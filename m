Return-Path: <linux-wireless+bounces-7927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E97C8CB8FE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 04:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C71282D52
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 02:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0042EB07;
	Wed, 22 May 2024 02:39:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D62322A
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345543; cv=none; b=YEgXubYZSwvBjbZV+bEXatfLOBYVObjUoOIrk2r/L6fWjnL21/p4MFUjI2YiO79oI1KxGwRCw8tSCkb9q2LMrOcMTAzdhz5KaY0kCSXRwAnGNyh9ecenVAIf8MT/nLkD1Be/ehJKw4RUer4k55AHjZV+z2WbtfbtfYK9ieyafJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345543; c=relaxed/simple;
	bh=WYaSShRMlPmkbEmNsymT+Fg/3CJya8nIlxPb/GNA+SI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTggvnBwTgk2HSdDu4tnjvD1IguXnLXry5qCm6Z1Gtp/pawG/ZSEg5UwOv2RhgZqtSF2k/6yPJzLr+UzH2XehTPduwnSKrMa2g3NF8OCuaWmVCj0qMgKppzAthDzVT+AQ8IyLFAmEiMKUSezInymSX/bqgs/8QMDHzaF1OKojJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44M2cwx573357146, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44M2cwx573357146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 10:38:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 10:38:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 May
 2024 10:38:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: add LDPC and STBC to rx_status and radiotap known fields for monitor mode
Date: Wed, 22 May 2024 10:38:30 +0800
Message-ID: <20240522023830.9798-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522023830.9798-1-pkshih@realtek.com>
References: <20240522023830.9798-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add LDPC and STBC to rx_status by hardware PPDU status, and set them as
known fields of radiotap, so we can check these capabilities in monitor
mode.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 36 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/txrx.h |  2 ++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 36d31608157f..3e99b63a7995 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1557,6 +1557,12 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 	u32 t;
 
 	phy_ppdu->chan_idx = le32_get_bits(ie->w0, RTW89_PHY_STS_IE01_W0_CH_IDX);
+
+	if (rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR) {
+		phy_ppdu->ldpc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_LDPC);
+		phy_ppdu->stbc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_STBC);
+	}
+
 	if (phy_ppdu->rate < RTW89_HW_RATE_OFDM6)
 		return;
 
@@ -1982,6 +1988,23 @@ static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
 	rx_status->rate_idx -= 4;
 }
 
+static
+void rtw89_core_update_rx_status_by_ppdu(struct rtw89_dev *rtwdev,
+					 struct ieee80211_rx_status *rx_status,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	if (!(rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR))
+		return;
+
+	if (!phy_ppdu)
+		return;
+
+	if (phy_ppdu->ldpc)
+		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
+	if (phy_ppdu->stbc)
+		rx_status->enc_flags |= u8_encode_bits(1, RX_ENC_FLAG_STBC_MASK);
+}
+
 static const u8 rx_status_bw_to_radiotap_eht_usig[] = {
 	[RATE_INFO_BW_20] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_20MHZ,
 	[RATE_INFO_BW_5] = U8_MAX,
@@ -2025,10 +2048,14 @@ static void rtw89_core_update_radiotap_eht(struct rtw89_dev *rtwdev,
 
 	eht->user_info[0] =
 		cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
-			    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O);
+			    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O |
+			    IEEE80211_RADIOTAP_EHT_USER_INFO_CODING_KNOWN);
 	eht->user_info[0] |=
 		le32_encode_bits(rx_status->rate_idx, IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
 		le32_encode_bits(rx_status->nss, IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
+	if (rx_status->enc_flags & RX_ENC_FLAG_LDPC)
+		eht->user_info[0] |=
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_CODING);
 
 	/* U-SIG */
 	tlv = (void *)tlv + sizeof(*tlv) + ALIGN(eht_len, 4);
@@ -2054,6 +2081,8 @@ static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
 {
 	static const struct ieee80211_radiotap_he known_he = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
+				     IEEE80211_RADIOTAP_HE_DATA1_CODING_KNOWN |
+				     IEEE80211_RADIOTAP_HE_DATA1_STBC_KNOWN |
 				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
 		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
 	};
@@ -2085,6 +2114,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 
 	rtw89_core_hw_to_sband_rate(rx_status);
 	rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
+	rtw89_core_update_rx_status_by_ppdu(rtwdev, rx_status, phy_ppdu);
 	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status);
 	/* In low power mode, it does RX in thread context. */
 	local_bh_disable();
@@ -4496,6 +4526,10 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->max_tx_aggregation_subframes = RTW89_MAX_TX_AGG_NUM;
 	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
 
+	hw->radiotap_mcs_details |= IEEE80211_RADIOTAP_MCS_HAVE_FEC |
+				    IEEE80211_RADIOTAP_MCS_HAVE_STBC;
+	hw->radiotap_vht_details |= IEEE80211_RADIOTAP_VHT_KNOWN_STBC;
+
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, MFP_CAPABLE);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 351296aba534..35f0cdfb8ddc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -793,6 +793,8 @@ struct rtw89_rx_phy_ppdu {
 		u8 evm_max;
 		u8 evm_min;
 	} ofdm;
+	bool ldpc;
+	bool stbc;
 	bool to_self;
 	bool valid;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 11049a50de2c..3882938c0893 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -558,6 +558,8 @@ struct rtw89_phy_sts_ie0 {
 #define RTW89_PHY_STS_IE01_W2_AVG_SNR GENMASK(5, 0)
 #define RTW89_PHY_STS_IE01_W2_EVM_MAX GENMASK(15, 8)
 #define RTW89_PHY_STS_IE01_W2_EVM_MIN GENMASK(23, 16)
+#define RTW89_PHY_STS_IE01_W2_LDPC BIT(28)
+#define RTW89_PHY_STS_IE01_W2_STBC BIT(30)
 
 enum rtw89_tx_channel {
 	RTW89_TXCH_ACH0	= 0,
-- 
2.25.1


