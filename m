Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2D07664B7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjG1HEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjG1HEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:04:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15F5219AF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:04:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73ikgE031479, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73ikgE031479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 28 Jul 2023 15:03:33 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 08/10] wifi: rtw89: add C2H RA event V1 to support WiFi 7 chips
Date:   Fri, 28 Jul 2023 15:02:50 +0800
Message-ID: <20230728070252.66525-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728070252.66525-1-pkshih@realtek.com>
References: <20230728070252.66525-1-pkshih@realtek.com>
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

WiFi 7 chips have more rate mode (EHT), higher MCS and more bandwidth, so
define and use reserved bits to carry these information in C2H events.
Also, the SS/MCS encoded bits of VHT and HE are changed, so define V1 masks
for them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.h   | 14 +++++++--
 drivers/net/wireless/realtek/rtw89/phy.c  | 35 +++++++++++++++++++----
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43e02a28e4cd4..24c1097467885 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -587,6 +587,8 @@ enum rtw89_hw_rate {
 
 	RTW89_HW_RATE_MASK_MOD = GENMASK(8, 7),
 	RTW89_HW_RATE_MASK_VAL = GENMASK(6, 0),
+	RTW89_HW_RATE_V1_MASK_MOD = GENMASK(10, 8),
+	RTW89_HW_RATE_V1_MASK_VAL = GENMASK(7, 0),
 };
 
 /* 2G channels,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 586f9707a5ed7..49ecf070de712 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3168,16 +3168,24 @@ struct rtw89_c2h_ra_rpt {
 
 #define RTW89_C2H_RA_RPT_W2_MACID GENMASK(15, 0)
 #define RTW89_C2H_RA_RPT_W2_RETRY_RATIO GENMASK(23, 16)
+#define RTW89_C2H_RA_RPT_W2_MCSNSS_B7 BIT(31)
 #define RTW89_C2H_RA_RPT_W3_MCSNSS GENMASK(6, 0)
 #define RTW89_C2H_RA_RPT_W3_MD_SEL GENMASK(9, 8)
 #define RTW89_C2H_RA_RPT_W3_GILTF GENMASK(12, 10)
 #define RTW89_C2H_RA_RPT_W3_BW GENMASK(14, 13)
-
-/* VHT, HE, HT-old: [6:4]: NSS, [3:0]: MCS
- * HT-new: [6:5]: NA, [4:0]: MCS
+#define RTW89_C2H_RA_RPT_W3_MD_SEL_B2 BIT(15)
+#define RTW89_C2H_RA_RPT_W3_BW_B2 BIT(16)
+
+/* For WiFi 6 chips:
+ *   VHT, HE, HT-old: [6:4]: NSS, [3:0]: MCS
+ *   HT-new: [6:5]: NA, [4:0]: MCS
+ * For WiFi 7 chips (V1):
+ *   HT, VHT, HE, EHT: [7:5]: NSS, [4:0]: MCS
  */
 #define RTW89_RA_RATE_MASK_NSS GENMASK(6, 4)
 #define RTW89_RA_RATE_MASK_MCS GENMASK(3, 0)
+#define RTW89_RA_RATE_MASK_NSS_V1 GENMASK(7, 5)
+#define RTW89_RA_RATE_MASK_MCS_V1 GENMASK(4, 0)
 #define RTW89_RA_RATE_MASK_HT_MCS GENMASK(4, 0)
 #define RTW89_MK_HT_RATE(nss, mcs) (FIELD_PREP(GENMASK(4, 3), nss) | \
 				    FIELD_PREP(GENMASK(2, 0), mcs))
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 19a0c7ce0451c..1940f4457677c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2247,10 +2247,13 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	const struct rtw89_c2h_ra_rpt *c2h =
 		(const struct rtw89_c2h_ra_rpt *)ra_data->c2h->data;
 	struct rtw89_ra_report *ra_report = &rtwsta->ra_report;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool format_v1 = chip->chip_gen == RTW89_CHIP_BE;
 	u8 mode, rate, bw, giltf, mac_id;
 	u16 legacy_bitrate;
 	bool valid;
 	u8 mcs = 0;
+	u8 t;
 
 	mac_id = le32_get_bits(c2h->w2, RTW89_C2H_RA_RPT_W2_MACID);
 	if (mac_id != rtwsta->mac_id)
@@ -2261,6 +2264,15 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	giltf = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_GILTF);
 	mode = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_MD_SEL);
 
+	if (format_v1) {
+		t = le32_get_bits(c2h->w2, RTW89_C2H_RA_RPT_W2_MCSNSS_B7);
+		rate |= u8_encode_bits(t, BIT(7));
+		t = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_BW_B2);
+		bw |= u8_encode_bits(t, BIT(2));
+		t = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_MD_SEL_B2);
+		mode |= u8_encode_bits(t, BIT(2));
+	}
+
 	if (mode == RTW89_RA_RPT_MODE_LEGACY) {
 		valid = rtw89_ra_report_to_bitrate(rtwdev, rate, &legacy_bitrate);
 		if (!valid)
@@ -2287,16 +2299,24 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 		break;
 	case RTW89_RA_RPT_MODE_VHT:
 		ra_report->txrate.flags |= RATE_INFO_FLAGS_VHT_MCS;
-		ra_report->txrate.mcs = FIELD_GET(RTW89_RA_RATE_MASK_MCS, rate);
-		ra_report->txrate.nss = FIELD_GET(RTW89_RA_RATE_MASK_NSS, rate) + 1;
+		ra_report->txrate.mcs = format_v1 ?
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_MCS_V1) :
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_MCS);
+		ra_report->txrate.nss = format_v1 ?
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_NSS_V1) + 1 :
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_NSS) + 1;
 		if (giltf)
 			ra_report->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		mcs = ra_report->txrate.mcs;
 		break;
 	case RTW89_RA_RPT_MODE_HE:
 		ra_report->txrate.flags |= RATE_INFO_FLAGS_HE_MCS;
-		ra_report->txrate.mcs = FIELD_GET(RTW89_RA_RATE_MASK_MCS, rate);
-		ra_report->txrate.nss = FIELD_GET(RTW89_RA_RATE_MASK_NSS, rate) + 1;
+		ra_report->txrate.mcs = format_v1 ?
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_MCS_V1) :
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_MCS);
+		ra_report->txrate.nss  = format_v1 ?
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_NSS_V1) + 1 :
+			u8_get_bits(rate, RTW89_RA_RATE_MASK_NSS) + 1;
 		if (giltf == RTW89_GILTF_2XHE08 || giltf == RTW89_GILTF_1XHE08)
 			ra_report->txrate.he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 		else if (giltf == RTW89_GILTF_2XHE16 || giltf == RTW89_GILTF_1XHE16)
@@ -2309,8 +2329,11 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 
 	ra_report->txrate.bw = rtw89_hw_to_rate_info_bw(bw);
 	ra_report->bit_rate = cfg80211_calculate_bitrate(&ra_report->txrate);
-	ra_report->hw_rate = FIELD_PREP(RTW89_HW_RATE_MASK_MOD, mode) |
-			     FIELD_PREP(RTW89_HW_RATE_MASK_VAL, rate);
+	ra_report->hw_rate = format_v1 ?
+			     u16_encode_bits(mode, RTW89_HW_RATE_V1_MASK_MOD) |
+			     u16_encode_bits(rate, RTW89_HW_RATE_V1_MASK_VAL) :
+			     u16_encode_bits(mode, RTW89_HW_RATE_MASK_MOD) |
+			     u16_encode_bits(rate, RTW89_HW_RATE_MASK_VAL);
 	ra_report->might_fallback_legacy = mcs <= 2;
 	sta->deflink.agg.max_rc_amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
 	rtwsta->max_agg_wait = sta->deflink.agg.max_rc_amsdu_len / 1500 - 1;
-- 
2.25.1

