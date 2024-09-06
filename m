Return-Path: <linux-wireless+bounces-12617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80E96FC60
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 21:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7C7B24A97
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005EF1D6DA0;
	Fri,  6 Sep 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh4iJLRs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2931B85E6
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652446; cv=none; b=CiQ/+eGu99MjF9C3EIhrQClwPpva4aXa33IRi/W/rgZcnAEQdI1p7XQ8cHBndoq7b1oioU162fXsqjs2jpKysnBjMkvuaCbEmsZgRWniTmyVKSZ9yY7Zee6ldYU01vg0ymmp2DdqQdb2zlRsQ+W3R2Uz/9hgVDVx2VLXHESwuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652446; c=relaxed/simple;
	bh=Wz9L6wgxbBQmjzHr4EFSsPeGD25o9g37rvuModMahIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3fvnQPnITyxWlAQwz9biYNI8Z22vvz/f0gEMErdKTPnhgdhEAQ04jTyyYerlzdZJhb5gtl3C/RSA6s2FljExbTsKEKC5Plo4bWPERlFHploSigoz5I/Fy+G6F9qUSF8JmMRSE5iZlRuW3jF2Z63ML2GVcMT4Byi3O3tDIxxQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh4iJLRs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso1947283a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2024 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652445; x=1726257245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmePR3Tl9e7BpX1XbkrluQ6eNEFtesj3DI5lbG85yuM=;
        b=Fh4iJLRs2wui3ioOlu3R51igPoqMdkq8pzGQUFHqHvuiPwXJSbQWvbmgNK//qXLyiS
         5QCDvP9w21jPgSJnsQ4RJvEyI64hMyGvX/royhrjE5p5a2Olx4SvL2vdN56ez7NmV1kv
         Xt8uaMEvkGXskE6lEgYh8cp0OxdScScsXziDj8JaENsnQMggKpuE5v1kn3XKFOUaDCYf
         TOP09Mk/RrL0EZG2dlym6z3N8G0AvfXMantXfL6QLlfdFctpKAAN0Pn32aaLL/A0V2w6
         U8t3jyy8TZuGSTpguSmhHk3x3QQWUA7CdJ+MmaRldIOKwWItxv9EkxrhglxztRxrg30P
         2z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652445; x=1726257245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmePR3Tl9e7BpX1XbkrluQ6eNEFtesj3DI5lbG85yuM=;
        b=mJyZvyXN/2N3HMw47tip/bfDu25ieePhlEly378jYR/Wai+ESTeD5E/bQKl/XMxee6
         /EF2PIdRohInz9Q2CSnGzEMP2MOled8vIR6D09qHch83o2VnDOtY4M9KCwaKg+3Bkmry
         1c5FnDSm20YPeHZlOZCBEAAG7pe3Z8IQbfamMHf02s+XIjNh2fUwq0qJXbfRrP82YJ7H
         XjvqYQAPH5BkiVkBoSlnzcjh0tgOmHAU3LMDzVwYHQ5MED9J8HHnsbPFxrpMgUFL9dT6
         tw0/ki1xQdmw/bVGwT1ML226RGEW4NMstFbSC+P7c76+7y99ivZXl3RJiyHnK4YS+Bt8
         FJ2g==
X-Gm-Message-State: AOJu0YzFGwJcxGwWYuRi4HRnTAsPz7dWHyB3/3Vl7uFjD/SuHGl8uNdt
	ssNGwHHuJuJvB3Bd9EAL/kpUxfjHDebQiYcRAVLtWKBoGwRjaetbhRpr4Snx
X-Google-Smtp-Source: AGHT+IEYbaw0FQIR9ylII+U8lbLPCmoDq60ju0tR3qH5nh6PR9ksha6zwilUm+owvWoHAfFNjv6wvg==
X-Received: by 2002:a17:90a:7802:b0:2da:d2a2:4a71 with SMTP id 98e67ed59e1d1-2dafd0bd6f9mr495069a91.40.1725652444693;
        Fri, 06 Sep 2024 12:54:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm2015954a91.34.2024.09.06.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:54:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	hauke@hauke-m.de
Subject: [PATCHv2 3/3] wifi: ath9k: remove ath9k_platform_data
Date: Fri,  6 Sep 2024 12:53:59 -0700
Message-ID: <20240906195359.6982-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906195359.6982-1-rosenp@gmail.com>
References: <20240906195359.6982-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely unused here in favor of Device Tree based setup. The DT code
in here should currently match what is available with platform files.
Any such lapse can always be added.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c |  1 -
 drivers/net/wireless/ath/ath9k/hw.c           |  2 +-
 drivers/net/wireless/ath/ath9k/init.c         | 52 +------------------
 include/linux/ath9k_platform.h                | 51 ------------------
 4 files changed, 3 insertions(+), 103 deletions(-)
 delete mode 100644 include/linux/ath9k_platform.h

diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index 004ca5f536be..fe1013a3a588 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -18,7 +18,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/ath9k_platform.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/workqueue.h>
 
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 04a4b9ea61c3..36db734c74ae 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -490,7 +490,7 @@ static void ath9k_hw_init_macaddr(struct ath_hw *ah)
 	u16 eeval;
 	static const u32 EEP_MAC[] = { EEP_MAC_LSW, EEP_MAC_MID, EEP_MAC_MSW };
 
-	/* MAC address may already be loaded via ath9k_platform_data */
+	/* MAC address may already be loaded via NVMEM */
 	if (is_valid_ether_addr(common->macaddr))
 		return;
 
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 7fad7e75af6a..f9e77c4624d9 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -18,7 +18,6 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <linux/ath9k_platform.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
@@ -583,8 +582,8 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 
 		/* nvmem cell might not be defined, or the nvmem
 		 * subsystem isn't included. In this case, follow
-		 * the established "just return 0;" convention of
-		 * ath9k_init_platform to say:
+		 * the established "just return 0;" convention
+		 * to say:
 		 * "All good. Nothing to see here. Please go on."
 		 */
 		if (err == -ENOENT || err == -EOPNOTSUPP)
@@ -620,49 +619,6 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 	return 0;
 }
 
-static int ath9k_init_platform(struct ath_softc *sc)
-{
-	struct ath9k_platform_data *pdata = sc->dev->platform_data;
-	struct ath_hw *ah = sc->sc_ah;
-	struct ath_common *common = ath9k_hw_common(ah);
-	int ret;
-
-	if (!pdata)
-		return 0;
-
-	if (!pdata->use_eeprom) {
-		ah->ah_flags &= ~AH_USE_EEPROM;
-		ah->gpio_mask = pdata->gpio_mask;
-		ah->gpio_val = pdata->gpio_val;
-		ah->led_pin = pdata->led_pin;
-		ah->is_clk_25mhz = pdata->is_clk_25mhz;
-		ah->get_mac_revision = pdata->get_mac_revision;
-		ah->external_reset = pdata->external_reset;
-		ah->disable_2ghz = pdata->disable_2ghz;
-		ah->disable_5ghz = pdata->disable_5ghz;
-
-		if (!pdata->endian_check)
-			ah->ah_flags |= AH_NO_EEP_SWAP;
-	}
-
-	if (pdata->eeprom_name) {
-		ret = ath9k_eeprom_request(sc, pdata->eeprom_name);
-		if (ret)
-			return ret;
-	}
-
-	if (pdata->led_active_high)
-		ah->config.led_active_high = true;
-
-	if (pdata->tx_gain_buffalo)
-		ah->config.tx_gain_buffalo = true;
-
-	if (pdata->macaddr)
-		ether_addr_copy(common->macaddr, pdata->macaddr);
-
-	return 0;
-}
-
 static int ath9k_of_init(struct ath_softc *sc)
 {
 	struct device_node *np = sc->dev->of_node;
@@ -748,10 +704,6 @@ static int ath9k_init_softc(u16 devid, struct ath_softc *sc,
 	 */
 	ath9k_init_pcoem_platform(sc);
 
-	ret = ath9k_init_platform(sc);
-	if (ret)
-		return ret;
-
 	ret = ath9k_of_init(sc);
 	if (ret)
 		return ret;
diff --git a/include/linux/ath9k_platform.h b/include/linux/ath9k_platform.h
deleted file mode 100644
index 76860a461ed2..000000000000
--- a/include/linux/ath9k_platform.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright (c) 2008 Atheros Communications Inc.
- * Copyright (c) 2009 Gabor Juhos <juhosg@openwrt.org>
- * Copyright (c) 2009 Imre Kaloz <kaloz@openwrt.org>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-
-#ifndef _LINUX_ATH9K_PLATFORM_H
-#define _LINUX_ATH9K_PLATFORM_H
-
-#define ATH9K_PLAT_EEP_MAX_WORDS	2048
-
-struct ath9k_platform_data {
-	const char *eeprom_name;
-
-	u16 eeprom_data[ATH9K_PLAT_EEP_MAX_WORDS];
-	u8 *macaddr;
-
-	int led_pin;
-	u32 gpio_mask;
-	u32 gpio_val;
-
-	u32 bt_active_pin;
-	u32 bt_priority_pin;
-	u32 wlan_active_pin;
-
-	bool endian_check;
-	bool is_clk_25mhz;
-	bool tx_gain_buffalo;
-	bool disable_2ghz;
-	bool disable_5ghz;
-	bool led_active_high;
-
-	int (*get_mac_revision)(void);
-	int (*external_reset)(void);
-
-	bool use_eeprom;
-};
-
-#endif /* _LINUX_ATH9K_PLATFORM_H */
-- 
2.46.0


