Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155121497E4
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2020 22:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgAYVOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jan 2020 16:14:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgAYVOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jan 2020 16:14:39 -0500
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jan 2020 16:14:39 EST
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B470A60479;
        Sat, 25 Jan 2020 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579986346;
        bh=S8t1shDOxQsCDC+mRLnA8090MNnNzFhLJnNdqrRe8ms=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ytRz3+w5Y2FhrjYw9tO1z5KyexGwsaPfc3L4XgHPaGw4dznEV8dLggDh3XAuE+QcI
         O1Sozze36ULeRYrkkRmkCZbx/Un476K1y7jsAozm1gAVCQ/z0FJ4wPifuvlRz3NZqm
         vYjKdq5p5wYbc2mratbXiDIGbvLV3Xb+yczst8efoRQC+gQPItyU/L/19Ek0uQE7do
         1vgJ1BuxKOswOPp7yeP+FFmRg7TEu5P0pk9UhNcoSOkd1zvHplSs5fVzSFwIy54x9U
         BrZfhL8zLcfoBoomp4ck5NHm+7ANDopJCntLjbdf0FrPSJL9JCRCeusY0mUQmSaIwT
         41mg3INYXroxE+UNCb3WKP6RW0SC+ZmGWMsk5BLVyBsqTEYGmde5hFVc9we+h0kAXW
         w25ZKUexOikdP/kTmMMRLO6VUP0EEtfg+gp0xvZ0bpeuUImvGgHCFk0K0DGaCf85PR
         a5wFPYyj7W0zO+++39/lHlXNawSHgIiiYL+sqRW6VHHmNixsrsl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Subject: [PATCH] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
Date:   Sat, 25 Jan 2020 21:05:14 +0000
Message-Id: <20200125210514.126312-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 2018 13" MacBook Pro (MacBookPro15,2) has a Broadcom chip, the 4364.
This chip appears to be specific to Apple and is not found in other
hardware.

Add this chip to the brcmfmac driver so that it can be recognized
automatically.  Note that the PCI device id is 4464 even though the chip
is referred to as the 4364.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
As far as I know, no firmware is shipped in a Linux firmware package for
this card, but it can be copied from macOS.  The rambase address was
found by trial and error.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 3 +++
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index dd586a96b57a..fa2282a4b29e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -687,6 +687,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4366_CHIP_ID:
 	case BRCM_CC_43664_CHIP_ID:
 		return 0x200000;
+	case BRCM_CC_4364_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
 	default:
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 6c463475e90b..1e63dafb964a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -52,6 +52,7 @@ BRCMF_FW_DEF(4356, "brcmfmac4356-pcie");
 BRCMF_FW_DEF(43570, "brcmfmac43570-pcie");
 BRCMF_FW_DEF(4358, "brcmfmac4358-pcie");
 BRCMF_FW_DEF(4359, "brcmfmac4359-pcie");
+BRCMF_FW_DEF(4364, "brcmfmac4364-pcie");
 BRCMF_FW_DEF(4365B, "brcmfmac4365b-pcie");
 BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
@@ -70,6 +71,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43570_CHIP_ID, 0xFFFFFFFF, 43570),
 	BRCMF_FW_ENTRY(BRCM_CC_4358_CHIP_ID, 0xFFFFFFFF, 4358),
 	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
+	BRCMF_FW_ENTRY(BRCM_CC_4364_CHIP_ID, 0xFFFFFFFF, 4364),
 	BRCMF_FW_ENTRY(BRCM_CC_4365_CHIP_ID, 0x0000000F, 4365B),
 	BRCMF_FW_ENTRY(BRCM_CC_4365_CHIP_ID, 0xFFFFFFF0, 4365C),
 	BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0x0000000F, 4366B),
@@ -2105,6 +2107,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_2G_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_5G_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_RAW_DEVICE_ID),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4364_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_2G_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_5G_DEVICE_ID),
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index d1037b6ef2d6..c6c4be05159d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -44,6 +44,7 @@
 #define BRCM_CC_4358_CHIP_ID		0x4358
 #define BRCM_CC_4359_CHIP_ID		0x4359
 #define BRCM_CC_43602_CHIP_ID		43602
+#define BRCM_CC_4364_CHIP_ID		0x4364
 #define BRCM_CC_4365_CHIP_ID		0x4365
 #define BRCM_CC_4366_CHIP_ID		0x4366
 #define BRCM_CC_43664_CHIP_ID		43664
@@ -74,6 +75,7 @@
 #define BRCM_PCIE_43602_2G_DEVICE_ID	0x43bb
 #define BRCM_PCIE_43602_5G_DEVICE_ID	0x43bc
 #define BRCM_PCIE_43602_RAW_DEVICE_ID	43602
+#define BRCM_PCIE_4364_DEVICE_ID	0x4464
 #define BRCM_PCIE_4365_DEVICE_ID	0x43ca
 #define BRCM_PCIE_4365_2G_DEVICE_ID	0x43cb
 #define BRCM_PCIE_4365_5G_DEVICE_ID	0x43cc
