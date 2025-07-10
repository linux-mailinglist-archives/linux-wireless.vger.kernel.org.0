Return-Path: <linux-wireless+bounces-25225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11CB00CC3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DD33A64BC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E1327185;
	Thu, 10 Jul 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itfVw+oO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADA2FE31D;
	Thu, 10 Jul 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178109; cv=none; b=kPMQMIJBjeROMJe97RCJiXh4aLdzVUf3YFWexmkNHNzDHIaROvzhql63vkvFoODv9Yj/+qsWh7JYfhoMHtlj2qbEOifD040wSp172T0SkaDOogf0HznesGp3jVkXcgsYqEBLYOMSyurjR1rOw9utYPkYQT5HVBW4RqLwl08j984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178109; c=relaxed/simple;
	bh=Sfd9DbdjqhyGrgcgUjyRp5yUfhYRHNyovJZUGbCtC7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXDwUD9CNxbdEbIxE73jDjrpcrm6Fi8THN488XUsebMC+9YrTygdGv/4kuSCnRn14R3EWU3TxnZ5djcFcy62/bSYIIOI5SwcSqnhGqvW07itbiYr2H1Fd4o5tGi20jGU230SLBfG23rzawLZ5qaq8w5Z/rC/wyF2aWGSYFYTZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itfVw+oO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1878724b3a.2;
        Thu, 10 Jul 2025 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178107; x=1752782907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SucvbX7V2pEE0KBr9pkRROL7F7h/88OMsOWVW0teiP4=;
        b=itfVw+oOD5+aoU6VfrKg6Pd1YXSknUVbmUUzClB9ri3QJYkPyF2qieOIFVgaZo5Y0i
         0KMj67YhlOGR4wd8k27QV69rpTmW+0P/ZFzIGpa8RHsoSBNmfZIwQ2vpYimLxkmUCV4v
         1KbpD1qpQIuT+39r+IXzTGZZPJP00/Kmmvbo2PM8QUYdZ9VNfGAtfZw2Kj6LJMeqP9Ez
         yNJ3HgoN34cW8EwcnOJ4sFNYsrXYx3dcAk/qescyFsfoylRGdAxdw+twNFwY+RpyfYiw
         87EibIcMUHrSAchJlYbQFNyKHV+4xK1338wl8/zn8Fv4MI90x173lJk0KBbt0V2fl9RX
         WlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178107; x=1752782907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SucvbX7V2pEE0KBr9pkRROL7F7h/88OMsOWVW0teiP4=;
        b=eG3pjxMFFZR6OlMyr3/rNjNPThkQfIhMa8R/iV6DZvCWiuAJG9EsKrxFfR9WYnmCo/
         UHzqa6AtVFBvaVrbZsd9kfjV7l7MLKrF02g12/YzcUDoCi8sujzMq5oRBEAsfwYtEtpS
         d8jyl8uJ8M0JH0gSg1rTYXkdy0UMcC/4Iua9u3LcCCYHJvONOgRMAxgvOcT/lYha9CS4
         nPVY0OZzMuJgoRNyoare3JISFOl0yrvzcd4G9xyBfrFhN2cACH2OjAepEtG9yhAHkSXI
         il2iEuF0+GB5ERi0ArEn6fQ/d0ED/erj9mvxnZZJ0Wqcvh6ZxxW5FSjn5PgefLUrJ7GO
         XmRw==
X-Forwarded-Encrypted: i=1; AJvYcCVmexx9xlzRswVRWPenjWTIHZ09NhtSYn4yVCTm6beFwVE3UGHsp3zS0VHTnNoUEmDnT1BuAKdfzDMsOQay@vger.kernel.org, AJvYcCWaehOSWoXaag5FHiHor3hjyPEjzh6B6YbB2hVTksMMaTP6A5Vnqo5fJ36nv8WXv5vSIlSWf7ibLGUY@vger.kernel.org, AJvYcCX652/TIF66oJ1y0d3yMd5Js9BwHk5EHVwRFdUk3VZduBzt4CyxzyqguWToiYR+9FdevunlDMVOmjOfMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7OIrnAwI/8HI5RcheFlif54tSoxH186ESBUVEX2dqGyHn1S86
	u2LeSdjvPaK0EXq+g1b8Zn4Sa5QT+vDKqGxFEBRjp8n2GfwqgQ+Ya/BhyZ9d9atQ
X-Gm-Gg: ASbGnctoYpu4Iy1YitYxo3MEgyPsa46U7D608wQ1Co/qnqoedrGlI8Tn/FDBa/veeZs
	yw4RVXaiwCIPFHdsU8fsp9MrH0ehjq8mlJpQDncTYg/No8ag+C6xnjKuhST32QEyAWBv+dVhKJw
	xiy8a3VpCuh9Ym4xgioMsAwiixB43inmGLyqwJ0sXMyZrJLzICw5zvN7nX8M13PCeqN6h3Asa+F
	XTFvgG48OxioUDgNYnIUNurw5CD10SVRjn43ZNQonOljHEEjPzRaJx61iMwzm+KxEgMSLCEbA31
	JdjhWRQgfHUOs8+lkk4Rj3POM05RDw3xYw3cG3ym2SA=
X-Google-Smtp-Source: AGHT+IGzltVPG6v737yVxcn1OOATgggO1wpQnPVQueIdozqaVYvOu4BC08JXO33LVZziHbIXS7BKzw==
X-Received: by 2002:a05:6a21:6da4:b0:21a:da01:e0cf with SMTP id adf61e73a8af0-23137e8e69bmr556789637.22.1752178107010;
        Thu, 10 Jul 2025 13:08:27 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:26 -0700 (PDT)
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
Subject: [PATCHv3 wireless-next 4/7] wifi: rt2800: move 2x00soc to 2800soc
Date: Thu, 10 Jul 2025 13:08:17 -0700
Message-ID: <20250710200820.262295-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710200820.262295-1-rosenp@gmail.com>
References: <20250710200820.262295-1-rosenp@gmail.com>
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
index a0dc9a751234..4d98b7723c56 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -203,7 +203,6 @@ endif
 config RT2800SOC
 	tristate "Ralink WiSoC support"
 	depends on OF && (SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST)
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


