Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35718E88C
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 13:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCVMOY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 08:14:24 -0400
Received: from mx.sdf.org ([205.166.94.20]:55775 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgCVMOY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 08:14:24 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2020 08:14:23 EDT
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02MC48xc007050
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 22 Mar 2020 12:04:08 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02MC4847008847;
        Sun, 22 Mar 2020 12:04:08 GMT
Date:   Sun, 22 Mar 2020 12:04:08 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>
Cc:     linux-wireless@vger.kernel.org, lkml@sdf.org
Subject: [PATCH] wilc1000: Use crc7 in lib/ rather than a private copy
Message-ID: <20200322120408.GA19411@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The code in lib/ is the desired polynomial, and even includes
the 1-bit left shift in the table rather than needing to code
it explicitly.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: linux-wireless@vger.kernel.org
---
Just a drive-by fix I happened to spot.  Another possible bug I found in
the code is in wilc_wfi_cfg_tx_vendor_spec:

			get_random_bytes(&priv->p2p.local_random, 1);
			priv->p2p.local_random++;

What is the point of the increment?  Since local_random is an 8-bit
variable, the result is 8 random bits in the range [0..255], the same
thing that was there before the increment.

Also, I was thinking it could be replaced by prandom_u32(); does this
application call for crypto-grade randomness?

 drivers/staging/wilc1000/Kconfig |  1 +
 drivers/staging/wilc1000/spi.c   | 56 ++------------------------------
 2 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/wilc1000/Kconfig b/drivers/staging/wilc1000/Kconfig
index 59e58550d1397..09242cc7c04b7 100644
--- a/drivers/staging/wilc1000/Kconfig
+++ b/drivers/staging/wilc1000/Kconfig
@@ -22,6 +22,7 @@ config WILC1000_SPI
 	tristate "Atmel WILC1000 SPI (WiFi only)"
 	depends on CFG80211 && INET && SPI
 	select WILC1000
+	select CRC7
 	help
 	  This module adds support for the SPI interface of adapters using
 	  WILC1000 chipset. The Atmel WILC1000 has a Serial Peripheral
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.c
index 55f8757325f0f..431aee27e7212 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
+#include <linux/crc7.h>
 
 #include "netdev.h"
 #include "cfg80211.h"
@@ -18,59 +19,6 @@ struct wilc_spi {
 
 static const struct wilc_hif_func wilc_hif_spi;
 
-/********************************************
- *
- *      Crc7
- *
- ********************************************/
-
-static const u8 crc7_syndrome_table[256] = {
-	0x00, 0x09, 0x12, 0x1b, 0x24, 0x2d, 0x36, 0x3f,
-	0x48, 0x41, 0x5a, 0x53, 0x6c, 0x65, 0x7e, 0x77,
-	0x19, 0x10, 0x0b, 0x02, 0x3d, 0x34, 0x2f, 0x26,
-	0x51, 0x58, 0x43, 0x4a, 0x75, 0x7c, 0x67, 0x6e,
-	0x32, 0x3b, 0x20, 0x29, 0x16, 0x1f, 0x04, 0x0d,
-	0x7a, 0x73, 0x68, 0x61, 0x5e, 0x57, 0x4c, 0x45,
-	0x2b, 0x22, 0x39, 0x30, 0x0f, 0x06, 0x1d, 0x14,
-	0x63, 0x6a, 0x71, 0x78, 0x47, 0x4e, 0x55, 0x5c,
-	0x64, 0x6d, 0x76, 0x7f, 0x40, 0x49, 0x52, 0x5b,
-	0x2c, 0x25, 0x3e, 0x37, 0x08, 0x01, 0x1a, 0x13,
-	0x7d, 0x74, 0x6f, 0x66, 0x59, 0x50, 0x4b, 0x42,
-	0x35, 0x3c, 0x27, 0x2e, 0x11, 0x18, 0x03, 0x0a,
-	0x56, 0x5f, 0x44, 0x4d, 0x72, 0x7b, 0x60, 0x69,
-	0x1e, 0x17, 0x0c, 0x05, 0x3a, 0x33, 0x28, 0x21,
-	0x4f, 0x46, 0x5d, 0x54, 0x6b, 0x62, 0x79, 0x70,
-	0x07, 0x0e, 0x15, 0x1c, 0x23, 0x2a, 0x31, 0x38,
-	0x41, 0x48, 0x53, 0x5a, 0x65, 0x6c, 0x77, 0x7e,
-	0x09, 0x00, 0x1b, 0x12, 0x2d, 0x24, 0x3f, 0x36,
-	0x58, 0x51, 0x4a, 0x43, 0x7c, 0x75, 0x6e, 0x67,
-	0x10, 0x19, 0x02, 0x0b, 0x34, 0x3d, 0x26, 0x2f,
-	0x73, 0x7a, 0x61, 0x68, 0x57, 0x5e, 0x45, 0x4c,
-	0x3b, 0x32, 0x29, 0x20, 0x1f, 0x16, 0x0d, 0x04,
-	0x6a, 0x63, 0x78, 0x71, 0x4e, 0x47, 0x5c, 0x55,
-	0x22, 0x2b, 0x30, 0x39, 0x06, 0x0f, 0x14, 0x1d,
-	0x25, 0x2c, 0x37, 0x3e, 0x01, 0x08, 0x13, 0x1a,
-	0x6d, 0x64, 0x7f, 0x76, 0x49, 0x40, 0x5b, 0x52,
-	0x3c, 0x35, 0x2e, 0x27, 0x18, 0x11, 0x0a, 0x03,
-	0x74, 0x7d, 0x66, 0x6f, 0x50, 0x59, 0x42, 0x4b,
-	0x17, 0x1e, 0x05, 0x0c, 0x33, 0x3a, 0x21, 0x28,
-	0x5f, 0x56, 0x4d, 0x44, 0x7b, 0x72, 0x69, 0x60,
-	0x0e, 0x07, 0x1c, 0x15, 0x2a, 0x23, 0x38, 0x31,
-	0x46, 0x4f, 0x54, 0x5d, 0x62, 0x6b, 0x70, 0x79
-};
-
-static u8 crc7_byte(u8 crc, u8 data)
-{
-	return crc7_syndrome_table[(crc << 1) ^ data];
-}
-
-static u8 crc7(u8 crc, const u8 *buffer, u32 len)
-{
-	while (len--)
-		crc = crc7_byte(crc, *buffer++);
-	return crc;
-}
-
 /********************************************
  *
  *      Spi protocol Function
@@ -396,7 +344,7 @@ static int spi_cmd_complete(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz,
 		return result;
 
 	if (!spi_priv->crc_off)
-		wb[len - 1] = (crc7(0x7f, (const u8 *)&wb[0], len - 1)) << 1;
+		wb[len - 1] = crc7_be(0xfe, wb, len - 1);
 	else
 		len -= 1;
 
-- 
2.26.0.rc2
