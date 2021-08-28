Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1713FA60C
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Aug 2021 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhH1N2I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Aug 2021 09:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhH1N17 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Aug 2021 09:27:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287AFC0613D9
        for <linux-wireless@vger.kernel.org>; Sat, 28 Aug 2021 06:27:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h13so14950957wrp.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Aug 2021 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtcS9aafz+Q0L8pDWZo/dhLnfCDOiTMCVcQTauLHP7s=;
        b=V/EzGIz2+C/cJ6GWnn64p+/BA7g9PDwx1bo2grDO9nAcDJcJ/vkuIlEEiy0SG0jn2E
         KJZPvuTna6VZtp7rJJ20rSyLIKRsiCEGn4ADxC8lMCupwhaXHQFFUnl4eDCZZd6+KRrk
         1TugS80QncrTuvcV3+I7jWqv2gQSHhHnfnbbXyYqh26OzyC184EtRm8Xzk8eEFgn6E90
         sjonBWd17dJUsN5vXUOVLUnBAEuoHcogMpbFhFhRGSIc4fVEL/9+2MVDi8x1h1w/L+oF
         Hz5Ddv9MgwSENj/zEH22UxO8xA7juRSh22Zg5YhUo+KSGsjMzsfheRdkT2MOFwxxZWIy
         lEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtcS9aafz+Q0L8pDWZo/dhLnfCDOiTMCVcQTauLHP7s=;
        b=Z1wujtYBtAoyoj7jcHAXFBKoY0LQuThte8OfU13VgBfgLzf0WCylE/ljuY9C36YLLD
         iHniDVEdC46WVBvAGA2wHVEDrftbu0RSmToHIwFJYWTCB1tLu3TOoQcBUtM0b7kj8Eqe
         qHCOyBmDIQaD0Af0NifQ5DWw7qUpCMFqdJegRGODgRfk+jiyVbDmpmPcJwIs0lr7lRYY
         zykAi/E5o7JynZt+26BrjTQFkGogGEQpzUI9MhPvXTZiyiPHWRnaVXt073VOiZHntMt1
         RZJUIMvrGD0HS0sKS24K5HljyBFSlyVqhi4T5NT0sih3LDO6/eiLGZJM61hjO99TP5Ju
         zUFw==
X-Gm-Message-State: AOAM533K67CQ5eUOYvDyAuw+adSRk/3sI9tuQMq8PVb22wmMBQfQga5v
        SOrDSlZ4ZOzDU9bZ9LJvmfblTyln5Hc=
X-Google-Smtp-Source: ABdhPJwx2uGFEfrjrfSVYup07+zvpX7IRewIZf2qp78BZHFeMIoIES/tDrKCqGIbnmY87V4XwIkMdA==
X-Received: by 2002:adf:e6d0:: with SMTP id y16mr16286581wrm.284.1630157227723;
        Sat, 28 Aug 2021 06:27:07 -0700 (PDT)
Received: from debian64.daheim (p5b0d759d.dip0.t-ipconnect.de. [91.13.117.157])
        by smtp.gmail.com with ESMTPSA id n10sm9390328wrw.76.2021.08.28.06.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 06:27:07 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mJyMT-000C8g-LJ; Sat, 28 Aug 2021 15:27:05 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: [PATCH v1 1/2] ath9k: fetch calibration data via nvmem subsystem
Date:   Sat, 28 Aug 2021 15:27:04 +0200
Message-Id: <f9b732b50a3453fadf3923cc75d365bae3505fe7.1630157099.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
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
the nvmem subsystem.

This feature - together with an nvmem cell definition either
in the platform data or via device-tree allows drivers to get
the data necessary for initializing the WIFI, without having
to wait around for the filesystem and userspace to do
the extractions.

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

