Return-Path: <linux-wireless+bounces-8673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00898FFFA4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814BB288AFE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89CF15AD9A;
	Fri,  7 Jun 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho4e2LDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909CB152511;
	Fri,  7 Jun 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752918; cv=none; b=AdBEeupRYSml2lguK22BYN9A2huYGRooFgn2C44ZehwCYbonPu+ldAFZ9/AUF5V2s3UdDwQWhPxti4qNP3VSWahHAaVS8njGQX/3YOimoR1i3UjnvHxxhACwSTO8lLmjlu4aNSiHbLm1CfFoOxtXoI8Jr161T/KVAgP23LdJKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752918; c=relaxed/simple;
	bh=A+LqgZLfevue4h2dCyrFdt6eXNkpFi7GW+4DtIPQquw=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=ostdEaJrJ5SbzYtFYiwxl2iilzUGWVRW0ubfwJ88bIGY9lxJ/dnAvGB3ii5AMkgYsMcm52bj3fKWk6P7BjuX98GNEs/frmfvJ7umx62wop50HBP+QG8uPAagdOa7qZrgQ3y4SA9eK3g7OqC2X+Y9VWLEVIsTCtvtjNmKeg6tYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho4e2LDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41394C2BBFC;
	Fri,  7 Jun 2024 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717752918;
	bh=A+LqgZLfevue4h2dCyrFdt6eXNkpFi7GW+4DtIPQquw=;
	h=From:Subject:To:Cc:Date:From;
	b=Ho4e2LDwXFUSCMSgTSF+6FK849KWYTk9+BTq3XxTDiO0KBXHZ/zy6u+czBtS7LUf5
	 F3LrH3CXok5tRjFgnSQ4yJLzHUlSZHl/1Vec6MvCVYl36slZ/COXjhtrRtp0UFFbtA
	 GEye3r9VScRANuhWTC48D6tquHIee1dl0rp798PS8VqZHjpbrlwD5Ew8sOS6O8llb9
	 Ma97Dt9/FtucwnUxbAMV7z4nD9FlLWuOsnbBLHHFfNRv8G9EU1j8uap4KEdyg23Ivx
	 lhIOgZVdjvWfsFKTn0RjuXKB98Nez7yV71mDnYoWP7kfKjq9Wj+bzQrhGmFlxb5ZAS
	 /6hRaq61YDF3A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-06-07
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240607093517.41394C2BBFC@smtp.kernel.org>
Date: Fri,  7 Jun 2024 09:35:17 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 83127ecada257e27f4740dbca9644dd0e838bc36:

  Merge tag 'wireless-next-2024-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2024-05-08 19:09:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-06-07

for you to fetch changes up to a46300b1b09ba260c2c2b00f06f6e34482a8ec01:

  Merge tag 'ath-next-20240605' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2024-06-05 21:29:56 +0300)

----------------------------------------------------------------
wireless-next patches for v6.11

The first "new features" pull request for v6.11 with changes both in
stack and in drivers. Nothing out of ordinary, except that we have two
conflicts this time:

CONFLICT (content): Merge conflict in net/mac80211/cfg.c
CONFLICT (content): Merge conflict in drivers/net/wireless/microchip/wilc1000/netdev.c

Here are Stephen's resolutions for them:

https://lore.kernel.org/all/20240531124415.05b25e7a@canb.auug.org.au/
https://lore.kernel.org/all/20240603110023.23572803@canb.auug.org.au/

Major changes:

cfg80211/mac80211

* parse Transmit Power Envelope (TPE) data in mac80211 instead of in drivers

wilc1000

* read MAC address during probe to make it visible to user space

iwlwifi

* bump FW API to 91 for BZ/SC devices

* report 64-bit radiotap timestamp

* Enable P2P low latency by default

* handle Transmit Power Envelope (TPE) advertised by AP

* start using guard()

rtlwifi

* RTL8192DU support

ath12k

* remove unsupported tx monitor handling

* channel 2 in 6 GHz band support

* Spatial Multiplexing Power Save (SMPS) in 6 GHz band support

* multiple BSSID (MBSSID) and Enhanced Multi-BSSID Advertisements (EMA) support

* dynamic VLAN support

* add panic handler for resetting the firmware state

ath10k

* add qcom,no-msa-ready-indicator Device Tree property

* LED support for various chipsets

----------------------------------------------------------------
Ajay Singh (1):
      wifi: wilc1000: read MAC address from fuse at probe

Alexis Lothoré (5):
      wifi: wilc1000: set net device registration as last step during interface creation
      wifi: wilc1000: register net device only after bus being fully initialized
      wifi: wilc1000: set wilc_set_mac_address parameter as const
      wifi: wilc1000: add function to read mac address from eFuse
      wifi: wilc1000: make sdio deinit function really deinit the sdio card

Aloka Dixit (9):
      wifi: ath12k: advertise driver capabilities for MBSSID and EMA
      wifi: ath12k: configure MBSSID params in vdev create/start
      wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
      wifi: ath12k: create a structure for WMI vdev up parameters
      wifi: ath12k: configure MBSSID parameters in AP mode
      wifi: ath12k: refactor arvif security parameter configuration
      wifi: ath12k: add MBSSID beacon support
      wifi: ath12k: add EMA beacon support
      wifi: ath12k: skip sending vdev down for channel switch

Andrei Otcheretianski (1):
      wifi: iwlwifi: mvm: Don't set NO_HT40+/- flags on 6 GHz band

Andrii Batyiev (1):
      wifi: iwlegacy: do not skip frames with bad FCS

Anjaneyulu (1):
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v11

Avraham Stern (8):
      wifi: iwlwifi: mvm: allow UAPSD when in SCM
      wifi: iwlwifi: mvm: debugfs: add entry for setting maximum TXOP time
      wifi: iwlwifi: mvm: add an option to use ptp clock for rx timestamp
      wifi: iwlwifi: mvm: initiator: move setting target flags into a function
      wifi: iwlwifi: mvm: initiator: move setting the sta_id into a function
      wifi: iwlwifi: mvm: modify iwl_mvm_ftm_set_secured_ranging() parameters
      wifi: iwlwifi: mvm: add support for version 14 of the range request command
      wifi: iwlwifi: mvm: add support for version 10 of the responder config command

Avri Altman (1):
      wifi: iwlwifi: mvm: Enable p2p low latency

Baochen Qiang (9):
      wifi: ath12k: fix Smatch warnings on ath12k_core_suspend()
      wifi: ath11k: refactor setting country code logic
      wifi: ath11k: restore country code during resume
      wifi: ath11k: fix wrong definition of CE ring's base address
      wifi: ath12k: fix race due to setting ATH12K_FLAG_EXT_IRQ_ENABLED too early
      wifi: ath12k: fix wrong definition of CE ring's base address
      wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()
      wifi: ath12k: do not process consecutive RDDM event
      wifi: ath12k: add panic handler

Benjamin Berg (1):
      wifi: iwlwifi: mvm: use vif P2P type helper

Bitterblue Smith (14):
      wifi: rtw88: usb: Simplify rtw_usb_write_data
      wifi: rtw88: usb: Fix disconnection after beacon loss
      wifi: rtlwifi: rtl8192d: Use "rtl92d" prefix
      wifi: rtlwifi: Add rtl8192du/table.{c,h}
      wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
      wifi: rtlwifi: Add rtl8192du/hw.{c,h}
      wifi: rtlwifi: Add rtl8192du/phy.{c,h}
      wifi: rtlwifi: Add rtl8192du/trx.{c,h}
      wifi: rtlwifi: Add rtl8192du/rf.{c,h}
      wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
      wifi: rtlwifi: Add rtl8192du/dm.{c,h}
      wifi: rtlwifi: Constify rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
      wifi: rtlwifi: Add rtl8192du/sw.c
      wifi: rtlwifi: Enable the new rtl8192du driver

Breno Leitao (4):
      wifi: wil6210: Do not use embedded netdev in wil6210_priv
      wifi: rtw89: Un-embed dummy device
      wifi: rtw88: Un-embed dummy device
      wifi: ath12k: allocate dummy net_device dynamically

Chaya Rachel Ivgi (1):
      wifi: iwlwifi: remove redundant reading from NVM file

Dmitry Antipov (2):
      wifi: rt2x00: remove unused delayed work data from link description
      wifi: cfg80211: use __counted_by where appropriate

Dr. David Alan Gilbert (1):
      wifi: brcm80211: remove unused structs

Emmanuel Grumbach (5):
      wifi: iwlwifi: mvm: simplify the uAPSD coexistence limitation code
      wifi: iwlwifi: always print the firmware version in hex
      wifi: iwlwifi: mvm: leave a print in the logs when we call fw_nmi()
      wifi: iwlwifi: kill iwl-eeprom-read
      wifi: iwlwifi: move code from iwl-eeprom-parse to dvm

Erick Archer (1):
      wifi: brcm80211: use sizeof(*pointer) instead of sizeof(type)

Jeff Johnson (8):
      wifi: ath11k: refactor CE remap & unmap
      wifi: ath11k: unmap the CE in ath11k_ahb_probe() error path
      wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
      wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()
      wifi: ath11k: fix misspelling of "dma" in num_rxmda_per_pdev
      wifi: ath12k: fix misspelling of "dma" in num_rxmda_per_pdev
      wifi: ath12k: initialize 'ret' in ath12k_dp_rxdma_ring_sel_config_wcn7850()
      wifi: ath12k: Fix devmem address prefix when logging

Jiapeng Chong (1):
      wifi: rtw89: chan: Use swap() in rtw89_swap_sub_entity()

Johannes Berg (43):
      wifi: regulatory: remove extra documentation
      wifi: ieee80211: add missing doc short descriptions
      wifi: radiotap: document ieee80211_get_radiotap_len() return value
      wifi: ieee80211: remove ieee80211_next_tbtt_present()
      wifi: ieee80211: document function return values
      wifi: ieee80211: document two FTM related functions
      wifi: nl80211: disallow setting special AP channel widths
      wifi: cfg80211: sort trace events again
      wifi: cfg80211: add tracing for wiphy work
      wifi: mac80211: remove outdated comments
      wifi: mac80211: remove extra link STA functions
      wifi: ieee80211/ath11k: remove IEEE80211_MAX_NUM_PWR_LEVEL
      wifi: ath11k: fix TPE power levels
      wifi: mac80211: pass parsed TPE data to drivers
      wifi: mac80211: track changes in AP's TPE
      wifi: iwlwifi: dvm: clean up rs_get_rate() logic
      wifi: iwlwifi: mvm: mark bad no-data RX as having bad PLCP
      wifi: iwlwifi: mei: unify iwl_mei_set_power_limit() prototype
      wifi: iwlwifi: fw: avoid bad FW config on RXQ DMA failure
      wifi: iwlwifi: mvm: don't track used links separately
      wifi: iwlwifi: tracing: fix condition to allocate buf1
      wifi: iwlwifi: simplify TX tracing
      wifi: iwlwifi: mvm: add mvm-specific guard
      wifi: mac80211: move radar detect work to sdata
      wifi: cfg80211: restrict operation during radar detection
      wifi: mac80211: mlme: handle cross-link CSA
      wifi: mac80211: collect some CSA data into sub-structs
      wifi: mac80211: handle wider bandwidth OFDMA during CSA
      wifi: mac80211: handle TPE element during CSA
      wifi: mac80211: refactor chanreq.ap setting
      wifi: mac80211: fix TTLM teardown work
      wifi: mac80211: cancel multi-link reconf work on disconnect
      wifi: mac80211: cancel TTLM teardown work earlier
      wifi: mac80211: don't stop TTLM works again
      wifi: mac80211: reset negotiated TTLM on disconnect
      wifi: mac80211: send DelBA with correct BSSID
      wifi: iwlwifi: mvm: report 64-bit radiotap timestamp
      wifi: iwlwifi: mvm: handle TPE advertised by AP
      wifi: iwlwifi: mvm: use only beacon BSS load for active links
      wifi: iwlwifi: mvm: show full firmware ID in debugfs
      wifi: mac80211: check ieee80211_bss_info_change_notify() against MLD
      wifi: mac80211: handle HW restart during ROC
      wifi: nl80211: clean up coalescing rule handling

Kalle Valo (3):
      wifi: ath11k: ath11k_mac_op_ipv6_changed(): use list_for_each_entry()
      Merge tag 'rtw-next-2024-06-04' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20240605' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Kang Yang (5):
      wifi: ath12k: remove unused variable monitor_flags
      wifi: ath12k: avoid duplicated vdev stop
      wifi: ath12k: avoid duplicated vdev down
      wifi: ath12k: remove invalid peer create logic
      wifi: ath12k: remove redundant peer delete for WCN7850

Karthikeyan Kathirvel (1):
      wifi: ath12k: drop failed transmitted frames from metric calculation.

Karthikeyan Periyasamy (13):
      wifi: ath12k: Refactor the hardware recovery procedure
      wifi: ath12k: Refactor the hardware state
      wifi: ath12k: Add lock to protect the hardware state
      wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer manager
      wifi: ath12k: Refactor idle ring descriptor setup
      wifi: ath12k: Introduce device index
      wifi: ath12k: add multi device support for WBM idle ring buffer setup
      wifi: ath12k: avoid double SW2HW_MACID conversion
      wifi: ath12k: remove duplicate definition of MAX_RADIOS
      wifi: ath12k: use correct MAX_RADIOS
      wifi: ath12k: refactor rx descriptor CMEM configuration
      wifi: ath12k: improve the rx descriptor error information
      wifi: ath12k: add hw_link_id in ath12k_pdev

Lingbo Kong (1):
      wifi: ath12k: fix ack signal strength calculation

Marc Gonzalez (2):
      dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop
      wifi: ath10k: do not always wait for MSA_READY indicator

Miri Korenblit (18):
      wifi: iwlwifi: mvm: define link_sta in the relevant scope
      wifi: iwlwifi: mvm: set A-MSDU size on the correct link
      wifi: iwlwifi: mvm: call ieee80211_sta_recalc_aggregates on A-MSDU size update
      wifi: iwlwifi: mvm: don't always set antenna in beacon template cmd
      wifi: iwlwifi: mvm: Use the SMPS cfg of the correct link
      wifi: iwlwifi: mvm: add a of print of a few commands
      wifi: iwlwifi: bump FW API to 91 for BZ/SC devices
      wifi: iwlwifi: mvm: disable dynamic EMLSR when AUTO_EML is false
      wifi: iwlwifi: mvm: don't skip link selection
      wifi: iwlwifi: mvm: remove IWL_MVM_USE_NSSN_SYNC
      wifi: iwlwifi: mvm: move a constant to constants.h
      wifi: iwlwifi: mvm: Remove debug related code
      wifi: iwlwifi: mvm: add debug data for MPDU counting
      wifi: iwlwifi: mvm: declare band variable in the scope
      wifi: iwlwifi: mvm: fix a wrong comment
      wifi: iwlwifi: remove redundant prints
      wifi: iwlwifi: move amsdu_size parsing to iwlwifi
      wifi: iwlwifi: move Bz and Gl iwl_dev_info entries

Mukesh Sisodiya (2):
      wifi: mac80211: update 6 GHz AP power type before association
      wifi: iwlwifi: fw: api: Add new timepoint for scan failure

Muna Sinada (1):
      wifi: ath12k: dynamic VLAN support

Nithyanantham Paramasivam (1):
      wifi: ath12k: Fix tx completion ring (WBM2SW) setup failure

P Praneesh (3):
      wifi: ath12k: change DMA direction while mapping reinjected packets
      wifi: ath12k: fix invalid memory access while processing fragmented packets
      wifi: ath12k: fix firmware crash during reo reinject

Ping-Ke Shih (6):
      wifi: rtw89: 8852b: restore setting for RFE type 5 after device resume
      wifi: rtw89: correct hardware value of nominal packet padding for WiFi 7 chips
      wifi: rtw89: 8852c: correct logic and restore PCI PHY EQ after device resume
      wifi: rtw89: fill STBC and LDPC capabilities to TX descriptor
      wifi: rtw89: add LDPC and STBC to rx_status and radiotap known fields for monitor mode
      wifi: rtlwifi: handle return value of usb init TX/RX

Po-Hao Huang (2):
      wifi: rtw89: fix HW scan not aborting properly
      wifi: rtw89: Fix P2P behavior for WiFi 7 chips

Pradeep Kumar Chitrapu (7):
      wifi: ath12k: add channel 2 into 6 GHz channel list
      wifi: ath12k: Correct 6 GHz frequency value in rx status
      wifi: ath12k: fix survey dump collection in 6 GHz
      wifi: ath12k: add 6 GHz params in peer assoc command
      wifi: ath12k: refactor SMPS configuration
      wifi: ath12k: support SMPS configuration for 6 GHz
      wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf

Rafael Beims (1):
      wifi: mwifiex: Fix interface type change

Rob Herring (Arm) (1):
      dt-bindings: net: wireless: ath11k: Drop "qcom,ipq8074-wcss-pil" from example

Samasth Norway Ananda (1):
      wifi: brcmsmac: LCN PHY code is used for BCM4313 2G-only device

Sebastian Gottschall (1):
      wifi: ath10k: add LED and GPIO controlling support for various chipsets

Shahar S Matityahu (1):
      wifi: iwlwifi: remove fw_running op

Sven Eckelmann (1):
      wifi: ath12k: Don't drop tx_status in failure case

Tamizh Chelvam Raja (3):
      wifi: ath12k: fix calling correct function for rx monitor mode
      wifi: ath12k: Remove unsupported tx monitor handling
      wifi: ath12k: Remove unused tcl_*_ring configuration

Venkateswara Naralasetty (1):
      wifi: ath11k: skip status ring entry processing

Zong-Zhe Yang (4):
      wifi: rtw89: ser: avoid multiple deinit on same CAM
      wifi: rtw89: cam: tweak relation between sec CAM and addr CAM
      wifi: rtw89: switch to register vif_cfg_changed and link_info_changed
      wifi: rtw89: support mac_id number according to chip

 .../bindings/net/wireless/qcom,ath10k.yaml         |    5 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |    9 -
 drivers/net/wireless/ath/ath10k/Kconfig            |    6 +
 drivers/net/wireless/ath/ath10k/Makefile           |    1 +
 drivers/net/wireless/ath/ath10k/core.c             |   32 +
 drivers/net/wireless/ath/ath10k/core.h             |    8 +
 drivers/net/wireless/ath/ath10k/hw.h               |    1 +
 drivers/net/wireless/ath/ath10k/leds.c             |   90 +
 drivers/net/wireless/ath/ath10k/leds.h             |   34 +
 drivers/net/wireless/ath/ath10k/mac.c              |    1 +
 drivers/net/wireless/ath/ath10k/qmi.c              |   11 +
 drivers/net/wireless/ath/ath10k/qmi.h              |    1 +
 drivers/net/wireless/ath/ath10k/wmi-ops.h          |   32 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |    2 +
 drivers/net/wireless/ath/ath10k/wmi.c              |   54 +
 drivers/net/wireless/ath/ath10k/wmi.h              |   35 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   57 +-
 drivers/net/wireless/ath/ath11k/ce.h               |    6 +-
 drivers/net/wireless/ath/ath11k/core.c             |   49 +-
 drivers/net/wireless/ath/ath11k/core.h             |    9 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    6 +-
 drivers/net/wireless/ath/ath11k/dp.c               |   12 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  104 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    6 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   16 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    2 +
 drivers/net/wireless/ath/ath11k/hw.h               |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  167 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/reg.c              |   18 +-
 drivers/net/wireless/ath/ath11k/reg.h              |    4 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/ce.h               |    6 +-
 drivers/net/wireless/ath/ath12k/core.c             |  144 +-
 drivers/net/wireless/ath/ath12k/core.h             |   44 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   83 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    4 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   40 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  115 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  165 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    5 +-
 drivers/net/wireless/ath/ath12k/hal.c              |    5 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   21 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   47 +-
 drivers/net/wireless/ath/ath12k/hal_tx.h           |    4 +-
 drivers/net/wireless/ath/ath12k/hif.h              |    9 +
 drivers/net/wireless/ath/ath12k/hw.c               |   23 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    4 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  574 +++-
 drivers/net/wireless/ath/ath12k/mhi.c              |   11 +
 drivers/net/wireless/ath/ath12k/pci.c              |   39 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    1 +
 drivers/net/wireless/ath/ath12k/qmi.c              |    8 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   19 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   55 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   48 +-
 drivers/net/wireless/ath/wil6210/netdev.c          |   21 +-
 drivers/net/wireless/ath/wil6210/wil6210.h         |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |    5 -
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    6 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.c |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/antsel.c  |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |   29 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      |    4 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |   24 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c         |    4 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/Makefile    |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h       |   21 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |    2 +-
 .../iwlwifi/{iwl-eeprom-parse.c => dvm/eeprom.c}   |  480 ++-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c        |   21 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |    1 +
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    7 +
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |  157 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   52 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c       |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   15 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    3 +-
 .../net/wireless/intel/iwlwifi/iwl-devtrace-data.h |    4 +-
 .../wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   14 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-read.c   |  394 ---
 .../net/wireless/intel/iwlwifi/iwl-eeprom-read.h   |   12 -
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h |   21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   19 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c |  118 +
 .../{iwl-eeprom-parse.h => iwl-nvm-utils.h}        |   17 -
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    5 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   38 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   10 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  300 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    2 -
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   52 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  240 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  145 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   69 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   67 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |   34 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   60 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   54 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   10 -
 drivers/net/wireless/microchip/wilc1000/fw.h       |   13 +
 drivers/net/wireless/microchip/wilc1000/hif.c      |    4 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |    2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   76 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    2 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   71 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |   17 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   49 +
 drivers/net/wireless/microchip/wilc1000/wlan.h     |    1 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |   10 -
 drivers/net/wireless/realtek/rtlwifi/Kconfig       |   12 +
 drivers/net/wireless/realtek/rtlwifi/Makefile      |    1 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    3 +-
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.c  |   94 +-
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.h  |   28 +-
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.c |   92 +-
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.h |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |   18 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |   20 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192du/Makefile    |   13 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/dm.c    |  120 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/dm.h    |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/fw.c    |   63 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/fw.h    |    9 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.c    | 1212 ++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.h    |   22 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/led.c   |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/led.h   |    9 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.c   | 3123 ++++++++++++++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.h   |   32 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/rf.c    |  240 ++
 .../net/wireless/realtek/rtlwifi/rtl8192du/rf.h    |   11 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    |  395 +++
 .../net/wireless/realtek/rtlwifi/rtl8192du/table.c | 1675 +++++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/table.h |   29 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/trx.c   |  372 +++
 .../net/wireless/realtek/rtlwifi/rtl8192du/trx.h   |   60 +
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   36 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   12 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   17 +-
 drivers/net/wireless/realtek/rtw88/pci.h           |    2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   14 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   79 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |    5 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  107 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   20 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   16 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |   31 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |    4 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   12 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   42 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   29 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    1 +
 drivers/net/wireless/realtek/rtw89/ser.c           |    8 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |    4 +
 include/linux/ieee80211.h                          |  252 +-
 include/net/cfg80211.h                             |   10 +-
 include/net/ieee80211_radiotap.h                   |    1 +
 include/net/mac80211.h                             |   47 +-
 include/net/regulatory.h                           |    2 -
 net/mac80211/cfg.c                                 |   80 +-
 net/mac80211/chan.c                                |    4 +-
 net/mac80211/driver-ops.h                          |   12 +
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ibss.c                                |    6 +-
 net/mac80211/ieee80211_i.h                         |   37 +-
 net/mac80211/iface.c                               |    8 +-
 net/mac80211/link.c                                |   18 +-
 net/mac80211/main.c                                |    3 +-
 net/mac80211/mlme.c                                |  899 ++++--
 net/mac80211/offchannel.c                          |   35 +-
 net/mac80211/parse.c                               |  100 +-
 net/mac80211/spectmgmt.c                           |    5 +-
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/tpe.c                           |  284 ++
 net/mac80211/util.c                                |   34 +-
 net/wireless/core.c                                |   15 +-
 net/wireless/ibss.c                                |    5 +-
 net/wireless/mesh.c                                |    5 +-
 net/wireless/nl80211.c                             |   95 +-
 net/wireless/nl80211.h                             |    4 +-
 net/wireless/trace.h                               |  212 +-
 222 files changed, 12831 insertions(+), 2709 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath10k/leds.c
 create mode 100644 drivers/net/wireless/ath/ath10k/leds.h
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-parse.c => dvm/eeprom.c} (69%)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-parse.h => iwl-nvm-utils.h} (73%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h
 create mode 100644 net/mac80211/tests/tpe.c


