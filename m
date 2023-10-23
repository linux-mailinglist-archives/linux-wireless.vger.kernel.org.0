Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D547D37A6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjJWNUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJWNUT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 09:20:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3EDAF;
        Mon, 23 Oct 2023 06:20:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CA9C433C7;
        Mon, 23 Oct 2023 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698067215;
        bh=nTyauBHRPG08A+9hZJs2qahNZ8Jagercz5HEXYwcAWw=;
        h=From:To:Cc:Subject:Date:From;
        b=ghT2J3SDSUrw5fLAKRgXRXnqxX2UhQ1ba3fQviNpxfGz6s2R5wf4uIf8OzwTNTmSy
         +UuZfUTUKgAzenx/gBGOzUAH3wUlJQYthvAa6euqUDasxB2msCi3aiEGCmZoy2BdWG
         bqn3nbvGbuFNTgbb4O11TEpg7LqgtmIUNaWGrFi/XD310a/5VJUOEWHgFXwlC4O1Rx
         Hwp9E7vQRMetHRPUTEZduhT35zRG8eC+8enLWy2MX9WhdBaj6hIeKQ08j9EVoBWVez
         YQIZp+qeIjEmJ7n2HjGUxJH5lJQPG8gT7tFYwL/IFHopyffhiurTN4nsmGZPTgRudu
         6nvBU64vrCThg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geoff Levand <geoff@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pavel Machek <pavel@ucw.cz>, Stanislaw Gruszka <stf_xl@wp.pl>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: [PATCH 00/10] Remove obsolete and orphaned wifi drivers
Date:   Mon, 23 Oct 2023 15:19:42 +0200
Message-Id: <20231023131953.2876682-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

As discussed previously, a lot of the older wifi drivers are likely
entirely unused, Though we can't know for sure.

As suggested by both Greg and Jakub, let's remove the ones that look
are most likely to have no users left and also get in the way of the
wext cleanup. If anyone is still using any of these, we can revert the
driver removal individually.

I would suggest merging these for net-next after 6.7-rc1 is out, to give
them the maximum amount of time for users to speak up before a release
comes out.

This kills off all pcmcia wifi drivers, and all wext users in
drivers/net/wireless, but not the ps3-gelic-wireless driver in
drivers/net/ethernet, or the staging drivers.

In staging, rtl8192u was already removed in the meantime, while rtl8712
and rtl8192e are apparently still used.  I have not been able to find
out whether ks7010 is still in use.

	Arnd

Link: https://lore.kernel.org/lkml/20231011080955.1beeb010@kernel.org/


Arnd Bergmann (10):
  wifi: libertas: drop 16-bit PCMCIA support
  wifi: atmel: remove wext style at76c50x drivers
  wifi: remove orphaned cisco/aironet driver
  wifi: remove obsolete hostap driver
  wifi: remove orphaned zd1201 driver
  wifi: remove orphaned orinoco driver
  wifi: remove orphaned ray_cs driver
  wifi: remove orphaned wl3501 driver
  wifi: remove orphaned rndis_wlan driver
  [RFC] wifi: remove ipw2100/ipw2200 drivers

 .../networking/device_drivers/wifi/index.rst  |    20 -
 .../device_drivers/wifi/intel/ipw2100.rst     |   323 -
 .../device_drivers/wifi/intel/ipw2200.rst     |   526 -
 .../networking/device_drivers/wifi/ray_cs.rst |   165 -
 MAINTAINERS                                   |    49 -
 drivers/net/wireless/Kconfig                  |     3 -
 drivers/net/wireless/Makefile                 |     2 -
 drivers/net/wireless/atmel/Kconfig            |    35 -
 drivers/net/wireless/atmel/Makefile           |     4 -
 drivers/net/wireless/atmel/atmel.c            |  4452 ------
 drivers/net/wireless/atmel/atmel.h            |    31 -
 drivers/net/wireless/atmel/atmel_cs.c         |   292 -
 drivers/net/wireless/atmel/atmel_pci.c        |    65 -
 drivers/net/wireless/cisco/Kconfig            |    59 -
 drivers/net/wireless/cisco/Makefile           |     3 -
 drivers/net/wireless/cisco/airo.c             |  8288 -----------
 drivers/net/wireless/cisco/airo.h             |    10 -
 drivers/net/wireless/cisco/airo_cs.c          |   218 -
 drivers/net/wireless/intel/Kconfig            |     1 -
 drivers/net/wireless/intel/Makefile           |     3 -
 drivers/net/wireless/intel/ipw2x00/Kconfig    |   195 -
 drivers/net/wireless/intel/ipw2x00/Makefile   |    15 -
 drivers/net/wireless/intel/ipw2x00/ipw.h      |    20 -
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  |  8587 -----------
 drivers/net/wireless/intel/ipw2x00/ipw2100.h  |  1142 --
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  | 11965 ----------------
 drivers/net/wireless/intel/ipw2x00/ipw2200.h  |  1984 ---
 drivers/net/wireless/intel/ipw2x00/libipw.h   |  1001 --
 .../net/wireless/intel/ipw2x00/libipw_geo.c   |   179 -
 .../wireless/intel/ipw2x00/libipw_module.c    |   297 -
 .../net/wireless/intel/ipw2x00/libipw_rx.c    |  1737 ---
 .../net/wireless/intel/ipw2x00/libipw_tx.c    |   519 -
 .../net/wireless/intel/ipw2x00/libipw_wx.c    |   726 -
 drivers/net/wireless/intersil/Kconfig         |     2 -
 drivers/net/wireless/intersil/Makefile        |     2 -
 drivers/net/wireless/intersil/hostap/Kconfig  |    95 -
 drivers/net/wireless/intersil/hostap/Makefile |     8 -
 drivers/net/wireless/intersil/hostap/hostap.h |    98 -
 .../wireless/intersil/hostap/hostap_80211.h   |    97 -
 .../intersil/hostap/hostap_80211_rx.c         |  1116 --
 .../intersil/hostap/hostap_80211_tx.c         |   554 -
 .../net/wireless/intersil/hostap/hostap_ap.c  |  3277 -----
 .../net/wireless/intersil/hostap/hostap_ap.h  |   264 -
 .../wireless/intersil/hostap/hostap_common.h  |   420 -
 .../wireless/intersil/hostap/hostap_config.h  |    49 -
 .../net/wireless/intersil/hostap/hostap_cs.c  |   710 -
 .../intersil/hostap/hostap_download.c         |   810 --
 .../net/wireless/intersil/hostap/hostap_hw.c  |  3387 -----
 .../wireless/intersil/hostap/hostap_info.c    |   509 -
 .../wireless/intersil/hostap/hostap_ioctl.c   |  3847 -----
 .../wireless/intersil/hostap/hostap_main.c    |  1123 --
 .../net/wireless/intersil/hostap/hostap_pci.c |   445 -
 .../net/wireless/intersil/hostap/hostap_plx.c |   617 -
 .../wireless/intersil/hostap/hostap_proc.c    |   411 -
 .../wireless/intersil/hostap/hostap_wlan.h    |  1051 --
 drivers/net/wireless/intersil/orinoco/Kconfig |   143 -
 .../net/wireless/intersil/orinoco/Makefile    |    15 -
 .../net/wireless/intersil/orinoco/airport.c   |   268 -
 drivers/net/wireless/intersil/orinoco/cfg.c   |   291 -
 drivers/net/wireless/intersil/orinoco/cfg.h   |    15 -
 drivers/net/wireless/intersil/orinoco/fw.c    |   387 -
 drivers/net/wireless/intersil/orinoco/fw.h    |    21 -
 .../net/wireless/intersil/orinoco/hermes.c    |   778 -
 .../net/wireless/intersil/orinoco/hermes.h    |   534 -
 .../wireless/intersil/orinoco/hermes_dld.c    |   477 -
 .../wireless/intersil/orinoco/hermes_dld.h    |    52 -
 .../wireless/intersil/orinoco/hermes_rid.h    |   165 -
 drivers/net/wireless/intersil/orinoco/hw.c    |  1362 --
 drivers/net/wireless/intersil/orinoco/hw.h    |    60 -
 drivers/net/wireless/intersil/orinoco/main.c  |  2414 ----
 drivers/net/wireless/intersil/orinoco/main.h  |    50 -
 drivers/net/wireless/intersil/orinoco/mic.c   |    89 -
 drivers/net/wireless/intersil/orinoco/mic.h   |    23 -
 .../net/wireless/intersil/orinoco/orinoco.h   |   251 -
 .../wireless/intersil/orinoco/orinoco_cs.c    |   350 -
 .../intersil/orinoco/orinoco_nortel.c         |   314 -
 .../wireless/intersil/orinoco/orinoco_pci.c   |   257 -
 .../wireless/intersil/orinoco/orinoco_pci.h   |    54 -
 .../wireless/intersil/orinoco/orinoco_plx.c   |   362 -
 .../wireless/intersil/orinoco/orinoco_tmd.c   |   237 -
 .../wireless/intersil/orinoco/orinoco_usb.c   |  1787 ---
 drivers/net/wireless/intersil/orinoco/scan.c  |   259 -
 drivers/net/wireless/intersil/orinoco/scan.h  |    21 -
 .../wireless/intersil/orinoco/spectrum_cs.c   |   328 -
 drivers/net/wireless/intersil/orinoco/wext.c  |  1428 --
 drivers/net/wireless/intersil/orinoco/wext.h  |    13 -
 drivers/net/wireless/legacy/Kconfig           |    55 -
 drivers/net/wireless/legacy/Makefile          |     6 -
 drivers/net/wireless/legacy/ray_cs.c          |  2824 ----
 drivers/net/wireless/legacy/ray_cs.h          |    74 -
 drivers/net/wireless/legacy/rayctl.h          |   734 -
 drivers/net/wireless/legacy/rndis_wlan.c      |  3760 -----
 drivers/net/wireless/legacy/wl3501.h          |   615 -
 drivers/net/wireless/legacy/wl3501_cs.c       |  2036 ---
 drivers/net/wireless/marvell/libertas/Kconfig |     7 +-
 .../net/wireless/marvell/libertas/Makefile    |     1 -
 drivers/net/wireless/marvell/libertas/if_cs.c |   957 --
 drivers/net/wireless/zydas/Kconfig            |    19 -
 drivers/net/wireless/zydas/Makefile           |     2 -
 drivers/net/wireless/zydas/zd1201.c           |  1909 ---
 drivers/net/wireless/zydas/zd1201.h           |   144 -
 101 files changed, 1 insertion(+), 87755 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/wifi/index.rst
 delete mode 100644 Documentation/networking/device_drivers/wifi/intel/ipw2100.rst
 delete mode 100644 Documentation/networking/device_drivers/wifi/intel/ipw2200.rst
 delete mode 100644 Documentation/networking/device_drivers/wifi/ray_cs.rst
 delete mode 100644 drivers/net/wireless/atmel/atmel.c
 delete mode 100644 drivers/net/wireless/atmel/atmel.h
 delete mode 100644 drivers/net/wireless/atmel/atmel_cs.c
 delete mode 100644 drivers/net/wireless/atmel/atmel_pci.c
 delete mode 100644 drivers/net/wireless/cisco/Kconfig
 delete mode 100644 drivers/net/wireless/cisco/Makefile
 delete mode 100644 drivers/net/wireless/cisco/airo.c
 delete mode 100644 drivers/net/wireless/cisco/airo.h
 delete mode 100644 drivers/net/wireless/cisco/airo_cs.c
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/Kconfig
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/Makefile
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/ipw.h
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/ipw2100.c
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/ipw2100.h
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/ipw2200.c
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/ipw2200.h
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/libipw.h
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_geo.c
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_module.c
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_rx.c
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_tx.c
 delete mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_wx.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/Kconfig
 delete mode 100644 drivers/net/wireless/intersil/hostap/Makefile
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_80211.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_80211_rx.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_80211_tx.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_ap.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_ap.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_common.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_config.h
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_cs.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_download.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_hw.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_info.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_ioctl.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_main.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_pci.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_plx.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_proc.c
 delete mode 100644 drivers/net/wireless/intersil/hostap/hostap_wlan.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/Kconfig
 delete mode 100644 drivers/net/wireless/intersil/orinoco/Makefile
 delete mode 100644 drivers/net/wireless/intersil/orinoco/airport.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/cfg.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/cfg.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/fw.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/fw.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes_dld.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes_dld.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hermes_rid.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hw.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/hw.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/main.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/main.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/mic.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/mic.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_cs.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_nortel.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_pci.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_pci.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_plx.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_tmd.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/orinoco_usb.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/scan.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/scan.h
 delete mode 100644 drivers/net/wireless/intersil/orinoco/spectrum_cs.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/wext.c
 delete mode 100644 drivers/net/wireless/intersil/orinoco/wext.h
 delete mode 100644 drivers/net/wireless/legacy/Kconfig
 delete mode 100644 drivers/net/wireless/legacy/Makefile
 delete mode 100644 drivers/net/wireless/legacy/ray_cs.c
 delete mode 100644 drivers/net/wireless/legacy/ray_cs.h
 delete mode 100644 drivers/net/wireless/legacy/rayctl.h
 delete mode 100644 drivers/net/wireless/legacy/rndis_wlan.c
 delete mode 100644 drivers/net/wireless/legacy/wl3501.h
 delete mode 100644 drivers/net/wireless/legacy/wl3501_cs.c
 delete mode 100644 drivers/net/wireless/marvell/libertas/if_cs.c
 delete mode 100644 drivers/net/wireless/zydas/zd1201.c
 delete mode 100644 drivers/net/wireless/zydas/zd1201.h

-- 
2.39.2

Cc: "David S . Miller" <davem@davemloft.net>,
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geoff Levand <geoff@infradead.org>,
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
Cc: Jakub Kicinski <kuba@kernel.org>,
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
Cc: Pavel Machek <pavel@ucw.cz>,
Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-staging@lists.linux.dev>,
Cc: <linux-wireless@vger.kernel.org>,
