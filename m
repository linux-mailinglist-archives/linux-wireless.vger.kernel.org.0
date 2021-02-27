Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B777C326E6D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 18:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhB0Rfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 12:35:47 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:16094 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhB0Ram (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 12:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=/sxCVuo1phQGlqgitdXTs3sBeAsKQgb46SnH1ErepPY=;
        b=UeXx8ZqxcD1oQ13g8FFikknMRkfBnGCaTFg/TbcIOYbzow90RU2WfPEtyQjGf7akNhCE
        x193dFWE6IH+58sO9NWhnbI5VZoewyGyN83U1rKXER9fthnkP1zRqiIQiRE42VAe3h6lrr
        FYXSiOYduOqbqGtNZkBptaUTbjMC7T9MA=
Received: by filterdrecv-p3mdw1-7745b6f999-7qk4c with SMTP id filterdrecv-p3mdw1-7745b6f999-7qk4c-19-603A8171-41
        2021-02-27 17:29:21.995029806 +0000 UTC m=+918780.645593645
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-6-0 (SG)
        with ESMTP
        id 3yyHkenrTc-GkRejIBrKAw
        Sat, 27 Feb 2021 17:29:21.845 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 61BB37002F9; Sat, 27 Feb 2021 10:29:21 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 2/4] wilc1000: Introduce symbolic names for SPI protocol
 register
Date:   Sat, 27 Feb 2021 17:29:22 +0000 (UTC)
Message-Id: <20210227172818.1711071-2-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224055135.1509200-1-davidm@egauge.net>
References: <20210224055135.1509200-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvN4STzJuVgHn0iTxP?=
 =?us-ascii?Q?y=2FshASTM13G=2FwYCKvuiCyZmi1iT2YUsfJ0QvrW=2F?=
 =?us-ascii?Q?y1JwJ8FXk3mKARsm71Twn=2FXUFhBqMPKy8Lu0cS6?=
 =?us-ascii?Q?0rjC1wDkqBCOdbVtNzv5V0yJ0nhayclv6e9UwFt?=
 =?us-ascii?Q?Nys=2Ffwlhwglm1TK81kbcOM7m5mLRd2PQU275ii9?=
 =?us-ascii?Q?AJKeRvY0KAIimhrVVvxTg=3D=3D?=
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

The WILC1000 protocol control register has bits for enabling the CRCs
(CRC7 for commands and CRC16 for data) and to set the data packet
size.  Define symbolic names for those so the code is more easily
understood.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index d11e365eeee2..fca34d1999ec 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -46,12 +46,25 @@ static const struct wilc_hif_func wilc_hif_spi;
 #define CMD_RESET				0xcf
 
 #define SPI_ENABLE_VMM_RETRY_LIMIT		2
-#define DATA_PKT_SZ_256				256
-#define DATA_PKT_SZ_512				512
-#define DATA_PKT_SZ_1K				1024
-#define DATA_PKT_SZ_4K				(4 * 1024)
-#define DATA_PKT_SZ_8K				(8 * 1024)
-#define DATA_PKT_SZ				DATA_PKT_SZ_8K
+
+#define PROTOCOL_REG_PKT_SZ_MASK		GENMASK(6, 4)
+#define PROTOCOL_REG_CRC16_MASK			GENMASK(3, 3)
+#define PROTOCOL_REG_CRC7_MASK			GENMASK(2, 2)
+
+/*
+ * The SPI data packet size may be any integer power of two in the
+ * range from 256 to 8192 bytes.
+ */
+#define DATA_PKT_LOG_SZ_MIN			8	/* 256 B */
+#define DATA_PKT_LOG_SZ_MAX			13	/* 8 KiB */
+
+/*
+ * Select the data packet size (log2 of number of bytes): Use the
+ * maximum data packet size.  We only retransmit complete packets, so
+ * there is no benefit from using smaller data packets.
+ */
+#define DATA_PKT_LOG_SZ				DATA_PKT_LOG_SZ_MAX
+#define DATA_PKT_SZ				(1 << DATA_PKT_LOG_SZ)
 
 #define USE_SPI_DMA				0
 
@@ -827,9 +840,16 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 		}
 	}
 	if (spi_priv->crc_off == 0) {
-		reg &= ~0xc; /* disable crc checking */
-		reg &= ~0x70;
-		reg |= (0x5 << 4);
+		/* disable crc checking: */
+		reg &= ~(PROTOCOL_REG_CRC7_MASK | PROTOCOL_REG_CRC16_MASK);
+
+		/* set the data packet size: */
+		BUILD_BUG_ON(DATA_PKT_LOG_SZ < DATA_PKT_LOG_SZ_MIN
+			     || DATA_PKT_LOG_SZ > DATA_PKT_LOG_SZ_MAX);
+		reg &= ~PROTOCOL_REG_PKT_SZ_MASK;
+		reg |= FIELD_PREP(PROTOCOL_REG_PKT_SZ_MASK,
+				  DATA_PKT_LOG_SZ - DATA_PKT_LOG_SZ_MIN);
+
 		ret = spi_internal_write(wilc, WILC_SPI_PROTOCOL_OFFSET, reg);
 		if (ret) {
 			dev_err(&spi->dev,
-- 
2.25.1

