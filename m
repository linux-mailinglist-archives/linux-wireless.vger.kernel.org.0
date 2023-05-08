Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDABC6FA287
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjEHIoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjEHIoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:44:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB76582
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:44:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488hlNU3007945, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488hlNU3007945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:43:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 May 2023 16:43:53 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:43:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: ser: L1 add pre-M0 and post-M0 states
Date:   Mon, 8 May 2023 16:43:34 +0800
Message-ID: <20230508084335.42953-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508084335.42953-1-pkshih@realtek.com>
References: <20230508084335.42953-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Newer FW re-design SER (syetem error recovery) L1 (level 1) flow.
New L1 flow will expect two extra states before original L1 flow.

* Before:
fw --- M1 --> driver
fw <-- M2 --- driver
fw --- M3 --> driver
fw <-- M4 --- driver
fw --- M5 --> driver

* After:
fw --- pre-M0  --> driver
fw <-- post-M0 --- driver
fw --- M1 --> driver
fw <-- M2 --- driver
fw --- M3 --> driver
fw <-- M4 --- driver
fw --- M5 --> driver

Then before M1, FW gets one more interval to deal with things that FW
should have handled well. To consider backward/forward compatibility,
FW and driver won't change flow from M1 to M5. (only except that halt
trigger control will change a little bit.) So, there will be two differnt
starting points of SER L1.
* old FW: SER L1 starts from M1
* new FW: SER L1 starts from pre-M0
Then, driver adds the new SER L1 entry and also keep the original one
instead of changing it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  |  6 ++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  2 ++
 drivers/net/wireless/realtek/rtw89/ser.c  | 43 ++++++++++++++++++++++-
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f697902706acc..b71827751848a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3945,6 +3945,7 @@ enum rtw89_ser_rcvy_step {
 struct rtw89_ser {
 	u8 state;
 	u8 alarm_event;
+	bool prehandle_l1;
 
 	struct work_struct ser_hdl_work;
 	struct delayed_work ser_alarm_work;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 64dc36470840c..e5996a94c0def 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -676,6 +676,7 @@ EXPORT_SYMBOL(rtw89_mac_get_err_status);
 
 int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err)
 {
+	struct rtw89_ser *ser = &rtwdev->ser;
 	u32 halt;
 	int ret = 0;
 
@@ -692,6 +693,11 @@ int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err)
 	}
 
 	rtw89_write32(rtwdev, R_AX_HALT_H2C, err);
+
+	if (ser->prehandle_l1 &&
+	    (err == MAC_AX_ERR_L1_DISABLE_EN || err == MAC_AX_ERR_L1_RCVY_EN))
+		return 0;
+
 	rtw89_write32(rtwdev, R_AX_HALT_H2C_CTRL, B_AX_HALT_H2C_TRIGGER);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index d3922d4fe288a..e340720bbb889 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -642,6 +642,7 @@ enum mac_ax_err_info {
 	MAC_AX_ERR_L0_PROMOTE_TO_L1 = 0x0010,
 
 	/* L1 */
+	MAC_AX_ERR_L1_PREERR_DMAC = 0x999,
 	MAC_AX_ERR_L1_ERR_DMAC = 0x1000,
 	MAC_AX_ERR_L1_RESET_DISABLE_DMAC_DONE = 0x1001,
 	MAC_AX_ERR_L1_RESET_RECOVERY_DONE = 0x1002,
@@ -780,6 +781,7 @@ enum mac_ax_err_info {
 	MAC_AX_ERR_L1_RCVY_EN = 0x0002,
 	MAC_AX_ERR_L1_RCVY_STOP_REQ = 0x0003,
 	MAC_AX_ERR_L1_RCVY_START_REQ = 0x0004,
+	MAC_AX_ERR_L1_RESET_START_DMAC = 0x000A,
 	MAC_AX_ERR_L0_CFG_NOTIFY = 0x0010,
 	MAC_AX_ERR_L0_CFG_DIS_NOTIFY = 0x0011,
 	MAC_AX_ERR_L0_CFG_HANDSHAKE = 0x0012,
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 9e9f6947e7f14..9ba99f3764e7e 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -20,12 +20,14 @@ enum ser_evt {
 	SER_EV_NONE,
 	SER_EV_STATE_IN,
 	SER_EV_STATE_OUT,
+	SER_EV_L1_RESET_PREPARE, /* pre-M0 */
 	SER_EV_L1_RESET, /* M1 */
 	SER_EV_DO_RECOVERY, /* M3 */
 	SER_EV_MAC_RESET_DONE, /* M5 */
 	SER_EV_L2_RESET,
 	SER_EV_L2_RECFG_DONE,
 	SER_EV_L2_RECFG_TIMEOUT,
+	SER_EV_M1_TIMEOUT,
 	SER_EV_M3_TIMEOUT,
 	SER_EV_FW_M5_TIMEOUT,
 	SER_EV_L0_RESET,
@@ -34,6 +36,7 @@ enum ser_evt {
 
 enum ser_state {
 	SER_IDLE_ST,
+	SER_L1_RESET_PRE_ST,
 	SER_RESET_TRX_ST,
 	SER_DO_HCI_ST,
 	SER_L2_RESET_ST,
@@ -374,6 +377,13 @@ static int hal_stop_dma(struct rtw89_ser *ser)
 	return ret;
 }
 
+static void hal_send_post_m0_event(struct rtw89_ser *ser)
+{
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
+	rtw89_mac_set_err_status(rtwdev, MAC_AX_ERR_L1_RESET_START_DMAC);
+}
+
 static void hal_send_m2_event(struct rtw89_ser *ser)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
@@ -398,6 +408,9 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 		rtw89_hci_recovery_complete(rtwdev);
 		clear_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
 		break;
+	case SER_EV_L1_RESET_PREPARE:
+		ser_state_goto(ser, SER_L1_RESET_PRE_ST);
+		break;
 	case SER_EV_L1_RESET:
 		ser_state_goto(ser, SER_RESET_TRX_ST);
 		break;
@@ -412,6 +425,28 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 	}
 }
 
+static void ser_l1_reset_pre_st_hdl(struct rtw89_ser *ser, u8 evt)
+{
+	switch (evt) {
+	case SER_EV_STATE_IN:
+		ser->prehandle_l1 = true;
+		hal_send_post_m0_event(ser);
+		ser_set_alarm(ser, 1000, SER_EV_M1_TIMEOUT);
+		break;
+	case SER_EV_L1_RESET:
+		ser_state_goto(ser, SER_RESET_TRX_ST);
+		break;
+	case SER_EV_M1_TIMEOUT:
+		ser_state_goto(ser, SER_L2_RESET_ST);
+		break;
+	case SER_EV_STATE_OUT:
+		ser_del_alarm(ser);
+		break;
+	default:
+		break;
+	}
+}
+
 static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
@@ -654,12 +689,14 @@ static const struct event_ent ser_ev_tbl[] = {
 	{SER_EV_NONE, "SER_EV_NONE"},
 	{SER_EV_STATE_IN, "SER_EV_STATE_IN"},
 	{SER_EV_STATE_OUT, "SER_EV_STATE_OUT"},
-	{SER_EV_L1_RESET, "SER_EV_L1_RESET"},
+	{SER_EV_L1_RESET_PREPARE, "SER_EV_L1_RESET_PREPARE pre-m0"},
+	{SER_EV_L1_RESET, "SER_EV_L1_RESET m1"},
 	{SER_EV_DO_RECOVERY, "SER_EV_DO_RECOVERY m3"},
 	{SER_EV_MAC_RESET_DONE, "SER_EV_MAC_RESET_DONE m5"},
 	{SER_EV_L2_RESET, "SER_EV_L2_RESET"},
 	{SER_EV_L2_RECFG_DONE, "SER_EV_L2_RECFG_DONE"},
 	{SER_EV_L2_RECFG_TIMEOUT, "SER_EV_L2_RECFG_TIMEOUT"},
+	{SER_EV_M1_TIMEOUT, "SER_EV_M1_TIMEOUT"},
 	{SER_EV_M3_TIMEOUT, "SER_EV_M3_TIMEOUT"},
 	{SER_EV_FW_M5_TIMEOUT, "SER_EV_FW_M5_TIMEOUT"},
 	{SER_EV_L0_RESET, "SER_EV_L0_RESET"},
@@ -668,6 +705,7 @@ static const struct event_ent ser_ev_tbl[] = {
 
 static const struct state_ent ser_st_tbl[] = {
 	{SER_IDLE_ST, "SER_IDLE_ST", ser_idle_st_hdl},
+	{SER_L1_RESET_PRE_ST, "SER_L1_RESET_PRE_ST", ser_l1_reset_pre_st_hdl},
 	{SER_RESET_TRX_ST, "SER_RESET_TRX_ST", ser_reset_trx_st_hdl},
 	{SER_DO_HCI_ST, "SER_DO_HCI_ST", ser_do_hci_st_hdl},
 	{SER_L2_RESET_ST, "SER_L2_RESET_ST", ser_l2_reset_st_hdl}
@@ -713,6 +751,9 @@ int rtw89_ser_notify(struct rtw89_dev *rtwdev, u32 err)
 	rtw89_info(rtwdev, "SER catches error: 0x%x\n", err);
 
 	switch (err) {
+	case MAC_AX_ERR_L1_PREERR_DMAC: /* pre-M0 */
+		event = SER_EV_L1_RESET_PREPARE;
+		break;
 	case MAC_AX_ERR_L1_ERR_DMAC:
 	case MAC_AX_ERR_L0_PROMOTE_TO_L1:
 		event = SER_EV_L1_RESET; /* M1 */
-- 
2.25.1

