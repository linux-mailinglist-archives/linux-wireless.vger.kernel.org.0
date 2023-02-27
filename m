Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1D6A418B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjB0MRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 07:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjB0MRn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 07:17:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98C01A491
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 04:17:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D0B60A26
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAD4C433D2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677500258;
        bh=mHYPljDvCCwYM7sH7AIJqGZhIVnFqgDGm9v/+nhMeAo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I72vIJXuCV3AD5MWROpre9FCEbm074WkwVOdx9aYVMTSEXqBJ4hV2k20BF38UvGXh
         FGFeA+yJI6j7UMXet7w9G9gvowbzWilshrd8vcR9fc/RYfBgNYd0sH4mGyIVp79FFW
         kmmekGG7RFcHFf4De9JA9JhDXcuuQOmPtMIcc0/IgJRu2793nLzhLhTVKyfbkp2nVg
         4xzvBeax+Se/wMcwQP7AWag+9iDDJq/HunZbnzwQ6Nl4bjUatKwFvaSdUXThzW9JAe
         gZEzEFwTfRseGBhCJGvebXdJsrMPHJKvpdd1wEOeum0wwp9F5C3HpBXNQxA0ANvnMn
         Xlmklzvo2faXw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy directory
Date:   Mon, 27 Feb 2023 14:17:32 +0200
Message-Id: <20230227121732.8967-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230227121732.8967-1-kvalo@kernel.org>
References: <20230227121732.8967-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To clean up drivers/net/wireless move the old drivers drivers left in the
directory to a new "legacy" directory. I did consider adding
CONFIG_WLAN_VENDOR_LEGACY like other vendors have but then dropped the idea as
these are really old drivers and hopefully we get to remove them soon.

There should be no changes in compilation or in Kconfig options, merely moving files.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/Kconfig                  | 55 +------------------
 drivers/net/wireless/Makefile                 |  7 +--
 drivers/net/wireless/legacy/Kconfig           | 55 +++++++++++++++++++
 drivers/net/wireless/legacy/Makefile          |  6 ++
 drivers/net/wireless/{ => legacy}/ray_cs.c    |  0
 drivers/net/wireless/{ => legacy}/ray_cs.h    |  0
 drivers/net/wireless/{ => legacy}/rayctl.h    |  0
 .../net/wireless/{ => legacy}/rndis_wlan.c    |  0
 drivers/net/wireless/{ => legacy}/wl3501.h    |  0
 drivers/net/wireless/{ => legacy}/wl3501_cs.c |  0
 10 files changed, 63 insertions(+), 60 deletions(-)
 create mode 100644 drivers/net/wireless/legacy/Kconfig
 create mode 100644 drivers/net/wireless/legacy/Makefile
 rename drivers/net/wireless/{ => legacy}/ray_cs.c (100%)
 rename drivers/net/wireless/{ => legacy}/ray_cs.h (100%)
 rename drivers/net/wireless/{ => legacy}/rayctl.h (100%)
 rename drivers/net/wireless/{ => legacy}/rndis_wlan.c (100%)
 rename drivers/net/wireless/{ => legacy}/wl3501.h (100%)
 rename drivers/net/wireless/{ => legacy}/wl3501_cs.c (100%)

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 42b40cc96b21..7555af5195ec 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -38,60 +38,7 @@ source "drivers/net/wireless/ti/Kconfig"
 source "drivers/net/wireless/zydas/Kconfig"
 source "drivers/net/wireless/quantenna/Kconfig"
 
-config PCMCIA_RAYCS
-	tristate "Aviator/Raytheon 2.4GHz wireless support"
-	depends on PCMCIA
-	select WIRELESS_EXT
-	select WEXT_SPY
-	select WEXT_PRIV
-	help
-	  Say Y here if you intend to attach an Aviator/Raytheon PCMCIA
-	  (PC-card) wireless Ethernet networking card to your computer.
-	  Please read the file
-	  <file:Documentation/networking/device_drivers/wifi/ray_cs.rst> for
-	  details.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called ray_cs.  If unsure, say N.
-
-config PCMCIA_WL3501
-	tristate "Planet WL3501 PCMCIA cards"
-	depends on CFG80211 && PCMCIA
-	select WIRELESS_EXT
-	select WEXT_SPY
-	help
-	  A driver for WL3501 PCMCIA 802.11 wireless cards made by Planet.
-	  It has basic support for Linux wireless extensions and initial
-	  micro support for ethtool.
-
-config USB_NET_RNDIS_WLAN
-	tristate "Wireless RNDIS USB support"
-	depends on USB
-	depends on CFG80211
-	select USB_NET_DRIVERS
-	select USB_USBNET
-	select USB_NET_CDCETHER
-	select USB_NET_RNDIS_HOST
-	help
-	  This is a driver for wireless RNDIS devices.
-	  These are USB based adapters found in devices such as:
-
-	  Buffalo WLI-U2-KG125S
-	  U.S. Robotics USR5421
-	  Belkin F5D7051
-	  Linksys WUSB54GSv2
-	  Linksys WUSB54GSC
-	  Asus WL169gE
-	  Eminent EM4045
-	  BT Voyager 1055
-	  Linksys WUSB54GSv1
-	  U.S. Robotics USR5420
-	  BUFFALO WLI-USB-G54
-
-	  All of these devices are based on Broadcom 4320 chip which is the
-	  only wireless RNDIS chip known to date.
-
-	  If you choose to build a module, it'll be called rndis_wlan.
+source "drivers/net/wireless/legacy/Kconfig"
 
 source "drivers/net/wireless/virtual/Kconfig"
 
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index 1b697cfe0a13..4d7374d567d1 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -23,10 +23,5 @@ obj-$(CONFIG_WLAN_VENDOR_ST) += st/
 obj-$(CONFIG_WLAN_VENDOR_TI) += ti/
 obj-$(CONFIG_WLAN_VENDOR_ZYDAS) += zydas/
 
-# 16-bit wireless PCMCIA client drivers
-obj-$(CONFIG_PCMCIA_RAYCS)	+= ray_cs.o
-obj-$(CONFIG_PCMCIA_WL3501)	+= wl3501_cs.o
-
-obj-$(CONFIG_USB_NET_RNDIS_WLAN)	+= rndis_wlan.o
-
+obj-$(CONFIG_WLAN) += legacy/
 obj-$(CONFIG_WLAN) += virtual/
diff --git a/drivers/net/wireless/legacy/Kconfig b/drivers/net/wireless/legacy/Kconfig
new file mode 100644
index 000000000000..3a5275941212
--- /dev/null
+++ b/drivers/net/wireless/legacy/Kconfig
@@ -0,0 +1,55 @@
+config PCMCIA_RAYCS
+	tristate "Aviator/Raytheon 2.4GHz wireless support"
+	depends on PCMCIA
+	select WIRELESS_EXT
+	select WEXT_SPY
+	select WEXT_PRIV
+	help
+	  Say Y here if you intend to attach an Aviator/Raytheon PCMCIA
+	  (PC-card) wireless Ethernet networking card to your computer.
+	  Please read the file
+	  <file:Documentation/networking/device_drivers/wifi/ray_cs.rst> for
+	  details.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ray_cs.  If unsure, say N.
+
+config PCMCIA_WL3501
+	tristate "Planet WL3501 PCMCIA cards"
+	depends on CFG80211 && PCMCIA
+	select WIRELESS_EXT
+	select WEXT_SPY
+	help
+	  A driver for WL3501 PCMCIA 802.11 wireless cards made by Planet.
+	  It has basic support for Linux wireless extensions and initial
+	  micro support for ethtool.
+
+config USB_NET_RNDIS_WLAN
+	tristate "Wireless RNDIS USB support"
+	depends on USB
+	depends on CFG80211
+	select USB_NET_DRIVERS
+	select USB_USBNET
+	select USB_NET_CDCETHER
+	select USB_NET_RNDIS_HOST
+	help
+	  This is a driver for wireless RNDIS devices.
+	  These are USB based adapters found in devices such as:
+
+	  Buffalo WLI-U2-KG125S
+	  U.S. Robotics USR5421
+	  Belkin F5D7051
+	  Linksys WUSB54GSv2
+	  Linksys WUSB54GSC
+	  Asus WL169gE
+	  Eminent EM4045
+	  BT Voyager 1055
+	  Linksys WUSB54GSv1
+	  U.S. Robotics USR5420
+	  BUFFALO WLI-USB-G54
+
+	  All of these devices are based on Broadcom 4320 chip which is the
+	  only wireless RNDIS chip known to date.
+
+	  If you choose to build a module, it'll be called rndis_wlan.
+
diff --git a/drivers/net/wireless/legacy/Makefile b/drivers/net/wireless/legacy/Makefile
new file mode 100644
index 000000000000..36878f080bfc
--- /dev/null
+++ b/drivers/net/wireless/legacy/Makefile
@@ -0,0 +1,6 @@
+# 16-bit wireless PCMCIA client drivers
+obj-$(CONFIG_PCMCIA_RAYCS)	+= ray_cs.o
+obj-$(CONFIG_PCMCIA_WL3501)	+= wl3501_cs.o
+
+obj-$(CONFIG_USB_NET_RNDIS_WLAN)	+= rndis_wlan.o
+
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
similarity index 100%
rename from drivers/net/wireless/ray_cs.c
rename to drivers/net/wireless/legacy/ray_cs.c
diff --git a/drivers/net/wireless/ray_cs.h b/drivers/net/wireless/legacy/ray_cs.h
similarity index 100%
rename from drivers/net/wireless/ray_cs.h
rename to drivers/net/wireless/legacy/ray_cs.h
diff --git a/drivers/net/wireless/rayctl.h b/drivers/net/wireless/legacy/rayctl.h
similarity index 100%
rename from drivers/net/wireless/rayctl.h
rename to drivers/net/wireless/legacy/rayctl.h
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/legacy/rndis_wlan.c
similarity index 100%
rename from drivers/net/wireless/rndis_wlan.c
rename to drivers/net/wireless/legacy/rndis_wlan.c
diff --git a/drivers/net/wireless/wl3501.h b/drivers/net/wireless/legacy/wl3501.h
similarity index 100%
rename from drivers/net/wireless/wl3501.h
rename to drivers/net/wireless/legacy/wl3501.h
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/legacy/wl3501_cs.c
similarity index 100%
rename from drivers/net/wireless/wl3501_cs.c
rename to drivers/net/wireless/legacy/wl3501_cs.c
-- 
2.30.2

