Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFA5677544
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 07:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAWGyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 01:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjAWGyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 01:54:47 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C190E19685
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 22:54:44 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30N6sYIN1012887, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30N6sYIN1012887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Jan 2023 14:54:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 23 Jan 2023 14:54:36 +0800
Received: from localhost (172.16.16.32) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 23 Jan
 2023 14:54:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8852b: try to use NORMAL_CE type firmware first
Date:   Mon, 23 Jan 2023 14:54:01 +0800
Message-ID: <20230123065401.14174-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123065401.14174-1-pkshih@realtek.com>
References: <20230123065401.14174-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.32]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/23/2023 06:33:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMjMgpFekyCAxMjozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New firmware type NORMAL_CE is introduced to support P2P-PS and hardware
scan, but no LPS-PG mode. After this patch, old firmware with NORMAL type
can still work well.

The use of this new type is the same as before, so we add new type to
avoid taking wrong firmware. Then, driver log can also give clear
information about this change:

  rtw89_8852be 0000:03:00.0: Firmware version 0.29.26.0, cmd version 0, type 5
  rtw89_8852be 0000:03:00.0: Firmware version 0.29.26.0, cmd version 0, type 3

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 22 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0d9cf4226544e..af0fe37646d7a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2847,6 +2847,7 @@ struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	const struct rtw89_chip_ops *ops;
 	const char *fw_name;
+	bool try_ce_fw;
 	u32 fifo_size;
 	u32 dle_scc_rsvd_size;
 	u16 max_amsdu_limit;
@@ -3013,6 +3014,7 @@ static inline void rtw89_init_wait(struct rtw89_wait_info *wait)
 enum rtw89_fw_type {
 	RTW89_FW_NORMAL = 1,
 	RTW89_FW_WOWLAN = 3,
+	RTW89_FW_NORMAL_CE = 5,
 };
 
 enum rtw89_fw_feature {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4da5eedbf8aac..0b73dc2e9ad77 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -152,7 +152,7 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 
 static
 int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
-			struct rtw89_fw_suit *fw_suit)
+			struct rtw89_fw_suit *fw_suit, bool nowarn)
 {
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const u8 *mfw = fw_info->firmware->data;
@@ -183,7 +183,8 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 		return 0;
 	}
 
-	rtw89_err(rtwdev, "no suitable firmware found\n");
+	if (!nowarn)
+		rtw89_err(rtwdev, "no suitable firmware found\n");
 	return -ENOENT;
 }
 
@@ -211,12 +212,13 @@ static void rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
 }
 
 static
-int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
+int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
+			 bool nowarn)
 {
 	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
 	int ret;
 
-	ret = rtw89_mfw_recognize(rtwdev, type, fw_suit);
+	ret = rtw89_mfw_recognize(rtwdev, type, fw_suit, nowarn);
 	if (ret)
 		return ret;
 
@@ -343,14 +345,22 @@ rtw89_early_fw_feature_recognize(struct device *device,
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	int ret;
 
-	ret = __rtw89_fw_recognize(rtwdev, RTW89_FW_NORMAL);
+	if (chip->try_ce_fw) {
+		ret = __rtw89_fw_recognize(rtwdev, RTW89_FW_NORMAL_CE, true);
+		if (!ret)
+			goto normal_done;
+	}
+
+	ret = __rtw89_fw_recognize(rtwdev, RTW89_FW_NORMAL, false);
 	if (ret)
 		return ret;
 
+normal_done:
 	/* It still works if wowlan firmware isn't existing. */
-	__rtw89_fw_recognize(rtwdev, RTW89_FW_WOWLAN);
+	__rtw89_fw_recognize(rtwdev, RTW89_FW_WOWLAN, false);
 
 	rtw89_fw_recognize_features(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 45119c512a051..9c42b6abd2232 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2055,6 +2055,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.chip_id		= RTL8852A,
 	.ops			= &rtw8852a_chip_ops,
 	.fw_name		= "rtw89/rtw8852a_fw.bin",
+	.try_ce_fw		= false,
 	.fifo_size		= 458752,
 	.dle_scc_rsvd_size	= 0,
 	.max_amsdu_limit	= 3500,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index c6345228d049f..1c25540f776d0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2430,6 +2430,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
 	.ops			= &rtw8852b_chip_ops,
 	.fw_name		= "rtw89/rtw8852b_fw.bin",
+	.try_ce_fw		= true,
 	.fifo_size		= 196608,
 	.dle_scc_rsvd_size	= 98304,
 	.max_amsdu_limit	= 3500,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 00fbb65355061..e6f5a0eb58964 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2857,6 +2857,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
 	.ops			= &rtw8852c_chip_ops,
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
+	.try_ce_fw		= false,
 	.fifo_size		= 458752,
 	.dle_scc_rsvd_size	= 0,
 	.max_amsdu_limit	= 8000,
-- 
2.25.1

