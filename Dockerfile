# Etapa base (runtime)
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8080

# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copiar proyecto
COPY . .

# Restaurar y publicar
RUN dotnet restore DemoApi.csproj
RUN dotnet publish DemoApi.csproj -c Release -o /out

# Etapa final
FROM base AS final
WORKDIR /app

ENV TZ=America/Mexico_City
ENV ASPNETCORE_URLS=http://+:8080

COPY --from=build /out . 
ENTRYPOINT ["dotnet", "DemoApi.dll"]
