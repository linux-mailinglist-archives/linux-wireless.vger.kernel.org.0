Return-Path: <linux-wireless+bounces-12784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F35974CE1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323F71C22104
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0813416D9DF;
	Wed, 11 Sep 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQgsAT+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B10165F1E;
	Wed, 11 Sep 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044108; cv=none; b=Os5QW6FC2KJnMUGCbTwP88OVweWQq1aHXFsHKZrdPBJ15K8c80KOjghsrUW06aojz4Bp4vJmjtTF87hBgo3uu9DH+WaZVl6BPfDhziCgOnMmGjuGsMC7CB1FImzy4rbtq10ryh+SSbnQIJNLyhSZG4hWF/3RmtHfxzLfeJ83UFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044108; c=relaxed/simple;
	bh=yveMsjqaOoEsqdegflybqL1Ma8yhDAEnqGO7HSnLIuo=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=D9WVjaSEA0Hevpu5MWrE7CE9QX76UiKuxuiVQDrgiYb4PMuX8JTjRGDBf8DxMDh6XgxJxCTMgdklEGMuSAonnQiyx1tufm011kWAjvS34VIvJnq53j3oXwuLGSqPs1jyCdv5WVESdEg2ggmzsjzQqvc2EgAzqCYMxUwhkAkw6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQgsAT+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A205DC4AF0F;
	Wed, 11 Sep 2024 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726044108;
	bh=yveMsjqaOoEsqdegflybqL1Ma8yhDAEnqGO7HSnLIuo=;
	h=From:Subject:To:Cc:Date:From;
	b=uQgsAT+NMvYv+IJy1jMARy0ZfRPSyJToktCYuoF4m+hCt7b5TSDQVuZYezAaVE0Vm
	 pVML2ePPzbNs74XIcCIzhk8Keh2OlYIfO3ZGZXBXb77inuisEhknX766I4iALBcp2b
	 x9bF4l9EaFxfrkPt0BWrV9vY86H0Sbm1vaKZJcQZh2/I/Zetc4sID7TM9aDoGn3zXx
	 8uqW8sXeRpsfgo1ZsAxQ4Sv3fnj47sZY9G/M1pVtUnOLH9Ezb/CgrPvE4aMTVBNn7E
	 tWUrYVPvvb0QdnO5sCOQu52DFX2ReP8ASI1HoMvI9iaYxR0l1O/1CXMx9/6RerQrq0
	 8iEdruoKX+vsQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-09-11
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240911084147.A205DC4AF0F@smtp.kernel.org>
Date: Wed, 11 Sep 2024 08:41:47 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 43b7724487109368363bb5cda034b3f600278d14:

  Merge tag 'wireless-next-2024-09-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2024-09-04 17:20:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-09-11

for you to fetch changes up to fe57beb026ef5f9614adfa23ee6f3c21faede2cf:

  Merge tag 'ath-next-20240909' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-09-09 20:40:12 +0300)

----------------------------------------------------------------
wireless-next patches for v6.12

The last -next "new features" pull request for v6.12. The stack now
supports DFS on MLO but otherwise nothing really standing out.

Major changes:

cfg80211/mac80211

* EHT rate support in AQL airtime

* DFS support for MLO

rtw89

* complete BT-coexistence code for RTL8852BT

* RTL8922A WoWLAN net-detect support

----------------------------------------------------------------
Aditya Kumar Singh (8):
      Revert "wifi: mac80211: move radar detect work to sdata"
      wifi: mac80211: remove label usage in ieee80211_start_radar_detection()
      wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt class
      wifi: cfg80211: move DFS related members to links[] in wireless_dev
      wifi: cfg80211: handle DFS per link
      wifi: mac80211: handle DFS per link
      wifi: cfg80211/mac80211: use proper link ID for DFS
      wifi: mac80211: handle ieee80211_radar_detected() for MLO

Benjamin Lin (3):
      wifi: mt76: connac: add IEEE 802.11 fragmentation support for mt7996
      wifi: mt76: connac: add support for IEEE 802.11 fragmentation
      wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation

Bitterblue Smith (1):
      wifi: rtw88: Fix USB/SDIO devices not transmitting beacons

Bjørn Mork (1):
      wifi: mt76: mt7915: fix oops on non-dbdc mt7986

Chen Ni (2):
      wifi: mt76: mt7925: convert comma to semicolon
      wifi: brcmfmac: cfg80211: Convert comma to semicolon

Chia-Yuan Li (1):
      wifi: rtw89: limit the PPDU length for VHT rate to 0x40000

Chin-Yen Lee (4):
      wifi: rtw89: 8852a: adjust ANA clock to 12M
      wifi: rtw89: wow: add wait for H2C of FW-IPS mode
      wifi: rtw89: wow: add net-detect support for 8922ae
      wifi: rtw89: wow: add scan interval option for net-detect

Ching-Te Ku (4):
      wifi: rtw89: coex: Update report version of Wi-Fi firmware 0.29.90.0 for RTL8852BT
      wifi: rtw89: coex: Update Wi-Fi role info version 7
      wifi: rtw89: coex: Bluetooth hopping map for Wi-Fi role version 7
      wifi: rtw89: coex: Add new Wi-Fi role format condition for function using

Christophe JAILLET (1):
      wifi: rsi: Remove an unused field in struct rsi_debugfs

Dmitry Antipov (3):
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Kandybka (1):
      wifi: rtw88: remove CPT execution branch never used

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: replace CONFIG_PM by CONFIG_PM_SLEEP

Eric Huang (2):
      wifi: rtw89: adjust DIG threshold to reduce false alarm
      wifi: rtw89: use frequency domain RSSI

Felix Fietkau (21):
      wifi: mt76: mt7603: fix mixed declarations and code
      wifi: mt76: mt7603: fix reading target power from eeprom
      wifi: mt76: mt7603: initialize chainmask
      wifi: mt76: fix mt76_get_rate
      wifi: mt76: partially move channel change code to core
      wifi: mt76: add separate tx scheduling queue for off-channel tx
      wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
      wifi: mt76: mt7915: allocate vif wcid in the same range as stations
      wifi: mt76: connac: add support for passing connection state directly
      wifi: mt76: change .sta_assoc callback to .sta_event
      wifi: mt76: mt7915: use mac80211 .sta_state op
      wifi: mt76: mt7915: set MT76_MCU_RESET early in mt7915_mac_full_reset
      wifi: mt76: mt7915: retry mcu messages
      wifi: mt76: mt7915: reset the device after MCU timeout
      wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
      wifi: mt76: connac: move mt7615_mcu_del_wtbl_all to connac
      wifi: mt76: mt7915: improve hardware restart reliability
      wifi: mt76: shrink mt76_queue_buf
      wifi: mt76: mt7915: always query station rx rate from firmware
      wifi: mt76: mt7996: fix uninitialized TLV data
      wifi: mt76: mt7915: avoid long MCU command timeouts during SER

Gustavo A. R. Silva (4):
      wifi: ath11k: Avoid -Wflex-array-member-not-at-end warnings
      wifi: ath12k: Avoid -Wflex-array-member-not-at-end warnings
      wifi: mt76: Avoid multiple -Wflex-array-member-not-at-end warnings
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Howard Hsu (5):
      wifi: mt76: mt7996: fix HE and EHT beamforming capabilities
      wifi: mt76: mt7996: set correct beamformee SS capability
      wifi: mt76: mt7996: fix EHT beamforming capability check
      wifi: mt76: mt7996: set correct value in beamforming mcu command for mt7992
      wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Jiawei Ye (1):
      wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param

Johannes Berg (1):
      wifi: cfg80211: fix kernel-doc for per-link data

Kalle Valo (3):
      Merge tag 'rtw-next-2024-09-05' of https://github.com/pkshih/rtw
      Merge tag 'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20240909' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Kuan-Chung Chen (2):
      wifi: rtw89: 8852c: support firmware with fw_element
      wifi: rtw89: 8922a: add digital compensation to avoid TX EVM degrade

Li Zetao (2):
      wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_sdio_probe()
      wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_bus_probe()

Ma Ke (4):
      wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he
      wifi: mt76: mt7915: check devm_kasprintf() returned value
      wifi: mt76: mt7921: Check devm_kasprintf() returned value
      wifi: mt76: mt7615: check devm_kasprintf() returned value

Miaoqing Pan (1):
      wifi: ath12k: fix the stack frame size warning in ath12k_mac_op_hw_scan

Michael Lo (1):
      wifi: mt76: mt7925: fix a potential association failure upon resuming

Michael-CY Lee (1):
      wifi: mt76: mt7996: set IEEE80211_KEY_FLAG_GENERATE_MMIE for other ciphers

Ming Yen Hsieh (4):
      wifi: mt76: mt7921: fix wrong UNII-4 freq range check for the channel usage
      wifi: mac80211: introduce EHT rate support in AQL airtime
      wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc
      wifi: mt76: mt7925: replace chan config with extend txpower config for clc

Peter Chiu (5):
      wifi: mt76: mt7996: use hweight16 to get correct tx antenna
      wifi: mt76: mt7996: fix traffic delay when switching back to working channel
      wifi: mt76: mt7996: fix wmm set of station interface to 3
      wifi: mt76: mt7996: advertize beacon_int_min_gcd
      wifi: mt76: connac: fix checksum offload fields of connac3 RXD

Ping-Ke Shih (4):
      wifi: rtw89: remove unused C2H event ID RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
      wifi: rtw89: correct base HT rate mask for firmware
      wifi: rtw89: debugfs: support multiple adapters debugging
      wifi: rtw88: assign mac_id for vif/sta and update to TX desc

Rex Lu (1):
      wifi: mt76: mt7996: fix handling mbss enable/disable

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Veerendranath Jakkam (4):
      wifi: cfg80211: Avoid RCU debug splat in __cfg80211_bss_update error paths
      wifi: cfg80211: make BSS source types public
      wifi: cfg80211: skip indicating signal for per-STA profile BSSs
      wifi: cfg80211: avoid overriding direct/MBSSID BSS with per-STA profile BSS

Yue Haibing (1):
      wifi: libertas: Cleanup unused declarations

Zong-Zhe Yang (10):
      wifi: rtw89: pass chan to rfk_band_changed()
      wifi: rtw89: 8851b: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852a: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852bx: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852c: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8922a: use right chanctx whenever possible in RFK flow
      wifi: rtw89: rename roc_entity_idx to roc_chanctx_idx
      wifi: rtw89: introduce chip support link number and driver MLO capability
      wifi: rtw89: wow: fix wait condition for AOAC report request
      wifi: rtw89: avoid reading out of bounds when loading TX power FW elements

 drivers/net/wireless/ath/ath10k/debug.c            |   4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   2 +-
 drivers/net/wireless/ath/ath11k/core.h             |   8 +-
 drivers/net/wireless/ath/ath11k/dp.h               |  23 -
 drivers/net/wireless/ath/ath11k/wmi.c              |   2 +-
 drivers/net/wireless/ath/ath12k/core.h             |   8 +-
 drivers/net/wireless/ath/ath12k/dp.h               |  12 -
 drivers/net/wireless/ath/ath12k/mac.c              |  54 ++-
 drivers/net/wireless/ath/ath12k/wmi.c              |   2 +-
 drivers/net/wireless/ath/ath9k/dfs.c               |   2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c         |   2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   6 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   7 +-
 drivers/net/wireless/marvell/libertas/cmd.h        |   5 -
 .../net/wireless/marvell/libertas_tf/libertas_tf.h |   3 -
 drivers/net/wireless/marvell/mwifiex/11h.c         |  11 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   6 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |   2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   3 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  66 ++-
 drivers/net/wireless/mediatek/mt76/mcu.c           |  20 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |  25 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |   1 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |  41 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |  27 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |  18 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |   1 +
 .../net/wireless/mediatek/mt76/mt7615/testmode.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |   1 +
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |   7 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |  11 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  10 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  30 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  28 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c   |  21 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h |   2 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |   1 +
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |  25 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |   1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |  25 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  37 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 154 ++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  56 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   6 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  34 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  36 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  20 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  89 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  17 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  37 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  26 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |  62 ++-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   4 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |  10 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |   5 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |   2 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |  12 +-
 drivers/net/wireless/realtek/rtw88/coex.c          |  38 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |  13 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |  13 +-
 drivers/net/wireless/realtek/rtw88/main.c          |  30 +-
 drivers/net/wireless/realtek/rtw88/main.h          |  14 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |  11 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |   1 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  12 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 508 +++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.c          | 107 ++++-
 drivers/net/wireless/realtek/rtw89/core.h          | 118 ++++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 180 ++++----
 drivers/net/wireless/realtek/rtw89/debug.h         |   2 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  93 ++--
 drivers/net/wireless/realtek/rtw89/fw.h            |  67 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  26 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   1 -
 drivers/net/wireless/realtek/rtw89/phy.c           |  49 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   6 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   7 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   7 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  21 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  | 138 +++---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h  |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  34 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  | 292 ++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h  |  17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  23 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |  29 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.h   |  24 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 211 +++++----
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h  |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |  31 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 188 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  | 260 ++++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h  |  17 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 124 ++++-
 drivers/net/wireless/realtek/rtw89/txrx.h          |  59 ++-
 drivers/net/wireless/realtek/rtw89/wow.c           |   3 +-
 drivers/net/wireless/rsi/rsi_debugfs.h             |   1 -
 drivers/net/wireless/ti/wl18xx/event.c             |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   2 +-
 include/net/cfg80211.h                             |  25 +-
 include/net/mac80211.h                             |   5 +-
 net/mac80211/airtime.c                             | 140 +++++-
 net/mac80211/cfg.c                                 |  51 ++-
 net/mac80211/chan.c                                |   1 +
 net/mac80211/ieee80211_i.h                         |   8 +-
 net/mac80211/iface.c                               |  25 +-
 net/mac80211/link.c                                |  12 +
 net/mac80211/mlme.c                                |  13 +-
 net/mac80211/pm.c                                  |   2 +-
 net/mac80211/scan.c                                |   6 +-
 net/mac80211/util.c                                |  80 +++-
 net/wireless/core.h                                |   8 +
 net/wireless/ibss.c                                |   2 +-
 net/wireless/mesh.c                                |   2 +-
 net/wireless/mlme.c                                |  20 +-
 net/wireless/nl80211.c                             |  62 ++-
 net/wireless/rdev-ops.h                            |  13 +-
 net/wireless/reg.c                                 |  19 +-
 net/wireless/scan.c                                |  45 +-
 net/wireless/sme.c                                 |   3 +-
 net/wireless/trace.h                               |  40 +-
 159 files changed, 3128 insertions(+), 1567 deletions(-)


