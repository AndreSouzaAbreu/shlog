# shlog

Minimalistic blog written in shell script.

It automates the conversion of markdown files to HTML files, as well as
indexing the pages in each directory.

## Features

- Deploy with Docker
- Automated generation of index files
- Live server with automatically reloading of changed pages
- CSS with dynamic file names to force browser loading of new CSS
- Rebuild of a HTML page when the corresponding markdown file changes

## Dependencies

### Required

- make
- grep
- pandoc
- sed
- shell (any POSIX shell)

### Optional

- docker
- docker-compose
- entr
- node
- npm
- php

## How it works

`shlog` uses `pandoc` to convert markdown to HTML. It uses `make` and
shell script to automate this process.

## How to use it

First, clone the repo and configure it by creating and customizing and `.env`
file.  A sample `.env` file is provided by [.env.sample](./.env.sample). You
can customize things such as website name, the path to the public folder,
the path to the source folder, among other things. See the `.env.sample`
to view a full list of variables.

### ENVIRONMENT VARIABLES

#### SRC_DIR

The src folder is where the markdown files will be located. It is there
where the writing is done. It defaults to `./src`.

#### PUBLIC_DIR

The public folder is where the generated HTML files will be placed. It
is also the entry for your public blog. It defaults to `./public`,

#### STORAGE_DIR

The storage folder is where you store files your blog will be using,
such as images, videos, PDFs, and so on. It default to `./public/storage`.

#### ASSETS_DIR

The [assets](./assets) folder contains the main CSS file as well as the
template used to generate the HTML files. You shouldn't change it, but you
can. It defaults to `./assets/`

#### CSS_FILE

The [path of the main CSS file](./assets/app.css). It defaults to
`./assets/app.css`.

#### TEMPLATE_FILE

The [path of the HTML template](./assets/template.html) used by `pandoc`.
It defaults to `./assets/template.html`.

#### WEBSITE_NAME

The name of the website to be placed in `index.html`.

#### TITLE_OF_LIST_OF_DIRS

The title to be placed before the list of the subdirectories in the current
`index.html` page.

#### TITLE_OF_LIST_OF_FILES

The title to be placed before the list of the files in the current `index.html`
page.

### Makefile rules

#### Generate the blog

Generate all HTML files for the blog.

```shell
make html
```

#### Generate indexes files only

Generate `index.md` files.

```
make indexes
```

#### Clean files

Remove generated HTML files.

```shell
make clean
```

#### Serve blog locally with PHP

Serve blog on `localhost:8080` with PHP.

```shell
make serve
```

**Dependencies**: `php`

#### Live server with browsersync

Browsersync automatically reload the blog when the current HTML page changes.
This is useful to see your blog while you make changes in real time. This
should be used together with the `watch` rule, otherwise it is useless.

```shell
make live
```

**Dependencies**: `node`, `npm`

#### Watch for changes

Whenever a markdown file in the `SRC_DIR` is changed, generate its
HTML file in the `PUBLIC_DIR`.

```shell
make watch
```

**Dependencies**: `entr`

#### Dynamic templates and CSS

The `CSS_FILE` is the main CSS for the blog. The shell scripts will copy
this file to the public folder and append its `md5` hash to the file name.
That way, it prevents browsers from loading old versions of the CSS file
due to cache. The template rule will change the template file, as well
as any HTML files, to match the correct CSS file.

```shell
make template
```

**Notice**: You don't need to run this rule because it is executed
automatically by the other rules.

## DEPLOY WITH DOCKER

You can deploy the blog with docker using [my static website
image](https://gitlab.com/andresouzaabreu/docker-static-website).

If you don't want to use my docker image, then you will have to find another
docker image or create one yourself.

## LICENSE

None. Do whatever you want with this software.
