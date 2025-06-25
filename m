Return-Path: <linux-wireless+bounces-24479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A4CAE8248
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 14:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EB616EFC7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67A1FF5EC;
	Wed, 25 Jun 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tl7YT0y7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C61E7C03;
	Wed, 25 Jun 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852903; cv=none; b=CAxHjA/WGdxT+fV1yoBdHUJTE12RNcLsPYL0kPSvA89qWzqVdO46EWCsiDLbhpXyTt/o45UXGPzbWAaPIcU3eRMfxQjzjSjfGooFRAWUXiJnIE6OTO3+AfXJhLgguc2QJCqXZtCF2LjkWhww/IK/G1YUz+/6HHJ/PM4BXXbNG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852903; c=relaxed/simple;
	bh=anD3OOOQzg17VqPK5JQZqmudq/wlh5Hyw3XjFlNgJXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgXCoOG84Nd9d3tmL0V/PPYD7xLx05JiOZnCFNU69uj/bEUhSFWbbFM7fdxL7iKGQu22iKOeZKmd4LwmGKXwhssqAtlLKhugfGpi11tFpjplfTLU+I6iLq92tmHi2qJU3cODjwFkk2gPCISeXvXSxWPQaMio14L/IiZZ8spybIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tl7YT0y7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=rguNhFVWRV04Fq1/8Rmsuz2olHxziGLrT6047DkZb44=; t=1750852901; x=1752062501; 
	b=tl7YT0y7Vrb7KXReZff2yXWrT6GWXzp67kO9D19iw918eYt6j86UyjrUoSMeLhCg4Zg9mivVU84
	jHuQpYRZk6Yz5GfGXxp3X+fnYVyZLTmLCH4/TT9d32W4mWfU8SrWj5R3Qb2EVlgK7I0/DklEosP0l
	RhPjpYZRZlCmJwR2gYtfJcDgZL9qIpcX+KY9e9j2Gu4mRpDBxRC8YRiKe3JVW/cuCn0c3izRXVbJL
	ubrmSpPVoeonM77SS3fXrHlueFQPkdlgVh4WyQKM403L0qSos1ivUp41fuGzEei1kBV0MppLUFw0t
	B1VY3AVeMrrgUTemun1vqbrfUzSMDhbudfTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUOos-00000009wdW-3myG;
	Wed, 25 Jun 2025 14:01:39 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-06-25
Date: Wed, 25 Jun 2025 14:00:22 +0200
Message-ID: <20250625120135.41933-55-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

And for -next quite a bit more, but not all that much
that really stands out either. iwlwifi picked up a bunch
of really old cleanups from patchwork "spring" cleaning,
and the rest just move along with regularly scheduled
feature additions. No known merge conflicts here either.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 62deb67fc519ee3b394f094982851d1ff3992731:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-19 13:00:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-06-25

for you to fetch changes up to c73ebc0dbb6ed968cb58d04d82ede3b5fb95e8bf:

  Merge tag 'iwlwifi-next-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-06-25 11:22:48 +0200)

----------------------------------------------------------------
The usual features/cleanups/etc., notably:
 - rtw88: IBSS mode for SDIO devices
 - rtw89:
   - BT coex for MLO/WiFi7
   - work on station + P2P concurrency
 - ath: fix W=2 export.h warnings
 - ath12k: fix scan on multi-radio devices
 - cfg80211/mac80211: MLO statistics
 - mac80211: S1G aggregation
 - cfg80211/mac80211: per-radio RTS threshold

----------------------------------------------------------------
Aditya Kumar Singh (3):
      wifi: ieee80211: add Radio Measurement action fields
      wifi: mac80211: Allow DFS/CSA on a radio if scan is ongoing on another radio
      wifi: ath12k: handle regulatory hints during mac registration

Arnd Bergmann (1):
      wifi: rtlwifi: avoid stack size warning for _read_eeprom_info

Baochen Qiang (2):
      wifi: ath12k: avoid bit operation on key flags
      wifi: ath12k: install pairwise key first

Bartosz Golaszewski (1):
      ssb: use new GPIO line value setter callbacks

Benjamin Berg (3):
      wifi: iwlwifi: move dBm averaging function into utils
      wifi: iwlwifi: mld: use the correct struct size for tracing
      wifi: iwlwifi: mld: advertise support for TTLM changes

Bitterblue Smith (2):
      wifi: rtw88: Rename the RTW_WCPU_11{AC,N} enums
      wifi: rtw88: Enable AP and adhoc modes for SDIO again

Chih-Kang Chang (11):
      wifi: rtw89: mcc: update format of RF notify MCC H2C command
      wifi: rtw89: mcc: correct frequency when MCC
      wifi: rtw89: mcc: adjust beacon filter when MCC and detect connection
      wifi: rtw89: mcc: stop TX during MCC prepare
      wifi: rtw89: TX nulldata 0 after scan complete
      wifi: rtw89: mcc: adjust TX nulldata early time from 3ms to 7ms
      wifi: rtw89: mcc: enlarge scan time of GC when GO in MCC
      wifi: rtw89: mcc: clear normal flow NoA when MCC start
      wifi: rtw89: mcc: use anchor pattern when bcn offset less than min of tob
      wifi: rtw89: mcc: enlarge TX retry count when GC auth
      wifi: rtw89: scan abort when assign/unassign_vif

Chin-Yen Lee (2):
      wifi: rtw88: pci: add PCI Express error handling
      wifi: rtw89: pci: add PCI Express error handling

Ching-Te Ku (20):
      wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.63.0
      wifi: rtw89: coex: Implement Wi-Fi MLO related logic
      wifi: rtw89: coex: Update Wi-Fi status logic for WiFi 7
      wifi: rtw89: coex: refine debug log with format version and readable string
      wifi: rtw89: coex: Add H2C command to collect driver outsource information to firmware
      wifi: rtw89: coex: Update Pre-AGC logic for WiFi 7
      wifi: rtw89: coex: Update BTG control for WiFi 7
      wifi: rtw89: coex: Update hardware PTA resource binding logic
      wifi: rtw89: coex: Add PTA grant signal setting offload to firmware feature
      wifi: rtw89: coex: Add v1 Bluetooth AFH handshake for WiFi 7
      wifi: rtw89: coex: Enable outsource info H2C command
      wifi: rtw89: coex: Query Bluetooth TX power when firmware support
      wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.71.0
      wifi: rtw89: coex: Get Bluetooth desired version by WiFi firmware version
      wifi: rtw89: coex: Update scoreboard to avoid Bluetooth re-link fail
      wifi: rtw89: coex: Assign priority table before entering power save
      wifi: rtw89: coex: Not to set slot duration to zero to avoid firmware issue
      wifi: rtw89: coex: Update Bluetooth slot length when Wi-Fi is scanning
      wifi: rtw89: coex: RTL8852B coexistence Wi-Fi firmware support for v0.29.122.0
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 9.0.0

Christophe JAILLET (1):
      wifi: rtlwifi: Constify struct rtl_hal_ops and rtl_hal_cfg

Colin Ian King (2):
      wifi: rtlwifi: rtl8821ae: make the read-only array params static const
      wifi: brcmfmac: Make read-only array cfg_offset static const

Dan Carpenter (1):
      wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()

Daniel Gabay (1):
      wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_retry_emlsr()

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Dr. David Alan Gilbert (3):
      wl1251: Remove unused wl1251_acx_rate_policies
      wl1251: Remove unused wl1251_cmd_*
      wifi: wlcore: Remove unused wl12xx_cmd_start_fwlog

Eric Huang (3):
      wifi: rtw89: add EHT physts and adjust init flow accordingly
      wifi: rtw89: update EDCCA report for subband 40M/80M/sub-20M
      wifi: rtw89: correct length for IE18/19 PHY report and IE parser

Fedor Pchelkin (3):
      wifi: rtw89: fix spelling mistake of RTW89_FLAG_FORBIDDEN_TRACK_WORK
      wifi: rtw89: sar: drop lockdep assertion in rtw89_set_sar_from_acpi
      wifi: rtw89: sar: do not assert wiphy lock held until probing is done

Gaosheng Cui (1):
      iwlwifi: remove unused no_sleep_autoadjust declaration

Gustavo A. R. Silva (1):
      wifi: iwlwifi: mvm: d3: Avoid -Wflex-array-member-not-at-end warnings

Heiner Kallweit (1):
      iwlwifi: use DECLARE_BITMAP macro

Ilan Peer (1):
      wifi: iwlwifi: mld: Block EMLSR when scanning on P2P Device

Itamar Shalev (2):
      wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_int_mlo_scan()
      wifi: iwlwifi: mvm: enable antenna selection for AX210 family

Jason Wang (1):
      iwlwifi: Fix comment typo

Jeff Johnson (5):
      wifi: ath: Add missing include of export.h
      wifi: ath9k: Add missing include of export.h
      wifi: ath10k: Add missing include of export.h
      wifi: ath11k: Add missing include of export.h
      wifi: ath12k: Add missing include of export.h

Jiasheng Jiang (1):
      iwlwifi: Add missing check for alloc_ordered_workqueue

Johannes Berg (22):
      wifi: iwlwifi: pcie: add missing TOP reset code
      Merge tag 'ath-next-20250624' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2025-06-25' of https://github.com/pkshih/rtw
      wifi: iwlwifi: pcie: initiate TOP reset if requested
      wifi: iwlwifi: mld: fix misspelling of 'established'
      wifi: iwlwifi: pcie: reinit device properly during TOP reset
      wifi: iwlwifi: pcie: abort D3 handshake on error
      wifi: iwlwifi: mld: add timer host wakeup debugfs
      wifi: iwlwifi: mld: remove special FW error resume handling
      wifi: iwlwifi: mld: fix last_mlo_scan_time type
      wifi: iwlwifi: defer MLO scan after link activation
      wifi: iwlwifi: dvm: fix some kernel-doc issues
      wifi: iwlwifi: pcie: fix kernel-doc warnings
      wifi: iwlwifi: mei: fix kernel-doc warnings
      wifi: iwlwifi: mvm: fix kernel-doc warnings
      wifi: iwlwifi: mld: make PHY config a debug message
      wifi: iwlwifi: fw: make PNVM version a debug message
      wifi: iwlwifi: make FSEQ version a debug message
      wifi: iwlwifi: add HE 1024QAM for <242-tone RU for PE
      wifi: iwlwifi: pcie: fix non-MSIX handshake register
      wifi: iwlwifi: mld: ftm: fix switch end indentation
      Merge tag 'iwlwifi-next-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Kang Yang (1):
      wifi: ath12k: update channel list in worker when wait flag is set

Karthik M (1):
      wifi: ath12k: disable pdev for non supported country

Karthikeyan Kathirvel (1):
      wifi: ath12k: Decrement TID on RX peer frag setup error handling

Kavita Kavita (2):
      wifi: cfg80211: Improve the documentation for NL80211_CMD_ASSOC_MLO_RECONF
      wifi: cfg80211: Add support for link reconfiguration negotiation offload to driver

Kuan-Chung Chen (5):
      wifi: rtw89: fix EHT 20MHz TX rate for non-AP STA
      wifi: rtw89: 8852c: increase beacon loss to 6 seconds
      wifi: rtw89: add chip_ops::chan_to_rf18_val to get code of RF register value
      wifi: rtw89: 8922a: pass channel information when enter LPS
      wifi: rtw89: mac: differentiate mem_page_size by chip generation

Lachlan Hodges (4):
      wifi: cfg80211: support configuration of S1G station capabilities
      wifi: mac80211: handle station association response with S1G
      wifi: mac80211: add support for storing station S1G capabilities
      wifi: mac80211: add support for S1G aggregation

Miri Korenblit (8):
      wifi: iwlwifi: mld: remove unneeded compilations
      wifi: iwlwifi: move iwl-context-info header files
      wifi: iwlwifi: bump minimum API version in BZ/SC/DR
      wifi: iwlwifi: pcie: move generation specific files to a folder
      wifi: iwlwifi: support RZL platform device ID
      wifi: iwlwifi: mld: make iwl_mld_add_all_rekeys void
      wifi: iwlwifi: mld: don't exit EMLSR when we shouldn't
      MAINTAINERS: update iwlwifi git link

Or Ron (1):
      wifi: iwlwifi: phy periph read - flow modification

P Praneesh (2):
      wifi: ath12k: remove monitor handling from ath12k_dp_rx_deliver_msdu()
      wifi: ath12k: Fix double budget decrement while reaping monitor ring

Pagadala Yesu Anjaneyulu (5):
      wifi: iwlwifi: parse VLP AP not allowed nvm channel flag
      wifi: iwlwifi: Remove unused cfg parameter from iwl_nvm_get_regdom_bw_flags
      wifi: iwlwifi: add support for the devcoredump
      wifi: iwlwifi: mld: Add dump handler to iwl_mld
      wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect

Ping-Ke Shih (2):
      wifi: rtw89: rfk: support IQK firmware command v1
      wifi: rtw89: mac: add dummy handler of MAC C2H event class 27

Rafael Beims (1):
      wifi: mwifiex: enable host mlme on sdio W8997 chipsets

Raj Kumar Bhagat (2):
      wifi: mac80211: Allow scan on a radio while operating on DFS on another radio
      wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0

Rameshkumar Sundaram (5):
      wifi: mac80211: Fix bssid_indicator for MBSSID in AP mode
      wifi: ath12k: Avoid accessing uninitialized arvif->ar during beacon miss
      wifi: ath12k: Prepare ahvif scan link for parallel scan
      wifi: ath12k: Split scan request for split band device
      wifi: ath12k: combine channel list for split-phy devices in single-wiphy

Ramya Gnanasekar (1):
      wifi: mac80211: update radar_required in channel context after channel switch

Rand Deeb (1):
      wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()

Roopni Devanathan (4):
      wifi: cfg80211/mac80211: Add support to get radio index
      wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
      wifi: cfg80211: Report per-radio RTS threshold to userspace
      wifi: mac80211: Set RTS threshold on per-radio basis

Rotem Kerem (3):
      wifi: iwlwifi: pcie: move iwl_trans_pcie_dump_regs() to utils.c
      wifi: iwlwifi: move iwl_trans_pcie_write_mem to iwl-trans.c
      wifi: iwlwifi: move _iwl_trans_set_bits_mask utilities

Ruffalo Lavoisier (1):
      iwlwifi: api: delete repeated words

Sarika Sharma (10):
      wifi: mac80211: add support towards MLO handling of station statistics
      wifi: cfg80211: add link_station_info structure to support MLO statistics
      wifi: cfg80211: extend to embed link level statistics in NL message
      wifi: cfg80211: add statistics for providing overview for MLO station
      wifi: cfg80211: allocate memory for link_station info structure
      wifi: mac80211: add support to accumulate removed link statistics
      wifi: cfg80211: clear sinfo->filled for MLO station statistics
      wifi: mac80211: extend support to fill link level sinfo structure
      wifi: mac80211: correct RX stats packet increment for multi-link
      wifi: mac80211: add link_sta_statistics ops to fill link station statistics

Stanislaw Gruszka (1):
      wifi: iwlegacy: Check rate_idx range after addition

Tamizh Chelvam Raja (1):
      wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type()

Thomas Fourier (2):
      wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
      wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.

Ting-Ying Li (1):
      wifi: brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists

Vasanthakumar Thiagarajan (1):
      wifi: cfg80211: Add utility API to get radio index from channel

Xiu Jianfeng (1):
      wifi: iwlwifi: Fix memory leak in iwl_mvm_init()

Yuesong Li (3):
      wifi: iwlegacy: convert to use secs_to_jiffies()
      wifi: ipw2x00: convert to use secs_to_jiffies
      wifi: iwlwifi: convert to use secs_to_jiffies()

Zheng Yongjun (1):
      iwlwifi: fw: simplify the iwl_fw_dbg_collect_trig()

Zong-Zhe Yang (8):
      wifi: rtw89: chan: concentrate the logic of setting/clearing chanctx bitmap
      wifi: rtw89: chan: re-config default chandef only when none is registered
      wifi: rtw89: implement channel switch support
      wifi: rtw89: fw: add RFE type to RF TSSI H2C command
      wifi: rtw89: extend HW scan of WiFi 6 chips for extra OP chan when concurrency
      wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role chanctx info
      wifi: rtw89: avoid NULL dereference when RX problematic packet on unsupported 6 GHz band
      wifi: rtw89: report boottime of receiving beacon and probe response

 MAINTAINERS                                        |    2 +-
 drivers/net/wireless/admtek/adm8211.c              |    2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |    5 +-
 drivers/net/wireless/ath/ath10k/bmi.c              |    2 +
 drivers/net/wireless/ath/ath10k/ce.c               |    2 +
 drivers/net/wireless/ath/ath10k/core.c             |    4 +-
 drivers/net/wireless/ath/ath10k/coredump.c         |    2 +
 drivers/net/wireless/ath/ath10k/debug.c            |    2 +
 drivers/net/wireless/ath/ath10k/htc.c              |    3 +
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    3 +
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    2 +
 drivers/net/wireless/ath/ath10k/hw.c               |    1 +
 drivers/net/wireless/ath/ath10k/hw.h               |    2 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   20 +-
 drivers/net/wireless/ath/ath10k/trace.c            |    2 +
 drivers/net/wireless/ath/ath11k/ce.c               |    2 +
 drivers/net/wireless/ath/ath11k/core.c             |    2 +
 drivers/net/wireless/ath/ath11k/coredump.c         |    2 +
 drivers/net/wireless/ath/ath11k/debug.c            |    2 +
 drivers/net/wireless/ath/ath11k/debugfs.c          |    2 +
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +
 drivers/net/wireless/ath/ath11k/fw.c               |    2 +
 drivers/net/wireless/ath/ath11k/hal.c              |    2 +
 drivers/net/wireless/ath/ath11k/mac.c              |   14 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |    2 +
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +
 drivers/net/wireless/ath/ath11k/trace.c            |    2 +
 drivers/net/wireless/ath/ath12k/core.c             |    7 +
 drivers/net/wireless/ath/ath12k/core.h             |   13 +-
 drivers/net/wireless/ath/ath12k/dp.c               |    1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c           |    1 -
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   18 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    5 +-
 drivers/net/wireless/ath/ath12k/hw.c               |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  441 +++++--
 drivers/net/wireless/ath/ath12k/mac.h              |    7 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |    3 +-
 drivers/net/wireless/ath/ath12k/reg.c              |  117 +-
 drivers/net/wireless/ath/ath12k/reg.h              |    3 +
 drivers/net/wireless/ath/ath12k/wmi.c              |   26 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    2 +
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |   12 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    7 +-
 drivers/net/wireless/ath/ath9k/common-beacon.c     |    1 +
 drivers/net/wireless/ath/ath9k/common-debug.c      |    1 +
 drivers/net/wireless/ath/ath9k/common-init.c       |    1 +
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    1 +
 drivers/net/wireless/ath/ath9k/common.c            |    1 +
 drivers/net/wireless/ath/ath9k/dynack.c            |    1 +
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   10 +-
 drivers/net/wireless/ath/ath9k/hw.c                |    1 +
 drivers/net/wireless/ath/ath9k/main.c              |    9 +-
 drivers/net/wireless/ath/carl9170/main.c           |    2 +-
 drivers/net/wireless/ath/main.c                    |    1 +
 drivers/net/wireless/ath/wcn36xx/main.c            |    5 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    3 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |    2 +-
 drivers/net/wireless/broadcom/b43/main.c           |    6 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |    2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   25 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    5 +
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   24 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    3 +-
 drivers/net/wireless/intel/ipw2x00/libipw_module.c |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    7 +-
 drivers/net/wireless/intel/iwlegacy/common.c       |    2 +-
 drivers/net/wireless/intel/iwlegacy/common.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    1 +
 drivers/net/wireless/intel/iwlwifi/Makefile        |    8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |   16 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |    2 +
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   11 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.h     |    2 -
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   34 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   49 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   10 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   18 +-
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c     |  113 +-
 drivers/net/wireless/intel/iwlwifi/iwl-utils.h     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h       |   30 +-
 drivers/net/wireless/intel/iwlwifi/mld/Makefile    |    4 -
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |   89 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |    5 +
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   15 +
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   15 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |    4 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   63 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   42 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |   20 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  129 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  117 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    3 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.h    |    8 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c |    6 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   12 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/internal.h     |   49 +-
 .../wireless/intel/iwlwifi/pcie/{ => gen1_2}/rx.c  |   34 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/trans-gen2.c   |    9 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/trans.c        |  182 +--
 .../intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c      |    0
 .../wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx.c  |   16 +-
 .../intel/iwlwifi/{ => pcie}/iwl-context-info-v2.h |    6 +-
 .../intel/iwlwifi/{ => pcie}/iwl-context-info.h    |    0
 drivers/net/wireless/intel/iwlwifi/pcie/utils.c    |  104 ++
 drivers/net/wireless/intel/iwlwifi/pcie/utils.h    |   38 +
 drivers/net/wireless/intel/iwlwifi/tests/Makefile  |    2 +-
 .../iwlwifi/{mvm/tests/scan.c => tests/utils.c}    |   43 +-
 drivers/net/wireless/intersil/p54/main.c           |    3 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   11 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |    2 +-
 drivers/net/wireless/marvell/mwl8k.c               |   12 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   11 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    4 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |    6 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   13 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    3 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   11 +-
 drivers/net/wireless/mediatek/mt7601u/main.c       |    5 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    7 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |    5 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    8 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h     |    3 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    8 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |    8 +-
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    5 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    8 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |    2 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   23 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   22 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    9 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   15 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   14 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   49 +-
 drivers/net/wireless/realtek/rtw88/pci.h           |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723de.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822be.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c     |    1 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |    8 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  347 +++++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   58 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 1309 +++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/coex.h          |    7 +
 drivers/net/wireless/realtek/rtw89/core.c          |  135 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  147 ++-
 drivers/net/wireless/realtek/rtw89/debug.c         |   13 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  314 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   49 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   68 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    6 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   88 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    1 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   37 +
 drivers/net/wireless/realtek/rtw89/pci.h           |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   96 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    1 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   26 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   46 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   52 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    5 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   11 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |    9 +-
 drivers/net/wireless/silabs/wfx/sta.c              |    4 +-
 drivers/net/wireless/silabs/wfx/sta.h              |    4 +-
 drivers/net/wireless/st/cw1200/sta.c               |    5 +-
 drivers/net/wireless/st/cw1200/sta.h               |    5 +-
 drivers/net/wireless/ti/wl1251/acx.c               |   35 -
 drivers/net/wireless/ti/wl1251/acx.h               |    1 -
 drivers/net/wireless/ti/wl1251/cmd.c               |   79 --
 drivers/net/wireless/ti/wl1251/cmd.h               |    3 -
 drivers/net/wireless/ti/wl1251/main.c              |    5 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |   26 -
 drivers/net/wireless/ti/wlcore/cmd.h               |    1 -
 drivers/net/wireless/ti/wlcore/main.c              |    8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    6 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |    2 +-
 drivers/ssb/driver_gpio.c                          |    8 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    6 +-
 include/linux/ieee80211.h                          |   10 +
 include/net/cfg80211.h                             |  170 ++-
 include/net/mac80211.h                             |   35 +-
 include/uapi/linux/nl80211.h                       |   22 +-
 net/mac80211/agg-rx.c                              |    6 +-
 net/mac80211/agg-tx.c                              |    3 +-
 net/mac80211/cfg.c                                 |  117 +-
 net/mac80211/chan.c                                |   33 +-
 net/mac80211/driver-ops.h                          |   55 +-
 net/mac80211/ibss.c                                |    4 +-
 net/mac80211/ieee80211_i.h                         |   14 +-
 net/mac80211/iface.c                               |    6 +-
 net/mac80211/main.c                                |    9 +-
 net/mac80211/mlme.c                                |   18 +-
 net/mac80211/offchannel.c                          |    7 +-
 net/mac80211/pm.c                                  |    2 +-
 net/mac80211/rx.c                                  |   15 +-
 net/mac80211/s1g.c                                 |   26 +
 net/mac80211/scan.c                                |   20 +-
 net/mac80211/sta_info.c                            |  417 ++++++-
 net/mac80211/sta_info.h                            |   59 +-
 net/mac80211/trace.h                               |  115 +-
 net/mac80211/tx.c                                  |    7 +-
 net/mac80211/util.c                                |   65 +-
 net/wireless/core.c                                |   19 +
 net/wireless/mlme.c                                |   10 +-
 net/wireless/nl80211.c                             |  539 +++++++-
 net/wireless/rdev-ops.h                            |   39 +-
 net/wireless/trace.h                               |   89 +-
 net/wireless/util.c                                |   36 +
 net/wireless/wext-compat.c                         |   10 +-
 291 files changed, 5840 insertions(+), 1906 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/internal.h (97%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/rx.c (98%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans-gen2.c (98%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans.c (95%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c (100%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx.c (99%)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info-v2.h (98%)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info.h (100%)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.h
 rename drivers/net/wireless/intel/iwlwifi/{mvm/tests/scan.c => tests/utils.c} (63%)

