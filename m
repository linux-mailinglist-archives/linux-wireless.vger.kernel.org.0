Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270057CABA9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 16:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjJPOi1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjJPOi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 10:38:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB6AB
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 07:38:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880D8C433C8;
        Mon, 16 Oct 2023 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697467103;
        bh=lC1q/rxBn1EVe0iVn+GQabdR2avsASTHtSuzWrrtFKo=;
        h=From:Subject:To:Cc:Date:From;
        b=GzpeZLZGetIBs0py3OIoYVA/1QwECPyMivc5Cxdcxfrsttl+OknXQKDOGserHXJgV
         zWTuOAX5Rov9Pseh+kEF37kbuChEjOyPxMS7rFEqHvldDKyqb+lM5b/7Qg2XG8ZByo
         tzTF6wrOgiI54Dp2VIsgWfRNEif4ZsB8tJtvbwVN84QM5wz53jqS7J9AzRMI0tTXW/
         EPDa2IOVm+Bqg8om3KLEajMEbjb9425BfE0nLtxjVh0jdpmwnO2uV8QCU8FrRflN0X
         x6HR5Wkpi0LCL5m3d3oDMDUKCHNoRNB//W48bhfA9KXkABNbe4KPnnbJHCNxNDGI9H
         mUMgbLaUZ/JSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2023-10-16
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Message-Id: <20231016143822.880D8C433C8@smtp.kernel.org>
Date:   Mon, 16 Oct 2023 14:38:22 +0000 (UTC)
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

The following changes since commit 48533eca606efcf63ef4080ded5618e0b17ee3d7:

  net: sock_dequeue_err_skb() optimization (2023-10-06 16:29:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2023-10-16

for you to fetch changes up to b650981501bf00bc84f09cf3b3e0b6190cfed794:

  wifi: rtw89: mac: do bf_monitor only if WiFi 6 chips (2023-10-14 09:43:32 +0300)

----------------------------------------------------------------
wireless-next patches for v6.7

The second pull request for v6.7, with only driver changes this time.
We have now support for mt7925 PCIe and USB variants, few new features
and of course some fixes.

Major changes:

mt76

* mt7925 support

ath12k

* read board data variant name from SMBIOS

wfx

* Remain-On-Channel (ROC) support

----------------------------------------------------------------
Aditya Kumar Singh (2):
      wifi: ath11k: fix CAC running state during virtual interface start
      wifi: ath11k: fix Tx power value during active CAC

Allen Ye (1):
      wifi: mt76: check sta rx control frame to multibss capability

Arnd Bergmann (2):
      wifi: atmel: remove unused ioctl function
      wifi: hostap: remove unused ioctl function

Benjamin Lin (1):
      wifi: mt76: mt7996: remove periodic MPDU TXS request

Bo Jiao (1):
      wifi: mt76: fix potential memory leak of beacon commands

Chank Chen (1):
      wifi: mt76: connac: add MBSSID support for mt7996

Christophe JAILLET (2):
      wifi: ath: dfs_pattern_detector: Fix a memory initialization issue
      wifi: ath: dfs_pattern_detector: Use flex array to simplify code

Deren Wu (10):
      wifi: mt76: connac: introduce helper for mt7925 chipset
      wifi: mt76: mt792x: support mt7925 chip init
      wifi: mt76: connac: export functions for mt7925
      wifi: mt76: connac: add eht support for phy mode config
      wifi: mt76: connac: add eht support for tx power
      wifi: mt76: connac: add data field in struct tlv
      wifi: mt76: connac: add more unified command IDs
      wifi: mt76: connac: add more unified event IDs
      wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips
      wifi: mt76: mt7921: move connac nic capability handling to mt7921

Dmitry Antipov (7):
      wifi: mt76: add DMA mapping error check in mt76_alloc_txwi()
      wifi: mt76: fix clang-specific fortify warnings
      wifi: ath10k: consistently use kstrtoX_from_user() functions
      wifi: ath10k: simplify ath10k_peer_create()
      wifi: rtlwifi: use unsigned long for bt_coexist_8723 timestamp
      wifi: rtlwifi: use convenient list_count_nodes()
      wifi: rtlwifi: simplify TX command fill callbacks

Douglas Anderson (1):
      wifi: ath10k: Don't touch the CE interrupt registers after power up

Felipe Negrelli Wolter (1):
      wifi: wfx: fix case where rates are out of order

Felix Fietkau (9):
      wifi: mt76: mt7603: rework/fix rx pse hang check
      wifi: mt76: mt7603: improve watchdog reset reliablity
      wifi: mt76: mt7603: improve stuck beacon handling
      wifi: mt76: mt7603: add missing register initialization for MT7628
      wifi: mt76: mt7603: disable A-MSDU tx support on MT7628
      wifi: mt76: fix race condition related to checking tx queue fill status
      wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb
      wifi: mt76: mt7915: fix monitor mode issues
      wifi: mt76: mt7915 add tc offloading support

Gustavo A. R. Silva (2):
      wifi: hostap: Add __counted_by for struct prism2_download_data and use struct_size()
      wifi: brcmfmac: fweh: Add __counted_by for struct brcmf_fweh_queue_item and use struct_size()

Hari Chandrakanthan (1):
      wifi: ath12k: do not drop data frames from unassociated stations

Howard Hsu (3):
      wifi: mt76: mt7996: fix beamform mcu cmd configuration
      wifi: mt76: mt7996: fix beamformee ss subfield in EHT PHY cap
      wifi: mt76: mt7996: support more options for mt7996_set_bitrate_mask()

Ingo Rohloff (1):
      wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi Redmibook 15 Pro (2023)

Jen-Hao Cheng (1):
      wifi: mt76: mt7996: support per-band LED control

Jinjie Ruan (3):
      wifi: mt76: Use PTR_ERR_OR_ZERO() to simplify code
      wifi: mt76: Drop unnecessary error check for debugfs_create_dir()
      wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()

Johannes Berg (1):
      wifi: mt76: use atomic iface iteration for pre-TBTT work

Jérôme Pouiller (8):
      wifi: wfx: fix power_save setting when AP is stopped
      wifi: wfx: relocate wfx_rate_mask_to_hw()
      wifi: wfx: move wfx_skb_*() out of the header file
      wifi: wfx: introduce hif_scan_uniq()
      wifi: wfx: simplify exclusion between scan and Rx filters
      wifi: wfx: scan_lock is global to the device
      wifi: wfx: allow to send frames during ROC
      wifi: wfx: implement wfx_remain_on_channel()

Kalle Valo (3):
      wifi: ath12k: fix debug messages
      Merge tag 'mt76-for-kvalo-2023-09-30' of https://github.com/nbd168/wireless
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Kees Cook (2):
      wifi: mt76: Annotate struct mt76_rx_tid with __counted_by
      wifi: p54: Annotate struct p54_cal_database with __counted_by

Lorenzo Bianconi (2):
      wifi: mt76: mt792x: move mt7921_skb_add_usb_sdio_hdr in mt792x module
      wifi: mt76: mt792x: move some common usb code in mt792x module

Ma Ke (1):
      wifi: ath12k: mhi: fix potential memory leak in ath12k_mhi_register()

MeiChia Chiu (2):
      wifi: mt76: update beacon size limitation
      wifi: mt76: mt7915: fix beamforming availability check

Ming Yen Hsieh (4):
      wifi: mt76: mt7921: enable set txpower for UNII-4
      wifi: mt76: mt7921: add 6GHz power type support for clc
      wifi: mt76: mt7921: get regulatory information from the clc event
      wifi: mt76: mt7921: update the channel usage when the regd domain changed

Peter Chiu (6):
      wifi: mt76: mt7996: set correct wcid in txp
      wifi: mt76: mt7996: fix wmm queue mapping
      wifi: mt76: mt7996: fix rx rate report for CBW320-2
      wifi: mt76: mt7996: fix TWT command format
      wifi: mt76: check vif type before reporting cca and csa
      wifi: mt76: mt7915: update mpdu density capability

Ping-Ke Shih (9):
      wifi: radiotap: add bandwidth definition of EHT U-SIG
      wifi: rtw89: parse EHT information from RX descriptor and PPDU status packet
      wifi: rtw89: Add EHT rate mask as parameters of RA H2C command
      wifi: rtw89: parse TX EHT rate selected by firmware from RA C2H report
      wifi: rtw89: show EHT rate in debugfs
      wifi: rtw89: add EHT radiotap in monitor mode
      wifi: rtw89: coex: add annotation __counted_by() for struct rtw89_btc_btf_set_slot_table
      wifi: rtw89: coex: add annotation __counted_by() to struct rtw89_btc_btf_set_mon_reg
      wifi: rtw89: mac: add registers of MU-EDCA parameters for WiFi 7 chips

Sean Wang (4):
      wifi: mt76: move struct ieee80211_chanctx_conf up to struct mt76_vif
      wifi: mt76: mt7921: fix the wrong rate pickup for the chanctx driver
      wifi: mt76: mt7921: fix the wrong rate selected in fw for the chanctx driver
      wifi: mt76: reduce spin_lock_bh held up in mt76_dma_rx_cleanup

Shayne Chen (2):
      wifi: mt76: mt7996: only set vif teardown cmds at remove interface
      wifi: mt76: fix per-band IEEE80211_CONF_MONITOR flag comparison

StanleyYP Wang (1):
      wifi: mt76: get rid of false alamrs of tx emission issues

Wen Gong (3):
      wifi: ath12k: add read variant from SMBIOS for download board data
      wifi: ath12k: add keep backward compatibility of PHY mode to avoid firmware crash
      wifi: ath10k: indicate to mac80211 scan complete with aborted flag for ATH10K_SCAN_STARTING state

Wu Yunchuan (1):
      wifi: carl9170: remove unnecessary (void*) conversions

Yi-Chia Hsieh (3):
      wifi: mt76: mt7996: get tx_retries and tx_failed from txfree
      wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic
      wifi: mt76: mt7996: enable PPDU-TxS to host

Zong-Zhe Yang (10):
      wifi: rtw88: regd: configure QATAR and UK
      wifi: rtw88: 8821c: update TX power limit to V67
      wifi: rtw88: 8822c: update TX power limit to V70
      wifi: rtw88: regd: update regulatory map to R64-R42
      wifi: rtw88: 8821c: tweak CCK TX filter setting for SRRC regulation
      wifi: rtw89: mac: update RTS threshold according to chip gen
      wifi: rtw89: mac: generalize register of MU-EDCA switch according to chip gen
      wifi: rtw89: mac: set bfee_ctrl() according to chip gen
      wifi: rtw89: mac: set bf_assoc capabilities according to chip gen
      wifi: rtw89: mac: do bf_monitor only if WiFi 6 chips

 drivers/net/wireless/ath/ath10k/debug.c            |   47 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   26 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |   18 +-
 drivers/net/wireless/ath/ath10k/spectral.c         |   26 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   27 +-
 drivers/net/wireless/ath/ath12k/core.c             |   69 +
 drivers/net/wireless/ath/ath12k/core.h             |   21 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   12 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   65 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |   11 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    5 +
 drivers/net/wireless/ath/ath12k/wmi.h              |    3 +
 drivers/net/wireless/ath/carl9170/usb.c            |   10 +-
 drivers/net/wireless/ath/dfs_pattern_detector.c    |   21 +-
 drivers/net/wireless/atmel/atmel.c                 |   72 -
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |    6 +-
 drivers/net/wireless/intersil/hostap/hostap.h      |    1 -
 .../net/wireless/intersil/hostap/hostap_download.c |    3 +-
 .../net/wireless/intersil/hostap/hostap_ioctl.c    |  228 --
 drivers/net/wireless/intersil/hostap/hostap_main.c |    3 -
 drivers/net/wireless/intersil/hostap/hostap_wlan.h |    2 +-
 drivers/net/wireless/intersil/p54/p54.h            |    2 +-
 drivers/net/wireless/mediatek/mt76/Kconfig         |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile        |    1 +
 drivers/net/wireless/mediatek/mt76/debugfs.c       |    2 -
 drivers/net/wireless/mediatek/mt76/dma.c           |   14 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |    7 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   62 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   36 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |   80 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c   |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |    8 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |   52 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    6 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   18 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   28 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  191 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   60 +-
 .../net/wireless/mediatek/mt76/mt76x02_beacon.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |   11 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |   13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   24 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   53 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   79 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   18 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    4 +
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   54 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   69 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |  155 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h    |   13 +
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |   18 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    2 +
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig  |   30 +
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |    9 +
 .../net/wireless/mediatek/mt76/mt7925/debugfs.c    |  319 ++
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  235 ++
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    | 1452 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mac.h    |   23 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 1454 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 3174 ++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |  537 ++++
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  309 ++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |  586 ++++
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  148 +
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |   53 +
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |   92 +
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |  332 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   38 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   49 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |    9 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   50 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  115 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   65 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  359 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   37 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |    8 +
 drivers/net/wireless/mediatek/mt76/tx.c            |  108 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.c   |    9 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192se/fw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/trx.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/trx.h   |    4 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c   |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/dm.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/trx.c   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.c   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.h   |    1 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |    3 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    4 +-
 drivers/net/wireless/realtek/rtw88/regd.c          |   24 +-
 drivers/net/wireless/realtek/rtw88/regd.h          |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   67 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |    1 +
 .../net/wireless/realtek/rtw88/rtw8821c_table.c    | 1154 +++++--
 .../net/wireless/realtek/rtw88/rtw8822c_table.c    | 1239 ++++----
 drivers/net/wireless/realtek/rtw88/usb.c           |    9 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |   23 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  127 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   11 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   14 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   57 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   22 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   16 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  174 ++
 drivers/net/wireless/realtek/rtw89/phy.c           |   70 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    5 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   79 +
 drivers/net/wireless/silabs/wfx/data_tx.c          |  125 +-
 drivers/net/wireless/silabs/wfx/data_tx.h          |   21 +-
 drivers/net/wireless/silabs/wfx/hif_tx.c           |   43 +
 drivers/net/wireless/silabs/wfx/hif_tx.h           |    1 +
 drivers/net/wireless/silabs/wfx/main.c             |    5 +
 drivers/net/wireless/silabs/wfx/queue.c            |   38 +-
 drivers/net/wireless/silabs/wfx/queue.h            |    1 +
 drivers/net/wireless/silabs/wfx/scan.c             |   66 +-
 drivers/net/wireless/silabs/wfx/scan.h             |    6 +
 drivers/net/wireless/silabs/wfx/sta.c              |   41 +-
 drivers/net/wireless/silabs/wfx/sta.h              |    1 -
 drivers/net/wireless/silabs/wfx/wfx.h              |    8 +-
 include/linux/pci_ids.h                            |    2 +
 include/net/ieee80211_radiotap.h                   |    6 +
 154 files changed, 12734 insertions(+), 2292 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/usb.c

