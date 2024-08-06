Return-Path: <linux-wireless+bounces-11032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B8949652
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226D7B2B6E5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68D174EDB;
	Tue,  6 Aug 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hZL8qpNQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F983173332;
	Tue,  6 Aug 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963719; cv=none; b=CxqbCZwWOvfYqdEjKrvY6oZft7Fbj/1QgUPObKxYGjT9mAJv1cpzV9JZd+kzxHbD9qYkyeOw6qw2i12BkHtc8NgbqdFe6jVSL8vRcjFfQjxvs0y47cNwSFgDF4gPWnjYhpoG6mDgI24HgOys1K95zicliPu4ol34kokSnEdM9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963719; c=relaxed/simple;
	bh=ms8A76nkeaNRHdXkIVVVrgITpbhw592CLIfijFs1/HQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0LYCPRlBo3tA//88kvwwO8h0kVxnDZsA5GrbJfJR1Hm70EnuOOC/1T+E+bd7ovs7wjZDqZqnZ3eZaELql/Ul4IuwNuVIKUPsNxdAAjeqzzQUbGtrywRtkLpB8Mfl1t2TqOLwc25kiDOX/7aSWkhm7XLByCprtz4JTmJ/VrZTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hZL8qpNQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476H1ohu007487;
	Tue, 6 Aug 2024 12:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722963710;
	bh=q15TcAJYFaPQe8njBAMAvJ8ClRw15csz0DfHF3xGVLE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hZL8qpNQBCtyu0GCTJr7DabUF9Z2VnmnMxRnNT19fQE4p4jlxEJFZysy6iLpJI0tQ
	 5Dggfs9If4/o3O1xo/dKqCVRySB0JnHYZLbI5jnJCxqbRMyHkxt+u+J86Y6NtcFzHb
	 kmhstR0XiqmAVYIIva92ZKW4Ezy9+97NHsaArCfA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476H1ojK006364
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 12:01:50 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 12:01:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 12:01:49 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476H1nJx039220;
	Tue, 6 Aug 2024 12:01:49 -0500
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v3 16/17] wifi: cc33xx: Add Kconfig, Makefile
Date: Tue, 6 Aug 2024 20:00:17 +0300
Message-ID: <20240806170018.638585-17-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806170018.638585-1-michael.nemanov@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Integrate cc33xx into wireless/ti folder

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/Kconfig         |  1 +
 drivers/net/wireless/ti/Makefile        |  1 +
 drivers/net/wireless/ti/cc33xx/Kconfig  | 24 ++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/Makefile | 10 ++++++++++
 4 files changed, 36 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/Kconfig
 create mode 100644 drivers/net/wireless/ti/cc33xx/Makefile

diff --git a/drivers/net/wireless/ti/Kconfig b/drivers/net/wireless/ti/Kconfig
index 3fcd9e395f72..fa7214d6018c 100644
--- a/drivers/net/wireless/ti/Kconfig
+++ b/drivers/net/wireless/ti/Kconfig
@@ -14,6 +14,7 @@ if WLAN_VENDOR_TI
 source "drivers/net/wireless/ti/wl1251/Kconfig"
 source "drivers/net/wireless/ti/wl12xx/Kconfig"
 source "drivers/net/wireless/ti/wl18xx/Kconfig"
+source "drivers/net/wireless/ti/cc33xx/Kconfig"
 
 # keep last for automatic dependencies
 source "drivers/net/wireless/ti/wlcore/Kconfig"
diff --git a/drivers/net/wireless/ti/Makefile b/drivers/net/wireless/ti/Makefile
index 05ee016594f8..9e028a91ec30 100644
--- a/drivers/net/wireless/ti/Makefile
+++ b/drivers/net/wireless/ti/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_WLCORE)			+= wlcore/
 obj-$(CONFIG_WL12XX)			+= wl12xx/
 obj-$(CONFIG_WL1251)			+= wl1251/
 obj-$(CONFIG_WL18XX)			+= wl18xx/
+obj-$(CONFIG_CC33XX)			+= cc33xx/
\ No newline at end of file
diff --git a/drivers/net/wireless/ti/cc33xx/Kconfig b/drivers/net/wireless/ti/cc33xx/Kconfig
new file mode 100644
index 000000000000..0c3ff97dacc7
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config CC33XX
+	tristate "TI CC33XX support"
+	depends on MAC80211
+	select FW_LOADER
+	help
+	  This module contains the main code for TI CC33XX WLAN chips. It abstracts
+	  hardware-specific differences among different chipset families.
+	  Each chipset family needs to implement its own lower-level module
+	  that will depend on this module for the common code.
+
+	  If you choose to build a module, it will be called cc33xx. Say N if
+	  unsure.
+
+config CC33XX_SDIO
+	tristate "TI CC33XX SDIO support"
+	depends on CC33XX && MMC
+	help
+	  This module adds support for the SDIO interface of adapters using
+	  TI CC33XX WLAN chipsets.  Select this if your platform is using
+	  the SDIO bus.
+
+	  If you choose to build a module, it'll be called cc33xx_sdio.
+	  Say N if unsure.
diff --git a/drivers/net/wireless/ti/cc33xx/Makefile b/drivers/net/wireless/ti/cc33xx/Makefile
new file mode 100644
index 000000000000..6156f778edee
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+cc33xx-objs		= main.o cmd.o io.o event.o tx.o rx.o ps.o acx.o \
+					boot.o init.o scan.o
+
+cc33xx_sdio-objs	= sdio.o
+
+cc33xx-$(CONFIG_NL80211_TESTMODE)	+= testmode.o
+obj-$(CONFIG_CC33XX)				+= cc33xx.o
+obj-$(CONFIG_CC33XX_SDIO)			+= cc33xx_sdio.o
-- 
2.34.1


