Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD36C58D7A5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiHIKuv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbiHIKuj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F02F2BD0
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 03:50:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279AoLrwD018880, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279AoLrwD018880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 18:50:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 18:50:32 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 18:50:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 13/13] wifi: rtw89: early recognize FW feature to decide if chanctx
Date:   Tue, 9 Aug 2022 18:49:52 +0800
Message-ID: <20220809104952.61355-14-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809104952.61355-1-pkshih@realtek.com>
References: <20220809104952.61355-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2022 10:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA4OjU0OjAw?=
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

In current flow, FW is asynchronously loaded after alloc_hw(). It defers
the decision on FW feature map. It makes things difficult for us to decide
whether to hook chanctx ops, which should be decided while alloc_hw() is
calling. Still, asynchronous gets its advantages. So, we want to resolve
this without dropping them.

Based on multi-FW flag, RTW89_MFW_SIG, we can determine runtime FW is
multi-FW (MFW) or single FW (SFW). Both of them have a quite small chunk
for header at the head. The difference is that MFW doesn't describe version
code in its header while SFW does. So, we plan to extend MFW header for
version code. After that, in both cases, we can determine FW feature map by
just FW header. And, according to the map, we can decide chanctx.

So, we call request_partial_firmware_into_buf() to request a quite small
chunk before alloc_hw() to get a early FW feature map without affecting
things much and only use early map to decide whether to hook chanctx ops.

It means that if non-extended MFW is used at runtime, driver just acts
without chanctx as before. If extended MFW or SFW, which supports required
FW features, is used at runtime, driver can hook chanctx ops to mac80211 if
chip has configured support_chanctx_num > 0.

Besides, key point for now to support single one chanctx is whether HW scan
is supported at runtime. So, we configure all chip's support_chanctx_num to
1, and check if HW scan is supported at runtime via early FW feature map.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 12 +++++-
 drivers/net/wireless/realtek/rtw89/core.h     | 12 ++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 40 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 12 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +-
 6 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 90b18be4fd3a3..93d4d3166e6d2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3216,12 +3216,19 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	struct rtw89_dev *rtwdev;
 	struct ieee80211_ops *ops;
 	u32 driver_data_size;
+	u32 early_feat_map = 0;
+	bool no_chanctx;
+
+	rtw89_early_fw_feature_recognize(device, chip, &early_feat_map);
 
 	ops = kmemdup(&rtw89_ops, sizeof(rtw89_ops), GFP_KERNEL);
 	if (!ops)
 		goto err;
 
-	if (chip->support_chanctx_num == 0) {
+	no_chanctx = chip->support_chanctx_num == 0 ||
+		     !(early_feat_map & BIT(RTW89_FW_FEATURE_SCAN_OFFLOAD));
+
+	if (no_chanctx) {
 		ops->add_chanctx = NULL;
 		ops->remove_chanctx = NULL;
 		ops->change_chanctx = NULL;
@@ -3240,6 +3247,9 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	rtwdev->ops = ops;
 	rtwdev->chip = chip;
 
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "probe driver %s chanctx\n",
+		    no_chanctx ? "without" : "with");
+
 	return rtwdev;
 
 err:
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3c7b8d9dc1397..8a39377f1dbed 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2561,6 +2561,18 @@ struct rtw89_fw_suit {
 #define RTW89_FW_SUIT_VER_CODE(s)	\
 	RTW89_FW_VER_CODE((s)->major_ver, (s)->minor_ver, (s)->sub_ver, (s)->sub_idex)
 
+#define RTW89_MFW_HDR_VER_CODE(mfw_hdr)		\
+	RTW89_FW_VER_CODE((mfw_hdr)->ver.major,	\
+			  (mfw_hdr)->ver.minor,	\
+			  (mfw_hdr)->ver.sub,	\
+			  (mfw_hdr)->ver.idx)
+
+#define RTW89_FW_HDR_VER_CODE(fw_hdr)				\
+	RTW89_FW_VER_CODE(GET_FW_HDR_MAJOR_VERSION(fw_hdr),	\
+			  GET_FW_HDR_MINOR_VERSION(fw_hdr),	\
+			  GET_FW_HDR_SUBVERSION(fw_hdr),	\
+			  GET_FW_HDR_SUBINDEX(fw_hdr))
+
 struct rtw89_fw_info {
 	const struct firmware *firmware;
 	struct rtw89_dev *rtwdev;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index cee9815b6df6f..bf07275ca8a3f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -248,6 +248,46 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 	}
 }
 
+void rtw89_early_fw_feature_recognize(struct device *device,
+				      const struct rtw89_chip_info *chip,
+				      u32 *early_feat_map)
+{
+	union {
+		struct rtw89_mfw_hdr mfw_hdr;
+		u8 fw_hdr[RTW89_FW_HDR_SIZE];
+	} buf = {};
+	const struct firmware *firmware;
+	u32 ver_code;
+	int ret;
+	int i;
+
+	ret = request_partial_firmware_into_buf(&firmware, chip->fw_name,
+						device, &buf, sizeof(buf), 0);
+	if (ret) {
+		dev_err(device, "failed to early request firmware: %d\n", ret);
+		goto out;
+	}
+
+	ver_code = buf.mfw_hdr.sig != RTW89_MFW_SIG ?
+		   RTW89_FW_HDR_VER_CODE(&buf.fw_hdr) :
+		   RTW89_MFW_HDR_VER_CODE(&buf.mfw_hdr);
+	if (!ver_code)
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(fw_feat_tbl); i++) {
+		const struct __fw_feat_cfg *ent = &fw_feat_tbl[i];
+
+		if (chip->chip_id != ent->chip_id)
+			continue;
+
+		if (ent->cond(ver_code, ent->ver_code))
+			*early_feat_map |= BIT(ent->feature);
+	}
+
+out:
+	release_firmware(firmware);
+}
+
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index e75ad22aa85df..1e193928deec8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2446,7 +2446,14 @@ struct rtw89_mfw_info {
 struct rtw89_mfw_hdr {
 	u8 sig;	/* RTW89_MFW_SIG */
 	u8 fw_nr;
-	u8 rsvd[14];
+	u8 rsvd0[2];
+	struct {
+		u8 major;
+		u8 minor;
+		u8 sub;
+		u8 idx;
+	} ver;
+	u8 rsvd1[8];
 	struct rtw89_mfw_info info[];
 } __packed;
 
@@ -2563,6 +2570,9 @@ struct rtw89_fw_h2c_rf_get_mccch {
 
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
+void rtw89_early_fw_feature_recognize(struct device *device,
+				      const struct rtw89_chip_info *chip,
+				      u32 *early_feat_map);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
 int rtw89_load_firmware(struct rtw89_dev *rtwdev);
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 3516e480e622b..f6810fbb3fab1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2133,7 +2133,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
 	.tssi_dbw_table		= NULL,
-	.support_chanctx_num	= 0,
+	.support_chanctx_num	= 1,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 0218fa90526ca..01d1ad76534ac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2981,7 +2981,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
 	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
-	.support_chanctx_num	= 0,
+	.support_chanctx_num	= 1,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
-- 
2.25.1

