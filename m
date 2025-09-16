Return-Path: <linux-wireless+bounces-27412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA5B7E1C6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4416166A55
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F81B394F;
	Tue, 16 Sep 2025 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="gKYofvmA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4245C14
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061885; cv=none; b=SWUli7qjNC47Dm5iPm6m57/5Uk+gIRpie80F1gPMV4jrbdpttdBT/BK5TEVuMdPlsR4b4EQn/O5y+HO78/fRcOdJIrqMlnD8jFH8SE5ty56erE516FdfjgTfU/sTHve/fJWJtGX7enTduLwOSzVOh1pPOV+sEaI9sDRfXSavuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061885; c=relaxed/simple;
	bh=+XNJJ0Zw55vWTgstivj6OoAHmZol7VBAQAQaR1SMJyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LL6BXi1sg3TomIMYTCmn87Ty2CDHtPocWl4eq/VRnnYV7GRcUZYKz+6exyGfQleSuL0MeMLhk8NA8zkMoVd73KnNWPUEbaRdmYeV8dL3jdRsqesnwNfAT6QgubEjp9zlM4COKFNbigfHdUTqSDcZqlmnizFG5oeyRr1YZNpmbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=gKYofvmA; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061883; x=1789597883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+XNJJ0Zw55vWTgstivj6OoAHmZol7VBAQAQaR1SMJyg=;
  b=gKYofvmAVX2Fe7CWPMBIVJvWJ007ZMzdJPNyuGf211u66rR2hH787abA
   SWH7ErJ2hKiiRURrlq8WIuQ0EYUMQLDm64JHGpxk0nwh2BXHJYN8sLfr3
   1RjtnGVjTyE5EWtXw5vt48scd9aCcPiz3/w87rd97MOZY+BDxO9fwOYJk
   o=;
X-CSE-ConnectionGUID: 80hcL+RgTzuXkE6eC7vreQ==
X-CSE-MsgGUID: sQs59gQQQ1ykATxDNYmRDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093958"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093958"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:31:21 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:31:20 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:31:18 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 57/57] wifi: inffmac: add Kconfig, Makefile
Date: Wed, 17 Sep 2025 03:48:17 +0530
Message-ID: <20250916221821.4387-63-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

Introduce a new Kconfig and Makefile the inffmac driver sub-directory.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/Kconfig | 61 +++++++++++++++++
 .../net/wireless/infineon/inffmac/Makefile    | 65 +++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/Kconfig
 create mode 100644 drivers/net/wireless/infineon/inffmac/Makefile

diff --git a/drivers/net/wireless/infineon/inffmac/Kconfig b/drivers/net/wireless/infineon/inffmac/Kconfig
new file mode 100644
index 000000000000..40b70ab2decb
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/Kconfig
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: ISC
+
+config INFFMAC
+	tristate "Infineon FullMAC WLAN driver"
+	depends on CFG80211
+	help
+	  This module adds support for wireless adapters based on Infineon
+	  FullMAC chipsets. It has to work with at least one of the bus
+	  interface support. If you choose to build a module, it'll be called
+	  inffmac.ko.
+
+config INFFMAC_PROTO_BCDC
+	bool
+
+config INFFMAC_PROTO_MSGBUF
+	bool
+
+config INFFMAC_SDIO
+	bool "SDIO bus interface support for FullMAC driver"
+	depends on (MMC = y || MMC = INFFMAC)
+	depends on INFFMAC
+	select INFFMAC_PROTO_BCDC
+	select FW_LOADER
+	default y
+	help
+	  This option enables the SDIO bus interface support for Infineon
+	  IEEE802.11 embedded FullMAC WLAN driver. Say Y if you want to
+	  use the driver for a SDIO wireless card.
+
+config INFFMAC_PCIE
+	bool "PCIE bus interface support for FullMAC driver"
+	depends on INFFMAC
+	depends on PCI
+	select INFFMAC_PROTO_MSGBUF
+	select FW_LOADER
+	default y
+	help
+	  This option enables the PCIE bus interface support for Infineon
+	  IEEE802.11 embedded FullMAC WLAN driver. Say Y if you want to
+	  use the driver for an PCIE wireless card.
+
+config INFFMAC_PCIE_BARWIN_SZ
+	bool "Custom PCIE BAR window size support for FullMAC driver"
+	depends on INFFMAC
+	depends on INFFMAC_PCIE
+	depends on PCI
+	default n
+	help
+	  If you say Y here, the FMAC driver will use custom PCIE BAR
+	  window size. Say Y to allow developers to use custom PCIE
+	  BAR window size when HOST PCIE IP can support less then 4MB
+	  BAR window.
+
+config INFFMAC_BT_SHARED_SDIO
+	bool "FMAC shares SDIO bus to Bluetooth"
+	depends on INFFMAC
+	depends on INFFMAC_SDIO
+	default n
+	help
+	  Selecting this to enables sharing the SDIO bus interface between
+	  Infineon BT and WiFi host drivers.
diff --git a/drivers/net/wireless/infineon/inffmac/Makefile b/drivers/net/wireless/infineon/inffmac/Makefile
new file mode 100644
index 000000000000..15ca17bf6cc2
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/Makefile
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: ISC
+#
+# Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+# All rights reserved.
+#
+# Makefile fragment for Infineon 802.11 Networking Device Driver
+#
+
+ccflags-y += -I $(src)
+
+obj-$(CONFIG_INFFMAC) += inffmac.o
+inffmac-objs += \
+		ie.o \
+		scan.o \
+		interface.o \
+		security.o \
+		cfg80211.o \
+		chip.o \
+		fwil.o \
+		fweh.o \
+		p2p.o \
+		proto.o \
+		common.o \
+		core.o \
+		firmware.o \
+		feature.o \
+		btcoex.o \
+		vendor.o \
+		pno.o \
+		xtlv.o \
+		vendor_inf.o \
+		he.o \
+		eht.o \
+		twt.o \
+		offload.o \
+		pmsr.o \
+		ftm.o \
+		wlan_sense.o \
+		chip_5557x.o \
+		chip_5551x.o \
+		chip_43022.o \
+		chip_5591x.o \
+		chanspec.o \
+		utils.o
+inffmac-$(CONFIG_INFFMAC_PROTO_BCDC) += \
+		bcdc.o \
+		fwsignal.o
+inffmac-$(CONFIG_INFFMAC_PROTO_MSGBUF) += \
+		commonring.o \
+		flowring.o \
+		msgbuf.o
+inffmac-$(CONFIG_INFFMAC_SDIO) += \
+		sdio.o \
+		infsdh.o \
+		dfu.o
+inffmac-$(CONFIG_INFFMAC_PCIE) += \
+		pcie.o \
+		xdp.o
+inffmac-${CONFIG_INFFMAC_BT_SHARED_SDIO} += \
+		bt_shared_sdio.o
+inffmac-$(CONFIG_INF_DEBUG) += \
+		debug.o \
+		logger.o
+inffmac-$(CONFIG_INF_TRACING) += \
+		tracepoint.o
-- 
2.25.1


