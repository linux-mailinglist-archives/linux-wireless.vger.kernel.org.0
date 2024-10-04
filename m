Return-Path: <linux-wireless+bounces-13502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A16F990257
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38311281E78
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F715B0FF;
	Fri,  4 Oct 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GzoK5Pav"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C58148316;
	Fri,  4 Oct 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042392; cv=none; b=CWVleslfNWG+bufdDKYUbV4UhP3jD7iKlWxJiAIr51NIYVBIIEtNG3G8exu3fn8FpQAhOwBXmSix/NWmnR8vHp69/cLyyymgk1Me8LI3qY47gojfDsh5/JLPQv3H0cz+TAT9Dn8yNFwKpkI+w5nCOa6sf/lxKXRCdVrXt42auI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042392; c=relaxed/simple;
	bh=1wWDEWjjdfcKcfIfVvpZcvZnWhG9Wc1aXAWz2l+SiOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0nNgLIyHxoXYKGQAg6bJAghdWSFXSo8qEORzJbrg57qI4hyNVKJJy6RjkVXdCOdvC85p7kiJEQt+OPtWy1Pq06M7KWd4Fk5j0t46koRaPu6T5pkXf/skJUPd5VjBxw73+kzxhta56EdzS1+teO6VzoRDL4PyljMAhFJ1epi6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GzoK5Pav; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D2DB288B63;
	Fri,  4 Oct 2024 13:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728042383;
	bh=OHSzMRtoLkZ1l0NiEhgbVrH5DU6gAPhAKPRc0Y49MjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzoK5Pavd2LD/lb2b6s0Ps9OqLIpdSFVp5V7Oyohf+52dEZABLQeC4ISfWiRmFSK5
	 LOuieMkkG7ow+5wxVPesM5vhanwsxflk0luXrdDlkLBx8IuhAgTLhYBRh563k+jOFz
	 q/Pe6cjEGIMruqe1WJ0LBJIA3EVD43a25HYViCcTYu4W0lcTFVhgIK671cZQDGbAX2
	 l0x4j4xvZDCE1Ug2uZKFJEYurDpflCPS6WAg1D80sJELNnQXgVLl5NsP3pRWol9qxl
	 ZtLjHLeJE5UI4568k1cN1KlxZuS7yjhVQMaR2zL4vq1+UQ9U1ATFsf3sYka4rMbTeP
	 qgyd55kyxtRlw==
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
Subject: [PATCH v8 2/7] wifi: wilc1000: Clean up usage of wilc_get_chipid()
Date: Fri,  4 Oct 2024 13:44:11 +0200
Message-ID: <20241004114551.40236-2-marex@denx.de>
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

Reduce the use of wilc_get_chipid(), use cached chip ID wherever
possible. Remove duplicated partial chip ID read implementations
from the driver. Update wilc_get_chipid() to always read the chip
ID out of the hardware and update the cached chip ID, and make it
return a proper return value instead of a chipid. Call wilc_get_chipid()
early to make the cached chip ID available to various sites using
is_wilc1000() to access the cached chip ID.

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
V5: No change
V6: - Get chipid early in probe
    - Drop RB
    - Rebase on next-20240926
V7: - Update commit message
    - Reinstate RB
    - Rebase on next-20241003 / wireless-next/main 5a4d42c1688c
      with v2 wifi: wilc1000: Keep slot powered on during suspend/resume
V8: Add missing EXPORT_SYMBOL_GPL(wilc_get_chipid)
---
 .../net/wireless/microchip/wilc1000/netdev.c  |  6 +-
 .../net/wireless/microchip/wilc1000/sdio.c    | 17 +----
 drivers/net/wireless/microchip/wilc1000/spi.c |  2 +-
 .../net/wireless/microchip/wilc1000/wlan.c    | 75 +++++++++++--------
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 +-
 5 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 8bc127c5a538c..3e80d29a99ccf 100644
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
index d67662b6b2a1a..7bc6d788f33a7 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -182,6 +182,10 @@ static int wilc_sdio_probe(struct sdio_func *func,
 
 	wilc_sdio_init(wilc, false);
 
+	ret = wilc_get_chipid(wilc);
+	if (ret)
+		goto dispose_irq;
+
 	ret = wilc_load_mac_from_nv(wilc);
 	if (ret) {
 		pr_err("Can not retrieve MAC address from chip\n");
@@ -667,7 +671,6 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
 	struct sdio_cmd52 cmd;
 	int loop, ret;
-	u32 chipid;
 
 	/**
 	 *      function 0 csa enable
@@ -756,18 +759,6 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
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
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 05b577b1068ea..81cf82c9175ef 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -245,7 +245,7 @@ static int wilc_bus_probe(struct spi_device *spi)
 	if (ret)
 		goto power_down;
 
-	ret = wilc_validate_chipid(wilc);
+	ret = wilc_get_chipid(wilc);
 	if (ret)
 		goto power_down;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 533939e71534a..28212ff28c112 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1402,9 +1402,38 @@ int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 	return ret;
 }
 
+int wilc_get_chipid(struct wilc *wilc)
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
+EXPORT_SYMBOL_GPL(wilc_get_chipid);
+
 static int init_chip(struct net_device *dev)
 {
-	u32 chipid;
 	u32 reg;
 	int ret = 0;
 	struct wilc_vif *vif = netdev_priv(dev);
@@ -1412,9 +1441,11 @@ static int init_chip(struct net_device *dev)
 
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
@@ -1445,34 +1476,6 @@ static int init_chip(struct net_device *dev)
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
@@ -1535,9 +1538,19 @@ int wilc_wlan_init(struct net_device *dev)
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
index dd2fb3c2f06a2..44dce53d24916 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -443,6 +443,6 @@ void chip_wakeup(struct wilc *wilc);
 int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count);
 int wilc_wlan_init(struct net_device *dev);
-u32 wilc_get_chipid(struct wilc *wilc, bool update);
+int wilc_get_chipid(struct wilc *wilc);
 int wilc_load_mac_from_nv(struct wilc *wilc);
 #endif
-- 
2.45.2


