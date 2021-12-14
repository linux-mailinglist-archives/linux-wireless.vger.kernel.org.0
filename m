Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DDA474828
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 17:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhLNQdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 11:33:24 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:24396 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhLNQdW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 11:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=YKirxG6CHpVK3733gG5FZmHPmsrKUthxnkRneucGCgw=;
        b=A7Bt9aTZHEEcFGpGJPHS/9i4n6JSKVF9v2Nlkg1arripnaR4A0X7wdlv1cJIxorcd0MX
        vu4w+m8gd8LEVVwSUDqGT+jRB0mU2ZDVd0yL+UUZfrcAEIhEZLwjD7wQ6gnqpkL5OCW1Q/
        M/yBH9SqFwnJRpSyTLcBHW5hUQ3A1VUehLjrhD1TC6XGfmtQHzP4d+Ew7YGCRrlY0iic6l
        VT6+aruy1RsBaJgLPGnes02heJdwRw7uJQ20/13uEsEHEx8BAgcOdsn9iD/l+KaTSc2B8H
        lcVqRXbdoIkec04h0+3EEix1jMjT5GvoIJBFG8FCqABSOctJmxlLRhnCwtdooMWg==
Received: by filterdrecv-656998cfdd-tjhxw with SMTP id filterdrecv-656998cfdd-tjhxw-1-61B8C750-99
        2021-12-14 16:33:20.975233689 +0000 UTC m=+7232761.515384775
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-6-1 (SG)
        with ESMTP
        id gvMLUwjWRMqJ4UCan4wi2w
        Tue, 14 Dec 2021 16:33:20.780 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 3E96C700311; Tue, 14 Dec 2021 09:33:20 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v4 1/2] wilc1000: Add reset/enable GPIO support to SPI driver
Date:   Tue, 14 Dec 2021 16:33:21 +0000 (UTC)
Message-Id: <20211214163315.3769677-2-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214163315.3769677-1-davidm@egauge.net>
References: <20211214163315.3769677-1-davidm@egauge.net>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvG+2bBk199qTQ9Y+y?=
 =?us-ascii?Q?8OdPepVB2E7=2FlVQog=2F8OV6APWhy6EICmrPKPqm+?=
 =?us-ascii?Q?Dze2FDGD7wECo7VnBAKwJF67WpXfFoNuuDUIvXp?=
 =?us-ascii?Q?fDjyXZBhyzNMji2YJ3ncHyb1tTRnDaDpWn0i=2Fn+?=
 =?us-ascii?Q?ZRQEYYXOF0wFhG9i+JkiuyMExL7siuM+=2FZ7Z6KG?=
 =?us-ascii?Q?Cf2b=2FZIx+waqZ91zFYFHA=3D=3D?=
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the SDIO driver, the RESET/ENABLE pins of WILC1000 are controlled
through the SDIO power sequence driver.  This commit adds analogous
support for the SPI driver.  Specifically, during initialization, the
chip will be ENABLEd and taken out of RESET and during
deinitialization, the chip will be placed back into RESET and disabled
(both to reduce power consumption and to ensure the WiFi radio is
off).

Both RESET and ENABLE GPIOs are optional.  However, if the ENABLE GPIO
is specified, then the RESET GPIO should normally also be specified as
otherwise there is no way to ensure proper timing of the ENABLE/RESET
sequence.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 58 ++++++++++++++++++-
 .../net/wireless/microchip/wilc1000/wlan.c    |  2 +-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 6e7fd18c14e7..0b4425e56bfa 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -8,6 +8,7 @@
 #include <linux/spi/spi.h>
 #include <linux/crc7.h>
 #include <linux/crc-itu-t.h>
+#include <linux/gpio/consumer.h>
 
 #include "netdev.h"
 #include "cfg80211.h"
@@ -43,6 +44,10 @@ struct wilc_spi {
 	bool probing_crc;	/* true if we're probing chip's CRC config */
 	bool crc7_enabled;	/* true if crc7 is currently enabled */
 	bool crc16_enabled;	/* true if crc16 is currently enabled */
+	struct wilc_gpios {
+		struct gpio_desc *enable;	/* ENABLE GPIO or NULL */
+		struct gpio_desc *reset;	/* RESET GPIO or NULL */
+	} gpios;
 };
 
 static const struct wilc_hif_func wilc_hif_spi;
@@ -152,6 +157,46 @@ struct wilc_spi_special_cmd_rsp {
 	u8 status;
 } __packed;
 
+static int wilc_parse_gpios(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv = wilc->bus_data;
+	struct wilc_gpios *gpios = &spi_priv->gpios;
+
+	/* get ENABLE pin and deassert it (if it is defined): */
+	gpios->enable = devm_gpiod_get_optional(&spi->dev,
+						"enable", GPIOD_OUT_LOW);
+	/* get RESET pin and assert it (if it is defined): */
+	if (gpios->enable) {
+		/* if enable pin exists, reset must exist as well */
+		gpios->reset = devm_gpiod_get(&spi->dev,
+					      "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(gpios->reset)) {
+			dev_err(&spi->dev, "missing reset gpio.\n");
+			return PTR_ERR(gpios->reset);
+		}
+	} else {
+		gpios->reset = devm_gpiod_get_optional(&spi->dev,
+						       "reset", GPIOD_OUT_HIGH);
+	}
+	return 0;
+}
+
+static void wilc_wlan_power(struct wilc *wilc, bool on)
+{
+	struct wilc_spi *spi_priv = wilc->bus_data;
+	struct wilc_gpios *gpios = &spi_priv->gpios;
+
+	if (on) {
+		gpiod_set_value(gpios->enable, 1);	/* assert ENABLE */
+		mdelay(5);
+		gpiod_set_value(gpios->reset, 0);	/* deassert RESET */
+	} else {
+		gpiod_set_value(gpios->reset, 1);	/* assert RESET */
+		gpiod_set_value(gpios->enable, 0);	/* deassert ENABLE */
+	}
+}
+
 static int wilc_bus_probe(struct spi_device *spi)
 {
 	int ret;
@@ -171,6 +216,10 @@ static int wilc_bus_probe(struct spi_device *spi)
 	wilc->bus_data = spi_priv;
 	wilc->dev_irq_num = spi->irq;
 
+	ret = wilc_parse_gpios(wilc);
+	if (ret < 0)
+		goto netdev_cleanup;
+
 	wilc->rtc_clk = devm_clk_get_optional(&spi->dev, "rtc");
 	if (IS_ERR(wilc->rtc_clk)) {
 		ret = PTR_ERR(wilc->rtc_clk);
@@ -984,9 +1033,10 @@ static int wilc_spi_reset(struct wilc *wilc)
 
 static int wilc_spi_deinit(struct wilc *wilc)
 {
-	/*
-	 * TODO:
-	 */
+	struct wilc_spi *spi_priv = wilc->bus_data;
+
+	spi_priv->isinit = false;
+	wilc_wlan_power(wilc, false);
 	return 0;
 }
 
@@ -1007,6 +1057,8 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 	}
 
+	wilc_wlan_power(wilc, true);
+
 	/*
 	 * configure protocol
 	 */
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 82566544419a..f1e4ac3a2ad5 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1253,7 +1253,7 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	wilc->rx_buffer = NULL;
 	kfree(wilc->tx_buffer);
 	wilc->tx_buffer = NULL;
-	wilc->hif_func->hif_deinit(NULL);
+	wilc->hif_func->hif_deinit(wilc);
 }
 
 static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
-- 
2.25.1

