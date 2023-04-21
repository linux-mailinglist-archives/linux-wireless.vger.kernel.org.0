Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB50D6EA1C8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 04:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjDUCqO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 22:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjDUCqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0174C01
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 19:46:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L2k2wQ5016009, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L2k2wQ5016009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 10:46:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 21 Apr 2023 10:46:02 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 10:46:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: change naming of BA CAM from V1 to V0_EXT
Date:   Fri, 21 Apr 2023 10:45:49 +0800
Message-ID: <20230421024551.29994-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421024551.29994-1-pkshih@realtek.com>
References: <20230421024551.29994-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
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

BA CAM of 8852C has more entries and more fields of H2C, and needs
initialization before using. Due to differences from 8852A/8852B, we name
it as V1 before. However, real V1 of BA CAM is introduced now, so change
it to V0_EXT to avoid confusing with firmware design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  9 ++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 12 ++++++------
 drivers/net/wireless/realtek/rtw89/fw.h       |  6 +++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +-
 7 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0d7b056c77fbd..2000812de27e2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -122,6 +122,13 @@ enum rtw89_cv {
 	CHIP_CV_INVALID = CHIP_CV_MAX,
 };
 
+enum rtw89_bacam_ver {
+	RTW89_BACAM_V0,
+	RTW89_BACAM_V1,
+
+	RTW89_BACAM_V0_EXT = 99,
+};
+
 enum rtw89_core_tx_type {
 	RTW89_CORE_TX_TYPE_DATA,
 	RTW89_CORE_TX_TYPE_MGMT,
@@ -3152,7 +3159,7 @@ struct rtw89_chip_info {
 	u8 scam_num;
 	u8 bacam_num;
 	u8 bacam_dynamic_num;
-	bool bacam_v1;
+	enum rtw89_bacam_ver bacam_ver;
 
 	u8 sec_ctrl_efuse_size;
 	u32 physical_efuse_size;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b9b675bf9d050..aeac2c6116d14 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -807,7 +807,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	}
 	skb_put(skb, H2C_BA_CAM_LEN);
 	SET_BA_CAM_MACID(skb->data, macid);
-	if (chip->bacam_v1)
+	if (chip->bacam_ver == RTW89_BACAM_V0_EXT)
 		SET_BA_CAM_ENTRY_IDX_V1(skb->data, entry_idx);
 	else
 		SET_BA_CAM_ENTRY_IDX(skb->data, entry_idx);
@@ -823,7 +823,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	SET_BA_CAM_INIT_REQ(skb->data, 1);
 	SET_BA_CAM_SSN(skb->data, params->ssn);
 
-	if (chip->bacam_v1) {
+	if (chip->bacam_ver == RTW89_BACAM_V0_EXT) {
 		SET_BA_CAM_STD_EN(skb->data, 1);
 		SET_BA_CAM_BAND(skb->data, rtwvif->mac_idx);
 	}
@@ -848,8 +848,8 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 	return ret;
 }
 
-static int rtw89_fw_h2c_init_dynamic_ba_cam_v1(struct rtw89_dev *rtwdev,
-					       u8 entry_idx, u8 uid)
+static int rtw89_fw_h2c_init_ba_cam_v0_ext(struct rtw89_dev *rtwdev,
+					   u8 entry_idx, u8 uid)
 {
 	struct sk_buff *skb;
 	int ret;
@@ -886,7 +886,7 @@ static int rtw89_fw_h2c_init_dynamic_ba_cam_v1(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-void rtw89_fw_h2c_init_ba_cam_v1(struct rtw89_dev *rtwdev)
+void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 entry_idx = chip->bacam_num;
@@ -894,7 +894,7 @@ void rtw89_fw_h2c_init_ba_cam_v1(struct rtw89_dev *rtwdev)
 	int i;
 
 	for (i = 0; i < chip->bacam_dynamic_num; i++) {
-		rtw89_fw_h2c_init_dynamic_ba_cam_v1(rtwdev, entry_idx, uid);
+		rtw89_fw_h2c_init_ba_cam_v0_ext(rtwdev, entry_idx, uid);
 		entry_idx++;
 		uid++;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 675f85c41471b..3a25efc1f3762 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3648,7 +3648,7 @@ void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
 void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw);
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params);
-void rtw89_fw_h2c_init_ba_cam_v1(struct rtw89_dev *rtwdev);
+void rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(struct rtw89_dev *rtwdev);
 
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
@@ -3711,8 +3711,8 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->bacam_v1)
-		rtw89_fw_h2c_init_ba_cam_v1(rtwdev);
+	if (chip->bacam_ver == RTW89_BACAM_V0_EXT)
+		rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(rtwdev);
 }
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 2c3db08b68310..5ed699ab75a40 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -74,7 +74,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.scam_num		= 128,
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
-	.bacam_v1		= false,
+	.bacam_ver		= RTW89_BACAM_V0,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 58cb99003be94..a8a58ff36e95f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2115,7 +2115,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.scam_num		= 128,
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
-	.bacam_v1		= false,
+	.bacam_ver		= RTW89_BACAM_V0,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 1536,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 5a67f02557ee7..fa12d4a7f79f9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2546,7 +2546,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.scam_num		= 128,
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
-	.bacam_v1		= false,
+	.bacam_ver		= RTW89_BACAM_V0,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 35ba30f040c71..d9272bce03256 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2846,7 +2846,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.scam_num		= 128,
 	.bacam_num		= 8,
 	.bacam_dynamic_num	= 8,
-	.bacam_v1		= true,
+	.bacam_ver		= RTW89_BACAM_V0_EXT,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
-- 
2.25.1

