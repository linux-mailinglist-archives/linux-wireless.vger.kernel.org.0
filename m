Return-Path: <linux-wireless+bounces-23315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81315AC11C0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2062174AC0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B068429ACC9;
	Thu, 22 May 2025 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nS0q956h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4CD29ACCF;
	Thu, 22 May 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932916; cv=none; b=O5T8UJSUK2Fumft7V/TYCtRirIk9jLjzXTgaXmS+9Z1ux2LTbi63lvWDsR6UKbnpdiKlPAY17cBwpcg6a0ZoWxBisLXUaZrZQxCVpvfQUZG/arbBwCrhYMD9NI2zJPmDawF41bm9vJIH0rm08RbsNH90TVSbibiYOuORk8weNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932916; c=relaxed/simple;
	bh=IG2HK47GQUx4FC6LxM3UJgRU9+ZSdBhy7EuiOYTDS/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RHWScWmQqwI2pOMA1uI3cfp7hbMWNyirybQQ3Vs1Wg5U25iPc7FBiI+7/XJayVdyDEN9IWahU6Bkat3vT5yxA7hcBDW/W4SJhpgMXPIq+onEsGfYJy2xcQfX/zIQukAoS16akbJD+YrlW6JJ3+IRm9ZgQYULAtH0xNfhiwapb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nS0q956h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=S72orAt1UIeVgdJPtlqQ5AOxCIWlRuYBWOh+12p4k60=; t=1747932913; x=1749142513; 
	b=nS0q956h10e7IpZpZkZDII6gDs9uIRzxfV06LLBGD33K8+NlouXY/QjG+8oRPD4PwyNOrZE469t
	fMKKDepAWDvevjSf8mhy6PeOCorrZ8N7hVYp+Ud3uq0xZEDhZve8p9znO0MT0tVIjSU3L1Y5rb7sz
	Ycpakk0HdL1EU9nu8MKXw4JUeIdTJVrX6LxSI104wXeEzJWpMOV6I7ma+ZdPfPgtSAKNA1+scoQWl
	8Yb1tw0W5R3jFl6DKqqoS9uuhVRuBLZ7WRfTcs+2pWLVtIsb4W7JN7moqEt41+v6yPg+VNh5tADQx
	AvoafFPqwvm+JESIFI3bmd+eMQ4e98vvCopg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uI9CF-0000000H3ZJ-3ZLX;
	Thu, 22 May 2025 18:55:08 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-05-22
Date: Thu, 22 May 2025 18:54:35 +0200
Message-ID: <20250522165501.189958-50-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
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

Final, but also big, pull request for 6.16 (we hope :-) ).
Somehow I got thinking we'd still have into next week ...

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 6b02fd7799fc8e1160c5783459d065ceeb4b7365:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-08 08:59:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-05-22

for you to fetch changes up to ed73728fd14e14714a86b4826fb7115d9dade1b6:

  Merge tag 'mt76-next-2025-05-21' of https://github.com/nbd168/wireless (2025-05-22 13:13:22 +0200)

----------------------------------------------------------------
Lots of new things, notably:
 * ath12k: monitor mode for WCN7850, better 6 GHz regulatory
 * brcmfmac: SAE for some Cypress devices
 * iwlwifi: rework device configuration
 * mac80211: scan improvements with MLO
 * mt76: EHT improvements, new device IDs
 * rtw88: throughput improvements
 * rtw89: MLO, STA/P2P concurrency improvements, SAR

----------------------------------------------------------------
Aditya Kumar Singh (6):
      wifi: mac80211: handle non-MLO mode as well in ieee80211_num_beaconing_links()
      wifi: ath12k: handle scan link during vdev create
      wifi: ath12k: Use scan link ID 15 for all scan operations
      wifi: ath12k: fix mac pdev frequency range update
      wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO
      wifi: mac80211: accept probe response on link address as well

Aishwarya R (1):
      wifi: ath12k: remove redundant regulatory rules intersection logic in host

Alexey Kodanev (1):
      wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds

Allan Wang (2):
      wifi: mt76: mt7925: add EHT preamble puncturing
      wifi: mt76: mt7925: add rfkill_poll for hardware rfkill

Aloka Dixit (1):
      wifi: ath12k: pass link_conf for tx_arvif retrieval

Arend van Spriel (3):
      wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware events
      wifi: brcmfmac: make per-vendor event map const
      wifi: brcmfmac: cyw: support external SAE authentication in station mode

Avraham Stern (4):
      wifi: iwlwifi: mld: start AP with the correct bandwidth
      wifi: iwlwifi: mld: force the responder to use the full bandwidth
      wifi: iwlwifi: mld: add debugfs for using ptp clock time for monitor interface
      wifi: iwlwifi: add range response version 10 support

Baochen Qiang (18):
      wifi: ath12k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: refactor ath12k_reg_chan_list_event()
      wifi: ath12k: refactor ath12k_reg_build_regd()
      wifi: ath12k: add support to select 6 GHz regulatory type
      wifi: ath12k: move reg info handling outside
      wifi: ath12k: store reg info for later use
      wifi: ath12k: determine interface mode in _op_add_interface()
      wifi: ath12k: update regulatory rules when interface added
      wifi: ath12k: update regulatory rules when connection established
      wifi: ath12k: save power spectral density(PSD) of regulatory rule
      wifi: ath12k: add parse of transmit power envelope element
      wifi: ath12k: save max transmit power in vdev start response event from firmware
      wifi: ath12k: fill parameters for vdev set TPC power WMI command
      wifi: ath12k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      wifi: ath12k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
      wifi: ath12k: fix regdomain update failure after 11D scan completes
      wifi: ath12k: fix regdomain update failure when adding interface
      wifi: ath12k: fix regdomain update failure when connection establishes

Benjamin Berg (5):
      wifi: mac80211: do not offer a mesh path if forwarding is disabled
      wifi: iwlwifi: fix thermal code compilation with -Werror=cast-qual
      wifi: iwlwifi: mvm: use a radio/system specific power budget
      wifi: iwlwifi: mld: use a radio/system specific power budget
      wifi: iwlwifi: mld: call thermal exit without wiphy lock held

Benjamin Lin (1):
      wifi: mt76: mt7996: drop fragments with multicast or broadcast RA

Bert Karwatzki (1):
      wifi: check if socket flags are valid

Bitterblue Smith (10):
      wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
      wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
      wifi: rtw88: Set AMPDU factor to hardware for RTL8814A
      wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
      wifi: rtw88: Fix the module names printed in dmesg
      wifi: rtw88: Fix RX aggregation settings for RTL8723DS
      wifi: rtw88: Handle RTL8723D(S) with blank efuse
      wifi: rtw88: usb: Reduce control message timeout to 500 ms
      wifi: rtw88: usb: Upload the firmware in bigger chunks
      wifi: rtw88: Fix the random "error beacon valid" messages for USB

Charles Han (1):
      wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init

Chen Ni (2):
      wifi: rtw88: sdio: Remove redundant 'flush_workqueue()' calls
      wifi: rtw88: usb: Remove redundant 'flush_workqueue()' calls

Chin-Yen Lee (1):
      wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips

Christian Lamparter (1):
      wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Christophe JAILLET (2):
      wifi: ath10k: Constify structures in hw.c
      wifi: mt76: Remove an unneeded local variable in mt76x02_dma_init()

Colin Ian King (1):
      wifi: ath10k: Fix spelling mistake "comple" -> "complete"

Dan Carpenter (2):
      wifi: mt76: mt7925: Fix logical vs bitwise typo
      wifi: mt76: mt7996: remove duplicate check in mt7996_mcu_sta_mld_setup_tlv()

Daniel Gabay (1):
      wifi: iwlwifi: mld: add monitor internal station

Dian-Syuan Yang (1):
      wifi: rtw89: leave idle mode when setting WEP encryption for AP mode

Dinesh Karthikeyan (1):
      wifi: ath12k: Add support to simulate firmware crash

Dmitry Antipov (1):
      wifi: rtw88: do not ignore hardware read error during DPK

Dr. David Alan Gilbert (3):
      wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
      wifi: rtlwifi: Remove uncalled stub rtl*_phy_ap_calibrate
      wifi: rtlwifi: Remove unused rtl_bb_delay()

Emmanuel Grumbach (4):
      wifi: iwlwifi: add support for ALIVE v8
      wifi: iwlwifi: mld: support for COMPRESSED_BA_RES_API_S_VER_7
      wifi: iwlwifi: add support PE RF
      wifi: iwlwifi: drop whtc RF

Feng Jiang (1):
      wifi: mt76: scan: Fix 'mlink' dereferenced before IS_ERR_OR_NULL check

Henk Vergonet (1):
      wifi: mt76: mt76x2: Add support for LiteOn WN4516R,WN4519R

Henry Martin (2):
      wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
      wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()

Howard Hsu (2):
      wifi: mt76: remove capability of partial bandwidth UL MU-MIMO
      wifi: mt76: mt7996: fix beamformee SS field

Ilan Peer (1):
      wifi: iwlfiwi: mvm: Fix the rate reporting

Jeff Johnson (1):
      wifi: iwlwifi: Add short description to enum iwl_power_scheme

Johan Hovold (3):
      wifi: ath11k: fix ring-buffer corruption
      wifi: ath11k: fix rx completion meta data corruption
      wifi: ath12k: fix ring-buffer corruption

Johannes Berg (121):
      wifi: iwlwifi: mld: refactor tests to use chandefs
      wifi: iwlwifi: mld: tests: extend link pair tests
      wifi: iwlwifi: avoid scheduling restart during restart
      wifi: iwlwifi: implement TOP reset follower
      wifi: iwlwifi: mld: handle SW reset w/o NIC error
      wifi: iwlwifi: implement TOP reset
      wifi: iwlwifi: dvm: fix various W=1 warnings
      wifi: iwlwifi: mld: set rx_mpdu_cmd_hdr_size
      wifi: iwlwifi: mvm: remove nl80211 testmode
      wifi: iwlwifi: clean up config macro
      wifi: iwlwifi: remove TH/TH1 RF types
      wifi: iwlwifi: unify some configurations
      wifi: iwlwifi: pcie: add entry for Killer AX1650i on AdL-P
      wifi: iwlwifi: tests: check for device names
      wifi: iwlwifi: cfg: remove fw_name_mac
      wifi: iwlwifi: cfg: unify Qu/QuZ configs
      wifi: iwlwifi: cfg: unify Killer 1650s/i with Qu/Hr
      wifi: iwlwifi: cfg: remove unused config externs
      wifi: iwlwifi: cfg: remove max_tx_agg_size
      wifi: iwlwifi: cfg: remove iwl_ax201_cfg_qu_hr
      wifi: iwlwifi: cfg: remove duplicated iwl_cfg_gl
      wifi: iwlwifi: cfg: remove duplicated Sc device configs
      wifi: iwlwifi: cfg: remove iwl_cfg_br
      wifi: iwlwifi: tests: check configs are not duplicated
      wifi: iwlwifi: tests: check transport configs are not duplicated
      wifi: iwlwifi: cfg: clean up BW limit and subdev matching
      wifi: iwlwifi: cfg: rename BW_NO_LIMIT to BW_NOT_LIMITED
      wifi: iwlwifi: pcie: remove 'ent' argument from alloc
      wifi: iwlwifi: cfg: minor fixes for Sc
      wifi: iwlwifi: cfg: finish config split
      wifi: iwlwifi: cfg: move all names out of configs
      wifi: iwlwifi: tests: check for duplicate name strings
      wifi: iwlwifi: cfg: reduce mac_type to u8
      wifi: iwlwifi: cfg: remove unnecessary configs
      wifi: iwlwifi: pcie: don't call itself indirectly
      wifi: iwlwifi: mvm: add command order checks to kunit
      wifi: iwlwifi: remove iwl_cmd_groups_verify_sorted()
      wifi: iwlwifi: pcie: rename "continuous" memory
      wifi: iwlwifi: pcie: move ME check data to pcie
      wifi: iwlwifi: pcie: move invalid TX CMD into PCIe
      wifi: iwlwifi: pcie: move wait_command_queue into PCIe
      wifi: iwlwifi: unexport iwl_trans_pcie_send_hcmd()
      wifi: iwlwifi: remove PM mode and send-in-D3
      wifi: iwlwifi: pass full FW info to transport
      wifi: iwlwifi: trans: remove hw_id_str
      wifi: iwlwifi: trans: remove hw_wfpm_id
      wifi: iwlwifi: pcie: remove constant wdg_timeout
      wifi: iwlwifi: remove bc_table_dword transport config
      wifi: iwlwifi: trans: remove SCD base address validation
      wifi: iwlwifi: trans: collect device information
      wifi: iwlwifi: rework transport configuration
      wifi: iwlwifi: move STEP config into trans->conf
      wifi: iwlwifi: trans: move ext_32khz_clock_valid to config
      wifi: iwlwifi: remove sku_id from trans
      wifi: iwlwifi: fw: remove RATE_MCS_NSS_POS
      wifi: iwlwifi: rename modulation type values
      wifi: iwlwifi: mld: build HT/VHT injected rate in v2
      wifi: iwlwifi: mld: don't report bad EHT rate to mac80211
      wifi: iwlwifi: mvm: don't report bad EHT rate to mac80211
      wifi: iwlwifi: mvm: remove HT greenfield support
      wifi: iwlwifi: tests: allow same config for different MACs
      wifi: iwlwifi: cfg: use minimum API version 97 for Sc/Dr
      wifi: iwlwifi: tests: simplify devinfo_no_trans_cfg_dups()
      wifi: iwlwifi: dvm: pair transport op-mode enter/leave
      wifi: iwlwifi: pcie: log async commands
      wifi: iwlwifi: dvm: init 'keep_alive_beacons' in power tables
      wifi: iwlwifi: remove NVM C step override
      wifi: iwlwifi: mvm: fix beacon CCK flag
      wifi: iwlwifi: make iwl_uefi_get_uats_table() return void
      wifi: iwlwifi: fix 6005N/SFF match
      wifi: iwlwifi: handle v3 rates
      wifi: iwlwifi: cfg: remove 6 GHz from ht40_bands
      wifi: iwlwifi: cfg: inline HT params
      wifi: iwlwifi: pcie: remove 0x2726 devices
      wifi: iwlwifi: add JF1/JF2 RF for dynamic FW building
      wifi: iwlwifi: build 9000 series FW filenames dynamically
      wifi: iwlwifi: cfg: remove QuZ/JF special cases
      wifi: iwlwifi: cfg: remove 'cdb' value
      wifi: iwlwifi: cfg: build ax210 family FW names dynamically
      wifi: iwlwifi: cfg: handle cc firmware dynamically
      wifi: iwlwifi: cfg: remove nvm_hw_section_num from new devices
      wifi: iwlwifi: pass trans to iwl_parse_nvm_mcc_info()
      wifi: iwlwifi: rename cfg_trans_params to mac_cfg
      wifi: iwlwifi: cfg: remove dbgc_supported field
      wifi: iwlwifi: cfg: remove rf_id field
      wifi: iwlwifi: rename struct iwl_base_params
      wifi: iwlwifi: cfg: remove eeprom_size from new devices
      wifi: iwlwifi: cfg: remove DCCM offsets from new devices
      wifi: iwlwifi: cfg: move MAC parameters to MAC data
      wifi: iwlwifi: remove unused high_temp from iwl_cfg
      wifi: iwlwifi: cfg: add ucode API min/max to MAC config
      wifi: iwlwifi: cfg: unify num_rbds config
      wifi: iwlwifi: cfg: unify JF configs
      wifi: iwlwifi: cfg: unify HR configs
      wifi: iwlwifi: cfg: add GF RF config
      wifi: iwlwifi: cfg: add FM RF config
      wifi: iwlwifi: cfg: clean up Sc/Dr/Br configs
      wifi: iwlwifi: rename iwl_cfg to iwl_rf_cfg
      wifi: iwlwifi: mvm/mld: allow puncturing use in 5 GHz
      wifi: iwlwifi: dbg: fix dump trigger split check
      wifi: iwlwifi: cfg: remove some unused names
      wifi: iwlwifi: cfg: fix some device names
      wifi: iwlwifi: cfg: fix Ma device configs
      wifi: iwlwifi: cfg: fix and unify Killer/JF configs
      wifi: iwlwifi: cfg: unify and add some Killer devices
      wifi: iwlwifi: cfg: clean up HR device matching
      wifi: iwlwifi: tests: make subdev match test more precise
      wifi: iwlwifi: cfg: clean up JF device matching
      wifi: iwlwifi: cfg: clean up GF device matching
      wifi: iwlwifi: cfg: fix and clean up FM/WH device matching
      wifi: iwlwifi: cfg: fix PE RF names
      wifi: iwlwifi: cfg: add a couple of older devices
      wifi: iwlwifi: cfg: remove MAC type/step matching
      wifi: iwlwifi: cfg: mark Ty devices as discrete
      wifi: iwlwifi: cfg: clean up dr/br configs
      wifi: iwlwifi: cfg: reduce configuration struct size
      wifi: iwlwifi: fw: api: include required headers in rs/location
      Merge tag 'iwlwifi-next-2025-05-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'rtw-next-2025-05-16' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20250521' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'mt76-next-2025-05-21' of https://github.com/nbd168/wireless

Kang Yang (14):
      wifi: ath12k: delete mon reap timer
      wifi: ath12k: parse msdu_end tlv in ath12k_dp_mon_rx_parse_status_tlv()
      wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
      wifi: ath12k: add srng config template for mon status ring
      wifi: ath12k: add ring config for monitor mode on WCN7850
      wifi: ath12k: add interrupt configuration for mon status ring
      wifi: ath12k: add monitor mode handler by monitor status ring interrupt
      wifi: ath12k: add support to reap and process monitor status ring
      wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
      wifi: ath12k: use ath12k_buffer_addr in ath12k_dp_rx_link_desc_return()
      wifi: ath12k: add support to reap and process mon dest ring
      wifi: ath12k: init monitor parameters for WCN7850
      wifi: ath12k: use different packet offset for WCN7850
      wifi: ath12k: enable monitor mode for WCN7850

Kees Cook (1):
      wifi: rtw89: fw: Remove "const" on allocation type

Kuan-Chung Chen (6):
      wifi: rtw89: 8922a: fix TX fail with wrong VCO setting
      wifi: rtw89: set pre-calculated antenna matrices for HE trigger frame
      wifi: rtw89: 8922a: increase beacon loss to 6 seconds
      wifi: rtw89: acpi: introduce country specific TAS enabling
      wifi: rtw89: phy: add C2H event handler for report of FW scan
      wifi: rtw89: constrain TX power according to dynamic antenna power table

Leon Yen (1):
      wifi: mt76: mt7925: introduce thermal protection

Lingbo Kong (1):
      wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion

Lorenzo Bianconi (1):
      Revert "wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()"

Miaoqing Pan (2):
      dt-bindings: net: wireless: ath12k: describe firmware-name property
      wifi: ath12k: support usercase-specific firmware overrides

Michael Lo (4):
      wifi: mt76: mt7925: fix host interrupt register initialization
      wifi: mt76: mt7925: ensure all MCU commands wait for response
      wifi: mt76: mt7925: extend MCU support for testmode
      wifi: mt76: mt7925: add test mode support

Ming Yen Hsieh (4):
      wifi: mt76: add mt76_connac_mcu_build_rnr_scan_param routine
      wifi: mt76: mt7925: add RNR scan support for 6GHz
      wifi: mt76: mt7925: prevent multiple scan commands
      wifi: mt76: mt7925: refine the sniffer commnad

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Miri Korenblit (26):
      wifi: iwlwifi: prepare for reading WPFC from UEFI
      wifi: iwlwifi: read WPFC also from UEFI
      wifi: iwlwifi: mld: send the WPFC table to the FW
      wifi: iwlwifi: mld: check for NULL before referencing a pointer
      wifi: iwlwifi: mld: don't return an error if the FW is dead
      wifi: iwlwifi: mld: support iwl_mac_power_cmd version 2
      wifi: iwlwifi: mvm: support ROC command version 6
      wifi: iwlwifi: mvm: support iwl_mac_power_cmd version 2
      wifi: iwlwifi: remove duplicated line
      wifi: iwlwifi: bump FW API to 99 for BZ/SC/DR devices
      wifi: iwlwifi: print the DSM value when read from UEFI
      wifi: iwlwifi: mld: don't check the TPT counters when scanning
      wifi: iwlwifi: debug: set CDB indication from CSR
      wifi: iwlwifi: mld: remove one more error in unallocated BAID
      wifi: iwlwifi: pcie: remove iwl_trans_pcie_gen2_send_hcmd
      wifi: iwlwifi: mld: avoid init-after-queue
      wifi: iwlwifi: stop supporting TX_CMD_API_S_VER_8
      wifi: iwlwifi: use normal versioning convention for iwl_tx_cmd
      wifi: iwlwifi: remove GEN3 from a couple of macros
      wifi: iwlwifi: use bc entries instead of bc table also for pre-ax210
      wifi: iwlwifi: unify iwlagn_scd_bc_tbl_entry and iwl_gen3_bc_tbl_entry
      wifi: iwlwifi: remove unused macro
      wifi: iwlwifi: map iwl_context_info to the matching struct
      wifi: iwlwifi: fix a wrong comment
      wifi: iwlwifi: rename ctx-info-gen3 to ctx-info-v2
      wifi: iwlwifi: mld: allow 2 ROCs on the same vif

Mohan Kumar G (2):
      wifi: mac80211: Update MCS15 support in link_conf
      wifi: ath12k: Send MCS15 support to firmware during peer assoc

Muhammad Usama Anjum (1):
      wifi: ath11k: Fix QMI memory reuse logic

Muna Sinada (1):
      wifi: ath12k: Prevent multicast duplication for dynamic VLAN

Ondrej Jirman (2):
      wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
      wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data

P Praneesh (2):
      wifi: ath12k: Fix invalid RSSI values in station dump
      wifi: ath12k: fix memory leak in WMI firmware stats

Pagadala Yesu Anjaneyulu (10):
      wifi: iwlwifi: rename ppag_ver to ppag_bios_rev
      wifi: iwlwifi: fw: support reading PPAG BIOS table revision 4
      wifi: iwlwifi: fw: support PPAG command version 7
      wifi: iwlwifi: mld: add RFI_CONFIG_CMD to iwl_mld_system_names array
      wifi: iwlwifi: mld: Correct comments for cleanup functions
      wifi: iwlwifi: mld: Fix ROC activity cleanup in iwl_mld_vif
      wifi: iwlwifi: mld: move aux_sta member from iwl_mld_link to iwl_mld_vif
      wifi: iwlwifi: mld: Block EMLSR only when ready to enter ROC
      wifi: iwlwifi: mld: add support for ROC on BSS
      wifi: iwlwifi: Add helper function to extract device ID

Peter Chiu (7):
      wifi: mt76: mt7996: rework WA mcu command for mt7990
      wifi: mt76: mt7996: rework DMA configuration for mt7990
      wifi: mt76: mt7996: adjust HW capabilities for mt7990
      wifi: mt76: mt7996: add PCI device id for mt7990
      wifi: mt76: mt7996: set EHT max ampdu length capability
      wifi: mt76: mt7996: fix invalid NSS setting when TX path differs from NSS
      wifi: mt76: mt7996: change max beacon size

Ping-Ke Shih (7):
      wifi: rtw89: set 2TX for 1SS rate by default
      wifi: rtw89: fw: cast mfw_hdr pointer from address of zeroth byte of firmware->data
      wifi: rtw89: phy: reset value of force TX power for MAC ID
      wifi: rtw89: 8852c: update supported firmware format to 2
      wifi: rtw89: 8922a: rfk: adjust timeout time of RX DCK
      wifi: rtw89: pci: configure manual DAC mode via PCI config API only
      wifi: rtw89: pci: enlarge retry times of RX tag to 1000

Po-Hao Huang (12):
      wifi: rtw89: 8922a: use SW CRYPTO when broadcast in MLO mode
      wifi: rtw89: Adjust management queue mapping for [MLO, HW-1]
      wifi: rtw89: Configure scan band when mlo_dbcc_mode changes
      wifi: rtw89: extend join_info H2C command for MLO fields
      wifi: rtw89: add MLD capabilities declaration
      wifi: rtw89: Fill in correct Rx link ID for MLO
      wifi: rtw89: allow driver to do specific band TX for MLO
      wifi: rtw89: send nullfunc based on the given link
      wifi: rtw89: add MLO track for MLSR switch decision
      wifi: rtw89: debug: extend dbgfs for MLO
      wifi: rtw89: debug: add MLD table dump
      wifi: rtw89: debug: add FW log component for MLO

Qasim Ijaz (3):
      wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
      wifi: mt76: mt7996: avoid NULL pointer dereference in mt7996_set_monitor()
      wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()

Rajat Soni (1):
      wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event

Ramasamy Kaliappan (1):
      wifi: ath12k: update EMLSR capabilities of ML Station

Rosen Penev (1):
      wifi: ath9k: ahb: do ioremap resource in one step

Salah Triki (1):
      wireless: purelifi: plfxlc: fix memory leak in plfxlc_usb_wreq_asyn()

Samuel Williams (1):
      wifi: mt76: mt7921: add 160 MHz AP for mt7922 device

Shayne Chen (6):
      wifi: mt76: mt7996: add macros for pci device ids
      wifi: mt76: connac: rework TX descriptor and TX free for mt7990
      Revert "wifi: mt76: mt7996: fill txd by host driver"
      wifi: mt76: mt7996: fix RX buffer size of MCU event
      wifi: mt76: fix available_antennas setting
      wifi: mt76: support power delta calculation for 5 TX paths

Somashekhar Puttagangaiah (5):
      wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON
      wifi: iwlwifi: mld: add kunit test for emlsr with bt on
      wifi: iwlwifi: pcie: Add support for new device ids
      wifi: iwlwifi: handle reasons recommended by FW for leaving EMLSR
      wifi: iwlwifi: mld: add debug log instead of warning

StanleyYP Wang (7):
      wifi: mt76: connac: add support to load firmware for mt7990
      wifi: mt76: mt7996: rework register mapping for mt7990
      wifi: mt76: mt7996: add eeprom support for mt7990
      wifi: mt76: mt7996: rework background radar check for mt7990
      wifi: mt76: mt7915: set correct background radar capability
      wifi: mt76: mt7915: rework radar HWRDD idx
      wifi: mt76: mt7996: rework radar HWRDD idx

Thiraviyam Mariyappan (1):
      wifi: ath12k: Enable AST index based address search in Station Mode

Ting-Ying Li (1):
      wifi: brcmfmac: Fix structure size for WPA3 external SAE

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Abort software beacon handling if disabled

Vignesh C (1):
      wifi: ath12k: Fix scan initiation failure handling

Vinith Kumar R (3):
      wifi: ath12k: change soc name to device name
      wifi: ath12k: Add device dp stats support
      wifi: ath12k: print device dp stats in debugfs

Wen Gong (1):
      wifi: ath12k: read country code from SMBIOS for WCN7850

Yedidya Benshimol (3):
      wifi: iwlwifi: Add a new version for sta config command
      wifi: iwlwifi: Add a new version for mac config command
      wifi: iwlwifi: Add support for a new version for link config command

Yingying Tang (2):
      wifi: ath12k: Reorder and relocate the release of resources in ath12k_core_deinit()
      wifi: ath12k: Adjust the process of resource release for ahb bus

Yu Zhang(Yuriy) (1):
      wifi: ath11k: support DBS and DFS compatibility

Yury Norov (1):
      wifi: carl9170: micro-optimize carl9170_tx_shift_bm()

Yuuki NAGAO (1):
      wifi: rtw88: rtw8822bu VID/PID for BUFFALO WI-U2-866DM

Zhen XIN (2):
      wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
      wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally

Zong-Zhe Yang (37):
      wifi: rtw89: fix typo of "access" in rtw89_sar_info description
      wifi: rtw89: regd: introduce string getter for reuse
      wifi: rtw89: sar: introduce structure to wrap query parameters
      wifi: rtw89: sar: add skeleton for SAR configuration via ACPI
      wifi: rtw89: acpi: introduce method evaluation function for reuse
      wifi: rtw89: acpi: support loading static SAR table
      wifi: rtw89: acpi: support loading dynamic SAR tables and indicator
      wifi: rtw89: acpi: support loading GEO SAR tables
      wifi: rtw89: sar: add skeleton for different configs by antenna
      wifi: rtw89: 8922a: support different SAR configs by antenna
      wifi: rtw89: 8852c: support different SAR configs by antenna
      wifi: rtw89: 8852bx: support different SAR configs by antenna
      wifi: rtw89: regd: indicate if regd_UK TX power settings follow regd_ETSI
      wifi: rtw89: add suffix "_ax" to Wi-Fi 6 HW scan struct and func
      wifi: rtw89: refactor flow that hw scan handles channel list
      wifi: rtw89: mcc: make GO announce one-time NoA for HW scan process
      wifi: rtw89: don't re-randomize TSF of AP/GO
      wifi: rtw89: mcc: make GO+STA mode calculate dynamic beacon offset
      wifi: rtw89: mcc: handle the case where NoA start time has passed
      wifi: rtw89: mcc: update entire plan when courtesy config changes
      wifi: rtw89: mcc: support courtesy mechanism on both roles at the same time
      wifi: rtw89: mcc: refine filling function of start TSF
      wifi: rtw89: mcc: avoid that loose pattern sets negative timing for auxiliary GO
      wifi: rtw89: extend mapping from Qsel to DMA ch for MLO
      wifi: rtw89: roc: dynamically handle link id and link instance index
      wifi: rtw89: introduce helper to get designated link for MLO
      wifi: rtw89: extract link part from core tx write function
      wifi: rtw89: chan: re-calculate MLO DBCC mode during setting channel
      wifi: rtw89: add handling of mlo_link_cfg H2C command and C2H event
      wifi: rtw89: debug: add mlo_mode dbgfs
      wifi: rtw89: declare MLO support if prerequisites are met
      wifi: rtw89: mcc: pass whom to stop at when pausing chanctx
      wifi: rtw89: mcc: drop queued chanctx changes when stopping
      wifi: rtw89: mcc: add courtesy mechanism conditions to P2P roles
      wifi: rtw89: mcc: introduce calculation of anchor pattern
      wifi: rtw89: mcc: deal with non-periodic NoA
      wifi: rtw89: mcc: avoid redundant recalculations if no chance to improve

sunliming (1):
      wifi: mt76: mt7996: fix uninitialized symbol warning

 .../bindings/net/wireless/qcom,ath12k.yaml         |    6 +
 drivers/net/wireless/ath/ath10k/ce.c               |   28 +-
 drivers/net/wireless/ath/ath10k/hw.c               |   62 +-
 drivers/net/wireless/ath/ath10k/hw.h               |   34 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |   11 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   25 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   42 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    9 +
 drivers/net/wireless/ath/ath12k/ahb.c              |    5 +-
 drivers/net/wireless/ath/ath12k/ce.c               |   11 +-
 drivers/net/wireless/ath/ath12k/core.c             |   37 +-
 drivers/net/wireless/ath/ath12k/core.h             |   72 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  263 +++
 drivers/net/wireless/ath/ath12k/debugfs.h          |    5 +
 drivers/net/wireless/ath/ath12k/dp.c               |   66 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   28 +
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  818 ++++++-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    3 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  172 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   10 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   66 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   42 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    4 +
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    7 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |  102 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   12 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   12 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    1 +
 drivers/net/wireless/ath/ath12k/mac.c              |  674 +++++-
 drivers/net/wireless/ath/ath12k/mac.h              |   43 +
 drivers/net/wireless/ath/ath12k/pci.c              |    8 +-
 drivers/net/wireless/ath/ath12k/reg.c              |  411 ++--
 drivers/net/wireless/ath/ath12k/reg.h              |   18 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  235 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   64 +
 drivers/net/wireless/ath/ath9k/ahb.c               |   13 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |    3 +
 drivers/net/wireless/ath/carl9170/tx.c             |    3 +-
 drivers/net/wireless/ath/wil6210/txrx.h            |    3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   44 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |   25 +
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |  308 +++
 .../broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   |   87 +
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |    3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.h |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |    7 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |    8 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.h   |   29 +
 drivers/net/wireless/intel/iwlwifi/Makefile        |   17 +-
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c      |   51 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c      |   90 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |  371 +---
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c      |   83 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c      |  235 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c      |  173 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |   94 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |  168 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |  230 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  169 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |  170 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |   51 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   42 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |   42 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c     |   84 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |   16 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c     |   15 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |  148 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |    3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |   53 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   77 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.c     |   34 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c        |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/ucode.c     |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   28 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |   10 +
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |   89 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  192 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |   83 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h   |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   40 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  105 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c       |   20 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   61 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h       |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   45 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   23 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c         |  145 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   74 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   37 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  496 +++--
 ...l-context-info-gen3.h => iwl-context-info-v2.h} |   42 +-
 .../net/wireless/intel/iwlwifi/iwl-context-info.h  |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h  |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  154 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   30 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   24 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |   14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   86 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  245 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  286 +--
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |    9 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   25 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   76 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   44 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |    9 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   10 +-
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |   12 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   85 +-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   79 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   21 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  198 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |   16 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   14 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |   43 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.h       |    5 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |    3 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |    2 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |  105 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   58 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |    3 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |   54 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |    7 +
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   15 +-
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |    2 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c        |  140 ++
 .../net/wireless/intel/iwlwifi/mld/tests/hcmd.c    |    6 +-
 .../intel/iwlwifi/mld/tests/link-selection.c       |  148 +-
 .../net/wireless/intel/iwlwifi/mld/tests/link.c    |    4 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |   39 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.h   |   86 +-
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c   |   89 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |  124 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   78 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  132 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   46 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   15 -
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   50 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   42 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  122 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/quota.c     |   43 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  204 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   78 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/hcmd.c    |   38 +
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   93 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  182 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   24 +-
 .../pcie/{ctxt-info-gen3.c => ctxt-info-v2.c}      |  185 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |   16 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 2339 +++++++++-----------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  114 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  179 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |  123 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  286 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |   76 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  226 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |  174 +-
 drivers/net/wireless/intersil/p54/fwio.c           |    2 +
 drivers/net/wireless/intersil/p54/p54.h            |    1 +
 drivers/net/wireless/intersil/p54/txrx.c           |   13 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    3 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |    4 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   10 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   20 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    7 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |    1 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   43 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   14 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    1 -
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |    2 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_init.c   |   13 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |   28 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   33 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   14 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   60 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   50 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    6 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |    1 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   28 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  154 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   82 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |    6 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt7925/testmode.c   |  201 ++
 .../net/wireless/mediatek/mt76/mt7996/coredump.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  194 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |   42 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   41 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  120 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  120 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |  195 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   82 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   21 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   51 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |    4 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |   11 -
 drivers/net/wireless/realtek/rtlwifi/core.h        |    1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.c   |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.h   |    1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   12 -
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 -
 drivers/net/wireless/realtek/rtw88/coex.c          |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/hci.h           |    8 +
 drivers/net/wireless/realtek/rtw88/mac.c           |   11 +-
 drivers/net/wireless/realtek/rtw88/mac.h           |    2 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +
 drivers/net/wireless/realtek/rtw88/main.c          |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    4 +
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   61 +-
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723de.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723du.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |   59 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |   12 +
 drivers/net/wireless/realtek/rtw88/rtw8814ae.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8822be.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    5 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   27 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   63 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          | 1039 ++++++++-
 drivers/net/wireless/realtek/rtw89/acpi.h          |  190 ++
 drivers/net/wireless/realtek/rtw89/cam.c           |    7 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  418 ++--
 drivers/net/wireless/realtek/rtw89/chan.h          |   17 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  493 +++--
 drivers/net/wireless/realtek/rtw89/core.h          |  144 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  174 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  480 +++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   94 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   58 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   19 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   38 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    3 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   36 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  135 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   15 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |    2 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |  147 ++
 drivers/net/wireless/realtek/rtw89/ps.h            |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   15 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   46 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    2 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   24 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   30 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |    5 -
 drivers/net/wireless/realtek/rtw89/sar.c           |  296 ++-
 drivers/net/wireless/realtek/rtw89/sar.h           |   19 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    3 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |   31 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    3 +-
 include/linux/ieee80211.h                          |    1 +
 include/net/mac80211.h                             |    3 +
 include/net/sock.h                                 |    6 +
 net/mac80211/cfg.c                                 |   11 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mesh_hwmp.c                           |    6 +-
 net/mac80211/scan.c                                |   18 +-
 net/mac80211/tx.c                                  |    6 +-
 349 files changed, 14677 insertions(+), 7180 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
 rename drivers/net/wireless/intel/iwlwifi/{iwl-context-info-gen3.h => iwl-context-info-v2.h} (90%)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/hcmd.c
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ctxt-info-gen3.c => ctxt-info-v2.c} (77%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c

