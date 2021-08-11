Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B535D3E948B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 17:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhHKP2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 11:28:49 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46088 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233160AbhHKP2s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 11:28:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5CC6E55E34D;
        Wed, 11 Aug 2021 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695704; bh=O98D6e2zuTrCXi+7B0oHeZQ4GwBBnRrpI8nf9qZQer8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uKl697+35YZZMlluLsxqIMymboMD6wEuxHJSqCVRGyWBPEJZhLoD4MEW1nZoiYP0+
         EJ1Ia/Ww9S3Y7MpqwJTkpvfSJU6Og3at5s0IeaAL7X7D8MfYkQhOcoIbP5ywh9KBJS
         LH4obxgb5pD8a6BELq2ipuiSYG1R5/dkKeu79g8w=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BmvMCzgaRZc8; Wed, 11 Aug 2021 15:28:24 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id C3EB455E34F;
        Wed, 11 Aug 2021 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695704; bh=O98D6e2zuTrCXi+7B0oHeZQ4GwBBnRrpI8nf9qZQer8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uKl697+35YZZMlluLsxqIMymboMD6wEuxHJSqCVRGyWBPEJZhLoD4MEW1nZoiYP0+
         EJ1Ia/Ww9S3Y7MpqwJTkpvfSJU6Og3at5s0IeaAL7X7D8MfYkQhOcoIbP5ywh9KBJS
         LH4obxgb5pD8a6BELq2ipuiSYG1R5/dkKeu79g8w=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v2 2/3] brcmfmac: add initializers for the 43752
Date:   Wed, 11 Aug 2021 08:28:03 -0700
Message-Id: <20210811152804.2379405-3-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811152804.2379405-1-angus@akkea.ca>
References: <20210811152804.2379405-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the firmware mapping structures for the BRCM43752 chipset.
The 43752 needs some things setup similar to the 43012 chipset.
The WATERMARK shows better performance when initialized to the 4373 value.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index c9954da6c5cd..cc41ba5421f4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -1413,6 +1413,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg = chip->ops->read32(chip->ctx, addr);
 		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
 	case BRCM_CC_4359_CHIP_ID:
+	case CY_CC_43752_CHIP_ID:
 	case CY_CC_43012_CHIP_ID:
 		addr = CORE_CC_REG(pmu->base, retention_ctl);
 		reg = chip->ops->read32(chip->ctx, addr);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 97ee9e2e2e35..84d8ddff2aef 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -624,6 +624,7 @@ BRCMF_FW_CLM_DEF(4356, "brcmfmac4356-sdio");
 BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
 BRCMF_FW_CLM_DEF(4373, "brcmfmac4373-sdio");
 BRCMF_FW_CLM_DEF(43012, "brcmfmac43012-sdio");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-sdio");
 
 /* firmware config files */
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-sdio.*.txt");
@@ -650,7 +651,8 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
-	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012)
+	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
+	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
 };
 
 #define TXCTL_CREDITS	2
@@ -3416,7 +3418,8 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
-	if (bus->ci->chip == CY_CC_43012_CHIP_ID)
+	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
+	    bus->ci->chip == CY_CC_43752_CHIP_ID)
 		return true;
 	else
 		return false;
@@ -4257,6 +4260,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 
 		switch (sdiod->func1->device) {
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
+		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
-- 
2.25.1

