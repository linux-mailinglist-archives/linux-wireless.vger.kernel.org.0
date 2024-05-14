Return-Path: <linux-wireless+bounces-7650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1758C590C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF861C219A8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C817F366;
	Tue, 14 May 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z0frKdqh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BC17EBA1;
	Tue, 14 May 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701891; cv=none; b=sfmraPeOJ4bQpmFBJgEY3BnefKYKMQB9LNmf/uv200MqUgMtps428T0Yd3yB7Mzl3uDY/PqZuFyvcDC+rLSHwRgwInWq0SSmZnilExYRD1W82XanKpKu1ejg4Ck5K40zbIljFAaDMCjX13NHYWseyyBsiU7qMYsb9+72+t2KfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701891; c=relaxed/simple;
	bh=2zlYPmw0oUDai+GNvcnqVvjCPXfhTgT7BhksMICd//E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQbJkNuFLwEaqsW/htqy8muxN48oqiaf3dwtk5ffnUbXZQZoOcXHt7wRcVFomCvWIy2aPX0E7vjLCWTmnJqfgAx8pDivvU++3L53OPa9gAvhJZoXp2zDQ17roL1gN8rTXeQgbsRDz5XQuCkYvTlHGBEgbgpQ0bsbWMg5uTgUyL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z0frKdqh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 402381C000E;
	Tue, 14 May 2024 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715701887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgUbv5TLP2gFCNZsfWrjVO9v5Ap+kxXYDf/mGhYmWoo=;
	b=Z0frKdqhfbxSAuZM5+f20gEQMHsXTBKB5hvGPMqZqncvPBm585nNDHje1qc0YnrDLvp0AI
	wQrrGIqZwLgRl4+uD5wAKSkCoXAgFzDTp0rhm1TFgMCfGTGDKJXcqjBURFgSlPwygWP3H9
	kCS1gLaig7eFEvDSOOkj9uzfauqNa9TsCJhkoJ0njRSJ2QeK9zMoJWSL6KIPPifO6ywFhI
	+5spOyL5z67sxea+N7PX48extUUJNcRu19EUi9Sv1wd1fnRp9moLBgvQQMOy9FkgPRYPYr
	UG4WeX6P00nvXzVv7HJOlWvhzB7n3j1+c4q0Ofo/OaFKLd43Qu4+y6qHh7lHoQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 14 May 2024 17:51:20 +0200
Subject: [PATCH v2 2/6] wifi: wilc1000: register net device only after bus
 being fully initialized
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-mac_addr_at_probe-v2-2-afef09f1cd10@bootlin.com>
References: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
In-Reply-To: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <Heiko.Thiery@kontron.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

SDIO/SPI probes functions automatically add a default wlan interface on top
of registered wiphy, through wilc_cfg80211_init which in turn calls
wilc_netdev_ifc_init. However, bus is still not fully initialized when we
register corresponding net device (for example we still miss some private
driver data pointers), which for example makes it impossible to
retrieve MAC address from chip (which is supposed to be set on net device
before its registration) before registering net device. More generally, net
device registration should not be done until driver has fully initialized
everything and is ready to handle any operation  on the net device.

Prevent net device from being registered so early by doing it at the end of
probe functions. Apply this logic to both sdio and spi buses.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v2:
- export wilc_netdev_ifc_init symbol to make it usable from sdio/spi
  modules
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 10 ----------
 drivers/net/wireless/microchip/wilc1000/netdev.c   |  1 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     | 14 ++++++++++++--
 drivers/net/wireless/microchip/wilc1000/spi.c      | 11 +++++++++--
 4 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 7d9fb9f2d527..f716981f62ad 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1773,7 +1773,6 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 		       const struct wilc_hif_func *ops)
 {
 	struct wilc *wl;
-	struct wilc_vif *vif;
 	int ret, i;
 
 	wl = wilc_create_wiphy(dev);
@@ -1802,18 +1801,9 @@ int wilc_cfg80211_init(struct wilc **wilc, struct device *dev, int io_type,
 		ret = -ENOMEM;
 		goto free_cfg;
 	}
-	vif = wilc_netdev_ifc_init(wl, "wlan%d", WILC_STATION_MODE,
-				   NL80211_IFTYPE_STATION, false);
-	if (IS_ERR(vif)) {
-		ret = PTR_ERR(vif);
-		goto free_hq;
-	}
 
 	return 0;
 
-free_hq:
-	destroy_workqueue(wl->hif_workqueue);
-
 free_cfg:
 	wilc_wlan_cfg_deinit(wl);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index acc9b9a64552..166165ee7712 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -996,6 +996,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	free_netdev(ndev);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(wilc_netdev_ifc_init);
 
 MODULE_DESCRIPTION("Atmel WILC1000 core wireless driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 52a770c5e76f..a841dad08410 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -136,9 +136,11 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio_cmd53 *cmd)
 static int wilc_sdio_probe(struct sdio_func *func,
 			   const struct sdio_device_id *id)
 {
+	struct wilc_sdio *sdio_priv;
+	struct wilc_vif *vif;
 	struct wilc *wilc;
 	int ret;
-	struct wilc_sdio *sdio_priv;
+
 
 	sdio_priv = kzalloc(sizeof(*sdio_priv), GFP_KERNEL);
 	if (!sdio_priv)
@@ -176,9 +178,17 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	}
 	clk_prepare_enable(wilc->rtc_clk);
 
+	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
+				   NL80211_IFTYPE_STATION, false);
+	if (IS_ERR(vif)) {
+		ret = PTR_ERR(vif);
+		goto clk_disable_unprepare;
+	}
+
 	dev_info(&func->dev, "Driver Initializing success\n");
 	return 0;
-
+clk_disable_unprepare:
+	clk_disable_unprepare(wilc->rtc_clk);
 dispose_irq:
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 61c3572ce321..add0e70a09ea 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -206,9 +206,10 @@ static void wilc_wlan_power(struct wilc *wilc, bool on)
 
 static int wilc_bus_probe(struct spi_device *spi)
 {
-	int ret;
-	struct wilc *wilc;
 	struct wilc_spi *spi_priv;
+	struct wilc_vif *vif;
+	struct wilc *wilc;
+	int ret;
 
 	spi_priv = kzalloc(sizeof(*spi_priv), GFP_KERNEL);
 	if (!spi_priv)
@@ -250,6 +251,12 @@ static int wilc_bus_probe(struct spi_device *spi)
 		goto power_down;
 
 	wilc_wlan_power(wilc, false);
+	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
+				   NL80211_IFTYPE_STATION, false);
+	if (IS_ERR(vif)) {
+		ret = PTR_ERR(vif);
+		goto power_down;
+	}
 	return 0;
 
 power_down:

-- 
2.44.0


