Return-Path: <linux-wireless+bounces-27656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530EBA1F62
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 01:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694357A9CEA
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD172EBB9B;
	Thu, 25 Sep 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B6YDx55/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A82D24B4;
	Thu, 25 Sep 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842630; cv=none; b=VP8a64Yk9b9ojc7vE3f1A5cOKsbdex8BGAeG4mWm+kAQZIyYkZc//u7A0lhipedKk9qWtxgmpP9LgkSMtwV0SbJM2DzpHzIGmkBOcgsTM9raW+xLNDdQg4jSGCs+TTiA3AWSrW/DtEx/3M/oNPrtRdI5LMvV9G2dh+Dsy/HCeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842630; c=relaxed/simple;
	bh=QJlA+OG/piDaW6cjO42KlDE5ZwS9kN/eOqQO5ya5GBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1ysw0XxhcGcdR0rsVXghrpewjJrDVG7Y0ZaKXa9n41Ly1cIgJ+VQ1neeUTceZK9Bo2BGmwNsppgixXEBmfD6P9V5aSRB0jWZyxUvIOtHNA3QpjJoi0x5LM8j4D9QVjkK8sDXoMALsSRKymctwyJlrugmcE3XTO+pneigW9tq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B6YDx55/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FX01Fm3/9NdYmqyU88abvvM6LOqXfQUDVYa5zvdjYNc=; t=1758842628; x=1760052228; 
	b=B6YDx55/7XMYN703PfU/mFACTaeXmz67qlJTkA44GqYsnJ//jcbQfziavoLb+r2x2AY0LduV9KF
	fkZTO6kJsUSCOFc65QNrBBbyuDmDA9K6zPV3SqT5cGd+4aYywgQ7+beXwPeIcIv0NrXhaDaCJMS+E
	lG28Y7K2iwCDrURA8XXd2H/FtV+LZ9S/NTpUtnjGVMDpONMHFQoDe1vgmJt397lvCegi2vIJvNm7n
	E0oF7Kv2nc/Bcx1V7tTzDWKcEoiStpL0kXYl+z+wB8fGyFhfOPKZrQ1DXJMiD9pkXcQ2FRZOIZRL2
	AZrp6SZr+/6R/tgG7XlMRs8y3UOtQCXX4WxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v1vJR-0000000Byng-2qHh;
	Fri, 26 Sep 2025 01:23:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-09-25
Date: Fri, 26 Sep 2025 01:22:19 +0200
Message-ID: <20250925232341.4544-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry, I was sure I sent this yesterday - Jeff just reminded me
and indeed it didn't make it out ... Not a whole lot still going
on, but that's obviously expected at this point.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit f2cdc4c22bca57ab4cdb28ef4a02c53837d26fe0:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-18 11:26:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-09-25

for you to fetch changes up to 56d9de46715245c9cc46dbe16830e431056abbc3:

  wifi: libertas: add WQ_UNBOUND to alloc_workqueue users (2025-09-24 10:48:32 +0200)

----------------------------------------------------------------
Quite a bit more things, including pull requests from drivers:
 - mt76: MLO support, HW restart improvements
 - rtw88/89: small features, prep for RTL8922DE support
 - ath10k: GTK rekey fixes
 - cfg80211/mac80211:
   - additions for more NAN support
   - S1G channel representation cleanup

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Aditya Kumar Singh (1):
      wifi: mac80211: fix Rx packet handling when pubsta information is not available

Akhilesh Patil (1):
      wifi: rtw89: 8852bt: Use standard helper for string choice

Aleksej Smirnov (1):
      wifi: rtl8xxxu: Remove TL-WN722N V2 (0x2357: 0x010c) from untested devices

Alexander Wilhelm (1):
      wifi: ath12k: enforce CPU endian format for all QMI data

Andrei Otcheretianski (4):
      wifi: nl80211: Add more configuration options for NAN commands
      wifi: nl80211: Add NAN Discovery Window (DW) notification
      wifi: cfg80211: Add cluster joined notification APIs
      wifi: nl80211: Add more NAN capabilities

Arnd Bergmann (1):
      wifi: ath10k: remove gpio number assignment

Arulanbu Balusamy (1):
      wifi: ath12k: Add support to handle reason inactivity STA kickout event for QCN9274/IPQ5332

Baochen Qiang (6):
      wifi: ath12k: initialize eirp_power before use
      wifi: ath12k: fix overflow warning on num_pwr_levels
      wifi: ath11k: downgrade log level for CE buffer enqueue failure
      wifi: ath12k: fix wrong logging ID used for CE
      wifi: ath12k: downgrade log level for CE buffer enqueue failure
      wifi: ath10k: avoid unnecessary wait for service ready message

Benjamin Lin (1):
      wifi: mt76: mt7996: Temporarily disable EPCS

Bitterblue Smith (4):
      wifi: rtw88: Lock rtwdev->mutex before setting the LED
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
      wifi: rtl8xxxu: Don't claim USB ID 07b8:8188
      wifi: rtw88: Use led->brightness_set_blocking for PCI too

Chih-Kang Chang (4):
      wifi: rtw89: 8852c: check LPS H2C command complete by C2H reg instead of done ack
      wifi: rtw89: disable RTW89_PHYSTS_IE09_FTR_0 for ppdu status
      wifi: rtw89: obtain RX path from ppdu status IE00
      wifi: rtw89: wow: enable TKIP related feature

Ching-Te Ku (1):
      wifi: rtw89: coex: Limit Wi-Fi scan slot cost to avoid A2DP glitch

Fedor Pchelkin (4):
      wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
      wifi: rtw89: avoid possible TX wait initialization race
      wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
      wifi: rtw89: avoid circular locking dependency in ser_state_run()

Felix Fietkau (11):
      wifi: mt76: mt7996: remove redundant per-phy mac80211 calls during restart
      wifi: mt76: mt7996: improve hardware restart reliability
      wifi: mt76: mt7996: decrease timeout for commonly issued MCU commands
      wifi: mt76: mt7996: fix setting beacon protection keys
      wifi: mt76: mt7996: fix memory leak on mt7996_mcu_sta_key_tlv error
      wifi: mt76: mt7996: delete vif keys when requested
      wifi: mt76: mt7996: fix key add/remove imbalance
      wifi: mt76: mt7996: fix updating beacon protection with beacons enabled
      wifi: mt76: use altx queue for offchannel tx on connac+
      wifi: mt76: improve phy reset on hw restart
      wifi: mt76: abort scan/roc on hw restart

Hari Chandrakanthan (1):
      wifi: ath12k: Fix peer lookup in ath12k_dp_mon_rx_deliver_msdu()

Howard Hsu (3):
      wifi: mt76: mt7996: support writing MAC TXD for AddBA Request
      wifi: mt76: mt7996: remove the mem_total field of STA_REC_BF command
      wifi: mt76: mt7996: fill User Priority in skb->priority for rx packets

Ilan Peer (10):
      wifi: cfg80211: Advertise supported NAN capabilities
      wifi: cfg80211: Support Tx/Rx of action frame for NAN
      wifi: cfg80211: Store the NAN cluster ID
      wifi: mac80211: Support Tx of action frame for NAN
      wifi: mac80211: Accept management frames on NAN interface
      wifi: mac80211: Track NAN interface start/stop
      wifi: mac80211: Get the correct interface for non-netdev skb status
      wifi: mac80211: Export an API to check if NAN is started
      wifi: mac80211: Extend support for changing NAN configuration
      wifi: mac80211_hwsim: Add simulation support for NAN device

Jack Kao (1):
      wifi: mt76: mt7925: add pci restore for hibernate

Johannes Berg (5):
      Merge tag 'mt76-next-2025-09-15' of https://github.com/nbd168/wireless
      wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
      Merge tag 'rtw-next-2025-09-22' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20250922' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Revert "wifi: libertas: WQ_PERCPU added to alloc_workqueue users"

Kang Yang (3):
      wifi: ath12k: fix signal in radiotap for WCN7850
      wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
      wifi: ath12k: fix the fetching of combined rssi

Kuan-Chung Chen (9):
      wifi: rtw89: introduce beacon tracking to improve connection stability
      wifi: rtw89: debug: add beacon_info debugfs
      wifi: rtw89: wow: remove notify during WoWLAN net-detect
      wifi: rtw89: 8851b: rfk: update IQK TIA setting
      wifi: rtw89: 8851b: rfk: update TX wideband IQK
      wifi: rtw89: fix BSSID comparison for non-transmitted BSSID
      wifi: rtw89: fix group frames loss when connected to non-transmitted BSSID
      wifi: rtw89: 8852b: enable beacon tracking support
      wifi: rtw89: 8922a: add TAS feature support

Lachlan Hodges (3):
      wifi: cfg80211: correctly implement and validate S1G chandef
      wifi: mac80211: correctly initialise S1G chandef for STA
      wifi: cfg80211: remove ieee80211_s1g_channel_width

Liao Yuanhong (3):
      wifi: rtw89: 8852bt: Simplify unnecessary if-else conditions in _dpk_onoff()
      wifi: rtw89: 8852bt: Remove redundant off_reverse variables
      wifi: ath11k: Remove redundant semicolon

Lingbo Kong (1):
      wifi: ath12k: report station mode per-chain signal strength

Loic Poulain (1):
      wifi: ath10k: Fix connection after GTK rekeying

Lorenzo Bianconi (22):
      wifi: mt76: mt7996: Overwrite unspecified link_id in mt7996_tx()
      wifi: mt76: mt7996: Fix mt7996_mcu_sta_ba wcid configuration
      wifi: mt76: mt7996: Fix mt7996_mcu_bss_mld_tlv routine
      wifi: mt76: mt7996: Set def_wcid pointer in mt7996_mac_sta_init_link()
      wifi: mt76: mt7996: Set proper link destination address in mt7996_tx()
      wifi: mt76: mt7996: Use deflink for AMPDU rx reordering
      wifi: mt76: Remove dead code in mt76_scan_work
      wifi: mt76: mt7996: Use proper link_id in link_sta_rc_update callback
      wifi: mt76: mt7996: Check phy before init msta_link in mt7996_mac_sta_add_links()
      wifi: mt76: mt7996: Use proper link info in mt7996_mcu_add_group
      wifi: mt76: mt7996: Add all active links to poll list in mt7996_mac_tx_free()
      wifi: mt76: mt7996: Set EML capabilities for AP interface
      wifi: mt76: mt7996: Enable MLO support for client interfaces
      wifi: mt76: Add reset_idx to reset_q mt76_queue_ops signature.
      wifi: mt76: Remove q->ndesc check in mt76_dma_rx_fill()
      wifi: mt76: Do not always enable NAPIs for WED RRO queues
      wifi: mt76: mt7996: Fix tx-queues initialization for second phy on mt7996
      wifi: mt76: mt7996: Fix RX packets configuration for primary WED device
      wifi: mt76: mt7996: Convert mt7996_wed_rro_addr to LE
      wifi: mt76: Add rx_queue_init callback
      wifi: mt76: Add mt76_dma_get_rxdmad_c_buf utility routione
      wifi: mt76: Convert mt76_wed_rro_ind to LE

Maharaja Kennadyrajan (2):
      wifi: ath12k: enhance the WMI_PEER_STA_KICKOUT event with reasons and RSSI reporting
      wifi: ath12k: Extend beacon miss handling for MLO non-AP STA

Manish Dharanenthiran (2):
      wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
      wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors

Marco Crivellari (2):
      wifi: libertas: WQ_PERCPU added to alloc_workqueue users
      wifi: libertas: add WQ_UNBOUND to alloc_workqueue users

Martin Kaistra (1):
      wifi: rtl8xxxu: expose efuse via debugfs

Matvey Kovalev (1):
      wifi: ath11k: fix NULL dereference in ath11k_qmi_m3_load()

Ming Yen Hsieh (3):
      wifi: mt76: mt7925: add MBSSID support
      wifi: mt76: mt7921: add MBSSID support
      wifi: mt76: mt7925: refine the txpower initialization flow

Muhammad Usama Anjum (1):
      wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Nick Morrow (2):
      wifi: mt76: mt7925u: Add VID/PID for Netgear A9000
      wifi: mt76: mt7921u: Add VID/PID for Netgear A7500

Nithyanantham Paramasivam (5):
      wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
      wifi: ath12k: Refactor RX TID deletion handling into helper function
      wifi: ath12k: Refactor RX TID buffer cleanup into helper function
      wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
      wifi: ath12k: Fix flush cache failure during RX queue update

Peter Chiu (2):
      wifi: mt76: mt7996: disable promiscuous mode by default
      wifi: mt76: mt7996: set VTA in txwi

Ping-Ke Shih (16):
      wifi: rtw88: sdio: use indirect IO for device registers before power-on
      wifi: rtw89: print just once for unknown C2H events
      wifi: rtw89: add dummy C2H handlers for BCN resend and update done
      wifi: rtw89: 8852c: update firmware crash trigger type for newer firmware
      wifi: rtw89: pci: move chip ISR definition out from chip generation
      wifi: rtw89: pci: prepare interrupt related registers and functions for 8922DE
      wifi: rtw89: pci: use RDU status of R_BE_PCIE_DMA_IMR_0_V1 instead for 8922DE
      wifi: rtw89: pci: add struct rtw89_{tx,rx}_rings to put related fields
      wifi: rtw89: pci: define TX/RX buffer descriptor pool
      wifi: rtw89: pci: add group BD address design
      wifi: rtw89: pci: abstract RPP parser
      wifi: rtw89: pci: add RPP parser v1
      wifi: rtw89: abstract getting function of DMA channel
      wifi: rtw89: add getting function of DMA channel v1
      wifi: rtw89: use ieee80211_tx_info::driver_data to store driver TX info
      wifi: rtw89: phy: initialize AFE by firmware element table

Po-Hao Huang (2):
      wifi: rtw89: 8852a: report per-channel noise level by get_survey ops
      wifi: rtw89: 8852a: report average RSSI to avoid unnecessary scanning

Qianfeng Rong (1):
      wifi: rtw89: use int type to store negative error codes

Quan Zhou (1):
      wifi: mt76: mt7921: Add 160MHz beamformee capability for mt7922 device

Rex Lu (8):
      wifi: mt76: Differentiate between RRO data and RRO MSDU queues
      wifi: mt76: mt7996: Initial DMA configuration for MT7992 WED support
      wifi: mt76: mt7996: Enable HW RRO for MT7992 chipset
      wifi: mt76: mt7996: Introduce the capability to reset MT7992 WED device
      wifi: mt76: mt7996: Enable WED for MT7992 chipset
      wifi: mt76: mt7996: Introduce RRO MSDU callbacks
      wifi: mt76: mt7996: Decouple RRO logic from WED support
      wifi: mt76: mt7996: Add SW path for HW-RRO v3.1

Rob Herring (Arm) (1):
      wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"

Roopni Devanathan (1):
      wifi: ath12k: Add support to set per-radio RTS threshold

Rosen Penev (1):
      wifi: mt76: mt76_eeprom_override to int

Ryder Lee (1):
      wifi: cfg80211: fix width unit in cfg80211_radio_chandef_valid()

Sarika Sharma (1):
      wifi: mac80211: remove tx_handlers_drop debugfs stats

Shayne Chen (3):
      wifi: mt76: mt7996: Fix mt7996_reverse_frag0_hdr_trans for MLO
      wifi: mt76: mt7996: Implement MLD address translation for EAPOL
      wifi: mt76: mt7996: Export MLO AP capabilities to mac80211

Sriram R (1):
      wifi: ath12k: Add fallback for invalid channel number in PHY metadata

Zenm Chen (2):
      wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
      wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1

Zhi-Jun You (1):
      wifi: mt76: mt7915: fix mt7981 pre-calibration

Zong-Zhe Yang (4):
      wifi: rtw89: chan: allow callers to check if a link has no managed chanctx
      wifi: rtw89: debug: support SER L0 simulation
      wifi: rtw89: renew a completion for each H2C command waiting C2H event
      wifi: rtw89: open C2H event waiting window first before sending H2C command

pengdonglin (1):
      wifi: mac80211: Remove redundant rcu_read_lock/unlock() in spin_lock

 drivers/net/wireless/ath/ath10k/leds.c             |   3 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  12 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |  14 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |  39 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |  17 +-
 drivers/net/wireless/ath/ath11k/ce.c               |   3 +-
 drivers/net/wireless/ath/ath11k/core.c             |   6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   1 -
 drivers/net/wireless/ath/ath11k/hal.c              |  16 +
 drivers/net/wireless/ath/ath11k/hal.h              |   1 +
 drivers/net/wireless/ath/ath11k/qmi.c              |  19 +-
 drivers/net/wireless/ath/ath12k/ce.c               |   5 +-
 drivers/net/wireless/ath/ath12k/core.h             |   7 +-
 drivers/net/wireless/ath/ath12k/debug.h            |   1 +
 drivers/net/wireless/ath/ath12k/dp.c               |   2 +
 drivers/net/wireless/ath/ath12k/dp.h               |  12 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  56 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            | 352 ++++++---
 drivers/net/wireless/ath/ath12k/dp_rx.h            |  18 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   1 +
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   1 +
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   3 +
 drivers/net/wireless/ath/ath12k/hal_rx.h           |  12 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 117 ++-
 drivers/net/wireless/ath/ath12k/mac.h              |   3 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  24 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |  16 +-
 drivers/net/wireless/ath/ath12k/wmi.c              | 158 +++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  33 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c    |   3 +-
 drivers/net/wireless/marvell/libertas/if_spi.c     |   3 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |   2 +
 drivers/net/wireless/mediatek/mt76/channel.c       |  13 +-
 drivers/net/wireless/mediatek/mt76/dma.c           | 231 ++++--
 drivers/net/wireless/mediatek/mt76/dma.h           |  29 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   9 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  59 ++
 drivers/net/wireless/mediatek/mt76/mt76.h          |  75 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |   5 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   7 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  25 +
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  29 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   3 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  67 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  28 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |  26 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   3 +
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   1 -
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 324 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 358 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 799 +++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 521 ++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 308 ++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  17 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  89 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 106 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  32 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |  13 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |   3 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |   8 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  27 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |   1 -
 drivers/net/wireless/realtek/rtw88/led.c           |  13 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   4 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  11 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |  10 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |   5 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 686 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h          | 150 +++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 125 +++-
 drivers/net/wireless/realtek/rtw89/debug.h         |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c            | 177 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  77 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  72 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  35 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   1 +
 drivers/net/wireless/realtek/rtw89/pci.c           | 466 +++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h           | 128 +++-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  18 +-
 drivers/net/wireless/realtek/rtw89/phy.c           | 476 +++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h           |  24 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   9 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |  56 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  | 157 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  46 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |  14 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   4 +
 drivers/net/wireless/realtek/rtw89/sar.c           |  15 +
 drivers/net/wireless/realtek/rtw89/sar.h           |   1 +
 drivers/net/wireless/realtek/rtw89/ser.c           |   5 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |  38 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  79 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   6 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      | 259 ++++++-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |   4 +-
 include/linux/ieee80211.h                          |  35 +-
 include/net/cfg80211.h                             | 248 ++++++-
 include/net/mac80211.h                             |  10 +
 include/uapi/linux/nl80211.h                       | 204 +++++-
 net/mac80211/cfg.c                                 | 142 +++-
 net/mac80211/debugfs.c                             |   3 -
 net/mac80211/debugfs_netdev.c                      |   2 -
 net/mac80211/debugfs_sta.c                         |   2 -
 net/mac80211/ieee80211_i.h                         |   8 +-
 net/mac80211/iface.c                               |  25 +-
 net/mac80211/main.c                                |  11 +-
 net/mac80211/mlme.c                                |  53 +-
 net/mac80211/offchannel.c                          |   5 +-
 net/mac80211/rate.c                                |  11 +-
 net/mac80211/rx.c                                  |  40 +-
 net/mac80211/scan.c                                |  13 +-
 net/mac80211/sta_info.c                            |   2 -
 net/mac80211/status.c                              |  21 +-
 net/mac80211/tx.c                                  |  14 +-
 net/mac80211/util.c                                |  47 +-
 net/wireless/chan.c                                | 103 ++-
 net/wireless/nl80211.c                             | 487 +++++++++++--
 net/wireless/reg.c                                 |  74 +-
 net/wireless/trace.h                               |  35 +
 net/wireless/util.c                                |  29 +-
 152 files changed, 7172 insertions(+), 1925 deletions(-)

