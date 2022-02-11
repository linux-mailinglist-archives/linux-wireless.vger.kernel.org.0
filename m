Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843F24B1FC5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 09:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347885AbiBKIAg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 03:00:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbiBKIAc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 03:00:32 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B7DBBF
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 00:00:31 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B80OAt8023923, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B80OAt8023923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 16:00:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 16:00:24 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 16:00:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 5/6] rtw89: declare if chip support 160M bandwidth
Date:   Fri, 11 Feb 2022 15:59:52 +0800
Message-ID: <20220211075953.40421-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211075953.40421-1-pkshih@realtek.com>
References: <20220211075953.40421-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/11/2022 07:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
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

The new chip can support 160M, so add a chip attribute to indicate the
chip support it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 19 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 116c5cb65fe46..bf5b7589906d8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2236,9 +2236,14 @@ static void rtw89_init_ht_cap(struct rtw89_dev *rtwdev,
 static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta_vht_cap *vht_cap)
 {
-	static const __le16 highest[RF_PATH_MAX] = {
+	static const __le16 highest_bw80[RF_PATH_MAX] = {
 		cpu_to_le16(433), cpu_to_le16(867), cpu_to_le16(1300), cpu_to_le16(1733),
 	};
+	static const __le16 highest_bw160[RF_PATH_MAX] = {
+		cpu_to_le16(867), cpu_to_le16(1733), cpu_to_le16(2600), cpu_to_le16(3467),
+	};
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const __le16 *highest = chip->support_bw160 ? highest_bw160 : highest_bw80;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u16 tx_mcs_map = 0, rx_mcs_map = 0;
 	u8 sts_cap = 3;
@@ -2267,6 +2272,9 @@ static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
 	vht_cap->cap |= IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
 			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE;
 	vht_cap->cap |= sts_cap << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
+	if (chip->support_bw160)
+		vht_cap->cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+				IEEE80211_VHT_CAP_SHORT_GI_160;
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(rx_mcs_map);
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(tx_mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest[hal->rx_nss - 1];
@@ -2339,6 +2347,8 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 			mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
 		phy_cap_info[0] = IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
 				  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+		if (chip->support_bw160)
+			phy_cap_info[0] |= IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 		phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
 				  IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
 				  IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
@@ -2367,6 +2377,9 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 		phy_cap_info[8] = IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
 				  IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI |
 				  IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_996;
+		if (chip->support_bw160)
+			phy_cap_info[8] |= IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+					   IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
 		phy_cap_info[9] = IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
 				  IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
 				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
@@ -2377,6 +2390,10 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 			phy_cap_info[9] |= IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
 		he_cap->he_mcs_nss_supp.rx_mcs_80 = cpu_to_le16(mcs_map);
 		he_cap->he_mcs_nss_supp.tx_mcs_80 = cpu_to_le16(mcs_map);
+		if (chip->support_bw160) {
+			he_cap->he_mcs_nss_supp.rx_mcs_160 = cpu_to_le16(mcs_map);
+			he_cap->he_mcs_nss_supp.tx_mcs_160 = cpu_to_le16(mcs_map);
+		}
 
 		idx++;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c5d40777558ec..0e55778b83ece 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2218,6 +2218,7 @@ struct rtw89_chip_info {
 	const struct rtw89_dle_mem *dle_mem;
 	u32 rf_base_addr[2];
 	u8 support_bands;
+	bool support_bw160;
 	u8 rf_path_num;
 	u8 tx_nss;
 	u8 rx_nss;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c39635a273994..a222e11de6acf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2024,6 +2024,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dig_table		= &rtw89_8852a_phy_dig_table,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
+	.support_bw160		= false,
 	.rf_path_num		= 2,
 	.tx_nss			= 2,
 	.rx_nss			= 2,
-- 
2.25.1

