Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48032370C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 06:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhBXFwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 00:52:49 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:13511 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhBXFwq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 00:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=Zh3Rdjov8qTVeX3tbNOAnAUj0VCwTpY2otvV0z8BLQ4=;
        b=TVx6MK5ZPt9I308GJ1gWgpxl9GeGBL813aLtn1c+v0sgul/Dbg6V8uWSMoSFu4aKZe71
        /5CF849RSDjK6K9XiZpCmhipltO8Z5ow+p2MH/GUA/M1H3fMT9bA4i11qlHOvR4agaj7XV
        0AwvOA7fiXqYXJ+mAMBz8+6oWts1eqAXs=
Received: by filterdrecv-p3iad2-fdf5ff85d-fcdlr with SMTP id filterdrecv-p3iad2-fdf5ff85d-fcdlr-19-6035E980-5
        2021-02-24 05:52:00.152484731 +0000 UTC m=+1235066.742630587
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-3-0 (SG)
        with ESMTP
        id Y5JuSazoSmep2omSJgEVhg
        Wed, 24 Feb 2021 05:51:59.992 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id ADBA37001EB; Tue, 23 Feb 2021 22:51:59 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH 4/4] wilc1000: Add support for enabling CRC
Date:   Wed, 24 Feb 2021 05:52:00 +0000 (UTC)
Message-Id: <20210224055135.1509200-4-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224055135.1509200-1-davidm@egauge.net>
References: <20210224055135.1509200-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvGCCkyeX0TOi4Kmui?=
 =?us-ascii?Q?=2FR4Lk80b3oD6LhU+wPeB7EWYAMC8dhlTcmywbO9?=
 =?us-ascii?Q?UW9QiOL+B3ASfMwZxKveH1bSyS4o9aHRi0dBnHo?=
 =?us-ascii?Q?8yGBDMhceVgN6vkTUMaInbCXxN3jD3yig5ws29v?=
 =?us-ascii?Q?TmaRfshDZL6szCa6WUagz=2F9YPYjqrvrla9ZnO6P?=
 =?us-ascii?Q?m6lUWzKKcuOF8d+uq61tQ=3D=3D?=
To:     linux-wireless@vger.kernel.org
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        davidm@egauge.net
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver so far has always disabled CRC protection.  This means any
data corruption that occurred during the SPI transfers could
potentially go unnoticed.  This patch adds the macros ENABLE_CRC7 and
ENABLE_CRC16 to allow compile-time selection of whether or not CRC7
and CRC16, respectively, should be enabled.

The default configuration remains unchanged, with both CRC7 and CRC16
off.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 .../net/wireless/microchip/wilc1000/Kconfig   |   1 +
 drivers/net/wireless/microchip/wilc1000/spi.c | 151 +++++++++++++-----
 2 files changed, 108 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/Kconfig b/drivers/net/wireless/microchip/wilc1000/Kconfig
index 7f15e42602dd..62cfcdc9aacc 100644
--- a/drivers/net/wireless/microchip/wilc1000/Kconfig
+++ b/drivers/net/wireless/microchip/wilc1000/Kconfig
@@ -27,6 +27,7 @@ config WILC1000_SPI
 	depends on CFG80211 && INET && SPI
 	select WILC1000
 	select CRC7
+	select CRC_ITU_T
 	help
 	  This module adds support for the SPI interface of adapters using
 	  WILC1000 chipset. The Atmel WILC1000 has a Serial Peripheral
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index b0e096a03a28..c745a440d273 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -7,10 +7,23 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/crc7.h>
+#include <linux/crc-itu-t.h>
 
 #include "netdev.h"
 #include "cfg80211.h"
 
+/**
+ * Establish the driver's desired CRC configuration.  CRC7 is used for
+ * command transfers which have no other protection against corruption
+ * during the SPI transfer.  Commands are short so CRC7 is relatively
+ * cheap.  CRC16 is used for data transfers, including network packet
+ * transfers.  Since those transfers can be large, CRC16 is relatively
+ * expensive.  CRC16 is also often redundant as network packets
+ * typically are protected by their own, higher-level checksum.
+ */
+#define ENABLE_CRC7	0	/* set to 1 to protect SPI commands with CRC7 */
+#define ENABLE_CRC16	0	/* set to 1 to protect SPI data with CRC16 */
+
 /*
  * For CMD_SINGLE_READ and CMD_INTERNAL_READ, WILC may insert one or
  * more zero bytes between the command response and the DATA Start tag
@@ -22,7 +35,8 @@
 #define WILC_SPI_RSP_HDR_EXTRA_DATA	8
 
 struct wilc_spi {
-	int crc_off;
+	bool crc7_enabled;
+	bool crc16_enabled;
 };
 
 static const struct wilc_hif_func wilc_hif_spi;
@@ -123,6 +137,10 @@ static int wilc_bus_probe(struct spi_device *spi)
 	if (!spi_priv)
 		return -ENOMEM;
 
+	/* WILC chip resets to both CRCs enabled: */
+	spi_priv->crc7_enabled = true;
+	spi_priv->crc16_enabled = true;
+
 	ret = wilc_cfg80211_init(&wilc, &spi->dev, WILC_HIF_SPI, &wilc_hif_spi);
 	if (ret) {
 		kfree(spi_priv);
@@ -303,7 +321,8 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32 sz)
 	struct wilc_spi *spi_priv = wilc->bus_data;
 	int ix, nbytes;
 	int result = 0;
-	u8 cmd, order, crc[2] = {0};
+	u8 cmd, order, crc[2];
+	u16 crc_calc;
 
 	/*
 	 * Data
@@ -345,9 +364,12 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32 sz)
 		}
 
 		/*
-		 * Write Crc
+		 * Write CRC
 		 */
-		if (!spi_priv->crc_off) {
+		if (spi_priv->crc16_enabled) {
+			crc_calc = crc_itu_t(0xffff, &b[ix], nbytes);
+			crc[0] = crc_calc >> 8;
+			crc[1] = crc_calc;
 			if (wilc_spi_tx(wilc, crc, 2)) {
 				dev_err(&spi->dev, "Failed data block crc write, bus error...\n");
 				result = -EINVAL;
@@ -381,11 +403,11 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 	struct spi_device *spi = to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv = wilc->bus_data;
 	u8 wb[32], rb[32];
-	u8 crc[2];
 	int cmd_len, resp_len, i;
+	u16 crc_calc, crc_recv;
 	struct wilc_spi_cmd *c;
-	struct wilc_spi_read_rsp_data *r_data;
 	struct wilc_spi_rsp_data *r;
+	struct wilc_spi_read_rsp_data *r_data;
 
 	memset(wb, 0x0, sizeof(wb));
 	memset(rb, 0x0, sizeof(rb));
@@ -409,7 +431,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 	cmd_len = offsetof(struct wilc_spi_cmd, u.simple_cmd.crc);
 	resp_len = sizeof(*r) + sizeof(*r_data) + WILC_SPI_RSP_HDR_EXTRA_DATA;
 
-	if (!spi_priv->crc_off) {
+	if (spi_priv->crc7_enabled) {
 		c->u.simple_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 		cmd_len += 1;
 		resp_len += 2;
@@ -455,8 +477,16 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 	if (b)
 		memcpy(b, r_data->data, 4);
 
-	if (!spi_priv->crc_off)
-		memcpy(crc, r_data->crc, 2);
+	if (!clockless && spi_priv->crc16_enabled) {
+		crc_recv = (r_data->crc[0] << 8) | r_data->crc[1];
+		crc_calc = crc_itu_t(0xffff, r_data->data, 4);
+		if (crc_recv != crc_calc) {
+			dev_err(&spi->dev, "%s: bad CRC 0x%04x "
+				"(calculated 0x%04x)\n", __func__,
+				crc_recv, crc_calc);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -483,7 +513,7 @@ static int wilc_spi_write_cmd(struct wilc *wilc, u8 cmd, u32 adr, u32 data,
 		c->u.internal_w_cmd.addr[1] = adr;
 		c->u.internal_w_cmd.data = cpu_to_be32(data);
 		cmd_len = offsetof(struct wilc_spi_cmd, u.internal_w_cmd.crc);
-		if (!spi_priv->crc_off)
+		if (spi_priv->crc7_enabled)
 			c->u.internal_w_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 	} else if (cmd == CMD_SINGLE_WRITE) {
 		c->u.w_cmd.addr[0] = adr >> 16;
@@ -491,14 +521,14 @@ static int wilc_spi_write_cmd(struct wilc *wilc, u8 cmd, u32 adr, u32 data,
 		c->u.w_cmd.addr[2] = adr;
 		c->u.w_cmd.data = cpu_to_be32(data);
 		cmd_len = offsetof(struct wilc_spi_cmd, u.w_cmd.crc);
-		if (!spi_priv->crc_off)
+		if (spi_priv->crc7_enabled)
 			c->u.w_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 	} else {
 		dev_err(&spi->dev, "write cmd [%x] not supported\n", cmd);
 		return -EINVAL;
 	}
 
-	if (!spi_priv->crc_off)
+	if (spi_priv->crc7_enabled)
 		cmd_len += 1;
 
 	resp_len = sizeof(*r);
@@ -536,6 +566,7 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
 {
 	struct spi_device *spi = to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv = wilc->bus_data;
+	u16 crc_recv, crc_calc;
 	u8 wb[32], rb[32];
 	int cmd_len, resp_len;
 	int retry, ix = 0;
@@ -554,7 +585,7 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
 		c->u.dma_cmd.size[0] = sz >> 8;
 		c->u.dma_cmd.size[1] = sz;
 		cmd_len = offsetof(struct wilc_spi_cmd, u.dma_cmd.crc);
-		if (!spi_priv->crc_off)
+		if (spi_priv->crc7_enabled)
 			c->u.dma_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 	} else if (cmd == CMD_DMA_EXT_WRITE || cmd == CMD_DMA_EXT_READ) {
 		c->u.dma_cmd_ext.addr[0] = adr >> 16;
@@ -564,14 +595,14 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
 		c->u.dma_cmd_ext.size[1] = sz >> 8;
 		c->u.dma_cmd_ext.size[2] = sz;
 		cmd_len = offsetof(struct wilc_spi_cmd, u.dma_cmd_ext.crc);
-		if (!spi_priv->crc_off)
+		if (spi_priv->crc7_enabled)
 			c->u.dma_cmd_ext.crc[0] = wilc_get_crc7(wb, cmd_len);
 	} else {
 		dev_err(&spi->dev, "dma read write cmd [%x] not supported\n",
 			cmd);
 		return -EINVAL;
 	}
-	if (!spi_priv->crc_off)
+	if (spi_priv->crc7_enabled)
 		cmd_len += 1;
 
 	resp_len = sizeof(*r);
@@ -637,12 +668,35 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
 		}
 
 		/*
-		 * Read Crc
+		 * Read CRC
 		 */
-		if (!spi_priv->crc_off && wilc_spi_rx(wilc, crc, 2)) {
-			dev_err(&spi->dev,
-				"Failed block crc read, bus err\n");
-			return -EINVAL;
+		if (spi_priv->crc16_enabled) {
+			if (wilc_spi_rx(wilc, crc, 2)) {
+				dev_err(&spi->dev,
+					"Failed block crc read, bus err\n");
+				return -EINVAL;
+			}
+			crc_recv = (crc[0] << 8) | crc[1];
+			crc_calc = crc_itu_t(0xffff, &b[ix], nbytes);
+			if (crc_recv != crc_calc) {
+				dev_err(&spi->dev, "%s: bad CRC 0x%04x "
+					"(calculated 0x%04x)\n", __func__,
+					crc_recv, crc_calc);
+
+				{
+					u8 byte;
+					int i;
+
+					for (i = 0; i < 16384; ++i) {
+						byte = 0;
+						wilc_spi_rx(wilc, &byte, 1);
+						if (!byte)
+							break;
+					}
+				}
+
+				return -EINVAL;
+			}
 		}
 
 		ix += nbytes;
@@ -871,43 +925,52 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 	ret = spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
 	if (ret) {
 		/*
-		 * Read failed. Try with CRC off. This might happen when module
-		 * is removed but chip isn't reset
+		 * Read failed. Try with CRC7 off. This might happen
+		 * when module is removed but chip isn't reset.
 		 */
-		spi_priv->crc_off = 1;
+		spi_priv->crc7_enabled = false;
 		dev_err(&spi->dev,
-			"Failed read with CRC on, retrying with CRC off\n");
+			"Failed read with CRC7 on, retrying with CRC7 off\n");
 		ret = spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
 		if (ret) {
 			/*
-			 * Read failed with both CRC on and off,
+			 * Read failed with both CRC7 on and off,
 			 * something went bad
 			 */
 			dev_err(&spi->dev, "Failed internal read protocol\n");
 			return ret;
 		}
 	}
-	if (spi_priv->crc_off == 0) {
-		/* disable crc checking: */
-		reg &= ~(PROTOCOL_REG_CRC7_MASK | PROTOCOL_REG_CRC16_MASK);
-
-		/* set the data packet size: */
-		BUILD_BUG_ON(DATA_PKT_LOG_SZ < DATA_PKT_LOG_SZ_MIN
-			     || DATA_PKT_LOG_SZ > DATA_PKT_LOG_SZ_MAX);
-		reg &= ~PROTOCOL_REG_PKT_SZ_MASK;
-		reg |= FIELD_PREP(PROTOCOL_REG_PKT_SZ_MASK,
-				  DATA_PKT_LOG_SZ - DATA_PKT_LOG_SZ_MIN);
-
-		ret = spi_internal_write(wilc, WILC_SPI_PROTOCOL_OFFSET, reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"[wilc spi %d]: Failed internal write reg\n",
-				__LINE__);
-			return ret;
-		}
-		spi_priv->crc_off = 1;
+
+	/* set up the desired CRC configuration: */
+	reg &= ~(PROTOCOL_REG_CRC7_MASK | PROTOCOL_REG_CRC16_MASK);
+#if ENABLE_CRC7
+	reg |= PROTOCOL_REG_CRC7_MASK;
+#endif
+#if ENABLE_CRC16
+	reg |= PROTOCOL_REG_CRC16_MASK;
+#endif
+
+	/* set up the data packet size: */
+	BUILD_BUG_ON(DATA_PKT_LOG_SZ < DATA_PKT_LOG_SZ_MIN
+		     || DATA_PKT_LOG_SZ > DATA_PKT_LOG_SZ_MAX);
+	reg &= ~PROTOCOL_REG_PKT_SZ_MASK;
+	reg |= FIELD_PREP(PROTOCOL_REG_PKT_SZ_MASK,
+			  DATA_PKT_LOG_SZ - DATA_PKT_LOG_SZ_MIN);
+
+	/* establish the new setup: */
+	ret = spi_internal_write(wilc, WILC_SPI_PROTOCOL_OFFSET, reg);
+	if (ret) {
+		dev_err(&spi->dev,
+			"[wilc spi %d]: Failed internal write reg\n",
+			__LINE__);
+		return ret;
 	}
 
+	/* now that new set up is established, update our state to match: */
+	spi_priv->crc7_enabled = ENABLE_CRC7;
+	spi_priv->crc16_enabled = ENABLE_CRC16;
+
 	/*
 	 * make sure can read back chip id correctly
 	 */
-- 
2.25.1

