Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042C77000B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 14:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHDMQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjHDMQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 08:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62D46B1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 05:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB4B61E85
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 12:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A52C433C7;
        Fri,  4 Aug 2023 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691151392;
        bh=VxtKdnL0u7IB663qeSEBGzXzrGqA78k1o+pzRTRgsys=;
        h=From:To:Cc:Subject:Date:From;
        b=EQFMDtN1DhB2XOPaPIaWWAbuzp7/HlP79orKtfEG89BPv5XZLpIeobgBZei24yzGm
         RLMVKV3sHC5rHwYh9UIa4qcEptNHrh2pXSsO5dViwhnlLUD2azfa/XN86anVIBKH1X
         3xY8Ypce3ZSdcKqkuJ8p5OhmJjKvraDWRO1+q5fVvZ5YyG+L+ulmYEg0H0JH45LOGM
         mtqWsH6EBWE1vtJmeCEw00DC14O0cKrW0oBfiJTX9PkbOD/xxAEeGa3x72W9Jmx4C6
         0AVU9iZi0aA9hyW1lP9rUMfnjzJurxXnJpVbdcJl9z6VuiodtT2Byz3M7KAFTADei7
         iaT35AO1wQf6g==
From:   Kalle Valo <kvalo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: wireless-next-2023-08-04
Date:   Fri, 04 Aug 2023 15:16:29 +0300
Message-ID: <87msz7j942.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

here's a pull request to net-next tree, more info below. Please let me know=
 if
there are any problems.

Kalle

The following changes since commit f5f80e32de12fad2813d37270e8364a03e6d3ef0:

  ipv6: remove hard coded limitation on ipv6_pinfo (2023-07-24 09:39:31 +01=
00)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git =
tags/wireless-next-2023-08-04

for you to fetch changes up to 904b102f1ebb67b91f1e90783a480fc473c986dd:

  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/a=
th.git (2023-08-03 21:16:27 +0300)

----------------------------------------------------------------
wireless-next patches for v6.6

The first pull request for v6.6 and only driver patches this time.
Nothing special really standing out, it has been quiet most likely due
to vacations.

Major changes:

rtl8xxxu

* enable AP mode for: RTL8192FU, RTL8710BU (RTL8188GU), RTL8192EU and RTL87=
23BU

mwifiex

* allow moving to a different namespace

mt76

* preparation for mt7925 support

* mt7981 support

ath12k

* Extremely High Throughput (EHT) PHY support for Wi-Fi 7

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: ath11k: fix band selection for ppdu received in channel 177 of =
5 GHz

Alexander Couzens (1):
      wifi: mt76: mt7915: add support for MT7981

Aloka Dixit (9):
      wifi: ath12k: rename HE capabilities setup/copy functions
      wifi: ath12k: move HE capabilities processing to a new function
      wifi: ath12k: WMI support to process EHT capabilities
      wifi: ath12k: propagate EHT capabilities to userspace
      wifi: ath12k: prepare EHT peer assoc parameters
      wifi: ath12k: add WMI support for EHT peer
      wifi: ath12k: peer assoc for 320 MHz
      wifi: ath12k: parse WMI service ready ext2 event
      wifi: ath12k: configure puncturing bitmap

Amisha Patel (1):
      wifi: wilc1000: add SPI commands retry mechanism

Anilkumar Kolli (1):
      wifi: ath11k: Add coldboot calibration support for QCN9074

Arnd Bergmann (1):
      wifi: ath12k: fix memcpy array overflow in ath12k_peer_assoc_h_he()

Azeem Shaikh (1):
      wifi: mt76: Replace strlcpy() with strscpy()

Baochen Qiang (1):
      wifi: ath12k: Use pdev_id rather than mac_id to get pdev

Ben Greear (1):
      wifi: mt76: mt7921: Support temp sensor

Bitterblue Smith (4):
      wifi: rtl8xxxu: Enable AP mode for RTL8192FU
      wifi: rtl8xxxu: Enable AP mode for RTL8710BU (RTL8188GU)
      wifi: rtl8xxxu: Enable AP mode for RTL8192EU
      wifi: rtl8xxxu: Enable AP mode for RTL8723BU

Bo Jiao (2):
      wifi: mt76: mt7915: disable WFDMA Tx/Rx during SER recovery
      wifi: mt76: mt7996: disable WFDMA Tx/Rx during SER recovery

Chin-Yen Lee (2):
      wifi: rtw89: recognize log format from firmware file
      wifi: rtw89: support firmware log with formatted text

Christian Marangi (2):
      wifi: mt76: split get_of_eeprom in subfunction
      wifi: mt76: add support for providing eeprom in nvmem cells

Daniel Golle (1):
      dt-bindings: net: wireless: mt76: add bindings for MT7981

Deren Wu (3):
      wifi: mt76: mt7921: do not support one stream on secondary antenna on=
ly
      wifi: mt76: mt7921e: report tx retries/failed counts in tx free event
      wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU

Dmitry Antipov (21):
      wifi: ath9k: avoid using uninitialized array
      wifi: ath9k: fix fortify warnings
      wifi: rtw88: delete timer and free skb queue when unloading
      wifi: rtw88: remove unused and set but unused leftovers
      wifi: rtw88: remove unused USB bulkout size set
      wifi: rtw88: simplify vif iterators
      wifi: mwifiex: prefer strscpy() over strlcpy()
      wifi: mwifiex: fix fortify warning
      wifi: brcmsmac: remove unused data type
      wifi: wil6210: fix fortify warnings
      wifi: libertas: add missing calls to cancel_work_sync()
      wifi: libertas: use convenient lists to manage SDIO packets
      wifi: libertas: simplify list operations in free_if_spi_card()
      wifi: libertas: cleanup SDIO reset
      wifi: libertas: handle possible spu_write_u16() errors
      wifi: libertas: prefer kstrtoX() for simple integer conversions
      wifi: brcmsmac: remove more unused data types
      wifi: brcmsmac: cleanup SCB-related data types
      wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
      wifi: ath11k: simplify ath11k_mac_validate_vht_he_fixed_rate_settings=
()
      wifi: ath12k: relax list iteration in ath12k_mac_vif_unref()

Dongliang Mu (1):
      wifi: ath9k: fix printk specifier

Felix Fietkau (4):
      wifi: mt76: mt7915: fix capabilities in non-AP mode
      wifi: mt76: mt7915: remove VHT160 capability on MT7915
      wifi: mt76: mt7603: fix beacon interval after disabling a single vif
      wifi: mt76: mt7603: fix tx filter/flush function

Howard Hsu (1):
      wifi: mt76: mt7996: increase tx token size

Johannes Wiesboeck (1):
      wifi: mwifiex: Set WIPHY_FLAG_NETNS_OK flag

Kalle Valo (2):
      Merge tag 'mt76-for-kvalo-2023-07-31' of https://github.com/nbd168/wi=
reless
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kva=
lo/ath.git

Larry Finger (1):
      wifi: rtw89: Fix loading of compressed firmware

Lin Ma (1):
      wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH

Lorenzo Bianconi (49):
      wifi: mt76: mt7921: remove macro duplication in regs.h
      wifi: mt76: mt7915: move mib_stats structure in mt76.h
      wifi: mt76: mt7996: rely on mib_stats shared definition
      wifi: mt76: mt7921: rely on mib_stats shared definition
      wifi: mt76: mt7921: make mt7921_mac_sta_poll static
      mt76: mt7996: rely on mt76_sta_stats in mt76_wcid
      wifi: mt76: mt7921: get rid of MT7921_RESET_TIMEOUT marco
      wifi: mt76: mt7915: move sta_poll_list and sta_poll_lock in mt76_dev
      wifi: mt76: mt7603: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7615: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7996: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7921: rely on shared sta_poll_list and sta_poll_lock
      wifi: mt76: mt7915: move poll_list in mt76_wcid
      wifi: mt76: mt7603: rely on shared poll_list field
      wifi: mt76: mt7615: rely on shared poll_list field
      wifi: mt76: mt7996: rely on shared poll_list field
      wifi: mt76: mt7921: rely on shared poll_list field
      wifi: mt76: move ampdu_state in mt76_wcid
      mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
      wifi: mt76: move rate info in mt76_vif
      wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h
      wifi: mt76: connac: add connac3 mac library
      wifi: mt76: mt7921: move common register definition in mt792x_regs.h
      wifi: mt76: mt7921: convert acpisar and clc pointers to void
      wifi: mt76: mt7921: rename mt7921_vif in mt792x_vif
      wifi: mt76: mt7921: rename mt7921_sta in mt792x_sta
      wifi: mt76: mt7921: rename mt7921_phy in mt792x_phy
      wifi: mt76: mt7921: rename mt7921_dev in mt792x_dev
      wifi: mt76: mt7921: rename mt7921_hif_ops in mt792x_hif_ops
      wifi: mt76: mt792x: move shared structure definition in mt792x.h
      wifi: mt76: mt7921: move mt792x_mutex_{acquire/release} in mt792x.h
      wifi: mt76: mt7921: move mt792x_hw_dev in mt792x.h
      wifi: mt76: mt792x: introduce mt792x-lib module
      wifi: mt76: mt7921: move mac shared code in mt792x-lib module
      wifi: mt76: mt7921: move dma shared code in mt792x-lib module
      wifi: mt76: mt7921: move debugfs shared code in mt792x-lib module
      wifi: mt76: mt7921: move init shared code in mt792x-lib module
      wifi: mt76: mt792x: introduce mt792x_irq_map
      wifi: mt76: mt792x: move more dma shared code in mt792x_dma
      wifi: mt76: mt7921: move hif_ops macro in mt792x.h
      wifi: mt76: mt7921: move shared runtime-pm code on mt792x-lib
      wifi: mt76: mt7921: move runtime-pm pci code in mt792x-lib
      wifi: mt76: mt7921: move acpi_sar code in mt792x-lib module
      wifi: mt76: mt792x: introduce mt792x-usb module
      wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module
      wifi: mt76: mt76_connac3: move lmac queue enumeration in mt76_connac3=
_mac.h
      wifi: mt76: mt792x: move MT7921_PM_TIMEOUT and MT7921_HW_SCAN_TIMEOUT=
 in common code
      wifi: mt76: mt7921: move mt7921_dma_init in pci.c
      wifi: mt76: mt7921: move mt7921u_disconnect mt792x-lib

Matt Whitlock (1):
      mt76: mt7921: don't assume adequate headroom for SDIO headers

MeiChia Chiu (1):
      wifi: mt76: mt7996: add muru support

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix non-PSC channel scan fail

Minjie Du (1):
      wifi: ath5k: remove phydir check from ath5k_debug_init_device()

Muna Sinada (1):
      wifi: ath12k: add EHT PHY modes

Peter Chiu (7):
      wifi: mt76: mt7915: rework tx packets counting when WED is active
      wifi: mt76: mt7915: rework tx bytes counting when WED is active
      wifi: mt76: report non-binding skb tx rate when WED is active
      wifi: mt76: connac: add support for dsp firmware download
      wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command
      wifi: mt76: mt7996: enable VHT extended NSS BW feature
      wifi: mt76: connac: add support to set ifs time by mcu command

Ping-Ke Shih (15):
      wifi: rtw89: add chip_info::chip_gen to determine chip generation
      wifi: rtw89: define hardware rate v1 for WiFi 7 chips
      wifi: rtw89: use struct to set RA H2C command
      wifi: rtw89: add H2C RA command V1 to support WiFi 7 chips
      wifi: rtw89: use struct to access firmware C2H event header
      wifi: rtw89: use struct to access RA report
      wifi: rtw89: add C2H RA event V1 to support WiFi 7 chips
      wifi: rtw89: add to display hardware rates v1 histogram in debugfs
      wifi: rtw89: get data rate mode/NSS/MCS v1 from RX descriptor
      wifi: rtw89: introduce v1 format of firmware header
      wifi: rtw89: add firmware parser for v1 format
      wifi: rtw89: add firmware suit for BB MCU 0/1
      wifi: rtw89: introduce infrastructure of firmware elements
      wifi: rtw89: add to parse firmware elements of BB and RF tables
      wifi: rtw89: return failure if needed firmware elements are not recog=
nized

Polaris Pi (1):
      wifi: mwifiex: Fix OOB and integer underflow when rx packets

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: add MLO header in peer association

Prasurjya Rohan Saikia (1):
      wifi: wilc1000: remove use of has_thrpt_enh3 flag

Rafa=C5=82 Mi=C5=82ecki (1):
      dt-bindings: mt76: support pointing to EEPROM using NVMEM cell

Rany Hany (1):
      wifi: mt76: mt7915: fix command timeout in AP stop period

Rob Herring (1):
      wifi: drivers: Explicitly include correct DT includes

Ryder Lee (11):
      wifi: mt76: mt7996: fix header translation logic
      wifi: mt76: mt7996: enable BSS_CHANGED_MU_GROUPS support
      wifi: mt76: mt7615: enable BSS_CHANGED_MU_GROUPS support
      wifi: mt76: enable UNII-4 channel 177 support
      wifi: mt76: mt7915: report tx retries/failed counts for non-WED path
      wifi: mt76: mt7915: drop return in mt7915_sta_statistics
      wifi: mt76: mt7996: drop return in mt7996_sta_statistics
      wifi: mt76: add tx_nss histogram to ethtool stats
      wifi: mt76: mt7915: accumulate mu-mimo ofdma muru stats
      wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
      wifi: mt76: mt7915: fix power-limits while chan_switch

Seevalamuthu Mariappan (2):
      wifi: ath11k: Split coldboot calibration hw_param
      wifi: ath11k: Remove cal_done check during probe

Shayne Chen (1):
      wifi: mt76: mt7996: move radio ctrl commands to proper functions

StanleyYP Wang (3):
      wifi: mt76: mt7915: fix background radar event being blocked
      wifi: mt76: mt7996: use correct phy for background radar event
      wifi: mt76: mt7996: fix WA event ring size

Wang Ming (1):
      wifi: ath6kl: Remove error checking for debugfs_create_dir()

Wen Gong (7):
      wifi: ath12k: Fix a NULL pointer dereference in ath12k_mac_op_hw_scan=
()
      wifi: ath12k: correct the data_type from QMI_OPT_FLAG to QMI_UNSIGNED=
_1_BYTE for mlo_capable
      wifi: ath12k: avoid array overflow of hw mode for preferred_hw_mode
      wifi: ath12k: trigger station disconnect on hardware restart
      wifi: ath12k: change to use dynamic memory for channel list of scan
      wifi: ath12k: add handler for scan event WMI_SCAN_EVENT_DEQUEUED
      wifi: ath12k: avoid deadlock by change ieee80211_queue_work for regd_=
update_work

Yuanjun Gong (1):
      wifi: mt76: mt76x02: fix return value check in mt76x02_mac_process_rx

Yueh-Shun Li (1):
      wifi: zd1211rw: fix typo "tranmits"

Zhang Shurong (1):
      wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual=
_set()

Zong-Zhe Yang (1):
      wifi: rtw89: phy: rate pattern handles HW rate by chip gen

 .../bindings/net/wireless/mediatek,mt76.yaml       |  13 +-
 drivers/net/wireless/ath/ath10k/ahb.c              |   2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |  29 +-
 drivers/net/wireless/ath/ath11k/core.c             |  38 +-
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath11k/hw.h               |   3 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   4 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   2 +
 drivers/net/wireless/ath/ath11k/qmi.c              |  35 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |   3 +-
 drivers/net/wireless/ath/ath12k/core.h             |  34 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  11 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   8 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 589 +++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              | 260 ++++++-
 drivers/net/wireless/ath/ath12k/wmi.h              | 119 ++-
 drivers/net/wireless/ath/ath5k/debug.c             |   2 -
 drivers/net/wireless/ath/ath6kl/debug.c            |   2 -
 drivers/net/wireless/ath/ath9k/ahb.c               |   4 +-
 drivers/net/wireless/ath/ath9k/mac.h               |   6 +-
 drivers/net/wireless/ath/ath9k/pci.c               |   4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   6 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |   3 +-
 drivers/net/wireless/ath/wil6210/txrx.c            |   2 +-
 drivers/net/wireless/ath/wil6210/txrx.h            |   6 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c       |   2 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.h       |   6 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.h |   8 -
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |   6 -
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   8 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |   2 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h      |   5 -
 .../net/wireless/broadcom/brcm80211/brcmsmac/pub.h |   2 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/scb.h |  14 -
 .../wireless/broadcom/brcm80211/brcmsmac/types.h   |   9 -
 drivers/net/wireless/intersil/orinoco/airport.c    |   2 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c    |  73 +-
 drivers/net/wireless/marvell/libertas/if_spi.c     |  20 +-
 drivers/net/wireless/marvell/libertas/mesh.c       |  51 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   1 +
 drivers/net/wireless/marvell/mwifiex/main.c        |  11 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  25 +-
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  11 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |   9 +-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |  19 +
 drivers/net/wireless/marvell/mwifiex/util.c        |  10 +-
 drivers/net/wireless/mediatek/mt76/Kconfig         |   8 +
 drivers/net/wireless/mediatek/mt76/Makefile        |  10 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   6 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |  89 ++-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   6 +
 drivers/net/wireless/mediatek/mt76/mt76.h          | 106 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |   2 -
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  43 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |  25 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h   |   7 +
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |  31 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |  49 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |   4 -
 .../wireless/mediatek/mt76/mt7615/mt7615_trace.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h   |   9 +
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  18 +
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  | 182 +++++
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  | 339 +++++++++
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   | 106 ++-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig  |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/coredump.c   |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    | 124 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    | 152 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |  20 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 194 ++---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 233 ++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    | 151 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |  47 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 100 +--
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |  16 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    | 163 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig  |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile |   9 +-
 .../net/wireless/mediatek/mt76/mt7921/acpi_sar.h   | 105 ---
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    | 228 +-----
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   | 343 ++-------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 554 ++------------
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 806 +++++------------=
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    | 230 ++----
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 355 ++-------
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    | 225 +++---
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |  34 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mcu.c    |  71 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h   | 465 +-----------
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |  32 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c   |  14 +-
 .../net/wireless/mediatek/mt76/mt7921/testmode.c   |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7921/trace.c  |  12 -
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    | 207 ++---
 .../net/wireless/mediatek/mt76/mt7921/usb_mac.c    | 255 -------
 drivers/net/wireless/mediatek/mt76/mt792x.h        | 367 +++++++++
 .../mt76/{mt7921/acpi_sar.c =3D> mt792x_acpi_sar.c}  | 128 ++--
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   | 105 +++
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   | 844 +++++++++++++++++=
++++
 .../net/wireless/mediatek/mt76/mt792x_debugfs.c    | 168 ++++
 .../mediatek/mt76/{mt7921/dma.c =3D> mt792x_dma.c}   | 476 ++++++------
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    | 385 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   | 479 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt792x_trace.c  |  14 +
 .../mt76/{mt7921/mt7921_trace.h =3D> mt792x_trace.h} |  16 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    | 309 ++++++++
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  83 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 300 ++------
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    | 315 +-------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 114 +--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 182 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  17 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  94 +--
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  25 +-
 drivers/net/wireless/mediatek/mt76/testmode.c      |   1 +
 drivers/net/wireless/mediatek/mt76/trace.h         |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |  16 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.h     |   2 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     | 103 +--
 drivers/net/wireless/microchip/wilc1000/spi.c      | 150 ++--
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |   2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c |   2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c |   2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |   2 +
 drivers/net/wireless/realtek/rtw88/fw.c            |   2 +-
 drivers/net/wireless/realtek/rtw88/main.c          |  13 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   9 -
 drivers/net/wireless/realtek/rtw88/ps.c            |   6 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |   2 -
 drivers/net/wireless/realtek/rtw88/usb.c           |  18 -
 drivers/net/wireless/realtek/rtw88/usb.h           |   7 -
 drivers/net/wireless/realtek/rtw88/util.c          |   7 +-
 drivers/net/wireless/realtek/rtw88/util.h          |   3 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  32 +-
 drivers/net/wireless/realtek/rtw89/core.h          | 246 +++++-
 drivers/net/wireless/realtek/rtw89/debug.c         |  57 +-
 drivers/net/wireless/realtek/rtw89/fw.c            | 664 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h            | 368 ++++-----
 drivers/net/wireless/realtek/rtw89/mac.c           |   3 +-
 drivers/net/wireless/realtek/rtw89/phy.c           | 108 ++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   2 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |  47 +-
 drivers/net/wireless/silabs/wfx/bus_sdio.c         |   2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |   2 +-
 165 files changed, 8291 insertions(+), 5775 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x.h
 rename drivers/net/wireless/mediatek/mt76/{mt7921/acpi_sar.c =3D> mt792x_a=
cpi_sar.c} (64%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_core.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
 rename drivers/net/wireless/mediatek/mt76/{mt7921/dma.c =3D> mt792x_dma.c}=
 (55%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_trace.c
 rename drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h =3D> mt79=
2x_trace.h} (68%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_usb.c
