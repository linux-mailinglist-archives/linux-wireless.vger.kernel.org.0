Return-Path: <linux-wireless+bounces-7340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE418BFCE0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04571C21804
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75C82D70;
	Wed,  8 May 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPLTEQB+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E282862;
	Wed,  8 May 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170047; cv=none; b=djbv86HaoPqAaUbhPB/TiO9mLgk4t9GBtgYWl3WfAK9jqneUsnrpT+IfC/zrVA+sgE73dILI0nl+yPWWpbceEu55tYpNPi/WOnsOUKh/NXsMBeRcf7o9e6681N9/5CtNTA5b86nncFwEpJ8w6lbi+nhnWXMjeuDDVYIlFJrC8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170047; c=relaxed/simple;
	bh=OElvYj2f+PStG44ljMKTQ72BOsQX5Cfecew9bd14dXY=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=P5FMvk8Su42DgPqHZn7VWty/amwcPdBhNLGlocMj5VvDBBsMn+AYBqNnmnzDZbVr4N0oBG1siRNA/tHx70b1ymA4nwNqZR3qFs3px3oDVvrp/4oP6OX/Q6QEVg7DHVfupQ1L8+y56X2rFC6nT6+x/PQlzPNaobZWPJAv5AiPOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPLTEQB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A10C113CC;
	Wed,  8 May 2024 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170047;
	bh=OElvYj2f+PStG44ljMKTQ72BOsQX5Cfecew9bd14dXY=;
	h=From:Subject:To:Cc:Date:From;
	b=iPLTEQB+cF715pPLO2nc8mEAZYm5dERDY4LMDVCyh2jK0ca/wVM1QW2HWWRKOlaGH
	 p+zUoi6k7C6LSVZTPrYP5koFfZ0EjBqAl5ofg62xEVvmZHbRPCH9cSJ0xRlK19E1uJ
	 9aY8EXzuz2MfVdhRcFF+MMXeieEaSNrGmtzdrxyfpJF04hn6ff7ciPVz4i+yksBl3k
	 vbpE1CNPgK0SklbUpQ1GuHS12o7AAWMPV1chQEwpa1EE13xnUvKQACo2LZlEJDBnTZ
	 RzHAgi2OWYPk4LMPnYysMVGlsa85v/a+wHIFITg7UODO3gepjdwYRHODoK5RdTNweJ
	 +ET6CZwoZsmCw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-05-08
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240508120726.85A10C113CC@smtp.kernel.org>
Date: Wed,  8 May 2024 12:07:26 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 1cedb16b945c32e029effbe6bf4cd8222e111130:

  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2024-04-25 20:00:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-05-08

for you to fetch changes up to 1d60eabb82694e58543e2b6366dae3e7465892a5:

  wifi: mwl8k: initialize cmd->addr[] properly (2024-05-07 15:08:14 +0300)

----------------------------------------------------------------
wireless-next patches for v6.10

The third, and most likely the last, "new features" pull request for
v6.10 with changes both in stack and in drivers. In ath12k and rtw89
we disabled Wireless Extensions just like with iwlwifi earlier. Wi-Fi
7 devices will not support Wireless Extensions (WEXT) anymore so if
someone is still using the legacy WEXT interface it's time to switch
to nl80211 now!

We merged wireless into wireless-next as we decided not to send a
wireless pull request to v6.9 this late in the cycle. Also an
immutable branch with MHI subsystem was merged to get ath11k and
ath12k hibernation working.

Major changes:

mac80211/cfg80211

* handle color change per link

mt76

* mt7921 LED control

* mt7925 EHT radiotap support

* mt7920e PCI support

ath12k

* debugfs support

* dfs_simulate_radar debugfs file

* disable Wireless Extensions

* suspend and hibernation support

* ACPI support

* refactoring in preparation of multi-link support

ath11k

* support hibernation (required changes in qrtr and MHI subsystems)

* ieee80211-freq-limit Device Tree property support

ath10k

* firmware-name Device Tree property support

rtw89

* complete features of new WiFi 7 chip 8922AE including BT-coexistence
  and WoWLAN

* use BIOS ACPI settings to set TX power and channels

* disable Wireless Extensios on Wi-Fi 7 devices

iwlwifi

* block_esr debugfs file

* support again firmware API 90 (was reverted earlier)

* provide channel survey information for Automatic Channel Selection (ACS)

----------------------------------------------------------------
Aditya Kumar Singh (3):
      wifi: cfg80211: handle color change per link
      wifi: mac80211: handle color change per link
      wifi: mac80211_hwsim: add support for BSS color

Andy Shevchenko (1):
      wifi: mt76: mt7915: Remove unused of_gpio.h

Arnd Bergmann (2):
      wifi: carl9170: re-fix fortified-memset warning
      wifi: ath9k: work around memset overflow warning

Baochen Qiang (16):
      bus: mhi: host: Add mhi_power_down_keep_dev() API to support system suspend/hibernation
      net: qrtr: support suspend/hibernation
      wifi: ath11k: support hibernation
      wifi: ath12k: fix kernel crash during resume
      wifi: ath12k: rearrange IRQ enable/disable in reset path
      wifi: ath12k: remove MHI LOOPBACK channels
      wifi: ath12k: do not dump SRNG statistics during resume
      wifi: ath12k: fix warning on DMA ring capabilities event
      wifi: ath12k: decrease MHI channel buffer length to 8KB
      wifi: ath12k: flush all packets before suspend
      wifi: ath12k: no need to handle pktlog during suspend/resume
      wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
      wifi: ath12k: support suspend/resume
      wifi: ath12k: change supports_suspend to true for WCN7850
      wifi: ath12k: check M3 buffer size as well whey trying to reuse it
      wifi: ath12k: fix flush failure in recovery scenarios

Ben Greear (2):
      wifi: mt76: mt7915: add missing chanctx ops
      wifi: iwlwifi: Use request_module_nowait

Benjamin Berg (2):
      wifi: iwlwifi: mvm: add the firmware API for channel survey
      wifi: iwlwifi: mvm: record and return channel survey information

Bitterblue Smith (10):
      wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
      wifi: rtl8xxxu: Add separate MAC init table for RTL8192CU
      wifi: rtl8xxxu: Add LED control code for RTL8192CU family
      wifi: rtl8xxxu: Add LED control code for RTL8723BU
      wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
      wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
      wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path
      wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
      wifi: rtlwifi: Clean up rtl8192d-common a bit
      wifi: rtlwifi: Adjust rtl8192d-common for USB

Bo Jiao (1):
      wifi: mt76: mt7915: only set MT76_MCU_RESET for the main phy

Breno Leitao (3):
      wifi: qtnfmac: Move stats allocation to core
      wifi: qtnfmac: Remove generic .ndo_get_stats64
      wifi: iwlwifi: pcie: allocate dummy net_device dynamically

Chad Monroe (1):
      wifi: mt76: mt7996: fix size of txpower MCU command

Chia-Yuan Li (1):
      wifi: rtw89: 8852c: refine power sequence to imporve power consumption

Chih-Kang Chang (10):
      wifi: rtw89: wow: refine WoWLAN flows of HCI interrupts and low power mode
      wifi: rtw89: wow: parsing Auth Key Management from associate request
      wifi: rtw89: wow: prepare PTK GTK info from mac80211
      wifi: rtw89: use struct to access firmware command h2c_dctl_sec_cam_v1
      wifi: rtw89: use struct to fill H2C of WoWLAN global configuration
      wifi: rtw89: wow: construct EAPoL packet for GTK rekey offload
      wifi: rtw89: wow: add GTK rekey feature related H2C commands
      wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume
      wifi: rtw89: wow: support 802.11w PMF IGTK rekey
      wifi: rtw89: wow: support WEP cipher on WoWLAN

Chin-Yen Lee (3):
      wifi: rtw89: reset AFEDIG register in power off sequence
      wifi: rtw89: wow: send RFK pre-nofity H2C command in WoWLAN mode
      wifi: rtw89: wow: add ARP offload feature

Ching-Te Ku (17):
      wifi: rtw89: coex: Allow Bluetooth doing traffic during Wi-Fi scan
      wifi: rtw89: coex: Add v7 firmware cycle status report
      wifi: rtw89: coex: Add version 3 report map of H2C command
      wifi: rtw89: coex: Add PTA path control condition for chip RTL8922A
      wifi: rtw89: coex: Update Bluetooth polluted Wi-Fi TX logic
      wifi: rtw89: coex: Add register monitor report v7 format
      wifi: rtw89: coex: Add GPIO signal control version 7
      wifi: rtw89: coex: Add coexistence firmware control report version 8
      wifi: rtw89: coex: Re-order the index for the report from firmware
      wifi: rtw89: coex: Add Wi-Fi null data status version 7
      wifi: rtw89: coex: Add Bluetooth scan parameter report version 7
      wifi: rtw89: coex: Add Bluetooth frequency hopping map version 7
      wifi: rtw89: coex: Add Bluetooth version report version 7
      wifi: rtw89: coex: Fix unexpected value in version 7 slot parameter
      wifi: rtw89: coex: Add Wi-Fi role v8 condition when set Bluetooth channel
      wifi: rtw89: coex: Add Wi-Fi role v8 condition when set BTG control
      wifi: rtw89: coex: Check and enable reports after run coex

Christian Lamparter (2):
      dt-bindings: net: wireless: ath11k: add ieee80211-freq-limit property
      wifi: ath11k: add support DT ieee80211-freq-limit

Christophe JAILLET (3):
      wifi: ath11k: Fix error handling in ath11k_wmi_p2p_noa_event()
      wifi: brcmsmac: ampdu: remove unused cb_del_ampdu_pars struct
      wifi: brcmfmac: remove unused brcmf_usb_image struct

Colin Ian King (1):
      wifi: rtlwifi: rtl8723be: Make read-only arrays static const

Dan Carpenter (1):
      wifi: mwl8k: initialize cmd->addr[] properly

Daniel Gabay (3):
      wifi: iwlwifi: Print EMLSR states name
      wifi: iwlwifi: Force SCU_ACTIVE for specific platforms
      wifi: iwlwifi: Ensure prph_mac dump includes all addresses

Deren Wu (2):
      wifi: mt76: mt7921: introduce mt7920 PCIe support
      wifi: mt76: mt7925: add EHT radiotap support in monitor mode

Dmitry Baryshkov (5):
      dt-bindings: net: wireless: ath10k: describe firmware-name property
      wifi: ath10k: support board-specific firmware overrides
      wifi: ath10k: populate board data for WCN3990
      wifi: ath10k: drop chip-specific board data file name
      wifi: ath10k: drop fw.eboard file name

Felix Fietkau (10):
      wifi: mt76: mt7915: initialize rssi on adding stations
      wifi: mt76: replace skb_put with skb_put_zero
      wifi: mt76: fix tx packet loss when scanning on DBDC
      wifi: mt76: mt7996: only set MT76_MCU_RESET for the main phy
      wifi: mt76: mt7915: add fallback in case of missing precal data
      wifi: mt76: mt7603: fix tx queue of loopback packets
      wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset
      wifi: mt76: connac: use muar idx 0xe for non-mt799x as well
      wifi: mt76: make const arrays in functions static
      wifi: mt76: enable spectrum management

Gustavo A. R. Silva (3):
      wifi: wil6210: cfg80211: Use __counted_by() in struct wmi_start_scan_cmd and avoid some -Wfamnae warnings
      wifi: wil6210: wmi: Use __counted_by() in struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
      wifi: rtlwifi: Remove unused structs and avoid multiple -Wfamnae warnings

Hao Zhang (1):
      wifi: mt76: mt7921e: add LED control support

Henry Yen (2):
      wifi: mt76: mt7915: fix bogus Tx/Rx airtime duration values
      wifi: mt76: mt7996: fix non-main BSS no beacon issue for MBSS scenario

Howard Hsu (4):
      wifi: mt76: mt7915: fix HE PHY capabilities IE for station mode
      wifi: mt76: connac: enable HW CSO module for mt7996
      wifi: mt76: mt7996: fix potential memory leakage when reading chip temperature
      wifi: mt76: connac: enable critical packet mode support for mt7992

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix race in scan completion

Jeff Johnson (3):
      wifi: ath11k: fix hal_rx_buf_return_buf_manager documentation
      wifi: ath12k: fix hal_rx_buf_return_buf_manager documentation
      wifi: ath12k: don't use %pK in dmesg format strings

Jiapeng Chong (1):
      wifi: rtw89: Remove the redundant else branch in the function rtw89_phy_get_kpath

Johannes Berg (5):
      Merge wireless into wireless-next
      wifi: iwlwifi: mvm: exit EMLSR when CSA happens
      wifi: iwlwifi: mvm: don't reset link selection during restart
      wifi: iwlwifi: mvm: use already determined cmd_id
      wifi: iwlwifi: mvm: align UATS naming with firmware

Kalle Valo (7):
      Merge branch 'mhi-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into ath-next
      wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
      wifi: rtl8xxxu: remove some unused includes
      wifi: rtl8xxxu: remove rtl8xxxu_ prefix from filenames
      Merge tag 'mt76-for-kvalo-2024-05-02' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20240502' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
      Merge tag 'rtw-next-2024-05-04-v2' of https://github.com/pkshih/rtw

Kang Yang (2):
      wifi: ath12k: dynamically update peer puncturing bitmap for STA
      wifi: ath12k: add support to handle beacon miss for WCN7850

Karthikeyan Kathirvel (1):
      wifi: ath12k: fix out-of-bound access of qmi_invoke_handler()

Karthikeyan Periyasamy (9):
      wifi: ath12k: extend the link capable flag
      wifi: ath12k: fix link capable flags
      wifi: ath12k: correct the capital word typo
      wifi: ath12k: add multiple radio support in a single MAC HW un/register
      wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
      wifi: ath12k: avoid redundant code in Rx cookie conversion init
      wifi: ath12k: Refactor the hardware cookie conversion init
      wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion table
      wifi: ath12k: Refactor data path cmem init

Kees Cook (1):
      wifi: nl80211: Avoid address calculations via out of bounds array indexing

Krzysztof Kozlowski (1):
      wifi: ath6kl: sdio: simplify module initialization

Kuan-Chung Chen (1):
      wifi: rtw89: fix CTS transmission issue with center frequency deviation

Leon Yen (1):
      wifi: mt76: mt7921s: fix potential hung tasks during chip recovery

Lingbo Kong (5):
      wifi: ath12k: ACPI TAS support
      wifi: ath12k: ACPI SAR support
      wifi: ath12k: ACPI CCA threshold support
      wifi: ath12k: ACPI band edge channel power support
      wifi: ath12k: fix the problem that down grade phy mode operation

Lorenzo Bianconi (2):
      wifi: mt76: mt7996: fix uninitialized variable in mt7996_irq_tasklet()
      wifi: mt76: sdio: move mcu queue size check inside critical section

Martin Kaistra (2):
      Revert "wifi: rtl8xxxu: enable MFP support"
      wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor

MeiChia Chiu (1):
      wifi: mt76: mt7915: add support for disabling in-band discovery

Miaoqing Pan (1):
      wifi: ath12k: fix missing endianness conversion in wmi_vdev_create_cmd()

Michael-CY Lee (1):
      wifi: mt76: mt7996: let upper layer handle MGMT frame protection

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: ensure 4-byte alignment for suspend & wow command

Miri Korenblit (14):
      wifi: iwlwifi: cleanup EMLSR when BT is active handling
      wifi: iwlwifi: mvm: trigger link selection after exiting EMLSR
      wifi: iwlwifi: mvm: add a debugfs for (un)blocking EMLSR
      wifi: iwlwifi: mvm: Always allow entering EMLSR from debugfs
      wifi: iwlwifi: mvm: don't always unblock EMLSR
      wifi: iwlwifi: mvm: Activate EMLSR based on traffic volume
      wifi: iwlwifi: mvm: consider FWs recommendation for EMLSR
      wifi: iwlwifi: mvm: trigger link selection upon TTLM start/end
      wifi: iwlwifi: mvm: avoid always prefering single-link
      wifi: iwlwifi: mvm: fix typo in debug print
      wifi: iwlwifi: mvm: fix primary link setting
      wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
      wifi: iwlwifi: mvm: exit EMLSR if secondary link is not used
      wifi: iwlwifi: mvm: don't request statistics in restart

Muhammad Usama Anjum (1):
      wifi: mt76: connac: check for null before dereferencing

Nikita Zhandarovich (2):
      wifi: carl9170: add a proper sanity check for endpoints
      wifi: ar5523: enable proper endpoint verification

Peter Chiu (3):
      wifi: mt76: mt7915: fix mcu command format for mt7915 tx stats
      wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration
      wifi: mt76: mt7996: set RCPI value in rate control command

Ping-Ke Shih (6):
      wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command
      wifi: rtw88: suppress messages of failed to flush queue
      wifi: rtw89: 8852b: update hardware parameters for RFE type 5
      wifi: rtl8xxxu: cleanup includes
      wifi: rtw89: correct aSIFSTime for 6GHz band
      wifi: rtlwifi: 8192d: initialize rate_mask in rtl92de_update_hal_rate_mask()

Raj Kumar Bhagat (2):
      wifi: ath12k: read single_chip_mlo_support parameter from QMI PHY capability
      wifi: ath12k: set mlo_capable_flags based on QMI PHY capability

Ramasamy Kaliappan (1):
      wifi: ath12k: initial debugfs support

Ramya Gnanasekar (1):
      wifi: ath12k: debugfs: radar simulation support

Rong Yan (1):
      wifi: mt76: mt7921: cqm rssi low/high event notify

Shayne Chen (2):
      wifi: mt76: mt7996: disable rx header translation for BMC entry
      wifi: mt76: connac: use peer address for station BMC entry

Sriram R (11):
      wifi: ath12k: Modify add and remove chanctx ops for single wiphy support
      wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
      wifi: ath12k: vdev statemachine changes for single wiphy
      wifi: ath12k: scan statemachine changes for single wiphy
      wifi: ath12k: fetch correct radio based on vdev status
      wifi: ath12k: Cache vdev configs before vdev create
      wifi: ath12k: Add additional checks for vif and sta iterators
      wifi: ath12k: modify regulatory support for single wiphy architecture
      wifi: ath12k: Modify set and get antenna mac ops for single wiphy
      wifi: ath12k: Modify rts threshold mac op for single wiphy
      wifi: ath12k: support get_survey mac op for single wiphy

StanleyYP Wang (1):
      wifi: mt76: mt7996: add sanity checks for background radar trigger

Su Hui (1):
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Thiraviyam Mariyappan (1):
      wifi: ath12k: enable service flag for survey dump stats

Xin Deng (1):
      wifi: cfg80211: Clear mlo_links info when STA disconnects

Yedidya Benshimol (5):
      wifi: iwlwifi: mvm: Disable/enable EMLSR due to link's bandwidth/band
      wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active
      wifi: iwlwifi: mvm: Add active EMLSR blocking reasons prints
      wifi: iwlwifi: mvm: add a debugfs for reading EMLSR blocking reasons
      wifi: iwlwifi: mvm: Add a print for invalid link pair due to bandwidth

Zong-Zhe Yang (10):
      wifi: rtw89: sar: correct TX power boundary for MAC domain
      wifi: rtw89: fw: scan offload prohibit all 6 GHz channel if no 6 GHz sband
      wifi: rtw89: 8852c: update TX power tables to R69.1 (1 of 2)
      wifi: rtw89: 8852c: update TX power tables to R69.1 (2 of 2)
      wifi: rtw89: regd: block 6 GHz by policy if not specific country
      wifi: rtw89: regd: extend policy of UNII-4 for IC regulatory
      wifi: rtw89: acpi: process 6 GHz SP policy from ACPI DSM
      wifi: rtw89: regd: handle policy of 6 GHz SP according to BIOS
      wifi: rtw89: set WIPHY_FLAG_DISABLE_WEXT before MLO
      wifi: rtw89: 8922a: fix argument to hal_reset in bb_cfg_txrx_path

striebit (1):
      wifi: iwlwifi: mvm: add beacon template version 14

 .../bindings/net/wireless/qcom,ath10k.yaml         |    6 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |    3 +
 drivers/bus/mhi/host/internal.h                    |    4 +-
 drivers/bus/mhi/host/pm.c                          |   42 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |   14 +
 drivers/net/wireless/ath/ath.h                     |    6 +-
 drivers/net/wireless/ath/ath10k/core.c             |   43 +-
 drivers/net/wireless/ath/ath10k/core.h             |    2 +
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    2 +-
 drivers/net/wireless/ath/ath10k/hw.h               |   14 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   10 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    3 +
 drivers/net/wireless/ath/ath10k/targaddrs.h        |    3 +
 drivers/net/wireless/ath/ath11k/ahb.c              |    6 +-
 drivers/net/wireless/ath/ath11k/core.c             |  113 +-
 drivers/net/wireless/ath/ath11k/core.h             |    6 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath11k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath11k/mac.c              |    3 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   12 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   44 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   21 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |    9 +
 drivers/net/wireless/ath/ath12k/Makefile           |    2 +
 drivers/net/wireless/ath/ath12k/acpi.c             |  394 +++
 drivers/net/wireless/ath/ath12k/acpi.h             |   76 +
 drivers/net/wireless/ath/ath12k/core.c             |  123 +-
 drivers/net/wireless/ath/ath12k/core.h             |   95 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   90 +
 drivers/net/wireless/ath/ath12k/debugfs.h          |   30 +
 drivers/net/wireless/ath/ath12k/dp.c               |   90 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    5 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |    6 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  104 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    4 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    2 +-
 drivers/net/wireless/ath/ath12k/hif.h              |   14 +-
 drivers/net/wireless/ath/ath12k/htc.c              |    4 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   12 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    4 +
 drivers/net/wireless/ath/ath12k/mac.c              | 1147 +++++++--
 drivers/net/wireless/ath/ath12k/mac.h              |    4 +
 drivers/net/wireless/ath/ath12k/mhi.c              |   92 +-
 drivers/net/wireless/ath/ath12k/mhi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |    3 +-
 drivers/net/wireless/ath/ath12k/p2p.h              |    1 +
 drivers/net/wireless/ath/ath12k/pci.c              |   43 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  109 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    4 +
 drivers/net/wireless/ath/ath12k/reg.c              |   55 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  195 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   67 +-
 drivers/net/wireless/ath/ath6kl/sdio.c             |   20 +-
 drivers/net/wireless/ath/ath9k/main.c              |    3 +-
 drivers/net/wireless/ath/carl9170/tx.c             |    3 +-
 drivers/net/wireless/ath/carl9170/usb.c            |   32 +
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   21 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |   19 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |    4 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    7 -
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |    6 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    7 +
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   23 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   33 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    2 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |   42 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   17 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   88 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  325 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    7 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  201 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  138 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   92 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   57 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   85 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  319 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   86 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   24 +
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |  119 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/scan.c    |  110 +
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    7 +
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   31 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   27 +-
 drivers/net/wireless/marvell/mwl8k.c               |    2 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |    5 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    1 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   46 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |    1 +
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   10 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  |   85 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   22 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   22 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   15 +
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |   47 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  160 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    4 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    1 -
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   32 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   79 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    6 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   19 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    2 -
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |    2 -
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    7 +
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    5 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   71 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    4 +-
 drivers/net/wireless/mediatek/mt76/sdio.c          |   17 +-
 drivers/net/wireless/mediatek/mt76/testmode.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    2 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |    3 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |   16 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} |   67 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} |   45 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} |   41 +-
 drivers/net/wireless/realtek/rtl8xxxu/Makefile     |    6 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c}   |   75 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h}   |    0
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   13 +-
 drivers/net/wireless/realtek/rtlwifi/Kconfig       |    4 +
 drivers/net/wireless/realtek/rtlwifi/Makefile      |    1 +
 drivers/net/wireless/realtek/rtlwifi/cam.c         |    5 +-
 drivers/net/wireless/realtek/rtlwifi/cam.h         |    6 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h       |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192d/Makefile |   11 +
 .../realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h  |    0
 .../wireless/realtek/rtlwifi/rtl8192d/dm_common.c  | 1061 ++++++++
 .../wireless/realtek/rtlwifi/rtl8192d/dm_common.h  |   79 +
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.c  |  370 +++
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.h  |   49 +
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.c  | 1225 +++++++++
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.h  |   24 +
 .../net/wireless/realtek/rtlwifi/rtl8192d/main.c   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192d/phy_common.c |  856 +++++++
 .../wireless/realtek/rtlwifi/rtl8192d/phy_common.h |  111 +
 .../realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h  |  162 +-
 .../wireless/realtek/rtlwifi/rtl8192d/rf_common.c  |  359 +++
 .../wireless/realtek/rtlwifi/rtl8192d/rf_common.h  |   13 +
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.c |  516 ++++
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.h |  405 +++
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.c    | 1072 +-------
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.h    |   91 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.c    |  375 +--
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.h    |   37 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    | 1168 +--------
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.h    |   11 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/led.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  916 +------
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.h   |   59 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.c    |  375 +--
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.h    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |   12 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |  515 +---
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.h   |  433 ----
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   45 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   33 +-
 drivers/net/wireless/realtek/rtw88/debug.h         |    1 +
 drivers/net/wireless/realtek/rtw88/mac.c           |    5 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |   47 +
 drivers/net/wireless/realtek/rtw89/acpi.h          |   21 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |  116 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |   71 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 1004 +++++++-
 drivers/net/wireless/realtek/rtw89/coex.h          |   36 +
 drivers/net/wireless/realtek/rtw89/core.c          |   13 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  242 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  338 ++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  466 +---
 drivers/net/wireless/realtek/rtw89/mac.c           |   50 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    7 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   28 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    5 +
 drivers/net/wireless/realtek/rtw89/pci.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |    6 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |    3 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    3 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  174 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   14 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   12 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    | 2616 --------------------
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/sar.h           |    4 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  716 +++++-
 drivers/net/wireless/realtek/rtw89/wow.h           |   57 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    6 +
 include/linux/mhi.h                                |   18 +-
 include/net/cfg80211.h                             |   29 +-
 include/net/mac80211.h                             |    6 +-
 net/mac80211/cfg.c                                 |  144 +-
 net/mac80211/rx.c                                  |    7 +-
 net/qrtr/mhi.c                                     |   46 +
 net/wireless/nl80211.c                             |   24 +-
 net/wireless/sme.c                                 |    1 +
 net/wireless/trace.h                               |    6 +-
 235 files changed, 13494 insertions(+), 9702 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/scan.c
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} (90%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} (90%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} (98%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c} (98%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h} (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h (90%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h


