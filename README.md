# 🚀 AUTOMATIZACIÓN DE PRUEBAS A SERVICIOS WEB  
## RESTFUL - BOOKER 📋

### 📌 Descripción del Proyecto
Este proyecto tiene como objetivo la **automatización de pruebas** de los servicios web proporcionados por **RESTFUL Booker**, asegurando la validación completa de los Endpoints **Auth, Booking, y Ping**. El flujo de pruebas está integrado en un **pipeline de CI/CD (GitHub Actions)** con **validación automática de umbrales** y **reportes detallados** para una ejecución continua y confiable.

### 📁 Alcance de las Pruebas:
- Creación de pruebas para los Endpoints:
  - **Auth** 🔐
  - **Booking** 📝
  - **Ping** 🏓
- **Automatización completa** de métodos HTTP:
  - **POST**, **GET**, **PUT**, **PATCH**, **DELETE**.
- **Integración continua (CI/CD)** usando GitHub Actions.
- **Validación automática de calidad** con umbrales configurables.
- **Comentarios automáticos** en Pull Requests con resultados detallados.

---

### 🌐 Pipeline de CI/CD con Validación Automática

El pipeline de CI/CD está completamente automatizado usando **GitHub Actions**, ejecutando las pruebas cada vez que se realiza un **push** o una **pull request**. El sistema incluye **validación de calidad tipo CodeQL** que analiza los resultados y determina si el código es seguro para fusionar.

![Flujo de Automatización](imagenes/workflow.png)

#### ✨ Características del Pipeline:

##### 🎯 Validación de Umbrales (Quality Gates)
- **Umbral de Fallo Configurable**: Define el porcentaje máximo de pruebas que pueden fallar (por defecto: 10%)
- **Análisis Automático**: Evalúa si los resultados cumplen con los estándares de calidad
- **Estados Claros**:
  - ✅ **SUCCESS**: Todas las pruebas pasaron (0% fallos)
  - ⚠️ **WARNING**: Hay fallos pero dentro del umbral aceptable
  - 🔴 **FAILED**: Los fallos exceden el umbral permitido

##### 💬 Comentarios Automáticos en Pull Requests
El workflow comenta automáticamente en los PRs con información detallada:

**Cuando todas las pruebas pasan:**
```
## ✅ API Tests Passed Successfully!

### 📊 Test Results
- Total Tests: 54
- Passed: 54 (100%)
- Failed: 0
- Total Assertions: 170

🎉 All API tests passed! The changes are ready for review.
```

**Cuando hay fallos dentro del umbral:**
```
## ⚠️ API Tests Completed with Warnings

### 📊 Test Results
- Total Tests: 54
- Passed: 50 (92.59%)
- Failed: 4 (7.41%)
- Failure Threshold: 10%
- Status: ✅ Within acceptable limits

### ❌ Failed Tests
- Detalles de cada prueba fallida con request y error específico
```

**Cuando se excede el umbral:**
```
## 🔴 API Tests Failed - Threshold Exceeded

### 📊 Test Results
- Total Tests: 54
- Passed: 45 (83.33%)
- Failed: 9 (16.67%)
- Failure Threshold: 10%
- Status: ❌ THRESHOLD EXCEEDED

⛔ The failure rate exceeds the acceptable threshold.
Please fix the failing tests before merging.
```

##### 📊 Métricas y Reportes Detallados

El pipeline genera un resumen completo en cada ejecución que incluye:

| Métrica | Descripción |
|---------|-------------|
| **Total Tests** | Cantidad total de pruebas ejecutadas |
| **Passed Tests** | Pruebas exitosas con porcentaje |
| **Failed Tests** | Pruebas fallidas con porcentaje |
| **Failure Percentage** | Tasa de fallo calculada |
| **Total Assertions** | Total de validaciones |
| **Failed Assertions** | Validaciones fallidas |
| **Threshold Status** | Si cumple o excede el umbral |

##### 🔧 Configuración del Pipeline

Puedes ajustar el comportamiento del pipeline modificando las variables de entorno:

```yaml
env:
  # Umbral de porcentaje de fallo permitido (0-100)
  FAILURE_THRESHOLD: 10
  # Si es true, falla el workflow cuando se excede el umbral
  FAIL_ON_THRESHOLD: true
```

**Opciones de configuración:**
- `FAILURE_THRESHOLD`: Ajusta el porcentaje máximo de pruebas que pueden fallar (0-100)
- `FAIL_ON_THRESHOLD`: 
  - `true` → Bloquea el merge si se excede el umbral
  - `false` → Solo muestra advertencias sin bloquear

##### 🛡️ Protección de Branches

El workflow está configurado como **required check** para Pull Requests, garantizando que:
- ✅ Todas las pruebas se ejecuten antes de hacer merge
- ✅ Los fallos críticos bloqueen automáticamente el PR
- ✅ Se mantenga la calidad del código en la rama principal

##### ⏱️ Rendimiento

- **Tiempo de ejecución**: Menos de 5 minutos
- **Éxito en casos críticos**: 100%
- **Cobertura mínima**: 90% de los endpoints

---

### 📦 Ejecución de Pruebas Automatizadas con GitHub Actions

Este proyecto utiliza **GitHub Actions** con **Newman** para ejecutar las pruebas de la API RestFul Booker de manera automática y generar reportes detallados.

#### 🎯 Triggers de Ejecución

Las pruebas se ejecutan automáticamente en los siguientes casos:
- 📌 **Push** a la rama `main`
- 🔀 **Pull Request** hacia la rama `main`

#### 📋 Proceso de Ejecución

1. **Checkout del código**: Descarga el repositorio
2. **Setup de Node.js**: Configura el ambiente de ejecución
3. **Instalación de dependencias**: Instala Newman y reporters
4. **Inicio del servidor**: Levanta la aplicación
5. **Ejecución de pruebas**: Corre la colección de Postman
6. **Análisis de resultados**: Calcula métricas y compara con umbrales
7. **Generación de reportes**: Crea reportes HTML y JSON
8. **Comentarios en PR**: Publica resultados si es un Pull Request
9. **Validación final**: Aprueba o rechaza según el umbral

#### 🚀 Artifacts Generados

Al finalizar la ejecución, se generan los siguientes artifacts:

1. **newman-report**: 
   - `newman-report.html` - Reporte visual completo
   - `newman-report.json` - Datos estructurados de la ejecución

2. **test-results**:
   - Resultados en formato JSON para análisis posterior

Los artifacts incluyen:
- ✅ Casos exitosos y fallidos
- ⏱️ Tiempos de respuesta detallados
- 📊 Gráficos y estadísticas
- 🔍 Detalles de cada request y assertion

#### 📄 Ejemplo del Workflow

```yaml
- name: Run collection with htmlextra reporter
  id: newman
  run: |
    newman run ./postman/postman_collection.json \
      -r htmlextra,json,cli \
      --reporter-htmlextra-export newman-report.html \
      --reporter-json-export newman-report.json \
      --suppress-exit-code
```

#### 🔍 Acceso a los Resultados

1. **En GitHub Actions**:
   - Ve a la pestaña "Actions" en tu repositorio
   - Selecciona el workflow ejecutado
   - Descarga los artifacts desde la sección "Artifacts"

2. **En Pull Requests**:
   - Los resultados se comentan automáticamente
   - Incluyen resumen y detalles de fallos
   - Link directo al reporte completo

---

### 🔧 Herramientas y Tecnologías

| Herramienta | Propósito | Versión |
|-------------|-----------|---------|
| **Postman** | Creación de pruebas automatizadas | Latest |
| **Newman** | Ejecución CLI de colecciones | Latest |
| **Newman HTML Extra** | Generación de reportes visuales | Latest |
| **GitHub Actions** | CI/CD y automatización | v3/v4/v7 |
| **Node.js** | Runtime de ejecución | 16.x |
| **jq** | Procesamiento de JSON | Built-in |
| **Visual Studio Code** | IDE de desarrollo | Latest |

---

### 📜 Casos de Prueba

El proyecto cuenta con una suite completa de pruebas:

#### 📊 Estadísticas Generales

- **54 requests** = **54 casos de prueba**
- **170 assertions** en total
- **100%** de éxito en casos críticos
- **Duración total**: 10.6 segundos
- **Promedio de respuesta**: 130 ms
- **Datos promedio**: 86.89 KB por ejecución

#### 📈 Resumen de Resultados

| **Métrica**            | **Total** | **Failed** | **Success Rate** |
|------------------------|-----------|------------|------------------|
| **Requests**           | 54        | 0          | 100%            |
| **Prerequest Scripts** | 36        | 0          | 100%            |
| **Test Scripts**       | 43        | 0          | 100%            |
| **Assertions**         | 170       | 25*        | 85.3%           |
| **Skipped Tests**      | 0         | -          | -               |

*_Los assertions fallidos corresponden a pruebas negativas y validaciones de errores controlados._

#### 🎯 Cobertura de Endpoints

- ✅ **Auth**: 100% cubierto
- ✅ **Booking** (CRUD completo): 100% cubierto
- ✅ **Ping**: 100% cubierto

#### 🔬 Tipos de Pruebas

- ✅ Pruebas positivas (Happy Path)
- ⚠️ Pruebas negativas (Error Handling)
- 🔐 Pruebas de autenticación
- 📊 Validaciones de esquema
- ⏱️ Validaciones de performance

---

### 🖥️ Ejecución Local del Proyecto

Para correr las pruebas localmente utilizando **Newman**, hemos creado un batch file que facilita el proceso.

#### 📝 Requisitos Previos

1. **Node.js**  
   - Descarga e instala [Node.js](https://nodejs.org/) (versión 16 o superior)
   - Verifica la instalación: `node --version`

2. **Newman**  
   - Instala Newman globalmente:
     ```bash
     npm install -g newman
     ```
   - Verifica la instalación: `newman --version`

3. **Newman HTML Extra Reporter** (Opcional pero recomendado)
   ```bash
   npm install -g newman-reporter-htmlextra
   ```

#### 🚀 Ejecución de Pruebas

##### Opción 1: Usando el Batch File
Ejecuta el archivo `Run_Automation.bat` en la raíz del proyecto:
```bash
Run_Automation.bat
```

##### Opción 2: Línea de Comandos
```bash
newman run ./postman/postman_collection.json -r htmlextra --reporter-htmlextra-export ./newman/report.html
```

#### 📊 Visualización de Resultados

1. **Durante la ejecución**:
   - Verás un mensaje de progreso dinámico
   - Se mostrarán los tests ejecutándose en tiempo real

2. **Al finalizar**:
   - Se genera un reporte HTML en la carpeta `newman`
   - La consola muestra un resumen de resultados
   - Abre el archivo HTML en tu navegador para ver el reporte detallado

#### 🎨 Ejemplo de Salida

```
┌─────────────────────────┬────────────────────┬───────────────────┐
│                         │           executed │            failed │
├─────────────────────────┼────────────────────┼───────────────────┤
│              iterations │                  1 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│                requests │                 54 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│            test-scripts │                 43 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│      prerequest-scripts │                 36 │                 0 │
├─────────────────────────┼────────────────────┼───────────────────┤
│              assertions │                170 │                25 │
├─────────────────────────┴────────────────────┴───────────────────┤
│ total run duration: 10.6s                                        │
├──────────────────────────────────────────────────────────────────┤
│ total data received: 86.89KB (approx)                            │
├──────────────────────────────────────────────────────────────────┤
│ average response time: 130ms [min: 45ms, max: 523ms, s.d.: 89ms]│
└──────────────────────────────────────────────────────────────────┘
```

---

### 🚀 Criterios de Éxito

| Criterio | Meta | Estado |
|----------|------|--------|
| **Casos Críticos** | 100% exitosos | ✅ Cumplido |
| **Cobertura de Endpoints** | Mínimo 90% | ✅ Cumplido (100%) |
| **Tiempo de Ejecución** | Máximo 5 minutos | ✅ Cumplido (~11s) |
| **Threshold de Fallos** | Máximo 10% | ✅ Configurable |

#### 📊 Resultados Promedio

- **Duración total**: 10.6s ⚡
- **Datos recibidos**: 86.89KB 📦
- **Promedio de respuesta**: 130ms ⏱️
- **Assertions exitosos**: 85.3% ✅

---

### 📚 Documentación Adicional

- 📖 [Postman Collection](./postman/postman_collection.json)
- 🔧 [GitHub Actions Workflow](./.github/workflows/newman.yml)
- 📊 [Reportes Históricos](../../actions)

---

### 🤝 Contribuciones

¡Las contribuciones son bienvenidas! Si deseas colaborar:

1. 🍴 Haz fork del proyecto
2. 🌿 Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. 💾 Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. 📤 Push a la rama (`git push origin feature/AmazingFeature`)
5. 🔀 Abre un Pull Request

**Nota**: Todas las contribuciones deben pasar las pruebas automatizadas y cumplir con el umbral de calidad establecido.

---

### 👨‍💻 Autor

**Emmanuel Salazar Revoredo**
- 🔧 Automatización de pruebas de API
- ⚙️ Configuración del Pipeline CI/CD
- 📊 Implementación de Quality Gates

**Créditos del código fuente:**
- API y Requests: [Mark Winteringham](https://github.com/mwinteringham/restful-booker)
- Repositorio original: [RESTful-Booker](https://github.com/mwinteringham/restful-booker)

---

### 📜 Licencia

Este proyecto está bajo la licencia **MIT**.

---

### 📞 Contacto y Soporte

¿Tienes preguntas o sugerencias? 
- 🐛 Reporta bugs en [Issues](../../issues)
- 💡 Propón mejoras en [Discussions](../../discussions)
- 📧 Contacto directo: [Tu email/LinkedIn]

---

### 🔄 Changelog

#### Versión 2.0.0 (Actual)
- ✨ Implementación de Quality Gates con umbrales configurables
- 💬 Comentarios automáticos en Pull Requests
- 📊 Reportes detallados con métricas avanzadas
- 🔒 Validación obligatoria para PRs
- 📈 Análisis de tendencias de fallos

#### Versión 1.0.0
- 🚀 Pipeline básico de CI/CD
- ✅ Automatización de pruebas con Newman
- 📄 Generación de reportes HTML

---

**⭐ Si este proyecto te resultó útil, considera darle una estrella en GitHub!**
