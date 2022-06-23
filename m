Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108D557208
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 06:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiFWEpc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 00:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243132AbiFWDro (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 23:47:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D738D89
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 20:47:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25N3lacJ7019269, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25N3lacJ7019269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 11:47:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 23 Jun 2022 11:47:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 23 Jun
 2022 11:47:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 13/13] rtw89: ensure chanctx ops are used with HW scan
Date:   Thu, 23 Jun 2022 11:46:35 +0800
Message-ID: <20220623034635.20964-14-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623034635.20964-1-pkshih@realtek.com>
References: <20220623034635.20964-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/23/2022 03:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjMgpFekyCAxMjo1MTowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We will configure chip::support_chanctx_num when the required FW for
HW scan has existed. And a module parameter, use_chanctx, is provided.
By default, it's `false` and chanctx ops are forced not to be used.

Condition (C) to decide whether to run with chanctx will be as follows.
	use_chanctx && chip::support_chanctx_num

NB: use_chanctx is only referenced when probing driver.

Besides, since mac80211 chanctx requires that driver supports HW scan,
we should ensure it at runtime. If (C) is met but an older FW which
doesn't support HW scan is used in system, we prohibit driver probe
and prompt the required FW version. Then, there will be two options to
choose, either upgrading FW or disabling use_chanctx.

If use_chanctx is set to `true` manually, cases are as follows.

 chip::support_chanctx_num  |  V  |  X  |  V  |  X
----------------------------------------------------
 runtime HW scan support    |  V  |  V  |  X  |  X
----------------------------------------------------
 behavior                   | <1> | <2> | <3> | <4>

<1>:
	Driver runs with chanctx.
<2>:
	Driver runs without chanctx.
	Upgrading driver should get into <1>.
<3>:
	Driver is prohibited to probe, but shows an error message
	to prompt the required FW version. So, one option is to
	upgrade FW to at least the required version. Another is
	to not enable use_chanctx.
<4>:
	It means chip has not been able to run with chanctx yet.
	Or, both FW and driver are too old to support it.
	Driver shows a warning once and runs without chanctx.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  7 ++-
 drivers/net/wireless/realtek/rtw89/core.h |  5 +++
 drivers/net/wireless/realtek/rtw89/fw.c   | 52 ++++++++++++++++++++---
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 60c8043749e28..7a8c4ec553d0d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -23,6 +23,11 @@ static bool rtw89_disable_ps_mode;
 module_param_named(disable_ps_mode, rtw89_disable_ps_mode, bool, 0644);
 MODULE_PARM_DESC(disable_ps_mode, "Set Y to disable low power mode");
 
+bool rtw89_use_chanctx;
+module_param_named(use_chanctx, rtw89_use_chanctx, bool, 0644);
+MODULE_PARM_DESC(use_chanctx,
+		 "Indicate whether to use channel context required for concurrency");
+
 #define RTW89_DEF_CHAN(_freq, _hw_val, _flags, _band)	\
 	{ .center_freq = _freq, .hw_value = _hw_val, .flags = _flags, .band = _band, }
 #define RTW89_DEF_CHAN_2G(_freq, _hw_val)	\
@@ -3220,7 +3225,7 @@ struct ieee80211_hw *rtw89_alloc_ieee80211_hw(u32 bus_data_size,
 	if (!ops)
 		goto err;
 
-	if (chip->support_chanctx_num == 0) {
+	if (!rtw89_use_chanctx || chip->support_chanctx_num == 0) {
 		ops->add_chanctx = NULL;
 		ops->remove_chanctx = NULL;
 		ops->change_chanctx = NULL;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 25292465a3718..47dee2b37620a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -16,6 +16,7 @@ struct rtw89_dev;
 struct rtw89_pci_info;
 
 extern const struct ieee80211_ops rtw89_ops;
+extern bool rtw89_use_chanctx;
 
 #define MASKBYTE0 0xff
 #define MASKBYTE1 0xff00
@@ -2560,6 +2561,10 @@ struct rtw89_fw_suit {
 	(((major) << 24) | ((minor) << 16) | ((sub) << 8) | (idx))
 #define RTW89_FW_SUIT_VER_CODE(s)	\
 	RTW89_FW_VER_CODE((s)->major_ver, (s)->minor_ver, (s)->sub_ver, (s)->sub_idex)
+#define RTW89_FW_VER_MAJOR(ver_code) FIELD_GET(GENMASK(31, 24), ver_code)
+#define RTW89_FW_VER_MINOR(ver_code) FIELD_GET(GENMASK(23, 16), ver_code)
+#define RTW89_FW_VER_SUB(ver_code) FIELD_GET(GENMASK(15, 8), ver_code)
+#define RTW89_FW_VER_IDX(ver_code) FIELD_GET(GENMASK(7, 0), ver_code)
 
 struct rtw89_fw_info {
 	const struct firmware *firmware;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index cee9815b6df6f..2867f395db4b3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -196,6 +196,29 @@ int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	return 0;
 }
 
+static
+int __fw_feat_err_check_non_hw_scan(struct rtw89_dev *rtwdev, u32 required_vercode)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (!rtw89_use_chanctx)
+		return 0;
+
+	if (chip->support_chanctx_num == 0) {
+		rtw89_warn(rtwdev,
+			   "Run without chanctx because chip hasn't claimed it.\n");
+		return 0;
+	}
+
+	rtw89_err(rtwdev,
+		  "Please upgrade FW to at least %lu.%lu.%lu.%lu or disable use_chanctx.\n",
+		  RTW89_FW_VER_MAJOR(required_vercode),
+		  RTW89_FW_VER_MINOR(required_vercode),
+		  RTW89_FW_VER_SUB(required_vercode),
+		  RTW89_FW_VER_IDX(required_vercode));
+	return -ENOENT;
+}
+
 #define __DEF_FW_FEAT_COND(__cond, __op) \
 static bool __fw_feat_cond_ ## __cond(u32 suit_ver_code, u32 comp_ver_code) \
 { \
@@ -210,29 +233,36 @@ struct __fw_feat_cfg {
 	enum rtw89_fw_feature feature;
 	u32 ver_code;
 	bool (*cond)(u32 suit_ver_code, u32 comp_ver_code);
+	int (*err_check)(struct rtw89_dev *rtwdev, u32 required_vercode);
 };
 
-#define __CFG_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _feat) \
+#define __CFG_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _feat, _argv...) \
 	{ \
 		.chip_id = _chip, \
 		.feature = RTW89_FW_FEATURE_ ## _feat, \
 		.ver_code = RTW89_FW_VER_CODE(_maj, _min, _sub, _idx), \
 		.cond = __fw_feat_cond_ ## _cond, \
+		##_argv,\
 	}
 
+#define __CFG_FW_FEAT_SCAN_OFFLOAD(_chip, _cond, _maj, _min, _sub, _idx) \
+	__CFG_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, SCAN_OFFLOAD, \
+		      .err_check = __fw_feat_err_check_non_hw_scan)
+
 static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852A, le, 0, 13, 29, 0, OLD_HT_RA_FORMAT),
-	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
+	__CFG_FW_FEAT_SCAN_OFFLOAD(RTL8852A, ge, 0, 13, 35, 0),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
 };
 
-static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
+static int rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct __fw_feat_cfg *ent;
 	const struct rtw89_fw_suit *fw_suit;
 	u32 suit_ver_code;
+	int ret;
 	int i;
 
 	fw_suit = rtw89_fw_suit_get(rtwdev, RTW89_FW_NORMAL);
@@ -243,9 +273,19 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 		if (chip->chip_id != ent->chip_id)
 			continue;
 
-		if (ent->cond(suit_ver_code, ent->ver_code))
+		if (ent->cond(suit_ver_code, ent->ver_code)) {
 			RTW89_SET_FW_FEATURE(ent->feature, &rtwdev->fw);
+			continue;
+		}
+
+		if (ent->err_check) {
+			ret = ent->err_check(rtwdev, ent->ver_code);
+			if (ret)
+				return ret;
+		}
 	}
+
+	return 0;
 }
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
@@ -259,7 +299,9 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 	/* It still works if wowlan firmware isn't existing. */
 	__rtw89_fw_recognize(rtwdev, RTW89_FW_WOWLAN);
 
-	rtw89_fw_recognize_features(rtwdev);
+	ret = rtw89_fw_recognize_features(rtwdev);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.25.1

