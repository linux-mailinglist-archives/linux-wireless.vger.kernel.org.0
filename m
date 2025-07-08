Return-Path: <linux-wireless+bounces-24998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31F4AFD821
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D889817937F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4032246793;
	Tue,  8 Jul 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE7b05Oy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3F245008;
	Tue,  8 Jul 2025 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005875; cv=none; b=aRUT6jYRanLfCVylC1gTE0wEwRBfZkSNjyapjr7FJHLJUel3zmjQRjXv2zJPXZbWMT8V6PGrgQpbokH26i2u/uVpNHbEqNYynzpUMgQzWiNW4dBXq+HyyBF3CUCuE8ZrHNiwTG3TQIjJzeZeOyYz3ImcdXViBWNoahOVTLOUnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005875; c=relaxed/simple;
	bh=3zZFWftG8WgwA2GG8hBIsWQbvdKXrNSKeIbd2g5bWXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO/RpVpxXhqXdunptazPZC6MUlMqmxwV1Df3AG4TgdPf/purwtRvt4laGDg15ijbHr1IvLfbbHxOyotyY++A5yrjiadK2qc6QRl4/ZTMCgDk484WDDROs7DbAXSJpKNGF+KutUJcpV4z8mcHjQ651dcIfMOlR1RLQHn3qxQwCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE7b05Oy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4078406b3a.3;
        Tue, 08 Jul 2025 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005873; x=1752610673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqy93qDm+nsA/Mn8c0ouKxjLutoxP/tuRg1tiXEUTCg=;
        b=FE7b05Oyx4VQBQLKkTMUlY0x529Kq4rWmxvXcbFkM1uLUmncPG5yd0XhtcPb8FnCJa
         mPUhAEm6bCofXT+ZnXPWCGzroKM/S3GQ9z9ITfYlEMtQLeuI+dWsxH1mQjH0ProXkjY3
         /GW+03URsYy/oPULctLwpMhixiKGCnlpYzOy9goBTqItWhn0p/xsqcjAOkMW9EmQ+hv5
         lY1PiT6IP+b4cdSpoOweTHqT+e0i2zofjONJDdfCnaVXvyNR2lagY/v+JGc5looTBbzv
         uTKjLJsFrDG8EpMQGSGeLqMkAgVlfN9zs2frZyhXx04aE4GGSdrvVCT80pX3IzBtzE/o
         9luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005873; x=1752610673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqy93qDm+nsA/Mn8c0ouKxjLutoxP/tuRg1tiXEUTCg=;
        b=Tcme5gQc+3p84lPF790Aoq1vh9a6G51HSPNjVcKegknzj5+67rJjr6y3dqyWGGollg
         eAOd+DVHJIQ9i4vh/VeBqCgVMIUu5KhI1uNq+cVQ47+Gm2bBblqfOslzDGYI5OMuxEtC
         sHL/3q8GyWfPJN4kC0h7OvVz+xDbxk2Tx1omb6DJHYfZHGPgOv2H6nhAGZLzMs18q4Kj
         lcDOhrtlBDSst5FsdsKt9KbNrL/hDmA5823LNUjR6r4+5s/etg+XCocBPlBjglM4akq8
         VMyNwef4jxnBhOCiksNM62PStlwriyQYhAGu4lZZ+Ms2O9dRcFzbFDGq99vCC9mXNUBO
         TXOg==
X-Forwarded-Encrypted: i=1; AJvYcCVmtbklcVcC7Z4uKXOK/T0Rz176IQaKRI0x7Hw6AHS+8J9514AN7DPOBimhaV/0g1rOcjHQWJ7DykTuRjDv@vger.kernel.org, AJvYcCWhhlU8R8238T8p+ckTyEnsQ2+NJ3PG+asz/2Mu0OfFbRPp73lA75LO5ERxrNvB4NvOltFhuFOb9ewHtA==@vger.kernel.org, AJvYcCX9mY8D96lTSPyjcsrr1jaWvivTaHq5qrTMypD7MZcdd4xUwSEAGUKlkzzLGf6Stf+UcYK0G/oqDvWs@vger.kernel.org
X-Gm-Message-State: AOJu0YzPN78pF6kS0y/bY8/slCfkEa5Hfm2aqadElmlm2czVlGP14421
	AJr577OeCfF5XuYRXKwJTJrlX3BPIVsWZIADwMXkwlghLDOEpgMpPybmBBpIwmpzxyE=
X-Gm-Gg: ASbGnctNPymzSr7zH/N9qOMqNR1c7V9GwAsxl1PbhXt7jf9Pz2LYB/3zWbw+b8IqNnc
	P6/CNXvwNVkKThUVtNKG9rLSOCM53HsgKk4855iXuikNB+k/DfqPel9Na/4VT7t+zgjYhEUScnE
	a5MpRXKiWe8HUz5q5lcq9N3KC1PRqKdrZUKjlyjdif6aVMdjCW9if5vKgZnLK0mtAjkDX1fS7Kr
	ZNR5yI5uox35YOjUu+rFYSfY1lGOUUXdKVF1xuKPrKfWSDqHVZJznDSQnxqI7i8eDRztZ8bn2p9
	fARGeK6YpVBLTNaUVkonsC03r2dmkYfgRkJKi9ZrHXI=
X-Google-Smtp-Source: AGHT+IGYqOdrg8modWX5yq3jcxC0oSBAHrTIGU34hvqP9V4WtFdhu3+iwwxBh0+kOmo6ZEjYHZYiig==
X-Received: by 2002:a05:6a00:3d53:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-74e4ac18359mr995807b3a.19.1752005872927;
        Tue, 08 Jul 2025 13:17:52 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv2 wireless-next 4/7] wifi: rt2800: move 2x00soc to 2800soc
Date: Tue,  8 Jul 2025 13:17:42 -0700
Message-ID: <20250708201745.5900-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708201745.5900-1-rosenp@gmail.com>
References: <20250708201745.5900-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver was written with multiple SOC platforms in mind. However
since Ralink was aquired by Mediatek, it only effectively got used by
older platforms. As such, we can slim down the driver slightly by moving
all of rt2x00soc to rt2800soc in order to benefit from inlining.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig    |   5 -
 drivers/net/wireless/ralink/rt2x00/Makefile   |   1 -
 .../net/wireless/ralink/rt2x00/rt2800soc.c    | 119 +++++++++++++-
 .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 151 ------------------
 .../net/wireless/ralink/rt2x00/rt2x00soc.h    |  29 ----
 5 files changed, 118 insertions(+), 187 deletions(-)
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index 3a32ceead54f..28530c1fac5c 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -203,7 +203,6 @@ endif
 config RT2800SOC
 	tristate "Ralink WiSoC support"
 	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
-	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
 	select RT2X00_LIB_FIRMWARE
@@ -231,10 +230,6 @@ config RT2X00_LIB_PCI
 	tristate
 	select RT2X00_LIB
 
-config RT2X00_LIB_SOC
-	tristate
-	select RT2X00_LIB
-
 config RT2X00_LIB_USB
 	tristate
 	select RT2X00_LIB
diff --git a/drivers/net/wireless/ralink/rt2x00/Makefile b/drivers/net/wireless/ralink/rt2x00/Makefile
index de030ebcdf6e..48d84d243606 100644
--- a/drivers/net/wireless/ralink/rt2x00/Makefile
+++ b/drivers/net/wireless/ralink/rt2x00/Makefile
@@ -12,7 +12,6 @@ rt2x00lib-$(CONFIG_RT2X00_LIB_LEDS)	+= rt2x00leds.o
 obj-$(CONFIG_RT2X00_LIB)		+= rt2x00lib.o
 obj-$(CONFIG_RT2X00_LIB_MMIO)		+= rt2x00mmio.o
 obj-$(CONFIG_RT2X00_LIB_PCI)		+= rt2x00pci.o
-obj-$(CONFIG_RT2X00_LIB_SOC)		+= rt2x00soc.o
 obj-$(CONFIG_RT2X00_LIB_USB)		+= rt2x00usb.o
 obj-$(CONFIG_RT2800_LIB)		+= rt2800lib.o
 obj-$(CONFIG_RT2800_LIB_MMIO)		+= rt2800mmio.o
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index db8d01f0cdc3..a19906c35d0a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -22,7 +22,6 @@
 
 #include "rt2x00.h"
 #include "rt2x00mmio.h"
-#include "rt2x00soc.h"
 #include "rt2800.h"
 #include "rt2800lib.h"
 #include "rt2800mmio.h"
@@ -131,6 +130,124 @@ static int rt2800soc_write_firmware(struct rt2x00_dev *rt2x00dev,
 	return 0;
 }
 
+static void rt2x00soc_free_reg(struct rt2x00_dev *rt2x00dev)
+{
+	kfree(rt2x00dev->rf);
+	rt2x00dev->rf = NULL;
+
+	kfree(rt2x00dev->eeprom);
+	rt2x00dev->eeprom = NULL;
+
+	iounmap(rt2x00dev->csr.base);
+}
+
+static int rt2x00soc_alloc_reg(struct rt2x00_dev *rt2x00dev)
+{
+	struct platform_device *pdev = to_platform_device(rt2x00dev->dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	rt2x00dev->csr.base = ioremap(res->start, resource_size(res));
+	if (!rt2x00dev->csr.base)
+		return -ENOMEM;
+
+	rt2x00dev->eeprom = kzalloc(rt2x00dev->ops->eeprom_size, GFP_KERNEL);
+	if (!rt2x00dev->eeprom)
+		goto exit;
+
+	rt2x00dev->rf = kzalloc(rt2x00dev->ops->rf_size, GFP_KERNEL);
+	if (!rt2x00dev->rf)
+		goto exit;
+
+	return 0;
+
+exit:
+	rt2x00_probe_err("Failed to allocate registers\n");
+	rt2x00soc_free_reg(rt2x00dev);
+
+	return -ENOMEM;
+}
+
+static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
+{
+	struct ieee80211_hw *hw;
+	struct rt2x00_dev *rt2x00dev;
+	int retval;
+
+	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
+	if (!hw) {
+		rt2x00_probe_err("Failed to allocate hardware\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, hw);
+
+	rt2x00dev = hw->priv;
+	rt2x00dev->dev = &pdev->dev;
+	rt2x00dev->ops = ops;
+	rt2x00dev->hw = hw;
+	rt2x00dev->irq = platform_get_irq(pdev, 0);
+	rt2x00dev->name = pdev->dev.driver->name;
+
+	rt2x00dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(rt2x00dev->clk))
+		rt2x00dev->clk = NULL;
+
+	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
+
+	retval = rt2x00soc_alloc_reg(rt2x00dev);
+	if (retval)
+		goto exit_free_device;
+
+	retval = rt2x00lib_probe_dev(rt2x00dev);
+	if (retval)
+		goto exit_free_reg;
+
+	return 0;
+
+exit_free_reg:
+	rt2x00soc_free_reg(rt2x00dev);
+
+exit_free_device:
+	ieee80211_free_hw(hw);
+
+	return retval;
+}
+
+static void rt2x00soc_remove(struct platform_device *pdev)
+{
+	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
+	struct rt2x00_dev *rt2x00dev = hw->priv;
+
+	/*
+	 * Free all allocated data.
+	 */
+	rt2x00lib_remove_dev(rt2x00dev);
+	rt2x00soc_free_reg(rt2x00dev);
+	ieee80211_free_hw(hw);
+}
+
+#ifdef CONFIG_PM
+static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
+	struct rt2x00_dev *rt2x00dev = hw->priv;
+
+	return rt2x00lib_suspend(rt2x00dev);
+}
+
+static int rt2x00soc_resume(struct platform_device *pdev)
+{
+	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
+	struct rt2x00_dev *rt2x00dev = hw->priv;
+
+	return rt2x00lib_resume(rt2x00dev);
+}
+#endif /* CONFIG_PM */
+
 static const struct ieee80211_ops rt2800soc_mac80211_ops = {
 	.add_chanctx = ieee80211_emulate_add_chanctx,
 	.remove_chanctx = ieee80211_emulate_remove_chanctx,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
deleted file mode 100644
index f7f3a2340c39..000000000000
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
+++ /dev/null
@@ -1,151 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
-	Copyright (C) 2004 - 2009 Ivo van Doorn <IvDoorn@gmail.com>
-	Copyright (C) 2004 - 2009 Felix Fietkau <nbd@openwrt.org>
-	<http://rt2x00.serialmonkey.com>
-
- */
-
-/*
-	Module: rt2x00soc
-	Abstract: rt2x00 generic soc device routines.
- */
-
-#include <linux/bug.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-#include "rt2x00.h"
-#include "rt2x00soc.h"
-
-static void rt2x00soc_free_reg(struct rt2x00_dev *rt2x00dev)
-{
-	kfree(rt2x00dev->rf);
-	rt2x00dev->rf = NULL;
-
-	kfree(rt2x00dev->eeprom);
-	rt2x00dev->eeprom = NULL;
-
-	iounmap(rt2x00dev->csr.base);
-}
-
-static int rt2x00soc_alloc_reg(struct rt2x00_dev *rt2x00dev)
-{
-	struct platform_device *pdev = to_platform_device(rt2x00dev->dev);
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	rt2x00dev->csr.base = ioremap(res->start, resource_size(res));
-	if (!rt2x00dev->csr.base)
-		return -ENOMEM;
-
-	rt2x00dev->eeprom = kzalloc(rt2x00dev->ops->eeprom_size, GFP_KERNEL);
-	if (!rt2x00dev->eeprom)
-		goto exit;
-
-	rt2x00dev->rf = kzalloc(rt2x00dev->ops->rf_size, GFP_KERNEL);
-	if (!rt2x00dev->rf)
-		goto exit;
-
-	return 0;
-
-exit:
-	rt2x00_probe_err("Failed to allocate registers\n");
-	rt2x00soc_free_reg(rt2x00dev);
-
-	return -ENOMEM;
-}
-
-int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
-{
-	struct ieee80211_hw *hw;
-	struct rt2x00_dev *rt2x00dev;
-	int retval;
-
-	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
-	if (!hw) {
-		rt2x00_probe_err("Failed to allocate hardware\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, hw);
-
-	rt2x00dev = hw->priv;
-	rt2x00dev->dev = &pdev->dev;
-	rt2x00dev->ops = ops;
-	rt2x00dev->hw = hw;
-	rt2x00dev->irq = platform_get_irq(pdev, 0);
-	rt2x00dev->name = pdev->dev.driver->name;
-
-	rt2x00dev->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(rt2x00dev->clk))
-		rt2x00dev->clk = NULL;
-
-	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
-
-	retval = rt2x00soc_alloc_reg(rt2x00dev);
-	if (retval)
-		goto exit_free_device;
-
-	retval = rt2x00lib_probe_dev(rt2x00dev);
-	if (retval)
-		goto exit_free_reg;
-
-	return 0;
-
-exit_free_reg:
-	rt2x00soc_free_reg(rt2x00dev);
-
-exit_free_device:
-	ieee80211_free_hw(hw);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(rt2x00soc_probe);
-
-void rt2x00soc_remove(struct platform_device *pdev)
-{
-	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
-	struct rt2x00_dev *rt2x00dev = hw->priv;
-
-	/*
-	 * Free all allocated data.
-	 */
-	rt2x00lib_remove_dev(rt2x00dev);
-	rt2x00soc_free_reg(rt2x00dev);
-	ieee80211_free_hw(hw);
-}
-EXPORT_SYMBOL_GPL(rt2x00soc_remove);
-
-#ifdef CONFIG_PM
-int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
-	struct rt2x00_dev *rt2x00dev = hw->priv;
-
-	return rt2x00lib_suspend(rt2x00dev);
-}
-EXPORT_SYMBOL_GPL(rt2x00soc_suspend);
-
-int rt2x00soc_resume(struct platform_device *pdev)
-{
-	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
-	struct rt2x00_dev *rt2x00dev = hw->priv;
-
-	return rt2x00lib_resume(rt2x00dev);
-}
-EXPORT_SYMBOL_GPL(rt2x00soc_resume);
-#endif /* CONFIG_PM */
-
-/*
- * rt2x00soc module information.
- */
-MODULE_AUTHOR(DRV_PROJECT);
-MODULE_VERSION(DRV_VERSION);
-MODULE_DESCRIPTION("rt2x00 soc library");
-MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
deleted file mode 100644
index d6226b8a10e0..000000000000
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
-	Copyright (C) 2004 - 2009 Ivo van Doorn <IvDoorn@gmail.com>
-	<http://rt2x00.serialmonkey.com>
-
- */
-
-/*
-	Module: rt2x00soc
-	Abstract: Data structures for the rt2x00soc module.
- */
-
-#ifndef RT2X00SOC_H
-#define RT2X00SOC_H
-
-/*
- * SoC driver handlers.
- */
-int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops);
-void rt2x00soc_remove(struct platform_device *pdev);
-#ifdef CONFIG_PM
-int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state);
-int rt2x00soc_resume(struct platform_device *pdev);
-#else
-#define rt2x00soc_suspend	NULL
-#define rt2x00soc_resume	NULL
-#endif /* CONFIG_PM */
-
-#endif /* RT2X00SOC_H */
-- 
2.50.0


