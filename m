Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38D3FA66E
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Aug 2021 17:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhH1PUD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Aug 2021 11:20:03 -0400
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:9368 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhH1PUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Aug 2021 11:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=PQdksHrrEUAosv4sUQmLo5SlZ0YKm2v3sLipoz4qRo8=;
        b=nCjNXsqpW8+nSyK+Cged+ar8WLSOLiGSgUz1AnhEy4CEoyq4gnDfE4xvUgbuY8vhf0jX
        0yy4tPvPVVLddwMV/aimTQMJFGp6kAbJhOq0Z7x/GTDzl6d5+vYnSdth7rZqUOHOzgbK5C
        PnS70Ldr14TvUI+U7/NoBR8D6nEg59ofeRLluDas+P43IQqDPuKBta7HI4WKOQvIVp2b3y
        nVBhQ1+9DrBS/uacnIoEMLkr5QYwamJe3egALdwgzDTwrbEQmRXYooUZSSdwj5dhj+srOt
        pfVeWKjUllyHKXGpq+5nZJ2nQ4lve59u1RVLApGfTnOZ2h8snuYhAD3odhOlVW3Q==
Received: by filterdrecv-7c9b89cc6f-d5wss with SMTP id filterdrecv-7c9b89cc6f-d5wss-1-612A53EF-2B
        2021-08-28 15:19:11.741570818 +0000 UTC m=+1350096.534804194
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-canary-0 (SG)
        with ESMTP
        id fZUiZXmERFiobl53QmrglQ
        Sat, 28 Aug 2021 15:19:11.547 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 9CCED70034D; Sat, 28 Aug 2021 09:19:10 -0600 (MDT)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2] wilc1000: Convert module-global "isinit" to
 device-specific variable
Date:   Sat, 28 Aug 2021 15:19:11 +0000 (UTC)
Message-Id: <20210828151346.3012697-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvGQOcDIo0v0Wt1nZY?=
 =?us-ascii?Q?nhFXmgKfSXYNH8DajXxCCVAqSzDilFOqxtsJ+dW?=
 =?us-ascii?Q?MbZor7W+CG4hIN7z9QVW+amCHPSanMsPqnhggrU?=
 =?us-ascii?Q?ib9La7SQTEUT=2F1zqlXVXdK7h=2FuI8Te4UUV70RTy?=
 =?us-ascii?Q?PezFS9nsMdE=2FXcBdBFW6vmV6y3P+pqwgmZo24+U?=
 =?us-ascii?Q?X5cvIc=2FxB715bFkMYekrA=3D=3D?=
To:     linux-wireless@vger.kernel.org
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move static "isinit" variable to wilc_spi structure to allow multiple
WILC1000 devices per machine.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 8b180c29d682..dd481dc0b5ce 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -39,6 +39,7 @@ MODULE_PARM_DESC(enable_crc16,
 #define WILC_SPI_RSP_HDR_EXTRA_DATA	8
 
 struct wilc_spi {
+	bool isinit;		/* true if SPI protocol has been configured */
 	bool probing_crc;	/* true if we're probing chip's CRC config */
 	bool crc7_enabled;	/* true if crc7 is currently enabled */
 	bool crc16_enabled;	/* true if crc16 is currently enabled */
@@ -908,15 +909,15 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 	struct wilc_spi *spi_priv = wilc->bus_data;
 	u32 reg;
 	u32 chipid;
-	static int isinit;
 	int ret, i;
 
-	if (isinit) {
+	if (spi_priv->isinit) {
+		/* Confirm we can read chipid register without error: */
 		ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
-		if (ret)
-			dev_err(&spi->dev, "Fail cmd read chip id...\n");
+		if (ret == 0)
+			return 0;
 
-		return ret;
+		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 	}
 
 	/*
@@ -974,7 +975,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 	spi_priv->probing_crc = false;
 
 	/*
-	 * make sure can read back chip id correctly
+	 * make sure can read chip id without protocol error
 	 */
 	ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
 	if (ret) {
@@ -982,7 +983,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 		return ret;
 	}
 
-	isinit = 1;
+	spi_priv->isinit = true;
 
 	return 0;
 }
-- 
2.25.1

