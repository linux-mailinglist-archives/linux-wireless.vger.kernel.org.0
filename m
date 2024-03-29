Return-Path: <linux-wireless+bounces-5516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5DC8910D3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635E8B22F78
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16642ABD;
	Fri, 29 Mar 2024 01:54:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93E20DCB
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677269; cv=none; b=K9Fg1SLIAjiJbek0Lqrm/v8Arw4aLou1ptE625vlA4UcIzdRpQMEOYg59e0VhOoGBjYsQUeGqLzhfEmKgP/sJAWL/J3xyZxtRP0elTfcKtiaZfMA8jeK2Y3RTswCARwv2ZvmMvWrkp+FkouDPcWE6N2G37UT0xinEIiR1bxaHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677269; c=relaxed/simple;
	bh=Ur60seDagPZ24sD1PvVsfpASEZWYOhVU9/BXwRwvuD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWXDaNAdGRX3JtVapeQr3TuwPHNGPe0zlry5QGkJoHdC7AeB6C8d5YBADkh9h16oQnYwy/5ysi8fyxsGyOV4XqJlLOc96UUMz5q0NqZj5nsSl90fvC5Bth62vMcSDgi/Ruo55F9siDAZyGe76UXVuSosNTrwhqANJgtIhwvFXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T1sPSR13183256, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T1sPSR13183256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 09:54:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:54:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 09:54:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 3/4] wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
Date: Fri, 29 Mar 2024 09:52:50 +0800
Message-ID: <20240329015251.22762-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329015251.22762-1-pkshih@realtek.com>
References: <20240329015251.22762-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Increase PCI BER (bit error rate) count depth setting which could increase
PHY circuit fault tolerance and improve compatibility.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 18 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 10 ++++++++
 drivers/net/wireless/realtek/rtw89/pci.c      | 19 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      |  5 ++++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    | 23 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 9 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d474b8d5df3d..b8d419a5b9db 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4069,6 +4069,24 @@ void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg eve
 	}
 }
 
+void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks)
+{
+	const struct dmi_system_id *match;
+	enum rtw89_quirks quirk;
+
+	if (!quirks)
+		return;
+
+	for (match = dmi_first_match(quirks); match; match = dmi_first_match(match + 1)) {
+		quirk = (uintptr_t)match->driver_data;
+		if (quirk >= NUM_OF_RTW89_QUIRKS)
+			continue;
+
+		set_bit(quirk, rtwdev->quirks);
+	}
+}
+EXPORT_SYMBOL(rtw89_check_quirks);
+
 int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fc1ed8612cf1..1ea5703225fb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7,6 +7,7 @@
 
 #include <linux/average.h>
 #include <linux/bitfield.h>
+#include <linux/dmi.h>
 #include <linux/firmware.h>
 #include <linux/iopoll.h>
 #include <linux/workqueue.h>
@@ -4079,6 +4080,7 @@ union rtw89_bus_info {
 
 struct rtw89_driver_info {
 	const struct rtw89_chip_info *chip;
+	const struct dmi_system_id *quirks;
 	union rtw89_bus_info bus;
 };
 
@@ -4426,6 +4428,12 @@ enum rtw89_flags {
 	NUM_OF_RTW89_FLAGS,
 };
 
+enum rtw89_quirks {
+	RTW89_QUIRK_PCI_BER,
+
+	NUM_OF_RTW89_QUIRKS,
+};
+
 enum rtw89_pkt_drop_sel {
 	RTW89_PKT_DROP_SEL_MACID_BE_ONCE,
 	RTW89_PKT_DROP_SEL_MACID_BK_ONCE,
@@ -5186,6 +5194,7 @@ struct rtw89_dev {
 	DECLARE_BITMAP(mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW89_FLAGS);
 	DECLARE_BITMAP(pkt_offload, RTW89_MAX_PKT_OFLD_NUM);
+	DECLARE_BITMAP(quirks, NUM_OF_RTW89_QUIRKS);
 
 	struct rtw89_phy_stat phystat;
 	struct rtw89_rfk_wait_info rfk_wait;
@@ -6231,6 +6240,7 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta,
 			       struct cfg80211_tid_config *tid_config);
+void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks);
 int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 19001130ad94..46e24b3d807f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2298,6 +2298,22 @@ static int rtw89_pci_deglitch_setting(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_pci_ber(struct rtw89_dev *rtwdev)
+{
+	u32 phy_offset;
+
+	if (!test_bit(RTW89_QUIRK_PCI_BER, rtwdev->quirks))
+		return;
+
+	phy_offset = R_RAC_DIRECT_OFFSET_G1;
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA1E * RAC_MULT, RAC_ANA1E_G1_VAL);
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA2E * RAC_MULT, RAC_ANA2E_VAL);
+
+	phy_offset = R_RAC_DIRECT_OFFSET_G2;
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA1E * RAC_MULT, RAC_ANA1E_G2_VAL);
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA2E * RAC_MULT, RAC_ANA2E_VAL);
+}
+
 static void rtw89_pci_rxdma_prefth(struct rtw89_dev *rtwdev)
 {
 	if (rtwdev->chip->chip_id != RTL8852A)
@@ -2695,6 +2711,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int ret;
 
+	rtw89_pci_ber(rtwdev);
 	rtw89_pci_rxdma_prefth(rtwdev);
 	rtw89_pci_l1off_pwroff(rtwdev);
 	rtw89_pci_deglitch_setting(rtwdev);
@@ -4171,6 +4188,8 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtwdev->hci.rpwm_addr = pci_info->rpwm_addr;
 	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
+	rtw89_check_quirks(rtwdev, info->quirks);
+
 	SET_IEEE80211_DEV(rtwdev->hw, &pdev->dev);
 
 	ret = rtw89_core_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index a63b6b7c9bfa..87e7081664c1 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -26,11 +26,16 @@
 #define RAC_REG_FLD_0			0x1D
 #define BAC_AUTOK_N_MASK		GENMASK(3, 2)
 #define PCIE_AUTOK_4			0x3
+#define RAC_ANA1E			0x1E
+#define RAC_ANA1E_G1_VAL		0x66EA
+#define RAC_ANA1E_G2_VAL		0x6EEA
 #define RAC_ANA1F			0x1F
 #define RAC_ANA24			0x24
 #define B_AX_DEGLITCH			GENMASK(11, 8)
 #define RAC_ANA26			0x26
 #define B_AX_RXEN			GENMASK(15, 14)
+#define RAC_ANA2E			0x2E
+#define RAC_ANA2E_VAL			0xFFFE
 #define RAC_CTRL_PPR_V1			0x30
 #define B_AX_CLK_CALIB_EN		BIT(12)
 #define B_AX_CALIB_EN			BIT(13)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index ca1374a71727..ec3629d95fda 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -63,6 +63,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8851be_info = {
 	.chip = &rtw8851b_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8851b_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 7c6ffedb77e2..fdee5dd4ba14 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -61,6 +61,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8852ae_info = {
 	.chip = &rtw8852a_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8852a_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index ed71364e6437..5f941122655c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -63,6 +63,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8852be_info = {
 	.chip = &rtw8852b_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8852b_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 583ea673a4f5..e07c7f3ade41 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -68,8 +68,31 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.recognize_intrs	= rtw89_pci_recognize_intrs_v1,
 };
 
+static const struct dmi_system_id rtw8852c_pci_quirks[] = {
+	{
+		.ident = "Dell Inc. Vostro 16 5640",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 16 5640"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "0CA0"),
+		},
+		.driver_data = (void *)RTW89_QUIRK_PCI_BER,
+	},
+	{
+		.ident = "Dell Inc. Inspiron 16 5640",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5640"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "0C9F"),
+		},
+		.driver_data = (void *)RTW89_QUIRK_PCI_BER,
+	},
+	{},
+};
+
 static const struct rtw89_driver_info rtw89_8852ce_info = {
 	.chip = &rtw8852c_chip_info,
+	.quirks = rtw8852c_pci_quirks,
 	.bus = {
 		.pci = &rtw8852c_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 4981b657bd7b..ce8aaa9501e1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -61,6 +61,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8922ae_info = {
 	.chip = &rtw8922a_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8922a_pci_info,
 	},
-- 
2.25.1


