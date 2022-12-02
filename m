Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC67640020
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 07:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiLBGGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 01:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiLBGGg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 01:06:36 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70967DC859
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 22:06:33 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B265dJ42001509, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B265dJ42001509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Dec 2022 14:05:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 2 Dec 2022 14:06:24 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Dec 2022
 14:06:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: request full firmware only once if it's early requested
Date:   Fri, 2 Dec 2022 14:05:21 +0800
Message-ID: <20221202060521.501512-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202060521.501512-1-pkshih@realtek.com>
References: <20221202060521.501512-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/02/2022 05:46:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIgpFekyCAwMToyMDowMA==?=
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

Under some condition, we now have to do early request full firmware when
rtw89_early_fw_feature_recognize(). In this case, we can avoid requesting
full firmware twice during probing driver. So, we pass out full firmware
from rtw89_early_fw_feature_recognize() if it's requested successfully.
And then, if firmware is settled, we have no need to request full firmware
again during normal initizating flow.

Setting firmware flow is updated to be as the following.

 platform	| early recognizing 	| normally initizating
-----------------------------------------------------------------------
 deny reading 	| request full FW	| (no more FW requesting)
 partial file 	|			| (obtain FW from early pahse)
-----------------------------------------------------------------------
 able to read	| request partial FW	| async request full FW
 partial file	| (quite small chunk)	|

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  6 ++++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 28 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h   |  7 +++---
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5ab95250755df..931aff8b5dc95 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3420,6 +3420,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 					   u32 bus_data_size,
 					   const struct rtw89_chip_info *chip)
 {
+	const struct firmware *firmware;
 	struct ieee80211_hw *hw;
 	struct rtw89_dev *rtwdev;
 	struct ieee80211_ops *ops;
@@ -3427,7 +3428,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	u32 early_feat_map = 0;
 	bool no_chanctx;
 
-	rtw89_early_fw_feature_recognize(device, chip, &early_feat_map);
+	firmware = rtw89_early_fw_feature_recognize(device, chip, &early_feat_map);
 
 	ops = kmemdup(&rtw89_ops, sizeof(rtw89_ops), GFP_KERNEL);
 	if (!ops)
@@ -3454,6 +3455,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	rtwdev->dev = device;
 	rtwdev->ops = ops;
 	rtwdev->chip = chip;
+	rtwdev->fw.firmware = firmware;
 
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "probe driver %s chanctx\n",
 		    no_chanctx ? "without" : "with");
@@ -3462,6 +3464,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 
 err:
 	kfree(ops);
+	release_firmware(firmware);
 	return NULL;
 }
 EXPORT_SYMBOL(rtw89_alloc_ieee80211_hw);
@@ -3469,6 +3472,7 @@ EXPORT_SYMBOL(rtw89_alloc_ieee80211_hw);
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev)
 {
 	kfree(rtwdev->ops);
+	release_firmware(rtwdev->fw.firmware);
 	ieee80211_free_hw(rtwdev->hw);
 }
 EXPORT_SYMBOL(rtw89_free_ieee80211_hw);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f5daea0d4f93c..de1f23779fc62 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -273,9 +273,10 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 	}
 }
 
-void rtw89_early_fw_feature_recognize(struct device *device,
-				      const struct rtw89_chip_info *chip,
-				      u32 *early_feat_map)
+const struct firmware *
+rtw89_early_fw_feature_recognize(struct device *device,
+				 const struct rtw89_chip_info *chip,
+				 u32 *early_feat_map)
 {
 	union rtw89_compat_fw_hdr buf = {};
 	const struct firmware *firmware;
@@ -300,7 +301,7 @@ void rtw89_early_fw_feature_recognize(struct device *device,
 
 	if (ret) {
 		dev_err(device, "failed to early request firmware: %d\n", ret);
-		return;
+		return NULL;
 	}
 
 	if (full_req)
@@ -322,7 +323,11 @@ void rtw89_early_fw_feature_recognize(struct device *device,
 	}
 
 out:
+	if (full_req)
+		return firmware;
+
 	release_firmware(firmware);
+	return NULL;
 }
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
@@ -629,6 +634,13 @@ int rtw89_load_firmware(struct rtw89_dev *rtwdev)
 	fw->rtwdev = rtwdev;
 	init_completion(&fw->completion);
 
+	if (fw->firmware) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "full firmware has been early requested\n");
+		complete_all(&fw->completion);
+		return 0;
+	}
+
 	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, rtwdev->dev,
 				      GFP_KERNEL, fw, rtw89_load_firmware_cb);
 	if (ret) {
@@ -645,8 +657,14 @@ void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
 
 	rtw89_wait_firmware_completion(rtwdev);
 
-	if (fw->firmware)
+	if (fw->firmware) {
 		release_firmware(fw->firmware);
+
+		/* assign NULL back in case rtw89_free_ieee80211_hw()
+		 * try to release the same one again.
+		 */
+		fw->firmware = NULL;
+	}
 }
 
 #define H2C_CAM_LEN 60
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5c4c7de1b4f5d..4d2f9ea9e0022 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3444,9 +3444,10 @@ struct rtw89_fw_h2c_rf_get_mccch {
 
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
-void rtw89_early_fw_feature_recognize(struct device *device,
-				      const struct rtw89_chip_info *chip,
-				      u32 *early_feat_map);
+const struct firmware *
+rtw89_early_fw_feature_recognize(struct device *device,
+				 const struct rtw89_chip_info *chip,
+				 u32 *early_feat_map);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
 int rtw89_load_firmware(struct rtw89_dev *rtwdev);
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
-- 
2.25.1

