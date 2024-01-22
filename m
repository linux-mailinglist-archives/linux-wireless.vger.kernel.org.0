Return-Path: <linux-wireless+bounces-2351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0C8375C8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 23:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB761C2206C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EC482F1;
	Mon, 22 Jan 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="M/elnQB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBE482EF
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960911; cv=none; b=q6b3vXftgV+7eoLZOuW6QNAlHtteRvkau7+AdtIfsWoSYgLfchFNBq1nd88yVtDA8j+XzkfGQGlHPgR6/AYwhhCehzMRYDY9gYMSNzIFF2Y5Ei7JT46Vc3M+tgX1CH2U0qIuXr9LH4bDhHAjKPhI4APSOBGFP8a9RiCehR2/Ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960911; c=relaxed/simple;
	bh=/dVl64iKYQ54+b07XG15WG2le/SASutKdSehbvjQSxQ=;
	h=From:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=opnV0yyHNlH4MCL9tA4h9O4o6kLhKVvmtLkJjmJCKE9K8lhSKRj2n0cAMsHzIEGp/LheDvJNHUcQfK7gg7rw5/9PaODkPbBi9kd/BRgQplEDLL2Rn3uD+EMHC2/1KJqP/bWH07CP0zjW7X2eLeN+QaUnNdxErNhXNArvyVU0Qi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=M/elnQB7; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=from:subject:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:from:subject:to;
	s=sgd; bh=u+XXGbzEn6hrw4MnO5y+i7ufxwDA2vbM+qF0F9qd17A=;
	b=M/elnQB7+K6SBHRFDMc9IuOb93yIHlx1bSw3gsV+b2TDFitzyXIwaEUwJ1SG94Obuoir
	HJPGK3e1o8Elnwq+F6FQ6GyefomJZkqAVPjdBlr+6v8BsOO5As7ZzSRmk8Wm3uR9zaod9J
	vlJA7MGsGeBeOz9Hjxrk23F8Qq5XQhLYCQkk6GrEbz/hRuim+f65aRdA+F7QQrNvE1Qc9U
	RFSmieyW77NtvFcnO63C8g5qpywGVDfJBEZW5BNT24wrPaBrk7cTOPnEhJZxGOrZ0fENCH
	oO6XYU4pKf/Jx6XVuHxe4LcqX1vf9j+ZJQuB+iqY395m02mvvyTWDliiRtDNtrfw==
Received: by filterdrecv-5bbdbb56cd-khxc7 with SMTP id filterdrecv-5bbdbb56cd-khxc7-1-65AEE5CB-30
        2024-01-22 22:01:47.997340678 +0000 UTC m=+981894.856206069
Received: from pearl.egauge.net (unknown)
	by geopod-ismtpd-canary-0 (SG)
	with ESMTP
	id jj3dpCKiSLWOxZu_SIZmvQ
	Mon, 22 Jan 2024 22:01:47.825 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
	id 2E2D3700494; Mon, 22 Jan 2024 15:01:47 -0700 (MST)
From: David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wifi: wilc1000: validate chip id during bus probe
Date: Mon, 22 Jan 2024 22:01:48 +0000 (UTC)
Message-Id: <20240122220137.1448644-1-davidm@egauge.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122211315.1444880-2-davidm@egauge.net>
References: <20240122211315.1444880-2-davidm@egauge.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvIJT5aWrlcwUuIWn4?=
 =?us-ascii?Q?ryjBpQINwf5U+Zjf7htBmZwMrK6LqAC43SZ1DoW?=
 =?us-ascii?Q?NIqeiUi523GSc0GQcboTaEw4W0N63NACQGFYeKH?=
 =?us-ascii?Q?SbimsrvsZd9YYOklAJsdlyvUpMjiQ+ci07DLeJY?=
 =?us-ascii?Q?ZEuFFJR=2F7LdVjJHWUSQBvyQaOQOCirA2g642Hdk?=
 =?us-ascii?Q?oiMs6U6ADBMVMZqb9QtSw=3D=3D?=
To: linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com, kvalo@kernel.org,
	David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

Previously, the driver created a net device (typically wlan0) as soon
as the module was loaded.  This commit changes the driver to follow
normal Linux convention of creating the net device only when bus
probing detects a supported chip.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
V1 -> V2: Add missing forward declarations.

 drivers/net/wireless/microchip/wilc1000/spi.c | 131 ++++++++++++------
 .../net/wireless/microchip/wilc1000/wlan.h    |   1 +
 2 files changed, 88 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 77b4cdff73c3..263ca8b2c764 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -42,7 +42,7 @@ MODULE_PARM_DESC(enable_crc16,
 #define WILC_SPI_RSP_HDR_EXTRA_DATA	8
 
 struct wilc_spi {
-	bool isinit;		/* true if SPI protocol has been configured */
+	bool isinit;		/* true if wilc_spi_init was successful */
 	bool probing_crc;	/* true if we're probing chip's CRC config */
 	bool crc7_enabled;	/* true if crc7 is currently enabled */
 	bool crc16_enabled;	/* true if crc16 is currently enabled */
@@ -232,6 +232,22 @@ static int wilc_bus_probe(struct spi_device *spi)
 	}
 	clk_prepare_enable(wilc->rtc_clk);
 
+	/* we need power to configure the bus protocol and to read the chip id: */
+
+	wilc_wlan_power(wilc, true);
+
+	ret = wilc_spi_configure_bus_protocol(wilc);
+
+	if (ret == 0)
+		ret = wilc_validate_chipid(wilc);
+
+	wilc_wlan_power(wilc, false);
+
+	if (ret) {
+		ret = -ENODEV;
+		goto netdev_cleanup;
+	}
+
 	return 0;
 
 netdev_cleanup:
@@ -1074,58 +1090,43 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
  *
  ********************************************/
 
-static int wilc_spi_reset(struct wilc *wilc)
+static const char *
+strbool(bool val)
 {
-	struct spi_device *spi = to_spi_device(wilc->dev);
-	struct wilc_spi *spi_priv = wilc->bus_data;
-	int result;
-
-	result = wilc_spi_special_cmd(wilc, CMD_RESET);
-	if (result && !spi_priv->probing_crc)
-		dev_err(&spi->dev, "Failed cmd reset\n");
-
-	return result;
-}
-
-static bool wilc_spi_is_init(struct wilc *wilc)
-{
-	struct wilc_spi *spi_priv = wilc->bus_data;
-
-	return spi_priv->isinit;
+	return val ? "on" : "off";
 }
 
-static int wilc_spi_deinit(struct wilc *wilc)
+static int wilc_validate_chipid(struct wilc *wilc)
 {
-	struct wilc_spi *spi_priv = wilc->bus_data;
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	u32 chipid, base_id;
+	int ret;
 
-	spi_priv->isinit = false;
-	wilc_wlan_power(wilc, false);
+	/*
+	 * make sure can read chip id without protocol error
+	 */
+	ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
+	if (ret) {
+		dev_err(&spi->dev, "Fail cmd read chip id...\n");
+		return ret;
+	}
+	base_id = chipid & ~WILC_CHIP_REV_FIELD;
+	if (base_id != WILC_1000_BASE_ID && base_id != WILC_3000_BASE_ID) {
+		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
+		return ret;
+	}
+	dev_info(&spi->dev, "Detected chip id 0x%x (crc7=%s, crc16=%s)\n",
+		 chipid, strbool(enable_crc7), strbool(enable_crc16));
 	return 0;
 }
 
-static int wilc_spi_init(struct wilc *wilc, bool resume)
+static int wilc_spi_configure_bus_protocol(struct wilc *wilc)
 {
 	struct spi_device *spi = to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv = wilc->bus_data;
 	u32 reg;
-	u32 chipid;
 	int ret, i;
 
-	if (spi_priv->isinit) {
-		/* Confirm we can read chipid register without error: */
-		ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
-		if (ret == 0)
-			return 0;
-
-		dev_err(&spi->dev, "Fail cmd read chip id...\n");
-	}
-
-	wilc_wlan_power(wilc, true);
-
-	/*
-	 * configure protocol
-	 */
-
 	/*
 	 * Infer the CRC settings that are currently in effect.  This
 	 * is necessary because we can't be sure that the chip has
@@ -1176,12 +1177,54 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 
 	spi_priv->probing_crc = false;
 
-	/*
-	 * make sure can read chip id without protocol error
-	 */
-	ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
+	return 0;
+}
+
+static int wilc_spi_reset(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv = wilc->bus_data;
+	int result;
+
+	result = wilc_spi_special_cmd(wilc, CMD_RESET);
+	if (result && !spi_priv->probing_crc)
+		dev_err(&spi->dev, "Failed cmd reset\n");
+
+	return result;
+}
+
+static bool wilc_spi_is_init(struct wilc *wilc)
+{
+	struct wilc_spi *spi_priv = wilc->bus_data;
+
+	return spi_priv->isinit;
+}
+
+static int wilc_spi_deinit(struct wilc *wilc)
+{
+	struct wilc_spi *spi_priv = wilc->bus_data;
+
+	spi_priv->isinit = false;
+	wilc_wlan_power(wilc, false);
+	return 0;
+}
+
+static int wilc_spi_init(struct wilc *wilc, bool resume)
+{
+	struct wilc_spi *spi_priv = wilc->bus_data;
+	int ret;
+
+	if (spi_priv->isinit) {
+		/* Confirm we can read chipid register without error: */
+		if (wilc_validate_chipid(wilc) == 0)
+			return 0;
+	}
+
+	wilc_wlan_power(wilc, true);
+
+	ret = wilc_spi_configure_bus_protocol(wilc);
 	if (ret) {
-		dev_err(&spi->dev, "Fail cmd read chip id...\n");
+		wilc_wlan_power(wilc, false);
 		return ret;
 	}
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index a72cd5cac81d..43dda9f0d9ca 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -182,6 +182,7 @@
 #define WILC_CORTUS_BOOT_FROM_IRAM	0x71
 
 #define WILC_1000_BASE_ID		0x100000
+#define WILC_3000_BASE_ID		0x300000
 
 #define WILC_1000_BASE_ID_2A		0x1002A0
 #define WILC_1000_BASE_ID_2A_REV1	(WILC_1000_BASE_ID_2A + 1)
-- 
2.34.1


