Return-Path: <linux-wireless+bounces-12078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150796145A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6EDFB222DE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5EC1CEAB1;
	Tue, 27 Aug 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="rwOR3Wef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7351C6F5B;
	Tue, 27 Aug 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776896; cv=none; b=XZndlIWU6Yuz3nNe/E8BWrYtyCNTHY2xhlshqD7huMd+4nAcnmRQQQHVVCuiSnJjZS6LadeKBeXPtZtFhOT1tr6qW9cJ9+wTgLOuUxUbARbXQLtckxw6U6Ixl5S50xKi5nrvAKuriD6NbdbtZEF0rK10Erfyk94kngLYwt6jhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776896; c=relaxed/simple;
	bh=rcs14JjphcQZk8BGpxJioplOMFoepkS8KQk9M7GX09k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4wpNYZUwlb5PceSr1jSLDk/OuJ1SipJTZadbbrGyL/mNzqivrUhh/5PLIXKwpk7O/qfk5KUJKXOn9wRyWVHkuKzMQJVWbDEwWdxL6Zb6kl4z5AxG8D6557MwRvxlP1ofCJpstJCF9K7qFw3tBhQyG9rbqWiVJB6FPWGl+6CbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=rwOR3Wef; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6471F888C8;
	Tue, 27 Aug 2024 18:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724776893;
	bh=rCa/y6dVPDa4950hoO2JraWPKEHMhAThqshSsLh20b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwOR3Wef2JyoNArvJU38f31Ln/8NmRxwfe4XzC2rBn5xcLywW1BuU59JegAU4KNiZ
	 B5zuki4pb7ir+sJIq0Duvc3De9+QTlcNKNNoh0X6yErz1MSCJlIEyOPrjumjcuBRix
	 HP9Sd7u/G86/5yiOAvRLO65qRa1Yr8KmPJ2KyPeNk6PEB22OMK1mgGbneu6JJwHwca
	 p/CpvSRkP4D9OKDJvMcVdVNxpdR51ml+87krwPuqQuumCh9Vr4w5qBXXkdef206PA5
	 fUfKLEbq4gRVjlaGhVPa7wK+zlxorcjfc/k0C/U9zOiylzGyXoEH6g4t4zg3FIOu0p
	 Ua9m083uWyPrg==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
Subject: [PATCH v3 2/5] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
Date: Tue, 27 Aug 2024 18:37:39 +0200
Message-ID: <20240827164042.53698-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827164042.53698-1-marex@denx.de>
References: <20240827164042.53698-1-marex@denx.de>
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
---
 .../net/wireless/microchip/wilc1000/sdio.c    | 13 ----
 .../net/wireless/microchip/wilc1000/wlan.c    | 74 +++++++++++--------
 .../net/wireless/microchip/wilc1000/wlan.h    |  1 -
 3 files changed, 43 insertions(+), 45 deletions(-)

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


