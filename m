Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8601F308BB0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jan 2021 18:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhA2Ren (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jan 2021 12:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhA2RcU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jan 2021 12:32:20 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380CC061756
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jan 2021 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:Subject:From:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3/+ptPh9GhcYasBGEZ47/dgKF6stDiUMqnuwSjcYF38=; b=MHyHkzdUl6NbNrALhvg0EzhDXM
        ng1oKZye7S8FOLghb14Y8TGsLWQ5mPURFkS0pCDgv5vTbU7Ba0XByDlBoyIkBU7uagB3MtjLf06d6
        4NjVlBBlduUq+dNA5BHbulRxVCjGjKUXIPLV2QoacLkTrQRJ74+5+cH6s1G62iqHVsuQ=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l5XcO-0004Sx-Vn; Fri, 29 Jan 2021 18:31:37 +0100
To:     Kalle Valo <kvalo@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-01-29
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <3eba5570-7cff-f51e-4050-aa0054f98f81@nbd.name>
Date:   Fri, 29 Jan 2021 18:31:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.12.

The following changes since commit 4832bb371c4175ffb506a96accbb08ef2b2466e7:

  iwl4965: do not process non-QOS frames on txq->sched_retry path (2021-01-25 16:43:27 +0200)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-01-29

for you to fetch changes up to d2bf7959d9c0f631ef860edaf834d55773fdedff:

  mt76: mt7663: introduce coredump support (2021-01-29 18:10:02 +0100)

----------------------------------------------------------------
mt76 patches for 5.12

* add new mt7921e driver
* factor out common code shared between 7615/7663 and 7921
* performance optimizations
* 7915 dbdc fixes
* 802.11 encap offload support
* support for multiple pcie gen1 host interfaces on 7915
* 7915 testmode support
* bugfixes
* testmode support enhancements
* endian fixes
* 7915 txbf support

----------------------------------------------------------------
Felix Fietkau (15):
      mt76: mt7603: fix ED/CCA monitoring with single-stream devices
      mt76: mt7915: ensure that init work completes before starting the device
      mt76: mt7915: do not set DRR group for stations
      mt76: mt7915: rework mcu API
      mt76: mt7915: disable RED support in the WA firmware
      mt76: mt7915: fix eeprom parsing for DBDC
      mt76: mt7915: fix eeprom DBDC band selection
      mt76: mt7615: unify init work
      mt76: mt7915: bring up the WA event rx queue for band1
      mt76: fix crash on tearing down ext phy
      mt76: mt7915: add support for using a secondary PCIe link for gen1
      mt76: mt7915: make vif index per adapter instead of per band
      mt76: move vif_mask back from mt76_phy to mt76_dev
      mt76: reduce q->lock hold time
      mt76: mt7615: reduce VHT maximum MPDU length

Lorenzo Bianconi (19):
      mt76: mt7915: run mt7915_configure_filter holding mt76 mutex
      mt76: mt7915: fix endianness warning in mt7915_mcu_set_radar_th
      mt76: mt7915: simplify mt7915_mcu_send_message routine
      mt76: move mac_work in mt76_core module
      mt76: move chainmask in mt76_phy
      mt76: mt7615: set mcu country code in mt7615_mcu_set_channel_domain()
      mt76: usb: process URBs with status EPROTO properly
      mt76: introduce mt76_vif data structure
      mt76: mt76_connac: create mcu library
      mt76: mt76_connac: move hw_scan and sched_scan routine in mt76_connac_mcu module
      mt76: mt76_connac: move WoW and suspend code in mt76_connac_mcu module
      mt76: mt76_connac: move pm data struct in mt76_connac.h
      mt76: mt76_connac: move pm utility routines in mt76_connac_lib module
      mt76: mt7921: rely on mt76_connac_mcu common library
      mt76: mt7921: rely on mt76_connac_mcu module for sched_scan and hw_scan
      mt76: mt7921: rely on mt76_connac_mcu module for suspend and WoW support
      mt76: mt7921: introduce regdomain notifier support
      mt76: mt7921: enable MSI interrupts
      mt76: mt7663: introduce coredump support

Ryder Lee (9):
      mt76: mt7915: add vif check in mt7915_update_vif_beacon()
      mt76: mt7615: add vif check in mt7615_update_vif_beacon()
      mt76: mt7915: fix MT_CIPHER_BIP_CMAC_128 setkey
      mt76: mt7915: reset token when mac_reset happens
      mt76: mt7615: reset token when mac_reset happens
      mt76: mt7915: drop zero-length packet to avoid Tx hang
      mt76: mt7915: simplify peer's TxBF capability check
      mt76: mt7915: add implicit Tx beamforming support
      mt76: mt7915: support TxBF for DBDC

Sean Wang (14):
      mt76: mt7921: add MAC support
      mt76: mt7921: add MCU support
      mt76: mt7921: add DMA support
      mt76: mt7921: add EEPROM support
      mt76: mt7921: add ieee80211_ops
      mt76: mt7921: introduce mt7921e support
      mt76: mt7921: add debugfs support
      mt76: mt7921: introduce schedule scan support
      mt76: mt7921: introduce 802.11 PS support in sta mode
      mt76: mt7921: introduce support for hardware beacon filter
      mt76: mt7921: introduce beacon_loss mcu event
      mt76: mt7921: introduce PM support
      mt76: mt7921: introduce Runtime PM support
      mt76: mt7921: add coredump support

Shayne Chen (18):
      mt76: mt7915: add support for flash mode
      mt76: mt7915: add partial add_bss_info command on testmode init
      mt76: testmode: introduce dbdc support
      mt76: testmode: move mtd part to mt76_dev
      mt76: mt7915: move testmode data from dev to phy
      mt76: mt7615: move testmode data from dev to phy
      mt76: mt7915: force ldpc for bw larger than 20MHz in testmode
      mt76: testmode: add support to set user-defined spe index
      mt76: testmode: add attributes for ipg related parameters
      mt76: testmode: make tx queued limit adjustable
      mt76: mt7915: split edca update function
      mt76: mt7915: add support for ipg in testmode
      mt76: mt7915: calculate new packet length when tx_time is set in testmode
      mt76: mt7915: clean hw queue before starting new testmode tx
      mt76: testmode: add a new state for continuous tx
      mt76: mt7915: rework set state part in testmode
      mt76: mt7915: add support for continuous tx in testmode
      mt76: mt7615: mt7915: disable txpower sku when testmode enabled

Xu Wang (1):
      mt76: mt7915: Remove unneeded semicolon

Zheng Yongjun (2):
      mt76: mt7615: convert comma to semicolon
      mt76: mt7915: convert comma to semicolon

 drivers/net/wireless/mediatek/mt76/Kconfig           |    5 +
 drivers/net/wireless/mediatek/mt76/Makefile          |    4 +
 drivers/net/wireless/mediatek/mt76/dma.c             |    8 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c          |    4 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c        |    8 +-
 drivers/net/wireless/mediatek/mt76/mt76.h            |   75 +++-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c     |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |   24 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c     |   16 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h   |    2 -
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c  |   17 +
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c     |   64 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  210 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  192 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 1617 ++++++++--------------------------------------------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h      |  683 +----------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   |  132 ++-----
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c      |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c |   23 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c     |   11 +-
 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c |  101 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c      |   12 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     |  105 ++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  119 +++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1842 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  979 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h         |    2 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     |   10 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c     |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |   14 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  |   28 ++
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c      |  102 ++++--
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |   42 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h   |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     |   48 +--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |  129 +++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h      |    2 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     |   46 +--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  542 +++++++++++++++-------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |   63 ++++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |   69 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c      |  177 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |  528 +++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.h |   59 +++
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig    |   11 +
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  |  250 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c      |  356 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c   |  100 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h   |   27 ++
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  282 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 1516 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h      |  333 +++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 1161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 1308 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h      |  434 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |  342 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  292 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h     |  419 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/testmode.c        |  124 ++++---
 drivers/net/wireless/mediatek/mt76/testmode.h        |   17 +
 drivers/net/wireless/mediatek/mt76/tx.c              |   39 +-
 drivers/net/wireless/mediatek/mt76/usb.c             |    1 +
 75 files changed, 12019 insertions(+), 3210 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regs.h
