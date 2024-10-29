Return-Path: <linux-wireless+bounces-14671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8E9B50A8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB551C22BFA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E420ADFB;
	Tue, 29 Oct 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SLou/OZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305020A5EC;
	Tue, 29 Oct 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222695; cv=none; b=FnMIaBpzNCtEIMVVGeYKFQHqGQyuZOC52/Ak5noXrlafvgfCUPfhmgmISKnIdUPrBiL5Kl2hrzBoQ//dU6h6Z+uMxdRlAzeEpcUvlmceTJNXR6ZThjKPC9PXV1zRLwArR4WnDw+Wo2vazXqmO0zFBAacg2KeZywhugIFKrFF7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222695; c=relaxed/simple;
	bh=ms8A76nkeaNRHdXkIVVVrgITpbhw592CLIfijFs1/HQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QD1YwgTWQFmSfkmoxmvK0BzknXERzMQ128IhF5ErH80/Z3mERhoi51cWUzBDNM7xqa00Jp9dQl3ihCvLR3E7VUM8sP+haXb2Araoh+PnoxlIBsW5bx61vIoJbct4si0E5Hb9jcdjjyTokmAYH18ME353mUIoB09gE8xFCsrwjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SLou/OZD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49THOkE7051096;
	Tue, 29 Oct 2024 12:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730222686;
	bh=q15TcAJYFaPQe8njBAMAvJ8ClRw15csz0DfHF3xGVLE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SLou/OZDWrBSo0WHUrstUq3tjHzzVUmVDOfTuIWLXEoUPAbKK+cy0Wunu0q1Y3Xpq
	 I/Tj5URm2wzW+92fwHnLeKy9yFRpim8u+WhFVo4FBZ+MkqknEWtE0gbW4qw6qE3SpZ
	 +HJr2CZ1HTHObxRbYrL+S7wZIIuxPYvfEf0+aUYU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49THOkhw092366
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 12:24:46 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 12:24:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 12:24:46 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49THOj6K065912;
	Tue, 29 Oct 2024 12:24:45 -0500
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
Subject: [PATCH v4 17/17] wifi: cc33xx: Add Kconfig, Makefile
Date: Tue, 29 Oct 2024 19:23:54 +0200
Message-ID: <20241029172354.4027886-18-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029172354.4027886-1-michael.nemanov@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

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


