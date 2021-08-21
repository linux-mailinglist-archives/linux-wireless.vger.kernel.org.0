Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17F73F37DD
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 03:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbhHUBJ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 21:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhHUBJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 21:09:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF8C061757;
        Fri, 20 Aug 2021 18:09:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q10so16608150wro.2;
        Fri, 20 Aug 2021 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1t5xO/vCozsm6qTyQvSV3wCxmTDXYEFQ4QrCefdVVb4=;
        b=UT79z/7za2bFRV8JcSGpblgfIvtPTQMS1q3EcoDR1u2ZQTDYOGrAjat2+VIN6znABT
         s744DbjKzO2BFYWRvtU1hBi9/RE7CcObV0q/Y74tL1OZZeioRYmOUtJuuUdqpXv3SDYR
         ZOBDbI4pvDT9Jn4ZbtBlDjMt1lU/eKypZiTtsj5hgIKju66O2gkmLheuTAF/6xk+tjfu
         MprGGFBS2C+7QofsQZokmaZuW0kUdml4CwB69han9uYDksPVB9pM9VTYRhV4oqdrw+i+
         3i7hrpijG+CVMcKsOv6EV2gdwTCGR9FUo1jb04iOs8DQRYg1Sw6xULqVBCKSaKNt7IM6
         wViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1t5xO/vCozsm6qTyQvSV3wCxmTDXYEFQ4QrCefdVVb4=;
        b=K1gXY2E4HEfotPRydhMKRNbTEAZNCYh6M+cs2aSQDpFWWk4vgzIvr+XNnnE8+JvuTl
         +kgcuxcBTGnyR16HSkqeta/UJucrUBtThB9V/nSkns5DQwhGrUM0ZbyMhZQ7lnTqJoRc
         jdFUQJDJTCD+oglCacSaHTzdqSKQc5C/c6+NveXyGGg6ezEzV/XNcCvnvfiexrCUFUZG
         MMwb7QR3q2D5tSdoEhVx/FlfyVs26oLh83vPXogbud1d0uL5yfv2VFgtQFhnOoBlG78n
         xprT/hJaH0kjC6Hl5Me3msNb22LHplI8q308P0rzLEelSo/cdShSj+ldhX7X5l0Uen7R
         /YUQ==
X-Gm-Message-State: AOAM531pkPjZxCrkmsKy9AYDTnFhjQx3wgWa8OjaxV0/FomWCPmXBMZO
        olGGh3uucPaeU6wa+RtMu4sOPdmuuFk=
X-Google-Smtp-Source: ABdhPJw4z3kdnmiOMiQAsevSygP5qrdnYZiLRh8mcomr0VNIxHLrdtIUfpXub60Px7D+b7E3fbJbLA==
X-Received: by 2002:adf:f707:: with SMTP id r7mr1368438wrp.175.1629508156661;
        Fri, 20 Aug 2021 18:09:16 -0700 (PDT)
Received: from debian64.daheim (pd9e297bb.dip0.t-ipconnect.de. [217.226.151.187])
        by smtp.gmail.com with ESMTPSA id u16sm7441259wmc.41.2021.08.20.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 18:09:16 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mHFVb-0046Wx-8U; Sat, 21 Aug 2021 03:09:15 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Subject: [RFC PATCH v1 2/3] ath9k: fetch calibration data via nvmem subsystem
Date:   Sat, 21 Aug 2021 03:09:14 +0200
Message-Id: <aa9d1e36df2cb7d4c2b4fc77eacbbcb884167c93.1629508039.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
References: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On most embedded ath9k devices (like range extenders,
routers, accesspoints, ...) the calibration data is
stored in a MTD partitions named "ART", or "caldata"/
"calibration".

Since commit 4b361cfa8624 ("mtd: core: add OTP nvmem provider support"):
All MTD partitions are all automatically available through
the nvmem subsystem. This feature - together with an nvmem cell definition
in the device-tree - allows drivers like ath9k to get the data necessary
for starting the WIFI, without having to wait around for the filesystem
and userspace to do the extractions.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/ath9k/eeprom.c | 12 +++++-
 drivers/net/wireless/ath/ath9k/hw.h     |  2 +
 drivers/net/wireless/ath/ath9k/init.c   | 56 +++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index c22d457dbc54..e6b3cd49ea18 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -135,13 +135,23 @@ static bool ath9k_hw_nvram_read_firmware(const struct firmware *eeprom_blob,
 					 offset, data);
 }
 
+static bool ath9k_hw_nvram_read_nvmem(struct ath_hw *ah, off_t offset,
+				      u16 *data)
+{
+	return ath9k_hw_nvram_read_array(ah->nvmem_blob,
+					 ah->nvmem_blob_len / sizeof(u16),
+					 offset, data);
+}
+
 bool ath9k_hw_nvram_read(struct ath_hw *ah, u32 off, u16 *data)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ath9k_platform_data *pdata = ah->dev->platform_data;
 	bool ret;
 
-	if (ah->eeprom_blob)
+	if (ah->nvmem_blob)
+		ret = ath9k_hw_nvram_read_nvmem(ah, off, data);
+	else if (ah->eeprom_blob)
 		ret = ath9k_hw_nvram_read_firmware(ah->eeprom_blob, off, data);
 	else if (pdata && !pdata->use_eeprom)
 		ret = ath9k_hw_nvram_read_pdata(pdata, off, data);
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index b7b65b1c90e8..096a206f49ed 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -977,6 +977,8 @@ struct ath_hw {
 	bool disable_5ghz;
 
 	const struct firmware *eeprom_blob;
+	u16 *nvmem_blob;	/* devres managed */
+	size_t nvmem_blob_len;
 
 	struct ath_dynack dynack;
 
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index e9a36dd7144f..1568730fc01e 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/relay.h>
 #include <linux/dmi.h>
 #include <net/ieee80211_radiotap.h>
@@ -568,6 +569,57 @@ static void ath9k_eeprom_release(struct ath_softc *sc)
 	release_firmware(sc->sc_ah->eeprom_blob);
 }
 
+static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
+{
+	struct ath_hw *ah = sc->sc_ah;
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+	int err;
+
+	cell = devm_nvmem_cell_get(sc->dev, "calibration");
+	if (IS_ERR(cell)) {
+		err = PTR_ERR(cell);
+
+		/* nvmem cell might not be defined, or the nvmem
+		 * subsystem isn't included. In this case, follow
+		 * the established "just return 0;" convention of
+		 * ath9k_init_platform to say:
+		 * "All good. Nothing to see here. Please go on."
+		 */
+		if (err == -ENOENT || err == -EOPNOTSUPP)
+			return 0;
+
+		return err;
+	}
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* run basic sanity checks on the returned nvram cell length.
+	 * That length has to be a multiple of a "u16" (i.e.: & 1).
+	 * Furthermore, it has to be more than "let's say" 512 bytes
+	 * but less than the maximum of AR9300_EEPROM_SIZE (16kb).
+	 */
+	if ((len & 1) == 1 || len < 512 || len >= AR9300_EEPROM_SIZE) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	/* devres manages the calibration values release on shutdown */
+	ah->nvmem_blob = (u16 *)devm_kmemdup(sc->dev, buf, len, GFP_KERNEL);
+	kfree(buf);
+	if (IS_ERR(ah->nvmem_blob))
+		return PTR_ERR(ah->nvmem_blob);
+
+	ah->nvmem_blob_len = len;
+	ah->ah_flags &= ~AH_USE_EEPROM;
+	ah->ah_flags |= AH_NO_EEP_SWAP;
+
+	return 0;
+}
+
 static int ath9k_init_platform(struct ath_softc *sc)
 {
 	struct ath9k_platform_data *pdata = sc->dev->platform_data;
@@ -704,6 +756,10 @@ static int ath9k_init_softc(u16 devid, struct ath_softc *sc,
 	if (ret)
 		return ret;
 
+	ret = ath9k_nvmem_request_eeprom(sc);
+	if (ret)
+		return ret;
+
 	if (ath9k_led_active_high != -1)
 		ah->config.led_active_high = ath9k_led_active_high == 1;
 
-- 
2.33.0

