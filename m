Return-Path: <linux-wireless+bounces-2469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0C83BF25
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 11:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68794B2BCEB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B0225DF;
	Thu, 25 Jan 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0uegihh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD8225A9;
	Thu, 25 Jan 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179232; cv=none; b=EDjer/BBNXWdecuEMZKiEx0MgzQFv3Wsk/vrKJLWYqu+1Ukd7zyE2O03EE0qZRlz628Yf9voRguMCtg3AiZEyJAjcCx3TLOmXxqz/qWTo3QOYEkmB2uPLacx90OOHK9JHKKdURNufr4Ip2QBVDpnGVNfiF0eglbSKbGG5WNoGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179232; c=relaxed/simple;
	bh=Evb5vKdnyabGcDHvII+9hIFyzqQhOBIBmlyzj9R73wY=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=N8IEz4kcnh7FWoaWirsMDd76qdIk+CM5tHQ44BcgBGinbeKYRXezJV/HMXAqaSg3gI9b8kz/7VZhGG9m2LzH7ZIaRyOWFsOucOCgOTh/kb25KxYDh4THLV62gvgqnOKebc/bOypMYr9Y0c6rrBeVBENPHjLsNs/9KSmF8i5dfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0uegihh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CA6C433C7;
	Thu, 25 Jan 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179231;
	bh=Evb5vKdnyabGcDHvII+9hIFyzqQhOBIBmlyzj9R73wY=;
	h=From:Subject:To:Cc:Date:From;
	b=B0uegihhvO3O9vj+aKXIn4SNlCxgNfBPn4H2X/SfTe+bsaW7RGTGHHNCeqSeJNwL9
	 2WR2PO0PRmWrC+d4Zz2/oXp3Kju0s1eGW0ltRIMjwMMOtop9NThnr2k8vJxuRvz+Eq
	 zhMDvQ93oGVxCVb3psfN3AEBglL4gc5F/zcDucY0C7busI536LaCq5zm3ufkOSwF1Y
	 nmu43USDoMmO0fTmYKdXMExdaE0/hQVG6Bj2TPess9mdHV9obFveliaU4MtYICRoUf
	 lC5AilkdToeKymOjgF8J8haqrD0idapO2ECYKxodXgSXLAMaslaFT+843hP2gy7/Ca
	 seBhcmf6y4TOw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-01-25
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240125104030.B6CA6C433C7@smtp.kernel.org>
Date: Thu, 25 Jan 2024 10:40:30 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 3fbf61207c66ff7ac9b60ab76d4bfd239f97e973:

  Revert "mlx5 updates 2023-12-20" (2024-01-07 17:16:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-01-25

for you to fetch changes up to acf868ff60b1cd1f2e597f0b15aee2ff43f9fcd3:

  wifi: iwlegacy: Use kcalloc() instead of kzalloc() (2024-01-23 13:51:24 +0200)

----------------------------------------------------------------
wireless-next patches for v6.9

The first "new features" pull request for v6.9. We have only driver
changes this time and most of them are for Realtek drivers. Really
nice to see activity in Broadcom drivers again.

Major changes:

rtwl8xxxu

* RTL8188F: concurrent interface support

* Channel Switch Announcement (CSA) support in AP mode

brcmfmac

* per-vendor feature support

* per-vendor SAE password setup

rtlwifi

* speed up USB firmware initialisation

----------------------------------------------------------------
Ajay Singh (4):
      wifi: wilc1000: fix driver_handler when committing initial configuration
      wifi: wilc1000: do not realloc workqueue everytime an interface is added
      wifi: wilc1000: fix incorrect power down sequence
      wifi: wilc1000: fix multi-vif management when deleting a vif

Alexis Lothoré (2):
      wifi: wilc1000: fix declarations ordering
      wifi: wilc1000: fix RCU usage in connect path

Arend van Spriel (5):
      wifi: brcmfmac: export firmware interface functions
      wifi: brcmfmac: add per-vendor feature detection callback
      wifi: brcmfmac: move feature overrides before feature_disable
      wifi: brcmfmac: avoid invalid list operation when vendor attach fails
      wifi: brcmfmac: allow per-vendor event handling

Artem Chernyshev (1):
      wifi: brcmsmac: phy: Remove unreachable code

Bitterblue Smith (5):
      wifi: rtl8xxxu: Fix LED control code of RTL8192FU
      wifi: rtl8xxxu: Fix off by one initial RTS rate
      wifi: rtlwifi: rtl_usb: Use sync register writes
      wifi: rtlwifi: rtl8192de: Don't read register in _rtl92de_query_rxphystatus
      wifi: rtlwifi: Speed up firmware loading for USB

Cheng-Chieh Hsieh (1):
      wifi: rtw89: 8922a: update the register used in DIG and the DIG flow

Chih-Kang Chang (2):
      wifi: rtw89: fix HW scan timeout due to TSF sync issue
      wifi: rtw89: fix disabling concurrent mode TX hang issue

Chin-Yen Lee (1):
      wifi: rtw89: pci: use DBI function for 8852AE/8852BE/8851BE

Chung-Hsuan Hung (3):
      wifi: rtw89: phy: add parser to support RX gain dynamic setting flow
      wifi: rtw89: 8922a: set RX gain along with set_channel operation
      wifi: rtw89: 8922a: add BTG functions to assist BT coexistence to control TX/RX

Colin Ian King (1):
      wifi: rtw89: mac: Fix spelling mistakes "notfify" -> "notify"

Dmitry Antipov (3):
      wifi: rtlwifi: cleanup few rtlxxx_tx_fill_desc() routines
      wifi: rtw88: use kstrtoX_from_user() in debugfs handlers
      wifi: rt2x00: simplify rt2x00crypto_rx_insert_iv()

Erick Archer (1):
      wifi: iwlegacy: Use kcalloc() instead of kzalloc()

Hector Martin (2):
      wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
      wifi: brcmfmac: Demote vendor-specific attach/detach messages to info

Jinjie Ruan (1):
      wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()

Martin Kaistra (24):
      wifi: rtl8xxxu: remove assignment of priv->vif in rtl8xxxu_bss_info_changed()
      wifi: rtl8xxxu: prepare supporting two virtual interfaces
      wifi: rtl8xxxu: support setting linktype for both interfaces
      wifi: rtl8xxxu: 8188e: convert usage of priv->vif to priv->vifs[0]
      wifi: rtl8xxxu: support setting mac address register for both interfaces
      wifi: rtl8xxxu: extend wifi connected check to both interfaces
      wifi: rtl8xxxu: extend check for matching bssid to both interfaces
      wifi: rtl8xxxu: don't parse CFO, if both interfaces are connected in STA mode
      wifi: rtl8xxxu: support setting bssid register for multiple interfaces
      wifi: rtl8xxxu: support multiple interfaces in set_aifs()
      wifi: rtl8xxxu: support multiple interfaces in update_beacon_work_callback()
      wifi: rtl8xxxu: support multiple interfaces in configure_filter()
      wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
      wifi: rtl8xxxu: support multiple interfaces in {add,remove}_interface()
      wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
      wifi: rtl8xxxu: support multiple interface in start_ap()
      wifi: rtl8xxxu: add macids for STA mode
      wifi: rtl8xxxu: remove obsolete priv->vif
      wifi: rtl8xxxu: add hw crypto support for AP mode
      wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
      wifi: rtl8xxxu: declare concurrent mode support for 8188f
      wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
      wifi: rtl8xxxu: enable channel switch support
      wifi: rtl8xxxu: add missing number of sec cam entries for all variants

Ping-Ke Shih (35):
      wifi: rtw89: phy: move bb_gain_info used by WiFi 6 chips to union
      wifi: rtw89: phy: ignore special data from BB parameter file
      wifi: rtw89: 8922a: add NCTL pre-settings for WiFi 7 chips
      wifi: rtw89: phy: add BB wrapper of TX power for WiFi 7 chips
      wifi: rtw89: phy: set channel_info for WiFi 7 chips
      wifi: rtw88: 8822ce: refine power parameters for RFE type 5
      wifi: rtw89: add firmware H2C command of BA CAM V1
      wifi: rtw89: mac: add feature_init to initialize BA CAM V1
      wifi: rtw89: add chip_ops::h2c_ba_cam() to configure BA CAM
      wifi: rtw89: 8922a: update BA CAM number to 24
      wifi: rtw89: fw: use struct to fill BA CAM H2C commands
      wifi: rtw89: refine H2C command that pause transmitting by MAC ID
      wifi: rtw89: add new H2C command to pause/sleep transmitting by MAC ID
      wifi: rtw89: use struct to fill H2C command to download beacon frame
      wifi: rtw89: add H2C command to download beacon frame for WiFi 7 chips
      wifi: rtw89: add chip_ops::update_beacon to abstract update beacon operation
      wifi: rtw89: adjust init_he_cap() to add EHT cap into iftype_data
      wifi: rtw89: change supported bandwidths of chip_info to bit mask
      wifi: rtw89: add EHT capabilities for WiFi 7 chips
      wifi: rtw89: declare EXT NSS BW of VHT capability
      wifi: rtw89: fw: add H2C command to update security CAM v2
      wifi: rtw89: fw: fill CMAC table to associated station for WiFi 7 chips
      wifi: rtw89: fw: add chip_ops to update CMAC table to associated station
      wifi: rtw89: fw: update TX AMPDU parameter to CMAC table
      wifi: rtw89: fw: add H2C command to reset CMAC table for WiFi 7
      wifi: rtw89: fw: add H2C command to reset DMAC table for WiFi 7
      wifi: rtw89: fw: use struct to fill JOIN H2C command
      wifi: rtw89: fw: extend JOIN H2C command to support WiFi 7 chips
      wifi: rtl8xxxu: convert EN_DESC_ID of TX descriptor to le32 type
      wifi: rtl8xxxu: make instances of iface limit and combination to be static const
      wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
      wifi: rtw89: 8922a: add chip_ops::{enable,disable}_bb_rf
      wifi: rtw89: 8922a: add chip_ops related to BB init
      wifi: rtw89: 8922a: add register definitions of H2C, C2H, page, RRSR and EDCCA
      wifi: rtw89: 8922a: add TX power related ops

Po-Hao Huang (6):
      wifi: rtw89: refine add_chan H2C command to encode_bits
      wifi: rtw89: refine hardware scan C2H events
      wifi: rtw89: Set default CQM config if not present
      wifi: rtw89: disable RTS when broadcast/multicast
      wifi: rtw89: fix null pointer access when abort scan
      wifi: rtw89: add wait/completion for abort scan

Rahul Rameshbabu (4):
      wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
      wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
      wifi: b43: Stop correct queue in DMA worker when QoS is disabled
      wifi: b43: Disable QoS for bcm4331

Ruan Jinjie (1):
      wifi: mwifiex: Use helpers to check multicast addresses

Zheng Wang (1):
      wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zong-Zhe Yang (2):
      wifi: rtw89: 8852b: update TX power tables to R36
      wifi: rtw89: 8851b: update TX power tables to R37

 drivers/net/wireless/broadcom/b43/b43.h            |  16 +
 drivers/net/wireless/broadcom/b43/dma.c            |   4 +-
 drivers/net/wireless/broadcom/b43/main.c           |  16 +-
 drivers/net/wireless/broadcom/b43/pio.c            |   6 +-
 .../broadcom/brcm80211/brcmfmac/bca/core.c         |  30 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  64 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |   2 +
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  18 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  12 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |   2 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |  50 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |  11 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    | 154 +++-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |  60 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.c    | 116 +--
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    | 125 ++-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.c   |  13 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.h   |  48 +-
 .../broadcom/brcm80211/brcmfmac/wcc/core.c         |  31 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      |   3 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h      |   2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |  11 +-
 drivers/net/wireless/intel/iwlegacy/common.c       |   4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   3 -
 drivers/net/wireless/marvell/mwifiex/wmm.c         |   2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  12 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |  40 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |  12 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  35 +-
 drivers/net/wireless/microchip/wilc1000/wlan.h     |   6 +
 drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c  |   5 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |  20 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c |   3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c |   2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c |  33 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |   1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 409 +++++++--
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h  |  15 +
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |  36 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h       |   4 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  12 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.c   |   4 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |   3 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |   5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.c   |   6 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         | 164 ++--
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |  38 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |  44 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   4 +
 drivers/net/wireless/realtek/rtw88/reg.h           |   3 +
 drivers/net/wireless/realtek/rtw89/cam.c           |  61 ++
 drivers/net/wireless/realtek/rtw89/cam.h           | 109 +++
 drivers/net/wireless/realtek/rtw89/chan.c          |   2 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 344 +++++---
 drivers/net/wireless/realtek/rtw89/core.h          | 136 ++-
 drivers/net/wireless/realtek/rtw89/fw.c            | 944 ++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h            | 810 ++++++++++--------
 drivers/net/wireless/realtek/rtw89/mac.c           |  96 ++-
 drivers/net/wireless/realtek/rtw89/mac.h           |   5 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  18 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   4 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  69 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  46 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |  72 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c        | 312 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h           | 278 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  15 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |  72 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  15 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    | 142 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 705 ++++++++++++++-
 drivers/net/wireless/realtek/rtw89/wow.c           |   2 +-
 82 files changed, 4618 insertions(+), 1398 deletions(-)


