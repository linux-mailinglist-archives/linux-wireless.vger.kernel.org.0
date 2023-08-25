Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C47788866
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbjHYNWn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245109AbjHYNWf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 09:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A712115
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 06:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA9860C22
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 13:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0833C433C8;
        Fri, 25 Aug 2023 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692969751;
        bh=azTuqycw6ZYic62e7PFa7FJ758KJ8woNxVTFsfGG0Es=;
        h=From:Subject:To:Cc:Date:From;
        b=mMPrmp+cia4erl9cx5M66Ru3KF4qTbowsnTOSAkHIl8INV0XL5SismXdxbycVWeV1
         ZhjT1LZ0SImnVTqMSLTCIkWe80Z7OpuG1IuSYi1myzDNvDhzW0eDKCpfOaz4jLQTFo
         /4Np/muPXsq6dv34iNR+e59gpULrBzbqbQXLe9s/6LvGswBJEk4OpYeO8udOpRXB6S
         DrmY9UCvq6o1zzwZulWCjKA2DhCrpb4ywJrNTkgT95SNAwSCgt6RkluYc/NkatWoxM
         oSSKmryAnYrkuvSykTMEO7kadWMtwVOTfiqTAdAglDQQ7Vql1OlMiPOvm7fpvEWiR6
         g4zchwDs+Raiw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2023-08-25
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Message-Id: <20230825132230.A0833C433C8@smtp.kernel.org>
Date:   Fri, 25 Aug 2023 13:22:30 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit cb39c35783f26892bb1a72b1115c94fa2e77f4c5:

  pds_core: Fix some kernel-doc comments (2023-08-21 07:48:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2023-08-25

for you to fetch changes up to 4dddbad8907bc2ecda6e3714de3ea0a27b90a7d3:

  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2023-08-25 13:15:26 +0300)

----------------------------------------------------------------
wireless-next patches for v6.6

The second pull request for v6.6, this time with both stack and driver
changes. Unusually we have only one major new feature but lots of
small cleanup all over, I guess this is due to people have been on
vacation the last month.

Major changes:

rtw89

* Introduce Time Averaged SAR (TAS) support

----------------------------------------------------------------
Alan Stern (1):
      Fix nomenclature for USB and PCI wireless devices

Arnd Bergmann (2):
      mac80211: make ieee80211_tx_info padding explicit
      wifi: ath: remove unused-but-set parameter

Avraham Stern (5):
      wifi: iwlwifi: pcie: avoid a warning in case prepare card failed
      wifi: iwlmei: don't send SAP messages if AMT is disabled
      wifi: iwlmei: send HOST_GOES_DOWN message even if wiamt is disabled
      wifi: iwlmei: send driver down SAP message only if wiamt is enabled
      wifi: iwlmei: don't send nic info with invalid mac address

Cheng-Chieh Hsieh (1):
      wifi: rtw89: phy: modify register setting of ENV_MNTR, PHYSTS and DIG

Dan Carpenter (1):
      wifi: rtw89: fix a width vs precision bug

Dmitry Antipov (10):
      wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
      wifi: mwifiex: cleanup private data structures
      wifi: mwifiex: handle possible sscanf() errors
      wifi: mwifiex: handle possible mwifiex_write_reg() errors
      wifi: mwifiex: drop BUG_ON from TX paths
      wifi: mwifiex: cleanup adapter data
      wifi: mwifiex: fix comment typos in SDIO module
      wifi: ath9k: consistently use kstrtoX_from_user() functions
      wifi: cfg80211: improve documentation for flag fields
      wifi: mwifiex: avoid possible NULL skb pointer dereference

EN-WEI WU (1):
      wifi: mac80211_hwsim: avoid calling nlmsg_free() in IRQ or IRQ disabled

Fedor Pchelkin (2):
      wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
      wifi: ath9k: protect WMI command response buffer replacement with a lock

Gregory Greenman (1):
      wifi: iwlwifi: add Razer to ppag approved list

Herbert Xu (1):
      wifi: mac80211: Do not include crypto/algapi.h

Jeff Johnson (5):
      wifi: Fix ieee80211.h kernel-doc issues
      wifi: ath11k: Consistently use ath11k_vif_to_arvif()
      wifi: ath10k: Fix a few spelling errors
      wifi: ath11k: Fix a few spelling errors
      wifi: ath12k: Fix a few spelling errors

Jinjie Ruan (1):
      wifi: rtlwifi: rtl8723: Remove unused function rtl8723_cmd_send_packet()

Johannes Berg (17):
      wifi: iwlwifi: mvm: advertise MLO only if EHT is enabled
      wifi: iwlwifi: api: fix a small upper/lower-case typo
      wifi: iwlwifi: remove WARN from read_mem32()
      wifi: iwlwifi: pcie: clean up gen1/gen2 TFD unmap
      wifi: iwlwifi: remove 'def_rx_queue' struct member
      wifi: iwlwifi: pcie: move gen1 TB handling to header
      wifi: iwlwifi: queue: move iwl_txq_gen2_set_tb() up
      wifi: iwlwifi: pcie: point invalid TFDs to invalid data
      wifi: iwlwifi: mvm: enable HE TX/RX <242 tone RU on new RFs
      wifi: iwlwifi: mvm: support flush on AP interfaces
      wifi: mac80211: check S1G action frame size
      wifi: cfg80211: reject auth/assoc to AP with our address
      wifi: cfg80211: ocb: don't leave if not joined
      wifi: mac80211: check for station first in client probe
      wifi: mac80211_hwsim: drop short frames
      wifi: mac80211: fix puncturing bitmap handling in CSA
      Revert "wifi: mac80211_hwsim: check the return value of nla_put_u32"

Justin Stitt (1):
      wifi: ipw2x00: refactor to use kstrtoul

Kalle Valo (1):
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Kees Cook (7):
      wifi: cfg80211: Annotate struct cfg80211_acl_data with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_cqm_config with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_mbssid_elems with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_pmsr_request with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by
      wifi: cfg80211: Annotate struct cfg80211_tid_config with __counted_by

Krzysztof Kozlowski (2):
      wifi: ath11k: fix Wvoid-pointer-to-enum-cast warning
      wifi: ath10k: fix Wvoid-pointer-to-enum-cast warning

Kuan-Chung Chen (1):
      wifi: rtw89: Introduce Time Averaged SAR (TAS) feature

Li Zetao (2):
      wifi: wfx: Use devm_kmemdup to replace devm_kmalloc + memcpy
      wifi: wlcore: sdio: Use module_sdio_driver macro to simplify the code

Lin Ma (1):
      wifi: nl80211/cfg80211: add forgotten nla_policy for BSS color attribute

Mahmoud Maatuq (1):
      wifi: ath5k: ath5k_hw_get_median_noise_floor(): use swap()

Minjie Du (1):
      wifi: ath9k: fix parameter check in ath9k_init_debug()

Mukesh Sisodiya (1):
      wifi: iwlwifi: remove memory check for LMAC error address

Nathan Chancellor (1):
      wifi: rtw89: Fix clang -Wimplicit-fallthrough in rtw89_query_sar()

Ping-Ke Shih (6):
      wifi: rtw89: 8852b: rfk: fine tune IQK parameters to improve performance on 2GHz band
      wifi: rtw89: mac: add mac_gen_def::band1_offset to map MAC band1 register address
      wifi: rtw89: mac: generalize code to indirectly access WiFi internal memory
      wifi: rtw89: mac: define internal memory address for WiFi 7 chip
      wifi: rtw89: mac: define register address of rx_filter to generalize code
      wifi: rtw89: phy: add phy_gen_def::cr_base to support WiFi 7 chips

Polaris Pi (1):
      wifi: mwifiex: Fix missed return in oob checks failed path

Rajat Soni (1):
      wifi: ath12k: Fix memory leak in rx_desc and tx_desc

Randy Dunlap (3):
      wifi: cfg80211: remove dead/unused enum value
      wifi: radiotap: fix kernel-doc notation warnings
      wifi: mac80211: fix kernel-doc notation warning

Ruan Jinjie (4):
      wifi: mwifiex: use is_zero_ether_addr() instead of ether_addr_equal()
      wifi: ath5k: Remove redundant dev_err()
      wifi: ath9k: Remove unnecessary ternary operators
      wifi: ath: Use is_multicast_ether_addr() to check multicast Ether address

Sascha Hauer (1):
      wifi: rtw88: usb: kill and free rx urbs on probe failure

Shiji Yang (2):
      wifi: rt2x00: correct MAC_SYS_CTRL register RX mask in R-Calibration
      wifi: rt2x00: limit MT7620 TX power based on eeprom calibration

Sven Eckelmann (2):
      wifi: ath11k: Don't drop tx_status when peer cannot be found
      wifi: ath11k: Cleanup mac80211 references on failure during tx_complete

Wang Ming (1):
      wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Wen Gong (1):
      wifi: ath12k: add check max message length while scanning with extraie

Wu Yunchuan (9):
      wifi: rsi: rsi_91x_coex: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_debugfs: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_hal: Remove unnecessary conversions
      wifi: rsi: rsi_91x_mac80211: Remove unnecessary conversions
      wifi: rsi: rsi_91x_main: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_sdio: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_sdio_ops: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_usb: Remove unnecessary (void*) conversions
      wifi: rsi: rsi_91x_usb_ops: Remove unnecessary (void*) conversions

Yang Yingliang (2):
      wifi: rtlwifi: use eth_broadcast_addr() to assign broadcast address
      wifi: ath11k: simplify the code with module_platform_driver

Yue Haibing (8):
      wifi: ath9k: Remove unused declarations
      wifi: wext: Remove unused declaration dev_get_wireless_info()
      wifi: mac80211: Remove unused function declarations
      wifi: mac80211: mesh: Remove unused function declaration mesh_ids_set_default()
      wifi: nl80211: Remove unused declaration nl80211_pmsr_dump_results()
      wifi: wilc1000: Remove unused declarations
      wifi: ath11k: Remove unused declarations
      wifi: ath12k: Remove unused declarations

Zong-Zhe Yang (7):
      wifi: rtw89: regd: update regulatory map to R64-R43
      wifi: rtw89: add function prototype for coex request duration
      wifi: rtw89: refine rtw89_correct_cck_chan() by rtw89_hw_to_nl80211_band()
      wifi: rtw89: sar: let caller decide the center frequency to query
      wifi: rtw89: call rtw89_chan_get() by vif chanctx if aware of vif
      wifi: rtw89: provide functions to configure NoA for beacon update
      wifi: rtw89: initialize multi-channel handling

 drivers/net/wireless/ath/ath10k/ahb.c              |   2 +-
 drivers/net/wireless/ath/ath10k/htt.h              |   4 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   4 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |   2 +-
 drivers/net/wireless/ath/ath10k/usb.c              |   2 +-
 drivers/net/wireless/ath/ath10k/wmi.h              |   8 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |  14 +-
 drivers/net/wireless/ath/ath11k/ce.h               |   3 -
 drivers/net/wireless/ath/ath11k/dp.h               |   2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |  12 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  64 ++---
 drivers/net/wireless/ath/ath11k/pci.c              |   2 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |   2 -
 drivers/net/wireless/ath/ath11k/testmode.c         |   2 +-
 drivers/net/wireless/ath/ath12k/ce.h               |   3 -
 drivers/net/wireless/ath/ath12k/core.h             |   1 -
 drivers/net/wireless/ath/ath12k/dp.c               |  30 ++-
 drivers/net/wireless/ath/ath12k/dp.h               |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   7 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   2 -
 drivers/net/wireless/ath/ath12k/rx_desc.h          |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  20 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   2 -
 drivers/net/wireless/ath/ath5k/ahb.c               |   1 -
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |   1 -
 drivers/net/wireless/ath/ath5k/phy.c               |  27 +--
 drivers/net/wireless/ath/ath9k/ath9k.h             |   1 -
 drivers/net/wireless/ath/ath9k/common-spectral.c   |  53 ++--
 drivers/net/wireless/ath/ath9k/common.h            |   2 -
 drivers/net/wireless/ath/ath9k/debug.c             | 108 +++------
 drivers/net/wireless/ath/ath9k/dfs_debug.c         |  14 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c       |   3 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |  15 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   3 +-
 drivers/net/wireless/ath/ath9k/main.c              |   1 -
 drivers/net/wireless/ath/ath9k/tx99.c              |  14 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |  20 +-
 drivers/net/wireless/ath/key.c                     |   2 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |   8 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |  39 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   7 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c      |  70 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  31 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  24 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      | 142 ++++++-----
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |  26 +-
 .../net/wireless/intersil/orinoco/orinoco_usb.c    |  12 +-
 drivers/net/wireless/legacy/rndis_wlan.c           |   2 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |  19 +-
 drivers/net/wireless/marvell/mwifiex/decl.h        |   1 -
 drivers/net/wireless/marvell/mwifiex/init.c        |   2 -
 drivers/net/wireless/marvell/mwifiex/main.h        |  20 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   7 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  26 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |   1 +
 drivers/net/wireless/marvell/mwifiex/sta_tx.c      |  15 +-
 drivers/net/wireless/marvell/mwifiex/txrx.c        |  44 ++--
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |  26 +-
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig  |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig  |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |   2 +-
 drivers/net/wireless/mediatek/mt7601u/Kconfig      |   2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.h |   4 -
 drivers/net/wireless/purelifi/plfxlc/Kconfig       |   2 +-
 drivers/net/wireless/ralink/rt2x00/Kconfig         |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |  59 +++--
 drivers/net/wireless/realtek/rtlwifi/core.c        |   2 +-
 .../realtek/rtlwifi/rtl8723com/fw_common.c         |  28 ---
 .../realtek/rtlwifi/rtl8723com/fw_common.h         |   2 -
 drivers/net/wireless/realtek/rtw88/pci.c           |   2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   7 +-
 drivers/net/wireless/realtek/rtw89/chan.c          | 124 ++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h          |   5 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   3 +-
 drivers/net/wireless/realtek/rtw89/coex.h          |   9 +
 drivers/net/wireless/realtek/rtw89/core.c          | 124 +++++++---
 drivers/net/wireless/realtek/rtw89/core.h          | 104 ++++++++
 drivers/net/wireless/realtek/rtw89/debug.c         |  26 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  24 +-
 drivers/net/wireless/realtek/rtw89/mac.c           | 197 ++++++++-------
 drivers/net/wireless/realtek/rtw89/mac.h           |  69 ++++--
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  14 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  38 +++
 drivers/net/wireless/realtek/rtw89/pci.c           |   2 +-
 drivers/net/wireless/realtek/rtw89/phy.c           | 266 +++++++++++++++------
 drivers/net/wireless/realtek/rtw89/phy.h           | 114 ++++++++-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  77 ++++++
 drivers/net/wireless/realtek/rtw89/ps.c            |  75 +++++-
 drivers/net/wireless/realtek/rtw89/ps.h            |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h           |  38 +++
 drivers/net/wireless/realtek/rtw89/regd.c          |  27 ++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  19 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  24 +-
 drivers/net/wireless/realtek/rtw89/sar.c           | 220 ++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/sar.h           |  10 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |  20 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |   3 +-
 drivers/net/wireless/rsi/rsi_91x_coex.c            |  11 +-
 drivers/net/wireless/rsi/rsi_91x_debugfs.c         |   3 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c             |   2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   4 +-
 drivers/net/wireless/rsi/rsi_91x_main.c            |   4 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  39 ++-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c        |  15 +-
 drivers/net/wireless/rsi/rsi_91x_usb.c             |  20 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c         |   2 +-
 drivers/net/wireless/silabs/wfx/main.c             |   7 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |  13 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  18 +-
 drivers/net/wireless/zydas/zd1201.c                |   6 +-
 drivers/platform/x86/eeepc-laptop.c                |   2 +-
 drivers/staging/wlan-ng/prism2usb.c                |  48 ++--
 include/linux/ieee80211.h                          | 235 +++++++++++++-----
 include/net/cfg80211.h                             |  25 +-
 include/net/ieee80211_radiotap.h                   |   3 +-
 include/net/iw_handler.h                           |  11 +-
 include/net/mac80211.h                             |   5 +-
 net/mac80211/cfg.c                                 |  27 ++-
 net/mac80211/fils_aead.c                           |   2 +-
 net/mac80211/ieee80211_i.h                         |   2 -
 net/mac80211/key.c                                 |   2 +-
 net/mac80211/mesh.h                                |   1 -
 net/mac80211/rx.c                                  |   4 +
 net/mac80211/wpa.c                                 |   2 +-
 net/wireless/core.h                                |   2 +-
 net/wireless/mlme.c                                |  13 +
 net/wireless/nl80211.c                             |   8 +-
 net/wireless/nl80211.h                             |   1 -
 net/wireless/ocb.c                                 |   3 +
 net/wireless/pmsr.c                                |   3 +-
 150 files changed, 2231 insertions(+), 1154 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/mac_be.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/phy_be.c
