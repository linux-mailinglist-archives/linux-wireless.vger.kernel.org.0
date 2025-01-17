Return-Path: <linux-wireless+bounces-17666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE51A158AB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 21:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD8A164158
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D01A8F6B;
	Fri, 17 Jan 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfjxwRcl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8713C9D4;
	Fri, 17 Jan 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146130; cv=none; b=sjYT8tE6gA+RGxJJ0w8FdzKfg5vbKRRDtowKLIHAsfGpjhKQd7sdTfFItR7q1dBz9vOmOeqW6n5mAcMxNyT7ZdKawIfYd/S6vr/Hd9c86tq5G7x9EVF1ZHjMDhoiztQJe0X0DCQIDPzHeJEEazWYFpoTefKU54rHDXZcRjcGqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146130; c=relaxed/simple;
	bh=oiM5L0RRYzejKhfBE03c6+Yb/erJJFJ9jmMBum3e8II=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=Ywct/vNYcRf/r0xnjloVjY3A60yN4GXcug8gHJ+PlHg4HNqCAyJWtY1Hm07c/Zrs0NMMqB+43Jx7rcbYEhP9zZn6sl+27+rQCmdoxOBjleCz57tm+lBTufqO2qzLSr57BVGveIxufeVHNr4doDoaJS2qU1B+Qfkp6u5meHlD/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfjxwRcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D45C4CEDD;
	Fri, 17 Jan 2025 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737146130;
	bh=oiM5L0RRYzejKhfBE03c6+Yb/erJJFJ9jmMBum3e8II=;
	h=From:Subject:To:Cc:Date:From;
	b=gfjxwRclAUoXyDe/KgKOLjGYRu6/e6f8DDOxYc1Col8x+q2CRKC3Fcgt/tMnZ2JtO
	 e97+VVqnLtMicfgaj4cBNjMvOQ17cm9CZiDdVzNnIZkgVc8YQpBhkReu3LyuwOy9iN
	 DCkT8nvg4m7tmQMLUuVLhv3cqJXIJ/Xvsffujg/wKXPc8ToI3LQ/6DJCtQ8AyttI00
	 Pmz1Xux+8yN8kM/RAYHR9rWRksfLjZMlc2VNLbgj2ZrcD78Hg2I2yevFECLDbDkrpP
	 0ezwdyofFFiZWqMQyVcpApmPj6y2nbjclfiN9poYrgTBgmvJAQfMomOW4sLr7PphdA
	 QCRO1iTdktL+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2025-01-17
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20250117203529.72D45C4CEDD@smtp.kernel.org>
Date: Fri, 17 Jan 2025 20:35:29 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 7b24f164cf005b9649138ef6de94aaac49c9f3d1:

  Merge tag 'ipsec-next-2025-01-09' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next (2025-01-10 09:15:17 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-01-17

for you to fetch changes up to 68abd0c4ebf24cd499841a488b97a6873d5efabb:

  wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize() (2025-01-16 21:26:30 +0200)

----------------------------------------------------------------
wireless-next patches for v6.14

Most likely the last "new features" pull request for v6.14 and this is
a bigger one. Multi-Link Operation (MLO) work continues both in stack
in drivers. Few new devices supported and usual fixes all over.

Major changes:

cfg80211

* Emergency Preparedness Communication Services (EPCS) station mode support

mac80211

* an option to filter a sta from being flushed

* some support for RX Operating Mode Indication (OMI) power saving

* support for adding and removing station links for MLO

iwlwifi

* new device ids

* rework firmware error handling and restart

rtw88

* RTL8812A: RFE type 2 support

* LED support

rtw89

* variant info to support RTL8922AE-VS

mt76

* mt7996: single wiphy multiband support (preparation for MLO)

* mt7996: support for more variants

* mt792x: P2P_DEVICE support

* mt7921u: TP-Link TXE50UH support

ath12k

* enable MLO for QCN9274 (although it seems to be broken with dual
  band devices)

* MLO radar detection support

* debugfs: transmit buffer OFDMA, AST entry and puncture stats

----------------------------------------------------------------
Aditya Kumar Singh (14):
      wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()
      wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large allocations
      wifi: ath12k: fix ar->supports_6ghz usage during hw register
      wifi: ath12k: pass link ID during MLO while delivering skb
      wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan
      wifi: ath12k: add can_activate_links mac operation
      wifi: ath12k: add no-op without debug print in WMI Rx event
      wifi: ath12k: remove warning print in htt mlo offset event message
      wifi: ath12k: add ATH12K_FW_FEATURE_MLO capability firmware feature
      wifi: ath12k: assign unique hardware link IDs during QMI host cap
      wifi: ath12k: rename CAC_RUNNING flag
      wifi: ath12k: fix CAC running state during virtual interface start
      wifi: ath12k: handle radar detection with MLO
      wifi: ath12k: fix key cache handling

Alexis Lothoré (2):
      wifi: wilc1000: unregister wiphy only if it has been registered
      wifi: wilc1000: unregister wiphy only after netdev registration

Allan Wang (2):
      wifi: mt76: introduce mt792x_config_mac_addr_list routine
      wifi: mt76: mt7921: add rfkill_poll for hardware rfkill

Andreas Kemnade (1):
      wifi: wlcore: fix unbalanced pm_runtime calls

Andy Strohman (1):
      wifi: mac80211: fix tid removal during mesh forwarding

Anjaneyulu (7):
      wifi: iwlwifi: mvm: update documentation for iwl_nvm_channel_flags
      wifi: iwlwifi: mvm: add UHB canada support in TAS_CONFIG cmd
      wifi: iwlwifi: mvm: add UHB canada support in GET_TAS_STATUS cmd resp
      wifi: iwlwifi: add WIKO to PPAG approved list
      wifi: iwlwifi: extend TAS_CONFIG cmd support for v5
      wifi: iwlwifi: mvm: handle version 3 GET_TAS_STATUS notification
      wifi: iwlwifi: mvm: remove unused tas_rsp variable

Ariel Otilibili (1):
      wifi: rt2x00: Remove unused rfval values

Baochen Qiang (1):
      wifi: ath12k: fix leaking michael_mic for non-primary links

Ben Greear (2):
      wifi: mt76: mt7996: Add eht radiotap tlv
      wifi: mt76: Fix EHT NSS radiotap reporting.

Benjamin Berg (13):
      wifi: iwlwifi: mvm: log error for failures after D3
      wifi: iwlwifi: mvm: skip short statistics window when updating EMLSR
      wifi: mac80211: Remove unused basic_rates variable
      wifi: mac80211: fix typo in HE MCS check
      wifi: mac80211: log link information in ieee80211_determine_chan_mode
      wifi: mac80211: skip all known membership selectors
      wifi: mac80211: parse BSS selectors and unknown rates
      wifi: nl80211: permit userspace to pass supported selectors
      wifi: mac80211: verify BSS membership selectors and basic rates
      wifi: mac80211: also verify requirements in EXT_SUPP_RATES
      wifi: mac80211: tests: add utility to create sdata skeleton
      wifi: mac80211: pass correct link ID on assoc
      wifi: mac80211: set key link ID to the deflink one

Benjamin Lin (2):
      wifi: mt76: mt7996: fix incorrect indexing of MIB FW event
      wifi: mt76: mt7996: fix definition of tx descriptor

Bhagavathi Perumal S (1):
      wifi: ath12k: Add MLO WMI setup and teardown functions

Bitterblue Smith (10):
      wifi: rtlwifi: rtl8821ae: Fix media status report
      wifi: rtw88: 8812a: Support RFE type 2
      wifi: rtw88: 8821a/8812a: Set ptct_efuse_size to 0
      wifi: rtw88: usb: Copy instead of cloning the RX skb
      wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()
      wifi: rtw88: usb: Preallocate and reuse the RX skbs
      wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
      wifi: rtw88: Add USB PHY configuration
      wifi: rtw88: Delete rf_type member of struct rtw_sta_info
      wifi: rtw88: Add support for LED blinking

Chad Monroe (2):
      wifi: mt76: mt7915: exclude tx backoff time from airtime
      wifi: mt76: mt7996: exclude tx backoff time from airtime

Charles Han (1):
      wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links

Chih-Kang Chang (2):
      wifi: rtw89: adjust thermal protection step and more RTL8852BE-VT ID
      wifi: rtw89: avoid to init mgnt_entry list twice when WoWLAN failed

Chin-Yen Lee (1):
      wifi: rtw89: pci: disable PCI completion timeout control

Christophe JAILLET (1):
      wifi: mt76: mt7915: Fix an error handling path in mt7915_add_interface()

Colin Ian King (1):
      wifi: ath12k: Fix spelling mistake "requestted" -> "requested"

Dan Carpenter (3):
      wifi: ath12k: Off by one in ath12k_wmi_process_csa_switch_count_event()
      wifi: mt76: mt7925: fix off by one in mt7925_load_clc()
      wifi: mac80211: fix memory leak in ieee80211_mgd_assoc_ml_reconf()

Daniel Gabay (6):
      wifi: iwlwifi: Remove mvm prefix from iwl_mvm_compressed_ba_notif
      wifi: iwlwifi: mvm: Check BAR packet size before accessing data
      wifi: iwlwifi: mvm: Use IWL_FW_CHECK() for BAR notif size validation
      wifi: iwlwifi: mvm: Move TSO code to shared utility
      wifi: iwlwifi: Remove MVM prefix from TX API macros
      wifi: iwlwifi: mvm: don't count mgmt frames as MPDU

Deming Wang (1):
      wifi: iwlwifi: api: remove the double word

Dmitry Antipov (5):
      wifi: ath9k: cleanup ath_txq_skb_done()
      wifi: ath9k: cleanup a few (mostly) TX-related routines
      wifi: ath9k: simplify internal time management
      wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
      wifi: cfg80211: adjust allocation of colocated AP data

Dr. David Alan Gilbert (4):
      wifi: iwlegacy: Remove unused il3945_calc_db_from_ratio()
      wifi: iwlegacy: Remove unused il_get_single_channel_number()
      wifi: mac80211: Clean up debugfs_key deadcode
      wifi: mac80211: Remove unused ieee80211_smps_is_restrictive

Emmanuel Grumbach (9):
      wifi: iwlwifi: add a new NMI type
      wifi: iwlwifi: mvm: rename iwl_dev_tx_power_common::mac_context_id
      wifi: iwlwifi: move fw_ver debugfs to firmware runtime
      wifi: iwlwifi: move fw_dbg_collect to fw debugfs
      wifi: iwlwifi: cleanup unused variable in trans.h
      wifi: iwlwifi: mvm: remove unneeded NULL pointer checks
      wifi: mac80211: remove an unneeded check in Rx
      wifi: mac80211: improve stop/wake queue tracing
      wifi: iwlwifi: get the max number of links from the firmware

Eric-SY Chang (1):
      wifi: mt76: mt7925: fix wrong band_idx setting when enable sniffer mode

Felix Fietkau (37):
      wifi: mt76: remove mt76_calculate_default_rate()
      wifi: mt76: mt7996: remove phy->monitor_vif
      wifi: mt76: mt7915: fix slot time for 5/6GHz
      wifi: mt76: mt7915: fix eifs value on older chipsets
      wifi: mt76: mt7996: fix rx filter setting for bfee functionality
      wifi: mt76: mt7915: reduce the number of command retries
      wifi: mt76: mt7915: decrease timeout for commonly issued MCU commands
      wifi: mt76: only enable tx worker after setting the channel
      wifi: mt76: mt7915: ensure that only one sta entry is active per mac address
      wifi: mt76: mt7915: hold dev->mutex while interacting with the thermal state
      wifi: mt76: mt7915: firmware restart on devices with a second pcie link
      wifi: mt76: mt7915: fix omac index assignment after hardware reset
      wifi: mt76: mt7996: use mac80211 .sta_state op
      wifi: mt76: do not add wcid entries to sta poll list during MCU reset
      wifi: mt76: add code for emulating hardware scanning
      wifi: mt76: add support for allocating a phy without hw
      wifi: mt76: rename struct mt76_vif to mt76_vif_link
      wifi: mt76: add vif link specific data structure
      wifi: mt76: mt7996: split link specific data from struct mt7996_vif
      wifi: mt76: initialize more wcid fields mt76_wcid_init
      wifi: mt76: add chanctx functions for multi-channel phy support
      wifi: mt76: remove dev->wcid_phy_mask
      wifi: mt76: add multi-radio support to a few core hw ops
      wifi: mt76: add multi-radio support to tx scheduling
      wifi: mt76: add multi-radio support to scanning code
      wifi: mt76: add multi-radio remain_on_channel functions
      wifi: mt76: mt7996: use emulated hardware scan support
      wifi: mt76: mt7996: pass wcid to mt7996_mcu_sta_hdr_trans_tlv
      wifi: mt76: mt7996: prepare mt7996_mcu_add_dev/bss_info for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_add_beacon for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_set_tx for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_set_timing for MLO support
      wifi: mt76: connac: prepare mt76_connac_mcu_sta_basic_tlv for MLO support
      wifi: mt76: mt7996: prepare mt7996_mcu_update_bss_color for MLO support
      wifi: mt76: mt7996: move all debugfs files to the primary phy
      wifi: mt76: mt7996: switch to single multi-radio wiphy
      wifi: mt76: mt7996: fix monitor mode

Fiona Klute (1):
      wifi: rtw88: sdio: Fix disconnection after beacon loss

Gan Jie (1):
      wifi: iwlwifi: fw: fix typo 'adderss'

Hao Zhang (1):
      wifi: mt76: mt792x: add P2P_DEVICE support

Howard Hsu (4):
      wifi: mt76: mt7996: fix the capability of reception of EHT MU PPDU
      wifi: mt76: mt7996: fix HE Phy capability
      wifi: mt76: connac: adjust phy capabilities based on band constraints
      wifi: mt76: mt7996: add implicit beamforming support for mt7992

Ilan Peer (9):
      wifi: ieee80211: Add some missing MLO related definitions
      wifi: nl80211: Split the links handling of an association request
      wifi: cfg80211: Add support for dynamic addition/removal of links
      wifi: mac80211: Refactor adding association elements
      wifi: mac80211: Pull link space calculation to a function
      wifi: mac80211: Support dynamic link addition and removal
      wifi: cfg80211: Add support for controlling EPCS
      wifi: mac80211: Fix common size calculation for ML element
      wifi: mac80211: Support parsing EPCS ML element

Jason Wang (1):
      wifi: iwlwifi: mvm: Fix duplicated 'if' in comment

Jeff Johnson (5):
      wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
      wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
      wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
      wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage
      wifi: brcmfmac: Add missing Return: to function documentation

Jilin Yuan (1):
      wifi: iwlwifi: fw: fix repeated words in comments

Johannes Berg (38):
      wifi: iwlwifi: differentiate NIC error types
      wifi: iwlwifi: mvm: remove warning on unallocated BAID
      wifi: iwlwifi: fw: read STEP table from correct UEFI var
      wifi: iwlwifi: context-info: add kernel-doc markers
      wifi: iwlwifi: return ERR_PTR from opmode start()
      wifi: iwlwifi: restrict driver retry loops to timeouts
      wifi: iwlwifi: mvm: restrict MAC start retry to timeouts
      wifi: iwlwifi: mvm: remove STARTING state
      wifi: iwlwifi: mvm: clean up FW restart a bit
      wifi: iwlwifi: unify cmd_queue_full() into nic_error()
      wifi: iwlwifi: mvm: restart device through NMI
      wifi: iwlwifi: rework firmware error handling
      wifi: iwlwifi: iwl_fw_error_collect() is always called sync
      wifi: iwlwifi: rename bits in config/boot control register
      wifi: iwlwifi: iwl-drv: refactor image loading a bit
      wifi: iwlwifi: mvm: fix add stream vs. restart race
      wifi: iwlwifi: fw: api: tdls: remove MVM_ from name
      wifi: iwlwifi: mvm: fix AP STA comparison
      wifi: mac80211: add some support for RX OMI power saving
      wifi: mac80211: reject per-band vendor elements with MLO
      wifi: mac80211: mlme: improve messages from config_bw()
      wifi: cfg80211: scan: skip duplicate RNR entries
      wifi: cfg80211: check extended MLD capa/ops in assoc
      wifi: mac80211: prohibit deactivating all links
      wifi: iwlwifi: pcie: check for WiAMT/CSME presence
      wifi: iwlwifi: implement product reset for TOP errors
      wifi: iwlwifi: implement reset escalation
      wifi: iwlwifi: mvm: improve/fix chanctx min_def use logic
      wifi: iwlwifi: config: unify fw/pnvm MODULE_FIRMWARE
      wifi: iwlwifi: mvm: support EMLSR on WH/PE
      wifi: iwlwifi: remove Mr/Ms radio
      wifi: iwlwifi: pcie: make _iwl_trans_pcie_gen2_stop_device() static
      wifi: iwlwifi: pcie: make iwl_pcie_d3_complete_suspend() static
      wifi: nl80211: simplify nested if checks
      wifi: iwlwifi: simplify nested if checks
      wifi: mac80211: don't flush non-uploaded STAs
      wifi: mac80211: ibss: stop transmit when merging IBSS
      wifi: mac80211: ibss: mark IBSS left before leaving

Juan José Arboleda (1):
      wifi: iwlwifi: mvm: Improve code style in pointer declarations

Kalle Valo (3):
      Merge tag 'rtw-next-2025-01-12' of https://github.com/pkshih/rtw
      Merge tag 'mt76-for-kvalo-2025-01-14' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20250114' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Karthikeyan Periyasamy (23):
      wifi: ath12k: send partner device details in QMI MLO capability
      wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
      wifi: ath12k: add support to allocate MLO global memory region
      wifi: ath12k: enable MLO setup and teardown from core
      wifi: ath12k: avoid redundant code in DP Rx error process
      wifi: ath12k: move to HW link id based receive handling
      wifi: ath12k: add partner device buffer support in receive data path
      wifi: ath12k: add helper function to init partner cmem configuration
      wifi: ath12k: introduce interface combination cleanup helper
      wifi: ath12k: Refactor radio frequency information
      wifi: ath12k: advertise multi device interface combination
      wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
      wifi: ath12k: Refactor monitor status TLV structure
      wifi: ath12k: cleanup Rx peer statistics structure
      wifi: ath12k: Fix the misspelled of hal TLV tag HAL_PHYRX_GENERICHT_SIG
      wifi: ath12k: fix incorrect TID updation in DP monitor status path
      wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
      wifi: ath12k: Change the Tx monitor SRNG ring ID
      wifi: ath12k: Avoid explicit type cast in monitor status parse handler
      wifi: ath12k: Refactor ath12k_hw set helper function argument
      wifi: ath12k: Refactor the ath12k_hw get helper function argument
      wifi: ath12k: Remove ath12k_get_num_hw() helper function
      wifi: ath12k: Fix uninitialized variable access in ath12k_mac_allocate() function

Kavita Kavita (1):
      wifi: cfg80211: skip regulatory for punctured subchannels

Kees Cook (1):
      wifi: cfg80211: Move cfg80211_scan_req_add_chan() n_channels increment earlier

Leon Yen (4):
      wifi: mt76: mt7921s: fix a potential firmware freeze during startup
      wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO
      wifi: mt76: mt7921: introduce CSA support
      wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain

Marcel Hamer (1):
      wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()

Michael Lo (2):
      wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.
      wifi: mt76: mt7925: config the dwell time by firmware

Michael-CY Lee (2):
      wifi: cfg80211: copy multi-link element from the multi-link probe request's frame body to the generated elements
      wifi: mt76: mt7996: fix beacon command during disabling

Ming Yen Hsieh (15):
      wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
      wifi: mt76: mt7925: fix the invalid ip address for arp offload
      wifi: mt76: mt7925: Fix incorrect MLD address in bss_mld_tlv for MLO support
      wifi: mt76: mt7925: Fix incorrect WCID assignment for MLO
      wifi: mt76: mt7925: fix wrong parameter for related cmd of chan info
      wifi: mt76: mt7925: Enhance mt7925_mac_link_bss_add to support MLO
      wifi: mt76: Enhance mt7925_mac_link_sta_add to support MLO
      wifi: mt76: mt7925: Update mt7925_mcu_sta_update for BC in ASSOC state
      wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA
      wifi: mt76: mt7925: Update mt7925_unassign_vif_chanctx for per-link BSS
      wifi: mt76: mt7925: Update secondary link PS flow
      wifi: mt76: mt7925: Init secondary link PM state
      wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO
      wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
      wifi: mt76: mt7925: Properly handle responses for commands with events

Minjie Du (1):
      wifi: iwlwifi: Remove a duplicate assignment in iwl_dbgfs_amsdu_len_write()

Miri Korenblit (19):
      wifi: iwlwifi: mvm: remove pre-mld code from mld path
      wifi: iwlwifi: mvm: send the right link id
      wifi: mac80211: add an option to filter a sta from being flushed
      wifi: mac80211: change disassoc sequence a bit
      wifi: iwlwifi: mvm: cleanup iwl_mvm_sta_del
      wifi: iwlwifi: bump FW API to 95 for BZ/SC devices
      wifi: iwlwifi: support BIOS override for UNII4 in CA/US also in LARI versions < 12
      wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8
      wifi: iwlwifi: mld: make iwl_mvm_find_ie_offset a iwlwifi util
      wifi: iwlwifi: mark that we support TX_CMD_API_S_VER_10
      wifi: iwlwifi: avoid memory leak
      wifi: iwlwifi: bump FW API to 96 for BZ/SC devices
      wifi: iwlwifi: mvm: avoid NULL pointer dereference
      wifi: iwlwifi: mvm: fix iwl_ssid_exist() check
      wifi: iwlwifi: mvm: Use helper function IS_ERR_OR_NULL()
      wifi: iwlwifi: mvm: Fix duplicated 'the' in comment
      wifi: mac80211: clarify key idx documententaion
      wifi: iwlwifi: rename iwl_datapath_monitor_notif::mac_id to link_id
      wifi: mac80211: avoid double free in auth/assoc timeout

Nick Morrow (1):
      wifi: mt76: mt7921u: Add VID/PID for TP-Link TXE50UH

Nicolas Cavallari (1):
      wifi: mt76: mt7915: Fix mesh scan on MT7916 DBDC

Nicolas Escande (1):
      wifi: nl80211: fix nl80211_start_radar_detection return value

P Praneesh (1):
      wifi: ath12k: Add support for parsing 64-bit TLVs

Peter Chiu (4):
      wifi: mt76: mt7915: fix register mapping
      wifi: mt76: mt7996: fix register mapping
      wifi: mt76: mt7996: add max mpdu len capability
      wifi: mt76: mt7996: fix ldpc setting

Ping-Ke Shih (6):
      wifi: rtw88: add __packed attribute to efuse layout struct
      wifi: rtw89: pci: treat first receiving part as first segment for 8922AE
      wifi: rtw89: fix race between cancel_hw_scan and hw_scan completion
      wifi: rtw89: read hardware capabilities part 1 via firmware command
      wifi: rtw89: 8922ae: add variant info to support RTL8922AE-VS
      wifi: rtw88: add RTW88_LEDS depends on LEDS_CLASS to Kconfig

Po-Hao Huang (1):
      wifi: rtw89: correct header conversion rule for MLO only

Pradeep Kumar Chitrapu (2):
      wifi: ath12k: Support Transmit Rate Buffer Stats
      wifi: ath12k: Support Transmit Buffer OFDMA Stats

Quan Zhou (6):
      wifi: mt76: mt7921: fix a potential scan no APs
      wifi: mt76: do not hold queue lock during initial rx buffer alloc
      wifi: mt76: mt7925: fix the unfinished command of regd_notifier before suspend
      wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
      wifi: mt76: mt7925: add handler to hif suspend/resume event
      wifi: mt76: mt7925e: fix too long of wifi resume time

Raj Kumar Bhagat (3):
      dt-bindings: net: wireless: Describe ath12k PCI module with WSI
      wifi: ath12k: parse multiple device information from Device Tree
      wifi: ath12k: Include MLO memory in firmware coredump collection

Rajat Soni (1):
      wifi: ath12k: Support pdev Puncture Stats

Rameshkumar Sundaram (1):
      wifi: ath12k: advertise MLO support and capabilities

Ramya Gnanasekar (1):
      wifi: ath12k: set flag for mgmt no-ack frames in Tx completion

Rolf Eike Beer (1):
      wifi: iwlwifi: fix documentation about initial values in station table

Roopni Devanathan (1):
      wifi: ath12k: Support AST Entry Stats

Sathishkumar Muruganandam (1):
      wifi: ath12k: fix tx power, max reg power update to firmware

Sean Wang (1):
      wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO

Shayne Chen (5):
      wifi: mt76: mt7996: fix invalid interface combinations
      wifi: mt76: mt7996: extend flexibility of mt7996_mcu_get_eeprom()
      wifi: mt76: mt7996: add support for more variants
      wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz on MT7916
      wifi: mt76: connac: rework connac helpers

Shen Lichuan (1):
      wifi: mt76: mt7615: Convert comma to semicolon

Somashekhar(Som) (6):
      wifi: mvm: Request periodic system statistics earlier
      wifi: iwlwifi: pcie: Add support for new device ids
      wifi: iwlwifi: interpret STEP URM BIOS configuration
      wifi: iwlwifi: Allow entering EMLSR for more band combinations
      wifi: iwlwifi: add mapping of prph register crf for PE RF
      wifi: iwlwifi: add channel_load_not_by_us in iwl_mvm_phy_ctxt

StanleyYP Wang (1):
      wifi: mt76: mt7996: set correct background radar capability

Stefan Dösinger (1):
      wifi: brcmfmac: Check the return value of of_property_read_string_index()

Vasily Khoruzhick (1):
      wifi: rtw88: 8703b: Fix RX/TX issues

WangYuli (1):
      wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO

Yedidya Benshimol (2):
      wifi: iwlwifi: remove mvm from session protection cmd's name
      wifi: iwlwifi: api: remove version number from latest stored_beacon_notif

Zhang Kunbo (1):
      wifi: mt76: mt7925: replace zero-length array with flexible-array member

Zong-Zhe Yang (4):
      wifi: rtw89: debug: print regd for QATAR/UK/THAILAND
      wifi: rtw89: fix proceeding MCC with wrong scanning state after sequence changes
      wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()
      wifi: rtw89: mcc: consider time limits not divisible by 1024

allan.wang (1):
      wifi: mt76: mt7925: Fix incorrect WCID phy_idx assignment

shitao (1):
      wifi: iwlwifi: Fix spelling typo in comment

xueqin Luo (2):
      wifi: mt76: mt7996: fix overflows seen when writing limit attributes
      wifi: mt76: mt7915: fix overflows seen when writing limit attributes

 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |  204 ++++
 drivers/net/wireless/ath/ath12k/core.c             |  315 +++++-
 drivers/net/wireless/ath/ath12k/core.h             |   63 +-
 drivers/net/wireless/ath/ath12k/coredump.c         |    3 +
 drivers/net/wireless/ath/ath12k/coredump.h         |    1 +
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  502 ++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  155 +++
 drivers/net/wireless/ath/ath12k/dp.c               |   14 +
 drivers/net/wireless/ath/ath12k/dp.h               |   30 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  156 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  233 ++--
 drivers/net/wireless/ath/ath12k/fw.h               |    3 +
 drivers/net/wireless/ath/ath12k/hal.c              |    2 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    4 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   14 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  792 ++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   11 +
 drivers/net/wireless/ath/ath12k/peer.c             |    2 +
 drivers/net/wireless/ath/ath12k/peer.h             |    3 +
 drivers/net/wireless/ath/ath12k/qmi.c              |  324 +++++-
 drivers/net/wireless/ath/ath12k/qmi.h              |    1 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  225 +++-
 drivers/net/wireless/ath/ath12k/wmi.h              |   56 +
 drivers/net/wireless/ath/ath9k/ath9k.h             |    8 +-
 drivers/net/wireless/ath/ath9k/beacon.c            |    2 +-
 drivers/net/wireless/ath/ath9k/calib.c             |   24 +-
 drivers/net/wireless/ath/ath9k/channel.c           |   29 +-
 drivers/net/wireless/ath/ath9k/hw.c                |   25 +-
 drivers/net/wireless/ath/ath9k/hw.h                |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |    9 +-
 drivers/net/wireless/ath/ath9k/recv.c              |    4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   52 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    6 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    5 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |    8 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |   38 -
 drivers/net/wireless/intel/iwlegacy/3945.h         |    1 -
 drivers/net/wireless/intel/iwlegacy/common.c       |   31 -
 drivers/net/wireless/intel/iwlegacy/common.h       |    1 -
 drivers/net/wireless/intel/iwlwifi/Makefile        |    3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   46 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   33 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |  167 +++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   38 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   11 +
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   78 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   99 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   49 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   57 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h   |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   42 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   60 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   63 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  101 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   26 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   15 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |   40 +-
 .../net/wireless/intel/iwlwifi/iwl-context-info.h  |   32 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h     |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  112 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   79 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    5 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  223 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   93 +-
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c     |   85 ++
 drivers/net/wireless/intel/iwlwifi/iwl-utils.h     |   56 +
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c   |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   77 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   93 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   55 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  121 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   86 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   36 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  196 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   18 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   35 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   70 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |    6 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   99 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    8 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   67 ++
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |    6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    6 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   28 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  291 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |    4 +-
 drivers/net/wireless/mediatek/mt76/Makefile        |    2 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |  406 +++++++
 drivers/net/wireless/mediatek/mt76/dma.c           |   22 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  236 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h          |  152 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   14 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   11 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c    |    6 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio_mcu.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |    4 +-
 .../net/wireless/mediatek/mt76/mt7615/usb_mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    4 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  |    5 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   45 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   79 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   23 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   21 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   24 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   26 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   79 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |    7 +
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    8 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   18 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  138 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h    |    5 +
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    5 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   28 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  130 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  236 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   23 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   33 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   20 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   23 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   48 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  150 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |  216 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h |    2 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  411 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   57 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  903 +++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  504 +++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  179 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   12 +
 drivers/net/wireless/mediatek/mt76/scan.c          |  168 +++
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c     |    4 +
 drivers/net/wireless/mediatek/mt76/tx.c            |   33 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |    4 +-
 drivers/net/wireless/mediatek/mt76/util.c          |   10 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |    2 -
 drivers/net/wireless/microchip/wilc1000/sdio.c     |    9 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |    9 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    6 -
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c      |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/fw.h    |    4 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |    5 +
 drivers/net/wireless/realtek/rtw88/Makefile        |    2 +
 drivers/net/wireless/realtek/rtw88/fw.c            |    7 +-
 drivers/net/wireless/realtek/rtw88/led.c           |   73 ++
 drivers/net/wireless/realtek/rtw88/led.h           |   25 +
 drivers/net/wireless/realtek/rtw88/main.c          |   21 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   10 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |   22 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    8 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |    8 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |   22 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |   28 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   19 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   19 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   19 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.h      |    9 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    2 +
 drivers/net/wireless/realtek/rtw88/usb.c           |  195 +++-
 drivers/net/wireless/realtek/rtw88/usb.h           |    3 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |    6 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |   31 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    9 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   29 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   18 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |    3 +
 drivers/net/wireless/realtek/rtw89/fw.c            |   66 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   16 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   94 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   12 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   24 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    4 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   10 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |   10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    6 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.h      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   17 +-
 drivers/net/wireless/ti/wlcore/main.c              |   10 +-
 include/linux/ieee80211.h                          |  100 +-
 include/net/cfg80211.h                             |   67 ++
 include/net/mac80211.h                             |   54 +-
 include/uapi/linux/nl80211.h                       |   28 +
 net/mac80211/cfg.c                                 |   26 +-
 net/mac80211/chan.c                                |    7 +
 net/mac80211/debug.h                               |   10 +-
 net/mac80211/debugfs_key.c                         |   47 -
 net/mac80211/debugfs_key.h                         |   15 -
 net/mac80211/debugfs_netdev.c                      |    2 +-
 net/mac80211/driver-ops.h                          |    3 +
 net/mac80211/he.c                                  |  119 +-
 net/mac80211/ibss.c                                |    3 +-
 net/mac80211/ieee80211_i.h                         |   23 +-
 net/mac80211/iface.c                               |    4 +
 net/mac80211/key.c                                 |    2 +-
 net/mac80211/main.c                                |    5 +
 net/mac80211/mesh_plink.c                          |    5 +-
 net/mac80211/mlme.c                                | 1196 +++++++++++++++++---
 net/mac80211/parse.c                               |   29 +
 net/mac80211/rx.c                                  |   16 +-
 net/mac80211/sta_info.c                            |   23 +-
 net/mac80211/sta_info.h                            |   12 +-
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/util.c                          |  313 +++++
 net/mac80211/tests/util.h                          |   36 +
 net/mac80211/trace.h                               |  120 +-
 net/mac80211/util.c                                |   35 +-
 net/mac80211/vht.c                                 |   33 +-
 net/wireless/chan.c                                |  394 +++----
 net/wireless/core.h                                |    4 +
 net/wireless/mlme.c                                |   84 ++
 net/wireless/nl80211.c                             |  371 ++++--
 net/wireless/nl80211.h                             |    3 +
 net/wireless/rdev-ops.h                            |   34 +
 net/wireless/scan.c                                |   47 +-
 net/wireless/trace.h                               |   78 ++
 273 files changed, 11715 insertions(+), 3814 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/dr.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/channel.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/scan.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.h
 create mode 100644 net/mac80211/tests/util.c
 create mode 100644 net/mac80211/tests/util.h


