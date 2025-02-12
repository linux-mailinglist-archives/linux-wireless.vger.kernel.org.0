Return-Path: <linux-wireless+bounces-18849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A88EA32A80
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625E3167D0D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237A256C7E;
	Wed, 12 Feb 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bWhR95VJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1EE21772B;
	Wed, 12 Feb 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375274; cv=none; b=CRCXEqG3GO6QUao2uPP0pRMJTv9wucNYgh+vBiUAJzvRZmdbi4ItGp+Rc2bLgCZdNc4+GRspOzXOtvFjo++BoB2Rzv1zEYgzQVIVOTA7OvXq1kNYrYIzgxkgEHzfYd1P74UVpv91j5o3oFpn82EX/GsNvjqjTDQPftfpdAeNGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375274; c=relaxed/simple;
	bh=Mlv81zmIhEZHJwT/hcQ3yQ6ZyHpYyAKt5h56HYPA/ZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnqYZWDlecnhQarlY7Q1ZFOcHy/+p9hvZwdPlNGqcSkBc0/3JvVon9pIA2QFMVWZxBUY5mbYeZJBeEeuqqz0+TccTs+3zr5QwmcG4s3N4DAIl3ZsYZU0hYy1BrxS99ELFOEBAuSLlCEugNpn/ucFdHkVSW8hiwoTZHqezI2GftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bWhR95VJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09DA1440FB;
	Wed, 12 Feb 2025 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fD1k5bMIW/imRQuzK5KhvhuylFhJp7j2W2nlf3giUE=;
	b=bWhR95VJSQ5uC0Sndhv/pxDenw+gX0dRpNFdgQqPWiD91pebWItUJdF7NB4RPGLQ8wl8nl
	GzgiZeiT8vYFJIsXBuf2C8sMvDFiGHOG5+Xq1dU0385nrdyGp/o0jA6HfVkmDJTLoiK42r
	cECb4VyA8zCdQv/5hiV5tzuV1kDfMWQ8LIHV2feTZlGPW7N0Pa11gKqaSjh360msfQPQ+M
	cifWlglhSf6M4hT+ELh6sMeMTBTBI0HhjFfg9ZHwvX/Y2ClOqR5fZ1KgjPGIuWoD/MjWIj
	Zg9rvDivxMjKIteLEfJBhlPH6ZVrne6QjQ3iXkcPenJUOHiuGawqL6ikkMLhhg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:22 +0100
Subject: [PATCH 03/12] wifi: wilc1000: add lock to prevent concurrent
 firmware startup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-3-9609b784874e@bootlin.com>
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

wilc1000 driver supports WILC3000, a combo wifi/bluetooth chip. This
chip needs a firmware for each radio. Before bringing support for the
bluetooth side (and so, before adding bluetooth firmware load and
start), add a dedicated lock around firmware loading and startup for
wlan side. The bluetooth part will also use this lock to ensure that
both firmware are not being loaded/started at the same time.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 ++
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 5 +++++
 drivers/net/wireless/microchip/wilc1000/netdev.h   | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f9919232350761d51cbb1b5be87ca39e855..393fff618f919c5a6d3f4a7d894b187399455fb8 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1736,6 +1736,7 @@ static void wlan_init_locks(struct wilc *wl)
 	mutex_init(&wl->cfg_cmd_lock);
 	mutex_init(&wl->vif_mutex);
 	mutex_init(&wl->deinit_lock);
+	mutex_init(&wl->radio_fw_start);
 
 	spin_lock_init(&wl->txq_spinlock);
 	mutex_init(&wl->txq_add_to_head_cs);
@@ -1755,6 +1756,7 @@ void wlan_deinit_locks(struct wilc *wilc)
 	mutex_destroy(&wilc->txq_add_to_head_cs);
 	mutex_destroy(&wilc->vif_mutex);
 	mutex_destroy(&wilc->deinit_lock);
+	mutex_destroy(&wilc->radio_fw_start);
 	cleanup_srcu_struct(&wilc->srcu);
 }
 
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index af298021e05041ba4b16a94c8ee768407a208dfc..d24859d12ccd535c966a9b7f46378ac3b3a21d7b 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
 
+#include "linux/mutex.h"
 #include <linux/irq.h>
 #include <linux/kthread.h>
 #include <linux/firmware.h>
@@ -534,6 +535,8 @@ static int wilc_wlan_initialize(struct net_device *dev, struct wilc_vif *vif)
 			goto fail_irq_init;
 		}
 
+		mutex_lock(&wl->radio_fw_start);
+
 		ret = wilc_wlan_get_firmware(dev);
 		if (ret)
 			goto fail_irq_enable;
@@ -562,6 +565,7 @@ static int wilc_wlan_initialize(struct net_device *dev, struct wilc_vif *vif)
 			netdev_err(dev, "Failed to configure firmware\n");
 			goto fail_fw_start;
 		}
+		mutex_unlock(&wl->radio_fw_start);
 		wl->initialized = true;
 		return 0;
 
@@ -569,6 +573,7 @@ static int wilc_wlan_initialize(struct net_device *dev, struct wilc_vif *vif)
 		wilc_wlan_stop(wl, vif);
 
 fail_irq_enable:
+		mutex_unlock(&wl->radio_fw_start);
 		if (!wl->dev_irq_num &&
 		    wl->hif_func->disable_interrupt)
 			wl->hif_func->disable_interrupt(wl);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index 95bc8b8fe65a584615b6b9021d08d11e4b36408b..5837f8ffe548dad1b756cdbd8543636f2be0e9b0 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -287,6 +287,8 @@ struct wilc {
 	struct ieee80211_supported_band band;
 	u32 cipher_suites[ARRAY_SIZE(wilc_cipher_suites)];
 	u8 nv_mac_address[ETH_ALEN];
+	/* Lock to prevent concurrent start of wlan/bluetooth firmware */
+	struct mutex radio_fw_start;
 };
 
 struct wilc_wfi_mon_priv {

-- 
2.48.0


