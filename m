Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA67BF0AB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 04:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441843AbjJJCKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441824AbjJJCKq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 22:10:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE129E
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 19:10:44 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39A2AWKF02015398, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39A2AWKF02015398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 10:10:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 10 Oct 2023 10:10:32 +0800
Received: from [127.0.1.1] (172.16.16.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 10 Oct
 2023 10:10:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/6] wifi: rtw89: Add EHT rate mask as parameters of RA H2C command
Date:   Tue, 10 Oct 2023 10:10:02 +0800
Message-ID: <20231010021006.6061-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010021006.6061-1-pkshih@realtek.com>
References: <20231010021006.6061-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

Set EHT rate mask to RA (rate adaptive) H2C command according to handshake
result. The EHT rate mask format looks like

  44               28               12        4    0
   +----------------+----------------+--------+----+
   |  EHT 2SS rate  |  EHT 1SS rate  |  OFDM  | CCK|
   +----------------+----------------+--------+----+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 58 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h  |  5 ++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5bf18110b379..f103ac085d2b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2734,6 +2734,7 @@ enum rtw89_ra_mode {
 	RTW89_RA_MODE_HT = BIT(2),
 	RTW89_RA_MODE_VHT = BIT(3),
 	RTW89_RA_MODE_HE = BIT(4),
+	RTW89_RA_MODE_EHT = BIT(5),
 };
 
 enum rtw89_ra_report_mode {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d04eaf7c5500..2a3edf775668 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -88,6 +88,55 @@ static u64 get_he_ra_mask(struct ieee80211_sta *sta)
 	return get_mcs_ra_mask(mcs_map, 11, 2);
 }
 
+static u64 get_eht_mcs_ra_mask(u8 *max_nss, u8 start_mcs, u8 n_nss)
+{
+	u64 nss_mcs_shift;
+	u64 nss_mcs_val;
+	u64 mask = 0;
+	int i, j;
+	u8 nss;
+
+	for (i = 0; i < n_nss; i++) {
+		nss = u8_get_bits(max_nss[i], IEEE80211_EHT_MCS_NSS_RX);
+		if (!nss)
+			continue;
+
+		nss_mcs_val = GENMASK_ULL(start_mcs + i * 2, 0);
+
+		for (j = 0, nss_mcs_shift = 12; j < nss; j++, nss_mcs_shift += 16)
+			mask |= nss_mcs_val << nss_mcs_shift;
+	}
+
+	return mask;
+}
+
+static u64 get_eht_ra_mask(struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_eht_cap *eht_cap = &sta->deflink.eht_cap;
+	struct ieee80211_eht_mcs_nss_supp_20mhz_only *mcs_nss_20mhz;
+	struct ieee80211_eht_mcs_nss_supp_bw *mcs_nss;
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_320:
+		mcs_nss = &eht_cap->eht_mcs_nss_supp.bw._320;
+		/* MCS 9, 11, 13 */
+		return get_eht_mcs_ra_mask(mcs_nss->rx_tx_max_nss, 9, 3);
+	case IEEE80211_STA_RX_BW_160:
+		mcs_nss = &eht_cap->eht_mcs_nss_supp.bw._160;
+		/* MCS 9, 11, 13 */
+		return get_eht_mcs_ra_mask(mcs_nss->rx_tx_max_nss, 9, 3);
+	case IEEE80211_STA_RX_BW_80:
+	default:
+		mcs_nss = &eht_cap->eht_mcs_nss_supp.bw._80;
+		/* MCS 9, 11, 13 */
+		return get_eht_mcs_ra_mask(mcs_nss->rx_tx_max_nss, 9, 3);
+	case IEEE80211_STA_RX_BW_20:
+		mcs_nss_20mhz = &eht_cap->eht_mcs_nss_supp.only_20mhz;
+		/* MCS 7, 9, 11, 13 */
+		return get_eht_mcs_ra_mask(mcs_nss_20mhz->rx_tx_max_nss, 7, 4);
+	}
+}
+
 #define RA_FLOOR_TABLE_SIZE	7
 #define RA_FLOOR_UP_GAP		3
 static u64 rtw89_phy_ra_mask_rssi(struct rtw89_dev *rtwdev, u8 rssi,
@@ -194,6 +243,9 @@ rtw89_ra_mask_vht_rates[4] = {RA_MASK_VHT_1SS_RATES, RA_MASK_VHT_2SS_RATES,
 static const u64
 rtw89_ra_mask_he_rates[4] = {RA_MASK_HE_1SS_RATES, RA_MASK_HE_2SS_RATES,
 			     RA_MASK_HE_3SS_RATES, RA_MASK_HE_4SS_RATES};
+static const u64
+rtw89_ra_mask_eht_rates[4] = {RA_MASK_EHT_1SS_RATES, RA_MASK_EHT_2SS_RATES,
+			      RA_MASK_EHT_3SS_RATES, RA_MASK_EHT_4SS_RATES};
 
 static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 				struct rtw89_sta *rtwsta,
@@ -255,7 +307,11 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 
 	memset(ra, 0, sizeof(*ra));
 	/* Set the ra mask from sta's capability */
-	if (sta->deflink.he_cap.has_he) {
+	if (sta->deflink.eht_cap.has_eht) {
+		mode |= RTW89_RA_MODE_EHT;
+		ra_mask |= get_eht_ra_mask(sta);
+		high_rate_masks = rtw89_ra_mask_eht_rates;
+	} else if (sta->deflink.he_cap.has_he) {
 		mode |= RTW89_RA_MODE_HE;
 		csi_mode = RTW89_RA_RPT_MODE_HE;
 		ra_mask |= get_he_ra_mask(sta);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 9473798b9dac..02521d984c9b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -46,6 +46,11 @@
 #define RA_MASK_HE_3SS_RATES	GENMASK_ULL(47, 36)
 #define RA_MASK_HE_4SS_RATES	GENMASK_ULL(59, 48)
 #define RA_MASK_HE_RATES	GENMASK_ULL(59, 12)
+#define RA_MASK_EHT_1SS_RATES	GENMASK_ULL(27, 12)
+#define RA_MASK_EHT_2SS_RATES	GENMASK_ULL(43, 28)
+#define RA_MASK_EHT_3SS_RATES	GENMASK_ULL(59, 44)
+#define RA_MASK_EHT_4SS_RATES	GENMASK_ULL(62, 60)
+#define RA_MASK_EHT_RATES	GENMASK_ULL(62, 12)
 
 #define CFO_TRK_ENABLE_TH (2 << 2)
 #define CFO_TRK_STOP_TH_4 (30 << 2)
-- 
2.25.1

