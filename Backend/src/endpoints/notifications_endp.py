from fastapi import APIRouter
from src.models.notifications_model import Notifications, GetNotifications
from src.database.notifications_db import (
    get_notifications, 
    get_notifications_count,
    create_notification,
    get_notifications_for_user,
    mark_all_as_read_for_user, 
    mark_as_read, 
    mark_all_as_read,
    get_notifications_count_for_user,
    mark_as_read_for_user
    )

router = APIRouter(
    prefix="/notifications",
    tags=["Notifications"],
    responses={404: {"description": "Not found"}},
)

@router.get("/get_count")
def get_count(station_name: str):
    if station_name == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return get_notifications_count(station_name)

@router.get("/get_notifications")
def get_notications_endp(station_name: str):
    if station_name == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return get_notifications(station_name)

@router.post("/create_notification")
def create_notification_endp(notification: Notifications):
    if notification.station_name == "" or notification.title == "" or notification.description == "" or notification.type == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return create_notification(notification)

@router.delete("/mark_as_read")
def mark_as_read_endp(notification: GetNotifications):
    if notification.id == "" or notification.station_name == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return mark_as_read(notification)

@router.delete("/mark_all_as_read")
def mark_all_as_read_endp(notification: GetNotifications):
    if notification.station_name == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return mark_all_as_read(notification)

@router.get("/get_count_for_user")
def get_count_for_user(user_id: str):
    if user_id == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return get_notifications_count_for_user(user_id)

@router.get("/get_notifications_for_user")
def get_notifications_for_user_endp(user_id: str):
    if user_id == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return get_notifications_for_user(user_id)

@router.delete("/mark_as_read_for_user")
def mark_as_read_for_user_endp(notification: GetNotifications):
    if notification.id == "" or notification.user_id == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return mark_as_read_for_user(notification.user_id, notification.id)

@router.delete("/mark_all_as_read_for_user")
def mark_all_as_read_for_user_endp(notification: GetNotifications):
    if notification.user_id == "":
        return {"ERROR": "MISSING PARAMETERS"}
    return mark_all_as_read_for_user(notification.user_id)