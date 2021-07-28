Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D840D3D9712
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhG1Uu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 16:50:58 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:55042 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231700AbhG1Uu6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 16:50:58 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8B8882E22C;
        Wed, 28 Jul 2021 13:50:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8B8882E22C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1627505455;
        bh=4QWcKvovCsq0PeIQ8YelBfVNbdX6YrvC/XMdHFHkLKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfHGIh2JVHIyUGy3aziDt7tFyz42yXOUhwkemEmccIfKMeul9u/56GSo0fCW0zZsb
         Ew7EQDf4esOwRfYlt5WDJW95fixmEVV0dW1/GpzIVUL8MvhegR8BbWpkgXIKfXZQdj
         nHD2bTNgAh4PtGSKPAc7qEwi8hhnR9vQRO3Jv9qU=
Received: from bld-bun-01.bun.broadcom.net (bld-bun-01.bun.broadcom.net [10.176.128.83])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 8EAF71874BD;
        Wed, 28 Jul 2021 13:50:54 -0700 (PDT)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 4/4] brcmfmac: support chipsets with different core enumeration space
Date:   Wed, 28 Jul 2021 22:50:34 +0200
Message-Id: <1627505434-9544-5-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Historically the broadcom wifi chipsets always had enumeration
space containing all core information at same place. However, for
new chipsets the ASIC developers moved away from that given fact.
So we have to accommodate that it can differ per chipset.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c         |  3 ++-
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c  | 16 ++++++++++++----
 .../wireless/broadcom/brcm80211/brcmfmac/chip.h  |  5 ++++-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c  |  3 ++-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 12 ++++++++----
 .../wireless/broadcom/brcm80211/include/soc.h    |  2 +-
 6 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 633d0ab19031..720c7fec22ac 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -128,7 +128,8 @@ int brcmf_sdiod_intr_register(struct brcmf_sdio_dev *sdiodev)
 
 		if (sdiodev->bus_if->chip == BRCM_CC_43362_CHIP_ID) {
 			/* assign GPIO to SDIO core */
-			addr = CORE_CC_REG(SI_ENUM_BASE, gpiocontrol);
+			addr = brcmf_chip_enum_base(sdiodev->func1->device);
+			addr = CORE_CC_REG(addr, gpiocontrol);
 			gpiocontrol = brcmf_sdiod_readl(sdiodev, addr, &ret);
 			gpiocontrol |= 0x2;
 			brcmf_sdiod_writel(sdiodev, addr, gpiocontrol, &ret);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index da4fd40b5275..4faab0170ffa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -896,7 +896,8 @@ int brcmf_chip_dmp_erom_scan(struct brcmf_chip_priv *ci)
 	u32 base, wrap;
 	int err;
 
-	eromaddr = ci->ops->read32(ci->ctx, CORE_CC_REG(SI_ENUM_BASE, eromptr));
+	eromaddr = ci->ops->read32(ci->ctx,
+				   CORE_CC_REG(ci->pub.enum_base, eromptr));
 
 	while (desc_type != DMP_DESC_EOT) {
 		val = brcmf_chip_dmp_get_desc(ci, &eromaddr, &desc_type);
@@ -944,6 +945,11 @@ int brcmf_chip_dmp_erom_scan(struct brcmf_chip_priv *ci)
 	return 0;
 }
 
+u32 brcmf_chip_enum_base(u16 devid)
+{
+	return SI_ENUM_BASE_DEFAULT;
+}
+
 static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 {
 	struct brcmf_core *core;
@@ -956,7 +962,8 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 	 * For different chiptypes or old sdio hosts w/o chipcommon,
 	 * other ways of recognition should be added here.
 	 */
-	regdata = ci->ops->read32(ci->ctx, CORE_CC_REG(SI_ENUM_BASE, chipid));
+	regdata = ci->ops->read32(ci->ctx,
+				  CORE_CC_REG(ci->pub.enum_base, chipid));
 	ci->pub.chip = regdata & CID_ID_MASK;
 	ci->pub.chiprev = (regdata & CID_REV_MASK) >> CID_REV_SHIFT;
 	socitype = (regdata & CID_TYPE_MASK) >> CID_TYPE_SHIFT;
@@ -976,7 +983,7 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 		ci->resetcore = brcmf_chip_sb_resetcore;
 
 		core = brcmf_chip_add_core(ci, BCMA_CORE_CHIPCOMMON,
-					   SI_ENUM_BASE, 0);
+					   SI_ENUM_BASE_DEFAULT, 0);
 		brcmf_chip_sb_corerev(ci, core);
 		core = brcmf_chip_add_core(ci, BCMA_CORE_SDIO_DEV,
 					   BCM4329_CORE_BUS_BASE, 0);
@@ -1090,7 +1097,7 @@ static int brcmf_chip_setup(struct brcmf_chip_priv *chip)
 	return ret;
 }
 
-struct brcmf_chip *brcmf_chip_attach(void *ctx,
+struct brcmf_chip *brcmf_chip_attach(void *ctx, u16 devid,
 				     const struct brcmf_buscore_ops *ops)
 {
 	struct brcmf_chip_priv *chip;
@@ -1115,6 +1122,7 @@ struct brcmf_chip *brcmf_chip_attach(void *ctx,
 	chip->num_cores = 0;
 	chip->ops = ops;
 	chip->ctx = ctx;
+	chip->pub.enum_base = brcmf_chip_enum_base(devid);
 
 	err = ops->prepare(ctx);
 	if (err < 0)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
index 8fa38658e727..d69f101f5834 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
@@ -15,6 +15,7 @@
  *
  * @chip: chip identifier.
  * @chiprev: chip revision.
+ * @enum_base: base address of core enumeration space.
  * @cc_caps: chipcommon core capabilities.
  * @cc_caps_ext: chipcommon core extended capabilities.
  * @pmucaps: PMU capabilities.
@@ -27,6 +28,7 @@
 struct brcmf_chip {
 	u32 chip;
 	u32 chiprev;
+	u32 enum_base;
 	u32 cc_caps;
 	u32 cc_caps_ext;
 	u32 pmucaps;
@@ -70,7 +72,7 @@ struct brcmf_buscore_ops {
 };
 
 int brcmf_chip_get_raminfo(struct brcmf_chip *pub);
-struct brcmf_chip *brcmf_chip_attach(void *ctx,
+struct brcmf_chip *brcmf_chip_attach(void *ctx, u16 devid,
 				     const struct brcmf_buscore_ops *ops);
 void brcmf_chip_detach(struct brcmf_chip *chip);
 struct brcmf_core *brcmf_chip_get_core(struct brcmf_chip *chip, u16 coreid);
@@ -85,5 +87,6 @@ void brcmf_chip_set_passive(struct brcmf_chip *ci);
 bool brcmf_chip_set_active(struct brcmf_chip *ci, u32 rstvec);
 bool brcmf_chip_sr_capable(struct brcmf_chip *pub);
 char *brcmf_chip_name(u32 chipid, u32 chiprev, char *buf, uint len);
+u32 brcmf_chip_enum_base(u16 devid);
 
 #endif /* BRCMF_AXIDMP_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index c49dd0c36ae4..5f6a418fbbb1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1886,7 +1886,8 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	devinfo->pdev = pdev;
 	pcie_bus_dev = NULL;
-	devinfo->ci = brcmf_chip_attach(devinfo, &brcmf_pcie_buscore_ops);
+	devinfo->ci = brcmf_chip_attach(devinfo, pdev->device,
+					&brcmf_pcie_buscore_ops);
 	if (IS_ERR(devinfo->ci)) {
 		ret = PTR_ERR(devinfo->ci);
 		devinfo->ci = NULL;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 97ee9e2e2e35..a430d3ca2fd0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3907,7 +3907,7 @@ static u32 brcmf_sdio_buscore_read32(void *ctx, u32 addr)
 	 * It can be identified as 4339 by looking at the chip revision. It
 	 * is corrected here so the chip.c module has the right info.
 	 */
-	if (addr == CORE_CC_REG(SI_ENUM_BASE, chipid) &&
+	if (addr == CORE_CC_REG(SI_ENUM_BASE_DEFAULT, chipid) &&
 	    (sdiodev->func1->device == SDIO_DEVICE_ID_BROADCOM_4339 ||
 	     sdiodev->func1->device == SDIO_DEVICE_ID_BROADCOM_4335_4339)) {
 		rev = (val & CID_REV_MASK) >> CID_REV_SHIFT;
@@ -3943,12 +3943,15 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	int reg_addr;
 	u32 reg_val;
 	u32 drivestrength;
+	u32 enum_base;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
 
-	pr_debug("F1 signature read @0x18000000=0x%4x\n",
-		 brcmf_sdiod_readl(sdiodev, SI_ENUM_BASE, NULL));
+	enum_base = brcmf_chip_enum_base(sdiodev->func1->device);
+
+	pr_debug("F1 signature read @0x%08x=0x%4x\n", enum_base,
+		 brcmf_sdiod_readl(sdiodev, enum_base, NULL));
 
 	/*
 	 * Force PLL off until brcmf_chip_attach()
@@ -3967,7 +3970,8 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 		goto fail;
 	}
 
-	bus->ci = brcmf_chip_attach(sdiodev, &brcmf_sdio_buscore_ops);
+	bus->ci = brcmf_chip_attach(sdiodev, sdiodev->func1->device,
+				    &brcmf_sdio_buscore_ops);
 	if (IS_ERR(bus->ci)) {
 		brcmf_err("brcmf_chip_attach failed!\n");
 		bus->ci = NULL;
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/soc.h b/drivers/net/wireless/broadcom/brcm80211/include/soc.h
index 92d942b44f2c..824921191366 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/soc.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/soc.h
@@ -6,7 +6,7 @@
 #ifndef	_BRCM_SOC_H
 #define	_BRCM_SOC_H
 
-#define SI_ENUM_BASE		0x18000000	/* Enumeration space base */
+#define SI_ENUM_BASE_DEFAULT	0x18000000
 
 /* Common core control flags */
 #define	SICF_BIST_EN		0x8000
-- 
2.27.0

