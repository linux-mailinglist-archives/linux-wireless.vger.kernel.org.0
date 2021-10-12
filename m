Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9942A5C5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhJLNgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbhJLNgC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 09:36:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23DC061570
        for <linux-wireless@vger.kernel.org>; Tue, 12 Oct 2021 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pNDk5WZ5ieLD07BYPODEcIZFJqQbHIn5y/wYEYNrggM=; b=YZUJvfr14c8acP6WjzOZrwshAR
        mZFZdf38LfOw8eQ3E2mAs/Hxt67cX0+8LUgWUIHBC4m2SMHQllXBZQ3b+KdUPJRw10NM0ua6QUJ4b
        qU99Ugq9yHJIAxkizl0XwkTlqrpiss5QLwWyqQilct9rP5QCrw3O93adunm6mCahlfMY=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1maHuo-0004RO-N7; Tue, 12 Oct 2021 15:33:58 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-10-11
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <f32b6609-b5bb-2da7-8971-b5c00b0f1d70@nbd.name>
Date:   Tue, 12 Oct 2021 15:33:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.16

- Felix

The following changes since commit 9b793db5fca44d01f72d3564a168171acf7c4076:

  b43: fix a lower bounds test (2021-10-11 09:09:30 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-10-12

for you to fetch changes up to 43b5c9d88078f790786643134f0febfef75541c5:

  mt76: do not access 802.11 header in ccmp check for 802.3 rx skbs (2021-10-12 15:23:17 +0200)

----------------------------------------------------------------
mt76 patches for 5.16

* various bugfixes
* endian fixes
* mt7921 aspm support
* cleanup
* mt7921 testmode support
* rate handling fixes
* tx status fixes/improvements
* mt7921 power management improvements
* mt7915 LED support
* DBDC fixes
* mt7921 6GHz support
* support for eeprom data in DT
* mt7915 TWT support

----------------------------------------------------------------
Ben Greear (9):
      mt76: mt7915: fix he_mcs capabilities for 160mhz
      mt76: mt7915: fix potential NPE in TXS processing
      mt76: mt7915: fix hwmon temp sensor mem use-after-free
      mt76: mt7915: add ethtool stats support
      mt76: mt7915: add tx stats gathered from tx-status callbacks
      mt76: mt7915: add some per-station tx stats to ethtool
      mt76: mt7915: add tx mu/su counters to mib
      mt76: mt7915: add more MIB registers
      mt76: mt7915: add mib counters to ethtool stats

Bo Jiao (2):
      mt76: mt7915: fix calling mt76_wcid_alloc with incorrect parameter
      mt76: mt7915: adapt new firmware to update BA winsize for Rx session

Christophe JAILLET (1):
      mt76: switch from 'pci_' to 'dma_' API

Dan Carpenter (1):
      mt76: mt7915: fix info leak in mt7915_mcu_set_pre_cal()

Daniel Golle (2):
      mt76: support reading EEPROM data embedded in fdt
      dt: bindings: net: mt76: add eeprom-data property

Deren Wu (4):
      mt76: mt7921: Fix out of order process by invalid event pkt
      mt76: mt7921: Add mt7922 support
      mt76: mt7921: fix dma hang in rmmod
      mt76: mt7921: add delay config for sched scan

Felix Fietkau (4):
      mt76: mt7615: fix skb use-after-free on mac reset
      mt76: mt7915: fix WMM index on DBDC cards
      mt76: disable BH around napi_schedule() calls
      mt76: do not access 802.11 header in ccmp check for 802.3 rx skbs

Leon Yen (2):
      mt76: connac: fix mt76_connac_gtk_rekey_tlv usage
      mt76: connac: fix GTK rekey offload failure on WPA mixed mode

Lorenzo Bianconi (46):
      mt76: mt7921: fix endianness in mt7921_mcu_tx_done_event
      mt76: mt7921: avoid unnecessary spin_lock/spin_unlock in mt7921_mcu_tx_done_event
      mt76: mt7915: fix endianness warning in mt7915_mac_add_txs_skb
      mt76: mt7921: fix endianness warning in mt7921_update_txs
      mt76: mt7615: fix endianness warning in mt7615_mac_write_txwi
      mt76: mt7921: fix survey-dump reporting
      mt76: mt76x02: fix endianness warnings in mt76x02_mac.c
      mt76: mt7921: introduce testmode support
      mt76: mt7921: get rid of monitor_vif
      mt76: mt7921: get rid of mt7921_mac_set_beacon_filter
      mt76: mt7921: introduce mt7921_mcu_set_beacon_filter utility routine
      mt76: overwrite default reg_ops if necessary
      mt76: mt7615: move mt7615_mcu_set_p2p_oppps in mt76_connac module
      mt76: mt7921: fix endianness warnings in mt7921_mac_decode_he_mu_radiotap
      mt76: mt7915: introduce bss coloring support
      mt76: mt7915: improve code readability in mt7915_mcu_sta_bfer_ht
      mt76: mt7921: move mt7921_queue_rx_skb to mac.c
      mt76: mt7921: always wake device if necessary in debugfs
      mt76: mt7921: update mib counters dumping phy stats
      mt76: mt7921: start reworking tx rate reporting
      mt76: mt7921: add support for tx status reporting
      mt76: mt7921: report tx rate directly from tx status
      mt76: mt7921: remove mcu rate reporting code
      mt76: mt7921: remove mt7921_sta_stats
      mt76: mt7915: honor all possible error conditions in mt7915_mcu_init()
      mt76: mt7915: fix possible infinite loop release semaphore
      mt76: connac: set 6G phymode in mt76_connac_get_phy_mode{,v2}
      mt76: connac: enable 6GHz band for hw scan
      mt76: connac: add 6GHz support to mt76_connac_mcu_set_channel_domain
      mt76: connac: set 6G phymode in single-sku support
      mt76: connac: add 6GHz support to mt76_connac_mcu_sta_tlv
      mt76: connac: add 6GHz support to mt76_connac_mcu_uni_add_bss
      mt76: connac: enable hw amsdu @ 6GHz
      mt76: add 6GHz support
      mt76: mt7921: add 6GHz support
      mt76: introduce packet_id idr
      mt76: remove mt76_wcid pointer from mt76_tx_status_check signature
      mt76: substitute sk_buff_head status_list with spinlock_t status_lock
      mt76: schedule status timeout at dma completion
      mt76: introduce __mt76_mcu_send_firmware routine
      mt76: mt7915: introduce __mt7915_get_tsf routine
      mt76: mt7915: introduce mt7915_mcu_twt_agrt_update mcu command
      mt76: mt7915: introduce mt7915_mac_add_twt_setup routine
      mt76: mt7915: enable twt responder capability
      mt76: mt7915: add twt_stats knob in debugfs
      mt76: debugfs: improve queue node readability

MeiChia Chiu (1):
      mt76: mt7915: add LED support

Ryder Lee (21):
      mt76: mt7915: report HE MU radiotap
      mt76: mt7915: fix an off-by-one bound check
      mt76: mt7915: take RCU read lock when calling ieee80211_bss_get_elem()
      mt76: mt7915: cleanup -Wunused-but-set-variable
      mt76: mt7915: report tx rate directly from tx status
      mt76: mt7915: remove mt7915_sta_stats
      mt76: mt7915: add a missing HT flag for GI parsing
      mt76: mt7915: add control knobs for thermal throttling
      mt76: mt7915: send EAPOL frames at lowest rate
      mt76: mt7921: send EAPOL frames at lowest rate
      mt76: add support for setting mcast rate
      mt76: mt7915: add HE-LTF into fixed rate command
      mt76: mt7915: update mac timing settings
      mt76: use IEEE80211_OFFLOAD_ENCAP_ENABLED instead of MT_DRV_AMSDU_OFFLOAD
      mt76: add a bound check in mt76_calculate_default_rate()
      mt76: mt7915: rework debugfs queue info
      mt76: mt7915: rename debugfs tx-queues
      mt76: fill boottime_ns in Rx path
      mt76: mt7915: enable configured beacon tx rate
      mt76: mt7615: fix hwmon temp sensor mem use-after-free
      mt76: mt7615: fix monitor mode tear down crash

Sean Wang (12):
      mt76: mt7921: enable aspm by default
      mt76: fix build error implicit enumeration conversion
      mt76: add mt76_default_basic_rate more devices can rely on
      mt76: mt7921: fix mgmt frame using unexpected bitrate
      mt76: mt7915: fix mgmt frame using unexpected bitrate
      mt76: mt7921: report HE MU radiotap
      mt76: mt7921: fix firmware usage of RA info using legacy rates
      mt76: mt7921: fix kernel warning from cfg80211_calculate_bitrate
      mt76: mt7921: fix the inconsistent state between bind and unbind
      mt76: mt7921: robustify hardware initialization flow
      mt76: mt7921: fix retrying release semaphore without end
      mt76: drop MCU header size from buffer size in __mt76_mcu_send_firmware

Shayne Chen (3):
      mt76: mt7915: fix potential overflow of eeprom page index
      mt76: mt7915: switch proper tx arbiter mode in testmode
      mt76: mt7915: fix bit fields for HT rate idx

Xing Song (1):
      mt76: use a separate CCMP PN receive counter for management frames

Xingbang Liu (1):
      mt76: move spin_lock_bh to spin_lock in tasklet

YN Chen (2):
      mt76: mt7921: add .set_sar_specs support
      mt76: connac: add support for limiting to maximum regulatory Tx power

jing yangyang (1):
      mt76: fix boolreturn.cocci warnings

 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |   5 +
 drivers/net/wireless/mediatek/mt76/debugfs.c                      |  19 +--
 drivers/net/wireless/mediatek/mt76/eeprom.c                       |  14 ++
 drivers/net/wireless/mediatek/mt76/mac80211.c                     | 214 +++++++++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mcu.c                          |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76.h                         |  82 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                  |   3 +
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c                   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |  29 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |  62 +++++----
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |  40 ++----
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |   2 -
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c                   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c                  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c              |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |   7 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              | 258 ++++++++++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  34 ++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c                   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |  15 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |  12 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c                 |   3 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c                   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               | 289 +++++++++++++++++++++++++-------------
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                  | 146 ++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   | 635 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h                   |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                  | 358 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 382 +++++++++++++++++++++-----------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |  76 ++++------
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                | 124 +++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  | 148 +++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |  29 ++++
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.h              |  10 ++
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile                |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               |  58 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   |  36 +----
 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c                |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  86 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   | 556 +++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h                   |  28 ++++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                  | 151 ++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   | 274 +++++++++++++++---------------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  63 +++------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  50 ++-----
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  18 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h                  |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c              | 197 ++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/sdio.c                         |   2 +-
 drivers/net/wireless/mediatek/mt76/testmode.c                     |   4 +-
 drivers/net/wireless/mediatek/mt76/testmode.h                     |   7 +
 drivers/net/wireless/mediatek/mt76/tx.c                           |  85 ++++++++----
 drivers/net/wireless/mediatek/mt76/usb.c                          |   2 +-
 59 files changed, 3428 insertions(+), 1271 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
