Return-Path: <linux-wireless+bounces-7567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CC8C37F8
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9B2B20FCD
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856957323;
	Sun, 12 May 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PMmBdroF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359F54FB5
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538844; cv=none; b=SCKsGDN7yqHekL/vBhTYrkSH5BS9zZbUdBf/6Hu2N7CGuKxOrm8wHLoB31IJkNHTLH/nWHkAHrSHr8sRvWkDBUBvhVecscgiFfxchJECpZilc44t0gwMLcCskoycDHJOxWMru+b4AtI1H15KbwWpXfaoeivU3zdyviOZzJfvaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538844; c=relaxed/simple;
	bh=wkBWpFDikxFMwD8eegS5ivYjmB4g7lcLoia+jdI0LpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAMsQxPM/VJuEoXQG31/HAezrf1svlzdj/kINcq4Wgba/CzWs3BeeNWyvwmwjswwdLjxM2Rba93jH4/b4zC2GpXKqQistoN4QT5SvIUhY/B08EpTNbrZzqgSl2jEcALkjhVdfg8sxHK7phFPxl9S63/4SSPie0TIM94r0r2ZvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PMmBdroF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXwSC006181;
	Sun, 12 May 2024 13:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715538839;
	bh=8WCTjPgWrJGAPbWLFUIE5sj5ZRa4/KGXfJDdzIU8MZE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PMmBdroFhGXv8YO0CCuwoFw+Oi2HVcBWKAILqpO2xkPQVmy3kI6md3B3CRdbrbbEb
	 Z6Q6Q7Ao89Cos8VNmYqXINy9wTfM+3B7NjJ2QmdUQuAQWPy73Xxc4ET1RA6EyxAyV2
	 RK3ehc+42Tf+xT7HFPlUNe/rYUc9bFqWxutmRsKE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CIXwcY096129
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 13:33:58 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 13:33:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 13:33:58 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXv0s074950;
	Sun, 12 May 2024 13:33:58 -0500
From: <michael.nemanov@ti.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <sabeeh-khan@ti.com>, Michael Nemanov <Michael.Nemanov@ti.com>,
        Michael
 Nemanov <michael.nemanov@ti.com>
Subject: [RFC PATCH 17/17] Add Kconfig, Makefile and integrate into wireless/ti folder
Date: Sun, 12 May 2024 21:32:47 +0300
Message-ID: <20240512183247.2190242-18-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512183247.2190242-1-michael.nemanov@ti.com>
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

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
index 000000000000..7066ab22471a
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+cc33xx-objs		= main.o cmd.o io.o event.o tx.o rx.o ps.o acx.o \
+			  boot.o init.o debugfs.o scan.o
+
+cc33xx_sdio-objs	= sdio.o
+
+cc33xx-$(CONFIG_NL80211_TESTMODE)	+= testmode.o
+obj-$(CONFIG_CC33XX)				+= cc33xx.o
+obj-$(CONFIG_CC33XX_SDIO)			+= cc33xx_sdio.o
-- 
2.25.1


