Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D92B3AB2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Nov 2020 01:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgKPARG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Nov 2020 19:17:06 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:33463 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgKPARG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Nov 2020 19:17:06 -0500
Received: from localhost.localdomain ([73.69.170.31]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3bfB-1kEA1j03SF-010go5; Mon, 16 Nov 2020 01:17:04 +0100
From:   Remi Depommier <rde@setrix.com>
To:     linux-wireless@vger.kernel.org
Cc:     Remi Depommier <rde@setrix.com>
Subject: [PATCH] brcmfmac: Fix incorrect type in assignment
Date:   Sun, 15 Nov 2020 19:16:39 -0500
Message-Id: <20201116001639.31958-1-rde@setrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020174639.28892-1-rde@setrix.com>
References: <20201020174639.28892-1-rde@setrix.com>
X-Provags-ID: V03:K1:ZVPpl/DFdzIMmTHyZdHBgPbbVNuJcWYZk/2fY4sGFGVhJc4Rx9q
 A6ZSLBoUlTUkf1gpj0zjb4/mDZrq2wMlcjbbB+j2GsKT7F4oOqIZFNc2H2dyuSA/Eq/eyKu
 muTjnbavXgSvwuzATBgpKy1QZIG+6Whp9IgiUzomECTnoqtE4LMNkv65kzwsCLz70rB04KK
 hE/ZLZl7nWEJx4Z+tBl5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hr/HtPmWryI=:Sc2rSJliK7J/OlxwVGcldG
 KqlK9zYso5ylsj1FetOiJbG5AUHFUaB2zu5qPuVGIz6+toAhErtXw2JLU/G+7o15QXvtEYNWK
 5fi3Ku0BC/CDEfRoEu598/+b5UQplPmU8yMJkEsJs9JlAXxSW+V3LG7s02iGRWF5/AduLghz1
 2W2taB0CPdQdR4mPd/ZYFQGK/c7h8OlKz1QQTx8xc9XMaafQOVUteGiRxYi9NDyQ/1qKJ6DDA
 9aaq4kJ1QtN1tdvSQ99ndoWJQQ1UNhCQancYY3pfiIU0K2TdV84s0y11hgP72zGksY35nkN3R
 YMqViUz4suHKkX/2Vrqt5O1Hx4YzKU6vtAEctUW3ayduIwuTy+ch0gg8F9yy06JwRM+bE23kX
 pW3QR+bfzWyToNHjm/gNCUE4FIJZXrPOoFNzEgbnn/pdRU0h4FwVfPF1gcJyq
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The left-hand side of the assignment from cpu_to_le32() should be of
type __le32. This commit clears the warning reported by sparse when
building with C=1 CF="-D__CHECK_ENDIAN__".

Fixes: d56fd83cf99c ("brcmfmac: fix SDIO access for big-endian host")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Remi Depommier <rde@setrix.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index f58a96fa4eb5..805e8d121d00 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3517,6 +3517,7 @@ static int brcmf_sdio_bus_preinit(struct device *dev)
 	struct brcmf_sdio *bus = sdiodev->bus;
 	struct brcmf_core *core = bus->sdio_core;
 	u32 value;
+	__le32 iovar;
 	int err;
 
 	/* maxctl provided by common layer */
@@ -3537,16 +3538,16 @@ static int brcmf_sdio_bus_preinit(struct device *dev)
 	 */
 	if (core->rev < 12) {
 		/* for sdio core rev < 12, disable txgloming */
-		value = 0;
-		err = brcmf_iovar_data_set(dev, "bus:txglom", &value,
-					   sizeof(u32));
+		iovar = 0;
+		err = brcmf_iovar_data_set(dev, "bus:txglom", &iovar,
+					   sizeof(iovar));
 	} else {
 		/* otherwise, set txglomalign */
 		value = sdiodev->settings->bus.sdio.sd_sgentry_align;
 		/* SDIO ADMA requires at least 32 bit alignment */
-		value = cpu_to_le32(max_t(u32, value, ALIGNMENT));
-		err = brcmf_iovar_data_set(dev, "bus:txglomalign", &value,
-					   sizeof(u32));
+		iovar = cpu_to_le32(max_t(u32, value, ALIGNMENT));
+		err = brcmf_iovar_data_set(dev, "bus:txglomalign", &iovar,
+					   sizeof(iovar));
 	}
 
 	if (err < 0)
@@ -3555,9 +3556,9 @@ static int brcmf_sdio_bus_preinit(struct device *dev)
 	bus->tx_hdrlen = SDPCM_HWHDR_LEN + SDPCM_SWHDR_LEN;
 	if (sdiodev->sg_support) {
 		bus->txglom = false;
-		value = cpu_to_le32(1);
+		iovar = cpu_to_le32(1);
 		err = brcmf_iovar_data_set(bus->sdiodev->dev, "bus:rxglom",
-					   &value, sizeof(u32));
+					   &iovar, sizeof(iovar));
 		if (err < 0) {
 			/* bus:rxglom is allowed to fail */
 			err = 0;
-- 
2.17.1

