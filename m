Return-Path: <linux-wireless+bounces-17482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E751DA1048D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0166B1699EB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF60152166;
	Tue, 14 Jan 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fbuAgKuF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C822961D;
	Tue, 14 Jan 2025 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851570; cv=none; b=MbT0v/SwZlDzjKeWtlmmeZICh+LnXiOtnoDJXIzrpHFEVQsNpyIM3CixlGe12njuLTAied4kkVYXvGsA+1H7Rp5xfhAWcXHZlkwKE33NchIj2I+cJlSX+4/4I2J39T16deboRWxOTD4yeX6TqG9vVhm+PUCL2OKEvfcDgcvRk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851570; c=relaxed/simple;
	bh=3vc5HPbqwm/mzUh9umjfNBN1lT97gVbeyiLPaxg7uGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TjGRqpo4ZVlzZ582zdrD1fmQ5jJwqD+LGb/uX5ZigvV+SE5oluXdnRaMqE2Zmzv0xLr+CwpAP31Bpdet/PCdc8UtQhk1g7o/7EScRRAn2NZeVRjQAND8ds4WcIwyWxmn0XKwpTL0MVenrGmcAkWxUpAdpnskB3IYVCQ3kZhlYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbuAgKuF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3C91E0004;
	Tue, 14 Jan 2025 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736851560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CjuR1GGe+NgAw5BykabP06mZ0uDN93UQ5m1kcEeF4NY=;
	b=fbuAgKuFP018j1YPPWzDo2r6yVvqzcxsYHLLoIVjvsebqLnCmqVKRvkuWMP5vQ9XtCdywm
	aOqPkT0KgXdQDSNbwa6Ujcwc/cLcdkqMtGtRnH++z7lBEvj25OmSiYiFbC2cbNnLcvffoG
	TunnZ6BZo5u367gPNeI7zWXKjQlwdxLe1sCYwjfu1oITMGis3i2LVEB9yOuqcYuCusTtB0
	XCzrxWLMHuXJg64dLPhhq965YL2ZKclnfEuK8Q1VZrR7HSABZfSoJRtHOgOX6EeBiF9o2J
	9k2i/HG284SOFWQ2laBjRsm86I+H3uMIzWO5O5QKdRSTHGJqVTTwBD6CavbYmQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 14 Jan 2025 11:45:34 +0100
Subject: [PATCH] wifi: wilc1000: unregister wiphy only after netdev
 registration
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAE1AhmcC/x3MTQqAIBBA4avErBNG+6OuEhGmUw1UikIF0d2Tl
 t/ivQciBaYIXfZAoJMjuyNB5hmYVR8LCbbJoFBVKGUpLt6MRMRxd9YHN5FoK9sWOCldNwSp84F
 mvv9nP7zvB2Z0KTxjAAAA
X-Change-ID: 20250114-wilc1000_modprobe-95d930b2a67e
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Marek Vasut <marex@denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

wiphy_unregister/wiphy_free has been recently decoupled from
wilc_netdev_cleanup to fix a faulty error path in sdio/spi probe
functions. However this change introduced a new failure when simply
loading then unloading the driver:
  $ modprobe wilc1000-sdio; modprobe -r wilc1000-sdio
  WARNING: CPU: 0 PID: 115 at net/wireless/core.c:1145 wiphy_unregister+0x904/0xc40 [cfg80211]
  Modules linked in: wilc1000_sdio(-) wilc1000 cfg80211 bluetooth ecdh_generic ecc
  CPU: 0 UID: 0 PID: 115 Comm: modprobe Not tainted 6.13.0-rc6+ #45
  Hardware name: Atmel SAMA5
  Call trace:
   unwind_backtrace from show_stack+0x18/0x1c
   show_stack from dump_stack_lvl+0x44/0x70
   dump_stack_lvl from __warn+0x118/0x27c
   __warn from warn_slowpath_fmt+0xcc/0x140
   warn_slowpath_fmt from wiphy_unregister+0x904/0xc40 [cfg80211]
   wiphy_unregister [cfg80211] from wilc_sdio_remove+0xb0/0x15c [wilc1000_sdio]
   wilc_sdio_remove [wilc1000_sdio] from sdio_bus_remove+0x104/0x3f0
   sdio_bus_remove from device_release_driver_internal+0x424/0x5dc
   device_release_driver_internal from driver_detach+0x120/0x224
   driver_detach from bus_remove_driver+0x17c/0x314
   bus_remove_driver from sys_delete_module+0x310/0x46c
   sys_delete_module from ret_fast_syscall+0x0/0x1c
  Exception stack(0xd0acbfa8 to 0xd0acbff0)
  bfa0:                   0044b210 0044b210 0044b24c 00000800 00000000 00000000
  bfc0: 0044b210 0044b210 00000000 00000081 00000000 0044b210 00000000 00000000
  bfe0: 00448e24 b6af99c4 0043ea0d aea2e12c
  irq event stamp: 0
  hardirqs last  enabled at (0): [<00000000>] 0x0
  hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
  softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
  softirqs last disabled at (0): [<00000000>] 0x0

The warning is triggered by the fact that there is still a
wireless_device linked to the wiphy we are unregistering, due to
wiphy_unregister now being called after net device unregister (performed
in wilc_netdev_cleanup). Fix this warning by moving wiphy_unregister
after wilc_netdev_cleanup is nominal paths (ie: driver removal).
wilc_netdev_cleanup ordering is left untouched in error paths in probe
function because net device is not registered in those paths (so the
warning can not trigger), yet the wiphy can still be registered, and we
still some cleanup steps from wilc_netdev_cleanup.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
I clearly overlooked this simple scenario/misunderstood expected
unregistration order when fixing some spi probe error path, my bad (see
commit 89a7616e1715 ("ARM: dts: at91-sama5d27_wlsom1: update bluetooth
chip description") in wireless-next)

@Kalle: 89a7616e1715 (the faulty commit) is only in wireless-next for
now IIUC, so I did not provide any Fixes: tag to prevent any faulty SHA1
if those commits end up being picked in stable tree (however, the faulty
commit _has_ a Fixes tag). Please let me know if we should proceed
differently.
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 2 +-
 drivers/net/wireless/microchip/wilc1000/spi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 3751e2ee1ca95918b589ba9be032984705fa822a..af970f9991110807ebd880681ad0e8aaf8a0b9bc 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -225,8 +225,8 @@ static void wilc_sdio_remove(struct sdio_func *func)
 	struct wilc *wilc = sdio_get_drvdata(func);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
 
-	wiphy_unregister(wilc->wiphy);
 	wilc_netdev_cleanup(wilc);
+	wiphy_unregister(wilc->wiphy);
 	wiphy_free(wilc->wiphy);
 	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 31219fd0cfb3fc6df071b3e9be5af17087ccf583..5bcabb7decea0fc8d0065a240f4acefabca3346a 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -285,8 +285,8 @@ static void wilc_bus_remove(struct spi_device *spi)
 	struct wilc *wilc = spi_get_drvdata(spi);
 	struct wilc_spi *spi_priv = wilc->bus_data;
 
-	wiphy_unregister(wilc->wiphy);
 	wilc_netdev_cleanup(wilc);
+	wiphy_unregister(wilc->wiphy);
 	wiphy_free(wilc->wiphy);
 	kfree(spi_priv);
 }

---
base-commit: 062792ae63cf5fd141d7f6f12cb0108e9ba6f88e
change-id: 20250114-wilc1000_modprobe-95d930b2a67e

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


