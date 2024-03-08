Return-Path: <linux-wireless+bounces-4484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E726876177
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 11:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982A0B21061
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A45380E;
	Fri,  8 Mar 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRALQZU5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764E537FE;
	Fri,  8 Mar 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892271; cv=none; b=C1Qoknnv0aC36zKX4rD9+E6WPYPon/1iJk6tI+NohMDsvw/bnCdTk4uvXMAJm1Z5sUG5hfFfnkqRXVC15Qo4WaFlAuuwA47H1T/R0+hSl6RBf/DtZktRzFfv/+sQHUdhe11E5CZZkk3LJl2g4IpRiR5DQkhwtKN5SYyRy0RMvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892271; c=relaxed/simple;
	bh=tsr8E9M0zZ69ZDICkf9NnJDjM6s4MNJ3Y28HJDjq5GM=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=epPbl1OZI+MTzgRNodv5QpAngbwqXdKmKqwj96VXqHIZPUvN1lbYhF6XZcod/5pv2GZF6o6sfqupnx4lzguK0tSyj5DorDNV9vO5Wf2eBYxf4lcfTMa0W3sSGizsoLVOZnF6kHABK9LeYmNIiDC/yeas33LWytK+u1fqu55jFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRALQZU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EA2C433F1;
	Fri,  8 Mar 2024 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892270;
	bh=tsr8E9M0zZ69ZDICkf9NnJDjM6s4MNJ3Y28HJDjq5GM=;
	h=From:Subject:To:Cc:Date:From;
	b=XRALQZU50ftjvCt+PXGyUq4gWmmYzkuDT5bJ0TE0x23sFGzP7JMcElcRrJdD+R6v7
	 rxoenzgh2ap9Jkq95BiTTwrycOa32PPjLKAux0ixJ5H/DgHFoetHzdsfXrryMB5BS3
	 ZHFd0+7xg5y2i5dtwDHOKBbg9flhP/QVT7aQyC6MkzBsZJ161EubAOSudwbQo8zyR3
	 ube7inuwKPbNSF8chL3Q2KwCSARw0TPeh0obk3L/wnHQNy7IUY06ascT4FcQ0TJqi+
	 8GtQWtHFNjgqvuhUzhott9AVecdcAilr7Zqs8jF/10yvKWnbwkSms8yXa3tqXLpxmN
	 ZswgUiPnGY9yA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-03-08
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240308100429.B8EA2C433F1@smtp.kernel.org>
Date: Fri,  8 Mar 2024 10:04:29 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit a4634aa71fee11f5e3e13bf7d80ee1480a64ce70:

  bonding: rate-limit bonding driver inspect messages (2024-02-22 19:13:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-03-08

for you to fetch changes up to f654e228ed6b822e87e6e6ad8e889bedccae2e16:

  Merge tag 'ath-next-20240305' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2024-03-05 20:57:28 +0200)

----------------------------------------------------------------
wireless-next patches for v6.9

The fourth "new features" pull request for v6.9 with changes both in
stack and in drivers. The theme in this pull request is to fix sparse
warnings but we still have some left in wireless subsystem. Otherwise
quite normal.

Major changes:

rtw89

* NL80211_EXT_FEATURE_SCAN_RANDOM_SN support

* NL80211_EXT_FEATURE_SET_SCAN_DWELL support

rtw88

* support for more rtw8811cu and rtw8821cu devices

mt76

* mt76x2u: add Netgear WNDA3100v3 USB

* mt7915: newer ADIE version support

* mt7925: radio temperature sensor support

* mt7996: remove GCMP IGTK offload

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211: handle netif carrier up/down with link AP during MLO

Alexey Berezhok (1):
      wifi: brcmfmac: do not pass hidden SSID attribute as value directly

Baochen Qiang (5):
      wifi: ath11k: rearrange IRQ enable/disable in reset path
      wifi: ath11k: remove MHI LOOPBACK channels
      wifi: ath11k: do not dump SRNG statistics during resume
      wifi: ath11k: fix warning on DMA ring capabilities event
      wifi: ath11k: decrease MHI channel buffer length to 8KB

Benjamin Lin (3):
      wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
      wifi: mt76: mt7996: ensure 4-byte alignment for beacon commands
      wifi: mt76: mt7996: fix HIF_TXD_V2_1 value

Bitterblue Smith (5):
      wifi: rtw88: 8821cu: Fix firmware upload fail
      wifi: rtw88: 8821cu: Fix connection failure
      wifi: rtw88: 8821c: Fix beacon loss and disconnect
      wifi: rtw88: 8821c: Fix false alarm count
      wifi: rtlwifi: Remove rtl_intf_ops.read_efuse_byte

Chin-Yen Lee (8):
      wifi: rtw89: pci: implement PCI CLK/ASPM/L1SS for WiFi 7 chips
      wifi: rtw89: wow: update WoWLAN reason register for different chips
      wifi: rtw89: wow: update WoWLAN status register for different generation
      wifi: rtw89: update DMA function with different generation
      wifi: rtw89: wow: update config mac function with different generation
      wifi: rtw89: update suspend/resume for different generation
      wifi: rtw89: wow: set security engine options for 802.11ax chips only
      wifi: rtw89: wow: move release offload packet earlier for WoWLAN mode

Ching-Te Ku (6):
      wifi: rtw89: coex: add init_info H2C command format version 7
      wifi: rtw89: coex: add BTC ctrl_info version 7 and related logic
      wifi: rtw89: coex: Reorder H2C command index to align with firmware
      wifi: rtw89: coex: add return value to ensure H2C command is success or not
      wifi: rtw89: coex: When Bluetooth not available don't set power/gain
      wifi: rtw89: coex: Add coexistence policy to decrease WiFi packet CRC-ERR

Colin Ian King (1):
      wifi: mt76: Remove redundant assignment to variable tidno

Dacio Romero (1):
      wifi: mt76: mt76x2u: add netgear wdna3100v3 to device table

Deren Wu (5):
      wifi: mt76: mt792xu: enable dmashdl support
      wifi: mt76: mt7925: update PCIe DMA settings
      wifi: mt76: mt7925: support temperature sensor
      wifi: mt76: mt7921e: fix use-after-free in free_irq()
      wifi: mt76: mt7925e: fix use-after-free in free_irq()

Duoming Zhou (1):
      wifi: brcm80211: handle pmk_op allocation failure

Felix Fietkau (1):
      wifi: mt76: mt7915: fix error recovery with WED enabled

Gen Xu (1):
      wifi: mt76: mt792x: fix ethtool warning

Gustavo A. R. Silva (1):
      wifi: brcmfmac: fweh: Fix boot crash on Raspberry Pi 4

Hao Zhang (1):
      wifi: mt76: mt7925: fix mcu query command fail

Howard Hsu (1):
      wifi: mt76: mt7996: fix HE beamformer phy cap for station vif

Ilan Peer (2):
      wifi: mac80211: Allow beacons to update BSS table regardless of scan
      wifi: mac80211: Adjust CQM handling for MLO

Javier Martinez Canillas (1):
      wifi: wlcore: sdio: Rate limit wl12xx_sdio_raw_{read,write}() failures warns

Jeff Johnson (2):
      dt-bindings: net: wireless: qcom: Update maintainers
      wifi: ath11k: constify MHI channel and controller configs

Johannes Berg (30):
      wifi: b43: silence sparse warnings
      wifi: brcmsmac: silence sparse warnings
      wifi: rt2x00: silence sparse warnings
      wifi: zd1211rw: silence sparse warnings
      bitfield: suppress "dubious: x & !y" sparse warning
      wifi: mac80211: always initialize match_auth
      wifi: mac80211: check link exists before use
      wifi: mac80211: fix supported rate masking in scan
      wifi: mac80211: track capability/opmode NSS separately
      wifi: cfg80211: check A-MSDU format more carefully
      wifi: mac80211: don't add VHT capa on links without them
      wifi: mac80211: obtain AP HT/VHT data for assoc request
      wifi: cfg80211: print flags in tracing in hex
      wifi: mac80211: update scratch_pos after defrag
      wifi: mac80211: remove unnecessary ML element type check
      wifi: mac80211: add ieee80211_vif_link_active() helper
      wifi: mac80211: remove unnecessary ML element checks
      wifi: mac80211: simplify multi-link element parsing
      wifi: mac80211: defragment reconfiguration MLE when parsing
      wifi: mac80211: remove unneeded scratch_len subtraction
      wifi: mac80211: hide element parsing internals
      wifi: cfg80211: expose cfg80211_iter_rnr() to drivers
      wifi: cfg80211: allow cfg80211_defragment_element() without output
      wifi: mac80211: pass link_id to channel switch ops
      wifi: mac80211: pass link conf to abort_channel_switch
      wifi: mac80211: introduce a feature flag for quiet in CSA
      wifi: mac80211: mlme: unify CSA handling
      wifi: mac80211: remove TDLS peers only on affected link
      wifi: mac80211: remove TDLS peers on link deactivation
      wifi: cw1200: restore endian swapping

Kalle Valo (4):
      wifi: ath11k: thermal: don't try to register multiple times
      Merge tag 'mt76-for-kvalo-2024-02-22' of https://github.com/nbd168/wireless
      wifi: ath12k: fix license in p2p.c and p2p.h
      Merge tag 'ath-next-20240305' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Kang Yang (1):
      wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()

Kuan-Chung Chen (2):
      wifi: rtw89: advertise missing extended scan feature
      wifi: rtw89: Update EHT PHY beamforming capability

Leon Yen (1):
      wifi: mt76: mt7921: fix a potential association failure upon resuming

Lorenzo Bianconi (5):
      wifi: mt76: mt7996: fix fw loading timeout
      wifi: mt76: usb: create a dedicated queue for psd traffic
      wifi: mt76: usb: store usb endpoint in mt76_queue
      wifi: mt76: move wed common utilities in wed.c
      wifi: mt76: set page_pool napi pointer for mmio devices

Michael Lo (1):
      wifi: mt76: mt7921: fix suspend issue on MediaTek COB platform

Michael-CY Lee (1):
      wifi: mt76: mt7996: mark GCMP IGTK unsupported

Ming Yen Hsieh (13):
      wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
      wifi: mt76: mt7925: fix wmm queue mapping
      wifi: mt76: mt7925: fix fw download fail
      wifi: mt76: mt7925: fix WoW failed in encrypted mode
      wifi: mt76: mt7925: fix the wrong header translation config
      wifi: mt76: mt7925: add support to set ifs time by mcu command
      wifi: mt76: mt7925: fix the wrong data type for scan command
      wifi: mt76: mt792x: add the illegal value check for mtcl table of acpi
      wifi: mt76: mt7921: fix incorrect type conversion for CLC command
      wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz channel config from ACPI
      wifi: mt76: mt792x: update the country list of EU for ACPI SAR
      wifi: mt76: mt7921: fix the unfinished command of regd_notifier before suspend
      wifi: mt76: fix the issue of missing txpwr settings from ch153 to ch177

Nick Morrow (1):
      wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU

Peter Chiu (8):
      wifi: mt76: disable HW AMSDU when using fixed rate
      wifi: mt76: check txs format before getting skb by pid
      wifi: mt76: mt7915: update mt798x_wmac_adie_patch_7976
      dt-bindings: net: wireless: mt76: add interrupts description for MT7986
      wifi: mt76: mt7996: check txs format before getting skb by pid
      wifi: mt76: mt7996: fix TWT issues
      wifi: mt76: mt7996: disable AMSDU for non-data frames
      wifi: mt76: mt7996: remove TXS queue setting

Ping-Ke Shih (2):
      wifi: rtw89: mac: add coexistence helpers {cfg/get}_plt
      wifi: rtw89: 8922a: add coexistence helpers of SW grant

Quan Zhou (1):
      wifi: mt76: mt7925: add flow to avoid chip bt function fail

Rafał Miłecki (1):
      dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981

Rameshkumar Sundaram (1):
      wifi: mac80211: remove only link keys during stopping link AP

Shaul Triebitz (1):
      wifi: mac80211: add link id to ieee80211_gtk_rekey_add()

Shayne Chen (3):
      wifi: mt76: mt7915: add locking for accessing mapped registers
      wifi: mt76: mt7996: add locking for accessing mapped registers
      wifi: mt76: connac: set correct muar_idx for mt799x chipsets

Shiji Yang (1):
      wifi: rtl8xxxu: fix mixed declarations in rtl8xxxu_set_aifs()

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix efuse reading issue

Takashi Iwai (1):
      wifi: iwlwifi: Add missing MODULE_FIRMWARE() for *.pnvm

rong.yan (1):
      wifi: mt76: mt7925: fix SAP no beacon issue in 5Ghz and 6Ghz band

 .../bindings/net/wireless/mediatek,mt76.yaml       |  33 +-
 .../bindings/net/wireless/qcom,ath10k.yaml         |   1 +
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   1 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |   1 +
 drivers/net/wireless/ath/ath11k/core.c             |   8 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |  68 +---
 drivers/net/wireless/ath/ath11k/qmi.c              |   5 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |   5 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   3 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |   2 +-
 drivers/net/wireless/ath/ath12k/p2p.h              |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   5 +-
 drivers/net/wireless/broadcom/b43/phy_ht.c         |   6 +-
 drivers/net/wireless/broadcom/b43/phy_n.c          |   4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  12 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |   2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |   2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |  16 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   6 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   3 +-
 drivers/net/wireless/mediatek/mt76/Makefile        |   2 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c           | 106 +-----
 drivers/net/wireless/mediatek/mt76/dma.h           |   9 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  26 +-
 drivers/net/wireless/mediatek/mt76/mmio.c          | 107 ------
 drivers/net/wireless/mediatek/mt76/mt76.h          |  61 ++--
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   5 +
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |   5 +
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   4 +
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |  55 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   6 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  13 +
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |  13 +
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  56 +++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  26 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 212 +++++++----
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |  94 ++++-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   3 +
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   2 +
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |  38 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  15 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |   8 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |  72 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  81 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  32 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  74 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   6 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |  52 +--
 drivers/net/wireless/mediatek/mt76/wed.c           | 213 +++++++++++
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   8 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   4 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   1 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |   6 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   1 -
 drivers/net/wireless/realtek/rtw88/mac.c           |   7 +
 drivers/net/wireless/realtek/rtw88/main.c          |   2 -
 drivers/net/wireless/realtek/rtw88/phy.c           |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |  46 ++-
 drivers/net/wireless/realtek/rtw88/usb.c           |  40 +++
 drivers/net/wireless/realtek/rtw89/coex.c          | 393 ++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/coex.h          |  20 ++
 drivers/net/wireless/realtek/rtw89/core.c          |  10 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  99 +++++-
 drivers/net/wireless/realtek/rtw89/debug.c         |   9 +-
 drivers/net/wireless/realtek/rtw89/fw.c            | 116 +++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  54 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  49 ++-
 drivers/net/wireless/realtek/rtw89/mac.h           |  34 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        | 166 +++++++++
 drivers/net/wireless/realtek/rtw89/pci.c           |  79 +++--
 drivers/net/wireless/realtek/rtw89/pci.h           |  60 ++++
 drivers/net/wireless/realtek/rtw89/pci_be.c        | 116 +++++-
 drivers/net/wireless/realtek/rtw89/reg.h           |  84 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      | 143 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  65 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  65 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  65 +++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 113 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  48 +--
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |   6 +
 drivers/net/wireless/ti/wlcore/sdio.c              |   8 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |   5 +-
 include/linux/bitfield.h                           |   3 +-
 include/net/cfg80211.h                             |  36 +-
 include/net/mac80211.h                             |  36 +-
 net/mac80211/cfg.c                                 | 146 +++++---
 net/mac80211/chan.c                                |   3 +-
 net/mac80211/debugfs.c                             |   3 +-
 net/mac80211/driver-ops.c                          |  14 +-
 net/mac80211/driver-ops.h                          |   8 +-
 net/mac80211/ieee80211_i.h                         |  21 +-
 net/mac80211/iface.c                               |   6 +-
 net/mac80211/key.c                                 |  16 +-
 net/mac80211/link.c                                |   2 +-
 net/mac80211/mlme.c                                | 191 +++++++---
 net/mac80211/parse.c                               | 139 +++++---
 net/mac80211/rate.c                                |   2 +-
 net/mac80211/scan.c                                |  22 +-
 net/mac80211/sta_info.h                            |   6 +-
 net/mac80211/tdls.c                                |   6 +-
 net/mac80211/tests/elems.c                         |   4 +-
 net/mac80211/trace.h                               |  82 +----
 net/mac80211/util.c                                |  11 +-
 net/mac80211/vht.c                                 |  46 ++-
 net/wireless/scan.c                                |  47 +--
 net/wireless/tests/fragmentation.c                 |  30 +-
 net/wireless/trace.h                               |  10 +-
 net/wireless/util.c                                |  14 +-
 132 files changed, 3174 insertions(+), 1340 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/wed.c


