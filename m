Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A693A2A82
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhFJLn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLn6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 07:43:58 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52B2C061574
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UeTHBiQOuxdspo77Xj7iZVly5tOGa4YuuWB5g/wBF80=; b=eM9FWC6egNbEx91gH7DGImW6bg
        +9Qfvv0sXPBjrBJkr4JrLZntZrGnt0qkBhYMxJDaBZ9omA7zc8k7f6LAx+TP3am+CMePv/C6OBG4U
        I7w/w8kX7NY8bnPwcl1kJmgWA+gpkBqzIiJJGKIg/dMtvD2PRke9TJ/aZCN+mE926DNA=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lrJ4S-0000ZP-Cv; Thu, 10 Jun 2021 13:42:00 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-06-10
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <7e509477-cb3d-9d18-7386-d989cbeeb178@nbd.name>
Date:   Thu, 10 Jun 2021 13:41:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.14

- Felix

The following changes since commit 080f9c10c773df39ccebe8dc414179d9179005a9:

  ipw2x00: Minor documentation update (2021-06-03 12:33:55 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-10

for you to fetch changes up to c3dfa83c3e625e111874295076557b7dddadda13:

  mt76: mt7915: drop the use of repeater entries for station interfaces (2021-06-10 13:39:41 +0200)

----------------------------------------------------------------
mt76 patches for 5.14

* mt7915 MSI support
* disable ASPM on mt7915
* mt7915 tx status reporting
* mt7921 decap offload
* driver fixes
* cleanups
* mt7921 runtime power management improvements
* testmode improvements/fixes

----------------------------------------------------------------
Dan Carpenter (1):
      mt76: mt7915: fix a signedness bug in mt7915_mcu_apply_tx_dpd()

Deren Wu (4):
      mt76: connac: update BA win size in Rx direction
      mt76: mt7921: introduce mac tx done handling
      mt76: mt7921: update statistic in active mode only
      mt76: mt7921: enable random mac address during sched_scan

Evelyn Tsai (1):
      mt76: mt7915: fix tssi indication field of DBDC NICs

Felix Fietkau (14):
      mt76: mt7915: add MSI support
      mt76: mt7915: disable ASPM
      mt76: mt7915: move mt7915_queue_rx_skb to mac.c
      mt76: mt7615: fix fixed-rate tx status reporting
      mt76: mt7615: avoid use of ieee80211_tx_info_clear_status
      mt76: mt7603: avoid use of ieee80211_tx_info_clear_status
      mt76: intialize tx queue entry wcid to 0xffff by default
      mt76: improve tx status codepath
      mt76: dma: use ieee80211_tx_status_ext to free packets when tx fails
      mt76: mt7915: rework tx rate reporting
      mt76: mt7915: add support for tx status reporting
      mt76: mt7915: improve error recovery reliability
      mt76: mt7921: enable VHT BFee capability
      mt76: mt7915: drop the use of repeater entries for station interfaces

Lorenzo Bianconi (30):
      mt76: move mt76_rates in mt76 module
      mt76: mt7921: enable rx hw de-amsdu
      mt76: connac: add missing configuration in mt76_connac_mcu_wtbl_hdr_trans_tlv
      mt76: mt7921: enable rx header traslation offload
      mt76: mt7921: enable rx csum offload
      mt76: fix possible NULL pointer dereference in mt76_tx
      mt76: mt7615: fix NULL pointer dereference in tx_prepare_skb()
      mt76: mt76x0: use dev_debug instead of dev_err for hw_rf_ctrl
      mt76: mt7615: free irq if mt7615_mmio_probe fails
      mt76: mt7663: enable hw rx header translation
      mt76: mt7921: enable runtime pm by default
      mt76: mt7921: return proper error value in mt7921_mac_init
      mt76: mt7921: do not schedule hw reset if the device is not running
      mt76: mt7921: reset wfsys during hw probe
      mt76: mt7615: remove useless if condition in mt7615_add_interface()
      mt76: testmode: fix memory leak in mt76_testmode_alloc_skb
      mt76: testmode: remove unnecessary function calls in mt76_testmode_free_skb
      mt76: testmode: remove undefined behaviour in mt76_testmode_alloc_skb
      mt76: allow hw driver code to overwrite wiphy interface_modes
      mt76: mt7921: set MT76_RESET during mac reset
      mt76: mt7921: enable hw offloading for wep keys
      mt76: mt7921: remove mt7921_get_wtbl_info routine
      mt76: connac: fix UC entry is being overwritten
      mt76: connac: add mt76_connac_power_save_sched in mt76_connac_pm_unref
      mt76: mt7921: wake the device before dumping power table
      mt76: mt7921: make mt7921_set_channel static
      mt76: connac: add mt76_connac_mcu_get_nic_capability utility routine
      mt76: reduce rx buffer size to 2048
      mt76: move mt76_get_next_pkt_id in mt76.h
      mt76: connac: check band caps in mt76_connac_mcu_set_rate_txpower

Ryder Lee (12):
      mt76: mt7915: cleanup mt7915_mcu_sta_rate_ctrl_tlv()
      mt76: mt7915: add .set_bitrate_mask() callback
      mt76: mt7915: add thermal sensor device support
      mt76: mt7915: add thermal cooling device support
      mt76: mt7615: add thermal sensor device support
      mt76: mt7915: add .offset_tsf callback
      mt76: mt7615: add .offset_tsf callback
      mt76: mt7615: fix potential overflow on large shift
      mt76: mt7915: use mt7915_mcu_get_mib_info() to get survey data
      mt76: mt7915: setup drr group for peers
      mt76: mt7615: update radar parameters
      mt76: mt7915: fix MT_EE_CAL_GROUP_SIZE

Sean Wang (12):
      mt76: mt7921: fix mt7921_wfsys_reset sequence
      mt76: mt7921: Don't alter Rx path classifier
      mt76: connac: fw_own rely on all packet memory all being free
      mt76: mt7921: fix reset under the deep sleep is enabled
      mt76: mt7921: enable deep sleep at runtime
      mt76: mt7921: add deep sleep control to runtime-pm knob
      mt76: mt7921: consider the invalid value for to_rssi
      mt76: mt7921: add back connection monitor support
      mt76: mt7921: avoid unnecessary consecutive WiFi resets
      mt76: mt7921: fix invalid register access in wake_work
      mt76: mt7921: fix OMAC idx usage
      mt76: connac: fix the maximum interval schedule scan can support

Shayne Chen (4):
      mt76: mt7915: use mt7915_mcu_get_txpower_sku() to get per-rate txpower
      mt76: mt7915: read all eeprom fields from fw in efuse mode
      mt76: testmode: move chip-specific stats dump before common stats
      mt76: mt7915: fix rx fcs error count in testmode

YN Chen (2):
      mt76: connac: fix WoW with disconnetion and bitmap pattern
      mt76: connac: add bss color support for sta mode

 drivers/net/wireless/mediatek/mt76/dma.c             |  19 ++--
 drivers/net/wireless/mediatek/mt76/mac80211.c        |  49 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h            |  36 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c     |  32 +------
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c  |  20 -----
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c      |  13 +--
 drivers/net/wireless/mediatek/mt76/mt7615/init.c     |  85 +++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  31 +++----
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  42 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  91 +++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c     |  11 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   |  10 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c |  10 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c  |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h     |   2 +
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c |  11 +--
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     |  16 +++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |   6 ++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 184 ++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  55 +++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |  16 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  |  63 ++-----------
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c      |  45 ++--------
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |  44 +++++----
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h   |  13 +--
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 160 ++++++++++++++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 340 ++++++++++++++++++++++++++++++++++++++++------------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h      |  56 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     | 103 ++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 470 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |  51 ++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |  33 ++++---
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c      |  41 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |  27 +-----
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |  21 ++++-
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  |  21 +++++
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c      |  22 ++---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  92 +++++++------------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 206 ++++++++++++++++++++++++++++---------------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h      |  14 +++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 129 +++++++++++++--------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 161 ++++++++++++++++++---------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h      | 143 ++++++------------------------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |  10 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  25 ++++--
 drivers/net/wireless/mediatek/mt76/sdio.c            |   1 +
 drivers/net/wireless/mediatek/mt76/testmode.c        |  35 ++++----
 drivers/net/wireless/mediatek/mt76/tx.c              |  82 ++++++++++-------
 drivers/net/wireless/mediatek/mt76/usb.c             |   1 +
 51 files changed, 2031 insertions(+), 1126 deletions(-)
