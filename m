Return-Path: <linux-wireless+bounces-12550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D372096E19D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FCDB26164
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890117BEA4;
	Thu,  5 Sep 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmVmYkQx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4917C99B
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559782; cv=none; b=r7yqjMBn5aly3F1d3AFxRRoldSE38j/A9ju16g6c10XaEkCXShbdHBT0dpDsQHX2DmjT+ArfImn00swTA5aRVcOWXg8qkktA4iv4o+wkROLFAq64slrT90E9QIWTEiVbJUh3A2hyN/Hdrzm5v5kyy8gU4ucw0WQoEanixdKxxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559782; c=relaxed/simple;
	bh=t4RpnkChInJMnxybZH68s7fE1zxROobmFfcqLun/NgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnlaEYuyO9gMscqW/kg7dUmWismUF5ser42fzMYqSJ+W2hM0pGXGxPlc/+s2QgO/MO+kxabGwlmC5zgm6yslCR+7c+Fo90jJJC/rII941iE0n441AY912TChxFa9WLajw15tGtEwjUcpZcuhuYPiKZxcd5fNg4fYoZUFQivGNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmVmYkQx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-715abede256so924582b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559780; x=1726164580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY40VmqYhN8V2lmu/siuRbRm4wTzzxRzsOvExXvkmYo=;
        b=cmVmYkQx/3AsUopZhBfdM7JeSOr+zcZ/txrG4Dm4JVFVIBBhX1Kg3PtCI/q+v1pBKw
         +3/xnHGsQt/XUW09Jgl9o4xZCN7lxyBBM/wT+AvLYn7YdTRFdVAzn8PBFyhyyrCutD5b
         GoqvVM7oYtPc1Th8Ss8dyQ6hjWm1525RIkPkOME3hTRwx7LG8/sgPq5BWjfUZy8VGDXa
         Y8vzB487vbQ3y38g+WZI+ddiv9JlC/KL2pFbSweMhbc30SnR2DTDNnXzbHsH2+/4l55S
         fUp9WvQEiZtHhI48dW8KSs2wPXFo50E7P7sTK32SSxanGbkD+5sN8KYAJVefFsyVky4h
         8GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559780; x=1726164580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY40VmqYhN8V2lmu/siuRbRm4wTzzxRzsOvExXvkmYo=;
        b=UI5cS+hjaV+hOBxUTlcre44xRpEPPkP9jMqZebG4DMyrXlP72PPKRvGtjThIigCpEl
         ZZBSCbyfoYVWmPEFyAnw8Y5VUqN/+VR3I2bkTMO/+9c4K6dOZXnr2pZS2P3UsoesmfVe
         Vr/FHXiGsqmHan4QzL/6ShwvAxouBFhSlM7AvspUm475tx36xuxzOGQvvwv0IYfwy0hg
         w2DeJ0FfwaXdBYr3/gt9+t7V88TaGMTHfs6eZN318D5kZu+GyP0nn+6GrKpyZKuxf4Es
         yjHwEkv7P1+EsXNoM8xCrdyWRPjCbVkbf3bLqafyw9SjlZAHYwZBTLBEMvFLwRmyn1ZM
         L+2g==
X-Gm-Message-State: AOJu0YzLGh39u+FyHx+qkgg+Q7U60bYS7TrsY4WoKVh82MumvzYUkOX8
	0IJ6m6OKHEjVOwfcxwL60gp0gIavG+x5kYeu2yuDQN8wQNDpJByKtoIgE6hw
X-Google-Smtp-Source: AGHT+IHmXJg5H3AMe4QvfKMWzaFMS2GWCf/h5QXZ1HhlDu+Jd3Psz0xCdTxXlMfD/GMpx0jpt5tmRg==
X-Received: by 2002:a05:6a00:21d5:b0:714:19f8:f135 with SMTP id d2e1a72fcca58-717449b1a76mr17544033b3a.21.1725559779794;
        Thu, 05 Sep 2024 11:09:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfd5sm3485199b3a.133.2024.09.05.11.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:09:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com
Subject: [PATCH 5/5] wifi: ath9k: remove ath9k_platform_data
Date: Thu,  5 Sep 2024 11:09:28 -0700
Message-ID: <20240905180928.382090-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905180928.382090-1-rosenp@gmail.com>
References: <20240905180928.382090-1-rosenp@gmail.com>
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
index 88db51ec7e55..58dbf5e13151 100644
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
@@ -755,10 +711,6 @@ static int ath9k_init_softc(u16 devid, struct ath_softc *sc,
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


