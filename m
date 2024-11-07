Return-Path: <linux-wireless+bounces-15077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B579C0666
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DB2846F5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091FC216DE3;
	Thu,  7 Nov 2024 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mg9vj6xl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BAB215F7D;
	Thu,  7 Nov 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983990; cv=none; b=PxdZP5RGaEERW7gTWKQcPmWzGDn4TZCoLSJ5ZCvMXyedgqo6bFb9+awL5YCst/XyV/WsKaerkHfCn0h0Qz0msuxmTRY+nxw4CFE1XlE2P2iP+FE/9rn58j62uewEC+JbIcXEuwBuy77VVCW/JAl4BWHDqJenln/Y2xPy8mhP5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983990; c=relaxed/simple;
	bh=O4JIEnkWMQ605+o0syIyHSWT27O1VQEtWWa9lopfQjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8gvyfPUkDfYm4DWObWac81VcJIkj5fiRLhKkSxxefoUDlpGqG1B1G3ZMayucJ9NG3F26IK27OgyeSv/VgVpV6X0hpOU6elLnwMA/seViHH1ApkBd8Cfqrbd6MTAdcTj2ZIdF/afN75VGHS9CRm/tTtapVYtGPh8731vQKxetYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mg9vj6xl; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Cr2kS041981;
	Thu, 7 Nov 2024 06:53:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730983982;
	bh=3Bf1eq+WdZi+EdwuJ3Oe2U0adIIvW8vJSFGrZiaYIY4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Mg9vj6xlmDOvw+fcrSzarLS0aouuxdOSzzMtKPth3FVE6HDCH/MC+iGDpgQB40eHC
	 pcRZkjItif7Z0BR9QOv5wBOsY+cKenMCFExi1HW8ss0bfu4NC2uPLK/B1eURnIOV+P
	 DD7zvUyQrr7vXyaZX/9ChH/ZbITwjyLhzCKL0x40=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7Cr2f3116182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 06:53:02 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 06:53:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 06:53:02 -0600
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Cr1vX038593;
	Thu, 7 Nov 2024 06:53:01 -0600
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
Subject: [PATCH v5 17/17] wifi: cc33xx: Add Kconfig, Makefile
Date: Thu, 7 Nov 2024 14:52:09 +0200
Message-ID: <20241107125209.1736277-18-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107125209.1736277-1-michael.nemanov@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
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
index 05ee016594f8..4356f58b4b98 100644
--- a/drivers/net/wireless/ti/Makefile
+++ b/drivers/net/wireless/ti/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_WLCORE)			+= wlcore/
 obj-$(CONFIG_WL12XX)			+= wl12xx/
 obj-$(CONFIG_WL1251)			+= wl1251/
 obj-$(CONFIG_WL18XX)			+= wl18xx/
+obj-$(CONFIG_CC33XX)			+= cc33xx/
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


