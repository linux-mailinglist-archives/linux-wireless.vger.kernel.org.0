Return-Path: <linux-wireless+bounces-2590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0E83E8AA
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6EAB251FA
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC694422;
	Sat, 27 Jan 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="tohBj06J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEA23D8
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316240; cv=none; b=KkLZwsrm2LZDoXH6j2yVCvg+1dbqlr+WGh5ys3v7I5LcNLgOomPS3HbKVlUNCofCIvp5/7i4XsDoW9bl2aYhMuBvT2/EQqrnDytM8EF0poVRzFnJnCKaoq68S6CdSFPm68at9n2u19lqNiZpUaXotgDaBSS/iCwK1N47EMe8xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316240; c=relaxed/simple;
	bh=RSoyG1EVcOsSXM1YteCFUpIpQ0RfBRBD2WLcj3FheHs=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=lnkO8oJHb3nUPShCUqKq5F2P8lUH9HOkCk5FH9ssOKc834t102cQkoPMvljSTV31s/ExC4ARh1CWMPi+ZbSbWKn6mBd9j4geXvOU+kUIdGJd7H+/jMNJ39lDxGUji/lI6UNYIcB+w7lcU5ATTurUKR615OzQ3lwrqFMm8UYfUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=tohBj06J; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=sgd; bh=9knJHSUsebqv2yNUSZUAf8+qncEpNf5bOSzZiOLEYh8=;
	b=tohBj06JFr9Q2lbE6zTAWmJd1+Q/4QCErge+JcI2YJBvNXZZOQu2O6jINRNmklKwXPN8
	6OFESHLqhJcjr4HPxth5VsdTY9durqtV4U4FxZtt2eW6VVNMabYTFEwabAOlWgHTnhgUwO
	Z2EqZfa8amfvepQUFKTgIJSYryQ9SMjY0Mn5chdr988qe+xVIh4MzesR1htYaGIyB3qFvI
	LA5ncTuSwg2L7kNGcFJGr9AfWcmyCYEcEFgrMAOrXDBfHvQvz8PIIM9eH4a7R26IIl5pxT
	jN3Hp1itOIy9709I7fR1OkuQRY6LiXTKzlkXlUDjuvwY6FZPJjs4//pwaZ5CUj0g==
Received: by recvd-6c4f9c464b-9kmf2 with SMTP id recvd-6c4f9c464b-9kmf2-1-65B451CD-1
	2024-01-27 00:43:57.069160927 +0000 UTC m=+98191.035494384
Received: from pearl.egauge.net (unknown)
	by geopod-ismtpd-13 (SG)
	with ESMTP
	id WmKzDRFNSpqleuM-GwnPeA
	Sat, 27 Jan 2024 00:43:56.962 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
	id 2353270074C; Fri, 26 Jan 2024 17:43:56 -0700 (MST)
From: David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
Date: Sat, 27 Jan 2024 00:43:57 +0000 (UTC)
Message-Id: <20240127004331.1334804-1-davidm@egauge.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvCrwgtcdLxuEPSo6H?=
 =?us-ascii?Q?0nWG=2FdtJ3WuVUqI8AhaBBwdV+4sv617LlFeHK4P?=
 =?us-ascii?Q?rnOhHOp0YWaLB7YZJJpOrNuAjf765648d3kR7IU?=
 =?us-ascii?Q?76M6vq80vpTpn9OktKXOZASp85leHb4Yua5+7H9?=
 =?us-ascii?Q?JT=2FG07hi3hcd3tZQWs0Q24dCtbETxnI=2FQGez05=2F?=
 =?us-ascii?Q?YXTF4WmY1yh5yWabkZxPw=3D=3D?=
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
changelog:
V1: original version
V2: Add missing forward declarations
V3: Add missing forward declarations, actually :-(
V4: - rearranged function order to improve readability
    - now relative to wireless-next repository
    - avoid change error return value and have lower-level functions
      directly return -ENODEV instead
    - removed any mention of WILC3000
    - export and use existing is_wilc1000() for chipid validation
    - replaced strbool() function with open code

 drivers/net/wireless/microchip/wilc1000/spi.c | 74 ++++++++++++++-----
 .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.h    |  1 +
 3 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 77b4cdff73c3..6496a19a337e 100644
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
@@ -55,6 +55,8 @@ struct wilc_spi {
 static const struct wilc_hif_func wilc_hif_spi;
 
 static int wilc_spi_reset(struct wilc *wilc);
+static int wilc_spi_configure_bus_protocol(struct wilc *wilc);
+static int wilc_validate_chipid(struct wilc *wilc);
 
 /********************************************
  *
@@ -232,8 +234,26 @@ static int wilc_bus_probe(struct spi_device *spi)
 	}
 	clk_prepare_enable(wilc->rtc_clk);
 
+	dev_info(&spi->dev, "Selected CRC config: crc7=%s, crc16=%s\n",
+		 enable_crc7 ? "on" : "off", enable_crc16 ? "on" : "off");
+
+	/* we need power to configure the bus protocol and to read the chip id: */
+
+	wilc_wlan_power(wilc, true);
+
+	ret = wilc_spi_configure_bus_protocol(wilc);
+	if (ret)
+		goto power_down;
+
+	ret = wilc_validate_chipid(wilc);
+	if (ret)
+		goto power_down;
+
+	wilc_wlan_power(wilc, false);
 	return 0;
 
+power_down:
+	wilc_wlan_power(wilc, false);
 netdev_cleanup:
 	wilc_netdev_cleanup(wilc);
 free:
@@ -1105,26 +1125,34 @@ static int wilc_spi_deinit(struct wilc *wilc)
 
 static int wilc_spi_init(struct wilc *wilc, bool resume)
 {
-	struct spi_device *spi = to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv = wilc->bus_data;
-	u32 reg;
-	u32 chipid;
-	int ret, i;
+	int ret;
 
 	if (spi_priv->isinit) {
 		/* Confirm we can read chipid register without error: */
-		ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
-		if (ret == 0)
+		if (wilc_validate_chipid(wilc) == 0)
 			return 0;
-
-		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 	}
 
 	wilc_wlan_power(wilc, true);
 
-	/*
-	 * configure protocol
-	 */
+	ret = wilc_spi_configure_bus_protocol(wilc);
+	if (ret) {
+		wilc_wlan_power(wilc, false);
+		return ret;
+	}
+
+	spi_priv->isinit = true;
+
+	return 0;
+}
+
+static int wilc_spi_configure_bus_protocol(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv = wilc->bus_data;
+	u32 reg;
+	int ret, i;
 
 	/*
 	 * Infer the CRC settings that are currently in effect.  This
@@ -1142,7 +1170,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 	}
 	if (ret) {
 		dev_err(&spi->dev, "Failed with CRC7 on and off.\n");
-		return ret;
+		return -ENODEV;
 	}
 
 	/* set up the desired CRC configuration: */
@@ -1165,7 +1193,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 		dev_err(&spi->dev,
 			"[wilc spi %d]: Failed internal write reg\n",
 			__LINE__);
-		return ret;
+		return -ENODEV;
 	}
 	/* update our state to match new protocol settings: */
 	spi_priv->crc7_enabled = enable_crc7;
@@ -1176,17 +1204,27 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 
 	spi_priv->probing_crc = false;
 
+	return 0;
+}
+
+static int wilc_validate_chipid(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	u32 chipid;
+	int ret;
+
 	/*
 	 * make sure can read chip id without protocol error
 	 */
 	ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
 	if (ret) {
 		dev_err(&spi->dev, "Fail cmd read chip id...\n");
-		return ret;
+		return -ENODEV;
+	}
+	if (!is_wilc1000(chipid)) {
+		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
+		return -ENODEV;
 	}
-
-	spi_priv->isinit = true;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 6b2f2269ddf8..3130a3ea8d71 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -12,10 +12,11 @@
 
 #define WAKE_UP_TRIAL_RETRY		10000
 
-static inline bool is_wilc1000(u32 id)
+bool is_wilc1000(u32 id)
 {
 	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
 }
+EXPORT_SYMBOL_GPL(is_wilc1000);
 
 static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index f02775f7e41f..ebdfb0afaf71 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -409,6 +409,7 @@ struct wilc_cfg_rsp {
 
 struct wilc_vif;
 
+bool is_wilc1000(u32 id);
 int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
-- 
2.34.1


