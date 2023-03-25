# Erste Phase: Builder
FROM maven:3.8.3-openjdk-11-slim as builder

# Kopiere die Quelldateien und die POM-Datei
COPY src /src
COPY pom.xml /

# Erstelle das Artefakt
RUN mvn -f pom.xml clean package -DskipTests

# Zweite Phase: JRE-Erstellung
FROM openjdk:11-slim as jre-builder

# JRE mit benötigten Modulen erstellen
RUN jlink --compress=2 \
          --no-header-files \
          --no-man-pages \
          --strip-debug \
          --add-modules java.base,java.logging,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
          --output /jre-min

# Dritte Phase: Runner
FROM debian:stable-slim

# Erstelle die Benutzergruppe und den Benutzer
RUN addgroup --system spring && adduser --system --ingroup spring spring

# Setze den Benutzer und die Benutzergruppe
USER spring:spring

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere die minimierte JRE
COPY --from=jre-builder /jre-min /jre-min

# Setze die Umgebungsvariable für die JRE
ENV PATH="/jre-min/bin:${PATH}"

# Kopiere das Artefakt aus der Builder-Phase in das Runner-Image
COPY --from=builder /target/*.jar app.jar

# Definiere den Einstiegspunkt
ENTRYPOINT ["java", "-jar", "app.jar"]
