# website

## Instalación

Para poder generar el website, tienes que tener instalado:

- [git](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Instalaci%c3%b3n-de-Git)
- [hugo](https://gohugo.io/installation/) - la versión en uso en este proyecto es 0.156.0

Clona el código fuente ejecutando `git clone https://github.com/aurorasteamgt/website.git`

## Ejecución

1. Abre una terminal y dirígete al directorio `website` donde está la copia de este proyecto.
2. Ejecuta `hugo serve`
3. Voilá 🎉 Puedes acceder a la página en http://localhost:1313/

## ¿Cómo contribuir?

1. Crea una branch para tu cambio, partiendo de `develop`. Recomendación: incorporar en el nombre `feat`, `fix` o `chore`.
```
$ git checkout develop
$ git checkout -b feat/contact-form
```

2. Haz commit de tus cambios usando el estilo de [mensajes convencionales](https://www.conventionalcommits.org/es/v1.0.0/).
```
$ git add *
$ git commit -m "feat: formulario de contacto"
```

3. Empuja tus cambios al repositorio.
```
$ git push
```

4. En Github, crea un Pull Request de tu branch hacia `develop`. Pon una descripcioń de lo que quieres incorporar y en el título también usa [mensajes convencionales](https://www.conventionalcommits.org/es/v1.0.0/).
5. Cuando esté verificado y aprobado, puedes hacer merge para incorporar los cambios al sitio de desarrollo.

## Proceso de release
1. Crear un Pull Request de `develop` a `main`.
2. Hacer merge del PR **con rebase** para que se incorporen todos los commits y sus mensajes a `main`.
3. Esto va a activar `release-please`, que abrirá un Pull Request con el CHANGELOG.md generado con los cambios.
4. Hacer merge del PR de `release-please`, con lo que se generará el tag de la nueva versión y se activará el deployment a producción.