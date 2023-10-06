Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF67BBADF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjJFOxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Oct 2023 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjJFOxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Oct 2023 10:53:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618668F
        for <linux-wireless@vger.kernel.org>; Fri,  6 Oct 2023 07:53:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2421CC433C7;
        Fri,  6 Oct 2023 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696603991;
        bh=Ky5tkYYhujIRCMUt26ICSFc1zteeYjvke2LYDb6fDlo=;
        h=From:To:Cc:Subject:Date:From;
        b=JhhMdoboSTG2EFKQPZobZG5/DT64DJpeCkAnJvQ4jScXgeOOxewIT2sgBiw4q/P3P
         7uMj97pQDXENVVhbqGGfi8F2vBSgJAHay+6QWD7kuQV45T2Cx71BOyan6nK4SOXxUd
         gZNG8tjDP7qxryT1I702szgAXxJ0jU8TCwgtZIFaQllIpxTCt7laST0lJf8wCC5Hge
         YQErDJ2PV6ImmR/+sS7lnW6AgPYVX8sg1jvjmMOZ//dclsMI99rgzwyivdtdm/VJ63
         yGGu0Cw7FZ/+tI13FzVKsbJpQ3HYLGyC1NpRed+xKQdIqHpcHythOUrg6xauFwN6Q6
         6x8F1rkuz+lnA==
From:   Kalle Valo <kvalo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: wireless-next-2023-10-06
Date:   Fri, 06 Oct 2023 17:53:07 +0300
Message-ID: <87jzrz6bvw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

here's a pull request to net-next tree, more info below. Please let me know=
 if
there are any problems.

Kalle

The following changes since commit 22061bfc57fe08c77141dc876b4af75603c4d61d:

  wifi: iwlwifi: mvm: Fix incorrect usage of scan API (2023-09-27 11:46:30 =
+0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git =
tags/wireless-next-2023-10-06

for you to fetch changes up to 7d6904bf26b96ef087514cb7a8c50b62a4911c99:

  Merge wireless into wireless-next (2023-10-06 17:08:47 +0300)

----------------------------------------------------------------
wireless-next patches for v6.7

The first pull request for v6.7, with both stack and driver changes.
We have a big change how locking is handled in cfg80211 and mac80211
which removes several locks and hopefully simplifies the locking
overall. In drivers rtw89 got MCC support and smaller features to
other active drivers but nothing out of ordinary.

This pull request got delayed because we were waiting for the wireless
tree pull requested processed first and after that we merged wireless
into wireless-next to avoid several conflicts in the stack.

When pulling this there's one conflict in drivers/staging/rtl8723bs/os_dep/=
ioctl_cfg80211.c:

<<<<<<< HEAD
static int cfg80211_rtw_change_beacon(struct wiphy *wiphy,
				      struct net_device *ndev,
				      struct cfg80211_beacon_data *info)
=3D=3D=3D=3D=3D=3D=3D
static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_devic=
e *ndev,
		struct cfg80211_ap_update *info)
>>>>>>> origin/merge-wireless-2023-10-05

Take the latter hunk which uses struct cfg80211_ap_update.

Major changes:

cfg80211

* remove wdev mutex, use the wiphy mutex instead

* annotate iftype_data pointer with sparse

* first kunit tests, for element defrag

* remove unused scan_width support

mac80211

* major locking rework, remove several locks like sta_mtx, key_mtx
  etc. and use the wiphy mutex instead

* remove unused shifted rate support

* support antenna control in frame injection (requires driver support)

* convert RX_DROP_UNUSABLE to more detailed reason codes

rtw89

* TDMA-based multi-channel concurrency (MCC) support

iwlwifi

* support set_antenna() operation

* support frame injection antenna control

ath12k

* WCN7850: enable 320 MHz channels in 6 GHz band

* WCN7850: hardware rfkill support

* WCN7850: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS to make scan faster

ath11k

* add chip id board name while searching board-2.bin

----------------------------------------------------------------
Abhishek Kumar (1):
      wifi: cfg80211: call reg_call_notifier on beacon hints

Aditya Kumar Singh (1):
      wifi: cfg80211: export DFS CAC time and usable state helper functions

Aloka Dixit (6):
      wifi: nl80211: fixes to FILS discovery updates
      wifi: mac80211: fixes in FILS discovery updates
      wifi: cfg80211: modify prototype for change_beacon
      wifi: nl80211: additions to NL80211_CMD_SET_BEACON
      wifi: mac80211: additions to change_beacon()
      wifi: ath12k: call ath12k_mac_fils_discovery() without condition

Anjaneyulu (1):
      wifi: iwlwifi: implement enable/disable for China 2022 regulatory

Arowa Suliman (1):
      wifi: ath11k: mhi: add a warning message for MHI_CB_EE_RDDM crash

Ayala Beker (3):
      wifi: mac80211: don't connect to an AP while it's in a CSA process
      wifi: mac80211: add support for parsing TID to Link mapping element
      wifi: mac80211: support handling of advertised TID-to-link mapping

Baochen Qiang (4):
      wifi: ath12k: fix possible out-of-bound read in ath12k_htt_pull_ppdu_=
stats()
      wifi: ath12k: fix possible out-of-bound write in ath12k_wmi_ext_hal_r=
eg_caps()
      wifi: ath12k: fix DMA unmap warning on NULL DMA address
      wifi: ath11k: fix boot failure with one MSI vector

Benjamin Berg (5):
      wifi: cfg80211: add ieee80211_fragment_element to public API
      wifi: mac80211: add more warnings about inserting sta info
      wifi: cfg80211: report per-link errors during association
      wifi: mac80211: report per-link error during association
      wifi: mac80211: reject MLO channel configuration if not supported

Colin Ian King (2):
      wifi: cfg80211: make read-only array centers_80mhz static const
      wifi: rt2x00: remove redundant check if u8 array element is less than=
 zero

Dmitry Antipov (20):
      wifi: plfxlc: fix clang-specific fortify warning
      wifi: mac80211_hwsim: fix clang-specific fortify warning
      wifi: wext: avoid extra calls to strlen() in ieee80211_bss()
      wifi: ath9k: simplify ar9003_hw_process_ini()
      wifi: ath9k: use u32 for txgain indexes
      wifi: ath9k: fix clang-specific fortify warnings
      wifi: ath10k: fix clang-specific fortify warning
      wifi: mwifiex: cleanup struct mwifiex_sdio_mpa_rx
      wifi: ath10k: drop HTT_DATA_TX_STATUS_DOWNLOAD_FAIL
      wifi: ath11k: drop NULL pointer check in ath11k_update_per_peer_tx_st=
ats()
      wifi: ath11k: drop redundant check in ath11k_dp_rx_mon_dest_process()
      wifi: ath11k: remove unused members of 'struct ath11k_base'
      wifi: mwifiex: simplify PCIE write operations
      wifi: mwifiex: followup PCIE and related cleanups
      wifi: ath11k: use kstrtoul_from_user() where appropriate
      wifi: ath11k: fix ath11k_mac_op_remain_on_channel() stack usage
      wifi: rtlwifi: cleanup few rtlxxxx_set_hw_reg() routines
      wifi: rtlwifi: fix EDCA limit set by BT coexistence
      wifi: rtlwifi: use unsigned long for rtl_bssid_entry timestamp
      wifi: rtlwifi: remove unreachable code in rtl92d_dm_check_edca_turbo()

Dongliang Mu (1):
      wifi: ath9k: clean up function ath9k_hif_usb_resume

Emmanuel Grumbach (8):
      wifi: mac80211: add support for mld in ieee80211_chswitch_done
      wifi: iwlwifi: mvm: support CSA with MLD
      wifi: iwlwifi: honor the enable_ini value
      wifi: iwlwifi: mvm: log dropped frames
      wifi: iwlwifi: mvm: fix recovery flow in CSA
      wifi: iwlwifi: mvm: add a debug print when we get a BAR
      wifi: mac80211: update the rx_chains after set_antenna()
      wifi: iwlwifi: mvm: support set_antenna()

Gregory Greenman (1):
      wifi: iwlwifi: fw: disable firmware debug asserts

Harshitha Prem (2):
      wifi: ath12k: Ignore fragments from uninitialized peer in  dp
      wifi: ath12k: fix undefined behavior with __fls in dp

Ilan Peer (5):
      wifi: mac80211: Fix SMPS handling in the context of MLO
      wifi: mac80211: Print local link address during authentication
      wifi: mac80211: Do not force off-channel for management Tx with MLO
      wifi: mac80211: Notify the low level driver on change in MLO valid li=
nks
      wifi: mac80211_hwsim: Handle BSS_CHANGED_VALID_LINKS

Jeff Johnson (2):
      wifi: mac80211: Use flexible array in struct ieee80211_tim_ie
      wifi: cw1200: Avoid processing an invalid TIM IE

Jinjie Ruan (1):
      wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_f=
ile()

Johannes Berg (105):
      wifi: mac80211: tx: clarify conditions in if statement
      wifi: mac80211: rework ack_frame_id handling a bit
      wifi: mac80211: fix SMPS status handling
      wifi: mac80211: debugfs: lock wiphy instead of RTNL
      wifi: mac80211: hold wiphy lock in netdev/link debugfs
      wifi: mac80211: lock wiphy for aggregation debugfs
      wifi: cfg80211: check RTNL when iterating devices
      wifi: cfg80211: add flush functions for wiphy work
      wifi: mac80211: flush wiphy work where appropriate
      wifi: mac80211: convert A-MPDU work to wiphy work
      wifi: mac80211: add more ops assertions
      wifi: mac80211: move DFS CAC work to wiphy work
      wifi: mac80211: move radar detect work to wiphy work
      wifi: mac80211: move scan work to wiphy work
      wifi: mac80211: move monitor work to wiphy work
      wifi: mac80211: lock wiphy in IP address notifier
      wifi: mac80211: move offchannel works to wiphy work
      wifi: mac80211: move link activation work to wiphy work
      wifi: mac80211: move dynamic PS to wiphy work
      wifi: mac80211: move sched-scan stop work to wiphy work
      wifi: mac80211: move TDLS work to wiphy work
      wifi: mac80211: move key tailroom work to wiphy work
      wifi: mac80211: move tspec work to wiphy work
      wifi: mac80211: move filter reconfig to wiphy work
      wifi: mac80211: move CSA finalize to wiphy work
      wifi: mac80211: move color change finalize to wiphy work
      wifi: mac80211: check wiphy mutex in ops
      wifi: cfg80211: reg: hold wiphy mutex for wdev iteration
      wifi: cfg80211: sme: hold wiphy lock for wdev iteration
      wifi: cfg80211: hold wiphy lock in cfg80211_any_wiphy_oper_chan()
      wifi: cfg80211: check wiphy mutex is held for wdev mutex
      wifi: mac80211: ethtool: hold wiphy mutex
      wifi: mac80211: hold wiphy_lock around concurrency checks
      wifi: mac80211: extend wiphy lock in interface removal
      wifi: mac80211: take wiphy lock for MAC addr change
      wifi: mac80211: remove sta_mtx
      wifi: mac80211: remove key_mtx
      wifi: mac80211: remove chanctx_mtx
      wifi: mac80211: remove ampdu_mlme.mtx
      wifi: mac80211: remove local->mtx
      wifi: mac80211: reduce iflist_mtx
      wifi: mac80211: set wiphy for virtual monitors
      wifi: cfg80211: remove wdev mutex
      wifi: mac80211: fix TXQ error path and cleanup
      wifi: mac80211: fix BA session teardown race
      wifi: cfg80211: annotate iftype_data pointer with sparse
      wifi: mac80211: fix RCU usage warning in mesh fast-xmit
      wifi: cfg80211: fix off-by-one in element defrag
      wifi: cfg80211: add first kunit tests, for element defrag
      wifi: mac80211: add an element parsing unit test
      wifi: mac80211: remove unnecessary struct forward declaration
      wifi: mac80211: fix various kernel-doc issues
      wifi: cfg80211: reg: fix various kernel-doc issues
      wifi: mac80211_hwsim: clean up kernel-doc
      wifi: mac80211: fix # of MSDU in A-MSDU calculation
      wifi: mac80211: take MBSSID/EHT data also from probe resp
      wifi: mac80211: fix channel switch link data
      wifi: iwlwifi: mvm: increase session protection after CSA
      wifi: iwlwifi: mvm: disconnect long CSA only w/o alternative
      wifi: iwlwifi: fix some kernel-doc issues
      wifi: iwlwifi: queue: fix kernel-doc
      wifi: iwlwifi: dvm: remove kernel-doc warnings
      wifi: iwlwifi: pcie: fix kernel-doc issues
      wifi: iwlwifi: mvm: fix kernel-doc
      wifi: iwlwifi: fw: reconstruct the API/CAPA enum number
      wifi: iwlwifi: mvm: move RU alloc B2 placement
      wifi: iwlwifi: mvm: check link more carefully
      wifi: iwlwifi: mvm: reduce maximum RX A-MPDU size
      wifi: iwlwifi: pcie: fix RB status reading
      wifi: iwlwifi: increase number of RX buffers for EHT devices
      wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()
      wifi: cfg80211: remove scan_width support
      wifi: mac80211: remove shifted rate support
      wifi: iwlwifi: pcie: rescan bus if no parent
      wifi: iwlwifi: pcie: give up mem read if HW is dead
      wifi: iwlwifi: pcie: enable TOP fatal error interrupt
      wifi: iwlwifi: mvm: make "pldr_sync" mode effective
      wifi: iwlwifi: update context info structure definitions
      wifi: iwlwifi: mvm: move listen interval to constants
      wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()
      wifi: mac80211: ethtool: always hold wiphy mutex
      wifi: cfg80211: split struct cfg80211_ap_settings
      wifi: mac80211: use bandwidth indication element for CSA
      wifi: mac80211: relax RCU check in for_each_vif_active_link()
      wifi: mac80211: allow for_each_sta_active_link() under RCU
      wifi: cfg80211: reg: describe return values in kernel-doc
      wifi: mac80211: describe return values in kernel-doc
      wifi: mac80211_hwsim: move kernel-doc description
      wifi: mac80211: support antenna control in injection
      wifi: iwlwifi: mvm: iterate active links for STA queues
      wifi: iwlwifi: mvm: handle link-STA allocation in restart
      wifi: iwlwifi: pcie: (re-)assign BAR0 on driver bind
      wifi: iwlwifi: fail NIC access fast on dead NIC
      wifi: iwlwifi: mvm: make pldr_sync AX210 specific
      wifi: iwlwifi: mvm: refactor TX rate handling
      wifi: iwlwifi: mvm: support injection antenna control
      wifi: iwlwifi: mvm: check for iwl_mvm_mld_update_sta() errors
      wifi: cfg80211: add local_state_change to deauth trace
      wifi: mac80211: fix check for unusable RX result
      wifi: mac80211: remove RX_DROP_UNUSABLE
      wifi: mac80211: split ieee80211_drop_unencrypted_mgmt() return value
      wifi: mac80211: expand __ieee80211_data_to_8023() status
      wifi: mac80211: fix ieee80211_drop_unencrypted_mgmt return type/value
      wifi: mac80211: add back SPDX identifier
      Merge wireless into wireless-next

Kalle Valo (2):
      wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data handling
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kva=
lo/ath.git

Kang Yang (1):
      wifi: ath12k: add msdu_end structure for WCN7850

Kees Cook (5):
      wifi: brcmfmac: Annotate struct brcmf_gscan_config with __counted_by
      wifi: brcmfmac: firmware: Annotate struct brcmf_fw_request with __cou=
nted_by
      wifi: ipw2x00: Annotate struct libipw_txb with __counted_by
      wifi: wcn36xx: Annotate struct wcn36xx_hal_ind_msg with __counted_by
      wifi: ath10k: Annotate struct ath10k_ce_ring with __counted_by

Kuan-Chung Chen (2):
      wifi: rtw89: 8852c: Update bandedge parameters for better performance
      wifi: rtw89: 8852c: Fix TSSI causes transmit power inaccuracy

Lingbo Kong (1):
      wifi: ath12k: add support for hardware rfkill for WCN7850

Manish Dharanenthiran (2):
      wifi: ath12k: fix WARN_ON during ath12k_mac_update_vif_chan
      wifi: ath12k: fix radar detection in 160 MHz

Miri Korenblit (4):
      wifi: iwlwifi: don't use an uninitialized variable
      wifi: iwlwifi: remove dead-code
      wifi: iwlwifi: Use FW rate for non-data frames
      wifi: iwlwifi: no power save during transition to D3

Mukesh Sisodiya (1):
      wifi: iwlwifi: add mapping of a periphery register crf for WH RF

Muna Sinada (2):
      wifi: ath11k: move references from rsvd2 to info fields
      wifi: ath11k: fix tid bitmap is 0 in peer rx mu stats

Ping-Ke Shih (16):
      wifi: rtw89: fw: move polling function of firmware path ready to an i=
ndividual function
      wifi: rtw89: fw: generalize download firmware flow by mac_gen pointers
      wifi: rtw89: fw: implement supported functions of download firmware f=
or WiFi 7 chips
      wifi: rtw89: fw: add checking type for variant type of firmware
      wifi: rtw89: fw: propagate an argument include_bb for BB MCU firmware
      wifi: rtw89: 8922a: add chip_ops::bb_preinit to enable BB before down=
loading firmware
      wifi: rtw89: fw: refine download flow to support variant firmware sui=
ts
      wifi: rtw89: 8922a: set memory heap address for secure firmware
      wifi: mac80211: don't return unset power in ieee80211_get_tx_power()
      wifi: rtw89: add to query RX descriptor format v2
      wifi: rtw89: add to fill TX descriptor for firmware command v2
      wifi: rtw89: add to fill TX descriptor v2
      wifi: rtw89: add chip_info::txwd_info size to generalize TX WD submit
      wifi: rtw89: consolidate registers of mac port to struct
      wifi: rtw89: add mac_gen pointer to access mac port registers
      wifi: rtw89: add subband index of primary channel to struct rtw89_chan

Po-Hao Huang (4):
      wifi: rtw88: fix typo rtw8822cu_probe
      wifi: ieee80211: add UL-bandwidth definition of trigger frame
      wifi: rtw89: refine uplink trigger based control mechanism
      wifi: rtw89: refine bandwidth 160MHz uplink OFDMA performance

Prasurjya Rohan Saikia (1):
      wifi: wilc1000: add back-off algorithm to balance tx queue packets

Raj Kumar Bhagat (1):
      wifi: cfg80211: allow reg update by driver even if wiphy->regd is set

Rand Deeb (1):
      ssb: Fix division by zero issue in ssb_calc_clock_rate

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: enable FILS DF Tx on non-PSC channel

Shiji Yang (1):
      wifi: rt2x00: fix MT7620 low RSSI issue

Sidhanta Sahu (1):
      wifi: ath12k: Set default beacon mode to burst mode

Stephen Douthit (1):
      wifi: mac80211: Sanity check tx bitrate if not provided by driver

Tom Rix (1):
      wifi: lib80211: remove unused variables iv32 and iv16

Uwe Kleine-K=C3=B6nig (1):
      wifi: wlcore: Convert to platform remove callback returning void

Vinayak Yadawad (1):
      wifi: cfg80211: OWE DH IE handling offload

V=C3=ADctor Gonzalo (1):
      wifi: mwifiex: use MODULE_FIRMWARE to add firmware files metadata

Wen Gong (9):
      wifi: cfg80211: save power spectral density(psd) of regulatory rule
      wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in EHT PHY capa=
bility for WCN7850
      wifi: ath12k: change to initialize recovery variables earlier in ath1=
2k_core_reset()
      wifi: ath11k: add chip id board name while searching board-2.bin for =
WCN6855
      wifi: ath12k: fix recovery fail while firmware crash when doing chann=
el switch
      wifi: ath12k: indicate to mac80211 scan complete with aborted flag fo=
r ATH12K_SCAN_STARTING state
      wifi: ath12k: indicate scan complete for scan canceled when scan runn=
ing
      wifi: ath12k: change to treat alpha code na as world wide regdomain
      wifi: ath12k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850

Wu Yunchuan (7):
      wifi: ar5523: Remove unnecessary (void*) conversions
      wifi: wcn36xx: remove unnecessary (void*) conversions
      wifi: ath5k: remove unnecessary (void*) conversions
      wifi: ath6kl: remove unnecessary (void*) conversions
      wifi: ath10k: Remove unnecessary (void*) conversions
      wifi: ath12k: Remove unnecessary (void*) conversions
      wifi: ath11k: remove unnecessary (void*) conversions

Yedidya Benshimol (1):
      wifi: iwlwifi: mvm: add support for new wowlan_info_notif

Zenm Chen (2):
      wifi: rtl8xxxu: mark TOTOLINK N150UA V5/N150UA-B as tested
      wifi: rtl8xxxu: Add a description about the device ID 0x7392:0xb722

Zong-Zhe Yang (35):
      wifi: rtw89: mcc: initialize start flow
      wifi: rtw89: mcc: fill fundamental configurations
      wifi: rtw89: mcc: consider and determine BT duration
      wifi: rtw89: mcc: decide pattern and calculate parameters
      wifi: rtw89: fix typo of rtw89_fw_h2c_mcc_macid_bitmap()
      wifi: rtw89: mcc: trigger FW to start/stop MCC
      wifi: rtw89: 52c: rfk: refine MCC channel info notification
      wifi: rtw89: rfk: disable driver tracking during MCC
      wifi: rtw89: 52c: rfk: disable DPK during MCC
      wifi: rtw89: mcc: update role bitmap when changed
      wifi: rtw89: mcc: track beacon offset and update when needed
      wifi: rtw89: mcc: deal with P2P PS change
      wifi: rtw89: mcc: deal with BT slot change
      wifi: rtw89: mcc: deal with beacon NoA if GO exists
      wifi: rtw89: indicate TX shape table inside RFE parameter
      wifi: rtw89: indicate TX power by rate table inside RFE parameter
      wifi: rtw89: phy: refine helpers used for raw TX power
      wifi: rtw89: load TX power by rate when RFE parms setup
      wifi: rtw89: phy: extend TX power common stuffs for Wi-Fi 7 chips
      wifi: rtw89: load TX power related tables from FW elements
      wifi: rtw89: mcc: fix NoA start time when GO is auxiliary
      wifi: rtw89: pause/proceed MCC for ROC and HW scan
      wifi: rtw89: 8852c: declare to support two chanctx
      wifi: rtw89: declare MCC in interface combination
      wifi: rtw89: regd: configure Thailand in regulation type
      wifi: rtw89: 8852c: update TX power tables to R67
      wifi: rtw89: 8852b: update TX power tables to R35
      wifi: rtw89: 8851b: update TX power tables to R34
      wifi: rtw89: mac: get TX power control register according to chip gen
      wifi: rtw89: phy: set TX power by rate according to chip gen
      wifi: rtw89: phy: set TX power offset according to chip gen
      wifi: rtw89: phy: set TX power limit according to chip gen
      wifi: rtw89: phy: set TX power RU limit according to chip gen
      wifi: rtw89: debug: show txpwr table according to chip gen
      wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips

 drivers/net/wireless/ath/ar5523/ar5523.c           |    2 +-
 drivers/net/wireless/ath/ath10k/ce.h               |    2 +-
 drivers/net/wireless/ath/ath10k/debug.c            |    2 +-
 drivers/net/wireless/ath/ath10k/htt.h              |    3 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c           |   16 +-
 drivers/net/wireless/ath/ath11k/core.c             |  108 +-
 drivers/net/wireless/ath/ath11k/core.h             |    2 -
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   23 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    8 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |   31 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h           |   18 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c           |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   71 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   24 +-
 drivers/net/wireless/ath/ath11k/spectral.c         |   28 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |    8 +-
 drivers/net/wireless/ath/ath12k/core.c             |   60 +-
 drivers/net/wireless/ath/ath12k/core.h             |    4 +
 drivers/net/wireless/ath/ath12k/dp.c               |    1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   12 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   30 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   12 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   12 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   12 +
 drivers/net/wireless/ath/ath12k/hw.h               |    4 +
 drivers/net/wireless/ath/ath12k/mac.c              |  145 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    2 +
 drivers/net/wireless/ath/ath12k/peer.h             |    3 +
 drivers/net/wireless/ath/ath12k/rx_desc.h          |   91 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   93 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   25 +
 drivers/net/wireless/ath/ath5k/base.c              |    4 +-
 drivers/net/wireless/ath/ath5k/pci.c               |    4 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    8 +-
 drivers/net/wireless/ath/ath6kl/main.c             |    4 +-
 drivers/net/wireless/ath/ath6kl/txrx.c             |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c        |   11 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   34 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |    2 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c             |    6 +-
 drivers/net/wireless/ath/wcn36xx/smd.c             |   20 +-
 drivers/net/wireless/ath/wcn36xx/smd.h             |    2 +-
 drivers/net/wireless/ath/wcn36xx/testmode.c        |    2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    3 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |    2 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    5 +-
 .../broadcom/brcm80211/brcmfmac/firmware.h         |    2 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |    2 +-
 drivers/net/wireless/intel/ipw2x00/libipw.h        |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/common.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |   33 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |   14 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h        |   12 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h        |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   18 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |    5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |   46 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |   22 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h    |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   25 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   30 +-
 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c         |    1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    5 -
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   51 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.c  |    5 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.h  |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   13 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   80 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   19 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  165 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   79 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   63 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    5 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    5 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.h    |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  104 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    3 +
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   59 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   45 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |    6 +-
 drivers/net/wireless/marvell/mwifiex/11h.c         |    4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    3 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    4 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  322 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   10 -
 drivers/net/wireless/marvell/mwifiex/sdio.h        |    4 -
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |    3 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    4 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   20 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    2 +
 drivers/net/wireless/purelifi/plfxlc/mac.c         |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    4 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  |    5 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   10 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |    2 +
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |    5 -
 .../wireless/realtek/rtlwifi/rtl8192c/dm_common.c  |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.c    |   18 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8723ae/dm.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    6 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |    5 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |    2 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |    4 +-
 drivers/net/wireless/realtek/rtw89/chan.c          | 1576 +++++++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   34 +
 drivers/net/wireless/realtek/rtw89/core.c          |  336 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  396 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  272 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  665 +++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  144 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  154 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   27 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    3 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  223 ++
 drivers/net/wireless/realtek/rtw89/pci.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  419 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |  123 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  568 +++
 drivers/net/wireless/realtek/rtw89/reg.h           |  326 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   12 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    | 1347 +++----
 .../net/wireless/realtek/rtw89/rtw8851b_table.h    |    3 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    7 +-
 .../net/wireless/realtek/rtw89/rtw8852a_table.c    |    2 +
 .../net/wireless/realtek/rtw89/rtw8852a_table.h    |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   12 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    |  333 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.h    |    3 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   26 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  107 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h  |    3 +
 .../wireless/realtek/rtw89/rtw8852c_rfk_table.c    |   42 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    | 3782 ++++++++++++++++=
++--
 .../net/wireless/realtek/rtw89/rtw8852c_table.h    |    3 -
 drivers/net/wireless/realtek/rtw89/txrx.h          |  271 ++
 drivers/net/wireless/realtek/rtw89/wow.c           |    4 +-
 drivers/net/wireless/st/cw1200/txrx.c              |    2 +-
 drivers/net/wireless/ti/wl12xx/main.c              |    6 +-
 drivers/net/wireless/ti/wl18xx/main.c              |    2 +-
 drivers/net/wireless/ti/wlcore/event.c             |    2 +-
 drivers/net/wireless/ti/wlcore/main.c              |   12 +-
 drivers/net/wireless/ti/wlcore/wlcore.h            |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   58 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |   19 +-
 drivers/ssb/main.c                                 |    2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    6 +-
 include/linux/ieee80211.h                          |  103 +-
 include/net/cfg80211.h                             |  219 +-
 include/net/mac80211.h                             |   58 +-
 include/net/regulatory.h                           |    1 +
 include/uapi/linux/nl80211.h                       |   39 +-
 net/mac80211/Kconfig                               |   11 +
 net/mac80211/Makefile                              |    2 +
 net/mac80211/agg-rx.c                              |   63 +-
 net/mac80211/agg-tx.c                              |   63 +-
 net/mac80211/airtime.c                             |   10 +-
 net/mac80211/cfg.c                                 |  490 ++-
 net/mac80211/chan.c                                |  156 +-
 net/mac80211/debugfs.c                             |   11 +-
 net/mac80211/debugfs_key.c                         |   20 +-
 net/mac80211/debugfs_netdev.c                      |  133 +-
 net/mac80211/debugfs_sta.c                         |    4 +-
 net/mac80211/driver-ops.c                          |   31 +-
 net/mac80211/driver-ops.h                          |  127 +-
 net/mac80211/drop.h                                |   49 +-
 net/mac80211/ethtool.c                             |   20 +-
 net/mac80211/ht.c                                  |   60 +-
 net/mac80211/ibss.c                                |  104 +-
 net/mac80211/ieee80211_i.h                         |  220 +-
 net/mac80211/iface.c                               |  170 +-
 net/mac80211/key.c                                 |  158 +-
 net/mac80211/key.h                                 |   11 +-
 net/mac80211/link.c                                |   56 +-
 net/mac80211/main.c                                |   91 +-
 net/mac80211/mesh.c                                |   16 +-
 net/mac80211/mesh_pathtbl.c                        |    2 +-
 net/mac80211/mlme.c                                |  666 ++--
 net/mac80211/ocb.c                                 |   19 +-
 net/mac80211/offchannel.c                          |  103 +-
 net/mac80211/pm.c                                  |   13 +-
 net/mac80211/rc80211_minstrel_ht.c                 |    7 +-
 net/mac80211/rx.c                                  |  104 +-
 net/mac80211/s1g.c                                 |   15 +-
 net/mac80211/scan.c                                |  226 +-
 net/mac80211/spectmgmt.c                           |   13 +-
 net/mac80211/sta_info.c                            |  111 +-
 net/mac80211/sta_info.h                            |   26 +-
 net/mac80211/status.c                              |  102 +-
 net/mac80211/tdls.c                                |   86 +-
 net/mac80211/tests/Makefile                        |    3 +
 net/mac80211/tests/elems.c                         |  101 +
 net/mac80211/tests/module.c                        |   10 +
 net/mac80211/trace.h                               |   11 +-
 net/mac80211/tx.c                                  |   73 +-
 net/mac80211/util.c                                |  248 +-
 net/mac80211/wep.c                                 |    9 +-
 net/mac80211/wpa.c                                 |   42 +-
 net/wireless/Kconfig                               |   11 +
 net/wireless/Makefile                              |    1 +
 net/wireless/ap.c                                  |   24 +-
 net/wireless/chan.c                                |   55 +-
 net/wireless/core.c                                |   72 +-
 net/wireless/core.h                                |   60 +-
 net/wireless/ibss.c                                |   76 +-
 net/wireless/lib80211_crypt_tkip.c                 |   12 +-
 net/wireless/mesh.c                                |   28 +-
 net/wireless/mlme.c                                |   21 +-
 net/wireless/nl80211.c                             |  536 ++-
 net/wireless/ocb.c                                 |   43 +-
 net/wireless/pmsr.c                                |    4 +-
 net/wireless/rdev-ops.h                            |    2 +-
 net/wireless/reg.c                                 |   99 +-
 net/wireless/reg.h                                 |   16 +-
 net/wireless/scan.c                                |   74 +-
 net/wireless/sme.c                                 |   59 +-
 net/wireless/sysfs.c                               |    4 +-
 net/wireless/tests/Makefile                        |    3 +
 net/wireless/tests/fragmentation.c                 |  157 +
 net/wireless/tests/module.c                        |   10 +
 net/wireless/trace.h                               |   78 +-
 net/wireless/util.c                                |   57 +-
 net/wireless/wext-compat.c                         |   43 +-
 net/wireless/wext-sme.c                            |   59 +-
 269 files changed, 14659 insertions(+), 5442 deletions(-)
 create mode 100644 net/mac80211/tests/Makefile
 create mode 100644 net/mac80211/tests/elems.c
 create mode 100644 net/mac80211/tests/module.c
 create mode 100644 net/wireless/tests/Makefile
 create mode 100644 net/wireless/tests/fragmentation.c
 create mode 100644 net/wireless/tests/module.c
