docker exec -it mysql-server bash -c "su root -c 'mysql -uroot -proot -e \"source /setup-user.sql\"'"
docker exec -it mysql-server bash -c "su root -c 'mysql -uambari -pambari -e \"source /setup-db.sql\"'"
# docker exec -it mysql-server bash -c "su root -c 'rm -f setup-script.sql'"
