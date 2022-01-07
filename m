Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6889848715A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbiAGDnO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:14 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51075 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbiAGDnN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:13 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073h8fS5022939, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073h8fS5022939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:43:08 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/19] rtw89: extend firmware commands on states of sta_assoc and sta_disconnect
Date:   Fri, 7 Jan 2022 11:42:27 +0800
Message-ID: <20220107034239.22002-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The h2c_join firmware command is used to indicate a station is connected,
and the assoc_cmac_tbl firmware command is used to set CMAC table
corresponding to a mac_id. Both commands must work in both station and AP
modes. Use the mac_id of rtw89_sta naturally and intuitively.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  4 +--
 drivers/net/wireless/realtek/rtw89/fw.c   | 35 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h   |  5 ++--
 drivers/net/wireless/realtek/rtw89/mac.c  |  2 +-
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3163c63091868..175d9924761c1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1925,7 +1925,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, 1);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, rtwsta, true);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
@@ -1957,7 +1957,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, 0);
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, rtwsta, false);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c join info\n");
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 441a8ef838570..e9f27382d2ba8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -733,12 +733,14 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 }
 
 #define H2C_CMC_TBL_LEN 68
-int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev, u8 macid)
+int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *rtwvif)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct sk_buff *skb;
 	u8 ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_B;
 	u8 map_b = hal->antenna_tx == RF_AB ? 1 : 0;
+	u8 macid = rtwvif->mac_id;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_CMC_TBL_LEN);
 	if (!skb) {
@@ -760,6 +762,8 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev, u8 macid)
 	SET_CMC_TBL_ANTSEL_D(skb->data, 0);
 	SET_CMC_TBL_DOPPLER_CTRL(skb->data, 0);
 	SET_CMC_TBL_TXPWR_TOLERENCE(skb->data, 0);
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+		SET_CMC_TBL_DATA_DCM(skb->data, 0);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
@@ -838,13 +842,15 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_sta *sta)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
 
 	memset(pads, 0, sizeof(pads));
-	__get_sta_he_pkt_padding(rtwdev, sta, pads);
+	if (sta)
+		__get_sta_he_pkt_padding(rtwdev, sta, pads);
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_CMC_TBL_LEN);
 	if (!skb) {
@@ -852,7 +858,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_CMC_TBL_LEN);
-	SET_CTRL_INFO_MACID(skb->data, rtwsta->mac_id);
+	SET_CTRL_INFO_MACID(skb->data, mac_id);
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
 	SET_CMC_TBL_DISRTSFB(skb->data, 1);
 	SET_CMC_TBL_DISDATAFB(skb->data, 1);
@@ -870,7 +876,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	SET_CMC_TBL_NOMINAL_PKT_PADDING(skb->data, pads[RTW89_CHANNEL_WIDTH_20]);
 	SET_CMC_TBL_NOMINAL_PKT_PADDING40(skb->data, pads[RTW89_CHANNEL_WIDTH_40]);
 	SET_CMC_TBL_NOMINAL_PKT_PADDING80(skb->data, pads[RTW89_CHANNEL_WIDTH_80]);
-	SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(skb->data, sta->he_cap.has_he);
+	if (sta)
+		SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(skb->data, sta->he_cap.has_he);
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+		SET_CMC_TBL_DATA_DCM(skb->data, 0);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
@@ -1018,9 +1027,17 @@ int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
 
 #define H2C_JOIN_INFO_LEN 4
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
-			   u8 dis_conn)
+			   struct rtw89_sta *rtwsta, bool dis_conn)
 {
 	struct sk_buff *skb;
+	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u8 self_role = rtwvif->self_role;
+	u8 net_type = rtwvif->net_type;
+
+	if (net_type == RTW89_NET_TYPE_AP_MODE && rtwsta) {
+		self_role = RTW89_SELF_ROLE_AP_CLIENT;
+		net_type = dis_conn ? RTW89_NET_TYPE_NO_LINK : net_type;
+	}
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_JOIN_INFO_LEN);
 	if (!skb) {
@@ -1028,7 +1045,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		return -ENOMEM;
 	}
 	skb_put(skb, H2C_JOIN_INFO_LEN);
-	SET_JOININFO_MACID(skb->data, rtwvif->mac_id);
+	SET_JOININFO_MACID(skb->data, mac_id);
 	SET_JOININFO_OP(skb->data, dis_conn);
 	SET_JOININFO_BAND(skb->data, rtwvif->mac_idx);
 	SET_JOININFO_WMM(skb->data, rtwvif->wmm);
@@ -1038,9 +1055,9 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	SET_JOININFO_TF_MAC_PAD(skb->data, 0);
 	SET_JOININFO_DL_T_PE(skb->data, 0);
 	SET_JOININFO_PORT_ID(skb->data, rtwvif->port);
-	SET_JOININFO_NET_TYPE(skb->data, rtwvif->net_type);
+	SET_JOININFO_NET_TYPE(skb->data, net_type);
 	SET_JOININFO_WIFI_ROLE(skb->data, rtwvif->wifi_role);
-	SET_JOININFO_SELF_ROLE(skb->data, rtwvif->self_role);
+	SET_JOININFO_SELF_ROLE(skb->data, self_role);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c6e83e4e49fa3..55f11e7886d52 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1871,7 +1871,8 @@ int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev);
 void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   u8 type, u8 cat, u8 class, u8 func,
 			   bool rack, bool dack, u32 len);
-int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev, u8 macid);
+int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
+				  struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta);
@@ -1887,7 +1888,7 @@ int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif *rtwvif,
 			      enum rtw89_upd_mode upd_mode);
 int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
-			   u8 dis_conn);
+			   struct rtw89_sta *rtwsta, bool dis_conn);
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			     bool pause);
 int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 59b6ef91afb0a..58f47b46c2f95 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2994,7 +2994,7 @@ int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	if (ret)
 		return ret;
 
-	ret = rtw89_fw_h2c_default_cmac_tbl(rtwdev, rtwvif->mac_id);
+	ret = rtw89_fw_h2c_default_cmac_tbl(rtwdev, rtwvif);
 	if (ret)
 		return ret;
 
-- 
2.25.1

