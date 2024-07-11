Return-Path: <linux-wireless+bounces-10186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2E92E48E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC451F21FEC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459D158A3D;
	Thu, 11 Jul 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjf6flA6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C940158A29;
	Thu, 11 Jul 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693434; cv=none; b=jrmUjZtzrY+jhelhwwaPj1IQNukfuXKxRDN/fqDdblD+cBs1C9+m+J9VaMLWpCGZcPosUvODc9gvr5b+7IE7/HlijjYellk4zxYv9kzSyigVxImCEhSIkwuQEaqG0bC+ED+Yb8OuHEvdqfdnFVCNqAdBLzmtCc4opRhgQqTT42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693434; c=relaxed/simple;
	bh=qbmmHl7LwfGSPPW4YCV/fAuG88UYt/tb5zidJevUNAQ=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=gtf9j3N9U/KilR5azOsIw7ykUxxTH/gbcoB8LsOlAxZayBBkkK1xD1rNSf3P154NuqcdZPRzQRvrwR8vMpBHd4//mqBOCntC5aSheMrHCWK4qavQFJLRaTToSrl8QdGr2hhUzf+P4Y3rXkXjcW1inmM3JC4JDB7Ck0s0SrQiuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjf6flA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C849C116B1;
	Thu, 11 Jul 2024 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693433;
	bh=qbmmHl7LwfGSPPW4YCV/fAuG88UYt/tb5zidJevUNAQ=;
	h=From:Subject:To:Cc:Date:From;
	b=Vjf6flA6p1/x8tuTiNPM5pgqNJWIcd3JP6ehbYWnlKsYFep/T8Bcekff5fEoVw0Yc
	 SmFW+u1LrAA77oi5ZhMJbbxM6tOuvvF5vZEYBqA7nlj3suHFPE2rYcFkYKCWTe7ye5
	 GGHlotS6TQGEx4taO6hhgLi+n20WLdP1e2u24U3G8RE0yCP2EHka3QjfP7bVDenx18
	 vZPOk3PFGTG2EtVmuggYCJk6BPTG+46QEebmYzUM1KboSigLae9K7bOqX0VINYfwyx
	 SlNMUxzKeK1K6x21PPpVjsgD4yDgSY3ogS41ogqlijEktc6JN1hINEAFj5e1BkuwO6
	 QiFI1pSA6HtjQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-07-11
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240711102353.0C849C116B1@smtp.kernel.org>
Date: Thu, 11 Jul 2024 10:23:52 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 94833addfaba89d12e5dbd82e350a692c00648ab:

  net: thunderx: Unembed netdev structure (2024-06-27 16:55:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-07-11

for you to fetch changes up to dabcfd5e116800496eb9bec2ba7c015ca2043aa0:

  Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless (2024-07-10 14:50:14 +0300)

----------------------------------------------------------------
wireless-next patches for v6.11

Most likely the last "new features" pull request for v6.11 with
changes both in stack and in drivers. The big thing is the multiple
radios for wiphy feature which makes it possible to better advertise
radio capabilities to user space. mt76 enabled MLO and iwlwifi
re-enabled MLO, ath12k and rtw89 Wi-Fi 6 devices got WoWLAN support.

Major changes:

cfg80211/mac80211

* remove DEAUTH_NEED_MGD_TX_PREP flag

* multiple radios per wiphy support

mac80211_hwsim

* multi-radio wiphy support

ath12k

* DebugFS support for datapath statistics

* WCN7850: support for WoW (Wake on WLAN)

* WCN7850: device-tree bindings

ath11k

* QCA6390: device-tree bindings

iwlwifi

* mvm: re-enable Multi-Link Operation (MLO)

* aggregation (A-MSDU) optimisations

rtw89

* preparation for RTL8852BE-VT support

* WoWLAN support for WiFi 6 chips

* 36-bit PCI DMA support

mt76

* mt7925 Multi-Link Operation (MLO) support

----------------------------------------------------------------
Aaradhana Sahu (3):
      wifi: ath12k: Fix WARN_ON during firmware crash in split-phy
      wifi: ath12k: fix NULL pointer access in ath12k_mac_op_get_survey()
      wifi: ath12k: fix uninitialize symbol error on ath12k_peer_assoc_h_he()

Aditya Kumar Singh (3):
      wifi: ath12k: fix per pdev debugfs registration
      wifi: ath12k: unregister per pdev debugfs
      wifi: ath12k: handle symlink cleanup for per pdev debugfs dentry

Ajith C (1):
      wifi: ath12k: fix firmware crash due to invalid peer nss

Aleksandr Mishin (1):
      wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter()

Anjaneyulu (1):
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v12

Baochen Qiang (11):
      wifi: ath12k: fix ACPI warning when resume
      wifi: ath11k: fix RCU documentation in ath11k_mac_op_ipv6_changed()
      wifi: ath11k: fix wrong handling of CCMP256 and GCMP ciphers
      wifi: ath12k: add ATH12K_DBG_WOW log level
      wifi: ath12k: implement WoW enable and wakeup commands
      wifi: ath12k: add basic WoW functionalities
      wifi: ath12k: add WoW net-detect functionality
      wifi: ath12k: implement hardware data filter
      wifi: ath12k: support ARP and NS offload
      wifi: ath12k: support GTK rekey offload
      wifi: ath12k: handle keepalive during WoWLAN suspend and resume

Bartosz Golaszewski (2):
      dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
      dt-bindings: net: wireless: describe the ath12k PCI module

Benjamin Berg (7):
      wifi: iwlwifi: return a new allocation for hdr page space
      wifi: iwlwifi: map entire SKB when sending AMSDUs
      wifi: iwlwifi: keep the TSO and workaround pages mapped
      wifi: iwlwifi: use already mapped data when TXing an AMSDU
      wifi: iwlwifi: keep BHs disabled when TXing from reclaim
      wifi: iwlwifi: release TXQ lock during reclaim
      wifi: iwlwifi: correctly reference TSO page information

Bitterblue Smith (1):
      wifi: rtw88: usb: Further limit the TX aggregation

Chen Ni (1):
      wifi: ipw2x00: Use kzalloc() instead of kmalloc()/memset()

Chih-Kang Chang (7):
      wifi: rtw89: wow: append security header offset for different cipher
      wifi: rtw89: wow: update WoWLAN reason register for different FW
      wifi: rtw89: wow: update config mac for 802.11ax chip
      wifi: rtw89: wow: fix GTK offload H2C skbuff issue
      wifi: rtw89: wow: prevent to send unexpected H2C during download Firmware
      wifi: rtw89: wow: enable beacon filter after swapping firmware
      wifi: rtw89: add polling for LPS H2C to ensure FW received

Ching-Te Ku (1):
      wifi: rtw89: coex: Add coexistence policy for hardware scan

Deren Wu (5):
      wifi: mt76: mt792x: add struct mt792x_bss_conf
      wifi: mt76: mt792x: add struct mt792x_link_sta
      wifi: mt76: mt792x: add struct mt792x_chanctx
      wifi: mt76: mt7925: support for split bss_info_changed method
      wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS

Dinesh Karthikeyan (6):
      wifi: ath12k: Add support to enable debugfs_htt_stats
      wifi: ath12k: Add htt_stats_dump file ops support
      wifi: ath12k: Add support to parse requested stats_type
      wifi: ath12k: Support Transmit Scheduler stats
      wifi: ath12k: Support pdev error stats
      wifi: ath12k: Support TQM stats

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't send an ROC command with max_delay = 0

En-Wei Wu (1):
      wifi: virt_wifi: avoid reporting connection success with wrong SSID

Felix Fietkau (11):
      wifi: nl80211: split helper function from nl80211_put_iface_combinations
      wifi: mac80211: clear vif drv_priv after remove_interface when stopping
      wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
      wifi: cfg80211: extend interface combination check for multi-radio
      wifi: cfg80211: add helper for checking if a chandef is valid on a radio
      wifi: mac80211: add support for DFS with multiple radios
      wifi: mac80211: add radio index to ieee80211_chanctx_conf
      wifi: mac80211: extend ifcomb check functions for multi-radio
      wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
      wifi: mac80211: add wiphy radio assignment and validation
      wifi: mac80211_hwsim: add support for multi-radio wiphy

Fredrik Lönnegren (1):
      wifi: rtlwifi: fix default typo

Harshitha Prem (1):
      wifi: ath12k: Remove unused ath12k_base from ath12k_hw

Ilan Peer (1):
      wifi: mac80211: Use the link BSS configuration for beacon processing

Jiapeng Chong (1):
      wifi: rtl8xxxu: use swap() in rtl8xxxu_switch_ports()

Johannes Berg (18):
      wifi: nl80211: don't give key data to userspace
      wifi: mac80211: remove key data from get_key callback
      wifi: mac80211_hwsim: fix kernel-doc
      wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP
      wifi: iwlwifi: mvm: fix interface combinations
      wifi: iwlwifi: mvm: clean up reorder buffer data
      wifi: iwlwifi: mvm: align reorder buffer entries to cacheline
      wifi: iwlwifi: mvm: simplify EMLSR blocking
      wifi: iwlwifi: mvm: add missing string for ROC EMLSR block
      wifi: iwlwifi: fw: api: fix memory region kernel-doc
      wifi: iwlwifi: fw: api: mac: fix kernel-doc
      wifi: iwlwifi: fw: api: add puncturing to PHY context docs
      wifi: iwlwifi: document PPAG table command union correctly
      wifi: iwlwifi: fw: api: fix missing RX descriptor kernel-doc
      wifi: iwlwifi: mvm: document remaining mvm data
      wifi: mac80211_hwsim: fix warning
      wifi: virt_wifi: don't use strlen() in const context
      wifi: mac80211: fix AP chandef capturing in CSA

Kalle Valo (3):
      Merge tag 'ath-next-20240702' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2024-07-05' of https://github.com/pkshih/rtw
      Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless

Karthikeyan Periyasamy (3):
      wifi: ath12k: avoid unnecessary MSDU drop in the Rx error process
      wifi: ath12k: fix mbssid max interface advertisement
      wifi: ath12k: fix peer metadata parsing

Kuan-Chung Chen (1):
      wifi: rtw89: 8852b: fix definition of KIP register number

Lingbo Kong (3):
      wifi: ath11k: fix ack signal strength calculation
      wifi: ath11k: modify the calculation of the average signal strength in station mode
      wifi: ath12k: Fix pdev id sent to firmware for single phy devices

Marcin Ślusarz (1):
      wifi: rtw88: usb: schedule rx work after everything is set up

Martin Kaistra (1):
      wifi: rtl8xxxu: 8188f: Limit TX power index

Michael Lo (1):
      wifi: mt76: mt792x: fix scheduler interference in drv own process

Michael-CY Lee (2):
      wifi: mac80211: cancel color change finalize work when link is stopped
      wifi: mac80211: do not check BSS color collision in certain cases

Miri Korenblit (1):
      wifi: iwlwifi: mvm: re-enable MLO

Mukesh Sisodiya (1):
      wifi: iwlwifi: Remove debug message

Ping-Ke Shih (15):
      wifi: rtw89: 8852bx: move common code from 8852b to 8852b_common
      wifi: rtw89: 8852bx: add extra handles for 8852BT in 8852b_common
      wifi: rtw89: 885xbx: apply common settings to 8851B, 8852B and 8852BT
      wifi: rtw89: adopt firmware whose version is equal or less but closest
      wifi: rtw89: pci: support 36-bit PCI DMA address
      wifi: rtw89: pci: fix RX tag race condition resulting in wrong RX length
      wifi: rtw89: 8852bt: rfk: add TSSI
      wifi: rtw89: 8852bt: rfk: add DPK
      wifi: rtw89: 8852b: set AMSDU limit to 5000
      wifi: rtw89: 8852bt: rfk: add IQK
      wifi: rtw89: 8852bt: rfk: add RX DCK
      wifi: rtw89: 8852bt: rfk: add DACK
      wifi: rtw89: 8852bt: rfk: add RCK
      wifi: rtw89: 8852bx: move BTC common code from 8852b to 8852b_common
      wifi: rtw89: 8852bx: add extra handles of BTC for 8852BT in 8852b_common

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: fix legacy peer association due to missing HT or 6 GHz capabilities

Rameshkumar Sundaram (2):
      wifi: ath12k: modify remain on channel for single wiphy
      wifi: ath12k: fix driver initialization for WoW unsupported devices

Ramya Gnanasekar (1):
      wifi: ath12k: Dump additional Tx PDEV HTT stats

Sascha Hauer (1):
      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

Sean Wang (79):
      wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_color_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_bmc_tlv for per-link BSS
      wifi: mt76: mt7925: remove unused parameters in mt7925_mcu_bss_bmc_tlv
      wifi: mt76: mt7925: extend mt7925_mcu_bss_sec_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_set_bss_pm for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_[abort, set]_roc for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_bcnft for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_ps for per-link BSS
      wifi: mt76: mt7925: add mt7925_mcu_bss_rlm_tlv to constitue the RLM TLV
      wifi: mt76: mt7925: mt7925_mcu_set_chctx rely on mt7925_mcu_bss_rlm_tlv
      wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_state_v2_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_rate_ctrl_tlv with per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_eht_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_he_6g_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_he_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_amsdu_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_vht_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_ht_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_phy_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_get_phy_mode_ext for per-link STA
      wifi: mt76: mt7925: extend mt7925_get_phy_mode for per-link STA
      wifi: mt76: mt792x: extend mt76_connac_get_phy_mode_v2 for per-link STA
      wifi: mt76: mt762x: extend mt76_connac_mcu_sta_basic_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_hdr_trans_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_sta_add to create per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_bss_add to create per-link BSS
      wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS
      wifi: mt76: mt7925: simpify mt7925_mcu_sta_cmd logic by removing fw_offload
      wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
      wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO
      wifi: mt76: mt7925: set Tx queue parameters according to link id
      wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
      wifi: mt76: mt7925: add mt7925_set_link_key
      wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
      wifi: mt76: mt7925: add mt7925_change_vif_links
      wifi: mt76: mt7925: add mt7925_change_sta_links
      wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
      wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
      wifi: mt76: mt7925: add link handling to txwi
      wifi: mt76: mt7925: add link handling in mt7925_set_key
      wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
      wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
      wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
      wifi: mt76: mt7925: add link handling in mt7925_txwi_free
      wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
      wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
      wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
      wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler
      wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
      wifi: mt76: mt7925: update rate index according to link id
      wifi: mt76: mt7925: report link information in rx status
      wifi: mt76: add def_wcid to struct mt76_wcid
      wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
      wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
      wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
      wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
      wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
      wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info
      wifi: mt76: mt7925: enabling MLO when the firmware supports it

Wolfram Sang (2):
      wifi: ath11k: use 'time_left' variable with wait_event_timeout()
      wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()

Zong-Zhe Yang (4):
      wifi: rtw89: constrain TX power according to Transmit Power Envelope
      wifi: rtw89: mac: parse MRC C2H failure report
      wifi: rtw89: unify the selection logic of RFK table when MCC
      wifi: mac80211: chanctx emulation set CHANGE_CHANNEL when in_reconfig

 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   46 +
 .../bindings/net/wireless/qcom,ath12k.yaml         |   99 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    3 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h            |    3 +
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   16 +-
 drivers/net/wireless/ath/ath11k/dp_tx.h            |    4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h           |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   29 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   20 +-
 drivers/net/wireless/ath/ath12k/Makefile           |    3 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |    2 +
 drivers/net/wireless/ath/ath12k/core.c             |   71 +-
 drivers/net/wireless/ath/ath12k/core.h             |   34 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    3 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   19 +-
 drivers/net/wireless/ath/ath12k/debugfs.h          |    6 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 1540 ++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  567 +++
 drivers/net/wireless/ath/ath12k/dp.h               |    1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   54 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    4 +
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    4 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   26 +-
 drivers/net/wireless/ath/ath12k/htc.c              |    6 +
 drivers/net/wireless/ath/ath12k/hw.h               |    2 -
 drivers/net/wireless/ath/ath12k/mac.c              |  302 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    5 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  728 +++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  586 ++-
 drivers/net/wireless/ath/ath12k/wow.c              | 1026 +++++
 drivers/net/wireless/ath/ath12k/wow.h              |   62 +
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c     |    3 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   34 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    7 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |    8 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |    4 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   13 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   18 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   41 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   11 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   19 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   36 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |  139 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  311 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    3 +
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    5 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |    8 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |   10 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   58 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   66 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  143 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   46 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    3 +
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    6 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  141 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 1139 ++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  981 +++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   65 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   31 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    3 +
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |  105 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  109 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/pci.c           |   23 +
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c      |   15 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |    9 +
 drivers/net/wireless/realtek/rtw88/main.h          |    2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/usb.c           |   17 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |    4 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    6 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |    1 +
 drivers/net/wireless/realtek/rtw89/chan.c          |   22 +
 drivers/net/wireless/realtek/rtw89/chan.h          |    4 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   29 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   21 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   38 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   29 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  114 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |    6 +
 drivers/net/wireless/realtek/rtw89/mac.c           |  112 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   11 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   20 -
 drivers/net/wireless/realtek/rtw89/pci.c           |  136 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  109 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   17 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   56 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  190 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      | 1866 +--------
 drivers/net/wireless/realtek/rtw89/rtw8852b.h      |  122 -
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   | 2053 ++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_common.h   |  388 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.h     |   13 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 4019 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |   22 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk_table.c   |  490 +++
 .../wireless/realtek/rtw89/rtw8852bt_rfk_table.h   |   38 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/util.c          |  106 +
 drivers/net/wireless/realtek/rtw89/util.h          |    5 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   33 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   30 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   76 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |    8 +-
 drivers/net/wireless/virtual/virt_wifi.c           |   20 +-
 include/net/cfg80211.h                             |   58 +-
 include/net/mac80211.h                             |   24 +-
 include/uapi/linux/nl80211.h                       |   65 +
 net/mac80211/cfg.c                                 |   10 +-
 net/mac80211/chan.c                                |  210 +-
 net/mac80211/debugfs.c                             |    1 -
 net/mac80211/ibss.c                                |    2 +-
 net/mac80211/ieee80211_i.h                         |    5 +-
 net/mac80211/iface.c                               |   10 +-
 net/mac80211/link.c                                |    2 +
 net/mac80211/main.c                                |   55 +-
 net/mac80211/mlme.c                                |   50 +-
 net/mac80211/rx.c                                  |    6 +-
 net/mac80211/spectmgmt.c                           |    9 +-
 net/mac80211/util.c                                |  147 +-
 net/wireless/nl80211.c                             |  222 +-
 net/wireless/rdev-ops.h                            |   12 +
 net/wireless/util.c                                |   68 +-
 162 files changed, 16665 insertions(+), 3674 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.c


