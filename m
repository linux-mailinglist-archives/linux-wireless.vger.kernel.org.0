Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997993ACF17
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhFRPeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhFRPdk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 11:33:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72178C07E5E4
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4ALC628ge3BUX/FZmp3cnF5lv/DgeJT0fJDSL4l/zec=; b=DORXYZv8V3ic97sZPxVnBM3KuB
        aCiAmxakYiREhom+0F09aBzSBWVdOQCY96satdyg6sRVwAiRxHA/HZEdD833Sx9F++BdQ914Kf2of
        gsbPfPqar+dkiHbhO/Qzy3VYn9mTEDjjbjx95kHlFzJ5QfaoZ2UuT0nUEINnjQWdkIaE=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1luGO9-0004gZ-RF; Fri, 18 Jun 2021 17:26:33 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-06-18
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <3369c6a7-1fa5-7f9a-2d50-867d61dce304@nbd.name>
Date:   Fri, 18 Jun 2021 17:26:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's an updated version of my first pull request for 5.14

- Felix

The following changes since commit 0c33795231bff5df410bd405b569c66851e92d4b:

  Merge tag 'wireless-drivers-next-2021-06-16' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-06-16 12:59:42 -0700)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-18

for you to fetch changes up to 6edc39a381a0842d6dd5dc073879fcaee08e9989:

  mt76: mt7921: allow chip reset during device restart (2021-06-18 17:18:09 +0200)

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
* runtime PM improvements

----------------------------------------------------------------
Dan Carpenter (1):
      mt76: mt7915: fix a signedness bug in mt7915_mcu_apply_tx_dpd()

Deren Wu (5):
      mt76: connac: update BA win size in Rx direction
      mt76: mt7921: introduce mac tx done handling
      mt76: mt7921: update statistic in active mode only
      mt76: mt7921: enable random mac address during sched_scan
      mt76: mt7921: enable HE BFee capability

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

Lorenzo Bianconi (40):
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
      mt76: mt7921: improve code readability for mt7921_update_txs
      mt76: mt7921: limit txpower according to userlevel power
      mt76: mt7921: introduce dedicated control for deep_sleep
      mt76: disable TWT capabilities for the moment
      mt76: sdio: do not run mt76_txq_schedule directly
      mt76: mt7663s: rely on pm reference counting
      mt76: mt7663s: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
      mt76: mt7663s: enable runtime-pm
      mt76: mt7615: set macwork timeout according to runtime-pm
      mt76: mt7921: allow chip reset during device restart

Ryder Lee (17):
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
      mt76: make mt76_update_survey() per phy
      mt76: mt7915: introduce mt7915_mcu_set_txbf()
      mt76: mt7915: improve MU stability
      mt76: mt7915: fix IEEE80211_HE_PHY_CAP7_MAX_NC for station mode
      mt76: fix iv and CCMP header insertion

Sean Wang (14):
      mt76: mt7921: fix mt7921_wfsys_reset sequence
      mt76: mt7921: Don't alter Rx path classifier
      mt76: connac: fw_own rely on all packet memory all being free
      mt76: mt7921: fix reset under the deep sleep is enabled
      mt76: mt7921: consider the invalid value for to_rssi
      mt76: mt7921: add back connection monitor support
      mt76: mt7921: avoid unnecessary consecutive WiFi resets
      mt76: mt7921: fix invalid register access in wake_work
      mt76: mt7921: fix OMAC idx usage
      mt76: connac: fix the maximum interval schedule scan can support
      mt76: mt7921: enable deep sleep at runtime
      mt76: mt7921: add deep sleep control to runtime-pm knob
      mt76: mt7921: fix kernel warning when reset on vif is not sta
      mt76: mt7921: fix the coredump is being truncated

Shayne Chen (4):
      mt76: mt7915: use mt7915_mcu_get_txpower_sku() to get per-rate txpower
      mt76: mt7915: read all eeprom fields from fw in efuse mode
      mt76: testmode: move chip-specific stats dump before common stats
      mt76: mt7915: fix rx fcs error count in testmode

Tom Rix (2):
      mt76: add a space between comment char and SPDX tag
      mt76: use SPDX header file comment style

YN Chen (2):
      mt76: connac: fix WoW with disconnetion and bitmap pattern
      mt76: connac: add bss color support for sta mode

 drivers/net/wireless/mediatek/mt76/dma.c              |  19 ++-
 drivers/net/wireless/mediatek/mt76/mac80211.c         |  64 +++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h             |  56 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c      |  32 +----
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |  43 ++++---
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h      |  12 --
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c   |  22 +---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  85 +++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 156 +++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h       |  42 ------
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  60 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |  99 +++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c      |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  19 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c  |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c   |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |   2 +
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.h      |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  39 ++++--
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c |  16 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  |  11 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h      |  19 ++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  | 228 ++++++++++++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  72 ++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |  36 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h      |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h     |  18 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |  16 +--
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |  78 +++---------
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |  45 +------
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  44 +++----
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c      | 177 ++++++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c       | 384 +++++++++++++++++++++++++++++++------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h       |  56 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c      | 103 ++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 673 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |  80 ++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |  39 ++++--
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |  41 +++++-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |  32 ++---
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c  |  21 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.h  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c   |  37 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c       |  22 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/init.c      |  99 ++++++--------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c       | 248 +++++++++++++++++++++++-------------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h       |  14 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 172 +++++++++++++------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       | 203 +++++++++++++++--------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       | 166 ++++++------------------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |  20 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  34 +++--
 drivers/net/wireless/mediatek/mt76/sdio.c             |  17 ++-
 drivers/net/wireless/mediatek/mt76/testmode.c         |  35 +++--
 drivers/net/wireless/mediatek/mt76/tx.c               |  82 +++++++-----
 drivers/net/wireless/mediatek/mt76/usb.c              |   1 +
 64 files changed, 2613 insertions(+), 1561 deletions(-)
