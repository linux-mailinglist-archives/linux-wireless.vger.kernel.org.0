Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27165B7FC3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiINDvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiINDv2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:51:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E26AC6F559
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:51:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28E3ootJ7007520, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28E3ootJ7007520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 14 Sep 2022 11:50:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:51:11 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 14 Sep
 2022 11:51:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: unify use of rtw89_h2c_tx()
Date:   Wed, 14 Sep 2022 11:50:31 +0800
Message-ID: <20220914035034.14521-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914035034.14521-1-pkshih@realtek.com>
References: <20220914035034.14521-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/14/2022 03:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTMgpFWkyCAxMToxMjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seaprate calling of rtw89_h2c_tx() out of if-expression, and bypass the
return value to upper caller.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 185 ++++++++++++++++--------
 1 file changed, 123 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f93d65c00f42f..7605c77022fdf 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -615,6 +615,7 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		     struct rtw89_sta *rtwsta, const u8 *scan_mac_addr)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CAM_LEN);
 	if (!skb) {
@@ -631,7 +632,8 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      H2C_FUNC_MAC_ADDR_CAM_UPD, 0, 1,
 			      H2C_CAM_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -640,7 +642,7 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_DCTL_SEC_CAM_LEN 68
@@ -649,6 +651,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_DCTL_SEC_CAM_LEN);
 	if (!skb) {
@@ -665,7 +668,8 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 			      H2C_FUNC_MAC_DCTLINFO_UD_V1, 0, 0,
 			      H2C_DCTL_SEC_CAM_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -674,7 +678,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v1);
 
@@ -737,7 +741,8 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			      H2C_FUNC_MAC_BA_CAM, 0, 1,
 			      H2C_BA_CAM_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -746,13 +751,14 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 static int rtw89_fw_h2c_init_dynamic_ba_cam_v1(struct rtw89_dev *rtwdev,
 					       u8 entry_idx, u8 uid)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_BA_CAM_LEN);
 	if (!skb) {
@@ -773,7 +779,8 @@ static int rtw89_fw_h2c_init_dynamic_ba_cam_v1(struct rtw89_dev *rtwdev,
 			      H2C_FUNC_MAC_BA_CAM, 0, 1,
 			      H2C_BA_CAM_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -782,7 +789,7 @@ static int rtw89_fw_h2c_init_dynamic_ba_cam_v1(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 void rtw89_fw_h2c_init_ba_cam_v1(struct rtw89_dev *rtwdev)
@@ -805,6 +812,7 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 	struct sk_buff *skb;
 	u32 comp = enable ? BIT(RTW89_FW_LOG_COMP_INIT) | BIT(RTW89_FW_LOG_COMP_TASK) |
 			    BIT(RTW89_FW_LOG_COMP_PS) | BIT(RTW89_FW_LOG_COMP_ERROR) : 0;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LOG_CFG_LEN);
 	if (!skb) {
@@ -824,7 +832,8 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 			      H2C_FUNC_LOG_CFG, 0, 0,
 			      H2C_LOG_CFG_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -833,7 +842,7 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_GENERAL_PKT_LEN 6
@@ -841,6 +850,7 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_GENERAL_PKT_LEN);
 	if (!skb) {
@@ -861,7 +871,8 @@ int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid)
 			      H2C_FUNC_MAC_GENERAL_PKT, 0, 1,
 			      H2C_GENERAL_PKT_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -870,7 +881,7 @@ int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_LPS_PARM_LEN 8
@@ -878,6 +889,7 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LPS_PARM_LEN);
 	if (!skb) {
@@ -903,7 +915,8 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			      H2C_FUNC_MAC_LPS_PARM, 0, 1,
 			      H2C_LPS_PARM_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -912,7 +925,7 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
@@ -936,6 +949,7 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
 	u8 macid = rtwvif->mac_id;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
 	if (!skb) {
@@ -963,7 +977,8 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 			      chip->h2c_cctl_func_id, 0, 1,
 			      H2C_CMC_TBL_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -972,7 +987,7 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
@@ -1043,6 +1058,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	int ret;
 
 	memset(pads, 0, sizeof(pads));
 	if (sta)
@@ -1091,7 +1107,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 			      chip->h2c_cctl_func_id, 0, 1,
 			      H2C_CMC_TBL_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1100,7 +1117,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
@@ -1108,6 +1125,7 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
 	if (!skb) {
@@ -1131,7 +1149,8 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 			      chip->h2c_cctl_func_id, 0, 1,
 			      H2C_CMC_TBL_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1140,7 +1159,7 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
@@ -1192,6 +1211,7 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb_beacon;
 	u16 tim_offset;
 	int bcn_total_len;
+	int ret;
 
 	skb_beacon = ieee80211_beacon_get_tim(rtwdev->hw, vif, &tim_offset,
 					      NULL, 0);
@@ -1227,10 +1247,11 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			      H2C_FUNC_MAC_BCN_UPD, 0, 1,
 			      bcn_total_len);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		dev_kfree_skb_any(skb);
-		return -EBUSY;
+		return ret;
 	}
 
 	return 0;
@@ -1245,6 +1266,7 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
 	u8 self_role;
+	int ret;
 
 	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE) {
 		if (rtwsta)
@@ -1271,7 +1293,8 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			      H2C_FUNC_MAC_FWROLE_MAINTAIN, 0, 1,
 			      H2C_ROLE_MAINTAIN_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1280,7 +1303,7 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_JOIN_INFO_LEN 4
@@ -1291,6 +1314,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
 	u8 self_role = rtwvif->self_role;
 	u8 net_type = rtwvif->net_type;
+	int ret;
 
 	if (net_type == RTW89_NET_TYPE_AP_MODE && rtwsta) {
 		self_role = RTW89_SELF_ROLE_AP_CLIENT;
@@ -1322,7 +1346,8 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      H2C_FUNC_MAC_JOININFO, 0, 1,
 			      H2C_JOIN_INFO_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1331,7 +1356,7 @@ int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
@@ -1340,6 +1365,7 @@ int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 	struct rtw89_fw_macid_pause_grp h2c = {{0}};
 	u8 len = sizeof(struct rtw89_fw_macid_pause_grp);
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_JOIN_INFO_LEN);
 	if (!skb) {
@@ -1356,7 +1382,8 @@ int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			      H2C_FUNC_MAC_MACID_PAUSE, 1, 0,
 			      len);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1365,7 +1392,7 @@ int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_EDCA_LEN 12
@@ -1373,6 +1400,7 @@ int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			  u8 ac, u32 val)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_EDCA_LEN);
 	if (!skb) {
@@ -1391,7 +1419,8 @@ int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      H2C_FUNC_USR_EDCA, 0, 1,
 			      H2C_EDCA_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1400,7 +1429,7 @@ int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_OFLD_CFG_LEN 8
@@ -1408,6 +1437,7 @@ int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
 {
 	static const u8 cfg[] = {0x09, 0x00, 0x00, 0x00, 0x5e, 0x00, 0x00, 0x00};
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_OFLD_CFG_LEN);
 	if (!skb) {
@@ -1421,7 +1451,8 @@ int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
 			      H2C_FUNC_OFLD_CFG, 0, 1,
 			      H2C_OFLD_CFG_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1430,7 +1461,7 @@ int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_RA_LEN 16
@@ -1438,6 +1469,7 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 {
 	struct sk_buff *skb;
 	u8 *cmd;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_RA_LEN);
 	if (!skb) {
@@ -1486,7 +1518,8 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 			      H2C_FUNC_OUTSRC_RA_MACIDCFG, 0, 0,
 			      H2C_RA_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1495,7 +1528,7 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_LEN_CXDRVHDR 2
@@ -1509,6 +1542,7 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_ant_info *ant = &module->ant;
 	struct sk_buff *skb;
 	u8 *cmd;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_INIT);
 	if (!skb) {
@@ -1545,7 +1579,8 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 			      SET_DRV_INFO, 0, 0,
 			      H2C_LEN_CXDRVINFO_INIT);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1554,7 +1589,7 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define PORT_DATA_OFFSET 4
@@ -1573,6 +1608,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 	struct sk_buff *skb;
 	u8 offset = 0;
 	u8 *cmd;
+	int ret;
 	int i;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_ROLE);
@@ -1623,7 +1659,8 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 			      SET_DRV_INFO, 0, 0,
 			      H2C_LEN_CXDRVINFO_ROLE);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1632,7 +1669,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
@@ -1644,6 +1681,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_active_role_v1 *active = role_info->active_role_v1;
 	struct sk_buff *skb;
 	u8 *cmd, offset;
+	int ret;
 	int i;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_ROLE_V1);
@@ -1704,7 +1742,8 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 			      SET_DRV_INFO, 0, 0,
 			      H2C_LEN_CXDRVINFO_ROLE_V1);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1713,7 +1752,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_LEN_CXDRVINFO_CTRL (4 + H2C_LEN_CXDRVHDR)
@@ -1723,6 +1762,7 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_ctrl *ctrl = &btc->ctrl;
 	struct sk_buff *skb;
 	u8 *cmd;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_CTRL);
 	if (!skb) {
@@ -1745,7 +1785,8 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 			      SET_DRV_INFO, 0, 0,
 			      H2C_LEN_CXDRVINFO_CTRL);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1754,7 +1795,7 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_LEN_CXDRVINFO_RFK (4 + H2C_LEN_CXDRVHDR)
@@ -1765,6 +1806,7 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_rfk_info *rfk_info = &wl->rfk_info;
 	struct sk_buff *skb;
 	u8 *cmd;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_RFK);
 	if (!skb) {
@@ -1788,7 +1830,8 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev)
 			      SET_DRV_INFO, 0, 0,
 			      H2C_LEN_CXDRVINFO_RFK);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1797,7 +1840,7 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_LEN_PKT_OFLD 4
@@ -1805,6 +1848,7 @@ int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id)
 {
 	struct sk_buff *skb;
 	u8 *cmd;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_PKT_OFLD);
 	if (!skb) {
@@ -1822,7 +1866,8 @@ int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id)
 			      H2C_FUNC_PACKET_OFLD, 1, 1,
 			      H2C_LEN_PKT_OFLD);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1831,7 +1876,7 @@ int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
@@ -1840,6 +1885,7 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 	struct sk_buff *skb;
 	u8 *cmd;
 	u8 alloc_id;
+	int ret;
 
 	alloc_id = rtw89_core_acquire_bit_map(rtwdev->pkt_offload,
 					      RTW89_MAX_PKT_OFLD_NUM);
@@ -1866,7 +1912,8 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 			      H2C_FUNC_PACKET_OFLD, 1, 1,
 			      H2C_LEN_PKT_OFLD + skb_ofld->len);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1875,7 +1922,7 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_LEN_SCAN_LIST_OFFLOAD 4
@@ -1886,6 +1933,7 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
 	struct sk_buff *skb;
 	int skb_len = H2C_LEN_SCAN_LIST_OFFLOAD + len * RTW89_MAC_CHINFO_SIZE;
 	u8 *cmd;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, skb_len);
 	if (!skb) {
@@ -1930,7 +1978,8 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
 			      H2C_FUNC_ADD_SCANOFLD_CH, 1, 1, skb_len);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1939,7 +1988,7 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 #define H2C_LEN_SCAN_OFFLOAD 28
@@ -1950,6 +1999,7 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct sk_buff *skb;
 	u8 *cmd;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_SCAN_OFFLOAD);
 	if (!skb) {
@@ -1982,7 +2032,8 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      H2C_FUNC_SCANOFLD, 1, 1,
 			      H2C_LEN_SCAN_OFFLOAD);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -1991,7 +2042,7 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
@@ -2001,6 +2052,7 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	u8 class = info->rf_path == RF_PATH_A ?
 		   H2C_CL_OUTSRC_RF_REG_A : H2C_CL_OUTSRC_RF_REG_B;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -2013,7 +2065,8 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			      H2C_CAT_OUTSRC, class, page, 0, 0,
 			      len);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -2022,7 +2075,7 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
@@ -2031,6 +2084,7 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
 	struct rtw89_fw_h2c_rf_get_mccch *mccch;
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, sizeof(*mccch));
 	if (!skb) {
@@ -2052,7 +2106,8 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 			      H2C_FUNC_OUTSRC_RF_GET_MCCCH, 0, 0,
 			      sizeof(*mccch));
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -2061,7 +2116,7 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_rf_ntfy_mcc);
 
@@ -2070,6 +2125,7 @@ int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      bool rack, bool dack)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -2082,7 +2138,8 @@ int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      H2C_CAT_OUTSRC, h2c_class, h2c_func, rack, dack,
 			      len);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -2091,12 +2148,13 @@ int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_no_hdr(rtwdev, len);
 	if (!skb) {
@@ -2105,7 +2163,8 @@ int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len)
 	}
 	skb_put_data(skb, buf, len);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -2114,7 +2173,7 @@ int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len)
 fail:
 	dev_kfree_skb_any(skb);
 
-	return -EBUSY;
+	return ret;
 }
 
 void rtw89_fw_send_all_early_h2c(struct rtw89_dev *rtwdev)
@@ -2643,6 +2702,7 @@ void rtw89_store_op_chan(struct rtw89_dev *rtwdev, bool backup)
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev)
 {
 	struct sk_buff *skb;
+	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_FW_CPU_EXCEPTION_LEN);
 	if (!skb) {
@@ -2661,7 +2721,8 @@ int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev)
 			      H2C_FUNC_CPU_EXCEPTION, 0, 0,
 			      H2C_FW_CPU_EXCEPTION_LEN);
 
-	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		goto fail;
 	}
@@ -2670,5 +2731,5 @@ int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev)
 
 fail:
 	dev_kfree_skb_any(skb);
-	return -EBUSY;
+	return ret;
 }
-- 
2.25.1

