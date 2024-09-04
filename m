Return-Path: <linux-wireless+bounces-12491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1996C27D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582011C2143F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86C1D9D6A;
	Wed,  4 Sep 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwCxXkwi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF7323D;
	Wed,  4 Sep 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463926; cv=none; b=G/kYIYFjX+CyW/pL+qLxvfYthvw/8Tus8SJ/evQ8pLHwd9+bV3mm4G2122SiU3KaCY9nR+/csT5sV//MnFOaAG50fI+a8JIsbUaWwzRrliL6ZPhcDLA2OvBO9YU/QT1qLHw1nncQL4RzL4grfxiY0nIZQ1sez2v//ohDKvCae9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463926; c=relaxed/simple;
	bh=L5P3uyUxIfxZ7uaCavLKxbPabfoB6uLjbYLjPl/hZOQ=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=iWF42Jrr0AEmxMxdL+PqqJ/uWeuRSPf3D/jrGExcSg0Jwi+sjTncmuWMt9j645z3bM8oZqtM8TL3FoCpBMywXG09ode8gxjWMsplGa9gcZePu5Xnws936FQBW8vEuPvgRze5UzorDFuW53E561RxM4yKNOgcsTVQiT5L+aYnHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwCxXkwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C11C4CEC2;
	Wed,  4 Sep 2024 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463926;
	bh=L5P3uyUxIfxZ7uaCavLKxbPabfoB6uLjbYLjPl/hZOQ=;
	h=From:Subject:To:Cc:Date:From;
	b=mwCxXkwifFY+yUSOYF1x3FgRmRTbLZFXg0NekgQM5QRkMs5lKrxASiDS0bAJdDFUU
	 LFB1kCpctEawbbD8bgvZk6em0+7ryYBDlcp9hfxLpBVuu2cqYEF5Pw4zkUcS413pjm
	 hBsRBw7sPZ+ww19h7TZCErtiwznhtqZi66DwMoR6og2NAfLA3FkncaRkf9/XUc82ey
	 X8u0oirA8wZd1T9qwqX02VGSWjc2GCiLZtDrlUZvK8J5vgmrkix1VE+X1kjXiRFflt
	 rxRaMCWXL0FgmT3DJOVnLhVE8d7hVto9yCLKyAN1J/SmIRiucj5ZU/ENQ3tBs4UL1K
	 /EoHrWOzySy+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-09-04
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240904153205.64C11C4CEC2@smtp.kernel.org>
Date: Wed,  4 Sep 2024 15:32:05 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-09-04

for you to fetch changes up to 97b766f989bcd06e5a7651b1080001d7327012f5:

  wifi: mwifiex: Convert to use jiffies macro (2024-09-03 21:31:24 +0300)

----------------------------------------------------------------
wireless-next patches for v6.12

mwifiex has recently started to see active development which is good
news. rtw89 is also under active development and got several new
features. Otherwise not really anything out of ordinary.

We have one conflict in ath12k but that's easy to fix:

https://lore.kernel.org/all/20240808104348.6846e064@canb.auug.org.au/

Major changes:

mwifiex

* support for up to ten Authentication and Key Management (AKM) suites

* host MAC Sublayer Management Entity (MLME) client and AP mode support

* WPA-PSK-SHA256 AKM suite support

rtw88

* improve USB performance by aggregation

rtw89

* Wi-Fi 6 chip RTL8852BE-VT support

* WoWLAN net-detect support

* hardware encryption in unicast management frames support

* hardware rfkill support

ath12k

* DebugFS support for transmit DE stats

* Make ASPM support hardware-dependent

iwlwifi

* channel puncturing for US/CAN from UEFI

* bump FW API to 93 for BZ/SC devices

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: ath12k: restore ASPM for supported hardwares only

Anjaneyulu (1):
      wifi: iwlwifi: allow only CN mcc from WRDD

Arend van Spriel (1):
      wifi: brcmfmac: introducing fwil query functions

Avraham Stern (3):
      wifi: iwlwifi: mei: add support for SAP version 4
      wifi: iwlwifi: mvm: set the cipher for secured NDP ranging
      wifi: iwlwifi: mvm: increase the time between ranging measurements

Baochen Qiang (1):
      wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()

Bitterblue Smith (8):
      wifi: rtw88: Set efuse->ext_lna_5g - fix typo
      wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
      wifi: rtw88: 8822c: Fix reported RX band width
      wifi: rtw88: 8703b: Fix reported RX band width
      wifi: rtw88: usb: Init RX burst length according to USB speed
      wifi: rtw88: usb: Update the RX stats after every frame
      wifi: rtw88: usb: Support RX aggregation
      wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c

Chen Yufan (1):
      wifi: mwifiex: Convert to use jiffies macro

Chih-Kang Chang (1):
      wifi: rtw89: avoid to add interface to list twice when SER

Chin-Yen Lee (4):
      wifi: rtw89: wow: implement PS mode for net-detect
      wifi: rtw89: wow: add WoWLAN net-detect support
      wifi: rtw89: wow: add delay option for net-detect
      wifi: rtw89: wow: add net-detect support for 8852c

Christophe JAILLET (5):
      wifi: brcmfmac: fwsignal: Use struct_size() to simplify brcmf_fws_rxreorder()
      wifi: b43: Constify struct lpphy_tx_gain_table_entry
      wifi: lib80211: Handle const struct lib80211_crypto_ops in lib80211
      wifi: lib80211: Constify struct lib80211_crypto_ops
      staging: rtl8192e: Constify struct lib80211_crypto_ops

Colin Ian King (1):
      wifi: rtw89: 8852bt: rfk: Fix spelling mistake "KIP_RESOTRE" -> "KIP_RESTORE"

Dan Carpenter (1):
      wifi: mwifiex: Fix uninitialized variable in mwifiex_cfg80211_authenticate()

Daniel Gabay (2):
      wifi: iwlwifi: mvm: Offload RLC/SMPS functionality to firmware
      wifi: iwlwifi: mvm: Remove unused last_sub_index from reorder buffer

David Lin (2):
      wifi: mwifiex: add host mlme for client mode
      wifi: mwifiex: add host mlme for AP mode

Dian-Syuan Yang (1):
      wifi: rtw89: correct VHT TX rate on 20MHz connection

Dinesh Karthikeyan (1):
      wifi: ath12k: Support Transmit DE stats

Dmitry Antipov (2):
      wifi: rtw88: always wait for both firmware loading attempts
      wifi: mac80211: refactor block ack management code

Dmitry Kandybka (2):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()
      wifi: brcmsmac: clean up unnecessary current_ampdu_cnt and related checks

Emmanuel Grumbach (16):
      wifi: iwlwifi: mvm: prepare the introduction of V9 of REDUCED_TX_POWER
      wifi: iwlwifi: mvm: add support for new REDUCE_TXPOWER_CMD versions
      wifi: iwlwifi: mvm: set ul_mu_data_disable when needed
      wifi: iwlwifi: mvm: s/iwl_bt_coex_profile_notif/iwl_bt_coex_prof_old_notif
      wifi: iwlwifi: mvm: start to support the new BT profile notification
      wifi: iwlwiif: mvm: handle the new BT notif
      wifi: iwlwifi: mvm: add firmware debug points for EMLSR entry / exit
      wifi: mac80211: fix the comeback long retry times
      wifi: iwlwifi: mvm: rename iwl_missed_beacons_notif
      wifi: iwlwifi: mvm: add the new API for the missed beacons notification
      wifi: iwlwifi: mvm: handle the new missed beacons notification
      wifi: iwlwifi: mvm: exit EMLSR if both links are missing beacons
      wifi: iwlwifi: mvm: add API for EML OMN frame failure
      wifi: iwlwifi: mvm: handle the new EML OMN failure notification
      wifi: iwlwifi: mvm: allow ESR when we the ROC expires
      wifi: iwlwifi: mvm: tell the firmware about CSA with mode=1

Frank Li (1):
      dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format

Gustavo A. R. Silva (3):
      wifi: ipw2x00: libipw: Avoid -Wflex-array-member-not-at-end warnings
      wifi: mwl8k: Use static_assert() to check struct sizes
      wifi: iwlegacy: Avoid multiple -Wflex-array-member-not-at-end warnings

Hans de Goede (1):
      net: rfkill: gpio: Do not load on Lenovo Yoga Tab 3 Pro YT3-X90

Heiner Kallweit (1):
      wifi: ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader

Ilan Peer (3):
      wifi: iwlwifi: mvm: Fix a race in scan abort flow
      wifi: iwlwifi: mvm: Stop processing MCC update if there was no change
      wifi: mac80211: Check for missing VHT elements only for 5 GHz

Issam Hamdi (1):
      wifi: cfg80211: Set correct chandef when starting CAC

Jinjie Ruan (1):
      wifi: brcmsmac: Use kvmemdup to simplify the code

Johannes Berg (6):
      wifi: iwlwifi: mvm: use correct key iteration
      wifi: iwlwifi: pcie: print function scratch before writing
      wifi: iwlwifi: config: label 'gl' devices as discrete
      wifi: iwlwifi: mvm: drop wrong STA selection in TX
      wifi: mac80211: fix RCU list iterations
      wifi: iwlwifi: mvm: refactor scan channel description a bit

Kalle Valo (2):
      Merge tag 'rtw-next-2024-08-09' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Kang Yang (1):
      wifi: ath11k: use work queue to process beacon tx event

Karthikeyan Periyasamy (2):
      wifi: ath12k: fix array out-of-bound access in SoC stats
      wifi: ath11k: fix array out-of-bound access in SoC stats

Kuan-Chung Chen (4):
      wifi: rtw89: add EVM statistics for 1SS rate
      wifi: rtw89: add support for hardware rfkill
      wifi: rtw89: 8922a: new implementation for RFK pre-notify H2C
      wifi: rtw89: add support for HW encryption in unicast management frames

Marek Vasut (2):
      wifi: wilc1000: Do not operate uninitialized hardware during suspend/resume
      wifi: wilc1000: Re-enable RTC clock on resume

Miri Korenblit (11):
      wifi: iwlwifi: remove MVM prefix from FW macros
      wifi: iwlwifi: mvm: add and improve EMLSR debug info
      wifi: iwlwifi: use default command queue watchdog timeout
      wifi: iwlwifi: mvm: cleanup iwl_mvm_get_wd_timeout
      wifi: iwlwifi: bump FW API to 93 for BZ/SC devices
      wifi: iwlwifi: mvm: avoid NULL pointer dereference
      wifi: iwlwifi: s/IWL_MVM_STATION_COUNT_MAX/IWL_STATION_COUNT_MAX
      wifi: iwlwifi: STA command structure shouldn't be mvm specific
      wifi: iwlwifi: s/iwl_mvm_remove_sta_cmd/iwl_remove_sta_cmd
      wifi: iwlwifi: mvm: remove mvm prefix from iwl_mvm_tx_resp*
      wifi: iwlwifi: mvm: properly set the rates in link cmd

Nick Morrow (1):
      wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c

P Praneesh (2):
      wifi: ath12k: fix BSS chan info request WMI command
      wifi: ath12k: match WMI BSS chan info structure with firmware definition

Peter Robinson (2):
      wifi: rtl8xxxu: drop reference to staging drivers
      wifi: rtl8xxxu: add missing rtl8192cu USB IDs

Ping-Ke Shih (12):
      wifi: rtw88: debugfs: support multiple adapters debugging
      wifi: rtw89: 8852bt: add set_channel_rf
      wifi: rtw89: 8852bt: rfk: use predefined string choice for DPK enable/disable
      wifi: rtw89: 8852bt: add chip_info of RTL8852BT
      wifi: rtw89: 8852bt: add chip_ops of RTL8852BT
      wifi: rtw89: 8852bt: declare firmware features of RTL8852BT
      wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
      wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
      wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware failure
      wifi: rtw89: 8852c: support firmware format up to v1
      wifi: mac80211: don't use rate mask for offchannel TX either
      wifi: mac80211: export ieee80211_purge_tx_queue() for drivers

Po-Hao Huang (2):
      wifi: rtw88: 8822c: Parse channel from IE to correct invalid hardware reports
      wifi: rtw89: 8922a: Add new fields for scan offload H2C command

Rory Little (1):
      wifi: mac80211: Add non-atomic station iterator

Rosen Penev (2):
      wifi: ath9k: use devm for request_irq()
      wifi: ath9k: use devm for gpio_request_one()

Sascha Hauer (6):
      wifi: mwifiex: increase max_num_akm_suites
      wifi: mwifiex: simplify WPA flags setting
      wifi: mwifiex: fix key_mgmt setting
      wifi: mwifiex: add support for WPA-PSK-SHA256
      wifi: mwifiex: keep mwifiex_cfg80211_ops constant
      wifi: mwifiex: remove unnecessary checks for valid priv

Shen Lichuan (1):
      wifi: mac80211: use kmemdup_array instead of kmemdup for multiple allocation

Simon Horman (1):
      wifi: cfg80211: wext: Update spelling and grammar

Somashekhar(Som) (1):
      wifi: iwlwifi: Enable channel puncturing for US/CAN from bios

Thorsten Blum (1):
      wifi: ath9k: Use swap() to improve ath9k_hw_get_nf_hist_mid()

Toke Høiland-Jørgensen (2):
      wifi: ath9k: Remove error checks when creating debugfs entries
      Revert "wifi: ath9k: use devm for request_irq()"

Yan Zhen (1):
      wifi: mac80211: scan: Use max macro

Yu Jiaoliang (1):
      wifi: cfg80211: Use kmemdup_array instead of kmemdup for multiple allocation

Zhang Changzhong (1):
      wifi: mac80211: remove redundant unlikely() around IS_ERR()

Zijun Hu (1):
      wifi: rfkill: Correct parameter type for rfkill_set_hw_state_reason()

Zong-Zhe Yang (11):
      wifi: rtw88: select WANT_DEV_COREDUMP
      wifi: rtw89: select WANT_DEV_COREDUMP
      wifi: rtw89: fix typo of rtw89_phy_ra_updata_XXX
      wifi: rtw89: chan: refine MCC re-plan flow when unassign chanctx
      wifi: rtw89: mcc: stop at a role holding chanctx
      wifi: rtw89: rename sub_entity to chanctx
      wifi: rtw89: pass rtwvif to RFK channel
      wifi: rtw89: pass rtwvif to RFK scan
      wifi: rtw89: fw: correct chan access in assoc_cmac_tbl_g7 and update_beacon_be
      wifi: rtw89: pass chanctx_idx to rtw89_btc_{path_}phymap()
      wifi: mac80211_hwsim: correct MODULE_PARM_DESC of multi_radio

hhorace (1):
      wifi: cfg80211: fix bug of mapping AF3x to incorrect User Priority

 .../bindings/net/wireless/marvell,sd8787.yaml      |  93 +++
 .../bindings/net/wireless/marvell-8xxx.txt         |  70 --
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  12 +
 drivers/net/wireless/ath/ath11k/wmi.c              |   4 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 354 +++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    | 126 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   6 +
 drivers/net/wireless/ath/ath12k/hw.h               |   1 +
 drivers/net/wireless/ath/ath12k/mac.c              |   5 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   3 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   1 +
 drivers/net/wireless/ath/ath12k/wmi.h              |   3 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |   8 +-
 drivers/net/wireless/ath/ath9k/calib.c             |   7 +-
 drivers/net/wireless/ath/ath9k/debug.c             |   6 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 -
 drivers/net/wireless/ath/ath9k/hw.c                |   6 +-
 drivers/net/wireless/broadcom/b43/tables_lpphy.c   |  20 +-
 drivers/net/wireless/broadcom/b43/tables_lpphy.h   |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  30 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |   4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    |  40 +-
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         |   8 +-
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |  22 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   6 +-
 drivers/net/wireless/intel/ipw2x00/libipw.h        |  46 +-
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c     |   2 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |   2 +-
 drivers/net/wireless/intel/iwlegacy/3945.h         |   6 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |   2 +-
 drivers/net/wireless/intel/iwlegacy/commands.h     | 273 +++----
 drivers/net/wireless/intel/iwlegacy/common.h       |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  13 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   2 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |  29 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |  13 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   4 +
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  87 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |  79 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |  46 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |  14 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |  12 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  16 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  31 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |  30 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   2 -
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   |  10 +
 drivers/net/wireless/intel/iwlwifi/mei/main.c      |  58 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |  83 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  93 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  69 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  42 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  83 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  54 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  64 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   4 +-
 drivers/net/wireless/marvell/mwifiex/11n.c         |   2 -
 drivers/net/wireless/marvell/mwifiex/11n.h         |   4 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  23 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 420 +++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |  29 +-
 drivers/net/wireless/marvell/mwifiex/decl.h        |  23 +
 drivers/net/wireless/marvell/mwifiex/fw.h          |  55 ++
 drivers/net/wireless/marvell/mwifiex/init.c        |  73 +-
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |   5 +
 drivers/net/wireless/marvell/mwifiex/join.c        |  69 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |  76 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |  49 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   8 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h        |   2 +
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c |   2 +
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |  36 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |   5 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c      |   9 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |   4 +-
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     | 202 ++++-
 drivers/net/wireless/marvell/mwifiex/usb.c         |   7 +-
 drivers/net/wireless/marvell/mwifiex/util.c        | 104 +++
 drivers/net/wireless/marvell/mwifiex/wmm.c         |   7 -
 drivers/net/wireless/marvell/mwl8k.c               |   3 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     |  10 +
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig      |   5 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   6 +
 drivers/net/wireless/realtek/rtw88/Kconfig         |   1 +
 drivers/net/wireless/realtek/rtw88/debug.c         | 303 ++++----
 drivers/net/wireless/realtek/rtw88/debug.h         |   3 +
 drivers/net/wireless/realtek/rtw88/hci.h           |   7 +
 drivers/net/wireless/realtek/rtw88/main.c          |  23 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   6 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |  17 +
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |   2 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |   4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |  20 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h      |  24 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |  41 +
 drivers/net/wireless/realtek/rtw88/rx.h            |  15 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   2 +
 drivers/net/wireless/realtek/rtw88/usb.c           | 209 ++++-
 drivers/net/wireless/realtek/rtw89/Kconfig         |  16 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   8 +
 drivers/net/wireless/realtek/rtw89/cam.c           |  12 +-
 drivers/net/wireless/realtek/rtw89/chan.c          | 186 +++--
 drivers/net/wireless/realtek/rtw89/chan.h          |   6 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |   2 +-
 drivers/net/wireless/realtek/rtw89/coex.h          |  12 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 207 +++--
 drivers/net/wireless/realtek/rtw89/core.h          |  75 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   7 +-
 drivers/net/wireless/realtek/rtw89/fw.c            | 446 +++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h            |  94 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  25 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |  11 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  35 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  25 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   2 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  82 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  27 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  36 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  23 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |  50 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  21 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |  50 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     | 843 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852bt.h     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 274 ++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |  93 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  31 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  42 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  29 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   8 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   2 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   8 +-
 drivers/net/wireless/realtek/rtw89/util.h          |  18 +
 drivers/net/wireless/realtek/rtw89/wow.c           | 349 +++++++--
 drivers/net/wireless/realtek/rtw89/wow.h           |  23 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   2 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |   2 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |   2 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |   2 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |   2 +-
 include/linux/rfkill.h                             |   5 +-
 include/net/iw_handler.h                           |  12 +-
 include/net/lib80211.h                             |   8 +-
 include/net/mac80211.h                             |  40 +-
 net/mac80211/agg-rx.c                              |  15 +-
 net/mac80211/agg-tx.c                              |  15 +-
 net/mac80211/chan.c                                |   4 +-
 net/mac80211/ht.c                                  |  15 +-
 net/mac80211/ieee80211_i.h                         |  25 +-
 net/mac80211/main.c                                |   6 +-
 net/mac80211/mesh_pathtbl.c                        |   2 +-
 net/mac80211/mlme.c                                |  32 +-
 net/mac80211/offchannel.c                          |   1 +
 net/mac80211/rate.c                                |   2 +-
 net/mac80211/scan.c                                |  10 +-
 net/mac80211/status.c                              |   1 +
 net/mac80211/tx.c                                  |   2 +-
 net/mac80211/util.c                                |  20 +-
 net/rfkill/core.c                                  |   8 +-
 net/rfkill/rfkill-gpio.c                           |  18 +
 net/wireless/lib80211.c                            |  10 +-
 net/wireless/lib80211_crypt_ccmp.c                 |   2 +-
 net/wireless/lib80211_crypt_tkip.c                 |   2 +-
 net/wireless/lib80211_crypt_wep.c                  |   2 +-
 net/wireless/nl80211.c                             |  15 +-
 net/wireless/util.c                                |  14 +-
 202 files changed, 6213 insertions(+), 1568 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bte.c


