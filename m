Return-Path: <linux-wireless+bounces-37624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N39cOHA+KWqoSwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 12:37:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF76685B5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 12:37:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=j6+Pdg5U;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37624-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37624-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6261F304939F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BB3F411A;
	Wed, 10 Jun 2026 10:36:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274013AEF27;
	Wed, 10 Jun 2026 10:36:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087808; cv=none; b=oZPkEPFL8b+jncX2gpR+NRQjiqTn+LsPB3PQRGRBa6WIywFVF2v4lrSLMlCujWv4CtKZL3D35gWO647lpg/ibYhgft7Qb6MFQLNmhiF3ue6pD/ZauofxyPyfBtzDbb7nFacPFnUIB8wP8Z87imukaYUHQ/e2KD0mScBFnVQTrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087808; c=relaxed/simple;
	bh=oz3IWg2QRJkYbZKqZB03jT140XIc256EGqQuQpSJjsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nvFGJA57tuXi8iB4bQcf7AS7P1f7GgU6qmiDJ2HRvwEb3Qb4OMUIT8wnlwtb1qbwNlFfj5iUvBe/xPEuD8tc2x5Y5MUX4ChQ7j90DVs6N0Q/01o1DCiC4bY3DU6hbri8jMStC0uJcb4LwiQ1C6jZpXKv6Fet0MFhloRywS4Yl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j6+Pdg5U; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2MW6/u48BCp1XZw6lweisn50pMGNMyE4y7udVMc3Hms=; t=1781087804; x=1782297404; 
	b=j6+Pdg5UUelINTg6/BzPWdnX4QD/gXQuoNuHFN0NTvLCuC7HTwrlDS6R0bLc5M/Cb7fEH1RfIAZ
	J4Htc0H3n/6kFhrGhchY99Ngzv9QSDykMyrtSgLvFYdKplj7MolQnjVHpzIVM18SNGGS6NdaUhzie
	y4g2iX9GTI0XslF3uL6oAispRhbpX0U+g6aw7eVjIdOooo2n9Bkd1Z0B62OjIeDFJsjyuiUiwukt5
	rXTbzYD+tgQ7pT62AxY67plCWZiAzSaDCrU6abh70vyoVqxdLHbdJJpc/q6ynS6HASfsVzezYY5Df
	uJdVR01B+bGdSb1BlFTeiDzezQZUJhxfQIpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wXGIb-00000007tBl-0AKN;
	Wed, 10 Jun 2026 12:36:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-06-10
Date: Wed, 10 Jun 2026 12:35:39 +0200
Message-ID: <20260610103637.179340-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-37624-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77FF76685B5

Hi,

This should be the last PR. Quite a few more driver things came
(see the tag message) but otherwise it feels fairly simple.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit c2c0486c56800ce276e79c40a6e576ffd672f2a9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-01 13:42:12 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-06-10

for you to fetch changes up to 21352612198c83a8441482abbf3bd45e4f128dd0:

  b43: add RF power offset for N-PHY r8 + radio 2057 r8 (2026-06-10 10:27:56 +0200)

----------------------------------------------------------------
Quite a few last updates, notably:
 - b43: new support for an 11n device
 - mt76:
   - mt792x broken usb transport detection
   - mt7921 regd improvements
   - mt7927 support
 - iwlwifi:
   - more kunit tests
   - FW version updates
 - ath12k: WDS support
 - rtw89:
   - RTL8922AU support
   - USB 3 mode switch for performance
   - better monitor radiotap support
   - RTL8922DE preparations
 - cfg80211/mac80211:
   - update UHR to D1.4, UHR DBE support
   - finally remove 5/10 MHz support
   - S1G rate reporting
   - multicast encapsulation offload

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: add hardware parameters for maximum supported clients

Aditya Kumar Singh (1):
      wifi: ath12k: Prevent incorrect vif chanctx switch when handling multi-radio contexts

Alessio Ferri (7):
      b43: add firmware mappings for rev22
      b43: add d11 core revision 0x16 to id table
      b43: route d11 corerev 22 to 24-bit indirect radio access
      b43: support radio 2057 rev 8
      b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
      b43: add channel info table for N-PHY r8 + radio 2057 r8
      b43: add RF power offset for N-PHY r8 + radio 2057 r8

Andreas Kemnade (1):
      wifi: wlcore: enable the right set of ciphers

Arjan van de Ven (1):
      wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon

Aviel Zohar (2):
      wifi: mt76: mt7925: validate skb length in testmode query
      wifi: mt76: mt7915: validate skb length in txpower SKU query

Avinash Bhatt (3):
      wifi: iwlwifi: mld: add KUnit tests for duplicated beacon RSSI adjustment
      wifi: iwlwifi: mld: add KUnit tests for PSD/EIRP RSSI adjustment
      wifi: iwlwifi: mld: add KUnit tests for link grading

Baochen Qiang (1):
      wifi: ath12k: fix EAPOL TX failure caused by stale tcl_metadata bits

Bitterblue Smith (16):
      wifi: rtw89: usb: Support 2 bulk in endpoints
      wifi: rtw89: Fix rtw89_usb_ops_mac_lv1_rcvy() for RTL8922AU
      wifi: rtw89: Fix rtw89_usb_ops_mac_pre_init() for RTL8922AU
      wifi: rtw89: Fix rtw89_usb_ops_mac_post_init() for RTL8922AU
      wifi: rtw89: usb: Enable RX aggregation for RTL8922AU
      wifi: rtw89: Fix rtw8922a_pwr_{on,off}_func() for USB
      wifi: rtw89: Let hfc_param_ini have separate settings for USB 2/3
      wifi: rtw89: Add rtw8922a_hfc_param_ini_usb{2,3}
      wifi: rtw89: Add rtw8922a_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8922au.c
      wifi: rtw89: Enable the new rtw89_8922au module
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor
      wifi: rtl8xxxu: Detect the maximum supported channel width
      wifi: rtw89: Add missing TX queue mappings for RTL8922AU
      wifi: rtw88: Add more validation for the RX descriptor
      wifi: rtw89: usb: Support switching to USB 3 mode

Bjoern A. Zeeb (1):
      wifi: mt76: fix argument to ieee80211_is_first_frag()

Bryam Vargas (1):
      wifi: mac80211: bound S1G TIM PVB walk to the TIM element

Chelsy Ratnawat (1):
      wifi: rtlwifi: rtl8821ae: Remove dead code in rtl8821ae_update_hal_rate_table()

Chia-Yuan Li (2):
      wifi: rtw89: add IO offload support via firmware
      wifi: rtw89: offload DMAC and CMAC init IO to firmware

Chih-Kang Chang (3):
      wifi: rtw89: use struct to fill C2H recv ack
      wifi: rtw89: check scan C2H event recv ack instead of C2H event done ack
      wifi: rtw89: suspend DIG when remain-on-channel

Chin-Yen Lee (2):
      wifi: rtw88: fix wrong pci_get_drvdata type in AER handlers
      wifi: rtw89: wow: send ARP reply packets instead of Null packets to keep alive

Christos Longros (1):
      wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers

David Laight (1):
      rfkill: Replace strcpy() with memcpy()

David Lee (1):
      wifi: rtw89: usb: skip ACPI capability check for USB devices

Devin Wittmayer (2):
      wifi: mt76: mt7925: add Netgear A8500 USB device ID
      wifi: mt76: mt7921: assert sniffer on chanctx change

Dian-Syuan Yang (3):
      wifi: rtw89: disable HTC field in AP mode
      wifi: rtw89: disable CSI STBC for VHT 160MHz
      wifi: rtw89: pci: enable LTR based on pcie control register

Dylan Eskew (2):
      wifi: mt76: mt7996: reduce phy work in set_coverage
      wifi: mt76: mt7996: limit work in set_bitrate_mask

ElXreno (2):
      wifi: mt76: route TDLS-peer frames as 3-addr non-DS in HW encap
      wifi: mt76: mt7925: don't disable AP BSS when removing TDLS peer

Emmanuel Grumbach (2):
      wifi: iwlwifi: add support for AX231
      wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 106

Eric Huang (2):
      wifi: rtw89: phy: support static PD level setting
      wifi: rtw89: use firmware offload for PHY and RF batch register writes

Felix Fietkau (3):
      wifi: mac80211: report assoc_link_id in station info for non-MLD STAs on MLD AP
      wifi: mt76: mt7996: fix out-of-bounds array access during hardware restart
      wifi: mt76: mt7996: add missing max_remain_on_channel_duration

Hangtian Zhu (1):
      wifi: ath12k: allow peer_id 0 in dp peer lookup

Hongling Zeng (1):
      wifi: mt76: mt7921: fix resource leak in probe error path

Hugo Villeneuve (1):
      wifi: rtlwifi: fix typos in comments in rtl8821ae_card_disable()

Ilan Peer (2):
      wifi: iwlwifi: mld: Require HT support for NAN
      wifi: mac80211: Free keys associated with NAN Device

Ingyu Jang (1):
      wifi: mt76: Drop unneeded mt76_register_debugfs_fops() return checks

Israel Kozitz (1):
      wifi: iwlwifi: mld: support FW TLV for NAN max channel switch time

JB Tsai (5):
      wifi: mt76: mt7921: refactor regulatory domain handling to regd.[ch]
      wifi: mt76: mt7921: refactor CLC support check flow
      wifi: mt76: mt7921: refactor regulatory notifier flow
      wifi: mt76: mt7921: add auto regdomain switch support
      wifi: mt76: mt7921: disable auto regd changes after user set

Javier Tia (9):
      wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
      wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
      wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
      wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
      wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
      wifi: mt76: mt7925: add MT7927 chip ID helpers
      wifi: mt76: mt7925: add MT7927 firmware paths
      wifi: mt76: mt7925: use irq_map for chip-specific interrupt handling
      wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927

Jeff Johnson (4):
      wifi: ath12k: Update Qualcomm copyrights
      wifi: ath11k: Update Qualcomm copyrights
      wifi: ath10k: Update Qualcomm copyrights
      wifi: ath: Update copyright in testmode_i.h

Jiajia Liu (2):
      wifi: mt76: add wcid publish check in mt76_sta_add
      wifi: mt76: transform aspm_conf for pci_disable_link_state

Johan Hovold (5):
      wifi: mt76: drop redundant device reference
      wifi: mt76x0u: drop redundant device reference
      wifi: mt76x2u: drop redundant device reference
      wifi: mt76: mt792xu: drop redundant device reference
      wifi: mt7601u: drop redundant device reference

Johannes Berg (29):
      wifi: cfg80211: remove 5/10 MHz channel support
      wifi: mac80211: remove 5/10 MHz channel code
      wifi: ieee80211: define some UHR link reconfiguration frame types
      wifi: mac80211: unify link STA removal in vif link removal
      wifi: mac80211: clean up return in ieee802_11_find_bssid_profile()
      wifi: mac80211: rename "multi_link_inner" variable
      wifi: mac80211: clarify beacon parsing with MBSSID/EMA
      wifi: mac80211: use local ml_basic_elem in parsing
      wifi: cfg80211: harden cfg80211_defragment_element()
      wifi: mac80211: always expose multi-link element
      wifi: mac80211: mlme: allow UHR only with MLO
      wifi: mac80211: explain ieee80211_determine_chan_mode() parsing
      wifi: Update UHR PHY capabilities to D1.4
      wifi: Update UHR MAC capabilities to D1.4
      wifi: mac80211: refactor link STA bandwidth update
      wifi: mac80211: parse and apply UHR DBE channel
      wifi: mac80211: AP: handle DBE for clients
      wifi: mac80211_hwsim: claim DBE capability
      Merge tag 'rtw-next-2026-06-03' of https://github.com/pkshih/rtw
      wifi: iwlwifi: fw: cut down NIC wakeups during dump
      wifi: iwlwifi: mvm: rename iwl_mvm_mac80211_idx_to_hwrate()
      wifi: iwlwifi: move iwl_fw_rate_idx_to_plcp() to mvm
      wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o netdetect
      wifi: iwlwifi: mvm: fix P2P-Device binding handling
      wifi: iwlwifi: pcie: fix write pointer move detection
      Merge tag 'ath-next-20260602' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-next-2026-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'mt76-next-2026-06-09' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20260609' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Johnson Tsai (5):
      wifi: rtw89: debug: disable hw_scan for latency-sensitive scenarios
      wifi: rtw89: debug: disable inactive power save to reduce bus overhead
      wifi: rtw89: 8832cu: Add ID 2c7c:8206 for RTL8832CU
      wifi: rtw89: add dev_id_quirks to driver_info for per-device quirk control
      wifi: rtw89: usb: add serial_number and uuid sysfs attributes for 0x28de:0x2432

Kuan-Chung Chen (7):
      wifi: rtw89: mlo: rearrange MLSR link decision flow
      wifi: rtw89: phy: support per PHY RX statistics
      wifi: rtw89: debug: bb_info entry including TX rate count for WiFi 7 chips
      wifi: rtw89: debug: add PMAC counter in bb_info
      wifi: rtw89: debug: extend bb_info with TX status and PER
      wifi: rtw89: debug: add RX statistics in bb_info
      wifi: rtw89: debug: add BB diagnose

Kwan Lai Chee Hou (1):
      wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode

Lachlan Hodges (1):
      wifi: mac80211: basic S1G rx rate reporting support

Lorenzo Bianconi (5):
      wifi: mt76: mt7996: Fix NULL pointer dereference in mt7996_init_tx_queues()
      wifi: mt76: mt7996: Fix possible token leak in mt7996_tx_prepare_skb()
      wifi: mt76: mt7996: Fix possible NULL pointer dereference in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7996: fix reading zeroed info->control.flags after mt76_tx_status_skb_add()
      wifi: mt76: mt7996: remove redundant pdev->bus check in probe

Louis Kotze (1):
      wifi: rtw89: phy: increase RF calibration timeouts for USB transport

Luka Gejak (2):
      wifi: rtw88: increase TX report timeout to fix race condition
      wifi: rtw88: usb: fix memory leaks on USB write failures

Martin Kaiser (1):
      wifi: rtw88: remove rtw_txq_dequeue

Masashi Honma (9):
      wifi: mac80211: Use struct instead of macro for PREQ frame
      wifi: mac80211: Use struct instead of macro for PREP frame
      wifi: mac80211: Use struct instead of macro for PERR frame
      wifi: mac80211: Fix overread in PREQ frame processing
      wifi: mac80211: Fix overread in PREP frame processing
      wifi: mac80211: Fix PERR frame processing
      wifi: mac80211: Add KUnit test for ieee80211_mesh_preq_size_ok
      wifi: mac80211: Add KUnit test for ieee80211_mesh_prep_size_ok
      wifi: mac80211: Add KUnit test for ieee80211_mesh_perr_size_ok

Miaoqing Pan (3):
      wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
      wifi: ath11k: add MSDU length validation for TKIP MIC error
      wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()

Miri Korenblit (7):
      wifi: iwlwifi: remove stale comment
      wifi: iwlwifi: remove mvm prefix from marker command
      wifi: iwlwifi: mld: fix smatch warning
      wifi: iwlwifi: mld: always allow mimo in NAN
      wifi: iwlwifi: fix a typo
      wifi: iwlwifi: trans: export the maximum supported hcmd size
      wifi: iwlwifi: mvm: remove __must_check annotation from command sending

Moriya Itzchaki (1):
      wifi: iwlwifi: fix STEP_URM register address for SC devices

Myeonghun Pak (1):
      wifi: mt76: mt7925: clean up DMA on probe failure

Nathan Chancellor (1):
      wifi: mac80211: Fix -Wc23-extensions in hwmp_route_info_get()

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mld: set fast-balance scan for active EMLSR

Panagiotis Petrakopoulos (1):
      wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()

Ping-Ke Shih (41):
      wifi: rtl8xxxu: validate action frame size before using in rtl8xxxu_dump_action()
      wifi: rtlwifi: validate action frame size in rtl_action_proc()
      wifi: rtlwifi: validate action frame size before using in _rtl_pci_tx_isr()
      wifi: rtw89: 8922d: fix typo rx_freq_frome_ie
      wifi: rtw89: pci: no need to wait CLK ready for RTL8922DE
      wifi: rtw89: add AMPDU to radiotap
      wifi: rtw89: add VHT beamformed to radiotap
      wifi: rtw89: SNIFFER_MODE bit along IEEE80211_CONF_MONITOR
      wifi: rtw89: phy: define PHY status IE length for generations
      wifi: rtw89: phy: enable IE-09/IE-10 PHY status report for monitor mode
      wifi: rtw89: move HE radiotap to an individual function
      wifi: rtw89: fill VHT radiotap
      wifi: rtw89: fill HE-SU/HE-TB/HE-MU/HE-EXT_SU radiotap
      wifi: rtw89: debug: make implementation of beacon_info entry in order
      wifi: rtw89: add debugfs entry of monitor mode options to capture HE-MU packets
      wifi: rtw89: phy: check length before parsing PHY status IE
      wifi: rtw89: phy: skip trailing 8-byte zeros of PHY status IE for RTL8922D
      wifi: rtw89: phy: support PHY status IE-09 GEN2 for RTL8922D
      wifi: rtw89: check skb headroom before adding radiotap
      wifi: rtw89: phy: define BB wrap data for RTL8922D variants
      wifi: rtw89: phy: set BB wrap of out-of-band DPD
      wifi: rtw89: phy: set BB wrap of DPD by bandwidth
      wifi: rtw89: phy: set BB wrap of control options
      wifi: rtw89: phy: set BB wrap of QAM threshold
      wifi: rtw89: phy: set BB wrap of QAM options
      wifi: rtw89: phy: set BB wrap of trigger-base partial band
      wifi: rtw89: phy: set BB wrap of CIM3K
      wifi: rtw89: phy: change order to align register order
      wifi: rtw89: phy: configure control options of BB wrapper by RFSI band
      wifi: rtw89: phy: add BB wrapper generation 3 for RTL8922D variant
      wifi: rtw89: pci: not disable PCI completion timeout control for a variant of RTL8922DE
      wifi: rtw89: pci: disable PCI PHY error flag 8
      wifi: rtw89: clear auto K delay value before downloading firmware
      wifi: rtw89: 8922d: change naming number and update values for WDE/PLE quota
      wifi: rtw89: mac: add field of release report size to DLE quota
      wifi: rtw89: mac: consolidate quota into a struct for variant chips
      wifi: rtw89: 8922d: add quota for RTL8922DE variant
      wifi: rtw89: 8922d: refactor digital power compensation to support new format
      wifi: rtw89: 8922d: support new digital power compensation format
      wifi: rtw89: fw: load TX compensation element by RFE type
      wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)

Po-Hao Huang (2):
      wifi: rtw89: 8852a: refine power save to lower latency
      wifi: rtw89: correct drop logic for malformed AMPDU frames

Rajat Gupta (1):
      wifi: mt76: use kfree_rcu for offchannel link in mt76_put_vif_phy_link

Rosen Penev (11):
      wifi: ath11k: use kzalloc_flex for struct scan_req_params
      wifi: mac80211: fold tid_ampdu_rx allocations into a flexible array
      wifi: wcn36xx: allocate chan_surveys with main struct
      wifi: ath9k_htc: use module_usb_driver
      wifi: ath9k: Clear DMA descriptors without memset
      wifi: ath9k: remove TX99 power array zero init
      wifi: ath9k: remove disabling of bands
      wifi: ath9k_htc: allocate tx_buf and buf together
      wifi: mt76: fix of_get_mac_address error handling
      wifi: brcm80211: change current_bss to value
      wifi: brcmfmac: flowring: simplify flow allocation

Runyu Xiao (1):
      wifi: qtnfmac: topaz: defer IRQ enabling until IPC init

Ryder Lee (5):
      wifi: mt76: mt7996: disable UNI_BSS_INFO_PROTECT_INFO for mt7996
      wifi: mt76: mt7915: fix potential tx_retries underflow
      wifi: mt76: mt7921: fix potential tx_retries underflow
      wifi: mt76: mt7925: fix potential tx_retries underflow
      wifi: mt76: mt7996: fix potential tx_retries underflow

Sean Wang (22):
      wifi: mt76: connac: replace is_mt7925() with is_connac3()
      wifi: mt76: mt7925: use link-specific removal for non-MLD STA
      wifi: mt76: connac: tolerate inactive BSS deactivation
      wifi: mt76: mt792x: add MT7927 WFSYS reset support
      wifi: mt76: mt792x: factor out common DMA queue allocation
      wifi: mt76: mt7925: switch DMA init to common mt792x queue helpers
      wifi: mt76: mt792x: add MT7927-specific PCIe DMA support
      wifi: mt76: mt7925: sync MT7927 BSS band assignment
      wifi: mt76: mt7925: add MBMC event handling
      wifi: mt76: mt792x: enable CNM ops for MT7927
      wifi: mt76: mt7925: add MT7927 PCIe support
      wifi: mt76: mt7925: add MT7927 USB support
      wifi: mt76: mt7925: keep TX BA state in the primary WCID
      wifi: mt76: mt7925: pass WCID explicitly to mt7925_mcu_sta_ba()
      wifi: mt76: mt7925: program BA state on active links
      wifi: mt76: mt792x: skip MLD header rewrite for 802.3 encap TX
      wifi: mt76: mt7921u: add MT7902 USB support
      wifi: mt76: connac: use a helper to cache txpower_cur
      wifi: mt76: connac: factor out rate power limit calculation
      wifi: mt76: mt792x: report txpower for the requested vif link
      wifi: mt76: mt792x: add common USB transport reset helpers
      wifi: mt76: mt7921u: escalate broken USB transport to device reset

Shahar Tzarfati (4):
      wifi: iwlwifi: cfg: Revert "wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file"
      wifi: iwlwifi: remove orphaned DC2DC config enum
      wifi: iwlwifi: stop supporting core101
      wifi: iwlwifi: mld: drop TLC config cmd v4/v5 compat code

Shin-Yi Lin (1):
      wifi: rtw89: Correct data type for scan index to avoid infinite loop

Stepan Ionichev (1):
      wifi: wcn36xx: fix spelling mistakes in dxe header comment

Tamizh Chelvam Raja (9):
      wifi: ath12k: Set WDS vdev parameter for 4-address station interface
      wifi: ath12k: Add support for 4-address mode
      wifi: ath12k: Add 4-address mode support for eth offload
      wifi: ath12k: Add support for 4-address NULL frame handling
      wifi: ath12k: Add support for 4-address frame notification
      wifi: ath12k: Handle 4-address EAPOL frames from WBM error path
      wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()
      wifi: mac80211: Add multicast to unicast support for 802.3 path
      wifi: mac80211: Add 802.3 multicast encapsulation offload support

Thiyagarajan Pandiyan (1):
      wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications

Tristan Madani (5):
      wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
      wifi: rtw89: add bounds check on firmware mac_id in link lookup
      wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
      wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
      wifi: wcn36xx: fix OOB read from short trigger BA firmware response

Wei Zhang (3):
      wifi: ath11k: raise max vdevs to 4 on hardware with P2P and dual-station support
      wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
      wifi: ath12k: fix NULL deref in change_sta_links for unready link

Wen Gong (1):
      wifi: ath12k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported

Zenm Chen (1):
      wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S

Zong-Zhe Yang (10):
      wifi: rtw89: 8852bt: configure support_noise field explicitly
      wifi: rtw89: chan: introduce new helper to get entity current configuration
      wifi: rtw89: 8922d: update RF calibration flow for MLD
      wifi: rtw89: debug: Wi-Fi 7 show count of SER L0 simulation
      wifi: rtw89: debug: Wi-Fi 7 update simulation of SER L0/L1 by halt H2C command
      wifi: rtw89: fw: dump status of H2C command and C2H event for SER
      wifi: rtw89: fw: load TX power track element according to AID
      wifi: rtw89: Wi-Fi 7 configure TX power limit for large MRU
      wifi: rtw89: debug: show large MRU in txpwr_table dbgfs
      wifi: rtw89: 8922d: configure TX shape settings

傅继晗 (1):
      wifi: mac80211: fix monitor mode frame capture for real chanctx drivers

 .../ABI/testing/sysfs-class-ieee80211-rtw89        |  24 +
 drivers/net/wireless/ath/ath10k/bmi.c              |   1 -
 drivers/net/wireless/ath/ath10k/ce.c               |   1 -
 drivers/net/wireless/ath/ath10k/coredump.c         |   1 -
 drivers/net/wireless/ath/ath10k/coredump.h         |   2 +-
 drivers/net/wireless/ath/ath10k/debug.c            |   1 -
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |   1 -
 drivers/net/wireless/ath/ath10k/htc.c              |   1 -
 drivers/net/wireless/ath/ath10k/htt.c              |   2 +-
 drivers/net/wireless/ath/ath10k/htt.h              |   2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |   1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c           |   1 -
 drivers/net/wireless/ath/ath10k/hw.c               |   2 +-
 drivers/net/wireless/ath/ath10k/hw.h               |   2 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   1 -
 drivers/net/wireless/ath/ath10k/pci.h              |   2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c     |   2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |   2 +-
 drivers/net/wireless/ath/ath10k/rx_desc.h          |   2 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |   2 +-
 drivers/net/wireless/ath/ath10k/thermal.c          |   2 +-
 drivers/net/wireless/ath/ath10k/usb.h              |   2 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |   2 +-
 drivers/net/wireless/ath/ath10k/wow.c              |   2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   2 +-
 drivers/net/wireless/ath/ath11k/ahb.h              |   2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |   1 -
 drivers/net/wireless/ath/ath11k/ce.h               |   2 +-
 drivers/net/wireless/ath/ath11k/core.c             |  10 +-
 drivers/net/wireless/ath/ath11k/coredump.c         |   1 -
 drivers/net/wireless/ath/ath11k/coredump.h         |   2 +-
 drivers/net/wireless/ath/ath11k/debug.c            |   1 -
 drivers/net/wireless/ath/ath11k/debugfs.c          |   1 -
 drivers/net/wireless/ath/ath11k/debugfs.h          |   2 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |   1 -
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |   2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.h      |   2 +-
 drivers/net/wireless/ath/ath11k/dp.c               |   1 -
 drivers/net/wireless/ath/ath11k/dp.h               |   2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  59 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h            |   2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   1 -
 drivers/net/wireless/ath/ath11k/dp_tx.h            |   2 +-
 drivers/net/wireless/ath/ath11k/fw.c               |   1 -
 drivers/net/wireless/ath/ath11k/fw.h               |   2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h         |   2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |   2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h           |   2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c           |   2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h           |   2 +-
 drivers/net/wireless/ath/ath11k/hif.h              |   2 +-
 drivers/net/wireless/ath/ath11k/htc.c              |   2 +-
 drivers/net/wireless/ath/ath11k/htc.h              |   2 +-
 drivers/net/wireless/ath/ath11k/hw.c               |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  72 +-
 drivers/net/wireless/ath/ath11k/mac.h              |   2 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |   2 +-
 drivers/net/wireless/ath/ath11k/p2p.c              |   2 +-
 drivers/net/wireless/ath/ath11k/p2p.h              |   2 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |   1 -
 drivers/net/wireless/ath/ath11k/pcic.h             |   2 +-
 drivers/net/wireless/ath/ath11k/peer.c             |   2 +-
 drivers/net/wireless/ath/ath11k/peer.h             |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |   2 +-
 drivers/net/wireless/ath/ath11k/reg.h              |   2 +-
 drivers/net/wireless/ath/ath11k/rx_desc.h          |   2 +-
 drivers/net/wireless/ath/ath11k/spectral.c         |   1 -
 drivers/net/wireless/ath/ath11k/spectral.h         |   2 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |   2 +-
 drivers/net/wireless/ath/ath11k/testmode.h         |   2 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |   2 +-
 drivers/net/wireless/ath/ath11k/thermal.h          |   2 +-
 drivers/net/wireless/ath/ath11k/trace.h            |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   2 +-
 drivers/net/wireless/ath/ath11k/wow.c              |   2 +-
 drivers/net/wireless/ath/ath11k/wow.h              |   2 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |   2 +-
 drivers/net/wireless/ath/ath12k/acpi.h             |   2 +-
 drivers/net/wireless/ath/ath12k/core.h             |   9 +
 drivers/net/wireless/ath/ath12k/coredump.c         |   2 +-
 drivers/net/wireless/ath/ath12k/coredump.h         |   2 +-
 drivers/net/wireless/ath/ath12k/dbring.h           |   2 +-
 drivers/net/wireless/ath/ath12k/debug.h            |   2 +-
 drivers/net/wireless/ath/ath12k/debugfs.h          |   2 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.h      |   2 +-
 drivers/net/wireless/ath/ath12k/dp.c               |  10 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   6 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c          |   2 +-
 drivers/net/wireless/ath/ath12k/dp_peer.h          |   2 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  13 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   3 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   4 +-
 drivers/net/wireless/ath/ath12k/hif.h              |   2 +-
 drivers/net/wireless/ath/ath12k/hw.h               |  25 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 232 ++++-
 drivers/net/wireless/ath/ath12k/mac.h              |   3 +
 drivers/net/wireless/ath/ath12k/p2p.c              |   1 -
 drivers/net/wireless/ath/ath12k/p2p.h              |   2 +-
 drivers/net/wireless/ath/ath12k/peer.c             |  11 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   2 +-
 drivers/net/wireless/ath/ath12k/reg.h              |   2 +-
 drivers/net/wireless/ath/ath12k/testmode.h         |   2 +-
 drivers/net/wireless/ath/ath12k/trace.c            |   2 +-
 drivers/net/wireless/ath/ath12k/trace.h            |   2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |  95 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |  43 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h      |   4 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |  16 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |  16 +
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c     |   4 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h     |   1 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  16 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  48 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  47 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  17 +
 drivers/net/wireless/ath/ath12k/wow.h              |   2 +-
 drivers/net/wireless/ath/ath5k/base.c              |   2 -
 drivers/net/wireless/ath/ath9k/ar9002_mac.c        |  15 +-
 drivers/net/wireless/ath/ath9k/ar9003_mac.c        |  23 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c        |   4 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |  24 +-
 drivers/net/wireless/ath/ath9k/hif_usb.h           |   4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |  18 -
 drivers/net/wireless/ath/ath9k/hw.c                |  16 +-
 drivers/net/wireless/ath/ath9k/hw.h                |   2 -
 drivers/net/wireless/ath/ath9k/init.c              |   1 -
 drivers/net/wireless/ath/testmode_i.h              |   2 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c             |   4 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |  13 +-
 drivers/net/wireless/ath/wcn36xx/smd.c             |  13 +
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h         |   2 +-
 drivers/net/wireless/broadcom/b43/main.c           |  22 +-
 drivers/net/wireless/broadcom/b43/radio_2057.c     | 230 ++++-
 drivers/net/wireless/broadcom/b43/tables_nphy.c    |  58 ++
 .../broadcom/brcm80211/brcmfmac/flowring.c         |  10 +-
 .../broadcom/brcm80211/brcmfmac/flowring.h         |   2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |  40 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  16 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |  12 -
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h |  11 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |  16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |  34 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  96 +--
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/rs.c         |  27 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   6 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   5 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  15 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  15 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   6 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |   6 +
 .../intel/iwlwifi/mld/tests/link-selection.c       | 282 ++++++-
 .../net/wireless/intel/iwlwifi/mld/tests/link.c    | 474 ++++++++++-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |  60 ++
 .../net/wireless/intel/iwlwifi/mld/tests/utils.h   |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |  78 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  26 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  32 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   3 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |   1 +
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |  12 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |   7 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  19 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   1 +
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c    |   2 -
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |   1 -
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |   3 -
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  21 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  13 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  49 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  29 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |   3 -
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   8 +
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |   2 -
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |  98 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  29 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |   1 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |  20 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c   | 206 +++++
 drivers/net/wireless/mediatek/mt76/mt7921/regd.h   |  19 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |  11 +-
 .../net/wireless/mediatek/mt76/mt7925/debugfs.c    |   2 -
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  29 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 101 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 116 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  29 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 151 +++-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  12 +-
 .../net/wireless/mediatek/mt76/mt7925/testmode.c   |   5 +
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |  22 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |  33 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  56 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    | 198 ++++-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  23 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |  79 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  51 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  29 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  36 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  22 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/pci.c           |   8 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |   2 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |   2 +
 drivers/net/wireless/mediatek/mt7601u/usb.c        |   3 -
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |   6 +-
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192f.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8710b.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  77 +-
 drivers/net/wireless/realtek/rtl8xxxu/regs.h       |   2 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   7 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |  17 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   7 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |  21 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.h   |   2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   3 +
 drivers/net/wireless/realtek/rtw88/pci.c           |  29 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |  31 +-
 drivers/net/wireless/realtek/rtw88/rx.h            |   6 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   8 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |  25 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |  22 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |  12 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   3 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  92 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |  21 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 815 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h          | 347 +++++++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 940 +++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.c            | 500 ++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h            | 115 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           | 153 +++-
 drivers/net/wireless/realtek/rtw89/mac.h           |  52 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  29 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  68 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  41 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   6 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  15 +
 drivers/net/wireless/realtek/rtw89/phy.c           | 622 +++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h           | 164 +++-
 drivers/net/wireless/realtek/rtw89/phy_be.c        | 724 ++++++++++++----
 drivers/net/wireless/realtek/rtw89/ps.c            |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h           | 289 +++++++
 drivers/net/wireless/realtek/rtw89/regd.c          |  24 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  58 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  63 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  58 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |  58 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  68 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |  13 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 335 +++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |  22 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922au.c     |  86 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c      | 445 +++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c  |  92 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h  |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922de.c     |   2 +
 drivers/net/wireless/realtek/rtw89/sar.c           |   4 +
 drivers/net/wireless/realtek/rtw89/txrx.h          | 110 +++
 drivers/net/wireless/realtek/rtw89/usb.c           | 199 ++++-
 drivers/net/wireless/realtek/rtw89/usb.h           |  11 +-
 drivers/net/wireless/ti/wlcore/main.c              |  23 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  30 +-
 include/linux/ieee80211-eht.h                      |  34 +-
 include/linux/ieee80211-mesh.h                     | 212 +++++
 include/linux/ieee80211-s1g.h                      |   2 +-
 include/linux/ieee80211-uhr.h                      | 201 ++++-
 include/linux/ieee80211.h                          |  17 +
 include/net/cfg80211.h                             |   4 +-
 include/net/mac80211.h                             |   5 +
 net/mac80211/agg-rx.c                              |  22 +-
 net/mac80211/ap.c                                  | 146 ++++
 net/mac80211/cfg.c                                 |  37 +-
 net/mac80211/chan.c                                |   4 +-
 net/mac80211/he.c                                  |  25 +-
 net/mac80211/ht.c                                  |  24 +-
 net/mac80211/ibss.c                                |  31 +-
 net/mac80211/ieee80211_i.h                         |  26 +-
 net/mac80211/iface.c                               |   6 +
 net/mac80211/link.c                                |  30 +
 net/mac80211/mesh.c                                |  36 +-
 net/mac80211/mesh_hwmp.c                           | 176 ++--
 net/mac80211/mesh_plink.c                          |   2 -
 net/mac80211/mlme.c                                | 567 +++++++++++--
 net/mac80211/offchannel.c                          |   4 +-
 net/mac80211/parse.c                               |  68 +-
 net/mac80211/rate.c                                |   8 +-
 net/mac80211/rx.c                                  |  45 +-
 net/mac80211/spectmgmt.c                           |  10 -
 net/mac80211/sta_info.c                            |  61 +-
 net/mac80211/sta_info.h                            |  35 +-
 net/mac80211/status.c                              |  25 +
 net/mac80211/tests/chan-mode.c                     |   4 +-
 net/mac80211/tests/elems.c                         | 282 +++++++
 net/mac80211/tx.c                                  | 111 ++-
 net/mac80211/util.c                                |   7 -
 net/rfkill/core.c                                  |   6 +-
 net/wireless/chan.c                                |  33 +-
 net/wireless/core.c                                |   4 +-
 net/wireless/nl80211.c                             |  16 +-
 net/wireless/scan.c                                |   6 +-
 net/wireless/util.c                                |   3 -
 353 files changed, 11533 insertions(+), 2253 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922au.c

