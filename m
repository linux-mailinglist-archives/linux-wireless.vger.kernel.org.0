Return-Path: <linux-wireless+bounces-2352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6D8375CC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 23:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7564F28CFBB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FCB482EA;
	Mon, 22 Jan 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="fvkOB2qE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8A482E3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961036; cv=none; b=j7TwwLwO3YvLMLc/oLeHGOLw7AgDzhzK4DjELp+VHkveCzdqcZSinzaLG0cSJWHvgPOqXxl3wbpAUSK5jgxcambq0PkWhl38t/Nn7eu7+HOUI/Sdhw/QkYIMzuuA5zd9YDyqjcH0WVPA+oTNe/CQc0XAvICfQutEajLX9tBIJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961036; c=relaxed/simple;
	bh=yAaxoI7arsvmoYxX7FZUPKm4d+oHrqitY/tDi+WemFU=;
	h=From:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=Xkw3SeA9dmmga0OsRUj9KLupHKo6oeltX6824IKYvNMrsAPjy2CXTPBF31kLnvxP4vlfG7TOJE9QcyT8iIXFGhHLNXNGJGkmSF6hH3SxSIVbSrWQFjflWIhzdyclDT7nt2Ps4Ph2sp01Synqz+aFtxH6EnjOE98O17c+qveVFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=fvkOB2qE; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=from:subject:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:from:subject:to;
	s=sgd; bh=138kXtYMlUrpZ1+NS22RdxTzVLj+tUe7swtkbk4iWPI=;
	b=fvkOB2qENiHePM2I1WAP0gzUyrcEgznnRQua0Q+mSPleaA3j4NfpeC0iifi0d86TXenO
	UELb6iyjPba4DyGcWXWc1FBFM85JLqCKQTA8Od437KL+2NsH2DgSbvB+0ocI8a6SN32oYA
	Fyxoi0shJNKtZL3VS+y8n1Z3I9ofZjiWfdpOqCsm8DFmUYs+/RNk1ZJhZgkfeH4hGxK2YF
	k4rtrScdrHKp6G1m4Jo0nC30Gk2ewZOQhjaTSHicPB5YUwe65aMrQzkBzyAggNqhYcyA8Y
	M8Q9vKjUbwG4VOiyLI7upcQBNL/NXVmkpXTuVhZpHC3AKPOjvq9mFQ6vQP31x50w==
Received: by filterdrecv-6b68c9f446-kzvqf with SMTP id filterdrecv-6b68c9f446-kzvqf-1-65AEE649-34
        2024-01-22 22:03:53.612028101 +0000 UTC m=+2202618.150716766
Received: from pearl.egauge.net (unknown)
	by geopod-ismtpd-11 (SG)
	with ESMTP
	id yvd9hQ-SQdGyxzO45YyFAw
	Mon, 22 Jan 2024 22:03:53.365 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
	id A885A700494; Mon, 22 Jan 2024 15:03:52 -0700 (MST)
From: David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wifi: wilc1000: validate chip id during bus probe
Date: Mon, 22 Jan 2024 22:03:53 +0000 (UTC)
Message-Id: <20240122220350.1449413-1-davidm@egauge.net>
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
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvNPyAZtdLu1SCtYuC?=
 =?us-ascii?Q?GnjVW0FzcJGJyBb0zDEeHAYVnyIOt+7SWA2NDo+?=
 =?us-ascii?Q?ugKBwP+tsULB90zVz=2FeZu6IxBK3NAPX56K1Sl3V?=
 =?us-ascii?Q?i9yZ4X5Yxnps1STonbY46cdO+H8u6vZxkZ9mvNZ?=
 =?us-ascii?Q?OBNltGvZuDAiTFL81TAbh9pXZqCc8d5vieKb0Qo?=
 =?us-ascii?Q?NDQVqylOZU4Ujuh81vBog=3D=3D?=
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
V2 -> V3: Add missing forward declarations, actually :-(

 drivers/net/wireless/microchip/wilc1000/spi.c | 133 ++++++++++++------
 .../net/wireless/microchip/wilc1000/wlan.h    |   1 +
 2 files changed, 90 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 77b4cdff73c3..dd6935dc1bc9 100644
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
@@ -232,6 +234,22 @@ static int wilc_bus_probe(struct spi_device *spi)
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
@@ -1074,58 +1092,43 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
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
@@ -1176,12 +1179,54 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 
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


