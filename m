Return-Path: <linux-wireless+bounces-12192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A979636FA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 02:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A01B23653
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499C134D1;
	Thu, 29 Aug 2024 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="I9XaCTol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6113A92D;
	Thu, 29 Aug 2024 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892342; cv=none; b=kFxdrOUAi+76GPLKeCz1i7I7Zj8i2fIWb1rGqDtLiEY4uCdfK4oYwtoOIPEcPtxaUoqBQ6kEBsAq61RQij74y74Ks9XJK5P0kCnsf6WvTQ3K8GNfpVBp8bV+hDzHUC+nK6Txz1Xpsm2vmmssJHQWx1EOhy1M5/y94pCyNqO98Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892342; c=relaxed/simple;
	bh=V2Aab4ITWBFo9jbeOQF7rtzjrZa9Dd4+Rux3weWI1p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqN9iWKkrd5lm8rmeYzOgUc+c7KLlBXtHtldr8uq76j6ps5XvisAFirlvA1jfm+KUT1ffUFR5XAdzjjUo7HsQG1CGm68ZiTiunG9RrR7UkbOLY4eD3EYUhWG8gOKe/UZZwl5+eQGQOZlBkEnBHte1cEaWiI7pCiznmWMzCNawog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=I9XaCTol; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B7CC78817C;
	Thu, 29 Aug 2024 02:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724892339;
	bh=fLjYiTnekZzuCWyVRGuuJpvWcfSvccPk3bmLqG4yIZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9XaCTolM+7hIy9/8jRgGNfnxYFFDavwFFLPszivQPzxN2xr9J7atLv8rWTdEeRcM
	 yHMwieXYSd0/Ir54y4pbVKoxwNtAYmE9Le9mTAfBPZ1uTkTsmJs3KIbHCqMzwuOYTh
	 TbtLWz61Fdty9GEq7HcioRygkEXO1AOEtvfjz0FxkpTUsp4GKaYf2226OVXgMmOYD+
	 AQbrcaRTpKhZ/fV2cjXZ8uI55IKJA0a2aoTSy1Kkhg9B0NVRue8l3GEN4/6eFT7hRA
	 mi97lnRHCrCNe62nTf+otP/SPEdX4tqpDH0IYbBXXlk6zPUeMmQORyQcbG47lOPmjn
	 TI5QFqC1PMoNQ==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
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
Subject: [PATCH v4 2/5] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
Date: Thu, 29 Aug 2024 02:45:00 +0200
Message-ID: <20240829004510.178016-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829004510.178016-1-marex@denx.de>
References: <20240829004510.178016-1-marex@denx.de>
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

Do not use wilc_get_chipid() outside of wlan.c . Instead, call
wilc_get_chipid() right after the SDIO/SPI interface has been
initialized to cache the device chipid, and then use the cached
chipid throughout the driver. Make wilc_get_chipid() static and
remove its prototype from wlan.h . Make wilc_get_chipid() return
a proper return value instead of a chipid.

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Marek Vasut <marex@denx.de>
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
Cc: Marek Vasut <marex@denx.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: New patch
V3: - Undo setup in wilc_wlan_init() if chip is neither wilc1000 or wilc3000
    - Make wilc_get_chipid() return proper return value
V4: - Drop wilc_get_chipid() from netdev.c
    - Add RB from Alexis
---
 .../net/wireless/microchip/wilc1000/netdev.c  |  6 +-
 .../net/wireless/microchip/wilc1000/sdio.c    | 13 ----
 .../net/wireless/microchip/wilc1000/wlan.c    | 74 +++++++++++--------
 .../net/wireless/microchip/wilc1000/wlan.h    |  1 -
 4 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 9ecf3fb29b558..086e70d833e06 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -195,13 +195,13 @@ static int wilc_wlan_get_firmware(struct net_device *dev)
 {
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc = vif->wilc;
-	int chip_id;
 	const struct firmware *wilc_fw;
 	int ret;
 
-	chip_id = wilc_get_chipid(wilc, false);
+	if (!is_wilc1000(wilc->chipid))
+		return -EINVAL;
 
-	netdev_info(dev, "ChipID [%x] loading firmware [%s]\n", chip_id,
+	netdev_info(dev, "WILC1000 loading firmware [%s]\n",
 		    WILC1000_FW(WILC1000_API_VER));
 
 	ret = request_firmware(&wilc_fw, WILC1000_FW(WILC1000_API_VER),
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 41122199d51eb..90357c89ae29b 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -671,7 +671,6 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
 	struct sdio_cmd52 cmd;
 	int loop, ret;
-	u32 chipid;
 
 	/**
 	 *      function 0 csa enable
@@ -760,18 +759,6 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
 		return ret;
 	}
 
-	/**
-	 *      make sure can read back chip id correctly
-	 **/
-	if (!resume) {
-		ret = wilc_sdio_read_reg(wilc, WILC_CHIPID, &chipid);
-		if (ret) {
-			dev_err(&func->dev, "Fail cmd read chip id...\n");
-			return ret;
-		}
-		dev_err(&func->dev, "chipid (%08x)\n", chipid);
-	}
-
 	sdio_priv->isinit = true;
 	return 0;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 533939e71534a..5b7dd37267de0 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1402,9 +1402,37 @@ int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 	return ret;
 }
 
+static int wilc_get_chipid(struct wilc *wilc)
+{
+	u32 chipid = 0;
+	u32 rfrevid = 0;
+
+	if (wilc->chipid == 0) {
+		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
+		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
+					     &rfrevid);
+		if (!is_wilc1000(chipid)) {
+			wilc->chipid = 0;
+			return -EINVAL;
+		}
+		if (chipid == WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
+			if (rfrevid != 0x1)
+				chipid = WILC_1000_BASE_ID_2A_REV1;
+		} else if (chipid == WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
+			if (rfrevid == 0x4)
+				chipid = WILC_1000_BASE_ID_2B_REV1;
+			else if (rfrevid != 0x3)
+				chipid = WILC_1000_BASE_ID_2B_REV2;
+		}
+
+		wilc->chipid = chipid;
+	}
+
+	return 0;
+}
+
 static int init_chip(struct net_device *dev)
 {
-	u32 chipid;
 	u32 reg;
 	int ret = 0;
 	struct wilc_vif *vif = netdev_priv(dev);
@@ -1412,9 +1440,11 @@ static int init_chip(struct net_device *dev)
 
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 
-	chipid = wilc_get_chipid(wilc, true);
+	ret = wilc_get_chipid(wilc);
+	if (ret)
+		goto release;
 
-	if ((chipid & 0xfff) != 0xa0) {
+	if ((wilc->chipid & 0xfff) != 0xa0) {
 		ret = wilc->hif_func->hif_read_reg(wilc,
 						   WILC_CORTUS_RESET_MUX_SEL,
 						   &reg);
@@ -1445,34 +1475,6 @@ static int init_chip(struct net_device *dev)
 	return ret;
 }
 
-u32 wilc_get_chipid(struct wilc *wilc, bool update)
-{
-	u32 chipid = 0;
-	u32 rfrevid = 0;
-
-	if (wilc->chipid == 0 || update) {
-		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
-		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
-					     &rfrevid);
-		if (!is_wilc1000(chipid)) {
-			wilc->chipid = 0;
-			return wilc->chipid;
-		}
-		if (chipid == WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
-			if (rfrevid != 0x1)
-				chipid = WILC_1000_BASE_ID_2A_REV1;
-		} else if (chipid == WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
-			if (rfrevid == 0x4)
-				chipid = WILC_1000_BASE_ID_2B_REV1;
-			else if (rfrevid != 0x3)
-				chipid = WILC_1000_BASE_ID_2B_REV2;
-		}
-
-		wilc->chipid = chipid;
-	}
-	return wilc->chipid;
-}
-
 int wilc_load_mac_from_nv(struct wilc *wl)
 {
 	int ret = -EINVAL;
@@ -1535,9 +1537,19 @@ int wilc_wlan_init(struct net_device *dev)
 	if (!wilc->hif_func->hif_is_init(wilc)) {
 		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
 		ret = wilc->hif_func->hif_init(wilc, false);
+		if (!ret)
+			ret = wilc_get_chipid(wilc);
 		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
 		if (ret)
 			goto fail;
+
+		if (!is_wilc1000(wilc->chipid)) {
+			netdev_err(dev, "Unsupported chipid: %x\n", wilc->chipid);
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		netdev_dbg(dev, "chipid (%08x)\n", wilc->chipid);
 	}
 
 	if (!wilc->vmm_table)
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index dd2fb3c2f06a2..ae187192a79c6 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -443,6 +443,5 @@ void chip_wakeup(struct wilc *wilc);
 int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count);
 int wilc_wlan_init(struct net_device *dev);
-u32 wilc_get_chipid(struct wilc *wilc, bool update);
 int wilc_load_mac_from_nv(struct wilc *wilc);
 #endif
-- 
2.45.2


