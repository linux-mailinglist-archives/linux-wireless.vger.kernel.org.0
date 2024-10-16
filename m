Return-Path: <linux-wireless+bounces-14091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF8A9A0BBE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06071C24051
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD72071FC;
	Wed, 16 Oct 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EJcw/7lJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04539443
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085890; cv=none; b=sqDJHgzeytJcmem2xFbUIYZtc7yT0QYsfMPAYkgmkiFKtbMMOjt80MoEqJoSqeEsBPRFO98fXsdipYcRA1KkrZNugXHACN6/ljmyNZqMF76DccK+AYfHaLtEe8j6Tsn7k2Zeod91pF5E2r1sIR4IeRVFRUVYheOgeYzWsSryBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085890; c=relaxed/simple;
	bh=3QNZizgUrWf9GWsZccfA4kXJDv/kWf3Kcv2SGs2EXl8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z40LsBxfmDtsyvSFv6lc7HXPhvIm6nQy/lS32w31dw03Kjf4F167R0dSInVksoXnIbHynpRam3lm0sGeDMhMtzHsQKIbuYw3ctzigms10gUdY6CpzFUqjfIkzFL15vgrjAA3hLnoDSj+JWT0uxb+QQp94tJ/G+h7P8jgm0nfp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EJcw/7lJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49GDc66h93078497, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729085886; bh=3QNZizgUrWf9GWsZccfA4kXJDv/kWf3Kcv2SGs2EXl8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EJcw/7lJ8x/nSSDTg2fTOk5EsFagfdw8v1lgB0a+Cya2iqZnu9JQmQESrqSuvToYB
	 mY8l8YA29IJTk+Xw7GXlmEusB77JIwM8qa5iROgaTPuCaOtjPICNKqMCrc0u7KaFrw
	 8zFCvzlMtvvMtJ/ms58qjQgF8VbHcxT6TfbQg4tUhfl7fO+hvUC2hJHLFEioTbANfV
	 quuh7UdwqVpt1/wl5ck1KGy978QbBO0rjgNTdlcVr1z/U9oIkaRAPK2Em5djKaI1PE
	 yRqh8Hr4nDmnBGH/o6jTTQMDUbeeG5fdcV6FUxK+NGq+KvCItAK5JeBppebwroupSO
	 SE3nLv5+HZQ4w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49GDc66h93078497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 21:38:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 21:38:05 +0800
Received: from [127.0.1.1] (172.16.21.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Oct
 2024 21:38:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: pci: add quirks by PCI subsystem ID for thermal protection
Date: Wed, 16 Oct 2024 21:37:35 +0800
Message-ID: <20241016133735.7571-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016133735.7571-1-pkshih@realtek.com>
References: <20241016133735.7571-1-pkshih@realtek.com>
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

Specific PCI subsystem ID (SSID) of WiFi cards is used by specific
customer who want to enable various features with different arguments.

Define PCI SSID quirks tables to enable thermal protection with two kinds
of thermal values for 110 and 120 degree Celsius.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  9 ++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 13 ++++++++
 drivers/net/wireless/realtek/rtw89/pci.c      | 31 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      | 15 +++++++++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  2 ++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  2 ++
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  2 ++
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  2 ++
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  2 ++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  8 +++++
 10 files changed, 86 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bba5bde95bb4..dc2578a331fc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4818,11 +4818,20 @@ static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 
 static void rtw89_core_setup_phycap(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
 	rtwdev->hal.support_cckpd =
 		!(rtwdev->chip->chip_id == RTL8852A && rtwdev->hal.cv <= CHIP_CBV) &&
 		!(rtwdev->chip->chip_id == RTL8852B && rtwdev->hal.cv <= CHIP_CAV);
 	rtwdev->hal.support_igi =
 		rtwdev->chip->chip_id == RTL8852A && rtwdev->hal.cv <= CHIP_CBV;
+
+	if (test_bit(RTW89_QUIRK_THERMAL_PROT_120C, rtwdev->quirks))
+		rtwdev->hal.thermal_prot_th = chip->thermal_th[1];
+	else if (test_bit(RTW89_QUIRK_THERMAL_PROT_110C, rtwdev->quirks))
+		rtwdev->hal.thermal_prot_th = chip->thermal_th[0];
+	else
+		rtwdev->hal.thermal_prot_th = 0;
 }
 
 static void rtw89_core_setup_rfe_parms(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6218e033b2b8..26b688c91902 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4719,10 +4719,22 @@ enum rtw89_flags {
 
 enum rtw89_quirks {
 	RTW89_QUIRK_PCI_BER,
+	RTW89_QUIRK_THERMAL_PROT_120C,
+	RTW89_QUIRK_THERMAL_PROT_110C,
 
 	NUM_OF_RTW89_QUIRKS,
 };
 
+enum rtw89_custid {
+	RTW89_CUSTID_NONE,
+	RTW89_CUSTID_ACER,
+	RTW89_CUSTID_AMD,
+	RTW89_CUSTID_ASUS,
+	RTW89_CUSTID_DELL,
+	RTW89_CUSTID_HP,
+	RTW89_CUSTID_LENOVO,
+};
+
 enum rtw89_pkt_drop_sel {
 	RTW89_PKT_DROP_SEL_MACID_BE_ONCE,
 	RTW89_PKT_DROP_SEL_MACID_BK_ONCE,
@@ -5520,6 +5532,7 @@ struct rtw89_dev {
 	struct rtw89_efuse efuse;
 	struct rtw89_traffic_stats stats;
 	struct rtw89_rfe_data *rfe_data;
+	enum rtw89_custid custid;
 
 	/* ensures exclusive access from mac80211 callbacks */
 	struct mutex mutex;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5ed7eaa18c85..0070c1701e7f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4175,6 +4175,36 @@ static int rtw89_pci_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static
+void rtw89_check_pci_ssid_quirks(struct rtw89_dev *rtwdev,
+				 struct pci_dev *pdev,
+				 const struct rtw89_pci_ssid_quirk *ssid_quirks)
+{
+	int i;
+
+	if (!ssid_quirks)
+		return;
+
+	for (i = 0; i < 200; i++, ssid_quirks++) {
+		if (ssid_quirks->vendor == 0 && ssid_quirks->device == 0)
+			break;
+
+		if (ssid_quirks->vendor != pdev->vendor ||
+		    ssid_quirks->device != pdev->device ||
+		    ssid_quirks->subsystem_vendor != pdev->subsystem_vendor ||
+		    ssid_quirks->subsystem_device != pdev->subsystem_device)
+			continue;
+
+		bitmap_or(rtwdev->quirks, rtwdev->quirks, &ssid_quirks->bitmap,
+			  NUM_OF_RTW89_QUIRKS);
+		rtwdev->custid = ssid_quirks->custid;
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_HCI, "quirks=%*ph custid=%d\n",
+		    (int)sizeof(rtwdev->quirks), rtwdev->quirks, rtwdev->custid);
+}
+
 static int __maybe_unused rtw89_pci_suspend(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
@@ -4349,6 +4379,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
 	rtw89_check_quirks(rtwdev, info->quirks);
+	rtw89_check_pci_ssid_quirks(rtwdev, pdev, pci_info->ssid_quirks);
 
 	SET_IEEE80211_DEV(rtwdev->hw, &pdev->dev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 796f6cd3c965..b68e2d82eea9 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1292,6 +1292,19 @@ struct rtw89_pci_gen_def {
 	void (*disable_eq)(struct rtw89_dev *rtwdev);
 };
 
+#define RTW89_PCI_SSID(v, d, ssv, ssd, cust) \
+	.vendor = v, .device = d, .subsystem_vendor = ssv, .subsystem_device = ssd, \
+	.custid = RTW89_CUSTID_ ##cust
+
+struct rtw89_pci_ssid_quirk {
+	unsigned short vendor;
+	unsigned short device;
+	unsigned short subsystem_vendor;
+	unsigned short subsystem_device;
+	enum rtw89_custid custid;
+	unsigned long bitmap; /* bitmap of rtw89_quirks */
+};
+
 struct rtw89_pci_info {
 	const struct rtw89_pci_gen_def *gen_def;
 	enum mac_ax_bd_trunc_mode txbd_trunc_mode;
@@ -1345,6 +1358,8 @@ struct rtw89_pci_info {
 	void (*recognize_intrs)(struct rtw89_dev *rtwdev,
 				struct rtw89_pci *rtwpci,
 				struct rtw89_pci_isrs *isrs);
+
+	const struct rtw89_pci_ssid_quirk *ssid_quirks;
 };
 
 struct rtw89_pci_tx_data {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index d334924faec8..651cbce1dd7e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -60,6 +60,8 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
 	.recognize_intrs	= rtw89_pci_recognize_intrs,
+
+	.ssid_quirks		= NULL,
 };
 
 static const struct rtw89_driver_info rtw89_8851be_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 9a675e2193bc..701187d69e14 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -58,6 +58,8 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
 	.recognize_intrs	= rtw89_pci_recognize_intrs,
+
+	.ssid_quirks		= NULL,
 };
 
 static const struct rtw89_driver_info rtw89_8852ae_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index d8f9d92ca0fb..a13ea1cce4a7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -60,6 +60,8 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
 	.recognize_intrs	= rtw89_pci_recognize_intrs,
+
+	.ssid_quirks		= NULL,
 };
 
 static const struct rtw89_driver_info rtw89_8852be_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index 702948119646..e4f40c2e287d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -60,6 +60,8 @@ static const struct rtw89_pci_info rtw8852bt_pci_info = {
 	.enable_intr		= rtw89_pci_enable_intr,
 	.disable_intr		= rtw89_pci_disable_intr,
 	.recognize_intrs	= rtw89_pci_recognize_intrs,
+
+	.ssid_quirks		= NULL,
 };
 
 static const struct rtw89_driver_info rtw89_8852bte_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 8aaad7d58c0d..1a46878be96b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -67,6 +67,8 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.enable_intr		= rtw89_pci_enable_intr_v1,
 	.disable_intr		= rtw89_pci_disable_intr_v1,
 	.recognize_intrs	= rtw89_pci_recognize_intrs_v1,
+
+	.ssid_quirks		= NULL,
 };
 
 static const struct dmi_system_id rtw8852c_pci_quirks[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 47f855a7a268..edfb1f220af0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -9,6 +9,12 @@
 #include "reg.h"
 #include "rtw8922a.h"
 
+static const struct rtw89_pci_ssid_quirk rtw8922a_pci_ssid_quirks[] = {
+	{RTW89_PCI_SSID(PCI_VENDOR_ID_REALTEK, 0x8922, 0x10EC, 0xA891, DELL),
+	 .bitmap = BIT(RTW89_QUIRK_THERMAL_PROT_120C)},
+	{},
+};
+
 static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.gen_def		= &rtw89_pci_gen_be,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
@@ -58,6 +64,8 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.enable_intr		= rtw89_pci_enable_intr_v2,
 	.disable_intr		= rtw89_pci_disable_intr_v2,
 	.recognize_intrs	= rtw89_pci_recognize_intrs_v2,
+
+	.ssid_quirks		= rtw8922a_pci_ssid_quirks,
 };
 
 static const struct rtw89_driver_info rtw89_8922ae_info = {
-- 
2.25.1


