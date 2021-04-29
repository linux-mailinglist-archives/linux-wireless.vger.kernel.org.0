Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5204A36E685
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhD2IE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 04:04:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43570 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbhD2IE5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 04:04:57 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13T847dY4025727, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13T847dY4025727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 16:04:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 16:04:06 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 29 Apr
 2021 16:04:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 17/19] rtw89: add ser to recover error reported by firmware
Date:   Thu, 29 Apr 2021 16:01:47 +0800
Message-ID: <20210429080149.7068-18-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210429080149.7068-1-pkshih@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXH36502.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwMjo0NTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:29:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163401 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:33:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwNzoyMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:51:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163403 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:54:00
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
 drivers/net/wireless/realtek/rtw89/ser.c | 435 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/ser.h |  14 +
 2 files changed, 449 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.h

diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
new file mode 100644
index 000000000000..58a55751c5a6
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "mac.h"
+#include "pci.h"
+#include "ser.h"
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
+static struct ser_msg *__rtw89_ser_dequeue_msg(struct rtw89_ser *ser)
+{
+	struct ser_msg *msg;
+
+	spin_lock_irq(&ser->msg_q_lock);
+	msg = list_first_entry_or_null(&ser->msg_q, struct ser_msg, list);
+	if (msg)
+		list_del(&msg->list);
+	spin_unlock_irq(&ser->msg_q_lock);
+
+	return msg;
+}
+
+static void rtw89_ser_hdl_work(struct work_struct *work)
+{
+	struct ser_msg *msg;
+	struct rtw89_ser *ser = container_of(work, struct rtw89_ser,
+					     ser_hdl_work);
+
+	while ((msg = __rtw89_ser_dequeue_msg(ser))) {
+		ser_state_run(ser, msg->event);
+		kfree(msg);
+	}
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
index 000000000000..fa501a36baf3
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/ser.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+ * Copyright(c) 2019-2020  Realtek Corporation
+ */
+#ifndef __SER_H__
+#define __SER_H__
+
+#include "core.h"
+
+int rtw89_ser_init(struct rtw89_dev *rtwdev);
+int rtw89_ser_deinit(struct rtw89_dev *rtwdev);
+int rtw89_ser_notify(struct rtw89_dev *rtwdev, u32 err);
+
+#endif /* __SER_H__*/
+
-- 
2.21.0

