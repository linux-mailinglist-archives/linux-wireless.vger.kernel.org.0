Return-Path: <linux-wireless+bounces-119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA707FA880
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B0BB20F20
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 18:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A73BB3E;
	Mon, 27 Nov 2023 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJdsyrd+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C73717F;
	Mon, 27 Nov 2023 18:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B48DC433C8;
	Mon, 27 Nov 2023 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701108056;
	bh=mdiRTD5LAJNoXk0V204XHP3AYNLNJeeGfJwNb809q1I=;
	h=From:Subject:To:Cc:Date:From;
	b=UJdsyrd+mMXDB/IwNHw32uG1pqLMqAAkxhEwBHlR7qRWVXoxkBxz0FucsubtOmo0c
	 48D/Fd4lCxSSrQWjst5UTjbDIzx2zNgThdf9/7rThJk4zgtQrRMsROhfdkgAZD9mtx
	 gxcl3RpJDGPbn8DxG4O/IieJ9pRoYZvu6jleTecz4EvSfaFWkxualWO+O2mz+f52Vt
	 6jErA/W58OmNWAYpVc3ynkIUCLY/3dDZ3RFy/wOOmZNUccbvVdJ25Q0IjONkqwkLLw
	 PbQd+3mtyWLAqLJ3lCdHkqWet1ueHinLs5NDl26zV5f/b84cu3sqXqpHScMcvshsGR
	 lKits/Iw4xPdA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2023-11-27
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20231127180056.0B48DC433C8@smtp.kernel.org>
Date: Mon, 27 Nov 2023 18:00:55 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit cc54d2e2c58a40a82dfd39afa95d3d27f3d6509d:

  MAINTAINERS: Remove linuxwwan@intel.com mailing list (2023-10-26 22:20:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2023-11-27

for you to fetch changes up to 0cc3f50f42d262d6175ee2834aeb56e98934cfcc:

  wifi: nl80211: Documentation update for NL80211_CMD_PORT_AUTHORIZED event (2023-11-24 20:34:43 +0100)

----------------------------------------------------------------
wireless-next patches for v6.8

The first features pull request for v6.8. Not so big in number of
commits but we removed quite a few ancient drivers: libertas 16-bit
PCMCIA support, atmel, hostap, zd1201, orinoco, ray_cs, wl3501 and
rndis_wlan.

Major changes:

cfg80211/mac80211

* extend support for scanning while Multi-Link Operation (MLO) connected

----------------------------------------------------------------
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
      wifi: libertas: stop selecting wext

Bjorn Helgaas (1):
      wifi: rtlwifi: drop unused const_amdpci_aspm

Chih-Kang Chang (1):
      wifi: rtw88: fix RX filter in FIF_ALLMULTI flag

Dan Carpenter (1):
      wifi: plfxlc: check for allocation failure in plfxlc_usb_wreq_async()

Dmitry Antipov (10):
      wifi: rtlwifi: cleanup struct rtl_hal
      wifi: rtlwifi: cleanup struct rtl_phy
      wifi: rtlwifi: rtl92ee_dm_dynamic_primary_cca_check(): fix typo in function name
      wifi: rtw89: fix timeout calculation in rtw89_roc_end()
      wifi: wilc1000: simplify remain on channel support
      wifi: wilc1000: always release SDIO host in wilc_sdio_cmd53()
      wifi: wilc1000: cleanup struct wilc_conn_info
      wifi: wilc1000: simplify wilc_scan()
      wifi: rtw88: simplify __rtw_tx_work()
      wifi: rtlwifi: simplify rtl_action_proc() and rtl_tx_agg_start()

Gregory Greenman (1):
      MAINTAINERS: update iwlwifi maintainers

Ilan Peer (2):
      wifi: cfg80211: Extend support for scanning while MLO connected
      wifi: mac80211: Extend support for scanning while MLO connected

Jiapeng Chong (1):
      wifi: iwlegacy: Remove the unused variable len

Justin Stitt (3):
      wifi: brcm80211: replace deprecated strncpy with strscpy
      wifi: brcmsmac: replace deprecated strncpy with memcpy
      wifi: airo: replace deprecated strncpy with strscpy_pad

Liam Kearney (1):
      wifi: ieee80211: fix PV1 frame control field name

Ping-Ke Shih (24):
      wifi: rtw89: 8922ae: add 8922AE PCI entry and basic info
      wifi: rtw89: pci: define PCI ring address for WiFi 7 chips
      wifi: rtw89: pci: add new RX ring design to determine full RX ring efficiently
      wifi: rtw89: pci: generalize code of PCI control DMA IO for WiFi 7
      wifi: rtw89: set entry size of address CAM to H2C field by chip
      wifi: rtw89: consider RX info for WiFi 7 chips
      wifi: rtw89: extend PHY status parser to support WiFi 7 chips
      wifi: rtw89: pci: add PCI generation information to pci_info for each chip
      wifi: rtw89: pci: use gen_def pointer to configure mac_{pre,post}_init and clear PCI ring index
      wifi: rtw89: pci: implement PCI mac_pre_init for WiFi 7 chips
      wifi: rtw89: pci: add LTR v2 for WiFi 7 chip
      wifi: rtw89: pci: implement PCI mac_post_init for WiFi 7 chips
      wifi: rtw89: coex: use struct assignment to replace memcpy() to append TDMA content
      wifi: rtw89: pci: add pre_deinit to be called after probe complete
      wifi: rtw89: pci: generalize interrupt status bits of interrupt handlers
      wifi: rtw89: 8922ae: add v2 interrupt handlers for 8922AE
      wifi: rtw89: pci: correct interrupt mitigation register for 8852CE
      wifi: rtw89: pci: update interrupt mitigation register for 8922AE
      wifi: rtw89: 8922a: add 8922A basic chip info
      wifi: rtw89: mac: use mac_gen pointer to access about efuse
      wifi: rtw89: mac: add to access efuse for WiFi 7 chips
      wifi: rtw89: 8852c: read RX gain offset from efuse for 6GHz channels
      wifi: rtw89: 8922a: read efuse content via efuse map struct from logic map
      wifi: rtw89: 8922a: read efuse content from physical map

Shiji Yang (4):
      wifi: rt2x00: introduce DMA busy check watchdog for rt2800
      wifi: rt2x00: disable RTS threshold for rt2800 by default
      wifi: rt2x00: restart beacon queue when hardware reset
      wifi: rt2x00: correct wrong BBP register in RxDCOC calibration

Su Hui (1):
      wifi: mwifiex: mwifiex_process_sleep_confirm_resp(): remove unused priv variable

Thomas Weißschuh (1):
      rfkill: return ENOTTY on invalid ioctl

Vinayak Yadawad (1):
      wifi: nl80211: Documentation update for NL80211_CMD_PORT_AUTHORIZED event

Zong-Zhe Yang (6):
      wifi: rtw89: configure PPDU max user by chip
      wifi: rtw89: pci: reset BDRAM according to chip gen
      wifi: rtw89: pci: stop/start DMA for level 1 recovery according to chip gen
      wifi: rtw89: acpi: process 6 GHz band policy from DSM
      wifi: rtw89: regd: handle policy of 6 GHz according to BIOS
      wifi: rtw89: regd: update regulatory map to R65-R44

 .../networking/device_drivers/wifi/index.rst       |    1 -
 .../networking/device_drivers/wifi/ray_cs.rst      |  165 -
 MAINTAINERS                                        |   42 +-
 drivers/net/wireless/Kconfig                       |    3 -
 drivers/net/wireless/Makefile                      |    2 -
 drivers/net/wireless/atmel/Kconfig                 |   35 -
 drivers/net/wireless/atmel/Makefile                |    4 -
 drivers/net/wireless/atmel/atmel.c                 | 4452 -----------
 drivers/net/wireless/atmel/atmel.h                 |   31 -
 drivers/net/wireless/atmel/atmel_cs.c              |  292 -
 drivers/net/wireless/atmel/atmel_pci.c             |   65 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c |    6 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    3 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |    4 +-
 drivers/net/wireless/cisco/Kconfig                 |   59 -
 drivers/net/wireless/cisco/Makefile                |    3 -
 drivers/net/wireless/cisco/airo.c                  | 8288 --------------------
 drivers/net/wireless/cisco/airo.h                  |   10 -
 drivers/net/wireless/cisco/airo_cs.c               |  218 -
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    6 -
 drivers/net/wireless/intersil/Kconfig              |    2 -
 drivers/net/wireless/intersil/Makefile             |    2 -
 drivers/net/wireless/intersil/hostap/Kconfig       |   95 -
 drivers/net/wireless/intersil/hostap/Makefile      |    8 -
 drivers/net/wireless/intersil/hostap/hostap.h      |   98 -
 .../net/wireless/intersil/hostap/hostap_80211.h    |   97 -
 .../net/wireless/intersil/hostap/hostap_80211_rx.c | 1116 ---
 .../net/wireless/intersil/hostap/hostap_80211_tx.c |  554 --
 drivers/net/wireless/intersil/hostap/hostap_ap.c   | 3277 --------
 drivers/net/wireless/intersil/hostap/hostap_ap.h   |  264 -
 .../net/wireless/intersil/hostap/hostap_common.h   |  420 -
 .../net/wireless/intersil/hostap/hostap_config.h   |   49 -
 drivers/net/wireless/intersil/hostap/hostap_cs.c   |  710 --
 .../net/wireless/intersil/hostap/hostap_download.c |  810 --
 drivers/net/wireless/intersil/hostap/hostap_hw.c   | 3387 --------
 drivers/net/wireless/intersil/hostap/hostap_info.c |  509 --
 .../net/wireless/intersil/hostap/hostap_ioctl.c    | 3847 ---------
 drivers/net/wireless/intersil/hostap/hostap_main.c | 1123 ---
 drivers/net/wireless/intersil/hostap/hostap_pci.c  |  445 --
 drivers/net/wireless/intersil/hostap/hostap_plx.c  |  617 --
 drivers/net/wireless/intersil/hostap/hostap_proc.c |  411 -
 drivers/net/wireless/intersil/hostap/hostap_wlan.h | 1051 ---
 drivers/net/wireless/intersil/orinoco/Kconfig      |  143 -
 drivers/net/wireless/intersil/orinoco/Makefile     |   15 -
 drivers/net/wireless/intersil/orinoco/airport.c    |  268 -
 drivers/net/wireless/intersil/orinoco/cfg.c        |  291 -
 drivers/net/wireless/intersil/orinoco/cfg.h        |   15 -
 drivers/net/wireless/intersil/orinoco/fw.c         |  387 -
 drivers/net/wireless/intersil/orinoco/fw.h         |   21 -
 drivers/net/wireless/intersil/orinoco/hermes.c     |  778 --
 drivers/net/wireless/intersil/orinoco/hermes.h     |  534 --
 drivers/net/wireless/intersil/orinoco/hermes_dld.c |  477 --
 drivers/net/wireless/intersil/orinoco/hermes_dld.h |   52 -
 drivers/net/wireless/intersil/orinoco/hermes_rid.h |  165 -
 drivers/net/wireless/intersil/orinoco/hw.c         | 1362 ----
 drivers/net/wireless/intersil/orinoco/hw.h         |   60 -
 drivers/net/wireless/intersil/orinoco/main.c       | 2414 ------
 drivers/net/wireless/intersil/orinoco/main.h       |   50 -
 drivers/net/wireless/intersil/orinoco/mic.c        |   89 -
 drivers/net/wireless/intersil/orinoco/mic.h        |   23 -
 drivers/net/wireless/intersil/orinoco/orinoco.h    |  251 -
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c |  350 -
 .../net/wireless/intersil/orinoco/orinoco_nortel.c |  314 -
 .../net/wireless/intersil/orinoco/orinoco_pci.c    |  257 -
 .../net/wireless/intersil/orinoco/orinoco_pci.h    |   54 -
 .../net/wireless/intersil/orinoco/orinoco_plx.c    |  362 -
 .../net/wireless/intersil/orinoco/orinoco_tmd.c    |  237 -
 .../net/wireless/intersil/orinoco/orinoco_usb.c    | 1787 -----
 drivers/net/wireless/intersil/orinoco/scan.c       |  259 -
 drivers/net/wireless/intersil/orinoco/scan.h       |   21 -
 .../net/wireless/intersil/orinoco/spectrum_cs.c    |  328 -
 drivers/net/wireless/intersil/orinoco/wext.c       | 1428 ----
 drivers/net/wireless/intersil/orinoco/wext.h       |   13 -
 drivers/net/wireless/legacy/Kconfig                |   55 -
 drivers/net/wireless/legacy/Makefile               |    6 -
 drivers/net/wireless/legacy/ray_cs.c               | 2824 -------
 drivers/net/wireless/legacy/ray_cs.h               |   74 -
 drivers/net/wireless/legacy/rayctl.h               |  734 --
 drivers/net/wireless/legacy/rndis_wlan.c           | 3760 ---------
 drivers/net/wireless/legacy/wl3501.h               |  615 --
 drivers/net/wireless/legacy/wl3501_cs.c            | 2036 -----
 drivers/net/wireless/marvell/libertas/Kconfig      |    9 +-
 drivers/net/wireless/marvell/libertas/Makefile     |    1 -
 drivers/net/wireless/marvell/libertas/if_cs.c      |  957 ---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |    8 -
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   24 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   46 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |   42 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |    9 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |    5 +-
 drivers/net/wireless/ralink/rt2x00/rt2800.h        |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   83 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |    3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |   11 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |    8 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |    1 -
 drivers/net/wireless/realtek/rtlwifi/pci.h         |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    3 -
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.c |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |   11 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    3 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   17 -
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    3 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |   81 +-
 drivers/net/wireless/realtek/rtw89/acpi.h          |   32 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   16 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |    4 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   95 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   40 +-
 drivers/net/wireless/realtek/rtw89/debug.h         |    1 +
 drivers/net/wireless/realtek/rtw89/efuse.c         |   11 +-
 drivers/net/wireless/realtek/rtw89/efuse.h         |   17 +-
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |  420 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   16 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    4 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    4 +
 drivers/net/wireless/realtek/rtw89/pci.c           |  323 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |  515 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  509 ++
 drivers/net/wireless/realtek/rtw89/phy.h           |   16 +
 drivers/net/wireless/realtek/rtw89/reg.h           |  437 ++
 drivers/net/wireless/realtek/rtw89/regd.c          |  175 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   29 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |   20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  363 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.h      |   73 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   88 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    4 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    6 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |    4 +
 drivers/net/wireless/zydas/Kconfig                 |   19 -
 drivers/net/wireless/zydas/Makefile                |    2 -
 drivers/net/wireless/zydas/zd1201.c                | 1909 -----
 drivers/net/wireless/zydas/zd1201.h                |  144 -
 include/linux/ieee80211.h                          |    4 +-
 include/net/cfg80211.h                             |    3 +
 include/uapi/linux/nl80211.h                       |   22 +-
 net/mac80211/scan.c                                |   48 +-
 net/rfkill/core.c                                  |    4 +-
 net/wireless/nl80211.c                             |    1 +
 158 files changed, 3424 insertions(+), 58838 deletions(-)
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
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/pci_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922ae.c
 delete mode 100644 drivers/net/wireless/zydas/zd1201.c
 delete mode 100644 drivers/net/wireless/zydas/zd1201.h


