alias syfor="foreman run -e ../.env"
alias sytest="syfor pytest --reuse-db --driver=Chrome"
alias sydldb="heroku pg:backups:download -a serviceyear-staging -o ../staging-env/staging.dump"
alias sydlmedia="aws s3 sync s3://sy-staging/media ./media --quiet --profile sy"
alias sydb="dropdb serviceyear && createdb serviceyear && pg_restore -d serviceyear \"../staging-env/staging.dump\"; syfor python manage.py migrate --noinput && syfor python manage.py clearbuildcache && syfor python manage.py build_index && syfor python manage.py set_site localhost:8000"
