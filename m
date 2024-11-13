Return-Path: <linux-wireless+bounces-15279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE069C7A70
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA32B23C5E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744F1F80BB;
	Wed, 13 Nov 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyZQrf3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85B15444E;
	Wed, 13 Nov 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518959; cv=none; b=BiWKUaBf1kxXeOQyCsCs/TylPuCFNw3Nu9WufTEvXojveSm3ZK4wi1WiTJTlQHtNM6gmqEzNWhJchkmwCyCxcTq6EYR6cilW7yxhSmvcpWFU04NenmLqNq9s+V9YqnQGMr7HLKrV/ib/1hE9xHwfm8u93emn9kl7MN/YYCP0lzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518959; c=relaxed/simple;
	bh=iwu5n1YXJ/bMLCitGj7M8NYO1FpWtyBhVxyox77B88A=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=dBfdx0B2GYGOBzWR9fDAJSnFLFsdTTvUUSk/yJYvgerHd8pUYR4SkKIpHxnTYE4bKxXRgNppnaKVhdt+6wC+C0n/E89JsHP9p0KNczPuCfle28BRX7UbJwF98MuYTR5O2hVwVFfTsspNKYQ5cQ0F2TOccjMCrFTB7ouAZAe6IIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyZQrf3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A11C4CEC3;
	Wed, 13 Nov 2024 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731518959;
	bh=iwu5n1YXJ/bMLCitGj7M8NYO1FpWtyBhVxyox77B88A=;
	h=From:Subject:To:Cc:Date:From;
	b=KyZQrf3DGtCUexXI8ydujKrCFPc8JxEVN/82SHucxEhCusVdw3oYuxqGAtcwQjwCn
	 7W7eQGpRBQ6yuua/4L1WsfQJ/L8zO/ccjG7lW8e3bktG2NeFMFLn0xSQSs/SpaynYB
	 VhZGE5lNW3m07KV8a+lpkwnaBsHWRFoem7bXf7ZHPX0/jC08gfDwXXWwo3N2Q650TQ
	 iCeZQ7NX1KIcnyOtnbQnNgrdk2VYqyACxdCK5Xx9AOg9Ozi+yDVb/mI8exYXkTUtSq
	 DgEEjT+HV/z6022QKZR2Wl/ujmlrP/0SPe0GqeDAIN/gLLm9HL4hkTVlL9pdV1h2bB
	 Y//v/QckqZCSg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-11-13
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20241113172918.A8A11C4CEC3@smtp.kernel.org>
Date: Wed, 13 Nov 2024 17:29:18 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 2b1d193a5a57ed4becbfebb889aa1bf5ad53f246:

  Documentation: networking: Add missing PHY_GET command in the message list (2024-10-29 20:31:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-11-13

for you to fetch changes up to 11597043d74809daf5d14256b96d6781749b3f82:

  Revert "wifi: iwlegacy: do not skip frames with bad FCS" (2024-11-12 20:24:45 +0200)

----------------------------------------------------------------
wireless-next patches for v6.13

Most likely the last -next pull request for v6.13. Most changes are in
Realtek and Qualcomm drivers, otherwise not really anything
noteworthy.

Major changes:

mac80211

* EHT 1024 aggregation size for transmissions

ath12k

* switch to using wiphy_lock() and remove ar->conf_mutex

* firmware coredump collection support

* add debugfs support for a multitude of statistics

ath11k

* dt: document WCN6855 hardware inputs

ath9k

* remove include/linux/ath9k_platform.h

ath5k

* Arcadyan ARV45XX AR2417 & Gigaset SX76[23] AR241[34]A support

rtw88:

* 8821au and 8812au USB adapters support

rtw89

* thermal protection

* firmware secure boot for WiFi 6 chip

----------------------------------------------------------------
Aleksei Vetrov (1):
      wifi: nl80211: fix bounds checker error in nl80211_parse_sched_scan

Andrew Kreimer (2):
      wifi: wcn36xx: fix a typo in struct wcn36xx_sta documentation
      wifi: ath6kl: fix typos in struct wmi_rssi_threshold_params_cmd and wmi_snr_threshold_params_cmd comments

Arnd Bergmann (2):
      wifi: ath12k: fix one more memcpy size error
      wifi: rtw89: fix -Wenum-compare-conditional warnings

Avraham Stern (1):
      wifi: iwlwifi: mvm: support new initiator and responder command version

Balaji Pothunoori (2):
      wifi: ath11k: enable fw_wmi_diag_event hw param for WCN6750
      wifi: ath11k: Fix CE offset address calculation for WCN6750 in SSR

Baochen Qiang (2):
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2

Bartosz Golaszewski (1):
      dt-bindings: net: ath11k: document the inputs of the ath11k on WCN6855

Bitterblue Smith (23):
      wifi: rtw88: Report the signal strength only if it's known
      wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
      wifi: rtw88: Dump the HW features only for some chips
      wifi: rtw88: Allow different C2H RA report sizes
      wifi: rtw88: Extend the init table parsing for RTL8812AU
      wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
      wifi: rtw88: Let each driver control the power on/off process
      wifi: rtw88: Enable data rate fallback for older chips
      wifi: rtw88: Make txagc_remnant_ofdm an array
      wifi: rtw88: Support TX page sizes bigger than 128
      wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
      wifi: rtw88: usb: Set pkt_info.ls for the reserved page
      wifi: rtw88: Detect beacon loss with chips other than 8822c
      wifi: rtw88: coex: Support chips without a scoreboard
      wifi: rtw88: 8821a: Regularly ask for BT info updates
      wifi: rtw88: 8812a: Mitigate beacon loss
      wifi: rtw88: Add rtw8812a_table.{c,h}
      wifi: rtw88: Add rtw8821a_table.{c,h}
      wifi: rtw88: Add rtw88xxa.{c,h}
      wifi: rtw88: Add rtw8821a.{c,h}
      wifi: rtw88: Add rtw8812a.{c,h}
      wifi: rtw88: Add rtw8821au.c and rtw8812au.c
      wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

Caleb Connolly (1):
      wifi: ath11k: allow missing memory-regions

Chih-Kang Chang (2):
      wifi: rtw89: set pause_data field to avoid transmitting data in scan channels
      wifi: rtw89: 8852b: change RF mode to normal mode when set channel

Chin-Yen Lee (1):
      wifi: rtw89: don't check done-ack for entering PS

Ching-Te Ku (2):
      wifi: rtw89: coex: Set Wi-Fi/Bluetooth priority for Wi-Fi scan case
      wifi: rtw89: coex: set higher priority to BT when WL scan and BT A2DP exist

Christophe JAILLET (1):
      wifi: cfg80211: Fix an error handling path in nl80211_start_ap()

Colin Ian King (1):
      wifi: ath12k: make read-only array svc_id static const

Dan Carpenter (1):
      wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()

Dinesh Karthikeyan (5):
      wifi: ath12k: Support Self-Generated Transmit stats
      wifi: ath12k: Support Ring and SFM stats
      wifi: ath12k: Support pdev Transmit Multi-user stats
      wifi: ath12k: Support pdev CCA Stats
      wifi: ath12k: Support Pdev OBSS Stats

Dr. David Alan Gilbert (2):
      wifi: brcm80211: Remove unused dma_txflush()
      wifi: rtlwifi: Remove some exhalbtc deadcode

Emmanuel Grumbach (6):
      wifi: iwlwifi: mvm: support new versions of the wowlan APIs
      wifi: iwlwifi: mvm: MLO scan upon channel condition degradation
      wifi: iwlwifi: allow fast resume on ax200
      wifi: iwlwifi: mvm: tell iwlmei when we finished suspending
      wifi: iwlwifi: be less noisy if the NIC is dead in S3
      wifi: iwlwifi: mvm: don't call power_update_mac in fast suspend

Guilherme G. Piccoli (1):
      wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures

Javier Carrasco (1):
      wifi: brcmfmac: release 'root' node in all execution paths

Jeongjun Park (1):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()

Jiapeng Chong (1):
      wifi: ipw2x00: libipw_rx_any(): fix bad alignment

Johannes Berg (5):
      wifi: iwlwifi: mvm: clarify fw_id_to_link_sta protection
      wifi: iwlwifi: mvm: unify link info initialization
      wifi: iwlwifi: mvm: allow always calling iwl_mvm_get_bss_vif()
      wifi: iwlwifi: mvm: use wiphy locked debugfs for low-latency
      wifi: mac80211: pass MBSSID config by reference

Jose Ignacio Tornos Martinez (2):
      wifi: ath12k: fix crash when unbinding
      wifi: ath12k: fix warning when unbinding

Kalle Valo (10):
      wifi: ath12k: fix atomic calls in ath12k_mac_op_set_bitrate_mask()
      wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
      wifi: ath12k: switch to using wiphy_lock() and remove ar->conf_mutex
      wifi: ath12k: cleanup unneeded labels
      wifi: ath12k: ath12k_mac_set_key(): remove exit label
      wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk cancellation
      wifi: ath12k: add missing lockdep_assert_wiphy() for ath12k_mac_op_ functions
      Merge tag 'ath-next-20241030' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2024-11-06' of https://github.com/pkshih/rtw
      Revert "wifi: iwlegacy: do not skip frames with bad FCS"

Kang Yang (9):
      wifi: ath10k: avoid NULL pointer error during sdio remove
      wifi: ath12k: remove unused variable monitor_present
      wifi: ath12k: fix struct hal_rx_ppdu_end_user_stats
      wifi: ath12k: fix struct hal_rx_ppdu_start
      wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
      wifi: ath12k: fix struct hal_rx_mpdu_start
      wifi: ath12k: delete NSS and TX power setting for monitor vdev
      wifi: ath12k: use tail MSDU to get MSDU information
      wifi: ath12k: fix A-MSDU indication in monitor mode

Kuan-Chung Chen (1):
      wifi: rtw89: 8922a: fill the missing OP1dB configuration

Li Zetao (1):
      wifi: ath9k: use clamp() in ar9003_aic_cal_post_process()

Lingbo Kong (2):
      wifi: ath12k: remove msdu_end structure for WCN7850
      wifi: cfg80211: Remove the Medium Synchronization Delay validity check

Linus Walleij (1):
      wifi: cw1200: Fix potential NULL dereference

Manikanta Pubbisetty (1):
      wifi: ath11k: Fix double free issue during SRNG deinit

MeiChia Chiu (1):
      wifi: mac80211: Support EHT 1024 aggregation size in TX

Miaoqing Pan (3):
      wifi: ath10k: fix the stack frame size warning in ath10k_remain_on_channel
      wifi: ath10k: fix the stack frame size warning in ath10k_hw_scan
      wifi: ath11k: fix the stack frame size warning in ath11k_vif_wow_set_wakeups

Mingwei Zheng (1):
      net: rfkill: gpio: Add check for clk_enable()

Miri Korenblit (3):
      wifi: iwlwifi: move IWL_LMAC_*_INDEX to fw/api/context.h
      wifi: iwlwifi: bump minimum API version in BZ/SC to 92
      wifi: iwlwifi: s/IWL_MVM_INVALID_STA/IWL_INVALID_STA

Mohammed Anees (1):
      wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate

Nicolas Escande (1):
      wifi: ath12k: move txbaddr/rxbaddr into struct ath12k_dp

Norbert van Bolhuis (1):
      wifi: brcmfmac: Fix oops due to NULL pointer dereference in brcmf_sdiod_sglist_rw()

Pei Xiao (1):
      wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()

Ping-Ke Shih (18):
      wifi: rtw89: wow: cast nd_config->delay to u64 in tsf arithmetic
      wifi: rtw89: pci: use 'int' as return type of error code in poll_{tx,rx}dma_ch_idle()
      wifi: rtw89: 8851b: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852b: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852bt: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852c: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: sar: add supported UNII-4 frequency range along with UNII-3 of SAR subband
      wifi: rtw89: add thermal protection
      wifi: rtw89: pci: add quirks by PCI subsystem ID for thermal protection
      wifi: rtlwifi: use MODULE_FIRMWARE() to declare used firmware
      wifi: rtw89: efuse: move reading efuse of fw secure info to common
      wifi: rtw89: efuse: move recognize firmware MSS info v1 to common
      wifi: rtw89: efuse: read firmware secure info v0 from efuse for WiFi 6 chips
      wifi: rtw89: fw: shrink download size of security section for RTL8852B
      wifi: rtw89: fw: set recorded IDMEM share mode in firmware header to register
      wifi: rtw89: fw: move v1 MSSC out of __parse_security_section() to share with v0
      wifi: rtw89: fw: use common function to parse security section for WiFi 6 chips
      wifi: rtw89: mac: no configure CMAC/DMAC tables for firmware secure boot

Po-Hao Huang (3):
      wifi: rtw89: Fix TX fail with A2DP after scanning
      wifi: rtw89: Add header conversion for MLO connections
      wifi: rtw89: Add encryption support for MLO connections

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: Support BE OFDMA Pdev Rate Stats

Raj Kumar Bhagat (1):
      wifi: ath12k: convert tasklet to BH workqueue for CE interrupts

Rajat Soni (1):
      wifi: ath12k: Support DMAC Reset Stats

Rameshkumar Sundaram (5):
      wifi: ath12k: fix use-after-free in ath12k_dp_cc_cleanup()
      wifi: ath12k: prepare vif config caching for MLO
      wifi: ath12k: modify ath12k_mac_vif_chan() for MLO
      wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
      wifi: ath12k: modify ath12k_mac_op_set_key() for MLO

Ramya Gnanasekar (1):
      wifi: ath12k: Skip Rx TID cleanup for self peer

Roopni Devanathan (1):
      wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics

Rosen Penev (5):
      wifi: ath9k: eeprom: remove platform data
      wifi: ath9k: btcoex: remove platform_data
      wifi: ath9k: remove ath9k_platform_data
      wifi: ath5k: add PCI ID for SX76X
      wifi: ath5k: add PCI ID for Arcadyan devices

Sidhanta Sahu (1):
      wifi: ath12k: Support Pdev Scheduled Algorithm Stats

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: Add firmware coredump collection support

Sriram R (7):
      wifi: ath12k: prepare vif data structure for MLO handling
      wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
      wifi: ath12k: prepare sta data structure for MLO handling
      wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
      wifi: ath12k: update ath12k_mac_op_conf_tx() for MLO
      wifi: ath12k: update ath12k_mac_op_update_vif_offload() for MLO
      wifi: ath12k: modify link arvif creation and removal for MLO

Uwe Kleine-König (1):
      wifi: Switch back to struct platform_driver::remove()

Yuan Can (1):
      wifi: wfx: Fix error handling in wfx_core_init()

Zong-Zhe Yang (5):
      wifi: rtw89: regd: block 6 GHz if marked as N/A in regd map
      wifi: rtw89: chan: manage active interfaces
      wifi: rtw89: tweak setting of channel and TX power for MLO
      wifi: rtw89: 8922a: extend RFK handling and consider MLO
      wifi: mac80211: fix description of ieee80211_set_active_links() for new sequence

 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   29 +
 drivers/net/wireless/ath/ath10k/ahb.c              |    8 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   98 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |    6 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    6 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   20 +-
 drivers/net/wireless/ath/ath11k/core.c             |    2 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    1 +
 drivers/net/wireless/ath/ath11k/qmi.c              |    3 +
 drivers/net/wireless/ath/ath11k/wow.c              |   39 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |   10 +
 drivers/net/wireless/ath/ath12k/Makefile           |    1 +
 drivers/net/wireless/ath/ath12k/ce.h               |    2 +-
 drivers/net/wireless/ath/ath12k/core.c             |    9 +-
 drivers/net/wireless/ath/ath12k/core.h             |  110 +-
 drivers/net/wireless/ath/ath12k/coredump.c         |   51 +
 drivers/net/wireless/ath/ath12k/coredump.h         |   80 +
 drivers/net/wireless/ath/ath12k/debugfs.c          |    4 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 1358 +++++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  444 +++-
 drivers/net/wireless/ath/ath12k/dp.c               |   58 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    7 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  120 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   16 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    9 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    2 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   12 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   53 +-
 drivers/net/wireless/ath/ath12k/hif.h              |    6 +
 drivers/net/wireless/ath/ath12k/hw.c               |    4 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1847 ++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h              |   11 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |    5 +
 drivers/net/wireless/ath/ath12k/mhi.h              |    2 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |   17 +-
 drivers/net/wireless/ath/ath12k/p2p.h              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |  200 +-
 drivers/net/wireless/ath/ath12k/peer.c             |   13 +-
 drivers/net/wireless/ath/ath12k/peer.h             |    4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |   88 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   30 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    8 +-
 drivers/net/wireless/ath/ath12k/wow.c              |   87 +-
 drivers/net/wireless/ath/ath5k/ahb.c               |    8 +-
 drivers/net/wireless/ath/ath5k/pci.c               |    2 +
 drivers/net/wireless/ath/ath6kl/wmi.h              |    8 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |   10 +-
 drivers/net/wireless/ath/ath9k/ar9003_aic.c        |   10 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |    1 -
 drivers/net/wireless/ath/ath9k/btcoex.c            |   16 +-
 drivers/net/wireless/ath/ath9k/eeprom.c            |   12 -
 drivers/net/wireless/ath/ath9k/htc_hst.c           |    3 +
 drivers/net/wireless/ath/ath9k/hw.c                |    2 +-
 drivers/net/wireless/ath/ath9k/init.c              |   52 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    8 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h         |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |    3 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    9 -
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.h |    1 -
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |    8 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/binding.h    |    2 -
 .../net/wireless/intel/iwlwifi/fw/api/context.h    |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |   69 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |   30 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  145 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   66 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    6 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   11 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/offloading.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   52 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    2 +-
 .../realtek/rtlwifi/btcoexist/halbtc8723b1ant.c    |   11 -
 .../realtek/rtlwifi/btcoexist/halbtc8723b1ant.h    |    1 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c       |   79 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h       |   10 -
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |   11 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    3 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    3 +
 drivers/net/wireless/realtek/rtw88/Kconfig         |   33 +
 drivers/net/wireless/realtek/rtw88/Makefile        |   15 +
 drivers/net/wireless/realtek/rtw88/coex.c          |   37 +-
 drivers/net/wireless/realtek/rtw88/coex.h          |   11 +
 drivers/net/wireless/realtek/rtw88/debug.c         |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   44 +-
 drivers/net/wireless/realtek/rtw88/fw.h            |   17 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   13 +-
 drivers/net/wireless/realtek/rtw88/mac.h           |    3 +
 drivers/net/wireless/realtek/rtw88/main.c          |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   39 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |   82 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |  174 ++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      | 1102 ++++++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.h      |   10 +
 .../net/wireless/realtek/rtw88/rtw8812a_table.c    | 2812 ++++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8812a_table.h    |   26 +
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      | 1197 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.h      |   10 +
 .../net/wireless/realtek/rtw88/rtw8821a_table.c    | 2350 ++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8821a_table.h    |   21 +
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   22 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |   24 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   20 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |   12 -
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   28 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c      | 1989 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h      |  175 ++
 drivers/net/wireless/realtek/rtw88/rx.c            |   12 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    2 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |    4 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    5 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   51 +
 drivers/net/wireless/realtek/rtw89/cam.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  183 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    8 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   10 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  190 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   62 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   10 +-
 drivers/net/wireless/realtek/rtw89/efuse.c         |  150 ++
 drivers/net/wireless/realtek/rtw89/efuse.h         |    2 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |   52 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  190 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   23 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   40 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   13 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    2 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   37 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   15 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   34 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    2 +
 drivers/net/wireless/realtek/rtw89/regd.c          |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    5 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   88 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   61 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    8 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    6 +-
 drivers/net/wireless/silabs/wfx/main.c             |   17 +-
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |    2 +-
 drivers/net/wireless/ti/wl12xx/main.c              |    2 +-
 drivers/net/wireless/ti/wl18xx/main.c              |    4 +-
 include/linux/ath9k_platform.h                     |   51 -
 include/linux/ieee80211.h                          |    2 +
 include/net/mac80211.h                             |    2 +-
 net/mac80211/agg-rx.c                              |   94 +-
 net/mac80211/agg-tx.c                              |   31 +-
 net/mac80211/cfg.c                                 |   12 +-
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ieee80211_i.h                         |    9 +-
 net/rfkill/rfkill-gpio.c                           |    8 +-
 net/wireless/mlme.c                                |    6 -
 net/wireless/nl80211.c                             |    9 +-
 199 files changed, 15731 insertions(+), 2012 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath12k/coredump.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.h
 delete mode 100644 include/linux/ath9k_platform.h


