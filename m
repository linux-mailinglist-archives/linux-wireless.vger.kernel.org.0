Return-Path: <linux-wireless+bounces-20617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F2A6A6E3
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 14:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0B4607E3
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341BCF9EC;
	Thu, 20 Mar 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r2lQU5YH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44333CA;
	Thu, 20 Mar 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476282; cv=none; b=hA4mu7RpmInhx4CYHgtLgVexU2MyxlKH+9lTCAz26XWCHAMdeqdLFN2OLRLI91SUx80r6pmW8C/eDKPgJcHuk7nPZqMPmw5IicJKcazTtwCpt343lEMZCLydwgnWLtegZ4Ol+NwoP6kEDkpd2XhZUUml0S81qbl8STB5LKZAspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476282; c=relaxed/simple;
	bh=wbEPhcmx4e2xii0o1j0dRF09o6CPf/cx4t0CpBbiweQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkVBVc4t/7EY1TMf2gbHuM2qSIzfwUAhQZg2kcEWwmMWtaQZ1OyInawYEEbY/G/tevG5WTfMd45389nxj6zLtiLx88q3AgJn38sbm+CTo6HxILPO4KmmgGLRR/8T7StbW1JM0N/2T/DH6+kRSWJp3QLfrUXiFGky368uADUzWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r2lQU5YH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=/3dQGc5s0qog8OOEJf3qifQ4qaUpQy/ReGj+i3YNC0c=; t=1742476278; x=1743685878; 
	b=r2lQU5YHhaADxl+UpYS3de/UlUGmzAXP1zbm38IpYKcquXacZyRPkwVx8k+xgXGUfqwZzIjQ7r4
	8wQHnUUbn6DRuTYgtRZspP+QHDcnW1HX03bXXZGD6eRw8UX6wzjtz5Dr/qHL0IhZ6w6pzHS4gGSzt
	dfQOLbxynznm4yxYqUxskwffr/31MfUSdM6FFzmUO5pPrrPt3xjraQ5eGgkXQW21Kw5PhKQajRAeC
	2LTP4/ThvSJONrY+7wtlyj2ahGSnnzXEWM1npRgFE2W+ZpisnwK6E6sJuLvX/4TmgI6SAPLE0e/Jg
	uRUlmCGWleLU0xbUORE3+d294tzypvSD4XYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tvFfy-0000000HRqX-2cBl;
	Thu, 20 Mar 2025 14:11:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-next-2025-03-20
Date: Thu, 20 Mar 2025 14:09:50 +0100
Message-ID: <20250320131106.33266-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi,

This is obviously going to be the last pull request before
the merge window. Nothing really stands out except for the
new iwlmld sub-driver for iwlwifi.

Note I pulled net-next back after wireless/net went in, to
fix the reported conflicts.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 50698b298b3995d253bd0b85ff7f60cae6f51e6a:

  Merge branch 'net-phy-rework-linkmodes-handling-in-a-dedicated-file' (2025-03-18 09:03:18 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-03-20

for you to fetch changes up to 1794d7ab34d2221ac7eb921b171e75b856e10561:

  wifi: mt76: mt7996: fix locking in mt7996_mac_sta_rc_work() (2025-03-19 19:44:25 +0100)

----------------------------------------------------------------
More features for 6.15, major changes:
 * cfg80211/mac80211: fix and enable link reconfiguration
 * rtw88: support RTL8814AE/RTL8814AU
 * mt7996: preparations for MLO
 * ath12k: continued work on MLO
 * iwlwifi: add new iwlmld sub-driver/op-mode for
   some current and future devices
 * wfx: wowlan support

----------------------------------------------------------------
Aaradhana Sahu (8):
      wifi: ath: create common testmode_i.h file for ath drivers
      wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
      wifi: ath12k: add factory test mode support
      wifi: ath12k: Disable MLO in Factory Test Mode
      wifi: ath12k: Fetch regdb.bin file from board-2.bin
      wifi: ath12k: Enable MLO setup ready and teardown commands for single split-phy device
      wifi: ath12k: Remove dependency on single_chip_mlo_support for mlo_capable flag
      wifi: ath12k: Enable MLO for single split-phy PCI device

Aditya Kumar Singh (15):
      wifi: ath12k: update beacon template function to use arvif structure
      wifi: ath12k: fix handling of CSA offsets in beacon template command
      wifi: ath12k: update the latest CSA counter
      wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE
      wifi: ath12k: relocate ath12k_mac_ieee80211_sta_bw_to_wmi()
      wifi: ath12k: handle ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
      wifi: ath12k: eliminate redundant debug mask check in ath12k_dbg()
      wifi: ath12k: introduce ath12k_generic_dbg()
      wifi: ath12k: remove redundant vif settings during link interface creation
      wifi: ath12k: remove redundant logic for initializing arvif
      wifi: ath12k: use arvif instead of link_conf in ath12k_mac_set_key()
      wifi: ath12k: relocate a few functions in mac.c
      wifi: ath12k: allocate new links in change_vif_links()
      wifi: ath12k: handle link removal in change_vif_links()
      wifi: nl80211: store chandef on the correct link when starting CAC

Aloka Dixit (5):
      wifi: ath11k: refactor transmitted arvif retrieval
      wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
      wifi: ath12k: refactor transmitted arvif retrieval
      wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
      wifi: ath12k: pass BSSID index as input for EMA

Anjaneyulu (1):
      wifi: cfg80211: allow IR in 20 MHz configurations

Arnd Bergmann (1):
      wifi: iwlegacy: avoid size increase

Avraham Stern (3):
      wifi: mac80211: allow 320 MHz FTM measurements
      wifi: iwlwifi: mvm: fix setting the TK when associated
      wifi: iwlwifi: mld: move the ftm initiator data to ftm-initiator.h

Avula Sri Charan (1):
      wifi: ath12k: Avoid napi_sync() before napi_enable()

Balamurugan Mahalingam (4):
      wifi: ath12k: Add EHT MCS support in Extended Rx statistics
      wifi: ath12k: Refactor the format of peer rate table information
      wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
      wifi: ath12k: Add support for MLO Multicast handling in driver

Baochen Qiang (1):
      wifi: ath12k: use link specific bss_conf as well in ath12k_mac_vif_cache_flush()

Bart Van Assche (1):
      wifi: ath12k: Fix locking in "QMI firmware ready" error paths

Benjamin Berg (1):
      wifi: iwlwifi: mld: assume wiphy is locked when getting BSS ifaces

Benjamin Lin (1):
      wifi: mt76: mt7996: revise TXS size

Bitterblue Smith (15):
      wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
      wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
      wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
      wifi: rtw88: Extend rtw_phy_config_swing_table() for RTL8814AU
      wifi: rtw88: Extend rtw_debugfs_get_phy_info() for RTL8814AU
      wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU
      wifi: rtw88: Add some definitions for RTL8814AU
      wifi: rtw88: Add rtw8814a_table.c (part 1/2)
      wifi: rtw88: Add rtw8814a_table.c (part 2/2)
      wifi: rtw88: Add rtw8814a.{c,h}
      wifi: rtw88: Add rtw8814ae.c
      wifi: rtw88: Add rtw8814au.c
      wifi: rtw88: Enable the new RTL8814AE/RTL8814AU drivers

Chih-Kang Chang (1):
      wifi: rtw89: Parse channel from IE to correct invalid hardware reports during scanning

Ching-Te Ku (4):
      wifi: rtw89: coex: RTL8852BT coexistence Wi-Fi firmware support for 0.29.122.0
      wifi: rtw89: coex: Fix coexistence report not show as expected
      wifi: rtw89: coex: Add parser for Bluetooth channel map report version 7
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.4

Dan Carpenter (1):
      wifi: iwlwifi: Fix uninitialized variable with __free()

Daniel Gabay (1):
      wifi: iwlwifi: w/a FW SMPS mode selection

Dian-Syuan Yang (1):
      wifi: rtw89: set force HE TB mode when connecting to 11ax AP

Dinesh Karthikeyan (4):
      wifi: ath12k: Support Sounding Stats
      wifi: ath12k: Support Latency Stats
      wifi: ath12k: Support Uplink OFDMA Trigger Stats
      wifi: ath12k: Support Received FSE Stats

Dmitry Antipov (4):
      wifi: ath9k: cleanup struct ath_tx_control and ath_tx_prepare()
      wifi: ath9k: use unsigned long for activity check timestamp
      wifi: ath9k: do not submit zero bytes to the entropy pool
      wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps

Edward Adam Davis (1):
      wifi: cfg80211: init wiphy_work before allocating rfkill fails

Emmanuel Grumbach (6):
      wifi: iwlwifi: add support for BE213
      wifi: iwlwifi: fix the ECKV UEFI variable name
      wifi: iwlwifi: fix print for ECKV
      wifi: iwlwifi: mld: we support v6 of compressed_ba_notif
      wifi: iwlwifi: remove a buggy else statement in op_mode selection
      wifi: iwlwifi: do not use iwlmld for non-wifi7 devices

Ethan Carter Edwards (1):
      wifi: ath12k: cleanup ath12k_mac_mlo_ready()

Felix Fietkau (5):
      wifi: mt76: scan: set vif offchannel link for scanning/roc
      wifi: mt76: mt7996: use the correct vif link for scanning/roc
      wifi: mt76: only mark tx-status-failed frames as ACKed on mt76x0/2
      wifi: mt76: mt7996: implement driver specific get_txpower function
      wifi: mt76: scan: fix setting tx_info fields

Gustavo A. R. Silva (1):
      wifi: iwlwifi: dvm: Avoid -Wflex-array-member-not-at-end warnings

Haoxiang Li (1):
      wifi: mt76: Add check for devm_kstrdup()

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Ilan Peer (4):
      wifi: mac80211_hwsim: Fix MLD address translation
      wifi: cfg80211: Update the link address when a link is added
      wifi: mac80211: Notify cfg80211 about added link addresses
      wifi: iwlwifi: mld: Correctly configure the A-MSDU max lengths

Jeff Chen (3):
      wifi: mwifiex: Fix HT40 bandwidth issue.
      wifi: mwifiex: Fix premature release of RF calibration data.
      wifi: mwifiex: Fix RF calibration data download from file

Johannes Berg (27):
      Merge tag 'ath-next-20250305' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: cfg80211: move link reconfig parameters into a struct
      wifi: cfg80211: allow setting extended MLD capa/ops
      wifi: mac80211: mlme: support extended MLD capa/ops in assoc
      wifi: mac80211: fix U-APSD check in ML reconfiguration
      wifi: cfg80211: improve supported_selector documentation
      wifi: mac80211: fix userspace_selectors corruption
      wifi: mac80211: fix warning on disconnect during failed ML reconf
      wifi: mac80211: fix ML reconf reset in disconnect
      wifi: mac80211: don't include MLE in ML reconf per-STA profile
      wifi: mac80211: set WMM in ML reconfiguration
      wifi: iwlwifi: mark Br device not integrated
      wifi: iwlwifi: fix debug actions order
      wifi: iwlwifi: mld: initialize regulatory early
      wifi: iwlwifi: mld: fix OMI time protection logic
      wifi: iwlwifi: mld: enable OMI bandwidth reduction on 6 GHz
      wifi: iwlwifi: mld: remove AP keys only for AP STA
      wifi: mac80211: remove SSID from ML reconf
      wifi: mac80211: use supported selectors from assoc in ML reconf
      wifi: cfg80211: expose cfg80211_chandef_get_width()
      wifi: mac80211: use cfg80211_chandef_get_width()
      Merge net-next/main to resolve conflicts
      wifi: mac80211: fix indentation in ieee80211_set_monitor_channel()
      wifi: nl80211: re-enable multi-link reconfiguration
      Merge tag 'rtw-next-2025-03-13' of https://github.com/pkshih/rtw
      Merge tag 'mt76-next-2025-03-19' of https://github.com/nbd168/wireless
      wifi: mt76: mt7996: fix locking in mt7996_mac_sta_rc_work()

Jérôme Pouiller (5):
      wifi: wfx: align declarations between bus_spi.c and bus_sdio.c
      wifi: wfx: declare support for WoWLAN
      wifi: wfx: allow SPI device to wake up the host
      wifi: wfx: allow SDIO device to wake up the host
      wifi: wfx: allow to enable WoWLAN using NL80211

Kang Yang (1):
      wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

Karthikeyan Periyasamy (9):
      wifi: ath12k: Refactor the monitor Rx parser handler argument
      wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
      wifi: ath12k: Refactor Rx status TLV parsing procedure argument
      wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
      wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
      wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
      wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
      wifi: ath12k: Update the peer id in PPDU end user stats TLV
      wifi: ath12k: Add peer extended Rx statistics debugfs support

Kees Cook (4):
      wifi: mwifiex: Add __nonstring annotations for unterminated strings
      wifi: zd1211rw: Add __nonstring annotations for unterminated strings
      wifi: virt_wifi: Add __nonstring annotations for unterminated strings
      wifi: rtw88: Add __nonstring annotations for unterminated strings

Krzysztof Kozlowski (5):
      dt-bindings: wireless: ath10k: Strip ath10k prefix from calibration properties
      dt-bindings: wireless: ath11k: Strip ath11k prefix from calibration property
      dt-bindings: wireless: ath12k: Strip ath12k prefix from calibration property
      wifi: ath10k: Deprecate qcom,ath10k-calibration-variant properties
      wifi: ath11k: Deprecate qcom,ath11k-calibration-variant properties

Kuan-Chung Chen (6):
      wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
      wifi: rtw89: add support for HW TKIP crypto
      wifi: rtw89: add support for negative values of dBm to linear conversion
      wifi: rtw89: refine mechanism of TAS
      wifi: rtw89: enable dynamic antenna gain based on country
      wifi: rtw89: 8922a: enable dynamic antenna gain

Lingbo Kong (10):
      wifi: ath12k: report station mode transmit rate
      wifi: ath12k: report station mode receive rate for IEEE 802.11be
      wifi: ath12k: report station mode signal strength
      wifi: ath12k: Add support for obtaining the buffer type ACPI function bitmap
      wifi: ath12k: Add Support for enabling or disabling specific features based on ACPI bitflag
      wifi: ath12k: Adjust the timing to access ACPI table
      wifi: ath12k: Add support for reading variant from ACPI to download board data file
      wifi: ath12k: Dump PDEV transmit rate HTT stats
      wifi: ath12k: Dump PDEV receive rate HTT stats
      wifi: ath12k: Dump additional PDEV receive rate HTT stats

Lorenzo Bianconi (18):
      wifi: mt76: mt7996: Add change_vif_links stub
      wifi: mt76: mt7996: Introduce mt7996_sta_link container
      wifi: mt76: mt7996: Add mt7996_sta_link struct in mt7996_vif_link
      wifi: mt76: mt7996: Add vif_cfg_changed callback
      wifi: mt76: mt7996: Add link_info_changed callback
      wifi: mt76: mt7996: Add mt7996_sta_state routine
      wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks
      wifi: mt76: mt7996: Support MLO in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Rely on mt7996_vif/sta_link in twt teardown
      wifi: mt76: mt7996: Add mt7996_sta_link to mt7996_mcu_add_bss_info signature
      wifi: mt76: mt7996: rework mt7996_sta_hw_queue_read to support MLO
      wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO
      wifi: mt76: mt7996: rework mt7996_mac_sta_poll to support MLO
      wifi: mt76: mt7996: rework mt7996_update_mu_group to support MLO
      wifi: mt76: mt7996: rework mt7996_net_fill_forward_path to support MLO
      wifi: mt76: mt7996: set vif default link_id adding/removing vif links
      wifi: mt76: mt7996: rework mt7996_ampdu_action to support MLO
      wifi: mt76: mt7996: Update mt7996_tx to MLO support

Manish Dharanenthiran (1):
      wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi

Manivannan Sadhasivam (3):
      wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
      wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
      wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with irq_set_affinity_and_hint()

Miaoqing Pan (4):
      wifi: ath11k: fix memory leak in ath11k_xxx_remove()
      wifi: ath12k: fix memory leak in ath12k_pci_remove()
      wifi: ath11k: use union for vaddr and iaddr in target_mem_chunk
      wifi: ath11k: Add firmware coredump collection support

Michael-CY Lee (1):
      wifi: mt76: mt7996: remove unnecessary key->cipher check for BIP frames

Mikhail Lobanov (1):
      wifi: mac80211: check basic rates validity in sta_link_apply_parameters

Ming Yen Hsieh (16):
      wifi: mt76: mt7925: introduce MLO capability control
      wifi: mt76: mt7925: ensure wow pattern command align fw format
      wifi: mt76: mt7925: fix country count limitation for CLC
      wifi: mt76: mt7921: fix kernel panic due to null pointer dereference
      wifi: mt76: mt7925: fix the wrong link_idx when a p2p_device is present
      wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
      wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
      wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
      wifi: mt76: mt7925: update the power-saving flow
      wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
      wifi: mt76: mt7925: add EHT control support based on the CLC data
      wifi: mt76: mt7925: update the channel usage when the regd domain changed
      wifi: mt76: mt7925: remove unused acpi function for clc
      wifi: mt76: mt792x: extend MTCL of APCI to version3 for EHT control
      wifi: mt76: mt7925: add MTCL support to enhance the regulatory compliance
      wifi: mt76: mt792x: re-register CHANCTX_STA_CSA only for the mt7921 series

Miri Korenblit (22):
      wifi: iwlwifi: add iwlmld sub-driver
      wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
      wifi: iwlwifi: bump minimum API version in BZ/SC to 93
      wifi: iwlwifi: don't warn when if there is a FW error
      wifi: iwlwifi: mld: fix build with CONFIG_PM_SLEEP undefined
      wifi: iwlwifi: mld: fix SMPS W/A
      wifi: iwlwifi: mld: track channel_load_not_by_us
      wifi: iwlwifi: mld: refactor iwl_mld_valid_emlsr_pair
      wifi: iwlwifi: mld: use the right iface iterator in low_latency
      wifi: iwlwifi: mld: always do MLO scan before link selection
      wifi: iwlwifi: mld: fix bad RSSI handling
      wifi: iwlwifi: mld: avoid selecting bad links
      wifi: iwlwifi: mld: remove IWL_MLD_EMLSR_BLOCKED_FW
      wifi: iwlwifi: mld: prevent toggling EMLSR due to FW requests
      wifi: iwlwifi: mld: allow EMLSR for unequal bandwidth
      wifi: iwlwifi: mld: KUnit: introduce iwl_mld_kunit_link
      wifi: iwlwifi: mld: KUnit: create chanctx with a custom width
      wifi: iwlwifi: mld: KUnit: test iwl_mld_channel_load_allows_emlsr
      wifi: iwlwifi: mld: make iwl_mld_run_fw_init_sequence static
      wifi: iwlwifi: mld: fix copy/paste error
      wifi: iwlwifi: mld: iwl_mld_remove_link can't fail
      wifi: iwlwifi: mld: add debugfs to control MLO scan

Nicolas Escande (5):
      wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx() error path
      wifi: ath11k: remove peer extra rssi update
      wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
      wifi: ath12k: add support of station average signal strength
      wifi: ath12k: Add missing htt_metadata flag in ath12k_dp_tx()

Nikita Zhandarovich (1):
      wifi: mt76: mt7915: fix possible integer overflows in mt7915_muru_stats_show()

P Praneesh (19):
      wifi: ath11k: Fix DMA buffer allocation to resolve SWIOTLB issues
      wifi: ath11k: Use dma_alloc_noncoherent for rx_tid buffer allocation
      wifi: ath12k: Add HTT source ring ID for monitor rings
      wifi: ath12k: Enable filter config for monitor destination ring
      wifi: ath12k: Avoid multiple times configuring monitor filter
      wifi: ath12k: Avoid code duplication in monitor ring processing
      wifi: ath12k: Restructure the code for monitor ring processing
      wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
      wifi: ath12k: Fix end offset bit definition in monitor ring descriptor
      wifi: ath12k: Add drop descriptor handling for monitor ring
      wifi: ath12k: Handle end reason for the monitor destination ring
      wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing
      wifi: ath12k: Handle PPDU spread across multiple buffers
      wifi: ath12k: Avoid memory leak while enabling statistics
      wifi: ath12k: Handle monitor drop TLVs scenario
      wifi: ath12k: Enable monitor ring mask for QCN9274
      wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
      wifi: ath11k: fix RCU stall while reaping monitor destination ring
      wifi: ath12k: remove redundant declaration of ath12k_dp_rx_h_find_peer()

Pagadala Yesu Anjaneyulu (7):
      wifi: iwlwifi: mvm: cleanup of TAS structure and enums
      wifi: iwlwifi: Add new TAS disable reason for invalid table source
      wifi: iwlwifi: mvm: Fix bit size calculation in iwl_dbgfs_tas_get_status_read
      wifi: iwlwifi: mld: Rename WIPHY_DEBUGFS_HANDLER_WRAPPER to WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER
      wifi: iwlwifi: mld: Add support for WIPHY_DEBUGFS_READ_FILE_OPS_MLD macro
      wifi: iwlwifi: mld: Ensure wiphy lock is held during debugfs read operations
      wifi: iwlwifi: mld: add support for DHC_TOOLS_UMAC_GET_TAS_STATUS command

Ping-Ke Shih (10):
      wifi: rtw89: mac: define registers of agg_limit and txcnt_limit to share common flow
      wifi: rtw89: add H2C command of TX time for WiFi 7 chips
      wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
      wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
      wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
      wifi: rtw89: fw: add debug message for unexpected secure firmware
      wifi: rtw89: fw: safely cast mfw_hdr pointer from firmware->data
      wifi: rtw89: fw: correct debug message format in rtw89_build_txpwr_trk_tbl_from_elm()
      wifi: rtw89: fw: don't reject firmware in blacklist to prevent breaking users
      wifi: rtw89: pci: correct ISR RDU bit for 8922AE

Po-Hao Huang (2):
      wifi: rtw89: fw: use struct to fill role_maintain H2C command
      wifi: rtw89: fw: update role_maintain H2C command for roles operating on band 1

Quan Zhou (2):
      wifi: mt76: mt7925: fix fails to enter low power mode in suspend state
      wifi: mt76: mt7925: Simplify HIF suspend handling to avoid suspend fail

Ramasamy Kaliappan (1):
      wifi: ath12k: Improve BSS discovery with hidden SSID in 6 GHz band

Rameshkumar Sundaram (1):
      wifi: ath12k: Fix pdev lookup in WBM error processing

Ramya Gnanasekar (3):
      wifi: ath12k: Request vdev stats from firmware
      wifi: ath12k: Request beacon stats from firmware
      wifi: ath12k: Request pdev stats from firmware

Razvan Grigore (3):
      wifi: mt76: add mt76_get_power_bound helper function
      wifi: mt76: mt7915: cleanup mt7915_get_power_bound
      wifi: mt76: mt7996: cleanup mt7996_get_power_bound

Remi Pommarel (1):
      wifi: ath12k: remove return for empty tx bitrate in mac_op_sta_statistics

Rex Lu (1):
      wifi: mt76: mt7996: fix SER reset trigger on WED reset

Roopni Devanathan (2):
      wifi: ath12k: Support Uplink MUMIMO Trigger Stats
      wifi: ath12k: Add NULL check to validate tpc_stats

Rosen Penev (1):
      wifi: ath9k: return by of_get_mac_address

Sathishkumar Muruganandam (1):
      wifi: ath12k: encode max Tx power in scan channel list command

Sean Wang (1):
      Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"

Shayne Chen (16):
      wifi: mt76: mt7996: Add mt7996_mac_sta_change_links callback
      wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()
      wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support
      wifi: mt76: mt7996: Rely on mt7996_vif_link in mt7996_mcu_twt_agrt_update signature
      wifi: mt76: mt7996: Update mt7996_mcu_add_rate_ctrl to MLO
      wifi: mt76: mt7996: Add mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()
      wifi: mt76: mt7996: Add mt7996_mcu_teardown_mld_sta rouine
      wifi: mt76: mt7996: rework mt7996_mac_write_txwi() for MLO support
      wifi: mt76: mt7996: Rely on wcid_to_sta in mt7996_mac_add_txs_skb()
      wifi: mt76: mt7996: rework mt7996_rx_get_wcid to support MLO
      wifi: mt76: mt7996: rework mt7996_sta_set_4addr and mt7996_sta_set_decap_offload to support MLO
      wifi: mt76: mt7996: rework mt7996_set_hw_key to support MLO
      wifi: mt76: mt7996: remove mt7996_mac_enable_rtscts()
      wifi: mt76: mt7996: rework mt7996_mcu_add_obss_spr to support MLO
      wifi: mt76: mt7996: rework mt7996_mcu_beacon_inband_discov to support MLO
      wifi: mt76: mt7996: rework set/get_tsf callabcks to support MLO

Sowmiya Sree Elavalagan (2):
      wifi: ath12k: Add Support to Parse TPC Event from Firmware
      wifi: ath12k: Add Support to Calculate and Display TPC Values

Thorsten Blum (1):
      wifi: mt76: mt7925: Remove unnecessary if-check

Vinith Kumar R (1):
      wifi: ath12k: Report proper tx completion status to mac80211

Wen Gong (2):
      wifi: ath11k: update channel list in reg notifier instead reg worker
      wifi: ath11k: update channel list in worker when wait flag is set

Yu Zhang(Yuriy) (2):
      wifi: ath11k: add support for MU EDCA
      wifi: ath11k: fix wrong overriding for VHT Beamformee STS Capability

Zenm Chen (1):
      wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1

 .../bindings/net/wireless/qcom,ath10k.yaml         |    25 +-
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |     9 +-
 .../bindings/net/wireless/qcom,ath11k.yaml         |     7 +
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |    13 +-
 drivers/net/wireless/ath/ath10k/core.c             |    13 +-
 drivers/net/wireless/ath/ath11k/Makefile           |     1 +
 drivers/net/wireless/ath/ath11k/ahb.c              |     4 +-
 drivers/net/wireless/ath/ath11k/core.c             |    11 +-
 drivers/net/wireless/ath/ath11k/core.h             |    13 +-
 drivers/net/wireless/ath/ath11k/coredump.c         |    52 +
 drivers/net/wireless/ath/ath11k/coredump.h         |    79 +
 drivers/net/wireless/ath/ath11k/dp.c               |    35 +-
 drivers/net/wireless/ath/ath11k/dp.h               |     6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   133 +-
 drivers/net/wireless/ath/ath11k/fw.c               |     3 +-
 drivers/net/wireless/ath/ath11k/hif.h              |     7 +
 drivers/net/wireless/ath/ath11k/mac.c              |   145 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |     5 +
 drivers/net/wireless/ath/ath11k/mhi.h              |     1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   195 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    19 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    10 +-
 drivers/net/wireless/ath/ath11k/reg.c              |   107 +-
 drivers/net/wireless/ath/ath11k/reg.h              |     3 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    80 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |    11 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |    11 +-
 drivers/net/wireless/ath/ath12k/Makefile           |     3 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |   202 +-
 drivers/net/wireless/ath/ath12k/acpi.h             |    40 +-
 drivers/net/wireless/ath/ath12k/core.c             |   103 +-
 drivers/net/wireless/ath/ath12k/core.h             |   139 +-
 drivers/net/wireless/ath/ath12k/debug.c            |     6 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    10 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  1191 +-
 drivers/net/wireless/ath/ath12k/debugfs.h          |   115 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  1238 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |   453 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c      |   337 +
 drivers/net/wireless/ath/ath12k/debugfs_sta.h      |    24 +
 drivers/net/wireless/ath/ath12k/dp.c               |     5 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    82 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  1425 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    11 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |    66 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |     8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   253 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |     4 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |     5 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   442 +-
 drivers/net/wireless/ath/ath12k/hal_tx.h           |    10 +-
 drivers/net/wireless/ath/ath12k/hw.c               |     8 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   870 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    10 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    22 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    23 +-
 drivers/net/wireless/ath/ath12k/reg.h              |     5 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |    12 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |   395 +
 drivers/net/wireless/ath/ath12k/testmode.h         |    40 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  1176 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   290 +-
 drivers/net/wireless/ath/ath12k/wow.c              |     3 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |     3 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |     4 +-
 drivers/net/wireless/ath/ath9k/init.c              |     4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |     9 -
 drivers/net/wireless/ath/{ath11k => }/testmode_i.h |    54 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c      |     3 +
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    15 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |     5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    11 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |     6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |     8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |   132 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    42 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h    |    97 +
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |     4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h  |    75 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |    10 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |     4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |     7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    36 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    12 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |     5 +-
 drivers/net/wireless/intel/iwlwifi/mld/Makefile    |    16 +
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   670 +
 drivers/net/wireless/intel/iwlwifi/mld/agg.h       |   127 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |   344 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.h        |    45 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.c      |    40 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.h      |    15 +
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    88 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  1998 ++
 drivers/net/wireless/intel/iwlwifi/mld/d3.h        |    51 +
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |  1082 +
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h   |   244 +
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |   451 +
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.h |    29 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   536 +
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h      |    56 +
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   671 +
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   233 +
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |   358 +
 drivers/net/wireless/intel/iwlwifi/mld/key.h       |    39 +
 drivers/net/wireless/intel/iwlwifi/mld/led.c       |   100 +
 drivers/net/wireless/intel/iwlwifi/mld/led.h       |    29 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  1213 +
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   153 +
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |   339 +
 .../net/wireless/intel/iwlwifi/mld/low_latency.h   |    68 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  2670 +++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h  |    13 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |   329 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.h       |    17 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   720 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   582 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  1076 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |   167 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   759 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.h     |    35 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |   155 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.h       |    55 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |   396 +
 drivers/net/wireless/intel/iwlwifi/mld/power.h     |    33 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |   321 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.h       |    45 +
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |   393 +
 .../net/wireless/intel/iwlwifi/mld/regulatory.h    |    23 +
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |   224 +
 drivers/net/wireless/intel/iwlwifi/mld/roc.h       |    20 +
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  2060 ++
 drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    72 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |  2008 ++
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |   136 +
 .../wireless/intel/iwlwifi/mld/session-protect.c   |   222 +
 .../wireless/intel/iwlwifi/mld/session-protect.h   |   102 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |  1289 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |   266 +
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   513 +
 drivers/net/wireless/intel/iwlwifi/mld/stats.h     |    22 +
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |     5 +
 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c |   663 +
 .../net/wireless/intel/iwlwifi/mld/tests/hcmd.c    |    62 +
 .../intel/iwlwifi/mld/tests/link-selection.c       |   303 +
 .../net/wireless/intel/iwlwifi/mld/tests/link.c    |   110 +
 .../net/wireless/intel/iwlwifi/mld/tests/module.c  |    11 +
 drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c  |   353 +
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |   474 +
 .../net/wireless/intel/iwlwifi/mld/tests/utils.h   |   134 +
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c   |   438 +
 drivers/net/wireless/intel/iwlwifi/mld/thermal.h   |    36 +
 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c |   240 +
 drivers/net/wireless/intel/iwlwifi/mld/time_sync.h |    26 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |   700 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.h       |    23 +
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |  1374 ++
 drivers/net/wireless/intel/iwlwifi/mld/tx.h        |    77 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |    38 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |     4 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    15 +
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |     3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |     3 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    30 +-
 drivers/net/wireless/marvell/mwifiex/11n.c         |     6 +-
 drivers/net/wireless/marvell/mwifiex/cfp.c         |     2 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    14 +
 drivers/net/wireless/marvell/mwifiex/main.c        |     4 -
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |    18 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |     3 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |     4 +
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    16 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |     8 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |     3 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |     6 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |     3 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |     3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |     3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |     4 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |    53 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |     4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    12 -
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |     1 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    96 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   164 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   274 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |     6 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |    36 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    19 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |   123 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |    18 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |     3 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    56 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   306 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   984 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   638 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |    47 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |     5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    79 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |    21 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |     3 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |    25 +
 drivers/net/wireless/realtek/rtw88/Makefile        |     9 +
 drivers/net/wireless/realtek/rtw88/debug.c         |    59 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |     1 +
 drivers/net/wireless/realtek/rtw88/main.c          |    40 +-
 drivers/net/wireless/realtek/rtw88/main.h          |     9 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |    24 +
 drivers/net/wireless/realtek/rtw88/reg.h           |    66 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |  2257 ++
 drivers/net/wireless/realtek/rtw88/rtw8814a.h      |    62 +
 .../net/wireless/realtek/rtw88/rtw8814a_table.c    | 23930 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8814a_table.h    |    40 +
 drivers/net/wireless/realtek/rtw88/rtw8814ae.c     |    31 +
 drivers/net/wireless/realtek/rtw88/rtw8814au.c     |    54 +
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |     4 +
 drivers/net/wireless/realtek/rtw88/rx.c            |     6 +
 drivers/net/wireless/realtek/rtw88/util.c          |     3 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |     6 +
 drivers/net/wireless/realtek/rtw89/chan.c          |    10 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |    16 +-
 drivers/net/wireless/realtek/rtw89/core.c          |    48 +-
 drivers/net/wireless/realtek/rtw89/core.h          |    39 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |     1 +
 drivers/net/wireless/realtek/rtw89/fw.c            |   180 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |    57 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |    49 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |     4 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |     1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |     6 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    56 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |     2 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |    41 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |     7 +
 drivers/net/wireless/realtek/rtw89/reg.h           |    39 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |    27 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |     5 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |     5 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |     5 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |     6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |     5 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |    13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |     7 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    59 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   383 +-
 drivers/net/wireless/realtek/rtw89/sar.h           |     5 +-
 drivers/net/wireless/realtek/rtw89/util.c          |   223 +-
 drivers/net/wireless/realtek/rtw89/util.h          |     8 +-
 drivers/net/wireless/silabs/wfx/bus.h              |     1 +
 drivers/net/wireless/silabs/wfx/bus_sdio.c         |    54 +
 drivers/net/wireless/silabs/wfx/bus_spi.c          |    47 +-
 drivers/net/wireless/silabs/wfx/main.c             |    14 +
 drivers/net/wireless/silabs/wfx/sta.c              |    25 +
 drivers/net/wireless/silabs/wfx/sta.h              |     3 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    14 +-
 drivers/net/wireless/virtual/virt_wifi.c           |     2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |     2 +-
 include/net/cfg80211.h                             |    40 +-
 include/uapi/linux/nl80211.h                       |    68 +-
 net/mac80211/cfg.c                                 |    23 +-
 net/mac80211/ieee80211_i.h                         |    13 +-
 net/mac80211/mlme.c                                |   138 +-
 net/mac80211/wbrf.c                                |     3 +-
 net/wireless/chan.c                                |    13 +-
 net/wireless/core.c                                |     9 +-
 net/wireless/core.h                                |     6 +-
 net/wireless/mlme.c                                |    17 +-
 net/wireless/nl80211.c                             |    43 +-
 net/wireless/rdev-ops.h                            |    10 +-
 net/wireless/reg.c                                 |     4 +-
 net/wireless/trace.h                               |    17 +-
 net/wireless/util.c                                |     4 +-
 274 files changed, 68265 insertions(+), 2716 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/agg.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/agg.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/constants.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/d3.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/d3.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/fw.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/notif.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/notif.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/rx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/rx.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/scan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/scan.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/module.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tlc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tlc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tx.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814ae.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814au.c

