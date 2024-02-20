Return-Path: <linux-wireless+bounces-3816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4B85C1E1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 17:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B911F2292F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A999768EC;
	Tue, 20 Feb 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb67PHX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21C0762EC;
	Tue, 20 Feb 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448324; cv=none; b=Hsiytb1hwkzuGnWkXbJifgvWJChuNKlyqGs+KkWl+k8H53E8SDnWDtRr3XJDCh5+KsZaEBf7c8KjNmfuS/HnfrZru58QrpC0izSOHzntewopogTlzLd/XjDDOojit8uqVrs63hlsMDJyhIyU7usKlc1gLPj2/kkkxwLSsI7L7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448324; c=relaxed/simple;
	bh=OWYu+Be9aX1xLdblnTLyuFKUZPSet9fUVTqb8+KnL14=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=fwIE+Ha2hTv+w0MxJ4NM1vRk80hwk4vjBLFHvUZplRra3MjZB2Y2Xcc1yAx0Dg4kmfm6o7KuMMApZQ41FivtroVWhyJ8l2TYdGaxDal8o5/UxS3yk+n/q8vMMfsOIIHe5iNjX4A6PvPYqRWzeyv6WEjR64HKqH3Vl3VDb1qRuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb67PHX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917CDC433F1;
	Tue, 20 Feb 2024 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708448323;
	bh=OWYu+Be9aX1xLdblnTLyuFKUZPSet9fUVTqb8+KnL14=;
	h=From:Subject:To:Cc:Date:From;
	b=Lb67PHX5TAifDFEcaFNfxVQLP1H4m9ti0+9jgGACsMxvMiquTrL/hCp83bHz82R60
	 c9dXo+KsJw9dla+NuL4fKqGYS1zNDCkvualV5MjwC543FzdDWlD1Dt2O2yjvchuzO5
	 C9Zx9Sp3DofbGwBhtC9qfozRGxCP5Gi3vPRnrwpzr82DXcQds5q1YKUkbRyoJw8DBG
	 o03uqaWKsCizK0fo28v3ABwzW89YXoAovTPifAqKD0VZS9LdF6goQLPRrD5JuntSlC
	 vlbDwBsCHq3EFG/OP50GoK0KCIft6zW3M5g0KfkoGK4XAi+AtQRTNS5Vrhjn8UZley
	 g1CCYWQBFFT7w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-02-20
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240220165842.917CDC433F1@smtp.kernel.org>
Date: Tue, 20 Feb 2024 16:58:42 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit b7198383ef2debe748118996f627452281cf27d7:

  wifi: iwlwifi: mvm: fix a crash when we run out of stations (2024-02-08 14:55:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-02-20

for you to fetch changes up to dd66185c23f71af36397bebfc99ede608dca07b6:

  wifi: wilc1000: add missing read critical sections around vif list traversal (2024-02-19 18:21:36 +0200)

----------------------------------------------------------------
wireless-next patches for v6.9

The second "new features" pull request for v6.9.  Lots of iwlwifi and
stack changes this time. And naturally smaller changes to other drivers.

We also twice merged wireless into wireless-next to avoid conflicts
between the trees.

Major changes:

stack

* mac80211: negotiated TTLM request support

* SPP A-MSDU support

* mac80211: wider bandwidth OFDMA config support

iwlwifi

* kunit tests

* bump FW API to 89 for AX/BZ/SC devices

* enable SPP A-MSDUs

* support for new devices

ath12k

* refactoring in preparation for Multi-Link Operation (MLO) support

* 1024 Block Ack window size support

* provide firmware wmi logs via a trace event

ath11k

* 36 bit DMA mask support

* support 6 GHz station power modes: Low Power Indoor (LPI), Standard
  Power) SP and Very Low Power (VLP)

rtl8xxxu

* TP-Link TL-WN823N V2 support

----------------------------------------------------------------
Aditya Kumar Singh (8):
      wifi: cfg80211: send link id in channel_switch ops
      wifi: mac80211: update beacon counters per link basis
      wifi: mac80211: handle set csa/after_csa beacon on per link basis
      wifi: mac80211: start and finalize channel switch on link basis
      wifi: mac80211: add support to call csa_finish on a link
      wifi: cfg80211: add support for link id attribute in NL80211_CMD_DEL_STATION
      wifi: mac80211: flush only stations using requests links
      wifi: mac80211: remove only own link stations during stop_ap

Ajay Singh (2):
      wifi: wilc1000: set preamble size to auto as default in wilc_init_fw_config()
      wifi: wilc1000: add missing read critical sections around vif list traversal

Alexey Berezhok (1):
      wifi: brcmfmac: do not cast hidden SSID attribute value to boolean

Alexis Lothoré (4):
      wifi: wilc1000: prevent use-after-free on vif when cleaning up all interfaces
      wifi: wilc1000: split deeply nested RCU list traversal in dedicated helper
      wifi: wilc1000: use SRCU instead of RCU for vif list traversal
      wifi: wilc1000: fix declarations ordering

Andrei Otcheretianski (1):
      wifi: mac80211_hwsim: Add 160MHz bw range to regdom_custom_04

Anjaneyulu (1):
      wifi: iwlwifi: Add support for PPAG cmd v5 and PPAG revision 3

Arend van Spriel (2):
      wifi: brcmfmac: add linefeed at end of file
      wifi: brcmfmac: fix copyright year mentioned in platform_data header

Arnd Bergmann (2):
      wifi: iwlwifi: fix #ifdef CONFIG_ACPI check
      wifi: brcmsmac: avoid function pointer casts

Avraham Stern (1):
      wifi: iwlwifi: mvm: advertise support for protected ranging negotiation

Ayala Beker (7):
      wifi: ieee80211: add definitions for negotiated TID to Link map
      wifi: mac80211: process and save negotiated TID to Link mapping request
      wifi: mac80211_hwsim: handle TID to link mapping neg request
      wifi: mac80211_hwsim: handle BSS_CHANGED_MLD_TTLM
      wifi: mac80211: add support for negotiated TTLM request
      wifi: iwlwifi: mvm: add support for TID to link mapping neg request
      wifi: iwlwifi: mvm: use fast balance scan in case of an active P2P GO

Baochen Qiang (11):
      wifi: ath12k: support default regdb while searching board-2.bin for WCN7850
      wifi: ath11k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
      wifi: ath12k: add support for BA1024
      wifi: ath12k: change MAC buffer ring size to 2048
      wifi: ath12k: add support for collecting firmware log
      wifi: ath11k: enable 36 bit mask for stream DMA
      wifi: ath11k: remove invalid peer create logic
      wifi: ath11k: rename ath11k_start_vdev_delay()
      wifi: ath11k: avoid forward declaration of ath11k_mac_start_vdev_delay()
      wifi: ath11k: fix connection failure due to unexpected peer delete

Benjamin Berg (5):
      wifi: cfg80211: add RNR with reporting AP information
      wifi: mac80211: use deflink and fix typo in link ID check
      wifi: iwlwifi: skip affinity setting on non-SMP
      wifi: cfg80211: add a kunit test for 6 GHz colocated AP parsing
      wifi: cfg80211: tests: verify BSS use flags of NSTR links

Bitterblue Smith (2):
      wifi: rtlwifi: rtl8192cu: Fix 2T2R chip type detection
      wifi: rtlwifi: rtl_usb: Store the endpoint addresses

Chih-Kang Chang (1):
      wifi: rtw89: 8922a: implement AP mode related reg for BE generation

Chin-Yen Lee (2):
      wifi: rtw89: add new H2C for PS mode in 802.11be chip
      wifi: rtw89: update ps_state register for chips with different generation

Chun Qiu (1):
      wifi: rtl8xxxu: Add TP-Link TL-WN823N V2

Colin Ian King (1):
      wifi: iwlwifi: Fix spelling mistake "SESION" -> "SESSION"

Dan Carpenter (2):
      wifi: rtl8xxxu: fix error messages
      wifi: iwlwifi: return negative -EINVAL instead of positive EINVAL

Daniel Amosi (1):
      wifi: iwlwifi: mvm: Keep connection in case of missed beacons during RX

Daniel Gabay (1):
      wifi: iwlwifi: mvm: log dropped packets due to MIC error

David Lechner (1):
      wifi: wilc1000: remove setting msg.spi

David Mosberger-Tang (2):
      wifi: wilc1000: correct CRC7 calculation
      wifi: wilc1000: validate chip id during bus probe

Dmitry Antipov (5):
      wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()
      wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()
      wifi: wireless: avoid strlen() in cfg80211_michael_mic_failure()
      wifi: mwifiex: use kstrtoX_from_user() in debugfs handlers

Emmanuel Grumbach (9):
      wifi: iwlwifi: mvm: introduce PHY_CONTEXT_CMD_API_VER_5
      wifi: iwlwifi: mvm: disconnect station vifs if recovery failed
      wifi: iwlwifi: mvm: fix the TLC command after ADD_STA
      iwlwifi: fw: fix more kernel-doc warnings
      wifi: iwlwifi: mvm: don't send NDPs for new tx devices
      wifi: iwlwifi: mvm: don't send BT_COEX_CI command on new devices
      wifi: iwlwifi: mvm: don't support reduced tx power on ack for new devices
      wifi: iwlwifi: mvm: don't set the MFP flag for the GTK
      wifi: iwlwifi: mvm: don't send the smart fifo command if not needed

Gregory Greenman (1):
      wifi: iwlwifi: bump FW API to 87 for AX/BZ/SC devices

Ilan Peer (6):
      wifi: mac80211_hwsim: Declare support for negotiated TTLM
      wifi: iwlwifi: mvm: Add support for removing responder TKs
      wifi: iwlwifi: mvm: Fix FTM initiator flags
      wifi: iwlwifi: mvm: Declare support for secure LTF measurement
      wifi: iwlwifi: mvm: Extend support for P2P service discovery
      wifi: iwlwifi: mvm: Fix the listener MAC filter flags

Jeff Johnson (17):
      wifi: ath10k: use flexible array in struct wmi_host_mem_chunks
      wifi: ath10k: use flexible arrays for WMI start scan TLVs
      wifi: ath10k: remove struct wmi_pdev_chanlist_update_event
      wifi: ath10k: remove unused template structs
      wifi: ath10k: use flexible array in struct wmi_tdls_peer_capabilities
      wifi: ath10k: remove duplicate memset() in 10.4 TDLS peer update
      wifi: ath12k: Make QMI message rules const
      wifi: ath12k: Remove unnecessary struct qmi_txn initializers
      wifi: ath12k: Add missing qmi_txn_cancel() calls
      wifi: ath12k: Use initializers for QMI message buffers
      wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
      wifi: ath10k: add missing wmi_10_4_feature_mask documentation
      wifi: ath10k: correctly document enum wmi_tlv_tx_pause_id
      wifi: ath10k: fix htt_q_state_conf & htt_q_state kernel-doc
      wifi: ath10k: Fix htt_data_tx_completion kernel-doc warning
      wifi: ath10k: Fix enum ath10k_fw_crash_dump_type kernel-doc
      Revert "nl80211/cfg80211: Specify band specific min RSSI thresholds with sched scan"

Johannes Berg (114):
      wifi: cfg80211: add support for SPP A-MSDUs
      wifi: mac80211: add support for SPP A-MSDUs
      wifi: mac80211_hwsim: advertise AP-side EMLSR/EMLMR capa
      wifi: mac80211: take EML/MLD capa from assoc response
      wifi: cfg80211: validate MLO connections better
      wifi: mac80211_hwsim: advertise 15 simultaneous links
      wifi: mac80211: simplify ieee80211_config_bw() prototype
      wifi: mac80211: remove extra element parsing
      wifi: mac80211: simplify HE capability access
      wifi: mac80211: disallow drivers with HT wider than HE
      wifi: mac80211: don't set bss_conf in parsing
      wifi: iwlwifi: add kunit test for devinfo ordering
      wifi: iwlwifi: make TB reallocation a debug message
      wifi: iwlwifi: mvm: limit EHT 320 MHz MCS for STEP URM
      wifi: iwlwifi: remove retry loops in start
      wifi: iwlwifi: nvm-parse: advertise common packet padding
      kunit: add wireless unit tests
      wifi: iwlwifi: mvm: report beacon protection failures
      wifi: iwlwifi: mvm: d3: disconnect on GTK rekey failure
      wifi: iwlwifi: fix some kernel-doc issues
      wifi: iwlwifi: dbg-tlv: avoid extra allocation/copy
      wifi: iwlwifi: dbg-tlv: use struct_size() for allocation
      wifi: iwlwifi: dbg-tlv: ensure NUL termination
      wifi: iwlwifi: fw: dbg: ensure correct config name sizes
      wifi: iwlwifi: acpi: fix WPFC reading
      wifi: iwlwifi: mvm: initialize rates in FW earlier
      wifi: iwlwifi: mvm: d3: fix IPN byte order
      wifi: iwlwifi: mvm: don't set trigger frame padding in AP mode
      wifi: iwlwifi: always have 'uats_enabled'
      wifi: iwlwifi: remove Gl A-step remnants
      wifi: iwlwifi: mvm: use FW rate for non-data only on new devices
      wifi: iwlwifi: mvm: support SPP A-MSDUs
      wifi: iwlwifi: mvm: refactor duplicate chanctx condition
      wifi: iwlwifi: mvm: d3: implement suspend with MLO
      wifi: iwlwifi: mvm: check AP supports EMLSR
      wifi: mac80211_hwsim: add control to skip beacons
      wifi: mac80211: trace SMPS requests from driver
      wifi: mac80211: clean up FILS discovery change flags handling
      wifi: nl80211: move WPA version validation to policy
      wifi: iwlwifi: remove unused function prototype
      wifi: iwlwifi: api: clean up some kernel-doc/typos
      wifi: iwlwifi: fw: fix compile w/o CONFIG_ACPI
      wifi: iwlwifi: fw: fix compiler warning for NULL string print
      wifi: iwlwifi: mvm: fix warnings from dmi_get_system_info()
      wifi: cfg80211: fix kunit exports
      Merge wireless into wireless-next
      wifi: mac80211: remove unused MAX_MSG_LEN define
      wifi: mac80211: remove extra shadowing variable
      wifi: mac80211: clean up band switch in duration
      wifi: mac80211: clean up connection process
      wifi: mac80211: clean up HE 6 GHz and EHT chandef parsing
      wifi: mac80211: simplify non-chanctx drivers
      wifi: mac80211: chan: chandef is non-NULL for reserved
      wifi: mac80211: introduce 'channel request'
      wifi: mac80211: add and use a link iteration macro
      wifi: mac80211: support wider bandwidth OFDMA config
      wifi: mac80211: validate assoc response channel config
      wifi: cfg80211: move puncturing validation code
      wifi: mac80211: refactor puncturing bitmap extraction
      wifi: wireless: declare different S1G chandefs incompatible
      wifi: cfg80211: simplify cfg80211_chandef_compatible()
      wifi: mac80211: use cfg80211_chandef_primary_freq()
      wifi: cfg80211/mac80211: move puncturing into chandef
      wifi: mac80211: add/use ieee80211_get_sn()
      wifi: mac80211: implement MLO multicast deduplication
      wifi: mac80211: disambiguate element parsing errors
      wifi: mac80211: disallow basic multi-link element in per-STA profile
      wifi: mac80211: simplify HE/EHT element length functions
      wifi: mac80211: adjust EHT capa when lowering bandwidth
      wifi: mac80211: limit HE RU capabilities when limiting bandwidth
      wifi: mac80211: rename ieee80211_ie_build_he_6ghz_cap()
      wifi: mac80211: tdls: use ieee80211_put_he_6ghz_cap()
      wifi: mac80211: simplify adding supported rates
      wifi: mac80211: start building elements in SKBs
      wifi: mac80211: move element parsing to a new file
      wifi: mac80211: convert ieee80211_ie_build_he_cap() to SKB use
      wifi: mac80211: convert ieee80211_ie_build_eht_cap() to SKB use
      wifi: mac80211: allow CSA to same channel
      wifi: mac80211: clarify vif handling in TX dequeue
      wifi: mac80211: add missing kernel-doc for fast_tx_check
      wifi: mac80211_hwsim: add missing kernel-doc
      wifi: mac80211: don't use sband->band early
      wifi: iwlwifi: pcie: don't allow hw-rfkill to stop device on gen2
      wifi: iwlwifi: mvm: const-ify chandef pointers
      wifi: iwlwifi: mvm: remove EHT code from mac80211.c
      wifi: iwlwifi: use system_unbound_wq for debug dump
      wifi: iwlwifi: mvm: remove one queue sync on BA session stop
      wifi: iwlwifi: mvm: expand queue sync warning messages
      wifi: iwlwifi: mvm: don't abort queue sync in CT-kill
      wifi: iwlwifi: mvm: combine condition/warning
      wifi: iwlwifi: mvm: limit pseudo-D3 to 60 seconds
      wifi: iwlwifi: mvm: fix erroneous queue index mask
      wifi: iwlwifi: mvm: don't do duplicate detection for nullfunc packets
      wifi: iwlwifi: fw: allow vmalloc for PNVM image
      wifi: iwlwifi: mvm: don't set replay counters to 0xff
      wifi: iwlwifi: mvm: remove flags for enable/disable beacon filter
      wifi: iwlwifi: mvm: show skb_mac_gso_segment() failure reason
      wifi: iwlwifi: mvm: move BA notif messages before action
      wifi: iwlwifi: queue: improve warning for no skb in reclaim
      wifi: cfg80211: fix kernel-doc for cfg80211_chandef_primary
      wifi: cfg80211: rename UHB to 6 GHz
      wifi: cfg80211: optionally support monitor on disabled channels
      wifi: mac80211: drop injection on disabled-chan monitor
      wifi: iwlwifi: mvm: work around A-MSDU size problem
      wifi: iwlwifi: api: fix constant version to match FW
      wifi: iwlwifi: don't use TRUE/FALSE with bool
      wifi: iwlwifi: mvm: fix thermal kernel-doc
      wifi: iwlwifi: error-dump: fix kernel-doc issues
      wifi: iwlwifi: api: dbg-tlv: fix up kernel-doc
      wifi: iwlwifi: fw: file: clean up kernel-doc
      wifi: iwlwifi: iwl-trans.h: clean up kernel-doc
      wifi: iwlwifi: mvm: check own capabilities for EMLSR
      Merge wireless into wireless-next
      wifi: cfg80211: use IEEE80211_MAX_MESH_ID_LEN appropriately

Jérôme Pouiller (1):
      wifi: wfx: fix memory leak when starting AP

Kalle Valo (4):
      Merge tag 'ath-next-20240130' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
      wifi: zd1211rw: remove __nocast from zd_addr_t
      wifi: rsi: fix restricted __le32 degrades to integer sparse warnings
      wifi: cw1200: fix __le16 sparse warnings

Karthikeyan Periyasamy (21):
      wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc() call
      wifi: ath12k: refactor ath12k_mac_allocate() and ath12k_mac_destroy()
      wifi: ath12k: refactor ath12k_mac_setup_channels_rates()
      wifi: ath12k: refactor ath12k_mac_register() and ath12k_mac_unregister()
      wifi: ath12k: refactor ath12k_mac_op_config()
      wifi: ath12k: refactor ath12k_bss_assoc()
      wifi: ath12k: refactor ath12k_mac_op_conf_tx()
      wifi: ath12k: refactor ath12k_mac_op_start()
      wifi: ath12k: refactor ath12k_mac_op_stop()
      wifi: ath12k: refactor ath12k_mac_op_update_vif_offload()
      wifi: ath12k: refactor ath12k_mac_op_configure_filter()
      wifi: ath12k: refactor ath12k_mac_op_ampdu_action()
      wifi: ath12k: refactor ath12k_mac_op_flush()
      wifi: ath12k: ath12k_start_vdev_delay(): convert to use ar
      wifi: ath12k: refactor QMI MLO host capability helper function
      wifi: ath12k: add QMI PHY capability learn support
      wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath12k: Refactor the mac80211 hw access from link/radio
      wifi: ath12k: Introduce the container for mac80211 hw

Kees Cook (1):
      wifi: mwifiex: Refactor 1-element array into flexible array in struct mwifiex_ie_types_chan_list_param_set

Linus Walleij (5):
      wifi: ti: wlcore: sdio: Drop unused include
      wifi: brcmsmac: Drop legacy header
      wifi: mwifiex: Drop unused headers
      wifi: plfxlc: Drop unused include
      wifi: cw1200: Convert to GPIO descriptors

Lorenzo Bianconi (1):
      wifi: mac80211: remove gfp parameter from ieee80211_obss_color_collision_notify

Martin Kaistra (1):
      wifi: rtl8xxxu: update rate mask per sta

Michael-CY Lee (3):
      wifi: mac80211: apply duration for SW scan
      wifi: cfg80211: Add utility for converting op_class into chandef
      wifi: mac80211: refactor STA CSA parsing flows

Miri Korenblit (40):
      wifi: iwlwifi: change link id in time event to s8
      wifi: iwlwifi: implement can_activate_links callback
      wifi: iwlwifi: add support for a wiphy_work rx handler
      wifi: iwlwifi: disable eSR when BT is active
      wifi: iwlwifi: implement GLAI ACPI table loading
      wifi: iwlwifi: cleanup uefi variables loading
      wifi: iwlwifi: fix EWRD table validity check
      wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
      wifi: iwlwifi: prepare for reading SAR tables from UEFI
      wifi: iwlwifi: cleanup sending PER_CHAIN_LIMIT_OFFSET_CMD
      wifi: iwlwifi: read SAR tables from UEFI
      wifi: iwlwifi: small cleanups in PPAG table flows
      wifi: iwlwifi: prepare for reading PPAG table from UEFI
      wifi: iwlwifi: validate PPAG table when sent to FW
      wifi: iwlwifi: read PPAG table from UEFI
      wifi: iwlwifi: don't check TAS block list size twice
      wifi: iwlwifi: prepare for reading TAS table from UEFI
      wifi: iwlwifi: separate TAS 'read-from-BIOS' and 'send-to-FW' flows
      wifi: iwlwifi: read WTAS table from UEFI
      wifi: mac80211_hwsim: enable all links only in MLO
      wifi: mac80211: don't allow deactivation of all links
      wifi: iwlwifi: prepare for reading SPLC from UEFI
      wifi: iwlwifi: read SPLC from UEFI
      wifi: iwlwifi: read WRDD table from UEFI
      wifi: iwlwifi: read ECKV table from UEFI
      wifi: iwlwifi: rfi: use a single DSM function for all RFI configurations
      wifi: iwlwifi: take send-DSM-to-FW flows out of ACPI ifdef
      wifi: iwlwifi: simplify getting DSM from ACPI
      wifi: iwlwifi: prepare for reading DSM from UEFI
      wifi: iwlwifi: read DSM functions from UEFI
      wifi: iwlwifi: bump FW API to 88 for AX/BZ/SC devices
      wifi: iwlwifi: add HONOR to PPAG approved list
      wifi: iwlwifi: adjust rx_phyinfo debugfs to MLO
      wifi: iwlwifi: read mac step from aux register
      wifi: iwlwifi: support EHT for WH
      wifi: iwlwifi: take SGOM and UATS code out of ACPI ifdef
      wifi: iwlwifi: properly check if link is active
      wifi: iwlwifi: bump FW API to 89 for AX/BZ/SC devices
      wifi: iwlwifi: mvm: remove IWL_MVM_STATUS_NEED_FLUSH_P2P
      wifi: iwlwifi: cancel session protection only if there is one

Mukesh Sisodiya (5):
      wifi: iwlwifi: Add support for new 802.11be device
      wifi: iwlwifi: disable 160 MHz based on subsystem device ID
      wifi: iwlwifi: pcie: Add the PCI device id for new hardware
      wifi: iwlwifi: pcie: Add new PCI device id and CNVI
      wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory

Ping-Ke Shih (37):
      wifi: rtw89: pci: update SER timer unit and timeout time
      wifi: rtw89: pci: validate RX tag for RXQ and RPQ
      wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor
      wifi: rtw89: 8922a: hook handlers of TX/RX descriptors to chip_ops
      wifi: rtw89: 8922a: implement {stop,resume}_sch_tx and cfg_ppdu
      wifi: rtw89: 8922a: add chip_ops::cfg_txrx_path
      wifi: rtw89: 8922a: add RF read/write v2
      wifi: rtw89: 8922a: add chip_ops to get thermal value
      wifi: rtw89: 8922a: set chip_ops FEM and GPIO to NULL
      wifi: rtw89: rfk: add a completion to wait RF calibration report from C2H event
      wifi: rtw89: rfk: send channel information to firmware for RF calibrations
      wifi: rtw89: rfk: add H2C command to trigger IQK
      wifi: rtw89: rfk: add H2C command to trigger RX DCK
      wifi: rtw89: rfk: add H2C command to trigger DPK
      wifi: rtw89: rfk: add H2C command to trigger DACK
      wifi: rtw89: rfk: add H2C command to trigger TXGAPK
      wifi: rtw89: rfk: add H2C command to trigger TSSI
      wifi: rtw89: 8922a: rfk: implement chip_ops to call RF calibrations
      wifi: rtw89: 8922a: add chip_ops::rfk_init_late to do initial RF calibrations later
      wifi: rtw89: 8922a: add chip_ops::rfk_hw_init
      wifi: rtw89: fw: consider checksum length of security data
      wifi: rtw89: fw: read firmware secure information from efuse
      wifi: rtw89: fw: parse secure section from firmware file
      wifi: rtw89: fw: download firmware with key data for secure boot
      wifi: rtw89: correct PHY register offset for PHY-1
      wifi: rtw89: load BB parameters to PHY-1
      wifi: rtw89: mac: return held quota of DLE when changing MAC-1
      wifi: rtw89: mac: correct MUEDCA setting for MAC-1
      wifi: rtw89: mac: reset PHY-1 hardware when going to enable/disable
      wifi: rtw89: use PLCP information to match BSS_COLOR and AID
      wifi: rtw89: 8922a: correct register definition and merge IO for ctrl_nbtg_bt_tx()
      wifi: rtw89: change qutoa to DBCC by default for WiFi 7 chips
      wifi: rtw89: fw: remove unnecessary rcu_read_unlock() for punctured
      wifi: rtw89: 8922a: add set_channel MAC part
      wifi: rtw89: 8922a: add set_channel BB part
      wifi: rtw89: 8922a: add set_channel RF part
      wifi: rtw89: 8922a: add helper of set_channel

Po-Hao Huang (6):
      wifi: rtw89: update scan C2H messages for wifi 7 IC
      wifi: rtw89: debug: add FW log component for scan
      wifi: rtw89: prepare scan leaf functions for wifi 7 ICs
      wifi: rtw89: 8922a: add ieee80211_ops::hw_scan
      wifi: rtw89: 8922a: add more fields to beacon H2C command to support multi-links
      wifi: rtw89: reference quota mode when setting Tx power

Ricardo B. Marliere (2):
      ssb: make ssb_bustype const
      bcma: make bcma_bus_type const

Shaul Triebitz (9):
      wifi: iwlwifi: support link command version 2
      wifi: iwlwifi: mvm: make functions public
      wifi: iwlwifi: mvm: define RX queue sync timeout as a macro
      wifi: iwlwifi: mvm: fix the key PN index
      wifi: iwlwifi: mvm: always update keys in D3 exit
      wifi: iwlwifi: mvm: avoid garbage iPN
      wifi: nl80211: allow reporting wakeup for unprot deauth/disassoc
      wifi: cfg80211: report unprotected deauth/disassoc in wowlan
      wifi: iwlwifi: iwlmvm: handle unprotected deauth/disassoc in d3

Sriram R (1):
      wifi: ath12k: Fix issues in channel list update

Uwe Kleine-König (1):
      wifi: ath9k: Convert to platform remove callback returning void

Wen Gong (15):
      wifi: ath12k: add string type to search board data in board-2.bin for WCN7850
      wifi: ath12k: add fallback board name without variant while searching board-2.bin
      wifi: ath12k: remove unused ATH12K_BD_IE_BOARD_EXT
      wifi: ath12k: add support to search regdb data in board-2.bin for WCN7850
      wifi: ath11k: add support to select 6 GHz regulatory type
      wifi: ath11k: store cur_regulatory_info for each radio
      wifi: ath11k: update regulatory rules when interface added
      wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band for station
      wifi: ath11k: save power spectral density(PSD) of regulatory rule
      wifi: ath11k: add parse of transmit power envelope element
      wifi: ath11k: save max transmit power in vdev start response event from firmware
      wifi: ath11k: fill parameters for vdev set tpc power WMI command
      wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
      wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      wifi: ath11k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz

Wenli Looi (1):
      wifi: ath9k: delete some unused/duplicate macros

Xingyuan Mo (1):
      wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Zhenghao Gu (1):
      wifi: ath11k: fix IOMMU errors on buffer rings

Zhipeng Lu (1):
      wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()

Zong-Zhe Yang (13):
      wifi: rtw89: pci: interrupt v2 refine IMR for SER
      wifi: rtw89: drop TIMING_BEACON_ONLY and sync beacon TSF by self
      wifi: rtw89: chan: add sub-entity swap function to cover replacing
      wifi: rtw89: chan: tweak bitmap recalc ahead before MLO
      wifi: rtw89: chan: tweak weight recalc ahead before MLO
      wifi: rtw89: chan: move handling from add/remove to assign/unassign for MLO
      wifi: rtw89: chan: MCC take reconfig into account
      wifi: rtw89: differentiate narrow_bw_ru_dis setting according to chip gen
      wifi: rtw89: fw: add definition of H2C command and C2H event for MRC series
      wifi: rtw89: mac: implement MRC C2H event handling
      wifi: rtw89: fw: implement MRC H2C command functions
      wifi: rtw89: chan: support MCC on Wi-Fi 7 chips
      wifi: rtw89: 8922a: declare to support two chanctx

 drivers/bcma/main.c                                |    2 +-
 drivers/net/dsa/mt7530.c                           |   34 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |    4 +-
 drivers/net/ethernet/google/gve/gve.h              |  144 +-
 drivers/net/ethernet/google/gve/gve_dqo.h          |   18 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  862 +++---
 drivers/net/ethernet/google/gve/gve_rx.c           |  135 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   91 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |  128 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  108 +-
 drivers/net/ethernet/google/gve/gve_utils.c        |   31 +
 drivers/net/ethernet/google/gve/gve_utils.h        |    5 +
 drivers/net/wireless/admtek/adm8211.c              |    4 +
 drivers/net/wireless/ath/ar5523/ar5523.c           |    4 +
 drivers/net/wireless/ath/ath10k/core.c             |    4 +-
 drivers/net/wireless/ath/ath10k/coredump.h         |    8 +-
 drivers/net/wireless/ath/ath10k/htt.c              |    3 +-
 drivers/net/wireless/ath/ath10k/htt.h              |   12 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   10 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   10 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   11 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |    4 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   24 +-
 drivers/net/wireless/ath/ath10k/wmi.h              |   62 +-
 drivers/net/wireless/ath/ath11k/core.h             |   41 +
 drivers/net/wireless/ath/ath11k/dp.c               |   20 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    6 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   19 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    3 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c              | 1088 ++++++--
 drivers/net/wireless/ath/ath11k/mac.h              |    5 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    4 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   19 +-
 drivers/net/wireless/ath/ath11k/pci.h              |    3 +-
 drivers/net/wireless/ath/ath11k/reg.c              |  267 +-
 drivers/net/wireless/ath/ath11k/reg.h              |   11 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  298 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   65 +-
 drivers/net/wireless/ath/ath12k/core.c             |  217 +-
 drivers/net/wireless/ath/ath12k/core.h             |   57 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    3 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |    4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |    8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   10 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   20 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   15 +-
 drivers/net/wireless/ath/ath12k/hw.c               |    9 +
 drivers/net/wireless/ath/ath12k/hw.h               |   23 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  868 ++++--
 drivers/net/wireless/ath/ath12k/mac.h              |    4 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   10 +
 drivers/net/wireless/ath/ath12k/qmi.c              |  377 ++-
 drivers/net/wireless/ath/ath12k/qmi.h              |   34 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   13 +-
 drivers/net/wireless/ath/ath12k/trace.h            |   29 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   97 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |    4 +
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |    6 +-
 drivers/net/wireless/ath/ath9k/antenna.c           |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h        |    9 -
 drivers/net/wireless/ath/ath9k/beacon.c            |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |    4 +
 drivers/net/wireless/ath/ath9k/main.c              |    4 +
 drivers/net/wireless/ath/ath9k/reg_aic.h           |    4 -
 drivers/net/wireless/ath/carl9170/main.c           |    4 +
 drivers/net/wireless/ath/wcn36xx/main.c            |    4 +
 drivers/net/wireless/atmel/at76c50x-usb.c          |    4 +
 drivers/net/wireless/broadcom/b43/b43.h            |   16 +
 drivers/net/wireless/broadcom/b43/dma.c            |    4 +-
 drivers/net/wireless/broadcom/b43/main.c           |   20 +-
 drivers/net/wireless/broadcom/b43/pio.c            |    6 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |    4 +
 .../broadcom/brcm80211/brcmfmac/bca/core.c         |   30 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   66 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    2 +
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |   18 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   12 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |    2 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |   50 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |   11 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |  154 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |   60 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.c    |  116 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    |  125 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.c   |   13 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.h   |   48 +-
 .../broadcom/brcm80211/brcmfmac/wcc/core.c         |   31 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/led.c |    1 -
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    4 +
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      |    6 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h      |    2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |   11 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c         |    5 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.h         |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    4 +
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    4 +
 drivers/net/wireless/intel/iwlegacy/common.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    9 +
 drivers/net/wireless/intel/iwlwifi/Makefile        |    3 +
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   40 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  623 +----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |  220 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |    1 +
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   23 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |   10 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   28 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   40 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   27 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    2 -
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   23 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   27 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   49 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  500 ++++
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |  199 ++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   22 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  427 ++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |  210 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   67 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   28 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |   10 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   75 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   69 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |  132 +
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  133 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   54 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   10 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    9 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  346 +--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   36 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  212 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |   36 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   11 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  162 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   81 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  100 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    3 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  190 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   79 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    2 +
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   49 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   11 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |   16 +-
 drivers/net/wireless/intel/iwlwifi/tests/Makefile  |    7 +
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   54 +
 drivers/net/wireless/intel/iwlwifi/tests/module.c  |   10 +
 drivers/net/wireless/intersil/p54/main.c           |    4 +
 drivers/net/wireless/marvell/libertas/cmd.c        |   13 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |    4 +
 drivers/net/wireless/marvell/mwifiex/11h.c         |    2 +-
 drivers/net/wireless/marvell/mwifiex/11n.c         |   12 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   22 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    2 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    2 -
 drivers/net/wireless/marvell/mwifiex/scan.c        |   14 +-
 drivers/net/wireless/marvell/mwifiex/wmm.c         |    2 +-
 drivers/net/wireless/marvell/mwl8k.c               |    4 +
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    4 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |    4 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |    4 +
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |    4 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |    4 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |    4 +
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c       |    4 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   14 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |  110 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   95 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    6 +
 drivers/net/wireless/microchip/wilc1000/spi.c      |   75 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   42 +-
 drivers/net/wireless/microchip/wilc1000/wlan.h     |   11 +
 drivers/net/wireless/purelifi/plfxlc/mac.c         |    5 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2500usb.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c  |    5 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c       |    4 +
 drivers/net/wireless/ralink/rt2x00/rt73usb.c       |    4 +
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    4 +
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    4 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   28 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c |    3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c |    2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c |   33 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  596 +++-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h  |   15 +
 drivers/net/wireless/realtek/rtlwifi/core.c        |    4 +
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |   36 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h       |    4 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   12 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/def.h   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/mac.c   |    3 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |   80 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.c   |    6 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |  195 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   39 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |   44 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    4 +
 drivers/net/wireless/realtek/rtw88/pci.c           |    4 +
 drivers/net/wireless/realtek/rtw88/reg.h           |    3 +
 drivers/net/wireless/realtek/rtw89/cam.c           |   61 +
 drivers/net/wireless/realtek/rtw89/cam.h           |  109 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  648 ++++-
 drivers/net/wireless/realtek/rtw89/chan.h          |    5 +
 drivers/net/wireless/realtek/rtw89/coex.h          |    1 +
 drivers/net/wireless/realtek/rtw89/core.c          |  382 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |  263 +-
 drivers/net/wireless/realtek/rtw89/efuse.h         |    1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |  142 +
 drivers/net/wireless/realtek/rtw89/fw.c            | 2380 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h            | 1468 +++++++---
 drivers/net/wireless/realtek/rtw89/mac.c           |  292 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   59 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   19 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  197 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  136 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    7 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |    5 +
 drivers/net/wireless/realtek/rtw89/phy.c           | 1105 +++++++-
 drivers/net/wireless/realtek/rtw89/phy.h           |  113 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  331 +++
 drivers/net/wireless/realtek/rtw89/ps.c            |   10 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  488 +++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   17 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |   72 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   17 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    |  142 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 1660 ++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |  378 +++
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h  |   18 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |    8 +-
 drivers/net/wireless/rsi/rsi_91x_usb.c             |   12 +-
 drivers/net/wireless/silabs/wfx/sta.c              |   19 +-
 drivers/net/wireless/st/cw1200/cw1200_sdio.c       |   42 +-
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |   79 +-
 drivers/net/wireless/st/cw1200/main.c              |    4 +
 drivers/net/wireless/ti/wl1251/main.c              |    4 +
 drivers/net/wireless/ti/wlcore/event.c             |    2 +-
 drivers/net/wireless/ti/wlcore/main.c              |    6 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |    1 -
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  101 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |    5 +-
 drivers/net/wireless/zydas/zd1211rw/zd_def.h       |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |    4 +
 drivers/ssb/main.c                                 |    2 +-
 drivers/staging/vt6655/device_main.c               |    6 +-
 drivers/staging/vt6656/main_usb.c                  |    6 +-
 include/linux/ieee80211.h                          |  120 +-
 include/linux/inet_diag.h                          |    1 +
 include/linux/platform_data/brcmfmac.h             |    2 +-
 include/linux/platform_data/net-cw1200.h           |    4 -
 include/linux/sock_diag.h                          |   10 +-
 include/net/cfg80211.h                             |  100 +-
 include/net/ip6_fib.h                              |    6 -
 include/net/mac80211.h                             |  118 +-
 include/uapi/linux/nl80211.h                       |   71 +-
 net/core/sock_diag.c                               |  120 +-
 net/dccp/diag.c                                    |    1 +
 net/ipv4/inet_diag.c                               |  101 +-
 net/ipv4/raw_diag.c                                |    1 +
 net/ipv4/tcp_diag.c                                |    1 +
 net/ipv4/udp_diag.c                                |    2 +
 net/ipv6/ip6_fib.c                                 |   19 +-
 net/ipv6/route.c                                   |    8 +-
 net/mac80211/Makefile                              |    2 +-
 net/mac80211/agg-tx.c                              |    2 +-
 net/mac80211/cfg.c                                 |  232 +-
 net/mac80211/chan.c                                |  707 +++--
 net/mac80211/debug.h                               |   18 +-
 net/mac80211/driver-ops.h                          |   19 +
 net/mac80211/ht.c                                  |    6 +-
 net/mac80211/ibss.c                                |   55 +-
 net/mac80211/ieee80211_i.h                         |  182 +-
 net/mac80211/iface.c                               |   30 +-
 net/mac80211/key.c                                 |    4 +
 net/mac80211/link.c                                |   13 +-
 net/mac80211/main.c                                |  231 +-
 net/mac80211/mesh.c                                |  162 +-
 net/mac80211/mesh.h                                |    3 +-
 net/mac80211/mesh_plink.c                          |   28 +-
 net/mac80211/mlme.c                                | 2952 +++++++++++---------
 net/mac80211/ocb.c                                 |    5 +-
 net/mac80211/offchannel.c                          |   21 +-
 net/mac80211/parse.c                               |  926 ++++++
 net/mac80211/rate.c                                |   12 +-
 net/mac80211/rx.c                                  |   53 +-
 net/mac80211/scan.c                                |   42 +-
 net/mac80211/spectmgmt.c                           |  337 ++-
 net/mac80211/sta_info.c                            |   21 +-
 net/mac80211/sta_info.h                            |   14 +-
 net/mac80211/tdls.c                                |   67 +-
 net/mac80211/tests/elems.c                         |    1 +
 net/mac80211/trace.h                               |  119 +-
 net/mac80211/trace_msg.h                           |    2 -
 net/mac80211/tx.c                                  |   46 +-
 net/mac80211/util.c                                | 1803 ++++--------
 net/mac80211/vht.c                                 |    6 +-
 net/mac80211/wpa.c                                 |   33 +-
 net/mptcp/mptcp_diag.c                             |    1 +
 net/netlink/diag.c                                 |    1 +
 net/packet/diag.c                                  |    1 +
 net/sctp/diag.c                                    |    1 +
 net/smc/smc_diag.c                                 |    1 +
 net/tipc/diag.c                                    |    1 +
 net/tipc/node.c                                    |    2 -
 net/tipc/socket.c                                  |    1 -
 net/unix/diag.c                                    |    1 +
 net/vmw_vsock/diag.c                               |    1 +
 net/wireless/chan.c                                |  397 +--
 net/wireless/core.h                                |   52 +-
 net/wireless/mlme.c                                |  146 +-
 net/wireless/nl80211.c                             |  233 +-
 net/wireless/reg.c                                 |   10 +-
 net/wireless/scan.c                                |  192 +-
 net/wireless/sme.c                                 |    3 +-
 net/wireless/tests/Makefile                        |    2 +-
 net/wireless/tests/chan.c                          |  228 ++
 net/wireless/tests/scan.c                          |  277 +-
 net/wireless/trace.h                               |   52 +-
 net/wireless/util.c                                |   76 +
 net/xdp/xsk_diag.c                                 |    1 +
 tools/testing/kunit/configs/all_tests.config       |    5 +
 tools/testing/selftests/net/fcnal-test.sh          |   25 +-
 tools/testing/selftests/tc-testing/config          |    1 +
 .../selftests/tc-testing/tc-tests/qdiscs/fq.json   |    2 +-
 .../tc-testing/tc-tests/qdiscs/taprio.json         |    2 +
 tools/testing/selftests/tc-testing/tdc.py          |    2 +-
 tools/testing/selftests/tc-testing/tdc.sh          |    3 +-
 tools/testing/vsock/util.c                         |   17 +-
 tools/testing/vsock/util.h                         |    4 +
 tools/testing/vsock/vsock_diag_test.c              |   23 +-
 tools/testing/vsock/vsock_test.c                   |  102 +-
 tools/testing/vsock/vsock_test_zerocopy.c          |   12 +-
 tools/testing/vsock/vsock_uring_test.c             |   17 +-
 397 files changed, 24917 insertions(+), 9421 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/module.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
 create mode 100644 net/mac80211/parse.c
 create mode 100644 net/wireless/tests/chan.c


