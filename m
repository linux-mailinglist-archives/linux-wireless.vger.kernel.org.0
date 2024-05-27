Return-Path: <linux-wireless+bounces-8100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29218D035F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B04D1F2848A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480E17165C;
	Mon, 27 May 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMFChAIL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25217165A;
	Mon, 27 May 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819270; cv=none; b=eU27Un7x1olQD37k0nbbRXDb6lElgn1BdC4M/s8NnGNZe/nU9ntsCsCU6zA19i2OyoBeP8NGKhCBc8v1fQ6khw5hfG37tsghHFwSqrxQRkE5M0bHXV2rIeBEhXwr8KxQJ0JI3nK3qaBJG5eG+VqwxzScq8lOPzEoXETZR2n4LRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819270; c=relaxed/simple;
	bh=uOv0MH1tCH1k0kqWIXNPPAj+9BNuI/XcllwC6nN3pxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGeOn9kgzHfXHzEjchWMd30ZF1qOL9egXe3pCOTaxz9+eK0LyTApFta/GXDFIEuLjoI3xHturtEceAGpdXwHmaw3FPCYsX8OnkFfWpJNwlK2fAFhqz9/zxqfvjZI9HSWhpN6//KhXTEimcB4GoZyFb23JPgFwOE+ek7Iq4N5mdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMFChAIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40644C4AF07;
	Mon, 27 May 2024 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819270;
	bh=uOv0MH1tCH1k0kqWIXNPPAj+9BNuI/XcllwC6nN3pxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMFChAILHYFc2OHJorsCIagXsXdi2S5QInimA/W+WVCNx7LUGXEeEXl4xITBIyRGF
	 grY+ViCZV7Q8fTLvEaSxPgcs/FDoeAgxnWDsfO++pjJQpiRQFtlTWiwhFzd3i2CSsQ
	 8K0vNqJuUugjP9KyHw9DKIiBQ6Luux/9FC5hYTd3dcdrZSl/07/LJ8OWjlUySY4k3j
	 hg5UhWAO86MaaHF47YLDRGVnOcBQG+fRH2UalEYdmgE5FK51NfC57lOULrooibsgoI
	 kQKYgu8LNpEAHKtwdkOHfS/UkLxrU/QxMTVFXdJHeRJTUg6WWjGk2mpvH+ZzKF3OEO
	 obSx98l68bVgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 06/30] wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
Date: Mon, 27 May 2024 10:13:15 -0400
Message-ID: <20240527141406.3852821-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 5b919d726b613c78d4dc463dd9f90c55843fd1b3 ]

Increase PCI BER (bit error rate) count depth setting which could increase
PHY circuit fault tolerance and improve compatibility.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://msgid.link/20240329015251.22762-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index fd527a2499964..b967d80ec84b5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3940,6 +3940,24 @@ void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg eve
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
index ea6df859ba152..e72a6a958a231 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7,6 +7,7 @@
 
 #include <linux/average.h>
 #include <linux/bitfield.h>
+#include <linux/dmi.h>
 #include <linux/firmware.h>
 #include <linux/iopoll.h>
 #include <linux/workqueue.h>
@@ -3812,6 +3813,7 @@ union rtw89_bus_info {
 
 struct rtw89_driver_info {
 	const struct rtw89_chip_info *chip;
+	const struct dmi_system_id *quirks;
 	union rtw89_bus_info bus;
 };
 
@@ -4139,6 +4141,12 @@ enum rtw89_flags {
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
@@ -4804,6 +4812,7 @@ struct rtw89_dev {
 	DECLARE_BITMAP(mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW89_FLAGS);
 	DECLARE_BITMAP(pkt_offload, RTW89_MAX_PKT_OFLD_NUM);
+	DECLARE_BITMAP(quirks, NUM_OF_RTW89_QUIRKS);
 
 	struct rtw89_phy_stat phystat;
 	struct rtw89_dack_info dack;
@@ -5803,6 +5812,7 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta,
 			       struct cfg80211_tid_config *tid_config);
+void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks);
 int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index cb03474f81552..59b04197609d7 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2233,6 +2233,22 @@ static int rtw89_pci_deglitch_setting(struct rtw89_dev *rtwdev)
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
@@ -2630,6 +2646,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int ret;
 
+	rtw89_pci_ber(rtwdev);
 	rtw89_pci_rxdma_prefth(rtwdev);
 	rtw89_pci_l1off_pwroff(rtwdev);
 	rtw89_pci_deglitch_setting(rtwdev);
@@ -4072,6 +4089,8 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtwdev->hci.rpwm_addr = pci_info->rpwm_addr;
 	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
+	rtw89_check_quirks(rtwdev, info->quirks);
+
 	SET_IEEE80211_DEV(rtwdev->hw, &pdev->dev);
 
 	ret = rtw89_core_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 772a84bd8db6b..b50d7a18e30bc 100644
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
index ca1374a717272..ec3629d95fda1 100644
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
index 7c6ffedb77e27..fdee5dd4ba148 100644
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
index ed71364e6437b..5f941122655c4 100644
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
index 583ea673a4f54..e07c7f3ade41e 100644
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
index 9f46fb1661055..15ea8e20dde36 100644
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
2.43.0


