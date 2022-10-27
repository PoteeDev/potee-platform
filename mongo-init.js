
db = new Mongo().getDB("ad");

db.entities.insert([{
    created_at: ISODate("2022-08-02T13:31:08.047Z"),
    updated_at: ISODate("2022-08-02T13:31:08.047Z"),
    name: "naliway",
    login: "naliway",
    subnet: "10.0.1.0/24",
    ip: "10.0.1.10",
    hash: "$2a$10$11sq8vxrjIJcS4PkSupjQeseU1JJFXDUBFLi7ONPlHJox8wfSNGLC",
    visible: true,
    blocked: false
},
{
    created_at: ISODate("2022-08-02T13:31:08.047Z"),
    updated_at: ISODate("2022-08-02T13:31:08.047Z"),
    name: "nakateam",
    login: "nakateam",
    subnet: "10.0.2.0/24",
    ip: "10.0.2.10",
    hash: "$2a$10$tHlqGIrVoJbcV6sgVfQ9cuxI7bhPw39Lwu9lqCkr7btG8NIGJLBcC",
    visible: true,
    blocked: false
}])