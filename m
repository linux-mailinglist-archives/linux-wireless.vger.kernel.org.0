Return-Path: <linux-wireless+bounces-25991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA1B1077C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246675677AE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04DB25E828;
	Thu, 24 Jul 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="XLJwg9Uu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9A253F1A
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351949; cv=none; b=OAxP7uBj1qERy/DpjidPR7uqAVQ0RqVeyCYNuWFHZAkt7i3KOqZ0gbBAM6B6zpvaHH3gnKRb5AxHLCWr0MzH1gU8ObgGJ/MQExwEhxvAyCJ7dzQL8++PlVeyPoQC48SMvFQKGL27wxoIWwEJMQqd3Zb/q0LnfwBoKXYXEIO4mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351949; c=relaxed/simple;
	bh=RDlND4lGoIDtk7mgAw8eKVrm+9ItkUgUUyDoNe7QPC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dg2jyfHSGSoCykBaGLzxXxH+ItTel/WWljK5LC436wgjkAqzIMMaxJ8p8K3uTr9lUvuAmLBTh4MjKTfTXZeKYrssFAKdf+5oMlImPidXB1j+j055u4vP3d6QmVx7E80uy+BGJ4/o+5ySzedO+OGvDcVYTAKcn6ewpw9GFGOGSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=XLJwg9Uu; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1753351948; x=1784887948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RDlND4lGoIDtk7mgAw8eKVrm+9ItkUgUUyDoNe7QPC4=;
  b=XLJwg9UuWVVkCTn3/kAgzBhCqYwwMPAMi54KHwK1rgvYdYSOfWFaZI8l
   zaBj4wMNc6oMs2D+YXjJvzf3jBGADmj21dCyNbH60y/avxJJBICGkua2p
   dUzLNHTt5Wl3qD7oSZ2Sxl989nYFnyXjAZpWiR1o0bVJc94lrMrsgSiCN
   4=;
X-CSE-ConnectionGUID: a427PJtIQHeqMYxXssGOuQ==
X-CSE-MsgGUID: 5Qfyut7ESCy0oW3Nurj3jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="92558837"
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="92558837"
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 12:12:20 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 12:12:19 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Jul 2025 12:12:17 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, Gokul Sivakumar
	<gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v3] wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)
Date: Thu, 24 Jul 2025 15:41:36 +0530
Message-ID: <20250724101136.6691-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 MUCSE827.infineon.com (172.23.29.20)

Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
has not officially released any firmware binary for it. It is incorrect to
maintain this WLAN chip with firmware vendor ID as "CYW". So relabel the
chip's firmware Vendor ID as "WCC" as suggested by the maintainer.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Fixes: f74f1ec22dc2 ("wifi: brcmfmac: add support for Cypress firmware api")
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---

v3:
 * Rephrased the subject to indicate that the incorrect firmware Vendor ID
   (FWVID) of 43752 SDIO is fixed by this patch.

v2:
 * Relabelled the 43752-SDIO chip from CYW to WCC instead of dropping the
   support for this chip as suggested by Arend.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c   | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 8 ++++----
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 -
 include/linux/mmc/sdio_ids.h                              | 2 +-
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 8ab7d1e34a6e..6a3f187320fc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -997,9 +997,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43751, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43752, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
 	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	{ /* end: all zeroes */ }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 9074ab49e806..4239f2b21e54 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -738,8 +738,8 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4364_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
-	case CY_CC_43752_CHIP_ID:
 	case BRCM_CC_43751_CHIP_ID:
+	case BRCM_CC_43752_CHIP_ID:
 	case BRCM_CC_4377_CHIP_ID:
 		return 0x170000;
 	case BRCM_CC_4378_CHIP_ID:
@@ -1452,7 +1452,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
 	case BRCM_CC_4359_CHIP_ID:
 	case BRCM_CC_43751_CHIP_ID:
-	case CY_CC_43752_CHIP_ID:
+	case BRCM_CC_43752_CHIP_ID:
 	case CY_CC_43012_CHIP_ID:
 		addr = CORE_CC_REG(pmu->base, retention_ctl);
 		reg = chip->ops->read32(chip->ctx, addr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 8a0bad5119a0..8cf9d7e7c3f7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -655,10 +655,10 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
 	BRCMF_FW_ENTRY(BRCM_CC_43751_CHIP_ID, 0xFFFFFFFF, 43752),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
 	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
 	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
-	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
 };
 
 #define TXCTL_CREDITS	2
@@ -3426,8 +3426,8 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
 	if (bus->ci->chip == BRCM_CC_43751_CHIP_ID ||
-	    bus->ci->chip == CY_CC_43012_CHIP_ID ||
-	    bus->ci->chip == CY_CC_43752_CHIP_ID)
+	    bus->ci->chip == BRCM_CC_43752_CHIP_ID ||
+	    bus->ci->chip == CY_CC_43012_CHIP_ID)
 		return true;
 	else
 		return false;
@@ -4278,8 +4278,8 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 
 		switch (sdiod->func1->device) {
 		case SDIO_DEVICE_ID_BROADCOM_43751:
+		case SDIO_DEVICE_ID_BROADCOM_43752:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
-		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index b39c5c1ee18b..df3b67ba4db2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -60,7 +60,6 @@
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43439_CHIP_ID		43439
-#define CY_CC_43752_CHIP_ID		43752
 
 /* USB Device IDs */
 #define BRCM_USB_43143_DEVICE_ID	0xbd1e
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index fe3d6d98f8da..673cbdf43453 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -77,7 +77,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_43751		0xaae7
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
+#define SDIO_DEVICE_ID_BROADCOM_43752		0xaae8
 
 #define SDIO_VENDOR_ID_CYPRESS			0x04b4
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d

base-commit: 3630f043302c065adb3d919992173b7dcb251b7b
-- 
2.25.1


