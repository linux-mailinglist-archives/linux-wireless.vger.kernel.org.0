Return-Path: <linux-wireless+bounces-3485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC12851E97
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 21:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FE82810EE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43B4BAA6;
	Mon, 12 Feb 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="kxcrefig"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D514879B
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769353; cv=none; b=CM54n1Rh2ifHe4Qpra9XgXFTuYfhfna9cIFUllfl3IpRvxMmHty0Z4FDxgBJI/10VW55CyFY6CnFlT/LskwLrIc/wc8Cuo9lBcFawWIQus9PmbPyOt6u8+CkZa4RnSt2y0I5PdnR/T21H/nkPzQ8BxlAN2vSqG5GrQgqpV3lHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769353; c=relaxed/simple;
	bh=kxRsc1ahLK7/sa6/fpi9wTUktKTRzWb0C9NfvvgMr9M=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=gJUTFnl87c6UplE4Y5oFUL8F88X0UV+UzAZFKhdR89GnlASKhHu3Jp0m/i94aKt8CgmgV3jAIA18CG8c5XRdPDvfQXe+Chc3uCFS8oThFXofxJyZsVfW9c3Jk0wNm2UhQuoCOKs0KF1RKwOS8h8wrnk50KDWzLWx2b3M1vDN6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=kxcrefig; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=sgd; bh=b0njXKltkYXy1nBHNL23uZZf0jVXS+iGT2+BFztYM7Q=;
	b=kxcrefigfmXWsqGZEJRpNRmqyimhNpLpByx7D/1wbFnDBaEhxz/HwXv8BIBHTyO6jNKw
	xCeGWxXN7EIea9EfHKgNym1ZNyHgTd9qs4YMXxD+0jwg6//fo8xZsTz4M7yeODhywrtAYI
	SoyG6wE0rZy/nJgTU5JVL9KEsZNhdItUWXR2DJZYwip3Kv+6qPA1LnfUsjgyeqwCeJ5a9m
	NoaWemb54j4yUtsS7bLZjCWxw0+vKE22daTr7wfm7nNEYHYS5sgNRX9Lui2jKbLZhToNeG
	2gzotqLw/ebDbm0dFYa8e82tSctKK0AZUm0bXNydom77aZFpm/OT6SarfpfL+xHw==
Received: by recvd-bf96468bd-qrlsn with SMTP id recvd-bf96468bd-qrlsn-1-65CA7E05-11
	2024-02-12 20:22:29.871591865 +0000 UTC m=+862655.717277031
Received: from pearl.egauge.net (unknown)
	by geopod-ismtpd-12 (SG)
	with ESMTP
	id I7x_F1A0QaWZRxFLeKXNGQ
	Mon, 12 Feb 2024 20:22:29.735 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
	id B227E700396; Mon, 12 Feb 2024 13:22:28 -0700 (MST)
From: David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wifi: wilc1000: validate chip id during bus probe
Date: Mon, 12 Feb 2024 20:22:30 +0000 (UTC)
Message-Id: <20240212202057.3468714-1-davidm@egauge.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvOcNhbRrrdy9LoByE?=
 =?us-ascii?Q?oZyn+ouMW98YM74yFgDM5r1vQPbzJQ4beBzvrHy?=
 =?us-ascii?Q?dJeO95bZWYWwOeMUIS+9WOWzl=2FePYNDtT=2FQd9YM?=
 =?us-ascii?Q?bPeJxnEFdLtn9lCuV12F5=2Fqob4n3SXW6cd=2FwgXm?=
 =?us-ascii?Q?gfgwqku7w5BGhkDKGGdLpNL52B9Lg4aqDK0vUPw?=
 =?us-ascii?Q?pjeOr+DeUofJn0dO=2FZHiw=3D=3D?=
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
V5: - add clk_disable_unprepare() to power_down path as suggested by Ajay
    - don't re-write error codes as suggested by Alexi
V6: - define is_wilc1000() as an inline function since it is trivial and
      does not warrant an EXPORT_SYMBOL_GPL() entry (suggested by Kalle)

 drivers/net/wireless/microchip/wilc1000/spi.c | 69 +++++++++++++++----
 .../net/wireless/microchip/wilc1000/wlan.c    |  5 --
 .../net/wireless/microchip/wilc1000/wlan.h    |  5 ++
 3 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index c92ee4b73a74..3c4451535c8a 100644
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
@@ -232,8 +234,27 @@ static int wilc_bus_probe(struct spi_device *spi)
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
+	clk_disable_unprepare(wilc->rtc_clk);
+	wilc_wlan_power(wilc, false);
 netdev_cleanup:
 	wilc_netdev_cleanup(wilc);
 free:
@@ -1102,26 +1123,34 @@ static int wilc_spi_deinit(struct wilc *wilc)
 
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
@@ -1173,6 +1202,15 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 
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
@@ -1181,9 +1219,10 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 		return ret;
 	}
-
-	spi_priv->isinit = true;
-
+	if (!is_wilc1000(chipid)) {
+		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
+		return -ENODEV;
+	}
 	return 0;
 }
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 6b2f2269ddf8..68be233c36ce 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -12,11 +12,6 @@
 
 #define WAKE_UP_TRIAL_RETRY		10000
 
-static inline bool is_wilc1000(u32 id)
-{
-	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
-}
-
 static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
 	mutex_lock(&wilc->hif_cs);
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index f02775f7e41f..54643d8fef04 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -409,6 +409,11 @@ struct wilc_cfg_rsp {
 
 struct wilc_vif;
 
+static inline bool is_wilc1000(u32 id)
+{
+	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
+}
+
 int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
-- 
2.34.1


