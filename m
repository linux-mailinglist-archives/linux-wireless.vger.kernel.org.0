Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51A7D7F44
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJZJES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJZJEQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 05:04:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2913184
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 02:04:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2426C433CB;
        Thu, 26 Oct 2023 09:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698311052;
        bh=cOWWK0cjfkS2iHeZb7imQpqgd/9CquR42j5FSqtC/1Q=;
        h=From:Subject:To:Cc:Date:From;
        b=tqOefmCojGx+0dzUeYHJMx3KkIGerFmD5leGALSOeAof+oma8X4CDbc/GwAXj9tFx
         f0fvkqS2NtJzvlHePm5MIEWDzflQO54rlbCAnYD6HlxpIzrgQVzH6StKar/J6FdU4h
         QIrVVZP4Q04bsAZncON9Y21rvL4qsA5LR7tzy0084bSrQs7ugGunGODeb3BR4iB4Hw
         ESeJL9sg02/IvWx9/YdphqFzVlYyNZRm79Xvmab6tAeWapQ1s3wb4ol2gLTB2kUEVU
         kuaUKx8y88nzWkGfkh0ye3qpxFaZSGUDSb32EpoJBcGqeFyY5+UBTRRKWL61x7HHpg
         I/Hnb6pEvUIjw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2023-10-26
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Message-Id: <20231026090411.B2426C433CB@smtp.kernel.org>
Date:   Thu, 26 Oct 2023 09:04:11 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit ee2a35fedbc942e6eeb9e351a53acb1fe6b101c5:

  Merge tag 'mlx5-updates-2023-10-10' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux (2023-10-17 18:27:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2023-10-26

for you to fetch changes up to 1002f8171d966f73e3d97b05fc0178e115fb5dca:

  wifi: ray_cs: Remove unnecessary (void*) conversions (2023-10-25 20:44:40 +0300)

----------------------------------------------------------------
wireless-next patches for v6.7

The third, and most likely the last, features pull request for v6.7.
Fixes all over and only few small new features.

Major changes:

iwlwifi

* more Multi-Link Operation (MLO) work

ath12k

* QCN9274: mesh support

ath11k

* firmware-2.bin container file format support

----------------------------------------------------------------
Aditya Kumar Singh (2):
      wifi: ath11k: add parsing of phy bitmap for reg rules
      wifi: ath12k: add parsing of phy bitmap for reg rules

Ajay Singh (1):
      wifi: wilc1000: use vmm_table as array in wilc struct

Aloka Dixit (1):
      wifi: ath11k: call ath11k_mac_fils_discovery() without condition

Alon Giladi (1):
      wifi: iwlwifi: send EDT table to FW

Anilkumar Kolli (1):
      wifi: ath11k: add firmware-2.bin support

Anjaneyulu (2):
      wifi: iwlwifi: mvm: implement new firmware API for statistics
      wifi: iwlwifi: mvm: debugfs for fw system stats

Avraham Stern (2):
      wifi: iwlwifi: mvm: update station's MFP flag after association
      wifi: iwlwifi: mvm: fix removing pasn station for responder

Ayala Beker (1):
      wifi: iwlwifi: mvm: advertise support for SCS traffic description

Benjamin Berg (3):
      wifi: mac80211: cleanup auth_data only if association continues
      wifi: mac80211: mesh: fix some kdoc warnings
      wifi: iwlwifi: mvm: Return success if link could not be removed

Cheng-Chieh Hsieh (3):
      wifi: rtw89: modify the register setting and the flow of CFO tracking
      wifi: rtw89: correct the DCFO tracking flow to improve CFO compensation
      wifi: rtw89: move software DCFO compensation setting to proper position

Chin-Yen Lee (2):
      wifi: rtw88: debug: add to check if debug mask is enabled
      wifi: rtw88: dump firmware debug information in abnormal state

Chung-Hsuan Hung (1):
      wifi: rtw89: phy: change naming related BT coexistence functions

Daniel Gabay (2):
      wifi: iwlwifi: add support for SNPS DPHYIP region type
      wifi: iwlwifi: read DSM func 2 for specific RF types

Dmitry Antipov (9):
      wifi: ath12k: remove redundant memset() in ath12k_hal_reo_qdesc_setup()
      wifi: rtlwifi: cleanup struct rtl_ps_ctl
      wifi: rtlwifi: drop pre_fill_tx_bd_desc() from HAL interface
      wifi: rtlwifi: drop fill_fake_txdesc() from HAL interface
      wifi: rtlwifi: drop chk_switch_dmdp() from HAL interface
      wifi: remove unused argument of ieee80211_get_tdls_action()
      wifi: iwlwifi: check for kmemdup() return value in iwl_parse_tlv_firmware()
      wifi: iwlwifi: drop NULL pointer check in iwl_mvm_tzone_set_trip_temp()
      wifi: rtw89: cleanup firmware elements parsing

Emmanuel Grumbach (6):
      wifi: mac80211: fix a expired vs. cancel race in roc
      wifi: iwlwifi: mvm: don't add dummy phy context
      wifi: iwlwifi: mvm: fold the ref++ into iwl_mvm_phy_ctxt_add
      wifi: iwlwifi: mvm: fix the PHY context resolution for p2p device
      wifi: iwlwifi: disable multi rx queue for 9000
      wifi: iwlwifi: mvm: simplify the reorder buffer

Gregory Greenman (5):
      wifi: iwlwifi: bump FW API to 84 for AX/BZ/SC devices
      wifi: iwlwifi: fw: increase fw_version string size
      wifi: iwlwifi: mvm: fix size check for fw_link_id
      wifi: iwlwifi: mvm: fix regdb initialization
      wifi: iwlwifi: bump FW API to 86 for AX/BZ/SC devices

Gustavo A. R. Silva (1):
      wifi: mac80211: Add __counted_by for struct ieee802_11_elems and use struct_size()

Haim Dreyfuss (1):
      wifi: iwlwifi: mvm: extend alive timeout to 2 seconds

Ilan Peer (10):
      wifi: mac80211: Rename and update IEEE80211_VIF_DISABLE_SMPS_OVERRIDE
      wifi: cfg80211: Include operating class 137 in 6GHz band
      wifi: cfg80211: Handle specific BSSID in 6GHz scanning
      wifi: mac80211: Fix setting vif links
      wifi: cfg80211: Fix typo in documentation
      wifi: iwlwifi: mvm: Add basic link selection logic
      wifi: iwlwifi: mvm: Don't always bind/link the P2P Device interface
      wifi: iwlwifi: mvm: Correctly set link configuration
      wifi: iwlwifi: mvm: Fix unreachable code path
      wifi: iwlwifi: mvm: Fix key flags for IGTK on AP interface

Jeff Johnson (6):
      wifi: ath12k: Consistently use ath12k_vif_to_arvif()
      wifi: ath11k: Remove unused struct ath11k_htc_frame
      wifi: ath11k: Introduce and use ath11k_sta_to_arsta()
      wifi: ath11k: Remove ath11k_base::bd_api
      wifi: ath12k: Remove ath12k_base::bd_api
      wifi: ath12k: Introduce and use ath12k_sta_to_arsta()

Johan Hovold (6):
      wifi: ath11k: fix temperature event locking
      wifi: ath11k: fix dfs radar event locking
      wifi: ath11k: fix htt pktlog locking
      wifi: ath11k: fix gtk offload status event locking
      wifi: ath12k: fix dfs-radar and temperature event locking
      wifi: ath12k: fix htt mlo-offset event locking

Johannes Berg (25):
      wifi: iwlwifi: pcie: propagate iwl_pcie_gen2_apm_init() error
      wifi: iwlwifi: skip opmode start retries on dead transport
      wifi: iwlwifi: fix opmode start/stop race
      wifi: iwlwifi: pcie: clean up WFPM control bits
      wifi: iwlwifi: mvm: offload IGTK in AP if BIGTK is supported
      wifi: iwlwifi: mvm: use correct sta ID for IGTK/BIGTK
      wifi: mac80211: don't recreate driver link debugfs in reconfig
      wifi: cfg80211: wext: convert return value to kernel-doc
      wifi: mac80211: flush STA queues on unauthorization
      wifi: iwlwifi: mvm: rework debugfs handling
      wifi: iwlwifi: mvm: fix SB CFG check
      wifi: iwlwifi: mei: return error from register when not built
      wifi: mac80211: fix change_address deadlock during unregister
      wifi: iwlwifi: mvm: change iwl_mvm_flush_sta() API
      wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()
      wifi: iwlwifi: mvm: remove TDLS stations from FW
      wifi: mac80211: fix another key installation error path
      wifi: iwlwifi: api: fix center_freq label in PHY diagram
      wifi: iwlwifi: mvm: remove set_tim callback for MLD ops
      wifi: iwlwifi: mvm: fix netif csum flags
      wifi: iwlwifi: pcie: synchronize IRQs before NAPI
      wifi: iwlwifi: trace full frames with TX status request
      wifi: iwlwifi: mvm: cycle FW link on chanctx removal
      wifi: iwlwifi: mvm: show dump even for pldr_sync
      wifi: mac80211: drop robust action frames before assoc

Justin Stitt (7):
      wifi: ath5k: replace deprecated strncpy with strscpy
      wifi: ath6kl: replace deprecated strncpy with memcpy
      wifi: ipw2x00: replace deprecated strncpy with strscpy_pad
      wifi: wl1251: replace deprecated strncpy with strscpy
      wifi: wl18xx: replace deprecated strncpy with strscpy
      wifi: wlcore: boot: replace deprecated strncpy with strscpy
      wifi: wlcore: main: replace deprecated strncpy with strscpy

Kalle Valo (9):
      wifi: ath11k: ath11k_debugfs_register(): fix format-truncation warning
      wifi: mac80211: rename ieee80211_tx_status() to ieee80211_tx_status_skb()
      wifi: mac80211: rename struct cfg80211_rx_assoc_resp to cfg80211_rx_assoc_resp_data
      wifi: brcmfmac: fix format-truncation warnings
      wifi: ipw2x00: fix format-truncation warnings
      wifi: ath9k_htc: fix format-truncation warning
      wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()
      Revert "wifi: ath11k: call ath11k_mac_fils_discovery() without condition"
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Karthikeyan Periyasamy (4):
      wifi: ath11k: rename the wmi_sc naming convention to wmi_ab
      wifi: ath11k: rename the sc naming convention to ab
      wifi: ath12k: rename the wmi_sc naming convention to wmi_ab
      wifi: ath12k: rename the sc naming convention to ab

Matt Chen (1):
      wifi: iwlmvm: fw: Add new OEM vendor to tas approved list

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix kernel panic by accessing invalid 6GHz channel info

Miri Korenblit (17):
      wifi: mac80211: add a driver callback to add vif debugfs
      wifi: mac80211: handle debugfs when switching to/from MLO
      wifi: mac80211: make mgd_protect_tdls_discover MLO-aware
      wifi: mac80211: purge TX queues in flush_queues flow
      wifi: mac80211: Check if we had first beacon with relevant links
      wifi: mac80211: add link id to mgd_prepare_tx()
      wifi: iwlwifi: Extract common prph mac/phy regions data dump logic
      wifi: iwlwifi: add support for new ini region types
      wifi: iwlwifi: mvm: add a per-link debugfs
      wifi: iwlwifi: abort scan when rfkill on but device enabled
      wifi: iwlwifi: mvm: cleanup MLO and non-MLO unification code
      wifi: iwlwifi: add support for activating UNII-1 in WW via BIOS
      wifi: iwlwifi: make time_events MLO aware
      wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd
      wifi: iwlwifi: support link id in SESSION_PROTECTION_NOTIF
      wifi: iwlwifi: mvm: add a print when sending RLC command
      wifi: iwlwifi: empty overflow queue during flush

Mukesh Sisodiya (4):
      wifi: iwlwifi: fw: Fix debugfs command sending
      wifi: iwlwifi: fix the rf step and flavor bits range
      wifi: iwlwifi: add new RF support for wifi7
      wifi: iwlwifi: fw: Add support for UATS table in UHB

Ping-Ke Shih (1):
      wifi: rtw89: phy: generalize valid bit of BSS color

Ramya Gnanasekar (2):
      wifi: ath12k: register EHT mesh capabilities
      wifi: ath12k: Enable Mesh support for QCN9274

Randy Dunlap (4):
      ssb: relax SSB_EMBEDDED dependencies
      wifi: cfg80211: fix header kernel-doc typos
      wifi: mac80211: fix header kernel-doc typos
      wifi: nl80211: fix doc typos

Rob Herring (1):
      wifi: ath11k: Use device_get_match_data()

Rotem Saado (1):
      wifi: iwlwifi: yoyo: swap cdb and jacket bits values

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: implement ROC version 3

Shiji Yang (4):
      wifi: rt2x00: fix rt2800 watchdog function
      wifi: rt2x00: improve MT7620 register initialization
      wifi: rt2x00: rework MT7620 channel config function
      wifi: rt2x00: rework MT7620 PA/LNA RF calibration

Stanislaw Gruszka (1):
      MAINTAINERS: wifi: rt2x00: drop Helmut Schaa

Vinayak Yadawad (1):
      wifi: cfg80211: Allow AP/P2PGO to indicate port authorization to peer STA/P2PClient

Wen Gong (3):
      wifi: ath12k: configure RDDM size to MHI for device recovery
      wifi: ath12k: add ath12k_qmi_free_resource() for recovery
      wifi: ath12k: fix invalid m3 buffer address

Wu Yunchuan (1):
      wifi: ray_cs: Remove unnecessary (void*) conversions

Yedidya Benshimol (1):
      wifi: iwlwifi: mvm: update IGTK in mvmvif upon D3 resume

iallouch (1):
      wifi: iwlwifi: mvm: add start mac ctdp sum calculation debugfs handler

 Documentation/driver-api/80211/mac80211.rst        |   2 +-
 MAINTAINERS                                        |   1 -
 drivers/net/wireless/ath/ath11k/Makefile           |   3 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |  10 +-
 drivers/net/wireless/ath/ath11k/core.c             |  15 +-
 drivers/net/wireless/ath/ath11k/core.h             |  21 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |   8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |  30 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  16 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   4 +-
 drivers/net/wireless/ath/ath11k/fw.c               | 168 +++++++
 drivers/net/wireless/ath/ath11k/fw.h               |  27 ++
 drivers/net/wireless/ath/ath11k/hif.h              |  54 +--
 drivers/net/wireless/ath/ath11k/htc.h              |  12 -
 drivers/net/wireless/ath/ath11k/mac.c              |  18 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |  18 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |   6 +-
 drivers/net/wireless/ath/ath11k/peer.c             |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |  54 ++-
 drivers/net/wireless/ath/ath11k/reg.c              |  11 +
 drivers/net/wireless/ath/ath11k/reg.h              |   3 +
 drivers/net/wireless/ath/ath11k/thermal.c          |  22 +-
 drivers/net/wireless/ath/ath11k/thermal.h          |   8 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  62 +--
 drivers/net/wireless/ath/ath12k/core.c             |   8 +-
 drivers/net/wireless/ath/ath12k/core.h             |   6 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  13 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   4 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   2 -
 drivers/net/wireless/ath/ath12k/hif.h              |  18 +-
 drivers/net/wireless/ath/ath12k/hw.c               |  12 +-
 drivers/net/wireless/ath/ath12k/hw.h               |   2 +
 drivers/net/wireless/ath/ath12k/mac.c              | 101 +++--
 drivers/net/wireless/ath/ath12k/mhi.c              |   1 +
 drivers/net/wireless/ath/ath12k/pci.c              |   4 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   7 +
 drivers/net/wireless/ath/ath12k/qmi.h              |   1 +
 drivers/net/wireless/ath/ath12k/reg.c              |  14 +
 drivers/net/wireless/ath/ath12k/reg.h              |   6 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  38 +-
 drivers/net/wireless/ath/ath5k/base.c              |   2 +-
 drivers/net/wireless/ath/ath5k/led.c               |   3 +-
 drivers/net/wireless/ath/ath6kl/init.c             |   2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.h           |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   2 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   2 +-
 drivers/net/wireless/broadcom/b43/dma.c            |   4 +-
 drivers/net/wireless/broadcom/b43/pio.c            |   2 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |   6 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |  20 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |  23 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  24 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |  30 ++
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |  37 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  10 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  62 ++-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  | 153 ++++++-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |  78 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 178 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   2 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  50 +++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |  17 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  39 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |  19 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   9 +-
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |  78 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   | 148 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 117 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 493 +++++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |  16 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 262 +++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       | 113 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |  68 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        | 157 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      | 324 ++------------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   7 -
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    | 198 +++++++--
 .../net/wireless/intel/iwlwifi/mvm/time-event.h    |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   7 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  61 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   1 +
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |   9 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |   2 +-
 drivers/net/wireless/legacy/ray_cs.c               |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   3 +
 drivers/net/wireless/mediatek/mt7601u/tx.c         |   2 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800.h        |  18 +
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     | 300 ++++++++-----
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c    |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |   6 +
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   2 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |   6 -
 drivers/net/wireless/realtek/rtlwifi/core.c        |  16 -
 drivers/net/wireless/realtek/rtlwifi/ps.c          |  17 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |   1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |  26 --
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   |   2 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |   1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   |   8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   |   3 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |  10 -
 drivers/net/wireless/realtek/rtw88/debug.h         |  12 +
 drivers/net/wireless/realtek/rtw88/fw.c            |  74 ++++
 drivers/net/wireless/realtek/rtw88/fw.h            |   3 +
 drivers/net/wireless/realtek/rtw88/main.h          |   6 +
 drivers/net/wireless/realtek/rtw88/ps.c            |   2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |  23 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  22 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  71 +--
 drivers/net/wireless/realtek/rtw89/phy.c           |  46 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   8 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   8 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  25 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  31 +-
 drivers/net/wireless/st/cw1200/txrx.c              |   2 +-
 drivers/net/wireless/ti/wl1251/main.c              |   2 +-
 drivers/net/wireless/ti/wl1251/tx.c                |   6 +-
 drivers/net/wireless/ti/wl18xx/main.c              |   5 +-
 drivers/net/wireless/ti/wlcore/boot.c              |   5 +-
 drivers/net/wireless/ti/wlcore/main.c              |   4 +-
 drivers/ssb/Kconfig                                |   3 +-
 include/linux/ieee80211.h                          |   3 +-
 include/net/cfg80211.h                             |  38 +-
 include/net/mac80211.h                             |  76 ++--
 include/uapi/linux/nl80211.h                       |   4 +-
 net/mac80211/cfg.c                                 |   6 +
 net/mac80211/debugfs_netdev.c                      |  28 +-
 net/mac80211/debugfs_netdev.h                      |  15 +-
 net/mac80211/driver-ops.c                          |  23 +-
 net/mac80211/driver-ops.h                          |  32 +-
 net/mac80211/ieee80211_i.h                         |   3 +-
 net/mac80211/iface.c                               |  10 +-
 net/mac80211/key.c                                 |   6 +-
 net/mac80211/link.c                                |   7 +-
 net/mac80211/main.c                                |   2 +-
 net/mac80211/mesh.c                                |   8 +-
 net/mac80211/mesh_hwmp.c                           |   2 +
 net/mac80211/mesh_pathtbl.c                        |  20 +-
 net/mac80211/mesh_plink.c                          |   6 +-
 net/mac80211/mesh_ps.c                             |   6 +-
 net/mac80211/mesh_sync.c                           |   4 +-
 net/mac80211/mlme.c                                |  43 +-
 net/mac80211/offchannel.c                          |  17 +
 net/mac80211/rx.c                                  |   9 +
 net/mac80211/sta_info.c                            |  60 ++-
 net/mac80211/status.c                              |   9 +-
 net/mac80211/tdls.c                                |   2 +-
 net/mac80211/util.c                                |  15 +-
 net/wireless/core.h                                |   4 +-
 net/wireless/mlme.c                                |   2 +-
 net/wireless/nl80211.c                             |   6 +-
 net/wireless/nl80211.h                             |   7 +-
 net/wireless/scan.c                                |  37 ++
 net/wireless/sme.c                                 |  23 +-
 net/wireless/trace.h                               |   2 +-
 net/wireless/util.c                                |   3 +-
 net/wireless/wext-compat.c                         |   4 +-
 193 files changed, 3558 insertions(+), 1724 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.h

