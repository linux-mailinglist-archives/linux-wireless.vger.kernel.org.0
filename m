Return-Path: <linux-wireless+bounces-31315-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vK1VMOY+e2mNCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31315-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:05:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A115AF5F3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 236973018BD3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A20341057;
	Thu, 29 Jan 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tIuegNJF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546FC37F73D;
	Thu, 29 Jan 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684512; cv=none; b=SdY5/DXbksXX0X7tNym3dB5uicjofxjQISGYwfPQ1AK7zGEbk8V6Z7/vck8EbUj5IujXWiRZiCDkM5lzaRk9tfcrXCFtwVymiXXOYqx8Fl87irMvDFisfSrFtDLbSc2l0sqdSZiOnFaqc/MU8ri22Ke0tv2TNaJAyS9chjvb420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684512; c=relaxed/simple;
	bh=e3Hsibd2scfyaNl/eYDwoA7iNyrSBKum6o+J2tzDyf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L9vxr/cwkBzJgo6Wrbkn4sqEQ0OSvGGocWeAU+yar5j0IU3RRl++lcof1OCCz9m5ODQ6i7D0cJiqqaSS/aHXfXF2U6rCEgFKokah29zT0oUwanM0EhAt2WZedUXiCgPUC4yaztSaGRNW1xFwOdCwoneOVz6qcpZgJOcYUQPQZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tIuegNJF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QXx/Un/eEoqX0/gXI6Tw6sHWb7DRBAfyyinfq83a7J0=; t=1769684510; x=1770894110; 
	b=tIuegNJFq7r/JdlBdwpZDpMKJoI51Z0fH3KpkAVtU/QnYBvzs3BHblc9MJtp7RuLXEJr/PrpVSb
	8D7VZUclcnz3DVHMGAPi444dvWQcUlR1l4aOBebX5MBmdvTKY3mksevn9z1Y79aEN6zMY3DFcFFpo
	qBsYWiRTV6H+t1a/hI9yhTQj97H6ovE292at4PbGZASa4KQJtT4N+zLIn6n5bRn2TjaP5wIT8raXs
	t2Toug8OtdgS5oJchDP7lsbvwG+uL+4GIZ7s9E62+ZuhoUzcWfpwqS4ooJjcYyVey+OGaql/0qIn0
	iLXp+i0DmsoW3HFOWbxjFrvBk7mwjEqy8Ugg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlPmQ-00000006nmA-0sHB;
	Thu, 29 Jan 2026 12:01:42 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-01-29
Date: Thu, 29 Jan 2026 11:58:31 +0100
Message-ID: <20260129110136.176980-39-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31315-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A115AF5F3
X-Rspamd-Action: no action

Hi,

Here's another set of changes for net-next. Two things to note:

 1) This introduces a couple of new sparse warnings, because it
    cannot deal with guard(spinlock_bh)() which the drivers are
    now using. I previously fixed sparse for that for RCU, but
    given the context tracking work will remove this validation
    from sparse entirely, I haven't bothered trying to keep up.

 2) There's a core SDIO patch in here, but that's intentional
    and we agreed with the maintainer to merge it through this
    tree since only two wireless changes depend on it.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 669aa3e3faa8ae876c169cde5b234828275caef8:

  Merge tag 'wireless-next-2026-01-12' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2026-01-12 17:02:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-01-29

for you to fetch changes up to c30e188bd2a886258be5facb970a804d8ef549b5:

  Merge tag 'iwlwifi-next-2026-01-21' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2026-01-27 13:54:12 +0100)

----------------------------------------------------------------
Another fairly large set of changes, notably:
 - cfg80211/mac80211
    - most of EPPKE/802.1X over auth frames support
    - additional FTM capabilities
    - split up drop reasons better, removing generic RX_DROP
    - NAN cleanups/fixes
 - ath11k:
    - support for Channel Frequency Response measurement
 - ath12k:
    - support for the QCC2072 chipset
 - iwlwifi:
    - partial NAN support
    - UNII-9 support
    - some UHR/802.11bn FW APIs
    - remove most of MLO/EHT from iwlmvm
      (such devices use iwlmld)
 - rtw89:
    - preparations for RTL8922DE support

----------------------------------------------------------------
Ainy Kumari (2):
      wifi: cfg80211: add support for EPPKE Authentication Protocol
      wifi: cfg80211: add feature flag for (re)association frame encryption

Alexander Minchev (1):
      wifi: ath12k: remove redundant pci_set_drvdata() call

Alexandru Gagniuc (1):
      wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params

Ali Tariq (1):
      wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add

Ally Heev (1):
      wifi: iwlwifi: mld: remove unused variable in d3.c

Avraham Stern (4):
      wifi: nl80211/cfg80211: add new FTM capabilities
      wifi: nl80211/cfg80211: clarify periodic FTM parameters for non-EDCA based ranging
      wifi: nl80211/cfg80211: add negotiated burst period to FTM result
      wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request

Baochen Qiang (18):
      wifi: ath12k: do WoW offloads only on primary link
      wifi: ath12k: refactor PCI window register access
      wifi: ath12k: refactor REO CMD ring handling
      wifi: ath12k: refactor REO status ring handling
      wifi: ath12k: fix preferred hardware mode calculation
      wifi: ath12k: refactor 320 MHz bandwidth support parsing
      wifi: ath12k: fix mac phy capability parsing
      wifi: ath12k: add hardware registers for QCC2072
      wifi: ath12k: add hardware parameters for QCC2072
      wifi: ath12k: support LPASS_SHARED target memory type
      wifi: ath12k: support downloading auxiliary ucode image for QCC2072
      wifi: ath12k: add HAL descriptor and ops for QCC2072
      wifi: ath12k: add hardware ops support for QCC2072
      wifi: ath12k: handle REO CMD ring for QCC2072
      wifi: ath12k: handle REO status ring for QCC2072
      wifi: ath12k: limit number of channels per WMI command
      wifi: ath12k: send peer meta data version to firmware
      wifi: ath12k: enable QCC2072 support

Benjamin Berg (2):
      wifi: iwlwifi: mld: decode VHT information for sniffer
      wifi: iwlwifi: mld: change cluster_id type to u8 array

Bitterblue Smith (4):
      wifi: rtw88: 8822b: Avoid WARNING in rtw8822b_config_trx_mode()
      wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()
      wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()
      wifi: rtw88: Fix inadvertent sharing of struct ieee80211_supported_band data

Chia-Yuan Li (1):
      wifi: rtw89: coex: update coex software control for RTL8922D

Chien Wong (1):
      wifi: ath11k: fix comment typo in monitor mode handling

Chih-Kang Chang (7):
      wifi: rtw89: refine C2H reg event polling timeout for LPS
      wifi: rtw89: setting TBTT AGG number when mac port initialization
      wifi: rtw89: mcc: reset probe counter when receiving beacon
      wifi: rtw89: refine TX nulldata judgement when scan with 2 OP channels
      wifi: rtw89: 8922a: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: rfk: add rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7 firmware
      wifi: rtw89: rfk: update rtw89_fw_h2c_rf_pre_ntfy_mcc format

Chin-Yen Lee (4):
      wifi: rtw89: wow: use struct style to fill WOW CAM H2C command
      wifi: rtw89: wow: add WOW_CAM update function for 8922D
      wifi: rtw89: wow: abstract DMA check register for RTL8922DE
      wifi: rtw89: wow: add reason codes for disassociation in WoWLAN mode

Dan Carpenter (1):
      wifi: ath12k: clean up on error in ath12k_dp_setup()

Daniel Gabay (2):
      wifi: iwlwifi: mld: Remove wrong channel flags in scan cmd
      wifi: iwlwifi: mvm: Remove few redundant 6 GHz scan chan params

David Yang (1):
      wifi: mac80211: use u64_stats_t with u64_stats_sync properly

Dian-Syuan Yang (2):
      wifi: rtw89: enhance connection stability when triggering beacon loss
      wifi: rtw89: 8852b: refine hardware parameters for RFE type 5

Emmanuel Grumbach (8):
      wifi: iwlwifi: mld: trigger a dump upon notification if needed
      wifi: iwlwifi: move lari helper functions to the op_mode
      wifi: iwlwifi: move iwl_get_lari_config_bitmap to the op_mode
      wifi: iwlwifi: acpi: cache the DSM functions
      wifi: iwlwifi: uefi: cache the DSM functions
      wifi: iwlwifi: split bios_value_u32 to separate the header
      wifi: iwlwifi: support V13 of iwl_lari_config_change_cmd
      wifi: iwlwifi: rename struct iwl_mcc_allowed_ap_type_cmd::offset_map

Hsiu-Ming Chang (1):
      wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H

Ilan Peer (6):
      wifi: iwlwifi: mld: Add support for NAN
      wifi: iwlwifi: mld: Handle rate selection for NAN interface
      wifi: iwlwifi: mld: Declare support for NAN capabilities
      wifi: iwlwifi: mld: Extend the NAN configuration
      wifi: iwlwifi: mld: Support changing NAN configuration
      wifi: iwlwifi: mld: Advertise support for multicast RX registration

Jan Gerber (1):
      wifi: rtw89: 8852au: add support for TP TX30U Plus

Johannes Berg (12):
      Merge tag 'rtw-next-2026-01-15' of https://github.com/pkshih/rtw
      wifi: mac80211: remove RX_DROP
      wifi: mac80211: mark iface work SKBs as consumed
      wifi: iwlwifi: fix 22000 series SMEM parsing
      wifi: iwlwifi: adjust LINK context NPCA API
      wifi: iwlwifi: add UHR TLC mode
      wifi: iwlwifi: fw: api: add UHR data definitions
      wifi: iwlwifi: mld: fix HE SIG-B MCS/DCM/compression
      wifi: iwlwifi: fw: api: add HE type for UHR ELR
      wifi: iwlwifi: cfg: remove iwl_be221_name
      Merge tag 'ath-next-20260120' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-next-2026-01-21' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Jose Ignacio Tornos Martinez (1):
      wifi: rtw89: 8922a: set random mac if efuse contains zeroes

Kavita Kavita (5):
      wifi: cfg80211: add support for key configuration before association
      wifi: mac80211: allow key installation before association
      wifi: mac80211: Check for MLE before appending in Authentication frame
      wifi: mac80211: add support for EPPKE authentication protocol in non-AP STA mode
      wifi: mac80211: add support for encryption/decryption of (Re)Association frames

Krzysztof Kozlowski (1):
      dt-bindings: net: wireless: ath11k: Combine two if:then: clauses

Kuan-Chung Chen (6):
      wifi: rtw89: 8852b: increase beacon loss to 6 seconds
      wifi: rtw89: mlo: fix missing TX null-data 1 during link switch
      wifi: rtw89: mlo: fix incorrect link address in management frames
      wifi: rtw89: define TX/RX aggregation and MPDU capability per chip
      wifi: rtw89: fix potential zero beacon interval in beacon tracking
      wifi: rtw89: support EHT GI/LTF setting

Lachlan Hodges (1):
      wifi: cfg80211: don't apply HT flags to S1G channels

Marco Crivellari (1):
      wifi: rtw89: add WQ_PERCPU to alloc_workqueue users

Martin Hrůza (1):
      wifi: rtw88: Increase the RX gain before scanning

Miaoqing Pan (1):
      wifi: ath12k: fix PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072

Miri Korenblit (11):
      wifi: cfg80211: allow only one NAN interface, also in multi radio
      wifi: cfg80211: stop NAN and P2P in cfg80211_leave
      wifi: cfg80211: limit NAN func management APIs to offloaded DE
      wifi: cfg80211: cleanup cluster_id when stopping NAN
      wifi: nl80211: ignore cluster id after NAN started
      wifi: iwlwifi: mvm: check the validity of noa_len
      wifi: iwlwifi: mld: support TLC command version 6
      wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file
      wifi: iwlwifi: mld: fix chandef start calculation
      wifi: iwlwifi: mld: add an helper to update an EMLSR blocker
      wifi: iwlwifi: mld: prevent EMLSR when NAN is active

Nidhish A N (3):
      wifi: iwlwifi: mld: Fix primary link selection logic
      wifi: iwlwifi: mvm: Cleanup MLO code
      wifi: iwlwifi: mvm: Remove link_id from time_events

Pagadala Yesu Anjaneyulu (3):
      wifi: iwlwifi: fw: fix documentation reference for ap_type field
      wifi: iwlwifi: mld: refactor AP power type setting
      wifi: cfg80211: treat deprecated INDOOR_SP_AP_OLD control value as LPI mode

Peter Åstrand (1):
      wifi: wlcore: Add support for IGTK key

Ping-Ke Shih (36):
      wifi: rtw89: correct use sequence of driver_data in skb->info
      wifi: rtw89: mac: reset power state before switching to power on
      wifi: rtw89: warn unexpected polling value of XTAL SI
      wifi: rtw89: wow: change type of WoWLAN pattern mask to __le32
      wifi: rtw89: efuse: read hardware version from efuse for WiFi 7 chips
      wifi: rtw89: read chip ID for RTL8922D variants
      wifi: rtw89: add default quirks as features to chip_info
      wifi: rtw89: rfk: update RFK pre info V2 for RTL8922D
      wifi: rtw89: update TXWD v3 for RTL8922D
      wifi: rtw89: update query RXDESC v3 for RTL8922D
      wifi: rtw89: fw: add DMAC v3 H2C command for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command to initialize default value for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for association for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for TX AMPDU for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for TX time for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for punctured for RTL8922D
      wifi: rtw89: fw: consider hardware AID for firmware elements
      wifi: rtw89: fw: set RACK bit every 4 H2C command for WiFi 6 chips only
      wifi: rtw89: coex: make coex scoreboard as chip info
      wifi: rtw89: coex: update scoreboard value according to power state for two BT
      wifi: rtw89: mac: remove unnecessary return from rtw89_fwdl_secure_idmem_share_mode()
      wifi: rtw89: mac: add dle_mem and ple_{min,max}_qt quota for RTL8922D
      wifi: rtw89: mac: set quota 13 for PLE SNRPT
      wifi: rtw89: mac: update MPDU quota according to chip DLE definition
      wifi: rtw89: mac: update WP quota for RTL8922D
      wifi: rtw89: mac: define preload_init for generations
      wifi: rtw89: mac: configure DMA_STOP1 by predefined mask
      wifi: rtw89: mac: separate functions of CMAC power and function enable
      wifi: rtw89: mac: add an entry to enable MAC function in preinit
      wifi: rtw89: mac: set EDCCA configurations for RTL8922D
      wifi: rtw89: pci: validate sequence number of TX release report
      wifi: rtw89: disable EHT protocol by chip capabilities
      wifi: rtw89: align CUSTID defined by firmware
      wifi: rtw89: mac: correct page number for CSI response
      wifi: rtw89: mac: consider RTL8922D in MAC common flow
      wifi: rtw89: pci: consider RTL8922D in PCI common flow

Qian Zhang (1):
      wifi: ath11k: Fix failure to connect to a 6 GHz AP

Randy Dunlap (4):
      wifi: ath5k: debug.h: fix enum ath5k_debug_level kernel-doc
      wifi: ath9k: debug.h: fix kernel-doc bad lines and struct ath_tx_stats
      wifi: ath9k: fix kernel-doc warnings in common-debug.h
      wifi: wil6210: fix a bunch of kernel-doc warnings

Rohit Chourasia (1):
      wifi: rtlwifi: fix typo 'received' in comment

Roman Peshkichev (1):
      wifi: rtw88: fix DTIM period handling when conf->dtim_period is zero

Rosen Penev (1):
      wifi: ath9k: add OF dependency to AHB

Ross Vandegrift (1):
      wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1

Sai Pratyusha Magam (1):
      wifi: nl80211: Add support for EPP peer indication

Uwe Kleine-König (3):
      sdio: Provide a bustype shutdown function
      wifi: rsi: sdio: Migrate to use sdio specific shutdown function
      wifi: rtw88: sdio: Migrate to use sdio specific shutdown function

Venkateswara Naralasetty (6):
      wifi: ath11k: Add initialization and deinitialization sequence for CFR module
      wifi: ath11k: Register debugfs for CFR configuration
      wifi: ath11k: Add support unassociated client CFR
      wifi: ath11k: Register relayfs entries for CFR dump
      wifi: ath11k: Register DBR event handler for CFR data
      wifi: ath11k: Register handler for CFR capture event

Zenm Chen (2):
      wifi: rtw89: Add support for MSI AX1800 Nano (GUAX18N)
      wifi: rtw89: Add support for D-Link VR Air Bridge (DWA-F18)

Zilin Guan (1):
      wifi: p54: Fix memory leak in p54_beacon_update()

Ziyi Guo (2):
      wifi: iwlegacy: add missing mutex protection in il3945_store_measurement()
      wifi: iwlegacy: add missing mutex protection in il4965_store_tx_power()

Zong-Zhe Yang (11):
      wifi: rtw89: ser: enable error IMR after recovering from L1
      wifi: rtw89: ser: L1 skip polling status if FW runs event mode
      wifi: rtw89: debug: add ser_counters dbgfs
      wifi: rtw89: debug: support SER L0/L1 simulation via halt H2C
      wifi: rtw89: regd: 6 GHz power type marks default when inactive
      wifi: rtw89: pre-handle RF calibration on link when needed
      wifi: rtw89: fw: change FW feature map to a BITMAP
      wifi: rtw89: fw: introduce helper for disabling FW feature configuration
      wifi: rtw89: 8922a: tweak RFK_PRE_NOTIFY FW feature configuration to align handling
      wifi: rtw89: refine mis-ordered entries in FW feature table
      wifi: rtw89: fw: change WITH_RFK_PRE_NOTIFY to be a FW feature group

 .../bindings/net/wireless/qcom,ath11k.yaml         |    9 -
 drivers/mmc/core/sdio_bus.c                        |   25 +
 drivers/net/wireless/ath/ath11k/Kconfig            |   11 +
 drivers/net/wireless/ath/ath11k/Makefile           |    1 +
 drivers/net/wireless/ath/ath11k/cfr.c              | 1023 ++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h              |  308 ++++++
 drivers/net/wireless/ath/ath11k/core.c             |   81 +-
 drivers/net/wireless/ath/ath11k/core.h             |   19 +-
 drivers/net/wireless/ath/ath11k/dbring.c           |   50 +-
 drivers/net/wireless/ath/ath11k/dbring.h           |    8 +-
 drivers/net/wireless/ath/ath11k/debug.h            |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |  142 ++-
 drivers/net/wireless/ath/ath11k/dp.c               |   12 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    1 -
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    9 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    3 +-
 drivers/net/wireless/ath/ath11k/hw.c               |   19 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    8 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   23 +-
 drivers/net/wireless/ath/ath11k/reg.c              |    9 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h              |   97 +-
 drivers/net/wireless/ath/ath12k/core.h             |    3 +
 drivers/net/wireless/ath/ath12k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath12k/fw.c               |   10 +-
 drivers/net/wireless/ath/ath12k/fw.h               |    3 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   46 +
 drivers/net/wireless/ath/ath12k/hal.h              |   34 +
 drivers/net/wireless/ath/ath12k/hw.h               |    2 +
 drivers/net/wireless/ath/ath12k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   18 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    7 +
 drivers/net/wireless/ath/ath12k/qmi.c              |  180 +++-
 drivers/net/wireless/ath/ath12k/qmi.h              |   16 +
 drivers/net/wireless/ath/ath12k/wifi7/Makefile     |    3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |   62 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |    1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |    8 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |    3 -
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h   |   33 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |  503 ++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |   13 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |    8 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     |   97 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |   30 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx_desc.h    |   17 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |    8 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |    1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  101 ++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c        |   26 +-
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |    5 +
 drivers/net/wireless/ath/ath12k/wmi.c              |   54 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    7 +
 drivers/net/wireless/ath/ath12k/wow.c              |   16 +
 drivers/net/wireless/ath/ath5k/debug.h             |    4 +-
 drivers/net/wireless/ath/ath9k/Kconfig             |    2 +-
 drivers/net/wireless/ath/ath9k/common-debug.h      |    8 +-
 drivers/net/wireless/ath/ath9k/debug.h             |   15 +-
 drivers/net/wireless/ath/wil6210/wil6210.h         |   33 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    2 +
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   12 -
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |   12 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  121 ++-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  159 ++-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   34 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |   41 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   95 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  206 +---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   17 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c       |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   74 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    1 -
 drivers/net/wireless/intel/iwlwifi/mld/Makefile    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    2 -
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   21 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  114 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |    3 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |    3 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   59 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |    5 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |  299 ++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h       |   28 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   13 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.h     |    1 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |   39 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |   64 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  142 ++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |   12 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |    3 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |   85 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |   11 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  202 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   22 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   68 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   29 -
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  193 +---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   60 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    8 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   39 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    4 -
 drivers/net/wireless/intersil/p54/main.c           |    4 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    1 +
 drivers/net/wireless/realtek/rtlwifi/regd.c        |    2 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   54 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    2 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |   20 +
 drivers/net/wireless/realtek/rtw88/phy.h           |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    3 +-
 drivers/net/wireless/realtek/rtw88/sdio.h          |    2 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |  134 +++
 drivers/net/wireless/realtek/rtw89/cam.h           |  129 +++
 drivers/net/wireless/realtek/rtw89/chan.c          |   38 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    2 +
 drivers/net/wireless/realtek/rtw89/core.c          |  237 ++++-
 drivers/net/wireless/realtek/rtw89/core.h          |  158 ++-
 drivers/net/wireless/realtek/rtw89/debug.c         |   79 ++
 drivers/net/wireless/realtek/rtw89/efuse.c         |    4 -
 drivers/net/wireless/realtek/rtw89/efuse.h         |    6 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |   26 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  866 +++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h            |  331 +++++--
 drivers/net/wireless/realtek/rtw89/mac.c           |  176 +++-
 drivers/net/wireless/realtek/rtw89/mac.h           |   79 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   40 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  675 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.c           |    7 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   56 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  136 ++-
 drivers/net/wireless/realtek/rtw89/phy.c           |   57 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |    2 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  566 ++++++++++-
 drivers/net/wireless/realtek/rtw89/regd.c          |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    9 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    9 +-
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   31 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |    2 -
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    7 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    9 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   31 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   48 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   10 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |   22 +
 drivers/net/wireless/realtek/rtw89/usb.c           |    2 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |    8 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |    1 +
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |    5 +-
 drivers/net/wireless/ti/wlcore/cmd.h               |    1 +
 drivers/net/wireless/ti/wlcore/main.c              |    9 +
 include/linux/ieee80211.h                          |    1 +
 include/linux/mmc/sdio_func.h                      |    1 +
 include/net/cfg80211.h                             |   37 +-
 include/net/mac80211.h                             |    2 +
 include/uapi/linux/nl80211.h                       |   73 +-
 net/mac80211/cfg.c                                 |   15 +-
 net/mac80211/drop.h                                |   46 +-
 net/mac80211/ieee80211_i.h                         |   10 +-
 net/mac80211/iface.c                               |    6 +-
 net/mac80211/mlme.c                                |   47 +-
 net/mac80211/rx.c                                  |  114 ++-
 net/mac80211/sta_info.c                            |   22 +-
 net/mac80211/sta_info.h                            |    4 +-
 net/mac80211/tx.c                                  |    4 +-
 net/mac80211/util.c                                |   12 +-
 net/mac80211/wpa.c                                 |    6 +-
 net/wireless/core.c                                |   14 +-
 net/wireless/nl80211.c                             |   67 +-
 net/wireless/pmsr.c                                |   27 +-
 net/wireless/reg.c                                 |   11 +-
 194 files changed, 8876 insertions(+), 1685 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.h

