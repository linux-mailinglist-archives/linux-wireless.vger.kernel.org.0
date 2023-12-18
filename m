Return-Path: <linux-wireless+bounces-937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D948177B0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192711C22AF5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A951E484;
	Mon, 18 Dec 2023 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv5Y9q9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392E1DFCC;
	Mon, 18 Dec 2023 16:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C031DC433C9;
	Mon, 18 Dec 2023 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702917541;
	bh=NUNiBx67KuHfAVHX5fnhI9aJI+rvD1MXdZ8GTgDOhpY=;
	h=From:Subject:To:Cc:Date:From;
	b=mv5Y9q9sXWBjkUjvODF71ChdZGyyQKovK2tLQZiZ/XaZNpQEMzLcHx1cZUkCcVJr1
	 sIWi3hxVshtZAEuQCx0i69EFMs57K9TCtDFq3J9jqZZi6pMM1L+s6ryKZKsNdOtpm9
	 Plsjo+5vmZm0JPoR+K04sWChf/Ht0Q11ubmA18fObTlutPk93jJICxY2Sh6rigCCYm
	 MjAsu7UQ+TXsunaeaVONNhGIPWIjTCOa6N/ONI/t6J/WHN3VYeAvWN3SiOJvjInLjH
	 0SdxaIiMOd+zkRs+GO+pfbZ9h0n89EXts24aAhRg56s8DVYqIIjwqan+/XWTOtDdDX
	 IdMzccbs2Be3A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2023-12-18
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20231218163900.C031DC433C9@smtp.kernel.org>
Date: Mon, 18 Dec 2023 16:39:00 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit f9893fdac319bb2817e5e7818870264d7fb2eb02:

  net: page_pool: fix general protection fault in page_pool_unlist (2023-11-30 10:14:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2023-12-18

for you to fetch changes up to c5a3f56fcdb0a48a20772e4c9b8adc6c7256a461:

  Merge tag 'ath-next-20231215' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2023-12-17 13:20:18 +0200)

----------------------------------------------------------------
wireless-next patches for v6.8

The second features pull request for v6.8. A bigger one this time with
changes both to stack and drivers. We have a new Wifi band RFI (WBRF)
mitigation feature for which we pulled an immutable branch shared with
other subsystems. And, as always, other new features and bug fixes all
over.

Major changes:

cfg80211/mac80211

* AMD ACPI based Wifi band RFI (WBRF) mitigation feature

* Basic Service Set (BSS) usage reporting

* TID to link mapping support

* mac80211 hardware flag to disallow puncturing

iwlwifi

* new debugfs file fw_dbg_clear

mt76

* NVMEM EEPROM improvements

* mt7996 Extremely High Throughpu (EHT) improvements

* mt7996 Wireless Ethernet Dispatcher (WED) support

* mt7996 36-bit DMA support

ath12k

* support one MSI vector

* WCN7850: support AP mode

----------------------------------------------------------------
Allen Ye (2):
      wifi: mt76: use chainmask for power delta calculation
      wifi: mt76: connac: add beacon protection support for mt7996

Andrei Otcheretianski (2):
      wifi: mac80211: Replace ENOTSUPP with EOPNOTSUPP
      wifi: cfg80211: Replace ENOTSUPP with EOPNOTSUPP

Arnd Bergmann (2):
      wifi: mt76: mt7996: fix mt7996_mcu_all_sta_info_event struct packing
      wifi: rtw89: avoid stringop-overflow warning

Baochen Qiang (1):
      wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too early

Benjamin Berg (2):
      wifi: cfg80211: generate an ML element for per-STA profiles
      wifi: cfg80211: consume both probe response and beacon IEs

Benjamin Lin (3):
      wifi: mt76: mt7996: switch to mcu command for TX GI report
      wifi: mt76: mt7996: add DMA support for mt7992
      wifi: mt76: connac: add new definition of tx descriptor

Bo Jiao (1):
      wifi: mt76: mt7996: add wed rx support

Chia-Yuan Li (1):
      wifi: rtw89: 8922a: dump MAC registers when SER occurs

Chih-Kang Chang (2):
      wifi: rtw89: refine remain on channel flow to improve P2P connection
      wifi: rtw89: fix misbehavior of TX beacon in concurrent mode

Chris Morgan (1):
      wifi: rtw88: Use random MAC when efuse MAC invalid

Christian Marangi (6):
      wifi: mt76: fix broken precal loading from MTD for mt7915
      wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
      wifi: mt76: limit support of precal loading for mt7915 to MTD only
      wifi: mt76: make mt76_get_of_eeprom static again
      wifi: mt76: permit to use alternative cell name to eeprom NVMEM load
      wifi: mt76: permit to load precal from NVMEM cell for mt7915

David Lin (2):
      wifi: mwifiex: add extra delay for firmware ready
      wifi: mwifiex: configure BSSID consistently when starting AP

Dmitry Antipov (5):
      wifi: ath10k: simplify __ath10k_htt_tx_txq_recalc()
      wifi: mac80211: cleanup airtime arithmetic with ieee80211_sta_keep_active()
      wifi: mac80211: drop spurious WARN_ON() in ieee80211_ibss_csa_beacon()
      wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()
      wifi: rt2x00: remove useless code in rt2x00queue_create_tx_descriptor()

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: add a debugfs hook to clear the monitor data
      wifi: iwlwifi: mvm: do not send STA_DISABLE_TX_CMD for newer firmware

Evan Quan (2):
      wifi: cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
      wifi: mac80211: Add support for WBRF features

Gustavo A. R. Silva (1):
      wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings

Hancheng Yang (1):
      wifi: ath9k: reset survey of current channel after a scan started

Howard Hsu (4):
      wifi: mt76: mt7996: add TX statistics for EHT mode in debugfs
      wifi: mt76: connac: add thermal protection support for mt7996
      wifi: mt76: mt7996: add thermal sensor device support
      wifi: mt76: connac: set fixed_bw bit in TX descriptor for fixed rate frames

Ilan Peer (3):
      wifi: iwlwifi: mvm: Use the link ID provided in scan request
      wifi: iwlwifi: mvm: Correctly report TSF data in scan complete
      wifi: cfg80211: Add support for setting TID to link mapping

Ilpo Järvinen (11):
      bcma: Use PCI_HEADER_TYPE_MASK instead of literal
      wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
      wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
      wifi: rtlwifi: Convert to use PCIe capability accessors
      wifi: rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
      wifi: rtlwifi: rtl8821ae: Reverse PM Capability exists check
      wifi: rtlwifi: rtl8821ae: Use pci_find_capability()
      wifi: rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
      wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
      wifi: rtlwifi: Remove unused PCI related defines and struct
      wifi: rtlwifi: Remove bridge vendor/device ids

James Prestwood (3):
      wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
      wifi: ath12k: use select for CRYPTO_MICHAEL_MIC
      wifi: ath10k: add support to allow broadcast action frame RX

Jeff Johnson (14):
      wifi: ath10k: Remove unused struct ath10k_htc_frame
      wifi: ath11k: Remove struct ath11k::ops
      wifi: ath12k: Remove struct ath12k::ops
      wifi: ath11k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath12k: Remove obsolete struct wmi_peer_flags_map *peer_flags
      wifi: ath11k: Consolidate WMI peer flags
      wifi: ath12k: Consolidate WMI peer flags
      wifi: ath12k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath11k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath10k: Update Qualcomm Innovation Center, Inc. copyrights
      wifi: ath10k: remove ath10k_htc_record::pauload[]
      wifi: ath10k: Use DECLARE_FLEX_ARRAY() for ath10k_htc_record
      wifi: ath11k: remove ath11k_htc_record::pauload[]
      wifi: ath11k: Fix ath11k_htc_record flexible record

Jiri Slaby (SUSE) (1):
      wifi: ath5k: remove unused ath5k_eeprom_info::ee_antenna

Johannes Berg (14):
      wifi: nl80211: refactor nl80211_send_mlme_event() arguments
      wifi: cfg80211: make RX assoc data const
      Merge tag 'platform-drivers-x86-amd-wbrf-v6.8-1' into wireless-next
      wifi: iwlwifi: refactor RX tracing
      wifi: iwlwifi: pcie: clean up device removal work
      wifi: iwlwifi: pcie: dump CSRs before removal
      wifi: iwlwifi: pcie: get_crf_id() can be void
      wifi: iwlwifi: fw: file: don't use [0] for variable arrays
      wifi: iwlwifi: remove async command callback
      wifi: cfg80211: add BSS usage reporting
      wifi: mac80211: update some locking documentation
      wifi: mac80211: add a flag to disallow puncturing
      wifi: mac80211: don't set ESS capab bit in assoc request
      wifi: cfg80211: sort certificates in build

Justin Stitt (2):
      wifi: ath10k: replace deprecated strncpy with memcpy
      wifi: iwlwifi: fw: replace deprecated strncpy with strscpy_pad

Kalle Valo (3):
      Merge tag 'mt76-for-kvalo-2023-12-06' of https://github.com/nbd168/wireless
      wifi: ath11k: workaround too long expansion sparse warnings
      Merge tag 'ath-next-20231215' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Kang Yang (8):
      wifi: ath12k: get msi_data again after request_irq is called
      wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler
      wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ
      wifi: ath12k: refactor multiple MSI vector implementation
      wifi: ath12k: add support one MSI vector
      wifi: ath12k: do not restore ASPM in case of single MSI vector
      wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector
      wifi: ath12k: fix and enable AP mode for WCN7850

Karthikeyan Periyasamy (9):
      wifi: ath12k: fix the error handler of rfkill config
      wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
      wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
      wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
      wifi: ath12k: refactor DP Rxdma ring structure
      wifi: ath12k: Optimize the mac80211 hw data access
      wifi: ath12k: avoid repeated hw access from ar
      wifi: ath12k: avoid repeated wiphy access from hw
      Revert "wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP IRQ"

Kunwu Chan (1):
      wifi: iwlegacy: Add null pointer check to il_leds_init()

Lingbo Kong (1):
      wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850

Lorenzo Bianconi (13):
      wifi: mt76: mmio: move mt76_mmio_wed_{init,release}_rx_buf in common code
      wifi: mt76: move mt76_mmio_wed_offload_{enable,disable} in common code
      wifi: mt76: move mt76_net_setup_tc in common code
      wifi: mt76: introduce mt76_queue_is_wed_tx_free utility routine
      wifi: mt76: introduce wed pointer in mt76_queue
      wifi: mt76: increase MT_QFLAG_WED_TYPE size
      wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine
      wifi: mt76: mt7996: use u16 for val field in mt7996_mcu_set_rro signature
      wifi: mt76: move wed reset common code in mt76 module
      wifi: mt76: mt7996: add wed reset support
      wifi: mt76: mt7996: add wed rro delete session garbage collector
      wifi: mt76: mt7915: fallback to non-wed mode if platform_get_resource fails in mt7915_mmio_wed_init()
      wifi: mt76: mt7925: remove iftype from mt7925_init_eht_caps signature

Luca Weiss (1):
      wifi: ath11k: Defer on rproc_get failure

Lukas Bulwahn (1):
      wifi: libertas: fix config name in dependency for SDIO support

Ma Jun (2):
      Documentation/driver-api: Add document about WBRF mechanism
      platform/x86/amd: Add support for AMD ACPI based Wifi band RFI mitigation feature

Ma Ke (1):
      wifi: ath12k: drop NULL pointer check in ath12k_update_per_peer_tx_stats()

Martin Blumenstingl (1):
      wifi: rtw88: sdio: Honor the host max_req_size in the RX path

MeiChia Chiu (2):
      wifi: mt76: mt7996: fix rate usage of inband discovery frames
      wifi: mt76: connac: fix EHT phy mode check

Ming Yen Hsieh (3):
      wifi: mt76: mt7921: fix country count limitation for CLC
      wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
      wifi: mt76: mt7921: fix wrong 6Ghz power type

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Miri Korenblit (1):
      wifi: iwlwifi: don't support triggered EHT CQI feedback

Muna Sinada (1):
      wifi: ath12k: add 320 MHz bandwidth enums

Peter Chiu (4):
      wifi: mt76: mt7996: adjust WFDMA settings to improve performance
      wifi: mt76: mt7996: handle IEEE80211_RC_SMPS_CHANGED
      wifi: mt76: mt7996: align the format of fixed rate command
      wifi: mt76: mt7996: rework ampdu params setting

Ping-Ke Shih (24):
      wifi: rtw88: debug: remove wrapper of rtw_dbg()
      wifi: rtw89: debug: add to check if debug mask is enabled
      wifi: rtw89: debug: add debugfs entry to disable dynamic mechanism
      wifi: rtw89: debug: remove wrapper of rtw89_debug()
      wifi: rtw89: 8922a: extend and add quota number
      wifi: rtw89: mac: add to get DLE reserved quota
      wifi: rtw89: add reserved size as factor of DLE used size
      wifi: rtw89: mac: move code related to hardware engine to individual functions
      wifi: rtw89: mac: use pointer to access functions of hardware engine and quota
      wifi: rtw89: mac: functions to configure hardware engine and quota for WiFi 7 chips
      wifi: rtw89: 8922a: add SER IMR tables
      wifi: rtw89: mac: refine SER setting during WiFi CPU power on
      wifi: rtw89: fw: load TX power track tables from fw_element
      wifi: rtw89: fw: add version field to BB MCU firmware element
      wifi: rtw89: load RFK log format string from firmware file
      wifi: rtw89: add C2H event handlers of RFK log and report
      wifi: rtw89: parse and print out RFK log from C2H events
      wifi: rtw89: phy: print out RFK log with formatted string
      wifi: rtw89: add XTAL SI for WiFi 7 chips
      wifi: rtw89: 8922a: add power on/off functions
      wifi: rtw89: mac: add flags to check if CMAC and DMAC are enabled
      wifi: rtw89: mac: add suffix _ax to MAC functions
      wifi: rtw89: add DBCC H2C to notify firmware the status
      wifi: rtw89: only reset BB/RF for existing WiFi 6 chips while starting up

Po-Hao Huang (2):
      wifi: rtw89: fix not entering PS mode after AP stops
      wifi: rtw89: Refine active scan behavior in 6 GHz

Randy Dunlap (4):
      wifi: cfg80211: fix spelling & punctutation
      wifi: nl80211: fix grammar & spellos
      wifi: mac80211: rx.c: fix sentence grammar
      wifi: mac80211: sta_info.c: fix sentence grammar

Rong Yan (1):
      wifi: mt76: mt7921: support 5.9/6GHz channel config in acpi

Ryder Lee (1):
      wifi: mt76: add ability to explicitly forbid LED registration with DT

Sean Wang (1):
      wifi: mt76: mt7921: reduce the size of MCU firmware download Rx queue

Shayne Chen (4):
      wifi: mt76: mt7996: add support for variants with auxiliary RX path
      wifi: mt76: change txpower init to per-phy
      wifi: mt76: mt7996: add txpower setting support
      wifi: mt76: mt7996: introduce mt7996_band_valid()

Stanislaw Gruszka (1):
      wifi: rt2x00: make watchdog param per device

StanleyYP Wang (9):
      wifi: mt76: connac: add beacon duplicate TX mode support for mt7996
      wifi: mt76: mt7996: fix alignment of sta info event
      wifi: mt76: mt7915: fix EEPROM offset of TSSI flag on MT7981
      wifi: mt76: mt7915: also MT7981 is 3T3R but nss2 on 5 GHz band
      wifi: mt76: connac: add firmware support for mt7992
      wifi: mt76: mt7996: rework register offsets for mt7992
      wifi: mt76: mt7996: support mt7992 eeprom loading
      wifi: mt76: mt7996: adjust interface num and wtbl size for mt7992
      wifi: mt76: mt7996: add PCI IDs for mt7992

Su Hui (2):
      wifi: rtlwifi: rtl8821ae: phy: remove some useless code
      wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior

Sujuan Chen (3):
      wifi: mt76: mt7996: add wed tx support
      wifi: mt76: mt7996: fix the size of struct bss_rate_tlv
      wifi: mt76: mt7996: set DMA mask to 36 bits for boards with more than 4GB of RAM

Uwe Kleine-König (5):
      wifi: ath11k: Convert to platform remove callback returning void
      wifi: brcmfmac: Convert to platform remove callback returning void
      wifi: ath5k: Convert to platform remove callback returning void
      wifi: wcn36xx: Convert to platform remove callback returning void
      wifi: mt76: Convert to platform remove callback returning void

Vinayak Yadawad (1):
      wifi: nl80211: Extend del pmksa support for SAE and OWE security

Wang Zhao (1):
      wifi: mt76: mt7921s: fix workqueue problem causes STA association fail

Wu Yunchuan (2):
      wifi: ath9k: Remove unnecessary (void*) conversions
      wifi: mt76: Remove unnecessary (void*) conversions

Yang Li (2):
      wifi: ath11k: Remove unneeded semicolon
      wifi: rt2x00: Simplify bool conversion

Yi-Chen Chen (1):
      wifi: rtw89: phy: dynamically adjust EDCCA threshold

Yi-Chia Hsieh (1):
      wifi: mt76: mt7996: fix uninitialized variable in parsing txfree

Zong-Zhe Yang (4):
      wifi: rtw89: refine element naming used by queue empty check
      wifi: rtw89: mac: check queue empty according to chip gen
      wifi: rtw89: 8922a: configure CRASH_TRIGGER FW feature
      wifi: rtw89: fw: extend program counter dump for Wi-Fi 7 chip

 Documentation/driver-api/index.rst                 |    1 +
 Documentation/driver-api/wbrf.rst                  |   78 +
 drivers/bcma/driver_pci_host.c                     |    2 +-
 drivers/net/wireless/ath/ath10k/bmi.c              |    1 +
 drivers/net/wireless/ath/ath10k/ce.c               |    1 +
 drivers/net/wireless/ath/ath10k/core.c             |   17 +
 drivers/net/wireless/ath/ath10k/core.h             |    3 +-
 drivers/net/wireless/ath/ath10k/coredump.c         |    1 +
 drivers/net/wireless/ath/ath10k/coredump.h         |    1 +
 drivers/net/wireless/ath/ath10k/debug.c            |    1 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    1 +
 drivers/net/wireless/ath/ath10k/htc.c              |    1 +
 drivers/net/wireless/ath/ath10k/htc.h              |   20 +-
 drivers/net/wireless/ath/ath10k/htt.h              |    1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    1 +
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    4 +-
 drivers/net/wireless/ath/ath10k/hw.c               |    1 +
 drivers/net/wireless/ath/ath10k/hw.h               |    4 +
 drivers/net/wireless/ath/ath10k/mac.c              |   17 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    1 +
 drivers/net/wireless/ath/ath10k/pci.h              |    1 +
 drivers/net/wireless/ath/ath10k/qmi.c              |    1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c     |    1 +
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |    1 +
 drivers/net/wireless/ath/ath10k/rx_desc.h          |    1 +
 drivers/net/wireless/ath/ath10k/sdio.c             |    1 +
 drivers/net/wireless/ath/ath10k/thermal.c          |    1 +
 drivers/net/wireless/ath/ath10k/usb.h              |    1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |    1 +
 drivers/net/wireless/ath/ath10k/wmi.c              |    1 +
 drivers/net/wireless/ath/ath10k/wmi.h              |    1 +
 drivers/net/wireless/ath/ath10k/wow.c              |    1 +
 drivers/net/wireless/ath/ath11k/Kconfig            |    2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   10 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    2 +-
 drivers/net/wireless/ath/ath11k/ce.h               |    1 +
 drivers/net/wireless/ath/ath11k/core.h             |    1 -
 drivers/net/wireless/ath/ath11k/dbring.c           |    1 +
 drivers/net/wireless/ath/ath11k/dbring.h           |    1 +
 drivers/net/wireless/ath/ath11k/debug.c            |    1 +
 drivers/net/wireless/ath/ath11k/debug.h            |    2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    1 +
 drivers/net/wireless/ath/ath11k/debugfs.h          |    1 +
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |    2 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |    2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |    1 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.h      |    1 +
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    1 +
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.h            |    1 +
 drivers/net/wireless/ath/ath11k/fw.c               |    2 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    2 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h         |    1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    1 +
 drivers/net/wireless/ath/ath11k/hal_rx.h           |    1 +
 drivers/net/wireless/ath/ath11k/hif.h              |    1 +
 drivers/net/wireless/ath/ath11k/htc.c              |    1 +
 drivers/net/wireless/ath/ath11k/htc.h              |    6 +-
 drivers/net/wireless/ath/ath11k/hw.c               |    2 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   16 +-
 drivers/net/wireless/ath/ath11k/mac.h              |    1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    1 +
 drivers/net/wireless/ath/ath11k/pcic.c             |    6 +-
 drivers/net/wireless/ath/ath11k/peer.c             |    2 +-
 drivers/net/wireless/ath/ath11k/peer.h             |    2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    2 +-
 drivers/net/wireless/ath/ath11k/reg.c              |    1 +
 drivers/net/wireless/ath/ath11k/reg.h              |    1 +
 drivers/net/wireless/ath/ath11k/rx_desc.h          |    1 +
 drivers/net/wireless/ath/ath11k/spectral.c         |    1 +
 drivers/net/wireless/ath/ath11k/spectral.h         |    1 +
 drivers/net/wireless/ath/ath11k/thermal.c          |    1 +
 drivers/net/wireless/ath/ath11k/thermal.h          |    1 +
 drivers/net/wireless/ath/ath11k/trace.h            |    1 +
 drivers/net/wireless/ath/ath11k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   63 +-
 drivers/net/wireless/ath/ath11k/wow.h              |    1 +
 drivers/net/wireless/ath/ath12k/Kconfig            |    2 +-
 drivers/net/wireless/ath/ath12k/core.c             |    6 +-
 drivers/net/wireless/ath/ath12k/core.h             |    5 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |    2 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    2 +-
 drivers/net/wireless/ath/ath12k/dp.c               |    6 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   13 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   15 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  153 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    2 +-
 drivers/net/wireless/ath/ath12k/hal.c              |    6 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |    2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |    3 +-
 drivers/net/wireless/ath/ath12k/hif.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hw.c               |    5 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  190 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    3 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |   18 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  174 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    4 +-
 drivers/net/wireless/ath/ath12k/peer.h             |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    2 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   21 +-
 drivers/net/wireless/ath/ath12k/reg.h              |    4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   64 +-
 drivers/net/wireless/ath/ath5k/ahb.c               |    8 +-
 drivers/net/wireless/ath/ath5k/eeprom.h            |    3 -
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |    2 +-
 drivers/net/wireless/ath/ath9k/common-init.c       |    2 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |   36 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |    5 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |    2 +-
 drivers/net/wireless/ath/ath9k/init.c              |   12 +-
 drivers/net/wireless/ath/ath9k/link.c              |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |   15 +
 drivers/net/wireless/ath/ath9k/pci.c               |    6 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    6 +-
 drivers/net/wireless/intel/iwlegacy/common.c       |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   18 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |    1 +
 .../net/wireless/intel/iwlwifi/iwl-devtrace-data.h |   15 +-
 .../wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h  |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c  |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h  |   21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   11 -
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |    4 -
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   16 +
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    7 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   13 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   31 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   47 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   34 +-
 drivers/net/wireless/marvell/libertas/Kconfig      |    2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +
 drivers/net/wireless/marvell/mwifiex/fw.h          |    1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |    1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   19 +
 drivers/net/wireless/marvell/mwifiex/sdio.h        |    2 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     |    8 +
 drivers/net/wireless/mediatek/mt76/dma.c           |  266 ++-
 drivers/net/wireless/mediatek/mt76/dma.h           |   54 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   22 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   60 +-
 drivers/net/wireless/mediatek/mt76/mmio.c          |  108 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |  105 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    8 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |    7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |    5 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |    5 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |   46 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   21 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |  118 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   38 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    6 +
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |   53 +
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |    2 +
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  400 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |   38 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h |    3 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  520 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  219 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   89 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  640 +++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  253 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  293 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  160 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   81 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  182 +-
 drivers/net/wireless/mediatek/mt76/sdio.c          |   18 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   15 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c    |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c   |    3 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  100 +-
 drivers/net/wireless/realtek/rtlwifi/pci.h         |   24 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   76 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |   16 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |    6 +-
 drivers/net/wireless/realtek/rtw88/debug.h         |    6 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    5 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |   35 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |    8 +
 drivers/net/wireless/realtek/rtw89/core.c          |   12 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   86 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   70 +-
 drivers/net/wireless/realtek/rtw89/debug.h         |   18 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  175 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |  154 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  834 +++++---
 drivers/net/wireless/realtek/rtw89/mac.h           |  146 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  765 ++++++-
 drivers/net/wireless/realtek/rtw89/pci.c           |   22 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    4 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  511 ++++-
 drivers/net/wireless/realtek/rtw89/phy.h           |   33 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    4 +
 drivers/net/wireless/realtek/rtw89/reg.h           | 2234 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   22 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   22 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   22 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   22 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  347 +++
 drivers/net/wireless/realtek/rtw89/ser.c           |   10 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |    7 +-
 drivers/net/wireless/silabs/wfx/sta.c              |   42 +-
 drivers/platform/x86/amd/Kconfig                   |   14 +
 drivers/platform/x86/amd/Makefile                  |    1 +
 drivers/platform/x86/amd/wbrf.c                    |  317 +++
 include/linux/acpi_amd_wbrf.h                      |   91 +
 include/net/cfg80211.h                             |   99 +-
 include/net/mac80211.h                             |   23 +-
 include/uapi/linux/nl80211.h                       |  136 +-
 net/mac80211/Makefile                              |    2 +
 net/mac80211/cfg.c                                 |    4 +-
 net/mac80211/chan.c                                |   13 +-
 net/mac80211/debugfs.c                             |    1 +
 net/mac80211/driver-ops.h                          |    2 +-
 net/mac80211/ibss.c                                |    2 +-
 net/mac80211/ieee80211_i.h                         |   20 +-
 net/mac80211/main.c                                |    2 +
 net/mac80211/mesh_hwmp.c                           |    2 +-
 net/mac80211/mesh_pathtbl.c                        |    8 +-
 net/mac80211/mlme.c                                |   25 +-
 net/mac80211/rx.c                                  |    4 +-
 net/mac80211/scan.c                                |    4 +-
 net/mac80211/sta_info.c                            |    8 +-
 net/mac80211/sta_info.h                            |    2 +-
 net/mac80211/tdls.c                                |   18 +-
 net/mac80211/tx.c                                  |    7 +-
 net/mac80211/wbrf.c                                |   95 +
 net/wireless/Makefile                              |    4 +-
 net/wireless/chan.c                                |    3 +-
 net/wireless/core.h                                |    3 +
 net/wireless/mlme.c                                |    2 +-
 net/wireless/nl80211.c                             |  289 ++-
 net/wireless/nl80211.h                             |    2 +-
 net/wireless/rdev-ops.h                            |   26 +-
 net/wireless/scan.c                                |  108 +-
 net/wireless/trace.h                               |   22 +-
 292 files changed, 10710 insertions(+), 2093 deletions(-)
 create mode 100644 Documentation/driver-api/wbrf.rst
 create mode 100644 drivers/platform/x86/amd/wbrf.c
 create mode 100644 include/linux/acpi_amd_wbrf.h
 create mode 100644 net/mac80211/wbrf.c


