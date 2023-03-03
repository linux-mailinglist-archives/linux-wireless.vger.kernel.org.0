Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5416A9E55
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 19:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCCST0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 13:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCCSTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 13:19:25 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630762688;
        Fri,  3 Mar 2023 10:19:24 -0800 (PST)
Received: from [IPV6:2a02:8428:2a4:1a01:f88c:752c:48de:2928] (unknown [IPv6:2a02:8428:2a4:1a01:f88c:752c:48de:2928])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id E91E55FFAF;
        Fri,  3 Mar 2023 19:19:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1677867562;
        bh=VIibiph2IAZw8YCCnsAN51osihVhUJ2GrEU2ysg22B8=;
        h=Date:From:Subject:To:Cc:From;
        b=YCkYwiro4W8pFN7Mj4VjeohMZ7StZ6xLgPf9K54LZ6SV0v53trSAbWHffLuazXfhU
         nprlcBb0eLvFQhcysD1ouRiIWPLyj25h7X4IRpPNaev9MJtw6U4BygK8qbNpNbi9DH
         xC9Myay8bBR3Ua4uZAvMSe0zkuRF4s979tA4stfAE1e/RMhdO9EXuzTMkWdegoWgiL
         BxIM1mfrA8As8WRmdKMFNU7VY7S0S0YVppk29SW+2YYI8d55Whuta2YpLRXKs9NEaE
         MUDOhFrGmpOl+TImT4kRpUktW5NwRjWJkxQuOPeQOeOSSHzoZgF0EGQNcxshwqesCW
         20I0TehqRrJPA==
Message-ID: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
Date:   Fri, 3 Mar 2023 19:19:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Unsupported WiFi adapter on S905X2 board
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I think there's an unsupported device in this system:

# cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
OF_NAME=wifi
OF_FULLNAME=/soc/sd@ffe03000/wifi@1
OF_COMPATIBLE_0=brcm,bcm4329-fmac
OF_COMPATIBLE_N=1
SDIO_CLASS=00
SDIO_ID=02D0:AAE7
SDIO_REVISION=0.0
MODALIAS=sdio:c00v02D0dAAE7

0xaae7 = 43751

Isn't there some overlap between
include/linux/mmc/sdio_ids.h
and
drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
?

(Relevant commit: d2587c57ffd8dc)

Looking at all the occurrences of 43752 to insert a 43751,
could someone comment whether this looks reasonable?

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 1967160f211eb..89bbad598782e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -987,6 +987,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751, CYW),
  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
  	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
  	{ /* end: all zeroes */ }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 121893bbaa1d7..cab9257272dd4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -731,6 +731,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
  	case BRCM_CC_4364_CHIP_ID:
  	case CY_CC_4373_CHIP_ID:
  		return 0x160000;
+	case CY_CC_43751_CHIP_ID:
  	case CY_CC_43752_CHIP_ID:
  		return 0x170000;
  	case BRCM_CC_4378_CHIP_ID:
@@ -1433,6 +1434,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
  		reg = chip->ops->read32(chip->ctx, addr);
  		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
  	case BRCM_CC_4359_CHIP_ID:
+	case CY_CC_43751_CHIP_ID:
  	case CY_CC_43752_CHIP_ID:
  	case CY_CC_43012_CHIP_ID:
  		addr = CORE_CC_REG(pmu->base, retention_ctl);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6b38d9de71af6..55cc7b65081fd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -624,6 +624,7 @@ BRCMF_FW_CLM_DEF(4356, "brcmfmac4356-sdio");
  BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
  BRCMF_FW_CLM_DEF(4373, "brcmfmac4373-sdio");
  BRCMF_FW_CLM_DEF(43012, "brcmfmac43012-sdio");
+BRCMF_FW_CLM_DEF(43751, "brcmfmac43751-sdio");
  BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-sdio");
  
  /* firmware config files */
@@ -657,6 +658,7 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
  	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
  	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
  	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
+	BRCMF_FW_ENTRY(CY_CC_43751_CHIP_ID, 0xFFFFFFFF, 43751),
  	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
  };
  
@@ -3425,6 +3427,7 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
  static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
  {
  	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
+	    bus->ci->chip == CY_CC_43751_CHIP_ID ||
  	    bus->ci->chip == CY_CC_43752_CHIP_ID)
  		return true;
  	else
@@ -4274,6 +4277,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
  
  		switch (sdiod->func1->device) {
  		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
+		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751:
  		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
  			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
  				  CY_4373_F2_WATERMARK);
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index f4939cf627672..8b21da3e66291 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -55,6 +55,7 @@
  #define CY_CC_4373_CHIP_ID		0x4373
  #define CY_CC_43012_CHIP_ID		43012
  #define CY_CC_43439_CHIP_ID		43439
+#define CY_CC_43751_CHIP_ID		43751
  #define CY_CC_43752_CHIP_ID		43752
  #define CY_CC_89459_CHIP_ID		0x4355
  
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 74f9d9a6d3307..80e84958e570f 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -76,6 +76,7 @@
  #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
  #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xa9af
  #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751	0xaae7
  #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
  
  #define SDIO_VENDOR_ID_MARVELL			0x02df


Regards.

