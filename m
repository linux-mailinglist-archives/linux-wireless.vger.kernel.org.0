Return-Path: <linux-wireless+bounces-8732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5429017B1
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E291C20B20
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315727C6D4;
	Sun,  9 Jun 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JuV+GcOk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE177119;
	Sun,  9 Jun 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957383; cv=none; b=HQos14JwIQTANUJvah9Wt4HRuW3BrTNOnWWA3YJSVZxGsIYGgt77PknZDu4ILCw9VKnsl/pbVgv60/qh1jrORxdjWr7IXwUHtzBz0Wat45hJNSMy89/1pTExQyJkRp4w8Rmaos8UUMceGlFkeKEB1h3fnAYO4m1UbSjiEUrxeio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957383; c=relaxed/simple;
	bh=LUbU/n1NgxZ9o/jU5VEawfYCrXStZSvnsTlPEXFfBns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ky1EPtBuEHSOUK3k8KuNJrGI8zmUj3+b+QZjC/jvSiGr6LQNmT3t9x1WsDUNUWKXMzUZ3rwDdDV2uoR/rg4jDz2GfGcgYI9otJ/eCRptyiWkqDp+I6dWELwueQodjAJczoVZjw4yvZ2paTlkr+o9u7Ftx2Se2X55X8ydCU4+5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JuV+GcOk; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMsKs075169;
	Sun, 9 Jun 2024 13:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957374;
	bh=InTJKlyp+itq7Bv0Xtt9P8tR0I50sqpUNLEMeR7dXDU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JuV+GcOkQluj7XZH9rYVK9ZfG1a/q0Vl8sHO2sxNWAcixCSdyQ1DWhFglqEYgeyeI
	 tf1/J8nhwI3l3w56wSVF4VzSZxVuZZLCRYRUxPY1e7u4meMDOggUSCVwwpUyC1B0Ny
	 G57QBLl0rCmamBE29zrzQnEWu4jE+k2AwiaZuDhQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMsCm058855
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:54 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMr0t034788;
	Sun, 9 Jun 2024 13:22:53 -0500
From: <michael.nemanov@ti.com>
To: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>
Subject: [PATCH v2 16/17] wifi: cc33xx: Add Kconfig, Makefile Integrate cc33xx into wireless/ti folder
Date: Sun, 9 Jun 2024 21:21:01 +0300
Message-ID: <20240609182102.2950457-17-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182102.2950457-1-michael.nemanov@ti.com>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
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
2.25.1


