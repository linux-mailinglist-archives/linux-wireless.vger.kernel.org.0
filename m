Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765B32941B1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391924AbgJTRrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 13:47:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391882AbgJTRrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 13:47:10 -0400
Received: from localhost.localdomain ([73.69.170.31]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9npT-1kXyen3DGP-005tzh; Tue, 20 Oct 2020 19:47:09 +0200
From:   Remi Depommier <rde@setrix.com>
To:     linux-wireless@vger.kernel.org
Cc:     Remi Depommier <rde@setrix.com>
Subject: [PATCH] brcmfmac: fix SDIO access for big-endian host
Date:   Tue, 20 Oct 2020 13:46:39 -0400
Message-Id: <20201020174639.28892-1-rde@setrix.com>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:d5w5pNgT3fivxtAILjlMbDnau8lClpw4gZFM50s7PfsTyTT8sW3
 9aeHGlQusM4BAxHT3ywE2jv/EPuXWabUb4jC1Ta02GHzVAI/FDcL+AjbOF91FfnCPA/MFut
 CP9nwpoRzu4rKen+CZJ5EuqlaJKgUhkuogWulAE52vbNZIKUIwwxl8si38JWFKQPDXNo1ap
 sFeUm6fbJHLoTRKAZL96A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HC75mzGFcNg=:YnedPG/r0cIMK83KUey++G
 WGp2pJaaQjBXhqG71OP4wBCiy1TGH6Kok3th2302PfzJInSP+tQxyRtHM+uNMaaFbNQMkrwHb
 g7PvG1XsICPLr3c19bEMN5536sz92Wsi2v/9nVH/Rm6lZPgavUwGA+PrhucHzDi36n+ppNLT7
 +eAd/Lxy7XJ8oVLtHk1EnZIk+j2Lf+mhdl5Nu+8o6AEITmI3ErJFHZTFFRNynJX36xLjC3FJt
 4JX1+fUu5Og+3W6yOU+FDjEZ9USaiEgJ70BVUlu/NUbJpELtyF3F6vmrR6KnMrNR90c0pqnXy
 1Ppke9erXUosviX2w0cBY106wJ+fAig7Zm8VHiLjTyGDRcosLv1nT3Wkd3stJ9SRGV2xau2SV
 AP30ITEWjcQ9SPcHlZSLrrM+16P2A3jtnQwY6koV9SlJy8sOHR1/vbsBDHBos
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These full-mac chips use little-endian byte ordering. This patch
adds a few missing conversions to/from little-endian so that the
driver may be used with a big-endian host.

Signed-off-by: Remi Depommier <rde@setrix.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 3c07d1bbe1c6..307f1d70224d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1340,7 +1340,7 @@ static void brcmf_sdio_free_glom(struct brcmf_sdio *bus)
 static inline u8 brcmf_sdio_getdatoffset(u8 *swheader)
 {
 	u32 hdrvalue;
-	hdrvalue = *(u32 *)swheader;
+	hdrvalue = le32_to_cpu(*(__le32 *)swheader);
 	return (u8)((hdrvalue & SDPCM_DOFFSET_MASK) >> SDPCM_DOFFSET_SHIFT);
 }
 
@@ -1349,7 +1349,7 @@ static inline bool brcmf_sdio_fromevntchan(u8 *swheader)
 	u32 hdrvalue;
 	u8 ret;
 
-	hdrvalue = *(u32 *)swheader;
+	hdrvalue = le32_to_cpu(*(__le32 *)swheader);
 	ret = (u8)((hdrvalue & SDPCM_CHANNEL_MASK) >> SDPCM_CHANNEL_SHIFT);
 
 	return (ret == SDPCM_EVENT_CHANNEL);
@@ -3544,7 +3544,7 @@ static int brcmf_sdio_bus_preinit(struct device *dev)
 		/* otherwise, set txglomalign */
 		value = sdiodev->settings->bus.sdio.sd_sgentry_align;
 		/* SDIO ADMA requires at least 32 bit alignment */
-		value = max_t(u32, value, ALIGNMENT);
+		value = cpu_to_le32(max_t(u32, value, ALIGNMENT));
 		err = brcmf_iovar_data_set(dev, "bus:txglomalign", &value,
 					   sizeof(u32));
 	}
@@ -3555,7 +3555,7 @@ static int brcmf_sdio_bus_preinit(struct device *dev)
 	bus->tx_hdrlen = SDPCM_HWHDR_LEN + SDPCM_SWHDR_LEN;
 	if (sdiodev->sg_support) {
 		bus->txglom = false;
-		value = 1;
+		value = cpu_to_le32(1);
 		err = brcmf_iovar_data_set(bus->sdiodev->dev, "bus:rxglom",
 					   &value, sizeof(u32));
 		if (err < 0) {
-- 
2.17.1

