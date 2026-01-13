Return-Path: <linux-wireless+bounces-30789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E153D1B42A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5055E300C61D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67B30F549;
	Tue, 13 Jan 2026 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="FeuvHVIs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BC27EFE9
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336934; cv=none; b=ed3pMPU/DQKF8OsnerX7WQ+sb/RdYOF1JiXCT6rsx+dxHeQWjSopdOWtnhi2Bs7+7YlRyjj07feDkOnECSMW8k4IH2qEoYL05pDTmyiqfn8klLBA5XUH0Pp+yr6ZqfQyVKtaK+EH6oAvvtpvgw1Fsg92IODsidweo++m5ImPDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336934; c=relaxed/simple;
	bh=ebgOhVBwBwn7x85OpABAKhwIkDi++R7mZ0HLRbx5PVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLxENaGvEWnu03GF11l1a3O5f65V+lmk6KEsrRb5RuDSaC+wSucIHLWeyrrFxbVJDHiwiXYbBYpg1NlazlMTOF2I64FoGhGXkx8e2PS1pFwBc9vQVbCpAf5I3FOVKvL+WbOxvHb7V60PFG7MoH/YyLHWtckrfwzLSFXBxFDVnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=FeuvHVIs; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336932; x=1799872932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebgOhVBwBwn7x85OpABAKhwIkDi++R7mZ0HLRbx5PVw=;
  b=FeuvHVIs6lvdkP1dOEuGLgIqwJQTn7H9+rZvcirseZyHDr/b1C4LMcvS
   nkYpxNM237xfS3uCBpkJ/yTIC6GfHQ0xBPsO0RT1iRS87UI0xmKMdk9Hq
   VF8mhB6knPNokl8YW26agMPL12sx1fa8cQPZPRosWcevJSn/f60c/jFlr
   M=;
X-CSE-ConnectionGUID: yZD7pbJhQ96Vwws//QWjpQ==
X-CSE-MsgGUID: kO5wNnawTNaY+oMQXueheg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="113628570"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="113628570"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:42:10 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:42:10 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:42:08 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 34/34] wifi: inffmac: add Kconfig, Makefile
Date: Wed, 14 Jan 2026 02:03:47 +0530
Message-ID: <20260113203350.16734-35-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE810.infineon.com (172.23.29.36) To
 MUCSE827.infineon.com (172.23.29.20)

Introduce a new Kconfig and Makefile for the inffmac driver sub-directory.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/Kconfig | 44 ++++++++++++++++
 .../net/wireless/infineon/inffmac/Makefile    | 52 +++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/Kconfig
 create mode 100644 drivers/net/wireless/infineon/inffmac/Makefile

diff --git a/drivers/net/wireless/infineon/inffmac/Kconfig b/drivers/net/wireless/infineon/inffmac/Kconfig
new file mode 100644
index 000000000000..037899797520
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/Kconfig
@@ -0,0 +1,44 @@
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
+config INFFMAC_PROTO_ICDC
+        bool
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
+	select INFFMAC_PROTO_ICDC
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
diff --git a/drivers/net/wireless/infineon/inffmac/Makefile b/drivers/net/wireless/infineon/inffmac/Makefile
new file mode 100644
index 000000000000..9d231f9868ba
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/Makefile
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: ISC
+#
+# Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
+		dev_cmd.o \
+		dev_evt.o \
+		p2p.o \
+		bus_proto.o \
+		main.o \
+		net.o \
+		firmware.o \
+		feature.o \
+		vendor.o \
+		he.o \
+		twt.o \
+		pmsr.o \
+		chip_5557x.o \
+		chip_5551x.o \
+		chip_43022.o \
+		chip_5591x.o \
+		chan.o \
+		utils.o
+inffmac-$(CONFIG_INFFMAC_PROTO_ICDC) += \
+                icdc.o
+inffmac-$(CONFIG_INFFMAC_PROTO_BCDC) += \
+		bcdc.o \
+		fwsignal.o
+inffmac-$(CONFIG_INFFMAC_PROTO_MSGBUF) += \
+		commonring.o \
+		flowring.o \
+		msgbuf.o
+inffmac-$(CONFIG_INFFMAC_SDIO) += \
+		sdio.o \
+		dfu.o
+inffmac-$(CONFIG_INFFMAC_PCIE) += \
+		pcie.o
+inffmac-$(CONFIG_INF_DEBUG) += \
+		debug.o
-- 
2.25.1


