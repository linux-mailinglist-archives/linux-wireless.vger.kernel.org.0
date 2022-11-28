Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CAE63A4BE
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 10:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiK1JWQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 04:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiK1JWP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 04:22:15 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E922186E4
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 01:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=apYWHMM8Xqwt0k1x+5naY8EOkXmhAGDNJyFHFapiCnQ=; b=LLW4T+gkK6XM3bPoirtCn/pYd+
        mnYQRchrMxoWvAcuA3SQBEb9K9MzSU0mmkcfegWesVgPJA03/2/5+h538DxMtkMaG2M+0nSzFhSMw
        dbEgWx3EsWbtur1S/5KW8KtvoKYCsLlo7k9qcbpGhB6Bq0pL4bzHCUj+ykXAfPnu3U6A=;
Received: from p200300daa7225c0824436b361c345cd2.dip0.t-ipconnect.de ([2003:da:a722:5c08:2443:6b36:1c34:5cd2] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ozaL4-004yk2-04; Mon, 28 Nov 2022 10:22:10 +0100
Message-ID: <b305eea9-3dd5-0e5e-7726-0eb7c6d0e242@nbd.name>
Date:   Mon, 28 Nov 2022 10:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2022-11-28
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's a replacement for my first pull request for 6.2
The update includes sparse warning / compile fixes and some other fixes

- Felix

The following changes since commit 3b79d4bad3a0e73d9becb409a5f6112bc61e2c93:

   wifi: p54: Replace zero-length array of trailing structs with flex-array (2022-11-22 12:17:12 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-11-28

for you to fetch changes up to bb5123e295f0c5ba5c1e33016de3f98cba44c035:

   wifi: mt76: mt7921: Add missing __packed annotation of struct mt7921_clc (2022-11-28 10:18:52 +0100)

----------------------------------------------------------------
mt76 patches for 6.2

- fixes
- WED support for mt7986 + mt7915 for flow offloading
- new driver for the mt7996 wifi-7 chipset

----------------------------------------------------------------
Ben Greear (2):
       wifi: mt76: mt7915: fix bounds checking for tx-free-done command
       Revert "mt76: use IEEE80211_OFFLOAD_ENCAP_ENABLED instead of MT_DRV_AMSDU_OFFLOAD"

Bo Jiao (2):
       wifi: mt76: mt7915: rework mt7915_dma_reset()
       wifi: mt76: mt7915: enable full system reset support

Deren Wu (2):
       wifi: mt76: fix coverity overrun-call in mt76_get_txpower()
       wifi: mt76: mt7921: Add missing __packed annotation of struct mt7921_clc

Evelyn Tsai (2):
       wifi: mt76: mt7915: reserve 8 bits for the index of rf registers
       wifi: mt76: connac: update nss calculation in txs

Felix Fietkau (2):
       wifi: mt76: move mt76_rate_power from core to mt76x02 driver code
       wifi: mt76: mt76x02: simplify struct mt76x02_rate_power

Gaosheng Cui (1):
       wifi: mt76: Remove unused inline function mt76_wcid_mask_test()

Howard Hsu (1):
       wifi: mt76: mt7915: fix incorrect tx path number configuration

Lorenzo Bianconi (13):
       wifi: mt76: mt7915: move wed init routines in mmio.c
       wifi: mt76: mt7915: enable wed for mt7986 chipset
       wifi: mt76: mt7915: enable wed for mt7986-wmac chipset
       wifi: mt76: mt7915: fix reporting of TX AGGR histogram
       wifi: mt76: mt7921: fix reporting of TX AGGR histogram
       wifi: mt76: mt7615: rely on mt7615_phy in mt7615_mac_reset_counters
       wifi: mt76: move aggr_stats array in mt76_phy
       wifi: mt76: do not run mt76u_status_worker if the device is not running
       wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf
       wifi: mt76: add WED RX support to mt76_dma_rx_fill
       wifi: mt76: add WED RX support to dma queue alloc
       wifi: mt76: mt7915: enable WED RX support
       wifi: mt76: mt76x0: remove dead code in mt76x0_phy_get_target_power

Ming Yen Hsieh (1):
       wifi: mt76: fix bandwidth 80MHz link fail in 6GHz band

Nicolas Cavallari (4):
       wifi: mt76: mt7915: fix antenna selection with bad eeprom.
       wifi: mt76: mt7915: Fix chainmask calculation on mt7915 DBDC
       wifi: mt76: mt7915: Fix VHT beamforming capabilities with DBDC
       wifi: mt76: mt7915: don't claim 160MHz support with mt7915 DBDC

Peter Chiu (1):
       wifi: mt76: mt7915: deal with special variant of mt7916

Quan Zhou (1):
       wifi: mt76: mt7921: add unified ROC cmd/event support

Ryder Lee (13):
       wifi: mt76: mt7915: fix mt7915_mac_set_timing()
       wifi: mt76: mt7915: improve accuracy of time_busy calculation
       wifi: mt76: mt7915: add ack signal support
       wifi: mt76: mt7915: enable use_cts_prot support
       wifi: mt76: mt7615: enable use_cts_prot support
       wifi: mt76: mt7915: add full system reset into debugfs
       wifi: mt76: mt7915: enable coredump support
       wifi: mt76: mt7915: add missing MODULE_PARM_DESC
       wifi: mt76: mt7915: add support to configure spatial reuse parameter set
       wifi: mt76: mt7915: add basedband Txpower info into debugfs
       wifi: mt76: mt7915: enable .sta_set_txpwr support
       wifi: mt76: mt7915: fix band_idx usage
       wifi: mt76: mt7915: fix endianness of mt7915_mcu_set_obss_spr_pd()

Sean Wang (7):
       wifi: mt76: mt7921: fix antenna signal are way off in monitor mode
       wifi: mt76: connac: add mt76_connac_mcu_uni_set_chctx
       wifi: mt76: mt7921: add chanctx parameter to mt76_connac_mcu_uni_add_bss signature
       wifi: mt76: mt7921: drop ieee80211_[start, stop]_queues in driver
       wifi: mt76: connac: accept hw scan request at a time
       wifi: mt76: mt7921: introduce remain_on_channel support
       wifi: mt76: mt7921: introduce chanctx support

Shayne Chen (14):
       wifi: mt76: mt7915: rework eeprom tx paths and streams init
       wifi: mt76: mt7915: rework testmode tx antenna setting
       wifi: mt76: connac: introduce mt76_connac_spe_idx()
       wifi: mt76: mt7915: add spatial extension index support
       wifi: mt76: mt7915: set correct antenna for radar detection on MT7915D
       wifi: mt76: connac: rework macros for unified command
       wifi: mt76: connac: update struct sta_rec_phy
       wifi: mt76: connac: rework fields for larger bandwidth support in sta_rec_bf
       wifi: mt76: connac: add more unified command IDs
       wifi: mt76: connac: introduce unified event table
       wifi: mt76: connac: add more bss info command tags
       wifi: mt76: connac: add more starec command tags
       wifi: mt76: connac: introduce helper for mt7996 chipset
       wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices

Sujuan Chen (4):
       wifi: mt76: introduce rxwi and rx token utility routines
       wifi: mt76: add info parameter to rx_skb signature
       wifi: mt76: connac: introduce mt76_connac_mcu_sta_wed_update utility routine
       wifi: mt76: mt7915: enable WED RX stats

YN Chen (1):
       wifi: mt76: mt7921: fix wrong power after multiple SAR set

  drivers/net/wireless/mediatek/mt76/Kconfig           |    1 +
  drivers/net/wireless/mediatek/mt76/Makefile          |    1 +
  drivers/net/wireless/mediatek/mt76/debugfs.c         |   19 -
  drivers/net/wireless/mediatek/mt76/dma.c             |  244 +++++++---
  drivers/net/wireless/mediatek/mt76/dma.h             |    8 +
  drivers/net/wireless/mediatek/mt76/mac80211.c        |   27 +-
  drivers/net/wireless/mediatek/mt76/mt76.h            |   50 ++-
  drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c  |    2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/dma.c      |    2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |    6 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h   |    2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c  |    6 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |   34 +-
  drivers/net/wireless/mediatek/mt76/mt7615/main.c     |    7 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |    2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   |    6 +-
  drivers/net/wireless/mediatek/mt76/mt7615/regs.h     |    2 +
  drivers/net/wireless/mediatek/mt76/mt76_connac.h     |   16 +
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |   17 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  210 ++++++---
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   99 ++++-
  drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c   |   28 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.h   |    2 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/init.c     |    2 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/phy.c      |   13 +-
  drivers/net/wireless/mediatek/mt76/mt76x02.h         |   16 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c |   19 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h  |    2 -
  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     |    6 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_phy.c     |   22 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_phy.h     |    6 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c    |   14 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c   |   16 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h   |    2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/init.c     |    2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/phy.c      |    6 +-
  drivers/net/wireless/mediatek/mt76/mt7915/Kconfig    |    1 +
  drivers/net/wireless/mediatek/mt76/mt7915/Makefile   |    3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/coredump.c |  410 +++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7915/coredump.h |  136 ++++++
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  |  115 +++--
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c      |  195 ++++++--
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |   58 +--
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h   |    5 -
  drivers/net/wireless/mediatek/mt76/mt7915/init.c     |  129 ++++--
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |  491 +++++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  134 ++++--
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  462 +++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |   41 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |  414 +++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |   64 ++-
  drivers/net/wireless/mediatek/mt76/mt7915/pci.c      |   93 +---
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |   88 +++-
  drivers/net/wireless/mediatek/mt76/mt7915/soc.c      |   21 +-
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |   38 +-
  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  |    2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |   91 +++-
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |   56 +--
  drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  233 +++++++++-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |  161 ++++++-
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |   74 +++-
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |   43 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c     |   31 +-
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c      |   22 +-
  drivers/net/wireless/mediatek/mt76/mt7996/Kconfig    |   12 +
  drivers/net/wireless/mediatek/mt76/mt7996/Makefile   |    6 +
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c  |  851 +++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c      |  360 +++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c   |  229 ++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h   |   75 ++++
  drivers/net/wireless/mediatek/mt76/mt7996/init.c     |  816 ++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 2468 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/mac.h      |  398 +++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/main.c     | 1325 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 3429 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h      |  662 ++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c     |  385 ++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h   |  516 ++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/pci.c      |  222 ++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h     |  533 ++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/sdio.c            |    2 +-
  drivers/net/wireless/mediatek/mt76/tx.c              |   30 ++
  drivers/net/wireless/mediatek/mt76/usb.c             |   13 +-
  drivers/net/wireless/mediatek/mt76/util.h            |    6 -
  84 files changed, 15976 insertions(+), 890 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/coredump.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Makefile
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/dma.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/init.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/main.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/pci.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/regs.h
