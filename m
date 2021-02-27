Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB4326E6C
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 18:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhB0Reh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 12:34:37 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:23958 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhB0Raq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 12:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=A0nyiQH89foVd5buQULuUX9sSu6emJdGHJKg04xVrkE=;
        b=cqtFi9Butba+3WHwkSSUYHiYmVtD56+FH2qNwL+f5WJo+RH4cjYYhvxTsznkAb8b/HUk
        xj/2d7ohugMaHjxdkygj2IXSiavQ9vXXPahPny8T3d58VoWX7OrXouB6rXHbPeBAxtCwtL
        PQF3FQ67NZLjGVSdrjZh1hvaJCvmQPPHQ=
Received: by filterdrecv-p3iad2-fdf5ff85d-l7rdf with SMTP id filterdrecv-p3iad2-fdf5ff85d-l7rdf-19-603A8189-3C
        2021-02-27 17:29:45.765782176 +0000 UTC m=+1536136.654393572
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-canary-0 (SG)
        with ESMTP
        id o3a_khVITRaV7NCD_YVfgQ
        Sat, 27 Feb 2021 17:29:45.547 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 038BE7002F9; Sat, 27 Feb 2021 10:29:45 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 3/4] wilc1000: Check for errors at end of DMA write
Date:   Sat, 27 Feb 2021 17:29:46 +0000 (UTC)
Message-Id: <20210227172818.1711071-3-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224055135.1509200-1-davidm@egauge.net>
References: <20210224055135.1509200-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvEXgQBWs9xCipqoFb?=
 =?us-ascii?Q?ZKGURIzqdaK16w70HkQ4OHG6IpCzbO03ln1Urcf?=
 =?us-ascii?Q?E6pmuEHQBAd6+TwGP36ZKeSAyb+N=2FBWtx0861Jf?=
 =?us-ascii?Q?bCexEnDc5tIp5Spk4tUhgtOHRVY5yAhXbQJRmOp?=
 =?us-ascii?Q?y6tRZyEuKFRtDgH0Dvm+IbhGA+2Jf6ON5p0URp8?=
 =?us-ascii?Q?VDdDXp=2Fgu0aLOqog8ayBA=3D=3D?=
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

After a DMA write to the WILC chip, check for and report any errors.

This is based on code from the wilc driver in the linux-at91
repository.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 62 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index fca34d1999ec..0be93eabad69 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -47,6 +47,17 @@ static const struct wilc_hif_func wilc_hif_spi;
 
 #define SPI_ENABLE_VMM_RETRY_LIMIT		2
 
+/* SPI response fields (section 11.1.2 in ATWILC1000 User Guide): */
+#define RSP_START_FIELD				GENMASK(7, 4)
+#define RSP_TYPE_FIELD				GENMASK(3, 0)
+
+/* SPI response values for the response fields: */
+#define RSP_START_TAG				0xc
+#define RSP_TYPE_FIRST_PACKET			0x1
+#define RSP_TYPE_INNER_PACKET			0x2
+#define RSP_TYPE_LAST_PACKET			0x3
+#define RSP_STATE_NO_ERROR			0x00
+
 #define PROTOCOL_REG_PKT_SZ_MASK		GENMASK(6, 4)
 #define PROTOCOL_REG_CRC16_MASK			GENMASK(3, 3)
 #define PROTOCOL_REG_CRC7_MASK			GENMASK(2, 2)
@@ -750,6 +761,52 @@ static int wilc_spi_write_reg(struct wilc *wilc, u32 addr, u32 data)
 	return 0;
 }
 
+static int spi_data_rsp(struct wilc *wilc, u8 cmd)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	int result, i;
+	u8 rsp[4];
+
+	/*
+	 * The response to data packets is two bytes long.  For
+	 * efficiency's sake, wilc_spi_write() wisely ignores the
+	 * responses for all packets but the final one.  The downside
+	 * of that optimization is that when the final data packet is
+	 * short, we may receive (part of) the response to the
+	 * second-to-last packet before the one for the final packet.
+	 * To handle this, we always read 4 bytes and then search for
+	 * the last byte that contains the "Response Start" code (0xc
+	 * in the top 4 bits).  We then know that this byte is the
+	 * first response byte of the final data packet.
+	 */
+	result = wilc_spi_rx(wilc, rsp, sizeof(rsp));
+	if (result) {
+		dev_err(&spi->dev, "Failed bus error...\n");
+		return result;
+	}
+
+	for (i = sizeof(rsp) - 2; i >= 0; --i)
+		if (FIELD_GET(RSP_START_FIELD, rsp[i]) == RSP_START_TAG)
+			break;
+
+	if (i < 0) {
+		dev_err(&spi->dev,
+			"Data packet response missing (%02x %02x %02x %02x)\n",
+			rsp[0], rsp[1], rsp[2], rsp[3]);
+		return -1;
+	}
+
+	/* rsp[i] is the last response start byte */
+
+	if (FIELD_GET(RSP_TYPE_FIELD, rsp[i]) != RSP_TYPE_LAST_PACKET
+	    || rsp[i + 1] != RSP_STATE_NO_ERROR) {
+		dev_err(&spi->dev, "Data response error (%02x %02x)\n",
+			rsp[i], rsp[i + 1]);
+		return -1;
+	}
+	return 0;
+}
+
 static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
 {
 	struct spi_device *spi = to_spi_device(wilc->dev);
@@ -777,7 +834,10 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
 		return result;
 	}
 
-	return 0;
+	/*
+	 * Data response
+	 */
+	return spi_data_rsp(wilc, CMD_DMA_EXT_WRITE);
 }
 
 /********************************************
-- 
2.25.1

