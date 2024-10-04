Return-Path: <linux-wireless+bounces-13507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B369D990265
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 13:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C102827EF
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6499917C984;
	Fri,  4 Oct 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YHDaMKz5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DE15ECDC;
	Fri,  4 Oct 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042396; cv=none; b=ZiFx7il6ACxVqoOrxAvQo9oMkfm1/UU3iuyEUdpivHArBwpY1UUcEHr6JKgO/VC75MYHAFQZcts1hB5xA1GdGgwBSuqAwQF4z4VlgM6DIFZ1n7khOWrr3WZA2aL+QIMO+NEXtAh9nD2GnXd+Lr+17KdFJgKtFEQH6fVq4XqHtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042396; c=relaxed/simple;
	bh=SYIrVgqBede8Uy/eq90YZikgBJVI7mM3mf9bqcLzO7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpYWrby8id7ECHg6h6pL6aXNTFnkyMsT4w/j8PSyE2tEY3fYe2WujDGkg87Pb4DnQSkLpB/CR0o5ByxQph7MuJ0UNUuXHKrOFYrgTakFXR9qDS18E+oOVduRopXiFTyWWLpQ0XCgn3/Bi8SMtPuUh7kjgdektudGWTAbQdlW6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=YHDaMKz5; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CC99588C4C;
	Fri,  4 Oct 2024 13:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728042386;
	bh=vcmQUqFgkLnrY7+VCQr4/xXEGAPntvoDH/T/S6K70a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHDaMKz5tTBHGzxk20dFuo9TrBd0rj2uhL37kFPFvXqs3WSoauxu4jyUcs+XFiU/x
	 6M9h5WSeo+jGyDpcq9SDBVWAoW2Ncy1dblkP+VBWajAnrDPEJ843hun2+NKRYwXMJ1
	 wXIvjsD8Px6s4Y6mzpAqj1ZoXV9YLp9DzRw7eH1t4ZWLZ5MeDTTJ149w3E5sUffafO
	 xrTTWRR0tnc3u12JOGSRXE80x9UQkCcqMGmEOloBfOZiLuRE9/++Zmt3HcO+7kSKgZ
	 Eo8kfluyjlBhJqBV02zfbYC4QdtEPg4TaXcPMBijry+/FPO+GrCPomqidUShVVTMkn
	 CIfne9AiIkdbw==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 7/7] wifi: wilc1000: Add WILC3000 support
Date: Fri,  4 Oct 2024 13:44:16 +0200
Message-ID: <20241004114551.40236-7-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004114551.40236-1-marex@denx.de>
References: <20241004114551.40236-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Ajay Singh <ajay.kathat@microchip.com>

Add support for the WILC3000 chip. The chip is similar to WILC1000,
except that the register layout is slightly different and it does
not support WPA3/SAE.

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Tested-on: WILC1000SD 07 SDIO WILC_WIFI_FW_REL_16_1_2
Tested-on: WILC1000SD 07 SPI WILC_WIFI_FW_REL_16_1_2
Tested-on: WILC3000 A SDIO WILC_WIFI_FW_REL_16_1_1
Tested-on: WILC3000 A SPI WILC_WIFI_FW_REL_16_1_1
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Note: Squashed and updated from the following downstream patches:
wifi: wilc1000: wilc3000 support added
wifi: wilc1000: wilc3000 interrupt handling
wifi: wilc1000: wilc3000 added chip wake and sleep support
wifi: wilc1000: wilc3000 FW file sepecific changes
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: - Return -EINVAL in wilc_sdio_init() if chip ID is not supported
    - Dispose of wilc_chip_type, replace with is_wilc1000()/is_wilc3000()
    - Remove wilc3000 DT compatible string handling, match on wilc1000 only,
      the device type can be auto-detected based on chipID
V3: - Define and use WILC3000_BOOTROM_STATUS and WILC3000_CORTUS_BOOT_REGISTER_2
V4: - Fix up after dropping wilc_get_chipid() in netdev.c in 2/5
V5: - Advertise WPA3/SAE to userspace only on WILC1000 in wilc_create_wiphy()
V6: - Rebase on next-20240926
V7: - Fix firmware name printing in wilc_wlan_get_firmware() netdev_info()
    - Rebase on next-20241003 / wireless-next/main 5a4d42c1688c
      with v2 wifi: wilc1000: Keep slot powered on during suspend/resume
V8: Add RB/TB from Alexis
---
 .../wireless/microchip/wilc1000/cfg80211.c    |   4 +-
 .../net/wireless/microchip/wilc1000/netdev.c  |  29 ++-
 .../net/wireless/microchip/wilc1000/sdio.c    |  62 ++++-
 drivers/net/wireless/microchip/wilc1000/spi.c |   2 +-
 .../net/wireless/microchip/wilc1000/wlan.c    | 220 +++++++++++++++---
 .../net/wireless/microchip/wilc1000/wlan.h    |  45 +++-
 6 files changed, 299 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 283f8df046884..b0dae6f7c633b 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1855,7 +1855,9 @@ EXPORT_SYMBOL_GPL(wilc_cfg80211_init);
 
 int wilc_cfg80211_register(struct wilc *wilc)
 {
-	wilc->wiphy->features |= NL80211_FEATURE_SAE;
+	/* WPA3/SAE supported only on WILC1000 */
+	if (is_wilc1000(wilc->chipid))
+		wilc->wiphy->features |= NL80211_FEATURE_SAE;
 
 	return wiphy_register(wilc->wiphy);
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 3e80d29a99ccf..7e84fc0fd9118 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -23,6 +23,12 @@
 #define __WILC1000_FW(api)		WILC1000_FW_PREFIX #api ".bin"
 #define WILC1000_FW(api)		__WILC1000_FW(api)
 
+#define WILC3000_API_VER		1
+
+#define WILC3000_FW_PREFIX		"atmel/wilc3000_wifi_firmware-"
+#define __WILC3000_FW(api)		WILC3000_FW_PREFIX #api ".bin"
+#define WILC3000_FW(api)		__WILC3000_FW(api)
+
 static irqreturn_t isr_uh_routine(int irq, void *user_data)
 {
 	struct wilc *wilc = user_data;
@@ -196,19 +202,23 @@ static int wilc_wlan_get_firmware(struct net_device *dev)
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc = vif->wilc;
 	const struct firmware *wilc_fw;
+	char *firmware;
 	int ret;
 
-	if (!is_wilc1000(wilc->chipid))
+	if (is_wilc1000(wilc->chipid))
+		firmware = WILC1000_FW(WILC1000_API_VER);
+	else if (is_wilc3000(wilc->chipid))
+		firmware = WILC3000_FW(WILC3000_API_VER);
+	else
 		return -EINVAL;
 
-	netdev_info(dev, "WILC1000 loading firmware [%s]\n",
-		    WILC1000_FW(WILC1000_API_VER));
+	netdev_info(dev, "WILC%d loading firmware [%s]\n",
+		    is_wilc1000(wilc->chipid) ? 1000 : 3000,
+		    firmware);
 
-	ret = request_firmware(&wilc_fw, WILC1000_FW(WILC1000_API_VER),
-			       wilc->dev);
+	ret = request_firmware(&wilc_fw, firmware, wilc->dev);
 	if (ret != 0) {
-		netdev_err(dev, "%s - firmware not available\n",
-			   WILC1000_FW(WILC1000_API_VER));
+		netdev_err(dev, "%s - firmware not available\n", firmware);
 		return -EINVAL;
 	}
 	wilc->firmware = wilc_fw;
@@ -233,7 +243,7 @@ static int wilc_start_firmware(struct net_device *dev)
 	return 0;
 }
 
-static int wilc1000_firmware_download(struct net_device *dev)
+static int wilc_firmware_download(struct net_device *dev)
 {
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc = vif->wilc;
@@ -528,7 +538,7 @@ static int wilc_wlan_initialize(struct net_device *dev, struct wilc_vif *vif)
 		if (ret)
 			goto fail_irq_enable;
 
-		ret = wilc1000_firmware_download(dev);
+		ret = wilc_firmware_download(dev);
 		if (ret)
 			goto fail_irq_enable;
 
@@ -1014,3 +1024,4 @@ EXPORT_SYMBOL_GPL(wilc_netdev_ifc_init);
 MODULE_DESCRIPTION("Atmel WILC1000 core wireless driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(WILC1000_FW(WILC1000_API_VER));
+MODULE_FIRMWARE(WILC3000_FW(WILC3000_API_VER));
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 56a929281d6a7..5262c8846c13d 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -810,13 +810,19 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
 		cmd.address = WILC_SDIO_EXT_IRQ_FLAG_REG;
 	} else {
 		cmd.function = 0;
-		cmd.address = WILC_SDIO_IRQ_FLAG_REG;
+		cmd.address = is_wilc1000(wilc->chipid) ?
+			      WILC1000_SDIO_IRQ_FLAG_REG :
+			      WILC3000_SDIO_IRQ_FLAG_REG;
 	}
 	cmd.raw = 0;
 	cmd.read_write = 0;
 	cmd.data = 0;
 	wilc_sdio_cmd52(wilc, &cmd);
 	irq_flags = cmd.data;
+
+	if (sdio_priv->irq_gpio)
+		irq_flags &= is_wilc1000(wilc->chipid) ? 0x1f : 0x0f;
+
 	tmp |= FIELD_PREP(IRG_FLAGS_MASK, cmd.data);
 
 	if (FIELD_GET(UNHANDLED_IRQ_MASK, irq_flags))
@@ -838,22 +844,56 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc, u32 val)
 	if (sdio_priv->irq_gpio)
 		reg = val & (BIT(MAX_NUM_INT) - 1);
 
-	/* select VMM table 0 */
-	if (val & SEL_VMM_TBL0)
-		reg |= BIT(5);
-	/* select VMM table 1 */
-	if (val & SEL_VMM_TBL1)
-		reg |= BIT(6);
-	/* enable VMM */
-	if (val & EN_VMM)
-		reg |= BIT(7);
+	if (is_wilc1000(wilc->chipid)) {
+		/* select VMM table 0 */
+		if (val & SEL_VMM_TBL0)
+			reg |= BIT(5);
+		/* select VMM table 1 */
+		if (val & SEL_VMM_TBL1)
+			reg |= BIT(6);
+		/* enable VMM */
+		if (val & EN_VMM)
+			reg |= BIT(7);
+	} else {
+		if (sdio_priv->irq_gpio && reg) {
+			struct sdio_cmd52 cmd;
+
+			cmd.read_write = 1;
+			cmd.function = 0;
+			cmd.raw = 0;
+			cmd.address = WILC3000_SDIO_IRQ_FLAG_REG;
+			cmd.data = reg;
+
+			ret = wilc_sdio_cmd52(wilc, &cmd);
+			if (ret) {
+				dev_err(&func->dev,
+					"Failed cmd52, set 0xfe data (%d) ...\n",
+					__LINE__);
+				return ret;
+			}
+		}
+
+		reg = 0;
+		/* select VMM table 0 */
+		if (val & SEL_VMM_TBL0)
+			reg |= BIT(0);
+		/* select VMM table 1 */
+		if (val & SEL_VMM_TBL1)
+			reg |= BIT(1);
+		/* enable VMM */
+		if (val & EN_VMM)
+			reg |= BIT(2);
+	}
+
 	if (reg) {
 		struct sdio_cmd52 cmd;
 
 		cmd.read_write = 1;
 		cmd.function = 0;
 		cmd.raw = 0;
-		cmd.address = WILC_SDIO_IRQ_CLEAR_FLAG_REG;
+		cmd.address = is_wilc1000(wilc->chipid) ?
+			      WILC1000_SDIO_IRQ_CLEAR_FLAG_REG :
+			      WILC3000_SDIO_VMM_TBL_CTRL_REG;
 		cmd.data = reg;
 
 		ret = wilc_sdio_cmd52(wilc, &cmd);
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 28d211ee60096..ce2a9cdd6aa78 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -1233,7 +1233,7 @@ static int wilc_validate_chipid(struct wilc *wilc)
 		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 		return ret;
 	}
-	if (!is_wilc1000(chipid)) {
+	if (!is_wilc1000(chipid) && !is_wilc3000(chipid)) {
 		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
 		return -ENODEV;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 521caa498035e..9d80adc45d6be 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -541,7 +541,7 @@ static struct rxq_entry_t *wilc_wlan_rxq_remove(struct wilc *wilc)
 	return rqe;
 }
 
-static int chip_allow_sleep(struct wilc *wilc)
+static int chip_allow_sleep_wilc1000(struct wilc *wilc)
 {
 	u32 reg = 0;
 	const struct wilc_hif_func *hif_func = wilc->hif_func;
@@ -601,7 +601,41 @@ static int chip_allow_sleep(struct wilc *wilc)
 	return 0;
 }
 
-static int chip_wakeup(struct wilc *wilc)
+static int chip_allow_sleep_wilc3000(struct wilc *wilc)
+{
+	u32 reg = 0;
+	int ret;
+	const struct wilc_hif_func *hif_func = wilc->hif_func;
+
+	if (wilc->io_type == WILC_HIF_SDIO) {
+		ret = hif_func->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
+		if (ret)
+			return ret;
+		ret = hif_func->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
+					      reg & ~WILC_SDIO_WAKEUP_BIT);
+		if (ret)
+			return ret;
+	} else {
+		ret = hif_func->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
+		if (ret)
+			return ret;
+		ret = hif_func->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
+					      reg & ~WILC_SPI_WAKEUP_BIT);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int chip_allow_sleep(struct wilc *wilc)
+{
+	if (is_wilc1000(wilc->chipid))
+		return chip_allow_sleep_wilc1000(wilc);
+	else
+		return chip_allow_sleep_wilc3000(wilc);
+}
+
+static int chip_wakeup_wilc1000(struct wilc *wilc)
 {
 	u32 ret = 0;
 	u32 clk_status_val = 0, trials = 0;
@@ -613,15 +647,15 @@ static int chip_wakeup(struct wilc *wilc)
 	if (wilc->io_type == WILC_HIF_SDIO) {
 		wakeup_reg = WILC_SDIO_WAKEUP_REG;
 		wakeup_bit = WILC_SDIO_WAKEUP_BIT;
-		clk_status_reg = WILC_SDIO_CLK_STATUS_REG;
-		clk_status_bit = WILC_SDIO_CLK_STATUS_BIT;
+		clk_status_reg = WILC1000_SDIO_CLK_STATUS_REG;
+		clk_status_bit = WILC1000_SDIO_CLK_STATUS_BIT;
 		from_host_to_fw_reg = WILC_SDIO_HOST_TO_FW_REG;
 		from_host_to_fw_bit = WILC_SDIO_HOST_TO_FW_BIT;
 	} else {
 		wakeup_reg = WILC_SPI_WAKEUP_REG;
 		wakeup_bit = WILC_SPI_WAKEUP_BIT;
-		clk_status_reg = WILC_SPI_CLK_STATUS_REG;
-		clk_status_bit = WILC_SPI_CLK_STATUS_BIT;
+		clk_status_reg = WILC1000_SPI_CLK_STATUS_REG;
+		clk_status_bit = WILC1000_SPI_CLK_STATUS_BIT;
 		from_host_to_fw_reg = WILC_SPI_HOST_TO_FW_REG;
 		from_host_to_fw_bit = WILC_SPI_HOST_TO_FW_BIT;
 	}
@@ -663,6 +697,74 @@ static int chip_wakeup(struct wilc *wilc)
 	return 0;
 }
 
+static int chip_wakeup_wilc3000(struct wilc *wilc)
+{
+	u32 wakeup_reg_val, clk_status_reg_val, trials = 0;
+	u32 wakeup_reg, wakeup_bit;
+	u32 clk_status_reg, clk_status_bit;
+	int wake_seq_trials = 5;
+	const struct wilc_hif_func *hif_func = wilc->hif_func;
+
+	if (wilc->io_type == WILC_HIF_SDIO) {
+		wakeup_reg = WILC_SDIO_WAKEUP_REG;
+		wakeup_bit = WILC_SDIO_WAKEUP_BIT;
+		clk_status_reg = WILC3000_SDIO_CLK_STATUS_REG;
+		clk_status_bit = WILC3000_SDIO_CLK_STATUS_BIT;
+	} else {
+		wakeup_reg = WILC_SPI_WAKEUP_REG;
+		wakeup_bit = WILC_SPI_WAKEUP_BIT;
+		clk_status_reg = WILC3000_SPI_CLK_STATUS_REG;
+		clk_status_bit = WILC3000_SPI_CLK_STATUS_BIT;
+	}
+
+	hif_func->hif_read_reg(wilc, wakeup_reg, &wakeup_reg_val);
+	do {
+		hif_func->hif_write_reg(wilc, wakeup_reg, wakeup_reg_val |
+							  wakeup_bit);
+		/* Check the clock status */
+		hif_func->hif_read_reg(wilc, clk_status_reg,
+				       &clk_status_reg_val);
+
+		/* In case of clocks off, wait 1ms, and check it again.
+		 * if still off, wait for another 1ms, for a total wait of 3ms.
+		 * If still off, redo the wake up sequence
+		 */
+		while ((clk_status_reg_val & clk_status_bit) == 0 &&
+		       (++trials % 4) != 0) {
+			/* Wait for the chip to stabilize*/
+			usleep_range(1000, 1100);
+
+			/* Make sure chip is awake. This is an extra step that
+			 * can be removed later to avoid the bus access
+			 * overhead
+			 */
+			hif_func->hif_read_reg(wilc, clk_status_reg,
+					       &clk_status_reg_val);
+		}
+		/* in case of failure, Reset the wakeup bit to introduce a new
+		 * edge on the next loop
+		 */
+		if ((clk_status_reg_val & clk_status_bit) == 0) {
+			hif_func->hif_write_reg(wilc, wakeup_reg,
+						wakeup_reg_val & (~wakeup_bit));
+			/* added wait before wakeup sequence retry */
+			usleep_range(200, 300);
+		}
+	} while ((clk_status_reg_val & clk_status_bit) == 0 && wake_seq_trials-- > 0);
+	if (!wake_seq_trials)
+		dev_err(wilc->dev, "clocks still OFF. Wake up failed\n");
+
+	return 0;
+}
+
+static int chip_wakeup(struct wilc *wilc)
+{
+	if (is_wilc1000(wilc->chipid))
+		return chip_wakeup_wilc1000(wilc);
+	else
+		return chip_wakeup_wilc3000(wilc);
+}
+
 static inline int acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
 	int ret = 0;
@@ -695,7 +797,9 @@ int host_wakeup_notify(struct wilc *wilc)
 	if (ret)
 		return ret;
 
-	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_2, 1);
+	wilc->hif_func->hif_write_reg(wilc, is_wilc1000(wilc->chipid) ?
+					    WILC1000_CORTUS_INTERRUPT_2 :
+					    WILC3000_CORTUS_INTERRUPT_2, 1);
 	return release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 }
 EXPORT_SYMBOL_GPL(host_wakeup_notify);
@@ -707,7 +811,9 @@ int host_sleep_notify(struct wilc *wilc)
 	if (ret)
 		return ret;
 
-	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_1, 1);
+	wilc->hif_func->hif_write_reg(wilc, is_wilc1000(wilc->chipid) ?
+					    WILC1000_CORTUS_INTERRUPT_1 :
+					    WILC3000_CORTUS_INTERRUPT_1, 1);
 	return release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 }
 EXPORT_SYMBOL_GPL(host_sleep_notify);
@@ -842,19 +948,45 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 		if (ret)
 			break;
 
-		ret = func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x2);
-		if (ret)
-			break;
+		if (is_wilc1000(wilc->chipid)) {
+			ret = func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x2);
+			if (ret)
+				break;
 
-		do {
-			ret = func->hif_read_reg(wilc, WILC_HOST_VMM_CTL, &reg);
+			do {
+				ret = func->hif_read_reg(wilc, WILC_HOST_VMM_CTL, &reg);
+				if (ret)
+					break;
+				if (FIELD_GET(WILC_VMM_ENTRY_AVAILABLE, reg)) {
+					entries = FIELD_GET(WILC_VMM_ENTRY_COUNT, reg);
+					break;
+				}
+			} while (--timeout);
+		} else {
+			ret = func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0);
 			if (ret)
 				break;
-			if (FIELD_GET(WILC_VMM_ENTRY_AVAILABLE, reg)) {
-				entries = FIELD_GET(WILC_VMM_ENTRY_COUNT, reg);
+
+			/* interrupt firmware */
+			ret = func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_BASE, 1);
+			if (ret)
 				break;
-			}
-		} while (--timeout);
+
+			do {
+				ret = func->hif_read_reg(wilc, WILC_CORTUS_INTERRUPT_BASE, &reg);
+				if (ret)
+					break;
+				if (reg == 0) {
+					/* Get the entries */
+					ret = func->hif_read_reg(wilc, WILC_HOST_VMM_CTL, &reg);
+					if (ret)
+						break;
+
+					entries = FIELD_GET(WILC_VMM_ENTRY_COUNT, reg);
+					break;
+				}
+			} while (--timeout);
+		}
 		if (timeout <= 0) {
 			ret = func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x0);
 			break;
@@ -1212,6 +1344,9 @@ int wilc_wlan_start(struct wilc *wilc)
 	if (wilc->io_type == WILC_HIF_SDIO && wilc->dev_irq_num)
 		reg |= WILC_HAVE_SDIO_IRQ_GPIO;
 
+	if (is_wilc3000(wilc->chipid))
+		reg |= WILC_HAVE_SLEEP_CLK_SRC_RTC;
+
 	ret = wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_1, reg);
 	if (ret)
 		goto release;
@@ -1462,21 +1597,25 @@ int wilc_get_chipid(struct wilc *wilc)
 	u32 rfrevid = 0;
 
 	if (wilc->chipid == 0) {
-		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
-		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
-					     &rfrevid);
-		if (!is_wilc1000(chipid)) {
-			wilc->chipid = 0;
-			return -EINVAL;
-		}
-		if (chipid == WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
-			if (rfrevid != 0x1)
-				chipid = WILC_1000_BASE_ID_2A_REV1;
-		} else if (chipid == WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
-			if (rfrevid == 0x4)
-				chipid = WILC_1000_BASE_ID_2B_REV1;
-			else if (rfrevid != 0x3)
-				chipid = WILC_1000_BASE_ID_2B_REV2;
+		wilc->hif_func->hif_read_reg(wilc, WILC3000_CHIP_ID, &chipid);
+		if (!is_wilc3000(chipid)) {
+			wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
+			wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
+						     &rfrevid);
+
+			if (!is_wilc1000(chipid)) {
+				wilc->chipid = 0;
+				return -EINVAL;
+			}
+			if (chipid == WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
+				if (rfrevid != 0x1)
+					chipid = WILC_1000_BASE_ID_2A_REV1;
+			} else if (chipid == WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
+				if (rfrevid == 0x4)
+					chipid = WILC_1000_BASE_ID_2B_REV1;
+				else if (rfrevid != 0x3)
+					chipid = WILC_1000_BASE_ID_2B_REV2;
+			}
 		}
 
 		wilc->chipid = chipid;
@@ -1526,6 +1665,21 @@ static int init_chip(struct net_device *dev)
 		}
 	}
 
+	if (is_wilc3000(wilc->chipid)) {
+		ret = wilc->hif_func->hif_read_reg(wilc, WILC3000_BOOTROM_STATUS, &reg);
+		if (ret) {
+			netdev_err(dev, "failed to read WILC3000 BootROM status register\n");
+			goto release;
+		}
+
+		ret = wilc->hif_func->hif_write_reg(wilc, WILC3000_CORTUS_BOOT_REGISTER_2,
+						    WILC_CORTUS_BOOT_FROM_IRAM);
+		if (ret) {
+			netdev_err(dev, "failed to write WILC3000 Boot register\n");
+			goto release;
+		}
+	}
+
 release:
 	rv = release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 
@@ -1607,7 +1761,7 @@ int wilc_wlan_init(struct net_device *dev)
 		if (ret)
 			goto fail;
 
-		if (!is_wilc1000(wilc->chipid)) {
+		if (!is_wilc1000(wilc->chipid) && !is_wilc3000(wilc->chipid)) {
 			netdev_err(dev, "Unsupported chipid: %x\n", wilc->chipid);
 			ret = -EINVAL;
 			goto fail;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index 552590823e444..b9e7f9222eadd 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -96,8 +96,14 @@
 #define WILC_SPI_WAKEUP_REG		0x1
 #define WILC_SPI_WAKEUP_BIT		BIT(1)
 
-#define WILC_SPI_CLK_STATUS_REG        0x0f
-#define WILC_SPI_CLK_STATUS_BIT        BIT(2)
+/* WILC1000 specific */
+#define WILC1000_SPI_CLK_STATUS_REG	0x0f
+#define WILC1000_SPI_CLK_STATUS_BIT	BIT(2)
+
+/* WILC3000 specific */
+#define WILC3000_SPI_CLK_STATUS_REG	0x13
+#define WILC3000_SPI_CLK_STATUS_BIT	BIT(2)
+
 #define WILC_SPI_HOST_TO_FW_REG		0x0b
 #define WILC_SPI_HOST_TO_FW_BIT		BIT(0)
 
@@ -123,14 +129,24 @@
 #define WILC_SDIO_WAKEUP_REG		0xf0
 #define WILC_SDIO_WAKEUP_BIT		BIT(0)
 
-#define WILC_SDIO_CLK_STATUS_REG	0xf1
-#define WILC_SDIO_CLK_STATUS_BIT	BIT(0)
+/* WILC1000 */
+#define WILC1000_SDIO_CLK_STATUS_REG	0xf1
+#define WILC1000_SDIO_CLK_STATUS_BIT	BIT(0)
+
+#define WILC1000_SDIO_IRQ_FLAG_REG	0xf7
+#define WILC1000_SDIO_IRQ_CLEAR_FLAG_REG	0xf8
+
+/* WILC3000 specific */
+#define WILC3000_SDIO_CLK_STATUS_REG	0xf0 /* clk & wakeup are on same reg */
+#define WILC3000_SDIO_CLK_STATUS_BIT	BIT(4)
+
+#define WILC3000_SDIO_VMM_TBL_CTRL_REG	0xf1
+#define WILC3000_SDIO_IRQ_FLAG_REG	0xfe
 
+/* Common vendor specific CCCR register */
 #define WILC_SDIO_INTERRUPT_DATA_SZ_REG	0xf2 /* Read size (2 bytes) */
 
 #define WILC_SDIO_VMM_TBL_CTRL_REG	0xf6
-#define WILC_SDIO_IRQ_FLAG_REG		0xf7
-#define WILC_SDIO_IRQ_CLEAR_FLAG_REG	0xf8
 
 #define WILC_SDIO_HOST_TO_FW_REG	0xfa
 #define WILC_SDIO_HOST_TO_FW_BIT	BIT(0)
@@ -172,8 +188,11 @@
 #define WILC_HAVE_USE_IRQ_AS_HOST_WAKE	BIT(8)
 
 #define WILC_CORTUS_INTERRUPT_BASE	0x10A8
-#define WILC_CORTUS_INTERRUPT_1		(WILC_CORTUS_INTERRUPT_BASE + 0x4)
-#define WILC_CORTUS_INTERRUPT_2		(WILC_CORTUS_INTERRUPT_BASE + 0x8)
+#define WILC1000_CORTUS_INTERRUPT_1	(WILC_CORTUS_INTERRUPT_BASE + 0x4)
+#define WILC3000_CORTUS_INTERRUPT_1	(WILC_CORTUS_INTERRUPT_BASE + 0x14)
+
+#define WILC1000_CORTUS_INTERRUPT_2	(WILC_CORTUS_INTERRUPT_BASE + 0x8)
+#define WILC3000_CORTUS_INTERRUPT_2	(WILC_CORTUS_INTERRUPT_BASE + 0x18)
 
 /* tx control register 1 to 4 for RX */
 #define WILC_REG_4_TO_1_RX		0x1e1c
@@ -183,6 +202,9 @@
 
 #define WILC_CORTUS_RESET_MUX_SEL	0x1118
 #define WILC_CORTUS_BOOT_REGISTER	0xc0000
+#define WILC3000_BOOTROM_STATUS		0x207ac
+#define WILC3000_CORTUS_BOOT_REGISTER_2	0x4f0000
+#define WILC3000_CHIP_ID		0x3b0000
 
 #define WILC_CORTUS_BOOT_FROM_IRAM	0x71
 
@@ -195,6 +217,8 @@
 #define WILC_1000_BASE_ID_2B_REV1	(WILC_1000_BASE_ID_2B + 1)
 #define WILC_1000_BASE_ID_2B_REV2	(WILC_1000_BASE_ID_2B + 2)
 
+#define WILC_3000_BASE_ID		0x300000
+
 #define WILC_CHIP_REV_FIELD		GENMASK(11, 0)
 
 /********************************************
@@ -413,6 +437,11 @@ static inline bool is_wilc1000(u32 id)
 	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
 }
 
+static inline bool is_wilc3000(u32 id)
+{
+	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_3000_BASE_ID;
+}
+
 int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
-- 
2.45.2


