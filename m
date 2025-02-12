Return-Path: <linux-wireless+bounces-18854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF76A32AA6
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E65188CD70
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06751261386;
	Wed, 12 Feb 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jrZVpFHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCC25D54C;
	Wed, 12 Feb 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375280; cv=none; b=EVjjrsudsdnsKSaaBSUD79I/s+yQlzRCuB1bWKKY8LEC6tAEyiQIGBOz1ZKCW03p+i03ohqfq66UXqf8aTwkCJcjQFFsQM0gw2KM/86tCfaOaTZPxfvxdSwfitt/wSmJEQxijiA8tnCXTxHznVa884EQCbFg8DbN8SRWQg745X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375280; c=relaxed/simple;
	bh=z6QtgQals0nj68HfLj/ST7GjV9kzm8CLeT9eKOKoVVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7IX0L+ebNhbGA5ML/AbjkvDBt2mZhXMB0Lr4xupi6WtzqEQgxSu1zxlfhREEQp9K3z1zh/UKxia0SvosNIPv3XEpwkNYls0yHDnpCWUvgZXLTkgpAzz1co8mt1nHSRg4boQwvguPDISdXMy737hdAgHGsa05QCs4A3rQ2fmgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jrZVpFHW; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCCFC44169;
	Wed, 12 Feb 2025 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E2aPfiJbXJ3tUrfXAYeEsTGlAb+ywwjD1zVqSfPHug=;
	b=jrZVpFHWxMTZVGPE3b26AtIMX6fFWPpy7jG9ONNAjya+xGWm/5ge/MptzCoRqa3QN/OuD3
	EfYXG+yofXLpdkkI+kuN+wgNA1hXtxDre4kOAORGkMB0SVX9fhUpOHuZhvPZp1jdB2CWp2
	PARvNi/nimMfnbzIJcNXCwiyO2jqn48JtxEVu2BH3IIxTxtFxIt+4wAKQkVIVDq8vIkEmn
	3Zc+f67QkgmNME9khtV4sWwPnu23Q3Q1tsLwF8LN0OFRlqXjzjAMiVFoKfgSbxxBl0jSY1
	dYE/ccQamdo1DsUN5+EZtjo21CglcBKydQcHFIoQGk29N51cMCo1aw+xXPS7AQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:28 +0100
Subject: [PATCH 09/12] wifi: wilc1000: disable firmware power save if
 bluetooth is in use
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-9-9609b784874e@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

If the wlan interface exposed by wilc driver has power save enabled
(either explicitly with iw dev wlan set power_save on, or because
kernel is built with CONFIG_CFG80211_DEFAULT_PS), it will send a power
management command to the wlan firmware when corresponding interface is
brought up. The bluetooth part, if used, is supposed to work
independently from the WLAN CPU. Unfortunately, this power save
management, if applied by the WLAN side, disrupts bluetooth operations
(the bluetooth CPU does not answer any command anymore on the UART
interface)

Make sure that the bluetooth part can work independently by disabling
power save in wlan firmware when bluetooth is in use.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/bt.c       | 29 +++++++++++++++++++---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  5 +++-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  3 +++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/bt.c b/drivers/net/wireless/microchip/wilc1000/bt.c
index b0f68a5479a5bd6f70e2390a35512037dc6c332b..f0eb5fb506eddf0f6f4f3f0b182eaa650c1c7a87 100644
--- a/drivers/net/wireless/microchip/wilc1000/bt.c
+++ b/drivers/net/wireless/microchip/wilc1000/bt.c
@@ -7,6 +7,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <net/wilc.h>
+#include "cfg80211.h"
 #include "netdev.h"
 #include "wlan_if.h"
 #include "wlan.h"
@@ -261,22 +262,36 @@ static int wilc_bt_start(struct wilc *wilc)
 int wilc_bt_init(void *wilc_wl_priv)
 {
 	struct wilc *wilc = (struct wilc *)wilc_wl_priv;
+	struct wilc_vif *vif;
 	int ret;
 
+	wilc->bt_enabled = true;
+
 	if (!wilc->hif_func->hif_is_init(wilc)) {
 		dev_info(wilc->dev, "Initializing bus before starting BT");
 		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
 		ret = wilc->hif_func->hif_init(wilc, false);
 		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
-		if (ret)
+		if (ret) {
+			wilc->bt_enabled = false;
 			return ret;
+		}
 	}
 
+	/* Power save feature managed by WLAN firmware may disrupt
+	 * operations from the bluetooth CPU, so disable it while bluetooth
+	 * is in use (if enabled, it will be enabled back when bluetooth is
+	 * not used anymore)
+	 */
+	vif = wilc_get_wl_to_vif(wilc);
+	if (wilc->power_save_mode && wilc_set_power_mgmt(vif, false))
+		goto hif_deinit;
+
 	mutex_lock(&wilc->radio_fw_start);
 	ret = wilc_bt_power_up(wilc);
 	if (ret) {
 		dev_err(wilc->dev, "Error powering up bluetooth chip\n");
-		goto hif_deinit;
+		goto reenable_power_save;
 	}
 	ret = wilc_bt_firmware_download(wilc);
 	if (ret) {
@@ -293,10 +308,14 @@ int wilc_bt_init(void *wilc_wl_priv)
 
 power_down:
 	wilc_bt_power_down(wilc);
-hif_deinit:
+reenable_power_save:
+	if (wilc->power_save_mode_request)
+		wilc_set_power_mgmt(vif, true);
 	mutex_unlock(&wilc->radio_fw_start);
+hif_deinit:
 	if (!wilc->initialized)
 		wilc->hif_func->hif_deinit(wilc);
+	wilc->bt_enabled = false;
 	return ret;
 }
 EXPORT_SYMBOL(wilc_bt_init);
@@ -304,6 +323,7 @@ EXPORT_SYMBOL(wilc_bt_init);
 int wilc_bt_shutdown(void *wilc_wl_priv)
 {
 	struct wilc *wilc = (struct wilc *)wilc_wl_priv;
+	struct wilc_vif *vif;
 	int ret;
 
 	mutex_lock(&wilc->radio_fw_start);
@@ -313,6 +333,9 @@ int wilc_bt_shutdown(void *wilc_wl_priv)
 		dev_warn(wilc->dev, "Failed to disable BT CPU\n");
 	if (wilc_bt_power_down(wilc))
 		dev_warn(wilc->dev, "Failed to power down BT CPU\n");
+	vif = wilc_get_wl_to_vif(wilc);
+	if (wilc->power_save_mode_request && wilc_set_power_mgmt(vif, true))
+		dev_warn(wilc->dev, "Failed to set back wlan power save\n");
 	if (!wilc->initialized)
 		wilc->hif_func->hif_deinit(wilc);
 	mutex_unlock(&wilc->radio_fw_start);
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index ff8c1a40634cee9960777eb017f6b2905e6399a5..04cff3561aad847a3f58a09766d0ef0fa61603e0 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1344,11 +1344,14 @@ static int set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc_priv *priv = &vif->priv;
+	struct wilc *wilc = vif->wilc;
 
 	if (!priv->hif_drv)
 		return -EIO;
 
-	wilc_set_power_mgmt(vif, enabled);
+	wilc->power_save_mode_request = enabled;
+	if (!wilc->bt_enabled)
+		wilc_set_power_mgmt(vif, enabled);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index 5837f8ffe548dad1b756cdbd8543636f2be0e9b0..4c297eb95eeb143fc2f1248e616ee307afa52dbd 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -213,6 +213,7 @@ struct wilc {
 	struct clk *rtc_clk;
 	bool initialized;
 	u32 chipid;
+	bool power_save_mode_request;
 	bool power_save_mode;
 	int dev_irq_num;
 	int close;
@@ -289,6 +290,8 @@ struct wilc {
 	u8 nv_mac_address[ETH_ALEN];
 	/* Lock to prevent concurrent start of wlan/bluetooth firmware */
 	struct mutex radio_fw_start;
+	/* Is the bluetooth part in use ? */
+	bool bt_enabled;
 };
 
 struct wilc_wfi_mon_priv {

-- 
2.48.0


