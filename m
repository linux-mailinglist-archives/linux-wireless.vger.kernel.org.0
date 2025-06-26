Return-Path: <linux-wireless+bounces-24554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60633AEA023
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DBB1C45C9C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2A2EA492;
	Thu, 26 Jun 2025 14:12:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFB2E975F;
	Thu, 26 Jun 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947172; cv=none; b=QU34gY1WZPu4cUwHHC6gAMSCDqXs/gDri0djVVRaImquR6le00pqNLwDJjKFv77XBBduJjnXGxaurR6WYgL6WNZf++RqRAhAZ0X8X8331BXrzoj8+mxWnj5PGXcx6fM1SztTgfL/YbIN58PcDzshtmJ7gx13TE5UrfDKQdxWYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947172; c=relaxed/simple;
	bh=O0n5PkvYZHuE+ymEljfo8kaBgOXB9iTy2XFyl6J2Z4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M82cYxWkV67VFsxWWfLuXV/1+Gqk2LSbiDYO5rkUdLRlryMR9jNwZTRblnIlOanEuZZw8fLlVyeu+rTldH95E4p/XmBQhSnGGb7SO5MOQc0Cs0hULPD7h49yx178J05+wqfOjL2TOS9UIJhqb9cY5AEyMo9v17s9Wn6v2KqrXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 16:12:43 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Thu, 26 Jun 2025 16:12:43 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1uUnLH-00Fqup-1B;
	Thu, 26 Jun 2025 16:12:43 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mgreer@animalcreek.com>, <krzk@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>
Subject: [PATCH v3 2/2] NFC: trf7970a: Create device-tree parameter for RX gain reduction
Date: Thu, 26 Jun 2025 16:12:42 +0200
Message-ID: <20250626141242.3749958-3-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
References: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The TRF7970a device is sensitive to RF disturbances, which can make it
hard to pass some EMC immunity tests. By reducing the RX antenna gain,
the device becomes less sensitive to EMC disturbances, as a trade-off
against antenna performance.

Add a device tree option to select RX gain reduction to improve EMC
performance.

Selecting a communication standard in the ISO control register resets
the RX antenna gain settings. Therefore set the RX gain reduction
everytime the ISO control register changes, when the option is used.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 drivers/nfc/trf7970a.c | 91 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 9e1a34e23af2..d17c701c7888 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -272,12 +272,18 @@
 #define TRF7970A_MODULATOR_EN_OOK		BIT(6)
 #define TRF7970A_MODULATOR_27MHZ		BIT(7)
 
+#define TRF7970A_RX_GAIN_REDUCTION_MAX_DB	15
+#define TRF7970A_RX_GAIN_REDUCTION_DB_PER_LSB	5
 #define TRF7970A_RX_SPECIAL_SETTINGS_NO_LIM	BIT(0)
 #define TRF7970A_RX_SPECIAL_SETTINGS_AGCR	BIT(1)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_0DB	(0x0 << 2)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_5DB	(0x1 << 2)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_10DB	(0x2 << 2)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_15DB	(0x3 << 2)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT	2
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_MAX	(0x3)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_MASK	(TRF7970A_RX_SPECIAL_SETTINGS_GD_MAX << \
+							TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_0DB	(0x0 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_5DB	(0x1 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_10DB	(0x2 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_15DB	(0x3 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
 #define TRF7970A_RX_SPECIAL_SETTINGS_HBT	BIT(4)
 #define TRF7970A_RX_SPECIAL_SETTINGS_M848	BIT(5)
 #define TRF7970A_RX_SPECIAL_SETTINGS_C424	BIT(6)
@@ -452,6 +458,8 @@ struct trf7970a {
 	unsigned int			timeout;
 	bool				ignore_timeout;
 	struct delayed_work		timeout_work;
+	u8				rx_gain_reduction;
+	bool			custom_rx_gain_reduction;
 };
 
 static int trf7970a_cmd(struct trf7970a *trf, u8 opcode)
@@ -551,6 +559,41 @@ static int trf7970a_read_irqstatus(struct trf7970a *trf, u8 *status)
 	return ret;
 }
 
+static int trf7970a_update_rx_gain_reduction(struct trf7970a *trf)
+{
+	int ret = 0;
+	u8 reg;
+
+	if (!trf->custom_rx_gain_reduction)
+		return 0;
+
+	ret = trf7970a_read(trf, TRF7970A_RX_SPECIAL_SETTINGS, &reg);
+	if (ret)
+		return ret;
+	reg &= ~(TRF7970A_RX_SPECIAL_SETTINGS_GD_MASK);
+	reg |= trf->rx_gain_reduction;
+
+	ret = trf7970a_write(trf, TRF7970A_RX_SPECIAL_SETTINGS, reg);
+
+	return ret;
+}
+
+static int trf7970a_update_iso_ctrl_register(struct trf7970a *trf, u8 iso_ctrl)
+{
+	int ret;
+
+	ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+	if (ret)
+		return ret;
+	/*
+	 * Every time the ISO_CTRL register is written, the RX special setting register is reset by
+	 * the chip. When a custom gain reguduction is required, it should be rewritten now.
+	 */
+	ret = trf7970a_update_rx_gain_reduction(trf);
+
+	return ret;
+}
+
 static int trf7970a_read_target_proto(struct trf7970a *trf, u8 *target_proto)
 {
 	int ret;
@@ -930,8 +973,7 @@ static irqreturn_t trf7970a_irq(int irq, void *dev_id)
 			}
 
 			if (iso_ctrl != trf->iso_ctrl) {
-				ret = trf7970a_write(trf, TRF7970A_ISO_CTRL,
-						     iso_ctrl);
+				ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 				if (ret)
 					goto err_unlock_exit;
 
@@ -1035,6 +1077,11 @@ static int trf7970a_init(struct trf7970a *trf)
 	if (ret)
 		goto err_out;
 
+	/* Set the gain reduction after soft init */
+	ret = trf7970a_update_rx_gain_reduction(trf);
+	if (ret)
+		goto err_out;
+
 	ret = trf7970a_cmd(trf, TRF7970A_CMD_IDLE);
 	if (ret)
 		goto err_out;
@@ -1309,7 +1356,7 @@ static int trf7970a_in_config_framing(struct trf7970a *trf, int framing)
 	}
 
 	if (iso_ctrl != trf->iso_ctrl) {
-		ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+		ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 		if (ret)
 			return ret;
 
@@ -1441,7 +1488,7 @@ static int trf7970a_per_cmd_config(struct trf7970a *trf,
 		}
 
 		if (iso_ctrl != trf->iso_ctrl) {
-			ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+			ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 			if (ret)
 				return ret;
 
@@ -1605,8 +1652,7 @@ static int trf7970a_tg_config_rf_tech(struct trf7970a *trf, int tech)
 	 */
 	if ((trf->framing == NFC_DIGITAL_FRAMING_NFC_DEP_ACTIVATED) &&
 	    (trf->iso_ctrl_tech != trf->iso_ctrl)) {
-		ret = trf7970a_write(trf, TRF7970A_ISO_CTRL,
-				     trf->iso_ctrl_tech);
+		ret = trf7970a_update_iso_ctrl_register(trf, trf->iso_ctrl_tech);
 
 		trf->iso_ctrl = trf->iso_ctrl_tech;
 	}
@@ -1654,7 +1700,7 @@ static int trf7970a_tg_config_framing(struct trf7970a *trf, int framing)
 	trf->framing = framing;
 
 	if (iso_ctrl != trf->iso_ctrl) {
-		ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+		ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 		if (ret)
 			return ret;
 
@@ -1755,6 +1801,10 @@ static int _trf7970a_tg_listen(struct nfc_digital_dev *ddev, u16 timeout,
 	if (ret)
 		goto out_err;
 
+	ret = trf7970a_update_rx_gain_reduction(trf);
+	if (ret)
+		goto out_err;
+
 	ret = trf7970a_write(trf, TRF7970A_REG_IO_CTRL,
 			     trf->io_ctrl | TRF7970A_REG_IO_CTRL_VRS(0x1));
 	if (ret)
@@ -1945,6 +1995,10 @@ static int trf7970a_startup(struct trf7970a *trf)
 	if (ret)
 		return ret;
 
+	ret = trf7970a_update_rx_gain_reduction(trf);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(trf->dev);
 	pm_runtime_enable(trf->dev);
 	pm_runtime_mark_last_busy(trf->dev);
@@ -1993,6 +2047,7 @@ static int trf7970a_probe(struct spi_device *spi)
 	struct trf7970a *trf;
 	int uvolts, autosuspend_delay, ret;
 	u32 clk_freq = TRF7970A_13MHZ_CLOCK_FREQUENCY;
+	u32 rx_gain_reduction_db;
 
 	if (!np) {
 		dev_err(&spi->dev, "No Device Tree entry\n");
@@ -2054,6 +2109,20 @@ static int trf7970a_probe(struct spi_device *spi)
 		trf->modulator_sys_clk_ctrl = 0;
 	}
 
+	if (of_property_read_u32(np, "ti,rx-gain-reduction-db", &rx_gain_reduction_db) == 0) {
+		if (rx_gain_reduction_db > TRF7970A_RX_GAIN_REDUCTION_MAX_DB) {
+			dev_warn(trf->dev, "RX Gain reduction too high. Ignored\n");
+		} else if ((rx_gain_reduction_db % TRF7970A_RX_GAIN_REDUCTION_DB_PER_LSB)) {
+			dev_warn(trf->dev, "RX Gain must be set in 5 dB increments. Ignored\n");
+		} else {
+			dev_dbg(trf->dev, "RX gain set to -%udB\n", rx_gain_reduction_db);
+			trf->rx_gain_reduction = ((rx_gain_reduction_db /
+				TRF7970A_RX_GAIN_REDUCTION_DB_PER_LSB) <<
+				TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT);
+			trf->custom_rx_gain_reduction = true;
+		}
+	}
+
 	ret = devm_request_threaded_irq(trf->dev, spi->irq, NULL,
 					trf7970a_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-- 
2.39.2


