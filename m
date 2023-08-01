Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF476A6CF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjHACMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjHACMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13D491BE2
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712CCXA0018143, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712CCXA0018143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:12:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 1 Aug 2023 10:11:59 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:11:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] Wifi: rtw89: recognize log format from firmware file
Date:   Tue, 1 Aug 2023 10:11:20 +0800
Message-ID: <20230801021127.15919-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801021127.15919-1-pkshih@realtek.com>
References: <20230801021127.15919-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Firmware log format is an element of multi-firmware file
and used for firmware to provide log with formatted text.
Driver needs to recognize it in advance if it exists.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 25 +++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d2c67db97db1a..a3acc0bb18926 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3347,6 +3347,7 @@ enum rtw89_fw_type {
 	RTW89_FW_NORMAL = 1,
 	RTW89_FW_WOWLAN = 3,
 	RTW89_FW_NORMAL_CE = 5,
+	RTW89_FW_LOGFMT = 255,
 };
 
 enum rtw89_fw_feature {
@@ -3406,6 +3407,7 @@ struct rtw89_fw_info {
 	u8 c2h_counter;
 	struct rtw89_fw_suit normal;
 	struct rtw89_fw_suit wowlan;
+	struct rtw89_fw_suit logfmt;
 	bool fw_log_enable;
 	u32 feature_map;
 };
@@ -4942,6 +4944,8 @@ static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
 
 	if (type == RTW89_FW_WOWLAN)
 		return &fw_info->wowlan;
+	else if (type == RTW89_FW_LOGFMT)
+		return &fw_info->logfmt;
 	return &fw_info->normal;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9637f5e48d842..6260bebf305e5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -178,19 +178,22 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 
 	for (i = 0; i < mfw_hdr->fw_nr; i++) {
 		mfw_info = &mfw_hdr->info[i];
-		if (mfw_info->cv != rtwdev->hal.cv ||
-		    mfw_info->type != type ||
-		    mfw_info->mp)
-			continue;
-
-		fw_suit->data = mfw + le32_to_cpu(mfw_info->shift);
-		fw_suit->size = le32_to_cpu(mfw_info->size);
-		return 0;
+		if (mfw_info->type == type) {
+			if (mfw_info->cv == rtwdev->hal.cv && !mfw_info->mp)
+				goto found;
+			if (type == RTW89_FW_LOGFMT)
+				goto found;
+		}
 	}
 
 	if (!nowarn)
 		rtw89_err(rtwdev, "no suitable firmware found\n");
 	return -ENOENT;
+
+found:
+	fw_suit->data = mfw + le32_to_cpu(mfw_info->shift);
+	fw_suit->size = le32_to_cpu(mfw_info->size);
+	return 0;
 }
 
 static void rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
@@ -199,6 +202,9 @@ static void rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_fw_hdr *hdr = (const struct rtw89_fw_hdr *)fw_suit->data;
 
+	if (type == RTW89_FW_LOGFMT)
+		return;
+
 	fw_suit->major_ver = le32_get_bits(hdr->w1, FW_HDR_W1_MAJOR_VERSION);
 	fw_suit->minor_ver = le32_get_bits(hdr->w1, FW_HDR_W1_MINOR_VERSION);
 	fw_suit->sub_ver = le32_get_bits(hdr->w1, FW_HDR_W1_SUBVERSION);
@@ -386,6 +392,9 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 	/* It still works if wowlan firmware isn't existing. */
 	__rtw89_fw_recognize(rtwdev, RTW89_FW_WOWLAN, false);
 
+	/* It still works if log format file isn't existing. */
+	__rtw89_fw_recognize(rtwdev, RTW89_FW_LOGFMT, true);
+
 	rtw89_fw_recognize_features(rtwdev);
 
 	rtw89_coex_recognize_ver(rtwdev);
-- 
2.25.1

