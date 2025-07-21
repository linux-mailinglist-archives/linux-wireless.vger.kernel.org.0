Return-Path: <linux-wireless+bounces-25748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D5B0C143
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 12:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF4417EBFE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7A619DF62;
	Mon, 21 Jul 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="DAaYdNxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451128F524
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093673; cv=none; b=XJWp8raMUa/so4OB9jOlCp31IUJGQOWAjqsCtlC+hBQ1f3G2O9ZJebWsErrR1kN92BITW2JJHbKloQxwvk9ojC3RpvjKhskORcR9YOKgrfYmjAMvD/XZQLPA1ZxjK7KVld8XNQS81rr30YSYo96NL5wvnlbmDl5o5p5MqcVGc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093673; c=relaxed/simple;
	bh=gnurhFThI9bO1nrcUeJQJ7VD/NRCVzFbmGx4//YV+vQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPUzEfQ6f0SKX+N/siMsX/wxOybeahsmCLhqxGpImi1D+v8WuQ6+P7NBZHJxl2HZY9Kzom/n1CutVVBWxNaI2wigFffkW8Ap63/BOF6LCNOk59J2Q7iZ0QsqaqPk8Wi54Hzn8H1T7Fltas/Jo65HHQV1e8Q2q7TI+YGLgXhL2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=DAaYdNxL; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1753093670; x=1784629670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gnurhFThI9bO1nrcUeJQJ7VD/NRCVzFbmGx4//YV+vQ=;
  b=DAaYdNxLJXKQAYlHew2Vg+VsXDf83DLG40mmGc9NjLb+XO8J3kfV2EPJ
   naKJ1tEUAud51cUuKOtQvZlM5i97DnWEYtBkE1n43anH99tcnWFRSxcTF
   rY5eW0rs4UEMNfHV9QzqhKV4PF5af/+qt26xXOIRqkNovJvIEHiklbGpm
   M=;
X-CSE-ConnectionGUID: W6rw5kxHTACAInbbCoTBrA==
X-CSE-MsgGUID: NNEREI/aSfqO+imulnBAsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="103261775"
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="103261775"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 12:26:40 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Jul
 2025 12:26:39 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 12:26:37 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, Gokul Sivakumar
	<gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next] wifi: brcmfmac: remove 43752 SDIO incorrectly labelled as a Cypress chip
Date: Mon, 21 Jul 2025 15:56:18 +0530
Message-ID: <20250721102618.1453-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE827.infineon.com (172.23.29.20)

Cypress(Infineon) is not the vendor for this 43752 SDIO WLAN chip, and so
has not officially released any firmware binary for it. It is incorrect to
maintain this WLAN chip with firmware vendor ID as "CYW".

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c    | 1 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c      | 4 ++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c      | 5 +----
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 1 -
 include/linux/mmc/sdio_ids.h                                 | 1 -
 5 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 8ab7d1e34a6e..de4634cad461 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -999,7 +999,6 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43751, WCC),
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
index 8a0bad5119a0..1454591cd165 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -658,7 +658,6 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
 	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
 	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
-	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
 };
 
 #define TXCTL_CREDITS	2
@@ -3426,8 +3425,7 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
 	if (bus->ci->chip == BRCM_CC_43751_CHIP_ID ||
-	    bus->ci->chip == CY_CC_43012_CHIP_ID ||
-	    bus->ci->chip == CY_CC_43752_CHIP_ID)
+	    bus->ci->chip == CY_CC_43012_CHIP_ID)
 		return true;
 	else
 		return false;
@@ -4279,7 +4277,6 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 		switch (sdiod->func1->device) {
 		case SDIO_DEVICE_ID_BROADCOM_43751:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
-		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 6564616a57df..81d91e720076 100644
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
index fe3d6d98f8da..9e9b54248d9f 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -77,7 +77,6 @@
 #define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_43751		0xaae7
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
 
 #define SDIO_VENDOR_ID_CYPRESS			0x04b4
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d

base-commit: 754fe848b3b297fc85ec24cd959bad22b6df8cb8
-- 
2.25.1


