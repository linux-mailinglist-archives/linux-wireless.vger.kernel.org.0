Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC24D7B63
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiCNHPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiCNHPE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:15:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6998711176
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:53 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7DlTqA003324, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7DlTqA003324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 14 Mar 2022 15:13:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 7/8] rtw89: reconstruct fw feature
Date:   Mon, 14 Mar 2022 15:12:49 +0800
Message-ID: <20220314071250.40292-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314071250.40292-1-pkshih@realtek.com>
References: <20220314071250.40292-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

As the fw features gradually increase, it would be better that
we have a set of methods to maintain fw features instead of using
scattered bool variables.

We reconstruct the way fw recognize features, and introduce
RTW89_CHK_FW_FEATURE() / RTW89_SET_FW_FEATURE() to check / set
fw features for uses.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  5 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 16 ++++--
 drivers/net/wireless/realtek/rtw89/fw.c       | 53 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  2 +-
 5 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bcefc968576e0..c61061358980b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -759,7 +759,7 @@ static void
 rtw89_core_tx_wake(struct rtw89_dev *rtwdev,
 		   struct rtw89_core_tx_request *tx_req)
 {
-	if (!rtwdev->fw.tx_wake)
+	if (!RTW89_CHK_FW_FEATURE(TX_WAKE, &rtwdev->fw))
 		return;
 
 	if (!test_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
@@ -1454,7 +1454,8 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
 	rx_status->band = hw->conf.chandef.chan->band;
 
-	if (rtwdev->scanning && rtwdev->fw.scan_offload) {
+	if (rtwdev->scanning &&
+	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
 		rx_status->freq =
 			ieee80211_channel_to_frequency(hal->current_channel,
 						       hal->current_band_type);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c95cd1a3ee9e0..93acc872f2beb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2386,6 +2386,12 @@ enum rtw89_fw_type {
 	RTW89_FW_WOWLAN = 3,
 };
 
+enum rtw89_fw_feature {
+	RTW89_FW_FEATURE_OLD_HT_RA_FORMAT,
+	RTW89_FW_FEATURE_SCAN_OFFLOAD,
+	RTW89_FW_FEATURE_TX_WAKE,
+};
+
 struct rtw89_fw_suit {
 	const u8 *data;
 	u32 size;
@@ -2415,11 +2421,15 @@ struct rtw89_fw_info {
 	struct rtw89_fw_suit normal;
 	struct rtw89_fw_suit wowlan;
 	bool fw_log_enable;
-	bool old_ht_ra_format;
-	bool scan_offload;
-	bool tx_wake;
+	u32 feature_map;
 };
 
+#define RTW89_CHK_FW_FEATURE(_feat, _fw) \
+	(!!((_fw)->feature_map & BIT(RTW89_FW_FEATURE_ ## _feat)))
+
+#define RTW89_SET_FW_FEATURE(_fw_feature, _fw) \
+	((_fw)->feature_map |= BIT(_fw_feature))
+
 struct rtw89_cam_info {
 	DECLARE_BITMAP(addr_cam_map, RTW89_MAX_ADDR_CAM_NUM);
 	DECLARE_BITMAP(bssid_cam_map, RTW89_MAX_BSSID_CAM_NUM);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2fe091cc12c0e..e4d94981cd32b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -193,22 +193,55 @@ int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	return 0;
 }
 
+#define __DEF_FW_FEAT_COND(__cond, __op) \
+static bool __fw_feat_cond_ ## __cond(u32 suit_ver_code, u32 comp_ver_code) \
+{ \
+	return suit_ver_code __op comp_ver_code; \
+}
+
+__DEF_FW_FEAT_COND(ge, >=); /* greater or equal */
+__DEF_FW_FEAT_COND(le, <=); /* less or equal */
+
+struct __fw_feat_cfg {
+	enum rtw89_core_chip_id chip_id;
+	enum rtw89_fw_feature feature;
+	u32 ver_code;
+	bool (*cond)(u32 suit_ver_code, u32 comp_ver_code);
+};
+
+#define __CFG_FW_FEAT(_chip, _cond, _maj, _min, _sub, _idx, _feat) \
+	{ \
+		.chip_id = _chip, \
+		.feature = RTW89_FW_FEATURE_ ## _feat, \
+		.ver_code = RTW89_FW_VER_CODE(_maj, _min, _sub, _idx), \
+		.cond = __fw_feat_cond_ ## _cond, \
+	}
+
+static const struct __fw_feat_cfg fw_feat_tbl[] = {
+	__CFG_FW_FEAT(RTL8852A, le, 0, 13, 29, 0, OLD_HT_RA_FORMAT),
+	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
+	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
+};
+
 static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, RTW89_FW_NORMAL);
+	const struct __fw_feat_cfg *ent;
+	const struct rtw89_fw_suit *fw_suit;
+	u32 suit_ver_code;
+	int i;
 
-	if (chip->chip_id == RTL8852A &&
-	    RTW89_FW_SUIT_VER_CODE(fw_suit) <= RTW89_FW_VER_CODE(0, 13, 29, 0))
-		rtwdev->fw.old_ht_ra_format = true;
+	fw_suit = rtw89_fw_suit_get(rtwdev, RTW89_FW_NORMAL);
+	suit_ver_code = RTW89_FW_SUIT_VER_CODE(fw_suit);
 
-	if (chip->chip_id == RTL8852A &&
-	    RTW89_FW_SUIT_VER_CODE(fw_suit) >= RTW89_FW_VER_CODE(0, 13, 35, 0))
-		rtwdev->fw.scan_offload = true;
+	for (i = 0; i < ARRAY_SIZE(fw_feat_tbl); i++) {
+		ent = &fw_feat_tbl[i];
+		if (chip->chip_id != ent->chip_id)
+			continue;
 
-	if (chip->chip_id == RTL8852A &&
-	    RTW89_FW_SUIT_VER_CODE(fw_suit) >= RTW89_FW_VER_CODE(0, 13, 35, 0))
-		rtwdev->fw.tx_wake = true;
+		if (ent->cond(suit_ver_code, ent->ver_code))
+			RTW89_SET_FW_FEATURE(ent->feature, &rtwdev->fw);
+	}
 }
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index fca9f82bb462f..8da3e117ad382 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -725,7 +725,7 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtw89_dev *rtwdev = hw->priv;
 	int ret = 0;
 
-	if (!rtwdev->fw.scan_offload)
+	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return 1;
 
 	if (rtwdev->scanning)
@@ -748,7 +748,7 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	if (!rtwdev->fw.scan_offload)
+	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return;
 
 	if (!rtwdev->scanning)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c6953a78658ae..24f9c11d15cce 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1558,7 +1558,7 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 		break;
 	case RTW89_RA_RPT_MODE_HT:
 		ra_report->txrate.flags |= RATE_INFO_FLAGS_MCS;
-		if (rtwdev->fw.old_ht_ra_format)
+		if (RTW89_CHK_FW_FEATURE(OLD_HT_RA_FORMAT, &rtwdev->fw))
 			rate = RTW89_MK_HT_RATE(FIELD_GET(RTW89_RA_RATE_MASK_NSS, rate),
 						FIELD_GET(RTW89_RA_RATE_MASK_MCS, rate));
 		else
-- 
2.25.1

