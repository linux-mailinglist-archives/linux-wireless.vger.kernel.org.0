Return-Path: <linux-wireless+bounces-16734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A171A9FB0E1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE40F165FAD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA817BB0D;
	Mon, 23 Dec 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LJBugzfj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CE1392;
	Mon, 23 Dec 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968836; cv=none; b=MLL3kPtjOPy/J+dz3pmBafBhQcD1+Km8Sly/YX6DiN+oWKnYU3luPZ1b1aXc8DU+sJfuCjS6tiPu0A18u1Z7tm8AJJwleDgHTaWrG05WjAOh8FZY8vw2YV9MfZMGM6jVwuzpjGk/q/ZlLDSAr476rhotPs8cK7ef4d4lzt4bnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968836; c=relaxed/simple;
	bh=4Qn2q61tUxHAF1fzLiqELFRHhk5hSoPWzOHX9cKsWcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YFYCkYZSZuscrJJTGCF5UO3kJbnm7M3mxjcgrCSCkWH1JdvMG50DbFofOBJyUEQDOSG4rVx2O3UqRZ6XLo0j0FRw8K82VmHmLmr68NSfqPDl1Kn7LuUBnvVv9DVEeFFae+YF1zGocjvKO8d9l2Aph4xsr7xM6Rl4BF2wIk1SP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LJBugzfj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8ECEC1BF204;
	Mon, 23 Dec 2024 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734968832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GUJu1Sd/MM0fZAqwu+qR+ZOHyutrBoq4u2/CkZK+wCw=;
	b=LJBugzfjc7M68QcCPy5Z/IapIV1dCcAKYV75c7uloz82qKiVCGnb2IQZvOAEyiZMP4HKAQ
	q4IpjrnjsfkUdMKeo2p1RckZA92DFfJJk+t7rkPNyQKHibUd8XOUmwtsC7gYT3YmoZ/S8+
	JtfPeo7Q4mbbY3dBG9/5TcaVnWSP/drsDSnIW0DbaiVlOk3TYMxYYz4AWjlt2XWroT2cBY
	knHv/JSpa456DGlROCEZiKXqCklTwhmf1IR6mhrgNT2bGxtkyqK7qAm17qpxQPiBdmXWQd
	PNL7W53t7Bp+9LDh3cEZS4NjqBPB/GAFcfGGlvAWf2L1anI2oin9JhPi3aKahQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 23 Dec 2024 16:46:48 +0100
Subject: [PATCH wireless] wifi: wilc1000: unregister wiphy only if it has
 been registered
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241223-wilc_fix_probe_error_path-v1-1-91fa7bd8e5b6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOeFaWcC/x2MUQqDMBAFryL7baAmUrBXKSVs7GtdEBN2RQXx7
 g39HJiZkwwqMHo0Jyk2MclLha5taJx4+cLJuzL5m+8774PbZR7jR45YNCdEqGaNhdfJ8b1PCDy
 kMDDVviiq938/aRfFDDN6XdcPFPn8eXUAAAA=
X-Change-ID: 20241223-wilc_fix_probe_error_path-a64be3a9b39a
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

There is a specific error path in probe functions in wilc drivers (both
sdio and spi) which can lead to kernel panic, as this one for example
when using SPI:

Unable to handle kernel paging request at virtual address 9f000000 when read
[9f000000] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in: wilc1000_spi(+) crc_itu_t crc7 wilc1000 cfg80211 bluetooth ecdh_generic ecc
CPU: 0 UID: 0 PID: 106 Comm: modprobe Not tainted 6.13.0-rc3+ #22
Hardware name: Atmel SAMA5
PC is at wiphy_unregister+0x244/0xc40 [cfg80211]
LR is at wiphy_unregister+0x1c0/0xc40 [cfg80211]
[...]
 wiphy_unregister [cfg80211] from wilc_netdev_cleanup+0x380/0x494 [wilc1000]
 wilc_netdev_cleanup [wilc1000] from wilc_bus_probe+0x360/0x834 [wilc1000_spi]
 wilc_bus_probe [wilc1000_spi] from spi_probe+0x15c/0x1d4
 spi_probe from really_probe+0x270/0xb2c
 really_probe from __driver_probe_device+0x1dc/0x4e8
 __driver_probe_device from driver_probe_device+0x5c/0x140
 driver_probe_device from __driver_attach+0x220/0x540
 __driver_attach from bus_for_each_dev+0x13c/0x1a8
 bus_for_each_dev from bus_add_driver+0x2a0/0x6a4
 bus_add_driver from driver_register+0x27c/0x51c
 driver_register from do_one_initcall+0xf8/0x564
 do_one_initcall from do_init_module+0x2e4/0x82c
 do_init_module from load_module+0x59a0/0x70c4
 load_module from init_module_from_file+0x100/0x148
 init_module_from_file from sys_finit_module+0x2fc/0x924
 sys_finit_module from ret_fast_syscall+0x0/0x1c

The issue can easily be reproduced, for example by not wiring correctly
a wilc device through SPI (and so, make it unresponsive to early SPI
commands). It is due to a recent change decoupling wiphy allocation from
wiphy registration, however wilc_netdev_cleanup has not been updated
accordingly, letting it possibly call wiphy unregister on a wiphy which
has never been registered.

Fix this crash by moving wiphy_unregister/wiphy_free out of
wilc_netdev_cleanup, and by adjusting error paths in both drivers

Fixes: fbdf0c5248dc ("wifi: wilc1000: Register wiphy after reading out chipid")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 --
 drivers/net/wireless/microchip/wilc1000/sdio.c   | 9 +++++++--
 drivers/net/wireless/microchip/wilc1000/spi.c    | 9 +++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 7e84fc0fd91188b411863b9de647b6d182c6c187..af298021e05041ba4b16a94c8ee768407a208dfc 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -925,8 +925,6 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 
 	wilc_wlan_cfg_deinit(wilc);
 	wlan_deinit_locks(wilc);
-	wiphy_unregister(wilc->wiphy);
-	wiphy_free(wilc->wiphy);
 }
 EXPORT_SYMBOL_GPL(wilc_netdev_cleanup);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 5262c8846c13df28cf65ec8c5ad0ef9d6677c98b..3751e2ee1ca95918b589ba9be032984705fa822a 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -193,7 +193,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	ret = wilc_load_mac_from_nv(wilc);
 	if (ret) {
 		pr_err("Can not retrieve MAC address from chip\n");
-		goto dispose_irq;
+		goto unregister_wiphy;
 	}
 
 	wilc_sdio_deinit(wilc);
@@ -202,15 +202,18 @@ static int wilc_sdio_probe(struct sdio_func *func,
 				   NL80211_IFTYPE_STATION, false);
 	if (IS_ERR(vif)) {
 		ret = PTR_ERR(vif);
-		goto dispose_irq;
+		goto unregister_wiphy;
 	}
 
 	dev_info(&func->dev, "Driver Initializing success\n");
 	return 0;
 
+unregister_wiphy:
+	wiphy_unregister(wilc->wiphy);
 dispose_irq:
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
+	wiphy_free(wilc->wiphy);
 free:
 	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
@@ -222,7 +225,9 @@ static void wilc_sdio_remove(struct sdio_func *func)
 	struct wilc *wilc = sdio_get_drvdata(func);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
 
+	wiphy_unregister(wilc->wiphy);
 	wilc_netdev_cleanup(wilc);
+	wiphy_free(wilc->wiphy);
 	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index ce2a9cdd6aa7877ed4c2517f9549a00bdc8dc874..31219fd0cfb3fc6df071b3e9be5af17087ccf583 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -256,7 +256,7 @@ static int wilc_bus_probe(struct spi_device *spi)
 	ret = wilc_load_mac_from_nv(wilc);
 	if (ret) {
 		pr_err("Can not retrieve MAC address from chip\n");
-		goto power_down;
+		goto unregister_wiphy;
 	}
 
 	wilc_wlan_power(wilc, false);
@@ -264,14 +264,17 @@ static int wilc_bus_probe(struct spi_device *spi)
 				   NL80211_IFTYPE_STATION, false);
 	if (IS_ERR(vif)) {
 		ret = PTR_ERR(vif);
-		goto power_down;
+		goto unregister_wiphy;
 	}
 	return 0;
 
+unregister_wiphy:
+	wiphy_unregister(wilc->wiphy);
 power_down:
 	wilc_wlan_power(wilc, false);
 netdev_cleanup:
 	wilc_netdev_cleanup(wilc);
+	wiphy_free(wilc->wiphy);
 free:
 	kfree(spi_priv);
 	return ret;
@@ -282,7 +285,9 @@ static void wilc_bus_remove(struct spi_device *spi)
 	struct wilc *wilc = spi_get_drvdata(spi);
 	struct wilc_spi *spi_priv = wilc->bus_data;
 
+	wiphy_unregister(wilc->wiphy);
 	wilc_netdev_cleanup(wilc);
+	wiphy_free(wilc->wiphy);
 	kfree(spi_priv);
 }
 

---
base-commit: 96997ddfc7c249dbcb6e248986dc2d56ba29ec8b
change-id: 20241223-wilc_fix_probe_error_path-a64be3a9b39a

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


