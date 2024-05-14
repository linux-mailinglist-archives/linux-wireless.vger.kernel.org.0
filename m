Return-Path: <linux-wireless+bounces-7654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAF8C5917
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5032628440F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5A180A68;
	Tue, 14 May 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D4wd31aG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F617EBA9;
	Tue, 14 May 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701893; cv=none; b=uGGuRYnuQt6BJkZVXSC5JhTS+N1/1y6VSaWhz7J1D8MyRMYVYJNK3R+140dCFcttaKmMdvWFd/aMUHT0reXOoTOhqRz8cEMzlYE6iihopeY58q1xWWq9uBX4QzZZBfL6SawbNrF/HKksuktkgPKKfrFKi154u6V3a8z9Mv/LMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701893; c=relaxed/simple;
	bh=wgjBRltNMkgyiHUnfn56CYOWH+y55q5EPCYwOVEoFJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9yovJKB1Q4odJ4EPcdWSJyRm4UXwLiemf3MOHt63ggggmA8sWN3NZMt7tnOa80hWNvpNAXrRJCEyJYaVMoQNL9h8M7px8qmWH1RglmdjE1PFD5R6IThzvbmDcHZFeNvxeAFKK4d8MRqBk3XWieKVBAHTeWeKVE0Mthz7pPiknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D4wd31aG; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FB811C0009;
	Tue, 14 May 2024 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715701889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq3Rjgw28L31fvGfHlWTTsb6g3gG5Rbyf4qVPui9ZPw=;
	b=D4wd31aGiCjZyWIF3+DC4F3X7veT54su8J22YS7wOvyv/hWS72PK/RT82D053N/V6VROPp
	+jrAyBme0SlJhyLwsDjW2/p3l1V6UUyfplZ7FKjxHM+hBs56voGdSFFSIYlSOJjpNbqMjW
	O9MW99a3hEImnLBV7/Mx4NENM4kNFc/IlpMwWroq8RejtHabVUT9JL3DHo2D7OtBot+y2B
	NYLP3UmTKzAbDrRVETyDWEPsNpYoGuUBO0CSVb+0aO0K+QTPyaOo9tLJEva05vddo6d3iv
	CCcJFStjdlmivkRAQQSVV2XHU7sqUcYCen50lSpbZe4wAyD7v5UXHUQ5pHmpKw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 14 May 2024 17:51:24 +0200
Subject: [PATCH v2 6/6] wifi: wilc1000: read MAC address from fuse at probe
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-mac_addr_at_probe-v2-6-afef09f1cd10@bootlin.com>
References: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
In-Reply-To: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <Heiko.Thiery@kontron.com>, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

The default netdev interface exposed by WILC1000 is registered at probe,
but the chip mac address is not known until ndo_open, which will load and
start chip firmware and then retrieve stored MAC address from it. As a
consequence, the interface has uninitialized value (00:00:00:00:00) until a
user brings up the interface.

Fix MAC address at probe by setting the following steps:
- at probe, read MAC address directly from fuse
- whenever a new netdevice is created, apply saved mac address (which can
  be a user-provided address, or the eFuse Mac address if no address has
  been passed by user)
- whenever an interface is brought up for the first time (and so the
  firmware is loaded and started), enforce netdevice mac address to the
  chip (in case user has changed it)

Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Closes: https://lore.kernel.org/netdev/CAEyMn7aV-B4OEhHR4Ad0LM3sKCz1-nDqSb9uZNmRWR-hMZ=z+A@mail.gmail.com/T/
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Co-developed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Tested-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 38 ++++++++++++++----------
 drivers/net/wireless/microchip/wilc1000/sdio.c   | 14 +++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c    |  6 ++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 2ee3d9827826..4e2698528a49 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -588,7 +588,6 @@ static int wilc_mac_open(struct net_device *ndev)
 	struct wilc *wl = vif->wilc;
 	int ret = 0;
 	struct mgmt_frame_regs mgmt_regs = {};
-	u8 addr[ETH_ALEN] __aligned(2);
 
 	if (!wl || !wl->dev) {
 		netdev_err(ndev, "device not ready\n");
@@ -607,25 +606,19 @@ static int wilc_mac_open(struct net_device *ndev)
 		return ret;
 	}
 
-	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
-				vif->idx);
-
-	if (is_valid_ether_addr(ndev->dev_addr)) {
-		ether_addr_copy(addr, ndev->dev_addr);
-		wilc_set_mac_address(vif, addr);
-	} else {
-		wilc_get_mac_address(vif, addr);
-		eth_hw_addr_set(ndev, addr);
-	}
 	netdev_dbg(ndev, "Mac address: %pM\n", ndev->dev_addr);
-
-	if (!is_valid_ether_addr(ndev->dev_addr)) {
-		netdev_err(ndev, "Wrong MAC address\n");
+	ret = wilc_set_mac_address(vif, ndev->dev_addr);
+	if (ret) {
+		netdev_err(ndev, "Failed to enforce MAC address in chip");
 		wilc_deinit_host_int(ndev);
-		wilc_wlan_deinitialize(ndev);
-		return -EINVAL;
+		if (!wl->open_ifcs)
+			wilc_wlan_deinitialize(ndev);
+		return ret;
 	}
 
+	wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
+				vif->idx);
+
 	mgmt_regs.interface_stypes = vif->mgmt_reg_stypes;
 	/* so we detect a change */
 	vif->mgmt_reg_stypes = 0;
@@ -941,6 +934,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 				      int vif_type, enum nl80211_iftype type,
 				      bool rtnl_locked)
 {
+	u8 mac_address[ETH_ALEN];
 	struct net_device *ndev;
 	struct wilc_vif *vif;
 	int ret;
@@ -969,6 +963,18 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	vif->iftype = vif_type;
 	vif->idx = wilc_get_available_idx(wl);
 	vif->mac_opened = 0;
+
+	memcpy(mac_address, wl->nv_mac_address, ETH_ALEN);
+	/* WILC firmware uses locally administered MAC address for the
+	 * second virtual interface (bit 1 of first byte set), but
+	 * since it is possibly not loaded/running yet, reproduce this behavior
+	 * in the driver during interface creation.
+	 */
+	if (vif->idx)
+		mac_address[0] |= 0x2;
+
+	eth_hw_addr_set(vif->ndev, mac_address);
+
 	mutex_lock(&wl->vif_mutex);
 	list_add_tail_rcu(&vif->list, &wl->vif_list);
 	wl->vif_num += 1;
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 04d6565df2cb..e6e20c86b791 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -24,6 +24,9 @@ MODULE_DEVICE_TABLE(sdio, wilc_sdio_ids);
 
 #define WILC_SDIO_BLOCK_SIZE 512
 
+static int wilc_sdio_init(struct wilc *wilc, bool resume);
+static int wilc_sdio_deinit(struct wilc *wilc);
+
 struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
@@ -178,6 +181,16 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	}
 	clk_prepare_enable(wilc->rtc_clk);
 
+	wilc_sdio_init(wilc, false);
+
+	ret = wilc_load_mac_from_nv(wilc);
+	if (ret) {
+		pr_err("Can not retrieve MAC address from chip\n");
+		goto clk_disable_unprepare;
+	}
+
+	wilc_sdio_deinit(wilc);
+
 	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
 				   NL80211_IFTYPE_STATION, false);
 	if (IS_ERR(vif)) {
@@ -187,6 +200,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
 
 	dev_info(&func->dev, "Driver Initializing success\n");
 	return 0;
+
 clk_disable_unprepare:
 	clk_disable_unprepare(wilc->rtc_clk);
 dispose_irq:
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index add0e70a09ea..5ff940c53ad9 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -250,6 +250,12 @@ static int wilc_bus_probe(struct spi_device *spi)
 	if (ret)
 		goto power_down;
 
+	ret = wilc_load_mac_from_nv(wilc);
+	if (ret) {
+		pr_err("Can not retrieve MAC address from chip\n");
+		goto power_down;
+	}
+
 	wilc_wlan_power(wilc, false);
 	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
 				   NL80211_IFTYPE_STATION, false);

-- 
2.44.0


