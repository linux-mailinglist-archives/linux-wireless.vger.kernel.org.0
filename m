Return-Path: <linux-wireless+bounces-8094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86318D02E9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFD71C2236E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A01607AC;
	Mon, 27 May 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8Xo0ADX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D51607A7;
	Mon, 27 May 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819148; cv=none; b=lF16P9OJAKK4AJr/Kg1rC8JhnsRabmN7oRqPhCpHZ2AWwMoAasvm+sOZvXqu6NArUwRZThyWZvkNWWJOaCT+xRRpNH/j0MY8DZ04hK6vClER3xoKfTlOwPtt6lT5ojyB4HZvMffHfHPlth2VLK7dxN6qXDCsX8YWZuAgeqGJJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819148; c=relaxed/simple;
	bh=0RVgly+KPL2OnxYGLdV92Lvnv0iqax/OrxCpmM9RFVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTWRNaTFM/zEkF2Fh1FofcUHx5OG3YAH4GvL13G2ykVYjuLevlps0woomtq16AuxuBb8HcO7Bj5sDgycs6jtguxqv0pxdxiSxSLgM6H8qNNR2dJcc9mx91YaGNJHS9adj3mSBQstyU3CDP0wXRO39iV5+Jysg884PPj7UD5XcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8Xo0ADX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A886C4AF0A;
	Mon, 27 May 2024 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819148;
	bh=0RVgly+KPL2OnxYGLdV92Lvnv0iqax/OrxCpmM9RFVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8Xo0ADXMM1Dyj/aJZKY6Y+fKeoHNpRw1nP3hr3+T5764OwB/FCLKmr5CBmb7TdV7
	 JWfcJQcpZUkU0E9INv0Kafx4yrlNU+ArDgY+/DqyTN1EW9x99le3+VV9arUfbspK8B
	 ID5bda9uWw219ymeolxO9NoGN3YGtbQutZHMNZRr1rp7Qip21bHciZBL6l0ae4PS4d
	 AQL77T5lNdiYeqwXYQGhmxBcWYPFX3b8sXTmXR2WPHFkhuBxnJ9mEA/d1Jl0sttUCx
	 b/cfDfP/NH7bp990zgRX6SvRcbAkmn1mmupjiash+IppnAn6vBeJqJpBEdL7kyfHCY
	 D2/W/VghgRqqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 07/35] wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
Date: Mon, 27 May 2024 10:11:12 -0400
Message-ID: <20240527141214.3844331-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index d474b8d5df3dd..b8d419a5b9db0 100644
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
index 2e854c9af7099..509d84a493348 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7,6 +7,7 @@
 
 #include <linux/average.h>
 #include <linux/bitfield.h>
+#include <linux/dmi.h>
 #include <linux/firmware.h>
 #include <linux/iopoll.h>
 #include <linux/workqueue.h>
@@ -3977,6 +3978,7 @@ union rtw89_bus_info {
 
 struct rtw89_driver_info {
 	const struct rtw89_chip_info *chip;
+	const struct dmi_system_id *quirks;
 	union rtw89_bus_info bus;
 };
 
@@ -4324,6 +4326,12 @@ enum rtw89_flags {
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
@@ -5084,6 +5092,7 @@ struct rtw89_dev {
 	DECLARE_BITMAP(mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW89_FLAGS);
 	DECLARE_BITMAP(pkt_offload, RTW89_MAX_PKT_OFLD_NUM);
+	DECLARE_BITMAP(quirks, NUM_OF_RTW89_QUIRKS);
 
 	struct rtw89_phy_stat phystat;
 	struct rtw89_rfk_wait_info rfk_wait;
@@ -6129,6 +6138,7 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta,
 			       struct cfg80211_tid_config *tid_config);
+void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks);
 int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 19001130ad943..46e24b3d807f2 100644
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
index a63b6b7c9bfaf..87e7081664c1f 100644
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
index 4981b657bd7b0..ce8aaa9501e16 100644
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


