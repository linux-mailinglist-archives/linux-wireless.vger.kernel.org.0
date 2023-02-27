Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7668E6A418C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 13:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjB0MRp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 07:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjB0MRn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 07:17:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D51E9D2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 04:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12065B80C98
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD5C4339B
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677500257;
        bh=3FVFXaPV8BgtNhBA9ahDYZj4U3BsQvhjLLNUoLcE1PA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LnOKVtCgxSFRzXFj3qNu5QTRcmkjQoTXBN6Zq8C+svXUBSqPuSRGrKCu42ayQQ5sF
         LOxhlf/qjnlFADMmcQ1vP+eNHnc1WB1fZUGMhzlDKGQKcc4aa3+LoY3aqIkUPPhuiw
         SrgHKO9UCxvBUcpiHHL2VfBsHQw5EPFKYkRp49mJTuKhu1QIUXl1qr0NRu3cW+9E3Y
         Zcgh82Rpke4OUNYcFqQO03gn6TCxlC78ZPGib4SdKCZ0DyBW+2fSr3lenOCX6qTl1I
         GlubHmaV28vvE981k8yuNyV2LkF/b07FoqbqPEqNPoiwQUjd5vLO92FXnatDRIbkTD
         jJqihYGapQ0RA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: move mac80211_hwsim and virt_wifi to virtual directory
Date:   Mon, 27 Feb 2023 14:17:31 +0200
Message-Id: <20230227121732.8967-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230227121732.8967-1-kvalo@kernel.org>
References: <20230227121732.8967-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To clean up drivers/net/wireless move the virtual drivers to a new virtual
directory. I did consider adding CONFIG_WLAN_VENDOR_VIRTUAL like other vendors
have but then dropped the idea as we are not real drivers.

There should be no changes in compilation or in Kconfig options, merely moving
files. The order in menuconfig is slightly changed, the virtual drivers are now
last in the list.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/Kconfig                  | 20 +------------------
 drivers/net/wireless/Makefile                 |  4 +---
 drivers/net/wireless/virtual/Kconfig          | 20 +++++++++++++++++++
 drivers/net/wireless/virtual/Makefile         |  3 +++
 .../wireless/{ => virtual}/mac80211_hwsim.c   |  0
 .../wireless/{ => virtual}/mac80211_hwsim.h   |  0
 .../net/wireless/{ => virtual}/virt_wifi.c    |  0
 7 files changed, 25 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/wireless/virtual/Kconfig
 create mode 100644 drivers/net/wireless/virtual/Makefile
 rename drivers/net/wireless/{ => virtual}/mac80211_hwsim.c (100%)
 rename drivers/net/wireless/{ => virtual}/mac80211_hwsim.h (100%)
 rename drivers/net/wireless/{ => virtual}/virt_wifi.c (100%)

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index cb1c15012dd0..42b40cc96b21 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -64,19 +64,6 @@ config PCMCIA_WL3501
 	  It has basic support for Linux wireless extensions and initial
 	  micro support for ethtool.
 
-config MAC80211_HWSIM
-	tristate "Simulated radio testing tool for mac80211"
-	depends on MAC80211
-	help
-	  This driver is a developer testing tool that can be used to test
-	  IEEE 802.11 networking stack (mac80211) functionality. This is not
-	  needed for normal wireless LAN usage and is only for testing. See
-	  Documentation/networking/mac80211_hwsim for more information on how
-	  to use this tool.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called mac80211_hwsim.  If unsure, say N.
-
 config USB_NET_RNDIS_WLAN
 	tristate "Wireless RNDIS USB support"
 	depends on USB
@@ -106,11 +93,6 @@ config USB_NET_RNDIS_WLAN
 
 	  If you choose to build a module, it'll be called rndis_wlan.
 
-config VIRT_WIFI
-	tristate "Wifi wrapper for ethernet drivers"
-	depends on CFG80211
-	help
-	  This option adds support for ethernet connections to appear as if they
-	  are wifi connections through a special rtnetlink device.
+source "drivers/net/wireless/virtual/Kconfig"
 
 endif # WLAN
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index a61cf6c90343..1b697cfe0a13 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -29,6 +29,4 @@ obj-$(CONFIG_PCMCIA_WL3501)	+= wl3501_cs.o
 
 obj-$(CONFIG_USB_NET_RNDIS_WLAN)	+= rndis_wlan.o
 
-obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211_hwsim.o
-
-obj-$(CONFIG_VIRT_WIFI)	+= virt_wifi.o
+obj-$(CONFIG_WLAN) += virtual/
diff --git a/drivers/net/wireless/virtual/Kconfig b/drivers/net/wireless/virtual/Kconfig
new file mode 100644
index 000000000000..fb3b4b69f26b
--- /dev/null
+++ b/drivers/net/wireless/virtual/Kconfig
@@ -0,0 +1,20 @@
+config MAC80211_HWSIM
+	tristate "Simulated radio testing tool for mac80211"
+	depends on MAC80211
+	help
+	  This driver is a developer testing tool that can be used to test
+	  IEEE 802.11 networking stack (mac80211) functionality. This is not
+	  needed for normal wireless LAN usage and is only for testing. See
+	  Documentation/networking/mac80211_hwsim for more information on how
+	  to use this tool.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called mac80211_hwsim.  If unsure, say N.
+
+config VIRT_WIFI
+	tristate "Wifi wrapper for ethernet drivers"
+	depends on CFG80211
+	help
+	  This option adds support for ethernet connections to appear as if they
+	  are wifi connections through a special rtnetlink device.
+
diff --git a/drivers/net/wireless/virtual/Makefile b/drivers/net/wireless/virtual/Makefile
new file mode 100644
index 000000000000..5773cc6d643e
--- /dev/null
+++ b/drivers/net/wireless/virtual/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211_hwsim.o
+
+obj-$(CONFIG_VIRT_WIFI)	+= virt_wifi.o
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
similarity index 100%
rename from drivers/net/wireless/mac80211_hwsim.c
rename to drivers/net/wireless/virtual/mac80211_hwsim.c
diff --git a/drivers/net/wireless/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
similarity index 100%
rename from drivers/net/wireless/mac80211_hwsim.h
rename to drivers/net/wireless/virtual/mac80211_hwsim.h
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
similarity index 100%
rename from drivers/net/wireless/virt_wifi.c
rename to drivers/net/wireless/virtual/virt_wifi.c
-- 
2.30.2

