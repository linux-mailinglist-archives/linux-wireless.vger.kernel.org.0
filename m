Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12E2E760F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 05:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgL3Eoc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 23:44:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44551 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgL3Eoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 23:44:32 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BU4hjWF3028287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BU4hjWF3028287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 12:43:45 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 30 Dec
 2020 12:43:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 17/18] rtw89: add ser to recover error reported by firmware
Date:   Wed, 30 Dec 2020 12:42:22 +0800
Message-ID: <20201230044223.14085-18-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201230044223.14085-1-pkshih@realtek.com>
References: <20201230044223.14085-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SER stands for System Error Recovery. When firmware detects error, it
interrupts driver. Driver read ser event code from register and do ser
processes as following:

1. driver stop TX
2. driver stop DMA
3. driver stop RX
4. reset TRX variable and counter
5. Inform FW driver reset is finish
   FW also resets itself when receiving driver's information
6. Wait FW to confirm reset finish
7. Enable DMA
8. driver resume rx
9. driver resume tx

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/ser.c | 430 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/ser.h |  12 +
 2 files changed, 442 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.h

diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
new file mode 100644
index 000000000000..a2224a031dc2
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+#include <linux/init.h>
+#include <linux/timer.h>
+#include "core.h"
+#include "mac.h"
+#include "pci.h"
+#include "ser.h"
+#include "debug.h"
+
+enum ser_evt {
+	SER_EV_NONE,
+	SER_EV_STATE_IN,
+	SER_EV_STATE_OUT,
+	SER_EV_L1_RESET, /* M1 */
+	SER_EV_DO_RECOVERY, /* M3 */
+	SER_EV_MAC_RESET_DONE, /* M5 */
+	SER_EV_L2_RESET,
+	SER_EV_M3_TIMEOUT,
+	SER_EV_FW_M5_TIMEOUT,
+	SER_EV_L0_RESET,
+	SER_EV_MAXX
+};
+
+enum ser_state {
+	SER_IDLE_ST,
+	SER_RESET_TRX_ST,
+	SER_DO_HCI_ST,
+	SER_L2_RESET_ST,
+	SER_ST_MAX_ST
+};
+
+struct ser_msg {
+	struct list_head list;
+	u8 event;
+};
+
+struct state_ent {
+	u8 state;
+	char *name;
+	void (*st_func)(struct rtw89_ser *ser, u8 event);
+};
+
+struct event_ent {
+	u8 event;
+	char *name;
+};
+
+static char *ser_ev_name(struct rtw89_ser *ser, u8 event)
+{
+	if (event < SER_EV_MAXX)
+		return ser->ev_tbl[event].name;
+
+	return "err_ev_name";
+}
+
+static char *ser_st_name(struct rtw89_ser *ser)
+{
+	if (ser->state < SER_ST_MAX_ST)
+		return ser->st_tbl[ser->state].name;
+
+	return "err_st_name";
+}
+
+static void ser_state_run(struct rtw89_ser *ser, u8 evt)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	rtw89_debug(rtwdev, RTW89_DBG_SER, "ser: %s receive %s\n",
+		    ser_st_name(ser), ser_ev_name(ser, evt));
+	ser->st_tbl[ser->state].st_func(ser, evt);
+}
+
+static void ser_state_goto(struct rtw89_ser *ser, u8 new_state)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	if (ser->state == new_state || new_state >= SER_ST_MAX_ST)
+		return;
+	ser_state_run(ser, SER_EV_STATE_OUT);
+
+	rtw89_debug(rtwdev, RTW89_DBG_SER, "ser: %s goto -> %s\n",
+		    ser_st_name(ser), ser->st_tbl[new_state].name);
+
+	ser->state = new_state;
+	ser_state_run(ser, SER_EV_STATE_IN);
+}
+
+static void rtw89_ser_hdl_work(struct work_struct *work)
+{
+	struct list_head *m, *t;
+	struct ser_msg *msg;
+	struct rtw89_ser *ser = container_of(work, struct rtw89_ser,
+					     ser_hdl_work);
+
+	spin_lock_irq(&ser->msg_q_lock);
+	list_for_each_safe(m, t, &ser->msg_q) {
+		list_del(m);
+		msg = list_entry(m, struct ser_msg, list);
+		ser_state_run(ser, msg->event);
+		kfree(msg);
+	}
+	spin_unlock_irq(&ser->msg_q_lock);
+}
+
+static int ser_send_msg(struct rtw89_ser *ser, u8 event)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	struct ser_msg *msg = NULL;
+
+	if (test_bit(RTW89_SER_DRV_STOP_RUN, ser->flags))
+		return -EIO;
+
+	msg = kmalloc(sizeof(*msg), GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->event = event;
+
+	spin_lock_irq(&ser->msg_q_lock);
+	list_add(&msg->list, &ser->msg_q);
+	spin_unlock_irq(&ser->msg_q_lock);
+
+	ieee80211_queue_work(rtwdev->hw, &ser->ser_hdl_work);
+	return 0;
+}
+
+static void rtw89_ser_alarm_work(struct work_struct *work)
+{
+	struct rtw89_ser *ser = container_of(work, struct rtw89_ser,
+					     ser_alarm_work.work);
+
+	ser_send_msg(ser, ser->alarm_event);
+	ser->alarm_event = SER_EV_NONE;
+}
+
+static void ser_set_alarm(struct rtw89_ser *ser, u32 ms, u8 event)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	if (test_bit(RTW89_SER_DRV_STOP_RUN, ser->flags))
+		return;
+
+	ser->alarm_event = event;
+	ieee80211_queue_delayed_work(rtwdev->hw, &ser->ser_alarm_work,
+				     msecs_to_jiffies(ms));
+}
+
+static void ser_del_alarm(struct rtw89_ser *ser)
+{
+	cancel_delayed_work(&ser->ser_alarm_work);
+	ser->alarm_event = SER_EV_NONE;
+}
+
+/* driver function */
+static void drv_stop_tx(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	ieee80211_stop_queues(rtwdev->hw);
+	set_bit(RTW89_SER_DRV_STOP_TX, ser->flags);
+}
+
+static void drv_stop_rx(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
+	set_bit(RTW89_SER_DRV_STOP_RX, ser->flags);
+}
+
+static void drv_trx_reset(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	rtw89_hci_reset(rtwdev);
+}
+
+static void drv_resume_tx(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	if (!test_bit(RTW89_SER_DRV_STOP_TX, ser->flags))
+		return;
+
+	ieee80211_wake_queues(rtwdev->hw);
+	clear_bit(RTW89_SER_DRV_STOP_TX, ser->flags);
+}
+
+static void drv_resume_rx(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	if (!test_bit(RTW89_SER_DRV_STOP_RX, ser->flags))
+		return;
+
+	set_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
+	clear_bit(RTW89_SER_DRV_STOP_RX, ser->flags);
+}
+
+/* hal function */
+static int hal_enable_dma(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	int ret;
+
+	if (!test_bit(RTW89_SER_HAL_STOP_DMA, ser->flags))
+		return 0;
+
+	if (!rtwdev->hci.ops->mac_lv1_rcvy)
+		return -EIO;
+
+	ret = rtwdev->hci.ops->mac_lv1_rcvy(rtwdev,
+					    MAC_AX_LV1_RCVY_STEP_2);
+	if (!ret)
+		clear_bit(RTW89_SER_HAL_STOP_DMA, ser->flags);
+
+	return ret;
+}
+
+static int hal_stop_dma(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	int ret;
+
+	if (!rtwdev->hci.ops->mac_lv1_rcvy)
+		return -EIO;
+
+	ret = rtwdev->hci.ops->mac_lv1_rcvy(rtwdev,
+					    MAC_AX_LV1_RCVY_STEP_1);
+	if (!ret)
+		set_bit(RTW89_SER_HAL_STOP_DMA, ser->flags);
+
+	return ret;
+}
+
+static void hal_send_m2_event(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_DISABLE_EN);
+}
+
+static void hal_send_m4_event(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RCVY_EN);
+}
+
+/* state handler */
+static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
+{
+	switch (evt) {
+	case SER_EV_STATE_IN:
+		break;
+	case SER_EV_L1_RESET:
+		ser_state_goto(ser, SER_RESET_TRX_ST);
+		break;
+	case SER_EV_L2_RESET:
+		ser_state_goto(ser, SER_L2_RESET_ST);
+		break;
+	case SER_EV_STATE_OUT:
+	default:
+		break;
+	}
+}
+
+static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
+{
+	switch (evt) {
+	case SER_EV_STATE_IN:
+		drv_stop_tx(ser);
+
+		if (hal_stop_dma(ser)) {
+			ser_state_goto(ser, SER_L2_RESET_ST);
+			break;
+		}
+
+		drv_stop_rx(ser);
+		drv_trx_reset(ser);
+
+		/* wait m3 */
+		hal_send_m2_event(ser);
+
+		/* set alarm to prevent FW response timeout */
+		ser_set_alarm(ser, 1000, SER_EV_M3_TIMEOUT);
+		break;
+
+	case SER_EV_DO_RECOVERY:
+		ser_state_goto(ser, SER_DO_HCI_ST);
+		break;
+
+	case SER_EV_M3_TIMEOUT:
+		ser_state_goto(ser, SER_L2_RESET_ST);
+		break;
+
+	case SER_EV_STATE_OUT:
+		ser_del_alarm(ser);
+		hal_enable_dma(ser);
+		drv_resume_rx(ser);
+		drv_resume_tx(ser);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void ser_do_hci_st_hdl(struct rtw89_ser *ser, u8 evt)
+{
+	switch (evt) {
+	case SER_EV_STATE_IN:
+		/* wait m5 */
+		hal_send_m4_event(ser);
+
+		/* prevent FW response timeout */
+		ser_set_alarm(ser, 1000, SER_EV_FW_M5_TIMEOUT);
+		break;
+
+	case SER_EV_FW_M5_TIMEOUT:
+	case SER_EV_MAC_RESET_DONE:
+		ser_state_goto(ser, SER_IDLE_ST);
+		break;
+
+	case SER_EV_STATE_OUT:
+		ser_del_alarm(ser);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
+{
+	switch (evt) {
+	case SER_EV_STATE_IN:
+		ser_state_goto(ser, SER_IDLE_ST);
+		break;
+
+	case SER_EV_STATE_OUT:
+	default:
+		break;
+	}
+}
+
+static struct event_ent ser_ev_tbl[] = {
+	{SER_EV_NONE, "SER_EV_NONE"},
+	{SER_EV_STATE_IN, "SER_EV_STATE_IN"},
+	{SER_EV_STATE_OUT, "SER_EV_STATE_OUT"},
+	{SER_EV_L1_RESET, "SER_EV_L1_RESET"},
+	{SER_EV_DO_RECOVERY, "SER_EV_DO_RECOVERY m3"},
+	{SER_EV_MAC_RESET_DONE, "SER_EV_MAC_RESET_DONE m5"},
+	{SER_EV_L2_RESET, "SER_EV_L2_RESET"},
+	{SER_EV_M3_TIMEOUT, "SER_EV_M3_TIMEOUT"},
+	{SER_EV_FW_M5_TIMEOUT, "SER_EV_FW_M5_TIMEOUT"},
+	{SER_EV_L0_RESET, "SER_EV_L0_RESET"},
+	{SER_EV_MAXX, "SER_EV_MAX"}
+};
+
+static struct state_ent ser_st_tbl[] = {
+	{SER_IDLE_ST, "SER_IDLE_ST", ser_idle_st_hdl},
+	{SER_RESET_TRX_ST, "SER_RESET_TRX_ST", ser_reset_trx_st_hdl},
+	{SER_DO_HCI_ST, "SER_DO_HCI_ST", ser_do_hci_st_hdl},
+	{SER_L2_RESET_ST, "SER_L2_RESET_ST", ser_l2_reset_st_hdl}
+};
+
+int rtw89_ser_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_ser *ser = &rtwdev->ser;
+
+	memset(ser, 0, sizeof(*ser));
+	INIT_LIST_HEAD(&ser->msg_q);
+	ser->state = SER_IDLE_ST;
+	ser->st_tbl = ser_st_tbl;
+	ser->ev_tbl = ser_ev_tbl;
+
+	bitmap_zero(ser->flags, RTW89_NUM_OF_SER_FLAGS);
+	spin_lock_init(&ser->msg_q_lock);
+	INIT_WORK(&ser->ser_hdl_work, rtw89_ser_hdl_work);
+	INIT_DELAYED_WORK(&ser->ser_alarm_work, rtw89_ser_alarm_work);
+	return 0;
+}
+
+int rtw89_ser_deinit(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_ser *ser = (struct rtw89_ser *)&rtwdev->ser;
+
+	set_bit(RTW89_SER_DRV_STOP_RUN, ser->flags);
+	cancel_delayed_work_sync(&ser->ser_alarm_work);
+	cancel_work_sync(&ser->ser_hdl_work);
+	clear_bit(RTW89_SER_DRV_STOP_RUN, ser->flags);
+	return 0;
+}
+
+int rtw89_ser_notify(struct rtw89_dev *rtwdev, u32 err)
+{
+	u8 event = SER_EV_NONE;
+
+	rtw89_info(rtwdev, "ser event = 0x%04x\n", err);
+
+	switch (err) {
+	case MAC_AX_ERR_L1_ERR_DMAC:
+	case MAC_AX_ERR_L0_PROMOTE_TO_L1:
+		event = SER_EV_L1_RESET; /* M1 */
+		break;
+	case MAC_AX_ERR_L1_RESET_DISABLE_DMAC_DONE:
+		event = SER_EV_DO_RECOVERY; /* M3 */
+		break;
+	case MAC_AX_ERR_L1_RESET_RECOVERY_DONE:
+		event = SER_EV_MAC_RESET_DONE; /* M5 */
+		break;
+	case MAC_AX_ERR_L0_ERR_CMAC0:
+	case MAC_AX_ERR_L0_ERR_CMAC1:
+	case MAC_AX_ERR_L0_RESET_DONE:
+		event = SER_EV_L0_RESET;
+		break;
+	default:
+		break;
+	}
+
+	if (event == SER_EV_NONE)
+		return -EINVAL;
+
+	ser_send_msg(&rtwdev->ser, event);
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_ser_notify);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.h b/drivers/net/wireless/realtek/rtw89/ser.h
new file mode 100644
index 000000000000..007e23d966f6
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/ser.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+ * Copyright(c) 2019-2020  Realtek Corporation
+ */
+#ifndef __SER_H__
+#define __SER_H__
+
+int rtw89_ser_init(struct rtw89_dev *rtwdev);
+int rtw89_ser_deinit(struct rtw89_dev *rtwdev);
+int rtw89_ser_notify(struct rtw89_dev *rtwdev, u32 err);
+
+#endif /* __SER_H__*/
+
-- 
2.21.0

