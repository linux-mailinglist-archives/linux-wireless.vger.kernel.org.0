Return-Path: <linux-wireless+bounces-10468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD693AC3B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 07:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46961F215A7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 05:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23047F64;
	Wed, 24 Jul 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RzOXfwKm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530B208D7
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798808; cv=none; b=AOoLdzojLVDWAV4cXEJN/b5BtguAoqwLAP6+Jji1nXXjrN36EYx0Jal8d1Pi2BETboR7D407eeLHq4AjzyQPxbv59YT+96sL4JCKOEsRZ37b+KzoNfvJCIDwq9eOtf/Q2CcN+olTL7AMEXRFetBunlD8BeBqyYCEJNyWecIJ5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798808; c=relaxed/simple;
	bh=OdUVi/R9IPDn7KP4kJ+qogBI45/1NZXBVEhD4Na2BHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIE0CCyQrQvkZulygqNLTqGG5J8wWLCgBViYFtBMpBlju8S/17dZe5Qnh4eM1k94NtKLaKZOg77TEciwNy0IyOGjMNkc1Wsk50y6bGFHUxsPzwEGJid2/pGidz+arTQSY2YLP34g7fmoIt5sp19jWIFGUM2x1Jkg42Guw0EBr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RzOXfwKm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46O5Qhp461894602, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721798803; bh=OdUVi/R9IPDn7KP4kJ+qogBI45/1NZXBVEhD4Na2BHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RzOXfwKmAgLs5qTlC54P8S8nrt+szcyv1vULT6q33enjpAmwPBp/Zt3K8vYx439Ge
	 Od2g1+B284t1XHRiSnqqOedtc1p2J1Xd4csqSgg/kiO6KR+zdhRmhFeIqsboIyBXwf
	 eMAPq+6UOoNtc8BJxXBvZAyY4ONoGyDn2ArfjpgUUz+ikDa6GEX5m1H+nbc7axEhTV
	 8tn24UlEOtwNgWL48WJk8KFRwOKxGcS1BBPYDU5b6Y10NgZocya0h0NzNfAH7agT0u
	 NJ3D1eptJrfh+qK2g2Uz4r87vI7wp2djO0yNtTZ1RqoU5+rgKv6YSB002+NiIOJy2d
	 u8cjKa5hTK9bQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46O5Qhp461894602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:26:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 13:26:43 +0800
Received: from [127.0.1.1] (172.16.23.66) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Jul
 2024 13:26:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 1/4] wifi: rtw89: add EVM statistics for 1SS rate
Date: Wed, 24 Jul 2024 13:26:23 +0800
Message-ID: <20240724052626.12774-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724052626.12774-1-pkshih@realtek.com>
References: <20240724052626.12774-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

To more accurately debug performance issues, EVM statistics will
differentiate between different space streams, and only beacon
and data frames will be included.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 49 +++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h  |  3 ++
 drivers/net/wireless/realtek/rtw89/debug.c |  5 ++-
 drivers/net/wireless/realtek/rtw89/txrx.h  |  8 +++-
 4 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7019f7d482a8..86b6febedc25 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1449,16 +1449,20 @@ static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 	}
 
-	/* For WiFi 7 chips, RXWD.mac_id of PPDU status is not set by hardware,
-	 * so update mac_id by rxinfo_user[].mac_id.
-	 */
-	for (i = 0; i < usr_num && chip_gen == RTW89_CHIP_BE; i++) {
+	for (i = 0; i < usr_num; i++) {
 		user = &rxinfo->user[i];
 		if (!le32_get_bits(user->w0, RTW89_RXINFO_USER_MAC_ID_VALID))
 			continue;
-
-		phy_ppdu->mac_id =
-			le32_get_bits(user->w0, RTW89_RXINFO_USER_MACID);
+		/* For WiFi 7 chips, RXWD.mac_id of PPDU status is not set
+		 * by hardware, so update mac_id by rxinfo_user[].mac_id.
+		 */
+		if (chip_gen == RTW89_CHIP_BE)
+			phy_ppdu->mac_id =
+				le32_get_bits(user->w0, RTW89_RXINFO_USER_MACID);
+		phy_ppdu->has_data =
+			le32_get_bits(user->w0, RTW89_RXINFO_USER_DATA);
+		phy_ppdu->has_bcn =
+			le32_get_bits(user->w0, RTW89_RXINFO_USER_BCN);
 		break;
 	}
 
@@ -1480,6 +1484,26 @@ static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static u8 rtw89_get_data_rate_nss(struct rtw89_dev *rtwdev, u16 data_rate)
+{
+	u8 data_rate_mode;
+
+	data_rate_mode = rtw89_get_data_rate_mode(rtwdev, data_rate);
+	switch (data_rate_mode) {
+	case DATA_RATE_MODE_NON_HT:
+		return 1;
+	case DATA_RATE_MODE_HT:
+		return rtw89_get_data_ht_nss(rtwdev, data_rate) + 1;
+	case DATA_RATE_MODE_VHT:
+	case DATA_RATE_MODE_HE:
+	case DATA_RATE_MODE_EHT:
+		return rtw89_get_data_nss(rtwdev, data_rate) + 1;
+	default:
+		rtw89_warn(rtwdev, "invalid RX rate mode %d\n", data_rate_mode);
+		return 0;
+	}
+}
+
 static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 						struct ieee80211_sta *sta)
 {
@@ -1509,10 +1533,14 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 			ewma_rssi_add(&rtwsta->rssi[i], phy_ppdu->rssi[i]);
 	}
 
-	if (phy_ppdu->ofdm.has) {
+	if (phy_ppdu->ofdm.has && (phy_ppdu->has_data || phy_ppdu->has_bcn)) {
 		ewma_snr_add(&rtwsta->avg_snr, phy_ppdu->ofdm.avg_snr);
-		ewma_evm_add(&rtwsta->evm_min[evm_pos], phy_ppdu->ofdm.evm_min);
-		ewma_evm_add(&rtwsta->evm_max[evm_pos], phy_ppdu->ofdm.evm_max);
+		if (rtw89_get_data_rate_nss(rtwdev, phy_ppdu->rate) == 1) {
+			ewma_evm_add(&rtwsta->evm_1ss, phy_ppdu->ofdm.evm_min);
+		} else {
+			ewma_evm_add(&rtwsta->evm_min[evm_pos], phy_ppdu->ofdm.evm_min);
+			ewma_evm_add(&rtwsta->evm_max[evm_pos], phy_ppdu->ofdm.evm_max);
+		}
 	}
 }
 
@@ -3367,6 +3395,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 
 	ewma_rssi_init(&rtwsta->avg_rssi);
 	ewma_snr_init(&rtwsta->avg_snr);
+	ewma_evm_init(&rtwsta->evm_1ss);
 	for (i = 0; i < ant_num; i++) {
 		ewma_rssi_init(&rtwsta->rssi[i]);
 		ewma_evm_init(&rtwsta->evm_min[i]);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 11fa003a9788..0a09360515dc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -802,6 +802,8 @@ struct rtw89_rx_phy_ppdu {
 		u8 evm_max;
 		u8 evm_min;
 	} ofdm;
+	bool has_data;
+	bool has_bcn;
 	bool ldpc;
 	bool stbc;
 	bool to_self;
@@ -3306,6 +3308,7 @@ struct rtw89_sta {
 	struct ewma_rssi avg_rssi;
 	struct ewma_rssi rssi[RF_PATH_MAX];
 	struct ewma_snr avg_snr;
+	struct ewma_evm evm_1ss;
 	struct ewma_evm evm_min[RF_PATH_MAX];
 	struct ewma_evm evm_max[RF_PATH_MAX];
 	struct rtw89_ampdu_params ampdu_params[IEEE80211_NUM_TIDS];
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 9e1353cce9cc..6fc30f137eaa 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3505,7 +3505,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ant_num = hal->ant_diversity ? 2 : rtwdev->chip->rf_path_num;
 	bool ant_asterisk = hal->tx_path_diversity || hal->ant_diversity;
-	u8 evm_min, evm_max;
+	u8 evm_min, evm_max, evm_1ss;
 	u8 rssi;
 	u8 snr;
 	int i;
@@ -3574,7 +3574,8 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	}
 	seq_puts(m, "]\n");
 
-	seq_puts(m, "EVM: [");
+	evm_1ss = ewma_evm_read(&rtwsta->evm_1ss);
+	seq_printf(m, "EVM: [%2u.%02u, ", evm_1ss >> 2, (evm_1ss & 0x3) * 25);
 	for (i = 0; i < (hal->ant_diversity ? 2 : 1); i++) {
 		evm_min = ewma_evm_read(&rtwsta->evm_min[i]);
 		evm_max = ewma_evm_read(&rtwsta->evm_max[i]);
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 3882938c0893..a33280ec2a25 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -14,6 +14,7 @@
 #define DATA_RATE_HT_IDX_MASK		GENMASK(4, 0)
 #define DATA_RATE_HT_IDX_MASK_V1	GENMASK(4, 0)
 #define DATA_RATE_MODE_HT		0x1
+#define DATA_RATE_HT_NSS_MASK		GENMASK(4, 3)
 #define DATA_RATE_VHT_HE_NSS_MASK	GENMASK(6, 4)
 #define DATA_RATE_VHT_HE_IDX_MASK	GENMASK(3, 0)
 #define DATA_RATE_NSS_MASK_V1		GENMASK(7, 5)
@@ -51,6 +52,11 @@ static inline u8 rtw89_get_data_mcs(struct rtw89_dev *rtwdev, u16 hw_rate)
 	return u16_get_bits(hw_rate, DATA_RATE_VHT_HE_IDX_MASK);
 }
 
+static inline u8 rtw89_get_data_ht_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
+{
+	return u16_get_bits(hw_rate, DATA_RATE_HT_NSS_MASK);
+}
+
 static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 {
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
@@ -408,7 +414,7 @@ struct rtw89_rxinfo_user {
 #define RTW89_RXINFO_USER_DATA BIT(1)
 #define RTW89_RXINFO_USER_CTRL BIT(2)
 #define RTW89_RXINFO_USER_MGMT BIT(3)
-#define RTW89_RXINFO_USER_BCM BIT(4)
+#define RTW89_RXINFO_USER_BCN BIT(4)
 #define RTW89_RXINFO_USER_MACID GENMASK(15, 8)
 
 struct rtw89_rxinfo {
-- 
2.25.1


