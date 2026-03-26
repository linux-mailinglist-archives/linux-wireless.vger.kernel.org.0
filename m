Return-Path: <linux-wireless+bounces-33980-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDCrBGlRxWmD9QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33980-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:31:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E893379BA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F2BB307810E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30C3FB7D0;
	Thu, 26 Mar 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wgPa6Yjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252A31F9B1;
	Thu, 26 Mar 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538438; cv=none; b=FQaW+hH3CbmDA3q/ylCeqkvKkZ0kuPpO5pkH3V/hjd1R2bTY13rZAZ2EwtZffv1M9Y7bR+oU+FnGctreGbaJIOPcSMgYEjJS2P1vZ0Eeo3McNvqqcYHaZmJkRsOLURPZfjW+5urba+DcMYQEiMNNUUNKIOwCG8jJ1i37XylOglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538438; c=relaxed/simple;
	bh=yCb8hDSyJO6tLvyOTcAC+30vUp7FuTuyq/RtkkXPZUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNGKcSfpPKdDYZMov/rPr8KP0CuCNtSnTscQbJvgFwQHRya4mHjMYViHrX3ru0aex03E3Y0i+BuT3TC0xoqPy57FJQNGuZ+r7p2Z4VA+FCve0p4C+5tGHttiscs8K8H8MveUZav4TSjJFDhrayz8t6kqs9+m571EMUv/1uMgk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wgPa6Yjm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=eV5iq42YTgAeI642/opqGH1t6Xa00diL9BX73LPgkMQ=; t=1774538435; x=1775748035; 
	b=wgPa6Yjm/mKg9QMRsfCf97yMzpMqSBl53lekLhXvIS2SlWr3WH17sh8MDE8FF6JAgQSP1v6pI3e
	TEnlOpvmb6L0JdtquwI7v0P5+fmJCw8Vg/yUdPw1vYRaJ2zHmlluEi4ZKEc4V63kE9dtUJNF/HL4x
	RZqm/eObBKIMd/ac1RZMBrcga52mFIpLJ8/BvXTr0B/Kd2cUnnyKkFI8beTVY9B0YNnKDmD/NsG/E
	MqrMksCLJlb0f2T+9wQcmZNKFhG4NlaUPOUl6aaQXMzvEEXoKvWOA1pbe79oVbkgiRTOVOS/HWBiH
	O4t4ffbLTCCFVCbU/WfqxqXYv0kl7mjdKQtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w5mVU-0000000D9Gq-21zf;
	Thu, 26 Mar 2026 16:20:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-03-26
Date: Thu, 26 Mar 2026 16:18:02 +0100
Message-ID: <20260326152021.305959-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33980-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 79E893379BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

So couple more things for now, including the NAN (Neighbor
Awareness Networking) APIs that we spent a lot of time on
trying to get right :) Other than that changes all over.

We'll surely have more changes for NAN and also ranging
(for proximity detection) is coming, it's looking to be
a big 7.1 from a wifi perspective, but we'll see how it
all comes together.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 9ac76f3d0bb2940db3a9684d596b9c8f301ef315:

  Merge tag 'wireless-next-2026-03-19' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-03-19 15:30:20 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-03-26

for you to fetch changes up to 7dd6f81f4ef801b57f6ce7b0eee32aef5c488538:

  wifi: mac80211: ignore reserved bits in reconfiguration status (2026-03-25 21:22:02 +0100)

----------------------------------------------------------------
A fairly big set of changes all over, notably with:
 - cfg80211: new APIs for NAN (Neighbor Aware Networking,
   aka Wi-Fi Aware) so less work must be in firmware
 - mt76:
   - mt7996/mt7925 MLO fixes/improvements
   - mt7996 NPU support (HW eth/wifi traffic offload)
 - iwlwifi: UNII-9 and continuing UHR work

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: Use .mbn firmware for AHB devices

Allen Ye (1):
      wifi: mt76: fix backoff fields and max_power calculation

Alok Tiwari (1):
      wifi: mt76: mt7996: fix FCS error flag check in RX descriptor

Avinash Bhatt (3):
      wifi: iwlwifi: add CQM event support for per-link RSSI changes
      wifi: iwlwifi: handle NULL/ERR returns from ptp_clock_register()
      wifi: iwlwifi: mld: block EMLSR during TDLS connections

Avraham Stern (1):
      wifi: cfg80211: allow protected action frame TX for NAN

Benjamin Berg (1):
      wifi: mac80211: ignore reserved bits in reconfiguration status

Chad Monroe (5):
      wifi: mt76: fix deadlock in remain-on-channel
      wifi: mt76: mt7996: reset device after MCU message timeout
      wifi: mt76: mt7996: increase txq memory limit to 32 MiB
      wifi: mt76: fix multi-radio on-channel scanning
      wifi: mt76: support upgrading passive scans to active

Christian Hewitt (1):
      wifi: mt7601u: check multiple firmware paths

Colin Ian King (1):
      wifi: mt76: mt7996: Fix spelling mistake "retriving" -> "retrieving"

Daniel Gabay (1):
      wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces

David Bauer (2):
      wifi: mt76: mt76x02: wake queues after reconfig
      wifi: mt76: don't return TXQ when exceeding max non-AQL packets

Duoming Zhou (2):
      wifi: mt76: mt7915: fix use-after-free bugs in mt7915_mac_dump_work()
      wifi: mt76: mt7996: fix use-after-free bugs in mt7996_mac_dump_work()

Emmanuel Grumbach (28):
      wifi: cfg80211: support UNII-9 channels in ieee80211_channel_to_freq_khz
      wifi: iwlwifi: mld: add support for iwl_mcc_allowed_ap_type_cmd v2
      wifi: iwlwifi: ensure we don't read SAR values past the limit
      wifi: iwlwifi: uefi: decouple UEFI and firmware APIs
      wifi: iwlwifi: acpi: better use ARRAY_SIZE than a define
      wifi: iwlwifi: uefi: open code the PPAG table store operation
      wifi: iwlwifi: bring iwl_fill_ppag_table to the iwlmvm
      wifi: iwlwifi: regulatory: support a new command for PPAG
      wifi: iwlwifi: acpi: check the size of the ACPI PPAG tables
      wifi: iwlwifi: acpi: add support for PPAG rev5
      wifi: iwlwifi: uefi: add support for PPAG table rev5
      wifi: iwlwifi: mvm: zero iwl_geo_tx_power_profiles_cmd before sending
      wifi: iwlwifi: uefi: support the new WRDS and EWRD tables
      wifi: iwlwifi: acpi: add support for WRDS rev 3 table
      wifi: iwlwifi: acpi: add support for EWRD rev 3 table
      wifi: iwlwifi: mld: support version 11 of REDUCE_TX_POWER_CMD
      wifi: iwlwifi: uefi: open code the parsing of the WGDS table
      wifi: iwlwifi: uefi: add support for WGDS rev4
      wifi: iwlwifi: acpi: validate the WGDS table
      wifi: iwlwifi: acpi: add support for WGDS revision 4
      wifi: iwlwifi: support PER_CHAIN_LIMIT_OFFSET_CMD v6
      wifi: iwlwifi: uefi: mode the comments valid kerneldoc comments
      wifi: iwlwifi: remove IWL_MAX_WD_TIMEOUT
      wifi: iwlwifi: mld: remove SCAN_TIMEOUT_MSEC
      wifi: iwlwifi: mld: update the TLC when we deactivate a link
      wifi: iwlwifi: TLC_MNG_CONFIG_CMD can use several structures
      wifi: iwlwifi: fix the description of SESSION_PROTECTION_CMD
      wifi: iwlwifi: reduce the number of prints upon firmware crash

Felix Fietkau (9):
      wifi: mt76: add offchannel check to mt76_roc_complete
      wifi: mt76: check chanctx before restoring channel after ROC
      wifi: mt76: abort ROC on chanctx changes
      wifi: mt76: optimize ROC for same-channel case
      wifi: mt76: send nullfunc PS frames on offchannel transitions
      wifi: mt76: flush pending TX before channel switch
      wifi: mt76: route nullfunc frames to PSD/ALTX queue
      wifi: mt76: wait for firmware TX completion of mgmt frames before channel switch
      wifi: mt76: add per-link beacon monitoring for MLO

Gustavo A. R. Silva (1):
      wifi: ath6kl: wmi: Avoid -Wflex-array-member-not-at-end warning

Howard Hsu (1):
      wifi: mt76: mt7996: support critical packet mode for MT7990 chipsets

Ilan Peer (4):
      wifi: cfg80211: Add support for additional 7 GHz channels
      wifi: iwlwifi: mld: Refactor scan command handling
      wifi: iwlwifi: mld: Introduce scan command version 18
      wifi: ieee80211: Add some missing NAN definitions

Jeff Johnson (2):
      wifi: ath12k: Clean up the WMI Unit Test command interface
      wifi: ath12k: Remove unused DFS Unit Test definitions

Johan Hovold (5):
      wifi: ath6kl: drop redundant device reference
      wifi: ath6kl: rename disconnect callback
      wifi: ath9k: drop redundant device reference
      wifi: ath10k: drop redundant device reference
      wifi: ath10k: rename disconnect callback

Johannes Berg (17):
      Merge tag 'ath-next-20260324' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211_hwsim: advertise basic UHR support
      Merge tag 'mt76-next-2026-03-23' of https://github.com/nbd168/wireless
      wifi: iwlwifi: restrict TOP reset to some devices
      wifi: iwlwifi: mld: enable UHR in TLC
      wifi: iwlwifi: mld: set UHR MCS in RX status
      wifi: iwlwifi: mld: support changing iftype at runtime
      wifi: iwlwifi: use IWL_FW_CHECK for sync timeout
      wifi: iwlwifi: pcie: don't dump on reset handshake in dump
      wifi: iwlwifi: mld: make iwl_mld_mac80211_iftype_to_fw() static
      wifi: iwlwifi: mld: remove type argument from iwl_mld_add_sta()
      wifi: iwlwifi: mld: rename iwl_mld_phy_from_mac80211() argument
      wifi: iwlwifi: mld: make alloc functions not forced static
      wifi: iwlwifi: mld: add double-include guards to nan.h
      wifi: iwlwifi: add MAC context command version 4
      wifi: iwlwifi: mld: set RX_FLAG_RADIOTAP_TLV_AT_END generically
      Merge tag 'iwlwifi-next-2026-03-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into wireless-next

Kees Cook (1):
      wifi: mac80211: Replace strncpy() with strscpy_pad() in drv_switch_vif_chanctx tracepoint

Leon Yen (5):
      wifi: mt76: mt7925: introduce CSA support in non-MLO mode
      wifi: mt76: mt7925: Fix incorrect MLO mode in firmware control
      wifi: mt76: mt792x: Fix a potential deadlock in high-load situations
      wifi: mt76: mt7921: fix a potential clc buffer length underflow
      wifi: mt76: mt7925: fix tx power setting failure after chip reset

Lorenzo Bianconi (30):
      wifi: mt76: mt7996: Set mtxq->wcid just for primary link
      wifi: mt76: mt7996: Reset mtxq->idx if primary link is removed in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Switch to the secondary link if the default one is removed
      wifi: mt76: mt7996: Clear wcid pointer in mt7996_mac_sta_deinit_link()
      wifi: mt76: mt7996: Reset ampdu_state state in case of failure in mt7996_tx_check_aggr()
      wifi: mt76: Fix memory leak destroying device
      wifi: mt76: mt7996: Fix NPU stop procedure
      wifi: mt76: npu: Add missing rx_token_size initialization
      wifi: mt76: always enable RRO queues for non-MT7992 chipset
      wifi: mt76: mt7996: Fix BAND2 tx queues initialization when NPU is enabled
      wifi: mt76: mt7996: Fix wdma_idx for MT7996 device if NPU is enabled
      wifi: mt76: mt7996: Add mt7992_npu_txrx_offload_init routine
      wifi: mt76: mt7996: Rename mt7996_npu_rxd_init() in mt7992_npu_rxd_init()
      wifi: mt76: mt7996: Add NPU support for MT7990 chipset
      wifi: mt76: mt7996: Integrate NPU in RRO session management
      wifi: mt76: mt7996: Integrate MT7990 init configuration for NPU
      wifi: mt76: mt7996: Integrate MT7990 dma configuration for NPU
      wifi: mt76: mt7996: Add __mt7996_npu_hw_init routine
      wifi: mt76: mt7996: Move RRO dma start in a dedicated routine
      wifi: mt76: Do not reset idx for NPU tx queues during reset
      wifi: mt76: mt7996: Do not schedule RRO and TxFree queues during reset for NPU
      wifi: mt76: mt7996: Store DMA mapped buffer addresses in mt7996_npu_hw_init()
      wifi: mt76: Enable NPU support for MT7996 devices
      wifi: mt76: mt7996: Add missing CHANCTX_STA_CSA property
      wifi: mt76: mt7996: Remove link pointer dependency in mt7996_mac_sta_remove_links()
      wifi: mt76: mt7996: Remove unnecessary phy filed in mt7996_vif_link struct
      wifi: mt76: mt7996: Decrement sta counter removing the link in mt7996_mac_reset_sta_iter()
      wifi: mt76: mt7996: Rely on msta_link link_id in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Destroy vif active links in mt7996_remove_interface()
      wifi: mt76: mt7996: Destroy active sta links in mt7996_mac_sta_remove()

Madhur Kumar (1):
      wifi: mt76: mt7921: Replace deprecated PCI function

Manish Dharanenthiran (1):
      wifi: ath12k: Fix the assignment of logical link index

Marco Crivellari (3):
      wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
      wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
      wifi: iwlwifi: mvm: replace use of system_wq with system_percpu_wq

MeiChia Chiu (1):
      wifi: mt76: mt7996: Add eMLSR support

Michael Lo (2):
      wifi: mt76: mt7925: Skip scan process during suspend.
      wifi: mt76: mt7921: fix 6GHz regulatory update on connection

Ming Yen Hsieh (3):
      wifi: mt76: mt7925: fix incorrect length field in txpower command
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_tx_check_aggr()
      wifi: mt76: mt7925: prevent NULL vif dereference in mt7925_mac_write_txwi

Miri Korenblit (22):
      wifi: mac80211: use for_each_chanctx_user_* in one more place
      wifi: mac80211: make ieee80211_find_chanctx link-unaware
      wifi: mac80211: properly handle error in ieee80211_add_virtual_monitor
      wifi: mac80211: don't consider the sband when processing capabilities
      wifi: iwlwifi: mld: add support for sta command version 3
      wifi: iwlwifi: bump core version for BZ/SC/DR
      wifi: iwlwifi: validate the channels received in iwl_mcc_update_resp_v*
      wifi: iwlwifi: mld: use the dedicated helper to extract a link
      wifi: iwlwifi: mld: always assign a fw id to a vif
      wifi: iwlwifi: add a macro for max FW links
      wifi: iwlwifi: mld: introduce iwl_mld_vif_fw_id_valid
      wifi: mac80211: extract channel logic from link logic
      wifi: mac80211: cleanup error path of ieee80211_do_open
      wifi: cfg80211: Add an API to configure local NAN schedule
      wifi: cfg80211: make sure NAN chandefs are valid
      wifi: cfg80211: add support for NAN data interface
      wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
      wifi: nl80211: add support for NAN stations
      wifi: nl80211: define an API for configuring the NAN peer's schedule
      wifi: nl80211: allow reporting spurious NAN Data frames
      wifi: nl80211: add NL80211_CMD_NAN_ULW_UPDATE notification
      wifi: nl80211: Add a notification to notify NAN channel evacuation

Nidhish A N (1):
      wifi: iwlwifi: mvm: cleanup some more MLO code

P Praneesh (1):
      wifi: ath12k: Fix legacy rate mapping for monitor mode capture

Pagadala Yesu Anjaneyulu (4):
      wifi: iwlwifi: mld: remove unused scan expire time constants
      wifi: iwlwifi: fw: Add TLV support for BIOS revision of command
      wifi: iwlwifi: mld: eliminate duplicate WIDE_ID in PPAG command handling
      wifi: iwlwifi: mld: add BIOS revision compatibility check for PPAG command

Peter Chiu (3):
      wifi: mt76: mt7996: fix RRO EMU configuration
      wifi: mt76: mt7996: update WFSYS reset flow for MT7990 chipsets
      wifi: mt76: mt7996: fix frequency separation for station STR mode

Quan Zhou (3):
      wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
      wifi: mt76: mt7921: fix ROC abort flow interruption in mt7921_roc_work
      wifi: mt76: mt7925: fix incorrect TLV length in CLC command

Rex Lu (1):
      wifi: mt76: mt7996: adjust timeout value for boot-up calibration commands

Rory Little (1):
      wifi: mt76: mt7921: Place upper limit on station AID

Rosen Penev (1):
      wifi: b43: kzalloc + kcalloc to kzalloc_flex

Ryder Lee (4):
      wifi: mt76: mt7615: fix use_cts_prot support
      wifi: mt76: mt7915: fix use_cts_prot support
      wifi: mt76: mt7996: add support for ERP CTS & HT protection
      wifi: mt76: mt7996: Disable Rx hdr_trans in monitor mode

Sarika Sharma (1):
      wifi: ath12k: account TX stats only when ACK/BA status is present

Sean Wang (36):
      wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()
      wifi: mt76: mt7925: drop puncturing handling from BSS change path
      wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync
      wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync
      wifi: mt76: connac: use is_connac2() to replace is_mt7921() checks
      wifi: mt76: mt7921: use mt76_for_each_q_rx() in reset path
      wifi: mt76: mt7921: handle MT7902 irq_map quirk with mutable copy
      wifi: mt76: mt7921: add MT7902e DMA layout support
      wifi: mt76: connac: mark MT7902 as hw txp devices
      wifi: mt76: mt792x: add PSE handling barrier for the large MCU cmd
      wifi: mt76: mt792x: ensure MCU ready before ROM patch download
      wifi: mt76: mt7921: add MT7902 MCU support
      wifi: mt76: mt792x: add MT7902 WFDMA prefetch configuration
      wifi: mt76: mt7921: add MT7902 PCIe device support
      wifi: mt76: mt7921: add MT7902 SDIO device support
      wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
      wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
      wifi: mt76: mt7925: pass mlink to sta_amsdu_tlv()
      wifi: mt76: mt7925: pass WCID indices to bss_basic_tlv()
      wifi: mt76: mt7925: pass mlink and mconf to sta_mld_tlv()
      wifi: mt76: mt7925: pass mlink to mcu_sta_update()
      wifi: mt76: mt7925: resolve primary mlink via def_wcid
      wifi: mt76: mt7925: pass mlink to mac_link_sta_remove()
      wifi: mt76: mt7925: pass mlink to sta_hdr_trans_tlv()
      wifi: mt76: mt7925: validate mlink in sta_hdr_trans_tlv()
      wifi: mt76: mt7925: pass mlink to wtbl_update_hdr_trans()
      wifi: mt76: mt7925: pass mlink to set_link_key()
      wifi: mt76: mt7925: resolve link after acquiring mt76 mutex
      wifi: mt76: mt7925: pass mconf and mlink to wtbl_update_hdr_trans()
      wifi: mt76: mt7925: make WCID cleanup unconditional in sta_remove_links()
      wifi: mt76: mt7925: unwind WCID setup on link STA add failure
      wifi: mt76: mt7925: drop WCID reinit after publish
      wifi: mt76: mt7925: move WCID teardown into link_sta_remove()
      wifi: mt76: mt7925: switch link STA allocation to RCU lifetime
      wifi: mt76: mt7925: publish msta->link after successful link add
      wifi: mt76: mt7925: host-only unwind published links on add failure

Shayne Chen (8):
      wifi: mt76: mt7996: extend CSA and CCA support for MLO
      wifi: mt76: mt7996: add duplicated WTBL command
      wifi: mt76: mt7996: fix iface combination for different chipsets
      wifi: mt76: mt7996: add variant for MT7992 chipsets
      wifi: mt76: mt7996: fix wrong DMAD length when using MAC TXP
      wifi: mt76: mt7996: Account active links in valid_links fields
      wifi: mt76: mt7996: Move mlink deallocation in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Add mcu APIs to enable/disable vif links.

StanleyYP Wang (10):
      wifi: mt76: mt7996: fix the behavior of radar detection
      wifi: mt76: mt7996: set specific BSSINFO and STAREC commands after channel switch
      wifi: mt76: mt7996: abort CCA when CSA is starting
      wifi: mt76: mt7996: offload radar threshold initialization
      wifi: mt76: add external EEPROM support for mt799x chipsets
      wifi: mt76: mt7996: apply calibration-free data from OTP
      wifi: mt76: mt7996: fix struct mt7996_mcu_uni_event
      wifi: mt76: avoid to set ACK for MCU command if wait_resp is not set
      wifi: mt76: mt7996: fix queue pause after scan due to wrong channel switch reason
      wifi: mt76: mt7996: fix issues with manually triggered radar detection

Zac Bowling (1):
      wifi: mt76: fix list corruption in mt76_wcid_cleanup

Zilin Guan (1):
      wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()

Ziyi Guo (1):
      wifi: mt76: add missing lock protection in mt76_sta_state for sta_event callback

 drivers/net/wireless/ath/ath10k/usb.c              |   8 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |   4 +-
 drivers/net/wireless/ath/ath12k/core.h             |   2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.c           |  24 +-
 drivers/net/wireless/ath/ath12k/hal.h              |  31 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  67 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |  76 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  58 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  14 +-
 drivers/net/wireless/ath/ath6kl/usb.c              |  16 +-
 drivers/net/wireless/ath/ath6kl/wmi.h              |  11 -
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   4 -
 drivers/net/wireless/broadcom/b43/dma.c            |  18 +-
 drivers/net/wireless/broadcom/b43/dma.h            |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 132 ++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |  28 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    | 167 +++-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |   6 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  18 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |  37 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |  45 +
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |  69 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |  15 +
 drivers/net/wireless/intel/iwlwifi/fw/img.c        |  32 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |   8 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 151 +---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |  14 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       | 238 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       | 141 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  23 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  20 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |   1 -
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |  22 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |  15 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   2 +
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  52 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h       |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.h       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |   4 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    | 178 +++-
 .../net/wireless/intel/iwlwifi/mld/regulatory.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  25 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      | 224 +++--
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |   2 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |  50 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |  31 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |  78 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.h       |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 157 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |  46 --
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |  18 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 132 ---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   | 291 +------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   5 -
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   4 -
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |   6 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |  13 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |   2 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |  39 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  33 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |   4 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        | 154 +++-
 drivers/net/wireless/mediatek/mt76/mac80211.c      | 230 +++++-
 drivers/net/wireless/mediatek/mt76/mcu.c           |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  47 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |  15 -
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |  47 ++
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h   |   2 -
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  11 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  28 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  46 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  15 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  13 -
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  66 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |  11 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   4 +
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  29 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   3 +
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |  16 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |  70 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   4 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  18 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 394 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 194 +++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   7 +
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   7 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  14 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  18 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |   6 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |  51 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  36 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 208 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |  64 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 110 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 161 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    |   5 -
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 439 +++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 823 +++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    | 112 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  70 +-
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    | 469 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  11 +
 drivers/net/wireless/mediatek/mt76/npu.c           |  37 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |  70 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |  34 +-
 drivers/net/wireless/mediatek/mt7601u/mcu.c        |  15 +-
 drivers/net/wireless/mediatek/mt7601u/usb.h        |   1 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  35 +
 include/linux/ieee80211-nan.h                      |   7 +-
 include/linux/ieee80211.h                          |   7 +
 include/net/cfg80211.h                             | 265 +++++-
 include/uapi/linux/nl80211.h                       | 232 +++++-
 net/mac80211/cfg.c                                 |   4 +-
 net/mac80211/chan.c                                | 199 +++--
 net/mac80211/he.c                                  |  37 +-
 net/mac80211/ht.c                                  |   6 +-
 net/mac80211/ibss.c                                |   4 +-
 net/mac80211/ieee80211_i.h                         |  12 +-
 net/mac80211/iface.c                               |  28 +-
 net/mac80211/mesh_plink.c                          |   3 +-
 net/mac80211/mlme.c                                |  17 +-
 net/mac80211/rx.c                                  |   2 +
 net/mac80211/trace.h                               |   5 +-
 net/mac80211/util.c                                |   1 +
 net/mac80211/vht.c                                 |  33 +-
 net/wireless/chan.c                                |   6 +-
 net/wireless/core.c                                | 130 ++-
 net/wireless/core.h                                |  10 +
 net/wireless/mlme.c                                |  13 +-
 net/wireless/nl80211.c                             | 905 ++++++++++++++++++++-
 net/wireless/rdev-ops.h                            |  32 +
 net/wireless/reg.c                                 |  27 +-
 net/wireless/sysfs.c                               |  27 +-
 net/wireless/trace.h                               | 105 +++
 net/wireless/util.c                                |  28 +-
 166 files changed, 7131 insertions(+), 2321 deletions(-)

