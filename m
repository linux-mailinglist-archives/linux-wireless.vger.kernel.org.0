Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E522069B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfEPME2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 08:04:28 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:50376 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727136AbfEPME1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 08:04:27 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 2F6B430C046;
        Thu, 16 May 2019 05:04:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 2F6B430C046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558008265;
        bh=XT8xd0U/q5uUV+HYlgLAY0MUKMOZEvMkr6yIbD35y6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuPZiVp4pXnyUYIOWY2vZR90FIg+nQ0eWOu5lH5GBlKAt5IzSvihxkfu7VhHEkWLY
         ql7F2gf6LPQ1WaCqAL+mZyjKRhTayLCUqVWlYAiFAAFFyPRJPBVHBq5kRTUgOyDG2K
         CffZITTpDW36LvK9wAdDSAtFBjX/dkREGtUBlwus=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 3EB8660D66;
        Thu, 16 May 2019 05:04:25 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id A20ADB02E9E; Thu, 16 May 2019 14:04:23 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 6/7] brcmfmac: use separate Kconfig file for brcmfmac
Date:   Thu, 16 May 2019 14:04:10 +0200
Message-Id: <1558008251-13692-7-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The number of Kconfig items related to brcmfmac is considerable and
upcoming changes will add some more so it seems good idea to have
a separate Kconfig file for brcmfmac.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/Kconfig    | 50 +---------------------
 .../wireless/broadcom/brcm80211/brcmfmac/Kconfig   | 50 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 49 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig

diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 6acba67..580f666 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -17,55 +17,7 @@ config BRCMSMAC
 	  be available if you select BCMA_DRIVER_GPIO. If you choose to build a
 	  module, the driver will be called brcmsmac.ko.
 
-config BRCMFMAC
-	tristate "Broadcom FullMAC WLAN driver"
-	depends on CFG80211
-	select BRCMUTIL
-	---help---
-	  This module adds support for wireless adapters based on Broadcom
-	  FullMAC chipsets. It has to work with at least one of the bus
-	  interface support. If you choose to build a module, it'll be called
-	  brcmfmac.ko.
-
-config BRCMFMAC_PROTO_BCDC
-	bool
-
-config BRCMFMAC_PROTO_MSGBUF
-	bool
-
-config BRCMFMAC_SDIO
-	bool "SDIO bus interface support for FullMAC driver"
-	depends on (MMC = y || MMC = BRCMFMAC)
-	depends on BRCMFMAC
-	select BRCMFMAC_PROTO_BCDC
-	select FW_LOADER
-	default y
-	---help---
-	  This option enables the SDIO bus interface support for Broadcom
-	  IEEE802.11n embedded FullMAC WLAN driver. Say Y if you want to
-	  use the driver for a SDIO wireless card.
-
-config BRCMFMAC_USB
-	bool "USB bus interface support for FullMAC driver"
-	depends on (USB = y || USB = BRCMFMAC)
-	depends on BRCMFMAC
-	select BRCMFMAC_PROTO_BCDC
-	select FW_LOADER
-	---help---
-	  This option enables the USB bus interface support for Broadcom
-	  IEEE802.11n embedded FullMAC WLAN driver. Say Y if you want to
-	  use the driver for an USB wireless card.
-
-config BRCMFMAC_PCIE
-	bool "PCIE bus interface support for FullMAC driver"
-	depends on BRCMFMAC
-	depends on PCI
-	select BRCMFMAC_PROTO_MSGBUF
-	select FW_LOADER
-	---help---
-	  This option enables the PCIE bus interface support for Broadcom
-	  IEEE802.11ac embedded FullMAC WLAN driver. Say Y if you want to
-	  use the driver for an PCIE wireless card.
+source "drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig"
 
 config BRCM_TRACING
 	bool "Broadcom device tracing"
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
new file mode 100644
index 0000000..32794c1
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig
@@ -0,0 +1,50 @@
+config BRCMFMAC
+	tristate "Broadcom FullMAC WLAN driver"
+	depends on CFG80211
+	select BRCMUTIL
+	help
+	  This module adds support for wireless adapters based on Broadcom
+	  FullMAC chipsets. It has to work with at least one of the bus
+	  interface support. If you choose to build a module, it'll be called
+	  brcmfmac.ko.
+
+config BRCMFMAC_PROTO_BCDC
+	bool
+
+config BRCMFMAC_PROTO_MSGBUF
+	bool
+
+config BRCMFMAC_SDIO
+	bool "SDIO bus interface support for FullMAC driver"
+	depends on (MMC = y || MMC = BRCMFMAC)
+	depends on BRCMFMAC
+	select BRCMFMAC_PROTO_BCDC
+	select FW_LOADER
+	default y
+	help
+	  This option enables the SDIO bus interface support for Broadcom
+	  IEEE802.11n embedded FullMAC WLAN driver. Say Y if you want to
+	  use the driver for a SDIO wireless card.
+
+config BRCMFMAC_USB
+	bool "USB bus interface support for FullMAC driver"
+	depends on (USB = y || USB = BRCMFMAC)
+	depends on BRCMFMAC
+	select BRCMFMAC_PROTO_BCDC
+	select FW_LOADER
+	help
+	  This option enables the USB bus interface support for Broadcom
+	  IEEE802.11n embedded FullMAC WLAN driver. Say Y if you want to
+	  use the driver for an USB wireless card.
+
+config BRCMFMAC_PCIE
+	bool "PCIE bus interface support for FullMAC driver"
+	depends on BRCMFMAC
+	depends on PCI
+	select BRCMFMAC_PROTO_MSGBUF
+	select FW_LOADER
+	help
+	  This option enables the PCIE bus interface support for Broadcom
+	  IEEE802.11ac embedded FullMAC WLAN driver. Say Y if you want to
+	  use the driver for an PCIE wireless card.
+
-- 
1.9.1

