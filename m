Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D847D326E73
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhB0Rkz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 12:40:55 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:56410 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhB0Rim (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 12:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=dbGM9Ma/J0GfxUvlXv6FpHJALfp6zLKoyWlQIibO2bc=;
        b=HWEZsw6DwjGQouBmb9H4MHeIVEREFjSU+/srydkGrzFSejjL3wQUD3IRmgyk5yS1qXrh
        X+9hWrawiXHkmyYDVg0/V1ssY4YpJsZVvK64DIjdJFNQCNeHOa1EoQ5tYhxvye/M5kCVMi
        wtFtlc7stUFviAHuBhNkAwwlN+4okxhXw=
Received: by filterdrecv-p3mdw1-7745b6f999-78kn7 with SMTP id filterdrecv-p3mdw1-7745b6f999-78kn7-18-603A81FA-62
        2021-02-27 17:31:38.801773744 +0000 UTC m=+918916.827550712
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-6-0 (SG)
        with ESMTP
        id jPk03aKkS3C0owCafpT2Hg
        Sat, 27 Feb 2021 17:31:38.686 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 545957002F9; Sat, 27 Feb 2021 10:31:38 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 4/4] wilc1000: Add support for enabling CRC
Date:   Sat, 27 Feb 2021 17:31:38 +0000 (UTC)
Message-Id: <20210227172818.1711071-4-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224055135.1509200-1-davidm@egauge.net>
References: <20210224055135.1509200-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvI75nYK6bFKlV9A80?=
 =?us-ascii?Q?6xibJBIvcmQtMolRIoByE7nj=2FLuqzYkuDQ=2FTFqX?=
 =?us-ascii?Q?XGyxjNOO0EMsnIAcVLZ6zM=2FOuAhXOnF2EdsSDkQ?=
 =?us-ascii?Q?=2FH1yBjbHSa1BjSd2fpE5WYOwL3=2FD4bDUT69MMiC?=
 =?us-ascii?Q?+Xuo2FwT938=2FnZORgtWD8bonW1lxXrDdzvqJWJP?=
 =?us-ascii?Q?F+iEqQ577L9TSmLCJFlww=3D=3D?=
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
data corruption that occurrs during the SPI transfers could go
undetected.  This patch adds module parameters enable_crc7 and
enable_crc16 to selectively turn on CRC7 (for command transfers) and
CRC16 (for data transfers), respectively.

The default configuration remains unchanged, with both CRC7 and CRC16
off.

The performance impact of CRC was measured by running ttcp -t four
times in a row on a SAMA5 device:

 CRC7 CRC16 Throughput: Standard deviation:
 ---- ----- ----------- -------------------
  off   off 1720 	+/- 48 KB/s
   on   off 1658 	+/- 58 KB/s
   on    on 1579 	+/- 84 KB/s

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 .../net/wireless/microchip/wilc1000/Kconfig   |   1 +
 drivers/net/wireless/microchip/wilc1000/spi.c | 178 +++++++++++-------
 2 files changed, 115 insertions(+), 64 deletions(-)

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
index 0be93eabad69..1472e9843896 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -7,10 +7,27 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/crc7.h>
+#include <linux/crc-itu-t.h>
 
 #include "netdev.h"
 #include "cfg80211.h"
 
+static bool enable_crc7;	/* protect SPI commands with CRC7 */
+module_param(enable_crc7, bool, 0644);
+MODULE_PARM_DESC(enable_crc7,
+		 "Enable CRC7 checksum to protect command transfers\n"
+		 "\t\t\tagainst corruption during the SPI transfer.\n"
+		 "\t\t\tCommand transfers are short and the CPU-cycle cost\n"
+		 "\t\t\tof enabling this is small.");
+
+static bool enable_crc16;	/* protect SPI data with CRC16 */
+module_param(enable_crc16, bool, 0644);
+MODULE_PARM_DESC(enable_crc16,
+		 "Enable CRC16 checksum to protect data transfers\n"
+		 "\t\t\tagainst corruption during the SPI transfer.\n"
+		 "\t\t\tData transfers can be large and the CPU-cycle cost\n"
+		 "\t\t\tof enabling this may be substantial.");
+
 /*
  * For CMD_SINGLE_READ and CMD_INTERNAL_READ, WILC may insert one or
  * more zero bytes between the command response and the DATA Start tag
@@ -22,7 +39,9 @@
 #define WILC_SPI_RSP_HDR_EXTRA_DATA	8
 
 struct wilc_spi {
-	int crc_off;
+	bool probing_crc;	/* true if we're probing chip's CRC config */
+	bool crc7_enabled;	/* true if crc7 is currently enabled */
+	bool crc16_enabled;	/* true if crc16 is currently enabled */
 };
 
 static const struct wilc_hif_func wilc_hif_spi;
@@ -314,7 +333,8 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32 sz)
 	struct wilc_spi *spi_priv = wilc->bus_data;
 	int ix, nbytes;
 	int result = 0;
-	u8 cmd, order, crc[2] = {0};
+	u8 cmd, order, crc[2];
+	u16 crc_calc;
 
 	/*
 	 * Data
@@ -356,9 +376,12 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32 sz)
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
@@ -392,11 +415,11 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
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
@@ -420,7 +443,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 	cmd_len = offsetof(struct wilc_spi_cmd, u.simple_cmd.crc);
 	resp_len = sizeof(*r) + sizeof(*r_data) + WILC_SPI_RSP_HDR_EXTRA_DATA;
 
-	if (!spi_priv->crc_off) {
+	if (spi_priv->crc7_enabled) {
 		c->u.simple_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 		cmd_len += 1;
 		resp_len += 2;
@@ -440,9 +463,10 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
 
 	r = (struct wilc_spi_rsp_data *)&rb[cmd_len];
 	if (r->rsp_cmd_type != cmd) {
-		dev_err(&spi->dev,
-			"Failed cmd response, cmd (%02x), resp (%02x)\n",
-			cmd, r->rsp_cmd_type);
+		if (!spi_priv->probing_crc)
+			dev_err(&spi->dev,
+				"Failed cmd, cmd (%02x), resp (%02x)\n",
+				cmd, r->rsp_cmd_type);
 		return -EINVAL;
 	}
 
@@ -466,8 +490,16 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
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
@@ -494,7 +526,7 @@ static int wilc_spi_write_cmd(struct wilc *wilc, u8 cmd, u32 adr, u32 data,
 		c->u.internal_w_cmd.addr[1] = adr;
 		c->u.internal_w_cmd.data = cpu_to_be32(data);
 		cmd_len = offsetof(struct wilc_spi_cmd, u.internal_w_cmd.crc);
-		if (!spi_priv->crc_off)
+		if (spi_priv->crc7_enabled)
 			c->u.internal_w_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 	} else if (cmd == CMD_SINGLE_WRITE) {
 		c->u.w_cmd.addr[0] = adr >> 16;
@@ -502,14 +534,14 @@ static int wilc_spi_write_cmd(struct wilc *wilc, u8 cmd, u32 adr, u32 data,
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
@@ -547,6 +579,7 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
 {
 	struct spi_device *spi = to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv = wilc->bus_data;
+	u16 crc_recv, crc_calc;
 	u8 wb[32], rb[32];
 	int cmd_len, resp_len;
 	int retry, ix = 0;
@@ -565,7 +598,7 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
 		c->u.dma_cmd.size[0] = sz >> 8;
 		c->u.dma_cmd.size[1] = sz;
 		cmd_len = offsetof(struct wilc_spi_cmd, u.dma_cmd.crc);
-		if (!spi_priv->crc_off)
+		if (spi_priv->crc7_enabled)
 			c->u.dma_cmd.crc[0] = wilc_get_crc7(wb, cmd_len);
 	} else if (cmd == CMD_DMA_EXT_WRITE || cmd == CMD_DMA_EXT_READ) {
 		c->u.dma_cmd_ext.addr[0] = adr >> 16;
@@ -575,14 +608,14 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
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
@@ -648,12 +681,22 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 sz)
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
+					"Failed block CRC read, bus err\n");
+				return -EINVAL;
+			}
+			crc_recv = (crc[0] << 8) | crc[1];
+			crc_calc = crc_itu_t(0xffff, &b[ix], nbytes);
+			if (crc_recv != crc_calc) {
+				dev_err(&spi->dev, "%s: bad CRC 0x%04x "
+					"(calculated 0x%04x)\n", __func__,
+					crc_recv, crc_calc);
+				return -EINVAL;
+			}
 		}
 
 		ix += nbytes;
@@ -720,11 +763,13 @@ static int spi_internal_write(struct wilc *wilc, u32 adr, u32 dat)
 static int spi_internal_read(struct wilc *wilc, u32 adr, u32 *data)
 {
 	struct spi_device *spi = to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv = wilc->bus_data;
 	int result;
 
 	result = wilc_spi_single_read(wilc, CMD_INTERNAL_READ, adr, data, 0);
 	if (result) {
-		dev_err(&spi->dev, "Failed internal read cmd...\n");
+		if (!spi_priv->probing_crc)
+			dev_err(&spi->dev, "Failed internal read cmd...\n");
 		return result;
 	}
 
@@ -861,7 +906,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 	u32 reg;
 	u32 chipid;
 	static int isinit;
-	int ret;
+	int ret, i;
 
 	if (isinit) {
 		ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
@@ -876,49 +921,54 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 	 */
 
 	/*
-	 * TODO: We can remove the CRC trials if there is a definite
-	 * way to reset
+	 * Infer the CRC settings that are currently in effect.  This
+	 * is necessary because we can't be sure that the chip has
+	 * been RESET (e.g, after module unload and reload).
 	 */
-	/* the SPI to it's initial value. */
-	ret = spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
-	if (ret) {
-		/*
-		 * Read failed. Try with CRC off. This might happen when module
-		 * is removed but chip isn't reset
-		 */
-		spi_priv->crc_off = 1;
-		dev_err(&spi->dev,
-			"Failed read with CRC on, retrying with CRC off\n");
+	spi_priv->probing_crc = true;
+	spi_priv->crc7_enabled = enable_crc7;
+	spi_priv->crc16_enabled = false; /* don't check CRC16 during probing */
+	for (i = 0; i < 2; ++i) {
 		ret = spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
-		if (ret) {
-			/*
-			 * Read failed with both CRC on and off,
-			 * something went bad
-			 */
-			dev_err(&spi->dev, "Failed internal read protocol\n");
-			return ret;
-		}
+		if (ret == 0)
+			break;
+		spi_priv->crc7_enabled = !enable_crc7;
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
+	if (ret) {
+		dev_err(&spi->dev, "Failed with CRC7 on and off.\n");
+		return ret;
+	}
+
+	/* set up the desired CRC configuration: */
+	reg &= ~(PROTOCOL_REG_CRC7_MASK | PROTOCOL_REG_CRC16_MASK);
+	if (enable_crc7)
+		reg |= PROTOCOL_REG_CRC7_MASK;
+	if (enable_crc16)
+		reg |= PROTOCOL_REG_CRC16_MASK;
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
+	/* update our state to match new protocol settings: */
+	spi_priv->crc7_enabled = enable_crc7;
+	spi_priv->crc16_enabled = enable_crc16;
+
+	/* re-read to make sure new settings are in effect: */
+	spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
+
+	spi_priv->probing_crc = false;
 
 	/*
 	 * make sure can read back chip id correctly
-- 
2.25.1

