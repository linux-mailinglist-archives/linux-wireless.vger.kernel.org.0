Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4D6C12B5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCTNH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 09:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCTNH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 09:07:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B71B561
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 06:07:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32KD74l44025612, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32KD74l44025612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 21:07:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 20 Mar 2023 21:07:17 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 21:07:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: fw: use generic flow to set/check features
Date:   Mon, 20 Mar 2023 21:06:04 +0800
Message-ID: <20230320130606.20777-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320130606.20777-1-pkshih@realtek.com>
References: <20230320130606.20777-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In early feature bitmap obtained from rtw89_early_fw_feature_recognize(),
the bits needed to check get increased. It's more friendly to work with
RTW89_CHK_FW_FEATURE(). So, we concentrate the flow of iterating FW feature
configures and calling RTW89_SET_FW_FEATURE() for various uses. And then,
we adjust rtw89_early_fw_feature_recognize() for RTW89_CHK_FW_FEATURE().

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  8 ++---
 drivers/net/wireless/realtek/rtw89/fw.c   | 41 +++++++++++------------
 drivers/net/wireless/realtek/rtw89/fw.h   |  2 +-
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bed1d9f045a4d..0c722c52c9fce 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3756,23 +3756,23 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 					   u32 bus_data_size,
 					   const struct rtw89_chip_info *chip)
 {
+	struct rtw89_fw_info early_fw = {};
 	const struct firmware *firmware;
 	struct ieee80211_hw *hw;
 	struct rtw89_dev *rtwdev;
 	struct ieee80211_ops *ops;
 	u32 driver_data_size;
-	u32 early_feat_map = 0;
 	bool no_chanctx;
 
-	firmware = rtw89_early_fw_feature_recognize(device, chip, &early_feat_map);
+	firmware = rtw89_early_fw_feature_recognize(device, chip, &early_fw);
 
 	ops = kmemdup(&rtw89_ops, sizeof(rtw89_ops), GFP_KERNEL);
 	if (!ops)
 		goto err;
 
 	no_chanctx = chip->support_chanctx_num == 0 ||
-		     !(early_feat_map & BIT(RTW89_FW_FEATURE_SCAN_OFFLOAD)) ||
-		     !(early_feat_map & BIT(RTW89_FW_FEATURE_BEACON_FILTER));
+		     !RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &early_fw) ||
+		     !RTW89_CHK_FW_FEATURE(BEACON_FILTER, &early_fw);
 
 	if (no_chanctx) {
 		ops->add_chanctx = NULL;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d3348f9bcc2a7..d9bd4339a59e5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -269,38 +269,45 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
 };
 
+static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
+					 const struct rtw89_chip_info *chip,
+					 u32 ver_code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fw_feat_tbl); i++) {
+		const struct __fw_feat_cfg *ent = &fw_feat_tbl[i];
+
+		if (chip->chip_id != ent->chip_id)
+			continue;
+
+		if (ent->cond(ver_code, ent->ver_code))
+			RTW89_SET_FW_FEATURE(ent->feature, fw);
+	}
+}
+
 static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct __fw_feat_cfg *ent;
 	const struct rtw89_fw_suit *fw_suit;
 	u32 suit_ver_code;
-	int i;
 
 	fw_suit = rtw89_fw_suit_get(rtwdev, RTW89_FW_NORMAL);
 	suit_ver_code = RTW89_FW_SUIT_VER_CODE(fw_suit);
 
-	for (i = 0; i < ARRAY_SIZE(fw_feat_tbl); i++) {
-		ent = &fw_feat_tbl[i];
-		if (chip->chip_id != ent->chip_id)
-			continue;
-
-		if (ent->cond(suit_ver_code, ent->ver_code))
-			RTW89_SET_FW_FEATURE(ent->feature, &rtwdev->fw);
-	}
+	rtw89_fw_iterate_feature_cfg(&rtwdev->fw, chip, suit_ver_code);
 }
 
 const struct firmware *
 rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
-				 u32 *early_feat_map)
+				 struct rtw89_fw_info *early_fw)
 {
 	union rtw89_compat_fw_hdr buf = {};
 	const struct firmware *firmware;
 	bool full_req = false;
 	u32 ver_code;
 	int ret;
-	int i;
 
 	/* If SECURITY_LOADPIN_ENFORCE is enabled, reading partial files will
 	 * be denied (-EPERM). Then, we don't get right firmware things as
@@ -329,15 +336,7 @@ rtw89_early_fw_feature_recognize(struct device *device,
 	if (!ver_code)
 		goto out;
 
-	for (i = 0; i < ARRAY_SIZE(fw_feat_tbl); i++) {
-		const struct __fw_feat_cfg *ent = &fw_feat_tbl[i];
-
-		if (chip->chip_id != ent->chip_id)
-			continue;
-
-		if (ent->cond(ver_code, ent->ver_code))
-			*early_feat_map |= BIT(ent->feature);
-	}
+	rtw89_fw_iterate_feature_cfg(early_fw, chip, ver_code);
 
 out:
 	if (full_req)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4d8d961f7b236..c5c7279ccc23a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3658,7 +3658,7 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
 const struct firmware *
 rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
-				 u32 *early_feat_map);
+				 struct rtw89_fw_info *early_fw);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
 int rtw89_load_firmware(struct rtw89_dev *rtwdev);
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
-- 
2.25.1

