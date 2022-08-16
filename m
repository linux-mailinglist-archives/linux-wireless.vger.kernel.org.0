Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D015952CC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 08:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiHPGna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 02:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiHPGnF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 02:43:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A17EBF2D72
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 18:33:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27G1WtaaE011763, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27G1WtaaE011763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 16 Aug 2022 09:32:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 09:33:07 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 16 Aug
 2022 09:33:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/3] wifi: rtw89: 8852c: initialize and correct BA CAM content
Date:   Tue, 16 Aug 2022 09:32:46 +0800
Message-ID: <20220816013247.6243-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816013247.6243-1-pkshih@realtek.com>
References: <20220816013247.6243-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/16/2022 01:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTUgpFWkyCAxMDo1MjowMA==?=
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

The bacam_v1 must do additional initialization, and H2C content of BA CAM
is also different. So, correct them accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  1 +
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 62 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  9 +++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +
 6 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 07aa722164203..2ec4cc11b29e1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2898,6 +2898,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
 	rtw89_fw_h2c_fw_log(rtwdev, rtwdev->fw.fw_log_enable);
+	rtw89_fw_h2c_init_ba_cam(rtwdev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 38228dbe2a7dd..d06cfb8025318 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2393,6 +2393,8 @@ struct rtw89_chip_info {
 	u8 bcam_num;
 	u8 scam_num;
 	u8 bacam_num;
+	u8 bacam_dynamic_num;
+	bool bacam_v1;
 
 	u8 sec_ctrl_efuse_size;
 	u32 physical_efuse_size;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4d39cf9185378..957c70ee9e135 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -638,6 +638,8 @@ EXPORT_SYMBOL(rtw89_fw_h2c_dctl_sec_cam_v1);
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
 	u8 macid = rtwsta->mac_id;
 	struct sk_buff *skb;
 	u8 entry_idx;
@@ -663,7 +665,10 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	}
 	skb_put(skb, H2C_BA_CAM_LEN);
 	SET_BA_CAM_MACID(skb->data, macid);
-	SET_BA_CAM_ENTRY_IDX(skb->data, entry_idx);
+	if (chip->bacam_v1)
+		SET_BA_CAM_ENTRY_IDX_V1(skb->data, entry_idx);
+	else
+		SET_BA_CAM_ENTRY_IDX(skb->data, entry_idx);
 	if (!valid)
 		goto end;
 	SET_BA_CAM_VALID(skb->data, valid);
@@ -676,6 +681,11 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	SET_BA_CAM_INIT_REQ(skb->data, 1);
 	SET_BA_CAM_SSN(skb->data, params->ssn);
 
+	if (chip->bacam_v1) {
+		SET_BA_CAM_STD_EN(skb->data, 1);
+		SET_BA_CAM_BAND(skb->data, rtwvif->mac_idx);
+	}
+
 end:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
@@ -695,6 +705,56 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	return -EBUSY;
 }
 
+static int rtw89_fw_h2c_init_dynamic_ba_cam_v1(struct rtw89_dev *rtwdev,
+					       u8 entry_idx, u8 uid)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_BA_CAM_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for dynamic h2c ba cam\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_BA_CAM_LEN);
+
+	SET_BA_CAM_VALID(skb->data, 1);
+	SET_BA_CAM_ENTRY_IDX_V1(skb->data, entry_idx);
+	SET_BA_CAM_UID(skb->data, uid);
+	SET_BA_CAM_BAND(skb->data, 0);
+	SET_BA_CAM_STD_EN(skb->data, 0);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_BA_CAM,
+			      H2C_FUNC_MAC_BA_CAM, 0, 1,
+			      H2C_BA_CAM_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+void rtw89_fw_h2c_init_ba_cam_v1(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u8 entry_idx = chip->bacam_num;
+	u8 uid = 0;
+	int i;
+
+	for (i = 0; i < chip->bacam_dynamic_num; i++) {
+		rtw89_fw_h2c_init_dynamic_ba_cam_v1(rtwdev, entry_idx, uid);
+		entry_idx++;
+		uid++;
+	}
+}
+
 #define H2C_LOG_CFG_LEN 12
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index e75ad22aa85df..a9508986b5623 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2623,6 +2623,7 @@ void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid);
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params);
+void rtw89_fw_h2c_init_ba_cam_v1(struct rtw89_dev *rtwdev);
 
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
@@ -2643,4 +2644,12 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev);
 
+static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->bacam_v1)
+		rtw89_fw_h2c_init_ba_cam_v1(rtwdev);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 4a1f7b5e83f6c..41ca679685e07 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2126,6 +2126,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.bcam_num		= 10,
 	.scam_num		= 128,
 	.bacam_num		= 2,
+	.bacam_dynamic_num	= 4,
+	.bacam_v1		= false,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 1536,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a74b4c550ec1a..f97349fa550fe 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2973,6 +2973,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.bcam_num		= 20,
 	.scam_num		= 128,
 	.bacam_num		= 8,
+	.bacam_dynamic_num	= 8,
+	.bacam_v1		= true,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
-- 
2.25.1

