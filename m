Return-Path: <linux-wireless+bounces-30152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFBFCE5C6A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B9930062D2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A21FBEB0;
	Mon, 29 Dec 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EJgaAhJC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F0224F3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977813; cv=none; b=lHjVLzW7Duw3dqYptChLvDNXjJLEwGqLbzi3124yXaXRU7NQd2rb/8OpRdmquICKmrlJmo1AjRel+MfYHy9IdGAx5LcpJkIRWIm3YeSijPcC4P2nkgBo0XicQaBfH/YaaDUtKBHZuPhkaiks6eaf1GcTuYPq2o02a4zL4yiCDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977813; c=relaxed/simple;
	bh=pHCLsYFF8CTkSEw4imqy9LgbHX7rhu3NxnmOqhTtb/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ8RoNTnUrO5OD3EbX7Ok98P5Wbpe55DEd7OnF0jWhH5i5ry6KyMSoe+yR3/smH200rObAGsM/58I0iL4RzdBECBxAFUitbb808fctCklJtFs2rPwmKzkCpy1T7K6jBSHm7VwoVV9cFB05TAK56dd5rRbZX1emDXHOHx8safgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EJgaAhJC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3A8qpC282644, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977809; bh=lPf3UVmGqB9QCUELPYmudIpJUnUJVVDMgwW86cMzYhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EJgaAhJC4THNcyRxhXoSTxYdSaeBtciHRUEqXv1ee0dTZN7z1Jl8QiCAWhIgfejeS
	 0O5Mxgm5/D4OMx8wPuwUoUlPQB0Ao2wFZs80yLSAmpZC8DatOwkGP6YT91qIh7QVP/
	 bA0gnzTB1sWM2prH+z2knn4f4KEdxuIsyh2EmPLz5F8NmRi5RgUdSwv/oLjhajg6bo
	 WlVCCXSkLl3QAyHC7EaO9+CCXPFOtPZuGY9AdZr3cRmP2mnwiLW9QD9Obzsa06kb/o
	 OyoinwfDRQrskfkb+pIJwHqoM4z8vkDWMI2RK+6wznb7x1QOUBdRq5i65pNM8nD1BR
	 mFVYXbNrZsNYw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3A8qpC282644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:09 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:08 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 05/12] wifi: rtw89: define TX/RX aggregation and MPDU capability per chip
Date: Mon, 29 Dec 2025 11:09:19 +0800
Message-ID: <20251229030926.27004-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

Since TX/RX aggregation is different from chip to chip, define individual
number according to hardware ability. Also the coming chip RTL8922DE
can get expected performance.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c      | 10 +++++-----
 drivers/net/wireless/realtek/rtw89/core.h      |  7 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  4 ++++
 8 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d07dc97e22d4..51aa3d0eb2ef 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5086,7 +5086,7 @@ static void rtw89_init_vht_cap(struct rtw89_dev *rtwdev,
 	}
 
 	vht_cap->vht_supported = true;
-	vht_cap->cap = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+	vht_cap->cap = chip->max_vht_mpdu_cap |
 		       IEEE80211_VHT_CAP_SHORT_GI_80 |
 		       IEEE80211_VHT_CAP_RXSTBC_1 |
 		       IEEE80211_VHT_CAP_HTC_VHT |
@@ -5214,7 +5214,7 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 					IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START) |
 		       le16_encode_bits(IEEE80211_VHT_MAX_AMPDU_1024K,
 					IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP) |
-		       le16_encode_bits(IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+		       le16_encode_bits(chip->max_vht_mpdu_cap,
 					IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN);
 		iftype_data->he_6ghz_capa.capa = capa;
 	}
@@ -5252,7 +5252,7 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	eht_cap->has_eht = true;
 
 	eht_cap_elem->mac_cap_info[0] =
-		u8_encode_bits(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991,
+		u8_encode_bits(chip->max_eht_mpdu_cap,
 			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 	eht_cap_elem->mac_cap_info[1] = 0;
 
@@ -6399,8 +6399,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 	hw->extra_tx_headroom = tx_headroom;
 	hw->queues = IEEE80211_NUM_ACS;
-	hw->max_rx_aggregation_subframes = RTW89_MAX_RX_AGG_NUM;
-	hw->max_tx_aggregation_subframes = RTW89_MAX_TX_AGG_NUM;
+	hw->max_rx_aggregation_subframes = chip->max_rx_agg_num;
+	hw->max_tx_aggregation_subframes = chip->max_tx_agg_num;
 	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
 
 	hw->radiotap_mcs_details |= IEEE80211_RADIOTAP_MCS_HAVE_FEC |
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5b4f998e1978..8f9c49d2ec5b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3407,9 +3407,6 @@ struct rtw89_ra_info {
 #define RTW89_PPDU_MAC_RX_CNT_SIZE 96
 #define RTW89_PPDU_MAC_RX_CNT_SIZE_V1 128
 
-#define RTW89_MAX_RX_AGG_NUM 64
-#define RTW89_MAX_TX_AGG_NUM 128
-
 struct rtw89_ampdu_params {
 	u16 agg_num;
 	bool amsdu;
@@ -4429,6 +4426,10 @@ struct rtw89_chip_info {
 	bool small_fifo_size;
 	u32 dle_scc_rsvd_size;
 	u16 max_amsdu_limit;
+	u16 max_vht_mpdu_cap;
+	u16 max_eht_mpdu_cap;
+	u16 max_tx_agg_num;
+	u16 max_rx_agg_num;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
 	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_TYPE_NUM];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 97254fe638d1..7e97220b723a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2591,6 +2591,10 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
 	.max_amsdu_limit	= 3500,
+	.max_vht_mpdu_cap	= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+	.max_eht_mpdu_cap	= 0,
+	.max_tx_agg_num		= 128,
+	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index f44ea4cd4c9e..58e041016c26 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2276,6 +2276,10 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
 	.max_amsdu_limit	= 3500,
+	.max_vht_mpdu_cap	= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+	.max_eht_mpdu_cap	= 0,
+	.max_tx_agg_num		= 128,
+	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b1ea0a6e38c2..f813ec9242eb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -900,6 +900,10 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
 	.max_amsdu_limit	= 5000,
+	.max_vht_mpdu_cap	= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+	.max_eht_mpdu_cap	= 0,
+	.max_tx_agg_num		= 128,
+	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 362d92d86aa1..534ac137b43f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -766,6 +766,10 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
 	.max_amsdu_limit	= 5000,
+	.max_vht_mpdu_cap	= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+	.max_eht_mpdu_cap	= 0,
+	.max_tx_agg_num		= 128,
+	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= {rtw8852bt_hfc_param_ini_pcie, NULL, NULL},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index bc31f563ad93..2110c714394d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3117,6 +3117,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
 	.max_amsdu_limit	= 8000,
+	.max_vht_mpdu_cap	= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+	.max_eht_mpdu_cap	= 0,
+	.max_tx_agg_num		= 128,
+	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index cfd42b0145d3..0383c3bd60dd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2890,6 +2890,10 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
 	.max_amsdu_limit	= 8000,
+	.max_vht_mpdu_cap	= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454,
+	.max_eht_mpdu_cap	= IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991,
+	.max_tx_agg_num		= 128,
+	.max_rx_agg_num		= 64,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
 	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie, NULL, NULL},
-- 
2.25.1


