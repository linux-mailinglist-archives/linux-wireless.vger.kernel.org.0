Return-Path: <linux-wireless+bounces-18848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F21DA32A79
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCB83A6E10
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03281253341;
	Wed, 12 Feb 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AsR2Kr+r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BA20B210;
	Wed, 12 Feb 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375273; cv=none; b=PgbaB36jVzxWo6i+YxXV4JRLZAbiKLnG0XtweCFEfbO1H+N6Qb4HkCIaGVT+/hqHDusIxbcqMgVJuVhwoAVOUYTSzXNn0Hh9eSq5lU9ik8P1Pr3NOfK5K1iswBfQNoYInGqgQy22NvcWpS3mhrynn0kRBx9ehu9YtJ6CwE5Gbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375273; c=relaxed/simple;
	bh=1jztkzYD9KJ/1fJA6MUcU0W065d9PyvnLOCcHtgK/nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3Dqu8ITmfvqm1msPVnZGOXwaarNAI0PT4b5BXdHS8NC/rzlGvJlsDIGj7zp9JWZiaGGJ7v7GaOXnBmDaphfr3gB4d1cea4hUwzBonIapcVcf3Avno00TNZZKi4qsvW9YNAB3thvpru3pv3/RcVmMwrDBxVXnCrwcn64Vb1RlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AsR2Kr+r; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC5D8440FF;
	Wed, 12 Feb 2025 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7OFME9i2IUPBCJlachFUyekEY4wChv9lVNTlta/qgw=;
	b=AsR2Kr+r0EsfCT0bRR50j86StsO7qBNICof/C8pNBJ9MSjy+WFLvVLL5dcJDVzjlT1+q3r
	57rTr179uIMOj88U4BHO1/nsJdJXgCOeFm6VxNOu5NGcHEJUjju9ZvFVAidGTBVIf9545+
	JRaA5ObSMEGC0kM8OYoJ04DKOpS3eQmVTcQA2f4z4NPMPyhfDEUF5nt1aWJak5xeM8S+tI
	/7JAwzJWgqRI+KWpdgEEy/MAt26N34VUK0/SDa/IQiUyirEqvNuwMTA+KZg3Ur8KIFY5do
	wrwQ1rq0OHH7OQI2NLoVsGq8scg5HX5wHJxOPuDUSNJZh43HYrweV3mtIAXUUQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:21 +0100
Subject: [PATCH 02/12] wifi: wilc1000: add a read-modify-write API for
 registers accesses
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-2-9609b784874e@bootlin.com>
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
In-Reply-To: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Many places in wilc driver need to modify a single bit in a register,
and then perform the following sequence: read the register, set/reset
the needed bit, write the register. This sequence is performed in
multiple places in the driver, with a varying amount of checks around
possible errors.

Replace all those sequences with a new hif_rmw_reg helper. Make sure to
perform the write only if needed.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Since the registers meaning and effect is pretty opaque, this commit
tries to remain conservative and converts only the "real"
read-modify-write sequences: bare writes seemingly trying to affect a
single bit but actually affecting the whole register are left untouched.
---
 drivers/net/wireless/microchip/wilc1000/sdio.c |  68 ++++++------
 drivers/net/wireless/microchip/wilc1000/spi.c  |  18 +++
 drivers/net/wireless/microchip/wilc1000/wlan.c | 145 +++++++++----------------
 drivers/net/wireless/microchip/wilc1000/wlan.h |   3 +
 4 files changed, 105 insertions(+), 129 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index af970f9991110807ebd880681ad0e8aaf8a0b9bc..7eab1c493774e197e43bdf265063aa8c5e6dff14 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -916,6 +916,7 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int nint)
 {
 	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
+	u32 int_en_mask = 0;
 
 	if (nint > MAX_NUM_INT) {
 		dev_err(&func->dev, "Too many interrupts (%d)...\n", nint);
@@ -923,61 +924,42 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int nint)
 	}
 
 	if (sdio_priv->irq_gpio) {
-		u32 reg;
 		int ret, i;
 
 		/**
 		 *      interrupt pin mux select
 		 **/
-		ret = wilc_sdio_read_reg(wilc, WILC_PIN_MUX_0, &reg);
+		ret = wilc->hif_func->hif_rmw_reg(wilc, WILC_PIN_MUX_0, BIT(8),
+						  BIT(8));
 		if (ret) {
-			dev_err(&func->dev, "Failed read reg (%08x)...\n",
-				WILC_PIN_MUX_0);
-			return ret;
-		}
-		reg |= BIT(8);
-		ret = wilc_sdio_write_reg(wilc, WILC_PIN_MUX_0, reg);
-		if (ret) {
-			dev_err(&func->dev, "Failed write reg (%08x)...\n",
-				WILC_PIN_MUX_0);
+			dev_err(&func->dev, "Failed to set interrupt mux\n");
 			return ret;
 		}
 
 		/**
 		 *      interrupt enable
 		 **/
-		ret = wilc_sdio_read_reg(wilc, WILC_INTR_ENABLE, &reg);
-		if (ret) {
-			dev_err(&func->dev, "Failed read reg (%08x)...\n",
-				WILC_INTR_ENABLE);
-			return ret;
-		}
-
 		for (i = 0; (i < 5) && (nint > 0); i++, nint--)
-			reg |= BIT((27 + i));
-		ret = wilc_sdio_write_reg(wilc, WILC_INTR_ENABLE, reg);
+			int_en_mask |= BIT(WILC_INTR_ENABLE_BIT_BASE + i);
+		ret = wilc->hif_func->hif_rmw_reg(wilc, WILC_INTR_ENABLE,
+						  int_en_mask, int_en_mask);
 		if (ret) {
-			dev_err(&func->dev, "Failed write reg (%08x)...\n",
-				WILC_INTR_ENABLE);
+			dev_err(&func->dev, "Failed to enable interrupts\n");
 			return ret;
 		}
-		if (nint) {
-			ret = wilc_sdio_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
-			if (ret) {
-				dev_err(&func->dev,
-					"Failed read reg (%08x)...\n",
-					WILC_INTR2_ENABLE);
-				return ret;
-			}
 
+		if (nint) {
+			int_en_mask = 0;
 			for (i = 0; (i < 3) && (nint > 0); i++, nint--)
-				reg |= BIT(i);
+				int_en_mask |= BIT(i);
 
-			ret = wilc_sdio_write_reg(wilc, WILC_INTR2_ENABLE, reg);
+			ret = wilc->hif_func->hif_rmw_reg(wilc,
+							  WILC_INTR2_ENABLE,
+							  int_en_mask,
+							  int_en_mask);
 			if (ret) {
 				dev_err(&func->dev,
-					"Failed write reg (%08x)...\n",
-					WILC_INTR2_ENABLE);
+					"Failed to enable internal interrupts\n");
 				return ret;
 			}
 		}
@@ -985,6 +967,23 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int nint)
 	return 0;
 }
 
+static int wilc_sdio_rmw_reg(struct wilc *wilc, u32 reg, u32 mask, u32 data)
+{
+	u32 old_val, new_val;
+	int ret = 0;
+
+	ret = wilc_sdio_read_reg(wilc, reg, &old_val);
+	if (ret)
+		return ret;
+
+	new_val = old_val & ~mask;
+	new_val |= data;
+	if (new_val != old_val)
+		ret = wilc_sdio_write_reg(wilc, reg, new_val);
+
+	return ret;
+}
+
 /* Global sdio HIF function table */
 static const struct wilc_hif_func wilc_hif_sdio = {
 	.hif_init = wilc_sdio_init,
@@ -1003,6 +1002,7 @@ static const struct wilc_hif_func wilc_hif_sdio = {
 	.disable_interrupt = wilc_sdio_disable_interrupt,
 	.hif_reset = wilc_sdio_reset,
 	.hif_is_init = wilc_sdio_is_init,
+	.hif_rmw_reg = wilc_sdio_rmw_reg
 };
 
 static int wilc_sdio_suspend(struct device *dev)
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 5bcabb7decea0fc8d0065a240f4acefabca3346a..aae4262045ff3e5f3668493ef235486e601996f7 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -1355,6 +1355,23 @@ static int wilc_spi_sync_ext(struct wilc *wilc, int nint)
 	return 0;
 }
 
+static int wilc_spi_rmw_reg(struct wilc *wilc, u32 reg, u32 mask, u32 data)
+{
+	u32 old_val, new_val;
+	int ret = 0;
+
+	ret = wilc_spi_read_reg(wilc, reg, &old_val);
+	if (ret)
+		return ret;
+
+	new_val = old_val & ~mask;
+	new_val |= data;
+	if (new_val != old_val)
+		ret = wilc_spi_write_reg(wilc, reg, new_val);
+
+	return ret;
+}
+
 /* Global spi HIF function table */
 static const struct wilc_hif_func wilc_hif_spi = {
 	.hif_init = wilc_spi_init,
@@ -1371,4 +1388,5 @@ static const struct wilc_hif_func wilc_hif_spi = {
 	.hif_sync_ext = wilc_spi_sync_ext,
 	.hif_reset = wilc_spi_reset,
 	.hif_is_init = wilc_spi_is_init,
+	.hif_rmw_reg = wilc_spi_rmw_reg
 };
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 9d80adc45d6be14c8818e8ef1643db6875cf57d2..f2b13bd44273ebe2ee474eda047e82bf1287bd6e 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -578,53 +578,27 @@ static int chip_allow_sleep_wilc1000(struct wilc *wilc)
 		pr_warn("FW not responding\n");
 
 	/* Clear bit 1 */
-	ret = hif_func->hif_read_reg(wilc, wakeup_reg, &reg);
+	ret = wilc->hif_func->hif_rmw_reg(wilc, wakeup_reg, wakeup_bit, 0);
 	if (ret)
 		return ret;
-	if (reg & wakeup_bit) {
-		reg &= ~wakeup_bit;
-		ret = hif_func->hif_write_reg(wilc, wakeup_reg, reg);
-		if (ret)
-			return ret;
-	}
 
-	ret = hif_func->hif_read_reg(wilc, from_host_to_fw_reg, &reg);
+	ret = wilc->hif_func->hif_rmw_reg(wilc, from_host_to_fw_reg,
+					  from_host_to_fw_bit, 0);
 	if (ret)
 		return ret;
-	if (reg & from_host_to_fw_bit) {
-		reg &= ~from_host_to_fw_bit;
-		ret = hif_func->hif_write_reg(wilc, from_host_to_fw_reg, reg);
-		if (ret)
-			return ret;
-	}
 
 	return 0;
 }
 
 static int chip_allow_sleep_wilc3000(struct wilc *wilc)
 {
-	u32 reg = 0;
 	int ret;
-	const struct wilc_hif_func *hif_func = wilc->hif_func;
+	u32 wake_bit = wilc->io_type == WILC_HIF_SDIO ? WILC_SDIO_WAKEUP_BIT :
+							WILC_SPI_WAKEUP_BIT;
 
-	if (wilc->io_type == WILC_HIF_SDIO) {
-		ret = hif_func->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
-		if (ret)
-			return ret;
-		ret = hif_func->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
-					      reg & ~WILC_SDIO_WAKEUP_BIT);
-		if (ret)
-			return ret;
-	} else {
-		ret = hif_func->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
-		if (ret)
-			return ret;
-		ret = hif_func->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
-					      reg & ~WILC_SPI_WAKEUP_BIT);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	ret = wilc->hif_func->hif_rmw_reg(wilc, WILC_SDIO_WAKEUP_REG, wake_bit,
+					  0);
+	return ret;
 }
 
 static int chip_allow_sleep(struct wilc *wilc)
@@ -699,10 +673,10 @@ static int chip_wakeup_wilc1000(struct wilc *wilc)
 
 static int chip_wakeup_wilc3000(struct wilc *wilc)
 {
-	u32 wakeup_reg_val, clk_status_reg_val, trials = 0;
-	u32 wakeup_reg, wakeup_bit;
+	u32 clk_status_reg_val, trials = 0;
 	u32 clk_status_reg, clk_status_bit;
-	int wake_seq_trials = 5;
+	int wake_seq_trials = 5, ret;
+	u32 wakeup_reg, wakeup_bit;
 	const struct wilc_hif_func *hif_func = wilc->hif_func;
 
 	if (wilc->io_type == WILC_HIF_SDIO) {
@@ -717,10 +691,12 @@ static int chip_wakeup_wilc3000(struct wilc *wilc)
 		clk_status_bit = WILC3000_SPI_CLK_STATUS_BIT;
 	}
 
-	hif_func->hif_read_reg(wilc, wakeup_reg, &wakeup_reg_val);
 	do {
-		hif_func->hif_write_reg(wilc, wakeup_reg, wakeup_reg_val |
-							  wakeup_bit);
+		ret = hif_func->hif_rmw_reg(wilc, wakeup_reg, wakeup_bit,
+					    wakeup_bit);
+		if (ret)
+			dev_warn(wilc->dev, "Failed to set wake bit\n");
+
 		/* Check the clock status */
 		hif_func->hif_read_reg(wilc, clk_status_reg,
 				       &clk_status_reg_val);
@@ -745,8 +721,10 @@ static int chip_wakeup_wilc3000(struct wilc *wilc)
 		 * edge on the next loop
 		 */
 		if ((clk_status_reg_val & clk_status_bit) == 0) {
-			hif_func->hif_write_reg(wilc, wakeup_reg,
-						wakeup_reg_val & (~wakeup_bit));
+			ret = hif_func->hif_rmw_reg(wilc, wakeup_reg,
+						    wakeup_bit, 0);
+			if (ret)
+				dev_warn(wilc->dev, "Failed to set CLK bit\n");
 			/* added wait before wakeup sequence retry */
 			usleep_range(200, 300);
 		}
@@ -996,11 +974,11 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 			break;
 
 		if (entries == 0) {
-			ret = func->hif_read_reg(wilc, WILC_HOST_TX_CTRL, &reg);
+			ret = wilc->hif_func->hif_rmw_reg(wilc,
+					WILC_HOST_TX_CTRL, BIT(0), 0);
 			if (ret)
-				break;
-			reg &= ~BIT(0);
-			ret = func->hif_write_reg(wilc, WILC_HOST_TX_CTRL, reg);
+				dev_warn(wilc->dev,
+					 "Failed to reset TX CTRL bit\n");
 		}
 	} while (0);
 
@@ -1267,9 +1245,12 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 	if (ret)
 		return ret;
 
-	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
-	reg &= ~BIT(10);
-	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+	ret = wilc->hif_func->hif_rmw_reg(wilc, WILC_GLB_RESET_0, BIT(10), 0);
+	if (ret) {
+		dev_err(wilc->dev, "Failed to reset WLAN CPU\n");
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	if (reg & BIT(10))
 		pr_err("%s: Failed to reset\n", __func__);
@@ -1357,16 +1338,12 @@ int wilc_wlan_start(struct wilc *wilc)
 	if (ret)
 		goto release;
 
-	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
-	if ((reg & BIT(10)) == BIT(10)) {
-		reg &= ~BIT(10);
-		wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
-		wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
-	}
-
-	reg |= BIT(10);
-	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
-	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	ret = wilc->hif_func->hif_rmw_reg(wilc, WILC_GLB_RESET_0, BIT(10), 0);
+	if (!ret)
+		ret = wilc->hif_func->hif_rmw_reg(wilc, WILC_GLB_RESET_0,
+						  BIT(10), BIT(10));
+	if (ret)
+		dev_warn(wilc->dev, "Failed to reset WLAN CPU\n");
 
 release:
 	rv = release_bus(wilc, WILC_BUS_RELEASE_ONLY);
@@ -1375,44 +1352,31 @@ int wilc_wlan_start(struct wilc *wilc)
 
 int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif)
 {
-	u32 reg = 0;
 	int ret, rv;
 
 	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	if (ret)
 		return ret;
 
-	ret = wilc->hif_func->hif_read_reg(wilc, GLOBAL_MODE_CONTROL, &reg);
-	if (ret)
-		goto release;
-
-	reg &= ~WILC_GLOBAL_MODE_ENABLE_WIFI;
-	ret = wilc->hif_func->hif_write_reg(wilc, GLOBAL_MODE_CONTROL, reg);
-	if (ret)
-		goto release;
-
-	ret = wilc->hif_func->hif_read_reg(wilc, PWR_SEQ_MISC_CTRL, &reg);
-	if (ret)
-		goto release;
-
-	reg &= ~WILC_PWR_SEQ_ENABLE_WIFI_SLEEP;
-	ret = wilc->hif_func->hif_write_reg(wilc, PWR_SEQ_MISC_CTRL, reg);
-	if (ret)
-		goto release;
-
-	ret = wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
+	ret = wilc->hif_func->hif_rmw_reg(wilc, GLOBAL_MODE_CONTROL,
+			  WILC_GLOBAL_MODE_ENABLE_WIFI, 0);
 	if (ret) {
-		netdev_err(vif->ndev, "Error while reading reg\n");
+		netdev_err(vif->ndev, "Failed to disable wlan control\n");
 		goto release;
 	}
 
-	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
-					(reg | WILC_ABORT_REQ_BIT));
+	ret = wilc->hif_func->hif_rmw_reg(wilc, PWR_SEQ_MISC_CTRL,
+			  WILC_PWR_SEQ_ENABLE_WIFI_SLEEP, 0);
 	if (ret) {
-		netdev_err(vif->ndev, "Error while writing reg\n");
+		netdev_err(vif->ndev, "Failed to unmux wlan power seq\n");
 		goto release;
 	}
 
+	ret = wilc->hif_func->hif_rmw_reg(wilc, WILC_GP_REG_0,
+			  WILC_ABORT_REQ_BIT, 1);
+	if (ret)
+		netdev_err(vif->ndev, "Failed to stop wlan CPU\n");
+
 	ret = 0;
 release:
 	/* host comm is disabled - we can't issue sleep command anymore: */
@@ -1641,19 +1605,10 @@ static int init_chip(struct net_device *dev)
 		goto release;
 
 	if ((wilc->chipid & 0xfff) != 0xa0) {
-		ret = wilc->hif_func->hif_read_reg(wilc,
-						   WILC_CORTUS_RESET_MUX_SEL,
-						   &reg);
-		if (ret) {
-			netdev_err(dev, "fail read reg 0x1118\n");
-			goto release;
-		}
-		reg |= BIT(0);
-		ret = wilc->hif_func->hif_write_reg(wilc,
-						    WILC_CORTUS_RESET_MUX_SEL,
-						    reg);
+		ret = wilc->hif_func->hif_rmw_reg(wilc,
+				WILC_CORTUS_RESET_MUX_SEL, BIT(0), BIT(0));
 		if (ret) {
-			netdev_err(dev, "fail write reg 0x1118\n");
+			netdev_err(dev, "Failed to enable WLAN global reset\n");
 			goto release;
 		}
 		ret = wilc->hif_func->hif_write_reg(wilc,
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index b9e7f9222eadde6d736e1d0a403f84ec19399632..65e79371014d9e60755cb0aa38e04d351e67bcfb 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -58,6 +58,7 @@
 #define WILC_HOST_TX_CTRL_1		(WILC_PERIPH_REG_BASE + 0x88)
 #define WILC_INTR_REG_BASE		(WILC_PERIPH_REG_BASE + 0xa00)
 #define WILC_INTR_ENABLE		WILC_INTR_REG_BASE
+#define WILC_INTR_ENABLE_BIT_BASE	27
 #define WILC_INTR2_ENABLE		(WILC_INTR_REG_BASE + 4)
 
 #define WILC_INTR_POLARITY		(WILC_INTR_REG_BASE + 0x10)
@@ -403,6 +404,7 @@ struct wilc_hif_func {
 	void (*disable_interrupt)(struct wilc *nic);
 	int (*hif_reset)(struct wilc *wilc);
 	bool (*hif_is_init)(struct wilc *wilc);
+	int (*hif_rmw_reg)(struct wilc *wilc, u32 reg, u32 mask, u32 data);
 };
 
 #define WILC_MAX_CFG_FRAME_SIZE		1468
@@ -472,4 +474,5 @@ int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 int wilc_wlan_init(struct net_device *dev);
 int wilc_get_chipid(struct wilc *wilc);
 int wilc_load_mac_from_nv(struct wilc *wilc);
+
 #endif

-- 
2.48.0


