Return-Path: <linux-wireless+bounces-25990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC0CB10757
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 12:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22AC542752
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812D25E479;
	Thu, 24 Jul 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rGNA7gqS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57225D549;
	Thu, 24 Jul 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351437; cv=none; b=EE8d9/VlQqpUQmaQ+eayCIayBWFFYIEoY4L3AJZTL7qI25/fGYLssFmULMSWPfddSc0lrH/0IqmV62gGsCMs93iC/guNipbzVHyY82ytl2qs3u993EciYnrVAk/8z3jGLfzMGrC2JZOCunauaeeNJG5xCI+nAMDNIze4P19FTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351437; c=relaxed/simple;
	bh=gsRtiXdZS5lM06FzaiOTossgHZ8FTxZwCtuMClHbfTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8o0/FPGdssq591NsU2vXLWXPSm4blfAGDfkmZ81jipTJe65GvugLTVzSmhQGHtpcAkykAMje5ElHAQT8Hx/+p9uKg4L0atwrPKVkGTNpB4OBxRQhDmzGlQYW97bSVuTpym3piyed1y9UMvk0S8U3Ex7PnmZQPZbkuBDwpKY7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rGNA7gqS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ImSe7NI523x+uBsFdqyZwKKNuOgKspPgmwCtKmmhqbY=; t=1753351434; x=1754561034; 
	b=rGNA7gqS+dQqPtuK9UdN3/gIQYS+cMNlbGXUsF1fvQgZ/i2iLA5n+Wvj8X3V56kzhn2ELZlBDKL
	riuROALKiZmR/pO4qq154lcBNrpnjoYsEmDqk2kTpbRXMhu8uXaxf+KGG3hYbKrwSrlelBTyIiqhY
	rEAQu0OUFU4iMDSrjs0kM3PHFhz6/RLg3R8J3zOfI1bzIBmr69r1fM7fchxCxHWX4nKpypS7aUjeO
	Peu4ebX5XbLAIimgRc7aqAqSAp0+hMurmehBcwq11PWmqLTgfeW9qFv7F8gXAYOrZh8wO1Js3DILu
	tQP+QAgRVPmmT0mvxZs9dQrXtGiD4GMgPopQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uesno-00000005Ngt-0ALb;
	Thu, 24 Jul 2025 12:03:52 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL net-next] wireless-next-2025-07-24
Date: Thu, 24 Jul 2025 12:02:42 +0200
Message-ID: <20250724100349.21564-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here's another, almost certainly final, set of changes
for -next. If we (unexpectedly) get -rc8 _and_ there's
something important to fix immediately I might send more,
but at this point that seem unlikely.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit af2d6148d2a159e1a0862bce5a2c88c1618a2b27:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-17 11:00:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-07-24

for you to fetch changes up to 55c172c13718b93300d3808b65ec326b5287c766:

  ssb: use new GPIO line value setter callbacks for the second GPIO chip (2025-07-24 09:06:46 +0200)

----------------------------------------------------------------
Another wireless update:
 - rtw89:
   - STA+P2P concurrency
   - support for USB devices RTL8851BU/RTL8852BU
 - ath9k: OF support
 - ath12k:
   - more EHT/Wi-Fi 7 features
   - encapsulation/decapsulation offload
 - iwlwifi: some FIPS interoperability
 - brcm80211: support SDIO 43751 device
 - rt2x00: better DT/OF support
 - cfg80211/mac80211:
   - improved S1G support
   - beacon monitor for MLO

----------------------------------------------------------------
Aaradhana Sahu (6):
      wifi: ath12k: Block radio bring-up in FTM mode
      wifi: ath12k: Add a table of parameters entries impacting memory consumption
      wifi: ath12k: Remove redundant TID calculation for QCN9274
      wifi: ath12k: Refactor macros to use memory profile-based values
      wifi: ath12k: Enable memory profile selection for QCN9274
      wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM mode

Aditya Kumar Singh (5):
      wifi: ath12k: fix timeout while waiting for regulatory update during interface creation
      wifi: ath12k: add support for Tx Power insertion in RRM action frame
      wifi: ath12k: advertise NL80211_FEATURE_TX_POWER_INSERTION support
      wifi: ath12k: Add num_stations counter for each interface
      wifi: mac80211: fix macro scoping in for_each_link_data

Alexander Wetzel (3):
      wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
      wifi: mac80211: Do not schedule stopped TXQs
      wifi: mac80211: Don't call fq_flow_idx() for management frames

Andrey Skvortsov (1):
      wifi: rtw88: enable TX reports for the management queue

Antonio Quartulli (2):
      wifi: iwlwifi: fix cmd length when sending WOWLAN_TSC_RSC_PARAM
      wifi: mac80211: fix unassigned variable access

Avraham Stern (2):
      wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
      wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn

Baochen Qiang (3):
      wifi: ath12k: remove unneeded semicolon in ath12k_mac_parse_tx_pwr_env()
      wifi: ath11k: fix sleeping-in-atomic in ath11k_mac_op_set_bitrate_mask()
      wifi: ath12k: bring DFS support back for WCN7850

Bartosz Golaszewski (1):
      ssb: use new GPIO line value setter callbacks for the second GPIO chip

Benjamin Berg (2):
      wifi: iwlwifi: mld: support channel survey collection for ACS scans
      wifi: iwlwifi: mld: decode EOF bit for AMPDUs

Bitterblue Smith (23):
      wifi: rtw89: 8851b: Accept USB devices and load their MAC address
      wifi: rtw89: Make dle_mem in rtw89_chip_info an array
      wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
      wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
      wifi: rtw89: Disable deep power saving for USB/SDIO
      wifi: rtw89: Add extra TX headroom for USB
      wifi: rtw89: Hide some errors when the device is unplugged
      wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
      wifi: rtw89: Fix rtw89_mac_power_switch() for USB
      wifi: rtw89: Add some definitions for USB
      wifi: rtw89: Add usb.{c,h}
      wifi: rtw89: Add rtw8851bu.c
      wifi: rtw89: Enable the new USB modules
      wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
      wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
      wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
      wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
      wifi: rtw89: Add rtw8852bu.c
      wifi: rtw89: Enable the new rtw89_8852bu module
      wifi: rtw88: Fix macid assigned to TDLS station
      wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
      wifi: rtw89: Lower the timeout in rtw89_fwdl_check_path_ready_ax() for USB

Bjorn Helgaas (1):
      wifi: Fix typos

Chia-Yuan Li (2):
      wifi: rtw89: trigger TX stuck if FIFO full
      wifi: rtw89: mac: reduce PPDU status length for WiFi 6 chips

Chih-Kang Chang (9):
      wifi: rtw89: mcc: add H2C command to support different PD level in MCC
      wifi: rtw89: add DIG suspend/resume flow when scan and connection
      wifi: rtw89: mcc: enlarge GO NoA duration to cover channel switching time
      wifi: rtw89: mcc: when MCC stop forcing to stay at GO role
      wifi: rtw89: extend HW scan of WiFi 7 chips for extra OP chan when concurrency
      wifi: rtw89: mcc: solve GO's TBTT change and TBTT too close to NoA issue
      wifi: rtw89: check LPS H2C command complete by C2H reg instead of done ack
      wifi: rtw89: update SER L2 type default value
      wifi: rtw89: tweak tx wake notify matching condition

Chin-Yen Lee (2):
      wifi: rtw89: enter power save mode aggressively
      wifi: rtw89: wow: Add Basic Rate IE to probe request in scheduled scan mode

Colin Ian King (1):
      wifi: ath11k: Make read-only const array svc_id static const

Double Lo (1):
      wifi: brcmfmac: support CYW54591 PCIE device

Dr. David Alan Gilbert (3):
      wifi: brcm80211: Remove unused functions
      wifi: brcm80211: Remove more unused functions
      wifi: brcm80211: Remove yet more unused functions

Fabio Estevam (1):
      wifi: brcmfmac: Add support for the SDIO 43751 device

Gokul Sivakumar (1):
      wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE

Gustavo A. R. Silva (1):
      wifi: iwlwifi: mvm/fw: Avoid -Wflex-array-member-not-at-end warnings

Hari Chandrakanthan (1):
      wifi: ath12k: Fix station association with MBSSID Non-TX BSS

Hariharan Basuthkar (1):
      wifi: ath12k: Send WMI_VDEV_SET_TPC_POWER_CMD for AP vdev

Harshitha Prem (1):
      wifi: ath12k: update unsupported bandwidth flags in reg rules

Ilan Peer (1):
      wifi: iwlwifi: mvm: Remove NAN support

Jeff Johnson (4):
      wifi: ath12k: pack HTT pdev rate stats structs
      wifi: ath10k: Prefer {} to {0} in initializers
      wifi: ath11k: Prefer {} to {0} in initializers
      wifi: ath12k: Prefer {} to {0} in initializers

Johan Hovold (10):
      wifi: ath11k: fix suspend use-after-free after probe failure
      wifi: ath11k: fix dest ring-buffer corruption
      wifi: ath11k: use plain access for descriptor length
      wifi: ath11k: use plain accesses for monitor descriptor
      wifi: ath11k: fix source ring-buffer corruption
      wifi: ath11k: fix dest ring-buffer corruption when ring is full
      wifi: ath12k: fix dest ring-buffer corruption
      wifi: ath12k: use plain access for descriptor length
      wifi: ath12k: fix source ring-buffer corruption
      wifi: ath12k: fix dest ring-buffer corruption when ring is full

Johannes Berg (7):
      Merge tag 'rtw-next-2025-07-18' of https://github.com/pkshih/rtw
      wifi: cfg80211/mac80211: remove wrong scan request n_channels
      wifi: cfg80211: reject HTC bit for management frames
      Merge tag 'ath-next-20250721' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next
      wifi: mac80211: fix WARN_ON for monitor mode on some devices
      wifi: iwlwifi: disable certain features for fips_enabled
      Merge tag 'iwlwifi-next-2025-07-23' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Kang Yang (1):
      wifi: ath10k: shutdown driver when hardware is unreliable

Karthikeyan Kathirvel (1):
      wifi: ath12k: allow beacon protection keys to be installed in hardware

Kees Cook (3):
      wifi: mac80211: Write cnt before copying in ieee80211_copy_rnr_beacon()
      wifi: nl80211: Set num_sub_specs before looping through sub_specs
      wifi: brcmfmac: cyw: Fix __counted_by to be LE variant

Kuan-Chung Chen (1):
      wifi: rtw89: dynamically update EHT preamble puncturing

Lachlan Hodges (4):
      wifi: cfg80211: support configuring an S1G short beaconing BSS
      wifi: mac80211: support initialising an S1G short beaconing BSS
      wifi: mac80211: support initialising current S1G short beacon index
      wifi: mac80211: support returning the S1G short beacon skb

Liu Song (1):
      wifi: brcmsmac: Use str_true_false() helper

Maharaja Kennadyrajan (5):
      wifi: ath12k: Add support to TDMA and MLO stats
      wifi: ath12k: Add support to RTT stats
      wifi: mac80211: Add link iteration macro for link data with rcu_dereference
      wifi: mac80211: extend beacon monitoring for MLO
      wifi: mac80211: extend connection monitoring for MLO

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Miaoqing Pan (2):
      dt-bindings: net: wireless: ath11k-pci: describe firmware-name property
      wifi: ath11k: support usercase-specific firmware overrides

Michael-CY Lee (2):
      wifi: mac80211: determine missing link_id in ieee80211_rx_for_interface() based on frequency
      wifi: cfg80211/mac80211: report link ID for unexpected frames

Miri Korenblit (10):
      wifi: mac80211: remove ieee80211_remove_key
      wifi: mac80211: don't require cipher and keylen in gtk rekey
      wifi: iwlwifi: mld: disable RX aggregation if requested
      wifi: iwlwifi: remove SC2F firmware support
      wifi: iwlwifi: stop supporting iwl_omi_send_status_notif ver 1
      wifi: iwlwifi: Remove support for rx OMI bandwidth reduction
      wifi: iwlwifi: mld: use spec link id and not FW link id
      wifi: iwlwifi: don't export symbols that we shouldn't
      wifi: iwlwifi: check validity of the FW API range
      wifi: iwlwifi: Revert "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions"

Moon Hee Lee (1):
      wifi: mac80211: reject TDLS operations when station is not associated

Murad Masimov (1):
      wifi: plfxlc: Fix error handling in usb driver probe

Nathan Chancellor (1):
      wifi: brcmsmac: Remove const from tbl_ptr parameter in wlc_lcnphy_common_read_table()

Nithyanantham Paramasivam (3):
      wifi: ath12k: Fix the handling of TX packets in Ethernet mode
      wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
      wifi: ath12k: Advertise encapsulation/decapsulation offload support to mac80211

P Praneesh (1):
      wifi: ath12k: set RX_FLAG_SKIP_MONITOR in WBM error path

Pei Xiao (1):
      wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags

Ping-Ke Shih (8):
      wifi: rtw89: 8851b: rfk: extend DPK path_ok type to u8
      wifi: rtw89: 8851b: set ADC bandwidth select according to calibration value
      wifi: rtw89: 8851b: adjust ADC setting for RF calibration
      wifi: rtw89: 8851b: update NCTL 0xB
      wifi: rtw89: 8851b: rfk: update DPK to 0x11
      wifi: rtw89: 8851b: rfk: update IQK to 0x14
      wifi: rtw89: purge obsoleted scan events with software sequence number
      wifi: rtw89: check path range before using in rtw89_fw_h2c_rf_ps_info()

Pradeep Kumar Chitrapu (8):
      wifi: ath12k: push HE MU-MIMO params to hardware
      wifi: ath12k: push EHT MU-MIMO params to hardware
      wifi: ath12k: move HE MCS mapper to a separate function
      wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
      wifi: ath12k: add support for setting fixed HE rate/GI/LTF
      wifi: ath12k: clean up 80P80 support
      wifi: ath12k: add support for 160 MHz bandwidth
      wifi: ath12k: add extended NSS bandwidth support for 160 MHz

Qianfeng Rong (5):
      wifi: ath5k: Use max() to improve code
      wifi: rtlwifi: Use min()/max() to improve code
      wifi: brcm80211: Use min() to improve code
      wifi: mwifiex: Use max_t() to improve code
      wifi: wilc1000: Use min() to improve code

Raj Kumar Bhagat (2):
      wifi: ath12k: handle WMI event for real noise floor calculation
      wifi: ath12k: use real noise floor instead of default value

Rameshkumar Sundaram (1):
      wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP

Remi Pommarel (2):
      wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
      Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Rosen Penev (11):
      wifi: ath9k: ahb: reorder declarations
      wifi: ath9k: ahb: reorder includes
      dt-bindings: net: wireless: ath9k: add WIFI bindings
      wifi: ath9k: ahb: replace id_table with of
      wifi: rt2x00: add COMPILE_TEST
      wifi: rt2x00: remove mod_name from platform_driver
      wifi: rt2800soc: allow loading from OF
      wifi: rt2800: move 2x00soc to 2800soc
      wifi: rt2x00: soc: modernize probe
      MIPS: dts: ralink: mt7620a: add wifi
      dt-bindings: net: wireless: rt2800: add SOC Wifi

Saleemuddin Shaik (1):
      wifi: ath12k: Add support for transmit histogram stats

Sarika Sharma (8):
      wifi: ath12k: Add memset and update default rate value in wmi tx completion
      wifi: ath12k: fill link station statistics for MLO
      wifi: ath12k: add link support for multi-link in arsta
      wifi: ath12k: add EHT support for TX rate
      wifi: ath12k: correctly update bw for ofdma packets
      wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv
      wifi: ath12k: properly set bit for pdev mask for firmware PPDU_STATS request
      wifi: ath12k: Correct tid cleanup when tid setup fails

Sergey Senozhatsky (1):
      wifi: ath11k: clear initialized flag for deinit-ed srng lists

Sivashankari Madhavan (1):
      wifi: ath12k: support average ack rssi in station dump

Sriram R (2):
      wifi: ath12k: Add support to enqueue management frame at MLD level
      wifi: ath12k: Validate peer_id before searching for peer

Sumanth Gavini (3):
      wifi: wil6210: wmi: Fix spellings reported by codespell
      wifi: ath10k: Fix Spelling
      wifi: ath6kl: Fix spellings

Tamizh Chelvam Raja (2):
      wifi: ath12k: fix endianness handling while accessing wmi service bit
      wifi: ath12k: Add support to parse max ext2 wmi service bit

Thiraviyam Mariyappan (1):
      wifi: ath12k: Clear auth flag only for actual association in security mode

Ting-Ying Li (1):
      wifi: brcmfmac: fix EXTSAE WPA3 connection failure due to AUTH TX failure

WangYuli (2):
      wifi: brcmfmac: Fix typo "notifer"
      wifi: iwlwifi: Fix typo "ransport"

Zong-Zhe Yang (9):
      wifi: rtw89: regd/acpi: support country CA by BIT(1) in 6 GHz SP conf
      wifi: rtw89: regd/acpi: update field definition to specific country in UNII-4 conf
      wifi: rtw89: regd/acpi: support regulatory rules via ACPI DSM and parse rule of regd_UK
      wifi: rtw89: regd/acpi: support 6 GHz VLP policy via ACPI DSM
      wifi: rtw89: introduce fw feature group and redefine CRASH_TRIGGER
      wifi: rtw89: 8852bt: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: 8852bt: implement RFK multi-channel handling and support chanctx up to 2
      wifi: rtw89: 8852b: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: 8852b: implement RFK multi-channel handling and support chanctx up to 2

 .../bindings/net/wireless/qca,ath9k.yaml           |   18 +-
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |    6 +
 .../bindings/net/wireless/ralink,rt2880.yaml       |   49 +
 arch/mips/boot/dts/ralink/mt7620a.dtsi             |   10 +
 drivers/net/wireless/ath/ath10k/core.c             |   50 +-
 drivers/net/wireless/ath/ath10k/core.h             |   13 +-
 drivers/net/wireless/ath/ath10k/debug.c            |    6 +-
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    7 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    8 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    4 +-
 drivers/net/wireless/ath/ath10k/hw.h               |    8 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   15 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    3 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |    6 +
 drivers/net/wireless/ath/ath11k/ahb.c              |    2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    5 +-
 drivers/net/wireless/ath/ath11k/core.c             |    9 +-
 drivers/net/wireless/ath/ath11k/core.h             |   13 +-
 drivers/net/wireless/ath/ath11k/dbring.c           |    3 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |   38 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |   15 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |   11 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   45 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   15 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   39 +-
 drivers/net/wireless/ath/ath11k/htc.c              |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   28 +-
 drivers/net/wireless/ath/ath11k/pci.c              |    4 +-
 drivers/net/wireless/ath/ath11k/spectral.c         |    3 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   12 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |    1 +
 drivers/net/wireless/ath/ath12k/ce.c               |    5 +-
 drivers/net/wireless/ath/ath12k/core.c             |   80 +-
 drivers/net/wireless/ath/ath12k/core.h             |   44 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |    3 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |    8 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  564 ++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  207 ++-
 drivers/net/wireless/ath/ath12k/dp.c               |  138 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   45 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   29 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   72 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  155 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   40 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   55 +
 drivers/net/wireless/ath/ath12k/hw.h               |   32 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1651 +++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   17 +
 drivers/net/wireless/ath/ath12k/pci.c              |    6 +-
 drivers/net/wireless/ath/ath12k/peer.c             |    5 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   28 +
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    6 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   31 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  359 ++++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  165 +-
 drivers/net/wireless/ath/ath5k/phy.c               |   12 +-
 drivers/net/wireless/ath/ath5k/reg.h               |    2 +-
 drivers/net/wireless/ath/ath6kl/core.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/hif.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/htc.h              |    6 +-
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         |    2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |    2 +-
 drivers/net/wireless/ath/ath6kl/init.c             |    4 +-
 drivers/net/wireless/ath/ath6kl/main.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/usb.c              |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.h              |   10 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |   62 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |    2 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   46 +-
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |    2 +
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |    2 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |   26 +-
 .../broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   21 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    5 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    5 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   19 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      |  443 ------
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h      |   27 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h      |   11 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |    2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |   25 +-
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |    2 +
 drivers/net/wireless/intel/iwlegacy/commands.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    4 -
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h       |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   26 -
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   20 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h   |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   33 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |    6 -
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   25 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   16 -
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |    5 +
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    9 -
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  389 +----
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   30 -
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |    3 -
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   73 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   19 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |    9 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |  156 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |   37 +
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |    2 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |    9 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    5 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   93 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |   22 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   28 +
 drivers/net/wireless/intersil/p54/p54spi.c         |    4 +-
 drivers/net/wireless/marvell/libertas/cfg.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    7 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    4 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |    5 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |   11 +-
 drivers/net/wireless/purelifi/plfxlc/mac.h         |    2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |   29 +-
 drivers/net/wireless/ralink/rt2x00/Kconfig         |    7 +-
 drivers/net/wireless/ralink/rt2x00/Makefile        |    1 -
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c     |  110 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c   |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c     |  151 --
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h     |   29 -
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |   19 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |   17 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/rf.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |   15 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   22 +-
 drivers/net/wireless/realtek/rtw88/coex.c          |   22 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   10 +
 drivers/net/wireless/realtek/rtw88/mac.h           |    1 +
 drivers/net/wireless/realtek/rtw88/main.c          |   10 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |    6 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    1 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |   26 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    9 +
 drivers/net/wireless/realtek/rtw89/acpi.c          |   95 ++
 drivers/net/wireless/realtek/rtw89/acpi.h          |   33 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  234 ++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   15 +
 drivers/net/wireless/realtek/rtw89/core.c          |  140 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   73 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |    2 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  310 +++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   61 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  112 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   33 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    8 +
 drivers/net/wireless/realtek/rtw89/pci.c           |    5 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  241 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |    2 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   28 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   34 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  149 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  169 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  156 +-
 .../wireless/realtek/rtw89/rtw8851b_rfk_table.c    |   81 +-
 .../wireless/realtek/rtw89/rtw8851b_rfk_table.h    |    2 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |  501 +++---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   39 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   98 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   77 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h  |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |   69 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   55 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    3 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |    1 +
 drivers/net/wireless/realtek/rtw89/usb.c           | 1042 ++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h           |   65 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   18 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   14 +-
 drivers/net/wireless/ti/wl1251/reg.h               |    6 +-
 drivers/net/wireless/ti/wl12xx/reg.h               |    6 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |    2 +-
 drivers/ssb/driver_gpio.c                          |    8 +-
 include/linux/mmc/sdio_ids.h                       |    1 +
 include/net/cfg80211.h                             |   33 +-
 include/net/mac80211.h                             |   27 +-
 include/uapi/linux/nl80211.h                       |   39 +
 net/mac80211/cfg.c                                 |   76 +-
 net/mac80211/debugfs_netdev.c                      |    2 +-
 net/mac80211/ieee80211_i.h                         |   32 +-
 net/mac80211/key.c                                 |   63 +-
 net/mac80211/main.c                                |   14 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mlme.c                                |  116 +-
 net/mac80211/rx.c                                  |   28 +-
 net/mac80211/tdls.c                                |    2 +-
 net/mac80211/tx.c                                  |  109 +-
 net/mac80211/util.c                                |   31 +-
 net/wireless/mlme.c                                |    3 +-
 net/wireless/nl80211.c                             |   96 +-
 net/wireless/reg.c                                 |    2 +
 net/wireless/sme.c                                 |    1 -
 net/wireless/trace.h                               |   17 +-
 238 files changed, 8375 insertions(+), 3057 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h

