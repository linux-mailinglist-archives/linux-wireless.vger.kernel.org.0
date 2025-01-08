Return-Path: <linux-wireless+bounces-17177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01731A0505F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B83418842E6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261D219DFA7;
	Wed,  8 Jan 2025 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bmdJC0i+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53619CC3A
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302222; cv=none; b=n9TBlmMB28XGh+7HKkwYOePzfDBow7vts4Ppp2w1ZjfdqfWxbRoR2NhRGBvNLgLNkHVUyn2eOnjjUIWLsryKHFdtUsfo4tz+y39Jl6SC/PXuIH8hoVJDFPNYvjaJfz5IRHHUzfhn2jOWjE6Veqqo/upvpWYa00nDSA7dzOid+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302222; c=relaxed/simple;
	bh=JiE45TgJ53JX2Yob4DkbHBOfAMnQmE2KQVr+RD8xyHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7vgisTbIOK4BkQPqYo47nc+1yGWj3nkdoZc2qazqTMb1UXjrNz6G/QUF8TeuS52fYQUaf8qbVVXzlRVXUY5sfYs2QiMpILuxqQdm8P7zoAQ8j+dqHTJbHlpP0i8x0JRNM/yDWpSe3sKEV1CjhvqTnv+kcAmAO/bwFmJYATBVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bmdJC0i+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5082AEguC619993, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736302214; bh=JiE45TgJ53JX2Yob4DkbHBOfAMnQmE2KQVr+RD8xyHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bmdJC0i+bA0gEjGNp3avOthE+KJu0lbEzHnGGnkz7LZY+1ZhLSgi8aHqN0/Smvrlg
	 WPZA7mwpAyr+k4uf8WxVDClVSWhMQ2m0Ro+/iaXOA9Wuy0lDHDdPFWZFUjqBs2q5N5
	 k9Y3atcFVKVq7tYoZ4XFHSWxmx05QJ0WYcmXHpWv9y1Dwq72FtR0HmbgHRV+40oM9w
	 a4RKcKc89Sb1D4vHFrxzHGhY1Jz/Fhbbda+CHYgts/q8j9+yLCLLyMMJlfUtv+Kpfs
	 GpI6Y2ekU7seGLD96r/WCWb6Oze9j9h9zWK994FKf3D74HEgRQjWeRFKCTtvSF1NQW
	 EbAPBELNtVXUg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5082AEguC619993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 10:10:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 Jan 2025 10:10:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 8 Jan
 2025 10:10:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/2] wifi: rtw89: 8922ae: add variant info to support RTL8922AE-VS
Date: Wed, 8 Jan 2025 10:09:55 +0800
Message-ID: <20250108020955.14668-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108020955.14668-1-pkshih@realtek.com>
References: <20250108020955.14668-1-pkshih@realtek.com>
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

RTL8922AE-VS is a variant of RTL8922AE, which is supported by firmware
version after 0.35.54.0 and only can support up to MCS11. Add a variant
struct to describe these requirements accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/Kconfig    |  6 +++--
 drivers/net/wireless/realtek/rtw89/core.c     | 18 +++++++++----
 drivers/net/wireless/realtek/rtw89/core.h     | 12 ++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 25 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  9 ++++++-
 drivers/net/wireless/realtek/rtw89/pci.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 10 +++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |  4 +++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  6 +++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.h |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    | 16 +++++++++++-
 16 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index d2a3361669d7..b1c86cdd9c0e 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -96,17 +96,19 @@ config RTW89_8852CE
 	  802.11ax PCIe wireless network (Wi-Fi 6E) adapter
 
 config RTW89_8922AE
-	tristate "Realtek 8922AE PCI wireless network (Wi-Fi 7) adapter"
+	tristate "Realtek 8922AE/8922AE-VS PCI wireless network (Wi-Fi 7) adapter"
 	depends on PCI
 	select RTW89_CORE
 	select RTW89_PCI
 	select RTW89_8922A
 	help
-	  Select this option will enable support for 8922AE chipset
+	  Select this option will enable support for 8922AE/8922AE-VS chipset
 
 	  802.11be PCIe wireless network (Wi-Fi 7) adapter
 	  supporting 2x2 2GHz/5GHz/6GHz 4096-QAM 160MHz channels.
 
+	  The variant 8922AE-VS has the same features except 1024-QAM.
+
 config RTW89_DEBUG
 	bool
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f848185e2ced..80b7b7cc5983 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4228,13 +4228,17 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 	struct ieee80211_eht_mcs_nss_supp *eht_nss;
 	struct ieee80211_sta_eht_cap *eht_cap;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	bool support_mcs_12_13 = true;
 	bool support_320mhz = false;
+	u8 val, val_mcs13;
 	int sts = 8;
-	u8 val;
 
 	if (chip->chip_gen == RTW89_CHIP_AX)
 		return;
 
+	if (hal->no_mcs_12_13)
+		support_mcs_12_13 = false;
+
 	if (band == NL80211_BAND_6GHZ &&
 	    chip->support_bandwidths & BIT(NL80211_CHAN_WIDTH_320))
 		support_320mhz = true;
@@ -4292,16 +4296,18 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 
 	val = u8_encode_bits(hal->rx_nss, IEEE80211_EHT_MCS_NSS_RX) |
 	      u8_encode_bits(hal->tx_nss, IEEE80211_EHT_MCS_NSS_TX);
+	val_mcs13 = support_mcs_12_13 ? val : 0;
+
 	eht_nss->bw._80.rx_tx_mcs9_max_nss = val;
 	eht_nss->bw._80.rx_tx_mcs11_max_nss = val;
-	eht_nss->bw._80.rx_tx_mcs13_max_nss = val;
+	eht_nss->bw._80.rx_tx_mcs13_max_nss = val_mcs13;
 	eht_nss->bw._160.rx_tx_mcs9_max_nss = val;
 	eht_nss->bw._160.rx_tx_mcs11_max_nss = val;
-	eht_nss->bw._160.rx_tx_mcs13_max_nss = val;
+	eht_nss->bw._160.rx_tx_mcs13_max_nss = val_mcs13;
 	if (support_320mhz) {
 		eht_nss->bw._320.rx_tx_mcs9_max_nss = val;
 		eht_nss->bw._320.rx_tx_mcs11_max_nss = val;
-		eht_nss->bw._320.rx_tx_mcs13_max_nss = val;
+		eht_nss->bw._320.rx_tx_mcs13_max_nss = val_mcs13;
 	}
 }
 
@@ -5336,7 +5342,8 @@ EXPORT_SYMBOL(rtw89_core_unregister);
 
 struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 					   u32 bus_data_size,
-					   const struct rtw89_chip_info *chip)
+					   const struct rtw89_chip_info *chip,
+					   const struct rtw89_chip_variant *variant)
 {
 	struct rtw89_fw_info early_fw = {};
 	const struct firmware *firmware;
@@ -5394,6 +5401,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	rtwdev->dev = device;
 	rtwdev->ops = ops;
 	rtwdev->chip = chip;
+	rtwdev->variant = variant;
 	rtwdev->fw.req.firmware = firmware;
 	rtwdev->fw.fw_format = fw_format;
 	rtwdev->support_mlo = support_mlo;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5b086ab36a3c..be642d5c6f72 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4364,12 +4364,18 @@ struct rtw89_chip_info {
 	const struct rtw89_xtal_info *xtal_info;
 };
 
+struct rtw89_chip_variant {
+	bool no_mcs_12_13: 1;
+	u32 fw_min_ver_code;
+};
+
 union rtw89_bus_info {
 	const struct rtw89_pci_info *pci;
 };
 
 struct rtw89_driver_info {
 	const struct rtw89_chip_info *chip;
+	const struct rtw89_chip_variant *variant;
 	const struct dmi_system_id *quirks;
 	union rtw89_bus_info bus;
 };
@@ -4744,6 +4750,8 @@ struct rtw89_hal {
 	bool ant_diversity_fixed;
 	bool support_cckpd;
 	bool support_igi;
+	bool no_mcs_12_13;
+
 	atomic_t roc_chanctx_idx;
 
 	DECLARE_BITMAP(changes, NUM_OF_RTW89_CHANCTX_CHANGES);
@@ -5602,6 +5610,7 @@ struct rtw89_dev {
 	enum rtw89_mlo_dbcc_mode mlo_dbcc_mode;
 	struct rtw89_hw_scan_info scan_info;
 	const struct rtw89_chip_info *chip;
+	const struct rtw89_chip_variant *variant;
 	const struct rtw89_pci_info *pci_info;
 	const struct rtw89_rfe_parms *rfe_parms;
 	struct rtw89_hal hal;
@@ -7037,7 +7046,8 @@ int rtw89_core_register(struct rtw89_dev *rtwdev);
 void rtw89_core_unregister(struct rtw89_dev *rtwdev);
 struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 					   u32 bus_data_size,
-					   const struct rtw89_chip_info *chip);
+					   const struct rtw89_chip_info *chip,
+					   const struct rtw89_chip_variant *variant);
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev);
 u8 rtw89_acquire_mac_id(struct rtw89_dev *rtwdev);
 void rtw89_release_mac_id(struct rtw89_dev *rtwdev, u8 mac_id);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2dc4bf4b1691..36a107ffe0c2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -806,6 +806,27 @@ rtw89_early_fw_feature_recognize(struct device *device,
 	return firmware;
 }
 
+static int rtw89_fw_validate_ver_required(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_variant *variant = rtwdev->variant;
+	const struct rtw89_fw_suit *fw_suit;
+	u32 suit_ver_code;
+
+	if (!variant)
+		return 0;
+
+	fw_suit = rtw89_fw_suit_get(rtwdev, RTW89_FW_NORMAL);
+	suit_ver_code = RTW89_FW_SUIT_VER_CODE(fw_suit);
+
+	if (variant->fw_min_ver_code > suit_ver_code) {
+		rtw89_err(rtwdev, "minimum required firmware version is 0x%x\n",
+			  variant->fw_min_ver_code);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -822,6 +843,10 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 		return ret;
 
 normal_done:
+	ret = rtw89_fw_validate_ver_required(rtwdev);
+	if (ret)
+		return ret;
+
 	/* It still works if wowlan firmware isn't existing. */
 	__rtw89_fw_recognize(rtwdev, RTW89_FW_WOWLAN, false);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e362214669db..a37c6d525d6f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3001,8 +3001,10 @@ static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 
 static int rtw89_mac_setup_phycap_part1(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_variant *variant = rtwdev->variant;
 	const struct rtw89_c2hreg_phycap *phycap;
 	struct rtw89_mac_c2h_info c2h_info = {};
+	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 qam_raw, qam;
 	int ret;
 
@@ -3025,7 +3027,12 @@ static int rtw89_mac_setup_phycap_part1(struct rtw89_dev *rtwdev)
 		break;
 	}
 
-	rtw89_debug(rtwdev, RTW89_DBG_FW, "phycap qam=%d/%d\n", qam_raw, qam);
+	if ((variant && variant->no_mcs_12_13) ||
+	    qam <= RTW89_C2HREG_PHYCAP_P1_W2_QAM_1024)
+		hal->no_mcs_12_13 = true;
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "phycap qam=%d/%d no_mcs_12_13=%d\n",
+		    qam_raw, qam, hal->no_mcs_12_13);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c3a027735d0f..7a34e773e2b6 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4410,7 +4410,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	rtwdev = rtw89_alloc_ieee80211_hw(&pdev->dev,
 					  sizeof(struct rtw89_pci),
-					  info->chip);
+					  info->chip, info->variant);
 	if (!rtwdev) {
 		dev_err(&pdev->dev, "failed to allocate hw\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 4e3754fd18fd..c7c05f7fda1d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -261,6 +261,9 @@ rtw89_ra_mask_he_rates[4] = {RA_MASK_HE_1SS_RATES, RA_MASK_HE_2SS_RATES,
 static const u64
 rtw89_ra_mask_eht_rates[4] = {RA_MASK_EHT_1SS_RATES, RA_MASK_EHT_2SS_RATES,
 			      RA_MASK_EHT_3SS_RATES, RA_MASK_EHT_4SS_RATES};
+static const u64
+rtw89_ra_mask_eht_mcs0_11[4] = {RA_MASK_EHT_1SS_MCS0_11, RA_MASK_EHT_2SS_MCS0_11,
+				RA_MASK_EHT_3SS_MCS0_11, RA_MASK_EHT_4SS_MCS0_11};
 
 static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 				struct rtw89_sta_link *rtwsta_link,
@@ -330,7 +333,12 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	if (link_sta->eht_cap.has_eht) {
 		mode |= RTW89_RA_MODE_EHT;
 		ra_mask |= get_eht_ra_mask(link_sta);
-		high_rate_masks = rtw89_ra_mask_eht_rates;
+
+		if (rtwdev->hal.no_mcs_12_13)
+			high_rate_masks = rtw89_ra_mask_eht_mcs0_11;
+		else
+			high_rate_masks = rtw89_ra_mask_eht_rates;
+
 		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta_link, link_sta,
 				    chan, &fix_giltf_en, &fix_giltf);
 	} else if (link_sta->he_cap.has_he) {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 697ee47fe325..08b635c93ac3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -51,6 +51,10 @@
 #define RA_MASK_EHT_2SS_RATES	GENMASK_ULL(43, 28)
 #define RA_MASK_EHT_3SS_RATES	GENMASK_ULL(59, 44)
 #define RA_MASK_EHT_4SS_RATES	GENMASK_ULL(62, 60)
+#define RA_MASK_EHT_1SS_MCS0_11	GENMASK_ULL(23, 12)
+#define RA_MASK_EHT_2SS_MCS0_11	GENMASK_ULL(39, 28)
+#define RA_MASK_EHT_3SS_MCS0_11	GENMASK_ULL(55, 44)
+#define RA_MASK_EHT_4SS_MCS0_11	GENMASK_ULL(62, 60)
 #define RA_MASK_EHT_RATES	GENMASK_ULL(62, 12)
 
 #define CFO_TRK_ENABLE_TH (2 << 2)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 651cbce1dd7e..56078545289e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -66,6 +66,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8851be_info = {
 	.chip = &rtw8851b_chip_info,
+	.variant = NULL,
 	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8851b_pci_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 701187d69e14..a8c5e6f61c9d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -64,6 +64,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8852ae_info = {
 	.chip = &rtw8852a_chip_info,
+	.variant = NULL,
 	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8852a_pci_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index a13ea1cce4a7..531389c74d1e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -66,6 +66,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8852be_info = {
 	.chip = &rtw8852b_chip_info,
+	.variant = NULL,
 	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8852b_pci_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index d1eebecfcd73..175276467bd1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -72,6 +72,7 @@ static const struct rtw89_pci_info rtw8852bt_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8852bte_info = {
 	.chip = &rtw8852bt_chip_info,
+	.variant = NULL,
 	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8852bt_pci_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 1a46878be96b..bfcefd018c0e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -95,6 +95,7 @@ static const struct dmi_system_id rtw8852c_pci_quirks[] = {
 
 static const struct rtw89_driver_info rtw89_8852ce_info = {
 	.chip = &rtw8852c_chip_info,
+	.variant = NULL,
 	.quirks = rtw8852c_pci_quirks,
 	.bus = {
 		.pci = &rtw8852c_pci_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index f04cb3b11372..11d66bfceb15 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2838,6 +2838,12 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 };
 EXPORT_SYMBOL(rtw8922a_chip_info);
 
+const struct rtw89_chip_variant rtw8922ae_vs_variant = {
+	.no_mcs_12_13 = true,
+	.fw_min_ver_code = RTW89_FW_VER_CODE(0, 35, 54, 0),
+};
+EXPORT_SYMBOL(rtw8922ae_vs_variant);
+
 MODULE_FIRMWARE(RTW8922A_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11be wireless 8922A driver");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.h b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
index 597317ab6af7..a29cfa5b4291 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
@@ -69,5 +69,6 @@ struct rtw8922a_efuse {
 } __packed;
 
 extern const struct rtw89_chip_info rtw8922a_chip_info;
+extern const struct rtw89_chip_variant rtw8922ae_vs_variant;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index edfb1f220af0..f0dd7d5d5038 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -70,6 +70,16 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8922ae_info = {
 	.chip = &rtw8922a_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+	.bus = {
+		.pci = &rtw8922a_pci_info,
+	},
+};
+
+static const struct rtw89_driver_info rtw89_8922ae_vs_info = {
+	.chip = &rtw8922a_chip_info,
+	.variant = &rtw8922ae_vs_variant,
 	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8922a_pci_info,
@@ -81,6 +91,10 @@ static const struct pci_device_id rtw89_8922ae_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8922),
 		.driver_data = (kernel_ulong_t)&rtw89_8922ae_info,
 	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x892B),
+		.driver_data = (kernel_ulong_t)&rtw89_8922ae_vs_info,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(pci, rtw89_8922ae_id_table);
@@ -95,5 +109,5 @@ static struct pci_driver rtw89_8922ae_driver = {
 module_pci_driver(rtw89_8922ae_driver);
 
 MODULE_AUTHOR("Realtek Corporation");
-MODULE_DESCRIPTION("Realtek 802.11be wireless 8922AE driver");
+MODULE_DESCRIPTION("Realtek 802.11be wireless 8922AE/8922AE-VS driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1


