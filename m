Return-Path: <linux-wireless+bounces-29378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4106C8DCF5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 11:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 325A3342E5D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003C8329C5E;
	Thu, 27 Nov 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Wsx7Lx5f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3A2D73A8;
	Thu, 27 Nov 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239902; cv=none; b=Cc8XdIQEe+qTAB2wDkwP3VRgDQJicGFDDGK9rx7a0IJ0qTxXfe7/T8kDGZlhIyQp7WBVbZxv9vw0HCIvQThnFM8QJEynZQZ/OUouZJJf7VmlPfkADv0eLih09psUB/XUQJjLnaXs/CaWNsKkDoOerndTN2DNN+QqeonWAo1UskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239902; c=relaxed/simple;
	bh=5P3lGtNqHf0fl5GMHJh6sdfcFCpMnMCHT3XB1/RnLhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7c5bxlylleIH3iQ4oi5RmeuKqbJHMfWKGmTqu8KT0bWpPrtCB5ZFmPrmVIfJonqAquyDWqUQtKYse7Ig1w4JDTg4Pr3gKXY59uA1rqI5+K6b+wi6QIc94zoSqztn25+zpneF408zHvLu/G0xwgVDiGDkkTk4tQKqzkLKRBdviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Wsx7Lx5f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=jQRc2BGROepN1miHWIBJ6KIO68dxHMfwKVoc2bmUHh0=; t=1764239900; x=1765449500; 
	b=Wsx7Lx5fIJGvnQTEZInohzYAZnAf535mU4xFjH2+CiIPZEbxj+BYb3Aj5373VR/0s8t5y7wC+kt
	v52jQp9A2NYLlQOLTIP4luJ9Yzan9V1WnyD/6x6SfFiYZUrrMPV/vlA1TRu5TawgPDOvH3T/GtPQg
	AI5rNmz3954+R2qGnl/f43hq3aqkjlttHAxZjvB6pOmNZtUGJymbolNKqrvBmGZROLRXke8v4m/Jj
	rIXIuxobLLkwofHxwuycj5OUmaNat/sI9fvleaBO0a9zwhNCYEDUDgOp8p1L97ePd5iDeLFxgf9dE
	5NBrggFPoBVnvZQHTVwUimi2b6hH1ntGhVzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vOZO7-0000000HYLY-1t48;
	Thu, 27 Nov 2025 11:38:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-11-27
Date: Thu, 27 Nov 2025 11:37:09 +0100
Message-ID: <20251127103806.17776-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So Qualcomm said they're still validating their architecture
changes and prefer pushing that to a later release, so for
the last changes we have it's mostly Mediatek and Realtek
drivers.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit c99ebb6132595b4b288a413981197eb076547c5a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-13 12:35:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-11-27

for you to fetch changes up to f9e788c5fd3a23edecd808ebb354e2cb1aef87c3:

  wifi: mac80211: allow sharing identical chanctx for S1G interfaces (2025-11-26 10:34:51 +0100)

----------------------------------------------------------------
Apart from the usual small things just driver updates:
 - mt76:
   - WED support for >32-bit DMA
   - airoha NPU support
   - regdomain improvements
   - continued WiFi7/MLO work
 - rtw89
   - support USB devices RTL8852AU and RTL8852CU
   - initial work for RTL8922DE
   - improved injection support
 - rtl8xxxu: 40 MHz connection fixes/support
 - brcmfmac: Acer A1 840 tablet quirk

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()

Alok Tiwari (1):
      wifi: mt76: mt7996: fix typos in comments

Bitterblue Smith (25):
      wifi: rtl8xxxu: Report the signal strength only if it's known
      wifi: rtl8xxxu: Dump the efuse right after reading it
      wifi: rtl8xxxu: Use correct power off sequence for RTL8192CU
      wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
      wifi: rtw89: usb: Move bulk out map to new struct rtw89_usb_info
      wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_pre_init() for RTL8852CU
      wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_post_init() for RTL8852CU
      wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
      wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
      wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
      wifi: rtw89: 8852c: Accept USB devices and load their MAC address
      wifi: rtw89: Add rtw8852cu.c
      wifi: rtw89: Enable the new rtw89_8852cu module
      wifi: rtw89: Use the correct power sequences for USB/SDIO
      wifi: rtw89: Add rtw8852a_dle_mem_usb
      wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
      wifi: rtw89: 8852a: Accept USB devices and load their MAC address
      wifi: rtw89: Add rtw8852au.c
      wifi: rtw89: Enable the new rtw89_8852au module
      wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
      wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX with 40 MHz width
      wifi: rtl8xxxu: Fix the 40 MHz subchannel for RTL8192EU, RTL8723BU
      wifi: rtl8xxxu: Fix RX channel width reported by RTL8192FU
      wifi: rtl8xxxu: Enable 40 MHz width by default

Caleb James DeLisle (1):
      wifi: mt76: mmio_*_copy fix byte order and alignment

Chien Wong (5):
      wifi: mac80211: fix CMAC functions not handling errors
      wifi: mac80211: add generic MMIE struct defines
      wifi: mac80211: utilize the newly defined CMAC constants
      wifi: mac80211: refactor CMAC crypt functions
      wifi: mac80211: refactor CMAC packet handlers

Chih-Kang Chang (3):
      wifi: rtw89: flush TX queue before deleting key
      wifi: rtw89: update format of addr cam H2C command
      wifi: rtw89: correct user macid mask of RX info for RTL8922D

Chin-Yen Lee (2):
      wifi: rtw89: restart hardware to recover firmware if power-save becomes abnormal
      wifi: rtw88: 8822c: use fixed rate and bandwidth to reply CSI packets

Dan Hamik (1):
      wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO USB Wifi dongle

Fedor Pchelkin (11):
      wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
      wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
      wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
      wifi: rtw89: refine rtw89_core_tx_wait_complete()
      wifi: rtw89: implement C2H TX report handler
      wifi: rtw89: usb: anchor TX URBs
      wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
      wifi: rtw89: provide TX reports for management frames
      wifi: rtw89: process TX wait skbs for USB via C2H handler
      Revert "wifi: mt76: mt792x: improve monitor interface handling"
      wifi: mt76: adjust BSS conf pointer handling

Felix Fietkau (3):
      wifi: mt76: mt7996: fix null pointer deref in mt7996_conf_tx()
      wifi: mt76: fix license/copyright of util.h
      wifi: mt76: relicense to BSD-3-Clause-Clear

Hans de Goede (1):
      wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet

Hiroaki Yamamoto (1):
      wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list

Howard Hsu (1):
      wifi: mt76: mt7996: fix implicit beamforming support for mt7992

Jack Kao (1):
      wifi: mt76: mt7925: cqm rssi low/high event notify

Johannes Berg (5):
      Merge tag 'rtw-next-2025-11-21-v2' of https://github.com/pkshih/rtw
      wifi: mac80211: fix channel switching code
      wifi: cfg80211: use cfg80211_leave() in iftype change
      wifi: cfg80211: stop radar detection in cfg80211_leave()
      Merge tag 'mt76-next-2025-11-24' of https://github.com/nbd168/wireless

Jui-Peng Tsai (1):
      wifi: rtw89: improve scan time on 6 GHz band

Kuan-Chung Chen (2):
      wifi: rtw89: 8852c: fix ADC oscillation in 160MHz affecting RX performance
      wifi: rtw89: phy: fix out-of-bounds access in rtw89_phy_read_txpwr_limit()

Lachlan Hodges (3):
      wifi: cfg80211: include s1g_primary_2mhz when sending chandef
      wifi: cfg80211: include s1g_primary_2mhz when comparing chandefs
      wifi: mac80211: allow sharing identical chanctx for S1G interfaces

Lorenzo Bianconi (14):
      wifi: mt76: mt7996: Remove unnecessary link_id checks in mt7996_tx
      wifi: mt76: wed: use proper wed reference in mt76 wed driver callabacks
      wifi: mt76: mt7996: Remove useless check in mt7996_msdu_page_get_from_cache()
      wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
      wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
      wifi: mt76: Add the capability to set TX token start ID
      wifi: mt76: Introduce the NPU generic layer
      wifi: mt76: mt7996: Add NPU offload support to MT7996 driver
      wifi: mt76: mt7996: grab mt76 mutex in mt7996_mac_sta_event()
      wifi: mt76: mt7996: move mt7996_update_beacons under mt76 mutex
      wifi: mt76: Move mt76_abort_scan out of mt76_reset_device()
      wifi: mt76: mt7996: skip deflink accounting for offchannel links
      wifi: mt76: mt7996: skip ieee80211_iter_keys() on scanning link remove
      wifi: mt76: mt7996: Add missing locking in mt7996_mac_sta_rc_work()

Marco Crivellari (8):
      wifi: qtnfmac: add WQ_PERCPU to alloc_workqueue users
      wifi: wfx: add WQ_PERCPU to alloc_workqueue users
      wifi: cw1200: add WQ_PERCPU to alloc_workqueue users
      wifi: cfg80211: replace use of system_unbound_wq with system_dfl_wq
      wifi: ipw2x00: replace use of system_wq with system_percpu_wq
      wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
      wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users
      wifi: mt76: replace use of system_wq with system_percpu_wq

Mario Limonciello (AMD) (1):
      wifi: mt76: Strip whitespace from build ddate

Michael Lo (1):
      wifi: mt76: mt7925: ensure the 6GHz A-MPDU density cap from the hardware.

Ming Yen Hsieh (6):
      wifi: mt76: mt7925: refactor regulatory domain handling to regd.[ch]
      wifi: mt76: mt7925: refactor CLC support check flow
      wifi: mt76: mt7925: refactor regulatory notifier flow
      wifi: mt76: mt7925: improve EHT capability control in regulatory flow
      wifi: mt76: mt7925: add auto regdomain switch support
      wifi: mt76: mt7925: disable auto regd changes after user set

Pagadala Yesu Anjaneyulu (1):
      wifi: cfg80211: Add support for 6GHz AP role not relevant AP type

Peter Chiu (2):
      wifi: mt76: use GFP_DMA32 for page_pool buffer allocation
      wifi: mt76: mt7996: no need to wait ACK event for SDO command

Ping-Ke Shih (25):
      wifi: rtw89: splice C2H events queue to local to prevent racing
      wifi: rtw89: use skb_dequeue() for queued ROC packets to prevent racing
      wifi: rtw89: 8832cu: turn off TX partial mode
      wifi: rtw89: fill TX descriptor of FWCMD in shortcut
      wifi: rtlwifi: rtl8188ee: correct allstasleep in P2P PS H2C command
      wifi: rtw89: pci: add to read PCI configuration space from common code
      wifi: rtw89: fw: parse firmware element of DIAG_MAC
      wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element
      wifi: rtw89: 8852c: add compensation of thermal value from efuse calibration
      wifi: rtw89: consider data rate/bandwidth/GI for injected packets
      wifi: rtw89: do RF calibration once setting channel when running pure monitor mode
      wifi: rtw89: configure RX antenna if chips can support
      wifi: rtw89: fw: part size to download firmware by header info
      wifi: rtw89: mac: separate pre-init code before downloading firmware
      wifi: rtw89: phy: calling BB pre-init by chips with/without BB MCU
      wifi: rtw89: mac: remove undefined bit B_BE_PPDU_MAC_INFO
      wifi: rtw89: mac: update wcpu_on to download firmware for RTL8922D
      wifi: rtw89: phy: consider type 15 in BB gain table
      wifi: rtw89: phy: ignore DCFO if not defined in chip_info
      wifi: rtw89: fw: print band and port where beacon update on
      wifi: rtw89: align RA H2C format v1 for RTL8922A
      wifi: rtw89: fill addr cam H2C command by struct
      wifi: rtw89: add addr cam H2C command v1
      wifi: rtw89: use separated function to set RX filter
      wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO

Quan Zhou (1):
      wifi: mt76: mt792x: fix wifi init fail by setting MCU_RUNNING after CLC load

Randy Dunlap (1):
      wifi: nl80211: vendor-cmd: intel: fix a blank kernel-doc line warning

Ria Thomas (1):
      wifi: ieee80211: correct FILS status codes

Rob Herring (Arm) (1):
      wifi: mt76: Use of_reserved_mem_region_to_resource() for "memory-region"

Seungjin Bae (1):
      wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()

Shayne Chen (10):
      wifi: mt76: mt7915: add bf backoff limit table support
      wifi: mt76: mt7996: support fixed rate for link station
      wifi: mt76: mt7996: fix several fields in mt7996_mcu_bss_basic_tlv()
      wifi: mt76: mt7996: fix teardown command for an MLD peer
      wifi: mt76: mt7996: set link_valid field when initializing wcid
      wifi: mt76: mt7996: use correct link_id when filling TXD and TXP
      wifi: mt76: mt7996: fix MLD group index assignment
      wifi: mt76: mt7996: fix MLO set key and group key issues
      wifi: mt76: mt7996: fix using wrong phy to start in mt7996_mac_restart()
      wifi: mt76: mt7996: fix EMI rings for RRO

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix max nss value when getting rx chainmask

Sven Eckelmann (Plasma Cloud) (3):
      wifi: mt76: Fix DTS power-limits on little endian systems
      dt-bindings: net: wireless: mt76: Document power-limits country property
      dt-bindings: net: wireless: mt76: introduce backoff limit properties

Thorsten Blum (1):
      wifi: mt76: connac: Replace memcpy + hard-coded size with strscpy

Yu-Chun Lin (1):
      wifi: rtw89: Replace hardcoded strings with helper functions

Zenm Chen (3):
      wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
      wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1
      wifi: rtw89: Add default ID 0bda:b831 for RTL8831BU

Zilin Guan (1):
      mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()

Zong-Zhe Yang (3):
      wifi: rtw89: mlo: handle needed H2C when link switching is requested by stack
      wifi: rtw89: support EHT rate pattern via bitrate mask
      wifi: rtw89: regd: apply ACPI policy even if country code is programmed

 .../bindings/net/wireless/mediatek,mt76.yaml       |  66 +++
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c |  14 +
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |   6 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/Kconfig         |   6 +-
 drivers/net/wireless/mediatek/mt76/Makefile        |   3 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |   2 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c       |   6 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  75 ++-
 drivers/net/wireless/mediatek/mt76/dma.h           |  69 ++-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |  77 +++-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  10 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |   2 +-
 drivers/net/wireless/mediatek/mt76/mmio.c          |  14 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          | 159 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/Makefile |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7603/debugfs.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |   2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615_trace.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_init.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/testmode.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/trace.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb_sdio.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  21 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  10 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci_mcu.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb_mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_beacon.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_debugfs.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dma.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Makefile |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/mt76x2u.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_init.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_mcu.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_phy.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_init.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_mac.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_mcu.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_phy.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/coredump.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/coredump.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |  76 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 184 ++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |  23 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/testmode.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |   4 +-
 .../net/wireless/mediatek/mt76/mt7925/debugfs.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   | 152 +------
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  40 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  99 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   5 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c   | 265 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7925/regd.h   |  19 +
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/testmode.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   4 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt792x_debugfs.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_trace.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_trace.h  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Makefile |   3 +-
 .../net/wireless/mediatek/mt76/mt7996/coredump.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/coredump.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  74 +--
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  33 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  34 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  62 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 153 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  78 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  16 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  38 +-
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    | 352 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/npu.c           | 501 +++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/pci.c           |   2 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |   2 +-
 drivers/net/wireless/mediatek/mt76/sdio.c          |   2 +-
 drivers/net/wireless/mediatek/mt76/sdio.h          |   2 +-
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c     |   2 +-
 drivers/net/wireless/mediatek/mt76/testmode.c      |   2 +-
 drivers/net/wireless/mediatek/mt76/testmode.h      |   2 +-
 drivers/net/wireless/mediatek/mt76/trace.c         |   2 +-
 drivers/net/wireless/mediatek/mt76/trace.h         |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |   8 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |   2 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.c     |   2 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.h     |   2 +-
 drivers/net/wireless/mediatek/mt76/util.c          |   2 +-
 drivers/net/wireless/mediatek/mt76/util.h          |   3 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |  12 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |   3 +-
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |   9 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |  27 +-
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |  80 +++-
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c      | 115 ++++-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       | 188 ++------
 drivers/net/wireless/realtek/rtl8xxxu/regs.h       |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 -
 drivers/net/wireless/realtek/rtlwifi/base.c        |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/fw.c    |   2 +-
 drivers/net/wireless/realtek/rtw88/bf.c            |   8 +-
 drivers/net/wireless/realtek/rtw88/bf.h            |   7 +
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |   2 +
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |   2 +
 drivers/net/wireless/realtek/rtw88/usb.c           |   3 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |  22 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   6 +
 drivers/net/wireless/realtek/rtw89/cam.c           | 165 ++++---
 drivers/net/wireless/realtek/rtw89/cam.h           | 450 +++++-------------
 drivers/net/wireless/realtek/rtw89/core.c          | 231 +++++++---
 drivers/net/wireless/realtek/rtw89/core.h          | 104 ++++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 299 ++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c            | 169 ++++---
 drivers/net/wireless/realtek/rtw89/fw.h            |  67 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           | 200 +++++++-
 drivers/net/wireless/realtek/rtw89/mac.h           | 114 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  89 +++-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   9 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  18 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   4 -
 drivers/net/wireless/realtek/rtw89/phy.c           |  65 ++-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   4 +
 drivers/net/wireless/realtek/rtw89/ps.c            |  23 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  24 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |  22 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   5 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |  24 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  85 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |  79 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   5 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |  24 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      | 170 +++++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  69 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |  69 +++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  17 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   7 +-
 drivers/net/wireless/realtek/rtw89/usb.c           | 115 +++--
 drivers/net/wireless/realtek/rtw89/usb.h           |  12 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   8 +-
 drivers/net/wireless/silabs/wfx/main.c             |   2 +-
 drivers/net/wireless/st/cw1200/bh.c                |   5 +-
 include/linux/ieee80211-he.h                       |   1 +
 include/linux/ieee80211.h                          |  18 +-
 include/linux/soc/airoha/airoha_offload.h          |   1 +
 include/linux/soc/mediatek/mtk_wed.h               |   1 +
 include/net/cfg80211.h                             |   4 +-
 include/uapi/linux/nl80211-vnd-intel.h             |   1 -
 net/mac80211/aes_cmac.c                            |  60 ++-
 net/mac80211/aes_cmac.h                            |   7 +-
 net/mac80211/aes_gmac.c                            |  22 +-
 net/mac80211/aes_gmac.h                            |   1 -
 net/mac80211/chan.c                                |  15 +-
 net/mac80211/mlme.c                                |   5 +-
 net/mac80211/rx.c                                  |   6 +-
 net/mac80211/tx.c                                  |   6 +-
 net/mac80211/wpa.c                                 | 150 ++----
 net/mac80211/wpa.h                                 |  10 +-
 net/wireless/core.c                                |   5 +-
 net/wireless/core.h                                |   1 +
 net/wireless/mlme.c                                |  19 +
 net/wireless/nl80211.c                             |   3 +
 net/wireless/sysfs.c                               |   2 +-
 net/wireless/util.c                                |  23 +-
 298 files changed, 5050 insertions(+), 1792 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/npu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/npu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852au.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c

