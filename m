Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B25462ED13
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 06:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiKRFLw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 00:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiKRFLp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 00:11:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69C876C73F
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 21:11:44 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AI5AuJxA003110, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AI5AuJxA003110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Nov 2022 13:10:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 18 Nov 2022 13:11:38 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 18 Nov
 2022 13:11:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: mac: process MCC related C2H
Date:   Fri, 18 Nov 2022 13:10:40 +0800
Message-ID: <20221118051042.29968-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118051042.29968-1-pkshih@realtek.com>
References: <20221118051042.29968-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/18/2022 04:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRVpMggMTA6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Process C2H(s) related to MCC (multi-channel concurrency). These handling,
which either call rtw89_complete_cond() or show message in debug mode, can
be considered atomic/lock-free. So, they should be safe to be processed
directly after C2H pre-check in previous patch.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |   2 +
 drivers/net/wireless/realtek/rtw89/core.h |   5 +
 drivers/net/wireless/realtek/rtw89/fw.h   |  66 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 171 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  |  34 +++++
 5 files changed, 278 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e0b044a33207a..d7f80751eee3a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3097,6 +3097,8 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	mutex_init(&rtwdev->rf_mutex);
 	rtwdev->total_sta_assoc = 0;
 
+	rtw89_init_wait(&rtwdev->mcc.wait);
+
 	INIT_WORK(&rtwdev->c2h_work, rtw89_fw_c2h_work);
 	INIT_WORK(&rtwdev->ips_work, rtw89_ips_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5a7d5514bba9a..cbcbf09dbb273 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3542,6 +3542,10 @@ struct rtw89_wow_param {
 	struct list_head pkt_list;
 };
 
+struct rtw89_mcc_info {
+	struct rtw89_wait_info wait;
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -3552,6 +3556,7 @@ struct rtw89_dev {
 	const struct rtw89_chip_info *chip;
 	const struct rtw89_pci_info *pci_info;
 	struct rtw89_hal hal;
+	struct rtw89_mcc_info mcc;
 	struct rtw89_mac_info mac;
 	struct rtw89_fw_info fw;
 	struct rtw89_hci_info hci;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d76d0c80f0256..6d9c3dc58f037 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2859,6 +2859,53 @@ static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
 #define RTW89_GET_MAC_C2H_SCANOFLD_BAND(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(25, 24))
 
+#define RTW89_GET_MAC_C2H_MCC_RCV_ACK_GROUP(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(1, 0))
+#define RTW89_GET_MAC_C2H_MCC_RCV_ACK_H2C_FUNC(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+
+#define RTW89_GET_MAC_C2H_MCC_REQ_ACK_GROUP(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(1, 0))
+#define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_RETURN(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(7, 2))
+#define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+
+struct rtw89_mac_mcc_tsf_rpt {
+	u32 macid_x;
+	u32 macid_y;
+	u32 tsf_x_low;
+	u32 tsf_x_high;
+	u32 tsf_y_low;
+	u32 tsf_y_high;
+};
+
+#define RTW89_GET_MAC_C2H_MCC_TSF_RPT_MACID_X(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(7, 0))
+#define RTW89_GET_MAC_C2H_MCC_TSF_RPT_MACID_Y(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+#define RTW89_GET_MAC_C2H_MCC_TSF_RPT_GROUP(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(17, 16))
+#define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_LOW_X(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 1), GENMASK(31, 0))
+#define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_HIGH_X(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 0))
+#define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_LOW_Y(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(31, 0))
+#define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_HIGH_Y(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
+
+#define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_STATUS(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(5, 0))
+#define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_GROUP(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(7, 6))
+#define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_MACID(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+#define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_LOW(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 1), GENMASK(31, 0))
+#define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_HIGH(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 0))
+
 #define RTW89_FW_HDR_SIZE 32
 #define RTW89_FW_SECTION_HDR_SIZE 16
 
@@ -2980,6 +3027,25 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_CL_BA_CAM			0xc
 #define H2C_FUNC_MAC_BA_CAM		0x0
 
+/* CLASS 14 - MCC */
+#define H2C_CL_MCC			0xe
+enum rtw89_mcc_h2c_func {
+	H2C_FUNC_ADD_MCC		= 0x0,
+	H2C_FUNC_START_MCC		= 0x1,
+	H2C_FUNC_STOP_MCC		= 0x2,
+	H2C_FUNC_DEL_MCC_GROUP		= 0x3,
+	H2C_FUNC_RESET_MCC_GROUP	= 0x4,
+	H2C_FUNC_MCC_REQ_TSF		= 0x5,
+	H2C_FUNC_MCC_MACID_BITMAP	= 0x6,
+	H2C_FUNC_MCC_SYNC		= 0x7,
+	H2C_FUNC_MCC_SET_DURATION	= 0x8,
+
+	NUM_OF_RTW89_MCC_H2C_FUNC,
+};
+
+#define RTW89_MCC_WAIT_COND(group, func) \
+	((group) * NUM_OF_RTW89_MCC_H2C_FUNC + (func))
+
 #define H2C_CAT_OUTSRC			0x2
 
 #define H2C_CL_OUTSRC_RA		0x1
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index df83d1bebe543..6395c28f3d8ac 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4180,6 +4180,164 @@ rtw89_mac_c2h_tsf32_toggle_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 {
 }
 
+static void
+rtw89_mac_c2h_mcc_rcv_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	u8 group = RTW89_GET_MAC_C2H_MCC_RCV_ACK_GROUP(c2h->data);
+	u8 func = RTW89_GET_MAC_C2H_MCC_RCV_ACK_H2C_FUNC(c2h->data);
+
+	switch (func) {
+	case H2C_FUNC_ADD_MCC:
+	case H2C_FUNC_START_MCC:
+	case H2C_FUNC_STOP_MCC:
+	case H2C_FUNC_DEL_MCC_GROUP:
+	case H2C_FUNC_RESET_MCC_GROUP:
+	case H2C_FUNC_MCC_REQ_TSF:
+	case H2C_FUNC_MCC_MACID_BITMAP:
+	case H2C_FUNC_MCC_SYNC:
+	case H2C_FUNC_MCC_SET_DURATION:
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "invalid MCC C2H RCV ACK: func %d\n", func);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "MCC C2H RCV ACK: group %d, func %d\n", group, func);
+}
+
+static void
+rtw89_mac_c2h_mcc_req_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	u8 group = RTW89_GET_MAC_C2H_MCC_REQ_ACK_GROUP(c2h->data);
+	u8 func = RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h->data);
+	u8 retcode = RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_RETURN(c2h->data);
+	struct rtw89_completion_data data = {};
+	unsigned int cond;
+	bool next = false;
+
+	switch (func) {
+	case H2C_FUNC_MCC_REQ_TSF:
+		next = true;
+		break;
+	case H2C_FUNC_MCC_MACID_BITMAP:
+	case H2C_FUNC_MCC_SYNC:
+	case H2C_FUNC_MCC_SET_DURATION:
+		break;
+	case H2C_FUNC_ADD_MCC:
+	case H2C_FUNC_START_MCC:
+	case H2C_FUNC_STOP_MCC:
+	case H2C_FUNC_DEL_MCC_GROUP:
+	case H2C_FUNC_RESET_MCC_GROUP:
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "invalid MCC C2H REQ ACK: func %d\n", func);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "MCC C2H REQ ACK: group %d, func %d, return code %d\n",
+		    group, func, retcode);
+
+	if (!retcode && next)
+		return;
+
+	data.err = !!retcode;
+	cond = RTW89_MCC_WAIT_COND(group, func);
+	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
+}
+
+static void
+rtw89_mac_c2h_mcc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	u8 group = RTW89_GET_MAC_C2H_MCC_TSF_RPT_GROUP(c2h->data);
+	struct rtw89_completion_data data = {};
+	struct rtw89_mac_mcc_tsf_rpt *rpt;
+	unsigned int cond;
+
+	rpt = rtw89_completion_cast(&data, rpt);
+	rpt->macid_x = RTW89_GET_MAC_C2H_MCC_TSF_RPT_MACID_X(c2h->data);
+	rpt->macid_y = RTW89_GET_MAC_C2H_MCC_TSF_RPT_MACID_Y(c2h->data);
+	rpt->tsf_x_low = RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_LOW_X(c2h->data);
+	rpt->tsf_x_high = RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_HIGH_X(c2h->data);
+	rpt->tsf_y_low = RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_LOW_Y(c2h->data);
+	rpt->tsf_y_high = RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_HIGH_Y(c2h->data);
+
+	cond = RTW89_MCC_WAIT_COND(group, H2C_FUNC_MCC_REQ_TSF);
+	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
+}
+
+static void
+rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	u8 group = RTW89_GET_MAC_C2H_MCC_STATUS_RPT_GROUP(c2h->data);
+	u8 macid = RTW89_GET_MAC_C2H_MCC_STATUS_RPT_MACID(c2h->data);
+	u8 status = RTW89_GET_MAC_C2H_MCC_STATUS_RPT_STATUS(c2h->data);
+	u32 tsf_low = RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_LOW(c2h->data);
+	u32 tsf_high = RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_HIGH(c2h->data);
+	struct rtw89_completion_data data = {};
+	unsigned int cond;
+	bool rsp = true;
+	bool err;
+	u8 func;
+
+	switch (status) {
+	case RTW89_MAC_MCC_ADD_ROLE_OK:
+	case RTW89_MAC_MCC_ADD_ROLE_FAIL:
+		func = H2C_FUNC_ADD_MCC;
+		err = status == RTW89_MAC_MCC_ADD_ROLE_FAIL;
+		break;
+	case RTW89_MAC_MCC_START_GROUP_OK:
+	case RTW89_MAC_MCC_START_GROUP_FAIL:
+		func = H2C_FUNC_START_MCC;
+		err = status == RTW89_MAC_MCC_START_GROUP_FAIL;
+		break;
+	case RTW89_MAC_MCC_STOP_GROUP_OK:
+	case RTW89_MAC_MCC_STOP_GROUP_FAIL:
+		func = H2C_FUNC_STOP_MCC;
+		err = status == RTW89_MAC_MCC_STOP_GROUP_FAIL;
+		break;
+	case RTW89_MAC_MCC_DEL_GROUP_OK:
+	case RTW89_MAC_MCC_DEL_GROUP_FAIL:
+		func = H2C_FUNC_DEL_MCC_GROUP;
+		err = status == RTW89_MAC_MCC_DEL_GROUP_FAIL;
+		break;
+	case RTW89_MAC_MCC_RESET_GROUP_OK:
+	case RTW89_MAC_MCC_RESET_GROUP_FAIL:
+		func = H2C_FUNC_RESET_MCC_GROUP;
+		err = status == RTW89_MAC_MCC_RESET_GROUP_FAIL;
+		break;
+	case RTW89_MAC_MCC_SWITCH_CH_OK:
+	case RTW89_MAC_MCC_SWITCH_CH_FAIL:
+	case RTW89_MAC_MCC_TXNULL0_OK:
+	case RTW89_MAC_MCC_TXNULL0_FAIL:
+	case RTW89_MAC_MCC_TXNULL1_OK:
+	case RTW89_MAC_MCC_TXNULL1_FAIL:
+	case RTW89_MAC_MCC_SWITCH_EARLY:
+	case RTW89_MAC_MCC_TBTT:
+	case RTW89_MAC_MCC_DURATION_START:
+	case RTW89_MAC_MCC_DURATION_END:
+		rsp = false;
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "invalid MCC C2H STS RPT: status %d\n", status);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "MCC C2H STS RPT: group %d, macid %d, status %d, tsf {%d, %d}\n",
+		     group, macid, status, tsf_low, tsf_high);
+
+	if (!rsp)
+		return;
+
+	data.err = err;
+	cond = RTW89_MCC_WAIT_COND(group, func);
+	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
+}
+
 static
 void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 					    struct sk_buff *c2h, u32 len) = {
@@ -4201,6 +4359,15 @@ void (* const rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_BCN_CNT] = rtw89_mac_c2h_bcn_cnt,
 };
 
+static
+void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
+					   struct sk_buff *c2h, u32 len) = {
+	[RTW89_MAC_C2H_FUNC_MCC_RCV_ACK] = rtw89_mac_c2h_mcc_rcv_ack,
+	[RTW89_MAC_C2H_FUNC_MCC_REQ_ACK] = rtw89_mac_c2h_mcc_req_ack,
+	[RTW89_MAC_C2H_FUNC_MCC_TSF_RPT] = rtw89_mac_c2h_mcc_tsf_rpt,
+	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
+};
+
 bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
 {
 	switch (class) {
@@ -4226,6 +4393,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < RTW89_MAC_C2H_FUNC_OFLD_MAX)
 			handler = rtw89_mac_c2h_ofld_handler[func];
 		break;
+	case RTW89_MAC_C2H_CLASS_MCC:
+		if (func < NUM_OF_RTW89_MAC_C2H_FUNC_MCC)
+			handler = rtw89_mac_c2h_mcc_handler[func];
+		break;
 	case RTW89_MAC_C2H_CLASS_FWDBG:
 		return;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 82b9e81fe4744..adb0c86a98d3e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -368,6 +368,15 @@ enum rtw89_mac_c2h_info_func {
 	RTW89_MAC_C2H_FUNC_INFO_MAX,
 };
 
+enum rtw89_mac_c2h_mcc_func {
+	RTW89_MAC_C2H_FUNC_MCC_RCV_ACK = 0,
+	RTW89_MAC_C2H_FUNC_MCC_REQ_ACK = 1,
+	RTW89_MAC_C2H_FUNC_MCC_TSF_RPT = 2,
+	RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT = 3,
+
+	NUM_OF_RTW89_MAC_C2H_FUNC_MCC,
+};
+
 enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_INFO,
 	RTW89_MAC_C2H_CLASS_OFLD,
@@ -378,6 +387,31 @@ enum rtw89_mac_c2h_class {
 	RTW89_MAC_C2H_CLASS_MAX,
 };
 
+enum rtw89_mac_mcc_status {
+	RTW89_MAC_MCC_ADD_ROLE_OK = 0,
+	RTW89_MAC_MCC_START_GROUP_OK = 1,
+	RTW89_MAC_MCC_STOP_GROUP_OK = 2,
+	RTW89_MAC_MCC_DEL_GROUP_OK = 3,
+	RTW89_MAC_MCC_RESET_GROUP_OK = 4,
+	RTW89_MAC_MCC_SWITCH_CH_OK = 5,
+	RTW89_MAC_MCC_TXNULL0_OK = 6,
+	RTW89_MAC_MCC_TXNULL1_OK = 7,
+
+	RTW89_MAC_MCC_SWITCH_EARLY = 10,
+	RTW89_MAC_MCC_TBTT = 11,
+	RTW89_MAC_MCC_DURATION_START = 12,
+	RTW89_MAC_MCC_DURATION_END = 13,
+
+	RTW89_MAC_MCC_ADD_ROLE_FAIL = 20,
+	RTW89_MAC_MCC_START_GROUP_FAIL = 21,
+	RTW89_MAC_MCC_STOP_GROUP_FAIL = 22,
+	RTW89_MAC_MCC_DEL_GROUP_FAIL = 23,
+	RTW89_MAC_MCC_RESET_GROUP_FAIL = 24,
+	RTW89_MAC_MCC_SWITCH_CH_FAIL = 25,
+	RTW89_MAC_MCC_TXNULL0_FAIL = 26,
+	RTW89_MAC_MCC_TXNULL1_FAIL = 27,
+};
+
 struct rtw89_mac_ax_coex {
 #define RTW89_MAC_AX_COEX_RTK_MODE 0
 #define RTW89_MAC_AX_COEX_CSR_MODE 1
-- 
2.25.1

