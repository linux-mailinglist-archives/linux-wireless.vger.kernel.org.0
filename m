Return-Path: <linux-wireless+bounces-10865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600E5945A03
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 10:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A61AB23806
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B171C2313;
	Fri,  2 Aug 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TgCMtJlu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E31BF33B
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587655; cv=none; b=nr+mSJbeGYEiwHqBU5UYx6q7JowXqmPeOp0JUWQmcb0eI5fKxso9IAxCGByTrBap5zL3M8bMWe91eodcK2SgkHOPDefxCC88yLIHVP5p7SepelnmrhCmBy3nyaLybl11ij3vXAq0v+nkPKbHchbfA0cL+2yH8gmJNZYP6SvNqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587655; c=relaxed/simple;
	bh=nSNW1huRVij5DjSNP5NR1ecaY6V33MkAfoxm89dToTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVAwJplwHLZ1eTnNXwJh82X2FoxHN3RHIpf3jQFWFScl1v2UoB4eNhTRebKbEOZnogqR52yxVF1gUbqujLBI5e40aU9h3j5+/Ap7Y2/KZCDvMvtB2Vvw69nWaGefJBz8bL9XmaqXuxHxJSN18T3lJlT0WXDPVQ3oeKSQQuSv08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TgCMtJlu; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db23a608eeso5120368b6e.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722587652; x=1723192452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CylTBVkGz/jVEBheVmXOhtkAwVGTAtTvqg8xZV0ycY=;
        b=TgCMtJluRGnFGIfItG/MHo9wf4f/BR1fOEhT5IpWtpzYRgOCSM5RdD09a+H4cTlpx/
         s5kj6Xtqej/L4fNB0399zbHMlzjN9YIRiSqc+VlGARJKaGycRU010dWdQmrquuQJs4eV
         jpzgZdpQ/M37EXpYDVtk+qN+Mm7BKTDqzmgdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722587652; x=1723192452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CylTBVkGz/jVEBheVmXOhtkAwVGTAtTvqg8xZV0ycY=;
        b=BgAe1G7I/V1ETCjxKlwmKIeQvGJI9WKMZPLPJjcPdiksyimNBydqLOAi06gWe4wCoU
         OfrKs/tJ4DbzRPSRxpAEEeAKYdUKz8qz7VgFfMaxdE8HdEKM0CBr4SHuHbcQs7r/yG+C
         bRQj/I/3qdAZQPEZgcIX2wP4W19fSdRqFVcJJl0ZG207t5JKHiyXqroXPaPLqfIOL4gJ
         LvPpurukhs0K30k2isnQ5xiiyDm060vtpuLLATIqTU9KJvZZGUrlDpbv6wrq6SegQBB8
         CCC1X52AAibgW035lxdKFW+reFIUQyOw8imVypQJ3w44cBt4VJ2ErwCEgdBvoHQ6iHug
         V4Qw==
X-Gm-Message-State: AOJu0YxL52l551yMONaPhCjcEJHTM5W3pHSf7bLWArRRiqfXzf5EvWwG
	zUrH5BiYC9jsZhASJhVC5TE9EamnqoVzovN+bH7+CuZXPWHOvUAFneqzmNrvPw==
X-Google-Smtp-Source: AGHT+IE8qcWjaWHDYYllQFdj+EfQl19t3wn0P1zm/ZiCHOduUFp0MyI4JNPC8RKh9Mpd8Jffhp8spQ==
X-Received: by 2002:a05:6870:d109:b0:261:1deb:f0ee with SMTP id 586e51a60fabf-26891b0ef9amr3605480fac.13.1722587652016;
        Fri, 02 Aug 2024 01:34:12 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc47csm946155b3a.162.2024.08.02.01.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2024 01:34:11 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Ondrej Jirman <megi@xff.cz>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT] wifi: brcmfmac: Add optional lpo clock enable support
Date: Fri,  2 Aug 2024 10:34:00 +0200
Message-Id: <20240802083400.166753-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacobe Zang <jacobe.zang@wesion.com>

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
[arend: handle -EPROBE_DEFER scenario]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hi Jacobe,

Here the patch I tinkered up last night. Please verify. You can
probably test the error handling by adding:

clk = PTR_ERR(-EPROBE_DEFER);

Regards,
Arend 
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +++
 .../broadcom/brcm80211/brcmfmac/common.c      |  6 ++++-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 27 +++++++++++++------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++++---
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 +++
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 18 ++++++++-----
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 +++
 7 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d35262335eaf..af31cfac0757 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -951,6 +951,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		ret = -ENODEV;
 		goto out;
 	}
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
+		goto out;
+	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
 out:
 	if (ret)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873..6c5d26f9b766 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,8 +561,12 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
 		brcmf_acpi_probe(dev, bus_type, settings);
+		i = brcmf_of_probe(dev, bus_type, settings);
+		if (i < 0) {
+			kfree(settings);
+			settings = ERR_PTR(i);
+		}
 	}
 	return settings;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f65756105..a04dfdce4960 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,18 +66,22 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
 	struct of_phandle_args oirq;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
 	u32 irqf;
 	u32 val;
 
+	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
+		return 0;
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -106,7 +111,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -114,8 +119,13 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (!IS_ERR_OR_NULL(clk)) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		clk_set_rate(clk, 32768);
+	} else if (PTR_ERR_OR_ZERO(clk) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	}
 
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
@@ -124,23 +134,24 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	of_get_mac_address(np, settings->mac);
 
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+		return 0;
 
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
 	if (of_irq_parse_one(np, 0, &oirq))
-		return;
+		return 0;
 
 	irq = irq_create_of_mapping(&oirq);
 	if (!irq) {
 		brcmf_err("interrupt could not be mapped\n");
-		return;
+		return 0;
 	}
 	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
 	sdio->oob_irq_flags = irqf;
+	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337..ae124c73fc3b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,11 +3,12 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings);
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-			   struct brcmf_mp_device *settings)
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+			  struct brcmf_mp_device *settings)
 {
+	return 0;
 }
 #endif /* CONFIG_OF */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e9..190e8990618c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2452,6 +2452,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1461dc453ac2..2dbc08c36a09 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_buscore_ops = {
 	.write32 = brcmf_sdio_buscore_write32,
 };
 
-static bool
+static int
 brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 {
 	struct brcmf_sdio_dev *sdiodev;
@@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	u32 reg_val;
 	u32 drivestrength;
 	u32 enum_base;
+	int ret = -EBADE;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
@@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 						   BRCMF_BUSTYPE_SDIO,
 						   bus->ci->chip,
 						   bus->ci->chiprev);
-	if (!sdiodev->settings) {
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
 		brcmf_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
 		goto fail;
 	}
 	/* platform specific configuration:
@@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	/* allocate header buffer */
 	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
 	if (!bus->hdrbuf)
-		return false;
+		return -ENOMEM;
 	/* Locate an appropriately-aligned portion of hdrbuf */
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
@@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	if (bus->poll)
 		bus->pollrate = 1;
 
-	return true;
+	return 0;
 
 fail:
 	sdio_release_host(sdiodev->func1);
-	return false;
+	return ret;
 }
 
 static int
@@ -4446,6 +4448,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	struct brcmf_sdio *bus;
 	struct workqueue_struct *wq;
 	struct brcmf_fw_request *fwreq;
+	int probe_attach_result;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -4474,7 +4477,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	probe_attach_result = brcmf_sdio_probe_attach(bus);
+	if (probe_attach_result < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,6 +4550,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
+	if (probe_attach_result < 0)
+		return ERR_PTR(probe_attach_result);
 	return NULL;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 8afbf529c745..2821c27f317e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.32.0


