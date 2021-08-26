Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC123F8F92
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhHZUSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:18:06 -0400
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:60399 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhHZUSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:18:05 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 16:18:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=nA/5adPJd7XQGCprDTpe1ev0havJA+mh+Hw7EJxmz1g=;
        b=DoVLS603nPFTo5dvDz/caFNQqpk7/L4x1xKI3qQE7QuQYmw8/qiDEDxWujZFXaEbm+WH
        ZPopnxMZDiAhrMc5e7dnuQNwVecnayc2EnonRausHdljGmvjaFd3mKCP1gotcus8W7PCWw
        aYJcm3XQUw1kKjIMaJnV4rfdiuHibSXmui/M7wLctkXjqlnnBxEd0zyXnXEAtv+a9eHEy5
        UrB+/oB2Hs6z4qkhXV9FsDlbpw7EBdnCIP9FRW26GXGhsuhyL8V1ZoqX6RAMvP6BJjrRF6
        d7emNAuipgIMxa8+wSBQyrbN4c/G4HuounoWVLIhP2joyAvuUazwA9rw3g+IWUVQ==
Received: by filterdrecv-5d6f795d94-zfqtq with SMTP id filterdrecv-5d6f795d94-zfqtq-1-6127F59E-38
        2021-08-26 20:12:15.015333425 +0000 UTC m=+1116456.455377867
Received: from pearl.egauge.net (unknown)
        by ismtpd0051p1las1.sendgrid.net (SG) with ESMTP
        id npW2G2tAR6-gOOGuPa0PRw
        Thu, 26 Aug 2021 20:12:14.775 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id DFB037002CD; Thu, 26 Aug 2021 14:12:13 -0600 (MDT)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wilc1000: Convert module-global "isinit" to device-specific
 variable
Date:   Thu, 26 Aug 2021 20:12:15 +0000 (UTC)
Message-Id: <20210826201127.2909616-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvNpSeVCv7TyanvJdQ?=
 =?us-ascii?Q?sinlSQWlq5TM1kVC5OtbcT7lFtI=2FhgdPe9tfj6U?=
 =?us-ascii?Q?6SPHml12e0987Qr=2FYKa3KqW0l2l7MWevV3uADY0?=
 =?us-ascii?Q?Pu6QR=2Fh8rQEc8VD3laEF17rPex0sfRoeJVRddaQ?=
 =?us-ascii?Q?W8LK4h61HjyLRlJdb96UHA5+5zAqiiQEZpJ6qyW?=
 =?us-ascii?Q?F+h7JbefhMaP8SmwJ5y9g=3D=3D?=
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

