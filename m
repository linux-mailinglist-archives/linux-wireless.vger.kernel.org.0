Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252E847F7FB
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Dec 2021 16:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhLZPkf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Dec 2021 10:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhLZPkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Dec 2021 10:40:23 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08674C06175B;
        Sun, 26 Dec 2021 07:40:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 30CBE44B24;
        Sun, 26 Dec 2021 15:40:13 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH 28/34] brcmfmac: pcie: Replace brcmf_pcie_copy_mem_todev with memcpy_toio
Date:   Mon, 27 Dec 2021 00:36:18 +0900
Message-Id: <20211226153624.162281-29-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211226153624.162281-1-marcan@marcan.st>
References: <20211226153624.162281-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The alignment check was wrong (e.g. & 4 instead of & 3), and the logic
was also inefficient if the length was not a multiple of 4, since it
would needlessly fall back to copying the entire buffer bytewise.

We already have a perfectly good memcpy_toio function, so just call that
instead of rolling our own copy logic here. brcmf_pcie_init_ringbuffers
was already using it anyway.

Fixes: 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 53 +++----------------
 1 file changed, 6 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 0d073087b01b..6cf55027e0d7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -13,6 +13,7 @@
 #include <linux/bcma/bcma.h>
 #include <linux/sched.h>
 #include <linux/random.h>
+#include <linux/io.h>
 #include <asm/unaligned.h>
 
 #include <soc.h>
@@ -559,47 +560,6 @@ brcmf_pcie_write_ram32(struct brcmf_pciedev_info *devinfo, u32 mem_offset,
 }
 
 
-static void
-brcmf_pcie_copy_mem_todev(struct brcmf_pciedev_info *devinfo, u32 mem_offset,
-			  void *srcaddr, u32 len)
-{
-	void __iomem *address = devinfo->tcm + mem_offset;
-	__le32 *src32;
-	__le16 *src16;
-	u8 *src8;
-
-	if (((ulong)address & 4) || ((ulong)srcaddr & 4) || (len & 4)) {
-		if (((ulong)address & 2) || ((ulong)srcaddr & 2) || (len & 2)) {
-			src8 = (u8 *)srcaddr;
-			while (len) {
-				iowrite8(*src8, address);
-				address++;
-				src8++;
-				len--;
-			}
-		} else {
-			len = len / 2;
-			src16 = (__le16 *)srcaddr;
-			while (len) {
-				iowrite16(le16_to_cpu(*src16), address);
-				address += 2;
-				src16++;
-				len--;
-			}
-		}
-	} else {
-		len = len / 4;
-		src32 = (__le32 *)srcaddr;
-		while (len) {
-			iowrite32(le32_to_cpu(*src32), address);
-			address += 4;
-			src32++;
-			len--;
-		}
-	}
-}
-
-
 static void
 brcmf_pcie_copy_dev_tomem(struct brcmf_pciedev_info *devinfo, u32 mem_offset,
 			  void *dstaddr, u32 len)
@@ -1697,8 +1657,8 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		return err;
 
 	brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
-	brcmf_pcie_copy_mem_todev(devinfo, devinfo->ci->rambase,
-				  (void *)fw->data, fw->size);
+	memcpy_toio(devinfo->tcm + devinfo->ci->rambase,
+		    (void *)fw->data, fw->size);
 
 	resetintr = get_unaligned_le32(fw->data);
 	release_firmware(fw);
@@ -1719,7 +1679,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		brcmf_dbg(PCIE, "Download NVRAM %s\n", devinfo->nvram_name);
 		address = devinfo->ci->rambase + devinfo->ci->ramsize -
 			  nvram_len;
-		brcmf_pcie_copy_mem_todev(devinfo, address, nvram, nvram_len);
+		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
 		/* Some Apple chips/firmwares expect a buffer of random data
@@ -1728,13 +1688,12 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		brcmf_dbg(PCIE, "Download random seed\n");
 
 		address -= sizeof(footer);
-		brcmf_pcie_copy_mem_todev(devinfo, address, &footer,
-					  sizeof(footer));
+		memcpy_toio(devinfo->tcm + address, &footer, sizeof(footer));
 
 		address -= rand_len;
 		randbuf = kzalloc(rand_len, GFP_KERNEL);
 		get_random_bytes(randbuf, rand_len);
-		brcmf_pcie_copy_mem_todev(devinfo, address, randbuf, rand_len);
+		memcpy_toio(devinfo->tcm + address, randbuf, rand_len);
 		kfree(randbuf);
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
-- 
2.33.0

