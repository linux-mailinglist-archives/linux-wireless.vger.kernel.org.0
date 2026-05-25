Return-Path: <linux-wireless+bounces-36869-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFbxKD0OFGpeJQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36869-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:54:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E325C82C5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90A1E30243BD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BFF3E5A31;
	Mon, 25 May 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FlfskR6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECE3E51C1;
	Mon, 25 May 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699139; cv=none; b=IwnO1g4HvPoRP331L1hU9dyHY0aDUXKqDP0oiS3SzpZeR/N3Tu1r1Aqz/k3umatXT9BhuPuitbiLYRi+fgU/Ax27m642BdkuQNLsZijxXR5cm6iEB+72IbGQLMAf1Dvnn7p/gtdC7s8ZR166SS2mzD3diuUCSNIWRWy2R20tffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699139; c=relaxed/simple;
	bh=+OzfYSj/vK6/Vzp9HRymj6uSsj/UdBSZSdjiDFdqL10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptDvMMNP1FaLmx9mXvjnIXyZWnnJq0nJzX/LgyQ7a3uCsmsE8CgEUu2FlJiwEKuPaLxK5bejMehq1X6+FoaQEIp6L6jDGfRI9rGyDUGlmQwhahR4MLQZdNqfTRJlDgO6/24co3n+otwFdi5s0uLzovEb9EQzO4VetsQtvpDV8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FlfskR6L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P8qAOf9936540, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779699130; bh=AXZGfK6fi8WlRNSLHp4WjoVuYiE/1cQDutno506K25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FlfskR6LMxBslQlX33mTW2dRfYvtKgvMk0hzIBkg6KCf/nlDgfHjVY2ndCHiUjKy+
	 xnnP4jmZ8jWud5gQX4yd35e8SD9c+yKW/ejbH7if2CNaWRguy6OqUC2Tso88W+MGFz
	 PSRYIkKhz9QR1FzZXsw50DaBKkdcLuOi2F72PD9Fld9uzx0hgifdqOSuw03RvGm2vX
	 GDL2rdWjzo5dVEphF71kYhDwRJpTfQBjr2RE38VDruPoR4W3r98B9Mt05GvXRUu+Ke
	 WowVQOdbcn3DwTTw8Kwf/fRoabR5PYDKX7fHKssweFH1jd9tq75+4T4hfGnq0KjJXf
	 FXmM8nnn+qD7A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P8qAOf9936540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 16:52:10 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 16:52:10 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 16:52:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <driver-core@lists.linux.dev>, <johannes@sipsolutions.net>,
	<wenjie.tsai@realtek.com>, <mh_chen@realtek.com>,
	<charlesl@valvesoftware.com>, <sabae@valvesoftware.com>
Subject: [PATCH v2 rtw-next 1/2] wifi: rtw89: add dev_id_quirks to driver_info for per-device quirk control
Date: Mon, 25 May 2026 16:51:47 +0800
Message-ID: <20260525085148.35180-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260525085148.35180-1-pkshih@realtek.com>
References: <20260525085148.35180-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-36869-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 86E325C82C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johnson Tsai <wenjie.tsai@realtek.com>

Add a dev_id_quirks field to rtw89_driver_info so that per-device
(VID/PID) quirks can be expressed independently of chip-level
default_quirks. Apply the bitmap in rtw89_alloc_ieee80211_hw() so
both USB and PCI probes benefit automatically.

All existing driver_info structs initialize dev_id_quirks to 0;
no behavior change.

Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c       | 9 +++++++--
 drivers/net/wireless/realtek/rtw89/core.h       | 4 ++--
 drivers/net/wireless/realtek/rtw89/pci.c        | 3 +--
 drivers/net/wireless/realtek/rtw89/rtw8851be.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852au.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c  | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8922au.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922de.c  | 2 ++
 drivers/net/wireless/realtek/rtw89/usb.c        | 3 +--
 16 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c1df3e2ba11e..68dad6090f87 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -7532,9 +7532,11 @@ EXPORT_SYMBOL(rtw89_core_unregister);
 
 struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 					   u32 bus_data_size,
-					   const struct rtw89_chip_info *chip,
-					   const struct rtw89_chip_variant *variant)
+					   const struct rtw89_driver_info *info)
 {
+	const unsigned long *dev_id_quirks = &info->dev_id_quirks;
+	const struct rtw89_chip_variant *variant = info->variant;
+	const struct rtw89_chip_info *chip = info->chip;
 	struct rtw89_fw_info early_fw = {};
 	const struct firmware *firmware;
 	struct ieee80211_hw *hw;
@@ -7600,6 +7602,9 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	rtwdev->fw.fw_format = fw_format;
 	rtwdev->support_mlo = support_mlo;
 
+	bitmap_or(rtwdev->quirks, rtwdev->quirks, dev_id_quirks,
+		  NUM_OF_RTW89_QUIRKS);
+
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "probe driver %s chanctx\n",
 		    no_chanctx ? "without" : "with");
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "probe driver %s MLO cap\n",
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 27d9a916d58c..e687216da5b6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4800,6 +4800,7 @@ struct rtw89_driver_info {
 	const struct rtw89_chip_info *chip;
 	const struct rtw89_chip_variant *variant;
 	const struct dmi_system_id *quirks;
+	unsigned long dev_id_quirks; /* bitmap of rtw89_quirks */
 	union rtw89_bus_info bus;
 };
 
@@ -8126,8 +8127,7 @@ int rtw89_core_register(struct rtw89_dev *rtwdev);
 void rtw89_core_unregister(struct rtw89_dev *rtwdev);
 struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 					   u32 bus_data_size,
-					   const struct rtw89_chip_info *chip,
-					   const struct rtw89_chip_variant *variant);
+					   const struct rtw89_driver_info *info);
 void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev);
 u8 rtw89_acquire_mac_id(struct rtw89_dev *rtwdev);
 void rtw89_release_mac_id(struct rtw89_dev *rtwdev, u8 mac_id);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index fe1152c560bd..102bae488180 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4772,8 +4772,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	info = (const struct rtw89_driver_info *)id->driver_data;
 
 	rtwdev = rtw89_alloc_ieee80211_hw(&pdev->dev,
-					  sizeof(struct rtw89_pci),
-					  info->chip, info->variant);
+					  sizeof(struct rtw89_pci), info);
 	if (!rtwdev) {
 		dev_err(&pdev->dev, "failed to allocate hw\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index ce59ac9f56ba..640672eb0d26 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -73,6 +73,7 @@ static const struct rtw89_driver_info rtw89_8851be_info = {
 	.chip = &rtw8851b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8851b_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 6a8d31544314..e7933174398e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -31,6 +31,7 @@ static const struct rtw89_driver_info rtw89_8851bu_info = {
 	.chip = &rtw8851b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.usb = &rtw8851b_usb_info,
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 9e05e831569d..64306cdc1ee4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -71,6 +71,7 @@ static const struct rtw89_driver_info rtw89_8852ae_info = {
 	.chip = &rtw8852a_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8852a_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
index 4cced4619b7d..29b7f7769370 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
@@ -33,6 +33,7 @@ static const struct rtw89_driver_info rtw89_8852au_info = {
 	.chip = &rtw8852a_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.usb = &rtw8852a_usb_info,
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 12db0d0be547..5bc0a6a99d1d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -73,6 +73,7 @@ static const struct rtw89_driver_info rtw89_8852be_info = {
 	.chip = &rtw8852b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8852b_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index 8c995aa95325..49a72ca835ac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -79,6 +79,7 @@ static const struct rtw89_driver_info rtw89_8852bte_info = {
 	.chip = &rtw8852bt_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8852bt_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 37111fed276f..308d3d570ff3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -31,6 +31,7 @@ static const struct rtw89_driver_info rtw89_8852bu_info = {
 	.chip = &rtw8852b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.usb = &rtw8852b_usb_info,
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 150fed189414..3c64c0539205 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -102,6 +102,7 @@ static const struct rtw89_driver_info rtw89_8852ce_info = {
 	.chip = &rtw8852c_chip_info,
 	.variant = NULL,
 	.quirks = rtw8852c_pci_quirks,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8852c_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 790fd1dec66d..8f89f9a31455 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -33,6 +33,7 @@ static const struct rtw89_driver_info rtw89_8852cu_info = {
 	.chip = &rtw8852c_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.usb = &rtw8852c_usb_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 90c62b757c57..5527a8db393b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -77,6 +77,7 @@ static const struct rtw89_driver_info rtw89_8922ae_info = {
 	.chip = &rtw8922a_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8922a_pci_info,
 	},
@@ -86,6 +87,7 @@ static const struct rtw89_driver_info rtw89_8922ae_vs_info = {
 	.chip = &rtw8922a_chip_info,
 	.variant = &rtw8922ae_vs_variant,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8922a_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922au.c b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
index 347bde171391..2b81de501d62 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922au.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922au.c
@@ -32,6 +32,7 @@ static const struct rtw89_driver_info rtw89_8922au_info = {
 	.chip = &rtw8922a_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.usb = &rtw8922a_usb_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922de.c b/drivers/net/wireless/realtek/rtw89/rtw8922de.c
index f144e7fc76de..a1a81c338be3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922de.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922de.c
@@ -73,6 +73,7 @@ static const struct rtw89_driver_info rtw89_8922de_vs_info = {
 	.chip = &rtw8922d_chip_info,
 	.variant = &rtw8922de_vs_variant,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8922d_pci_info,
 	},
@@ -82,6 +83,7 @@ static const struct rtw89_driver_info rtw89_8922de_info = {
 	.chip = &rtw8922d_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.dev_id_quirks = 0,
 	.bus = {
 		.pci = &rtw8922d_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index c6d55e669776..88d7ec200837 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -1070,8 +1070,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
 	info = (const struct rtw89_driver_info *)id->driver_info;
 
 	rtwdev = rtw89_alloc_ieee80211_hw(&intf->dev,
-					  sizeof(struct rtw89_usb),
-					  info->chip, info->variant);
+					  sizeof(struct rtw89_usb), info);
 	if (!rtwdev) {
 		dev_err(&intf->dev, "failed to allocate hw\n");
 		return -ENOMEM;
-- 
2.25.1


