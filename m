Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF72367306
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbhDUTCX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbhDUTCW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 15:02:22 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57BC06174A
        for <linux-wireless@vger.kernel.org>; Wed, 21 Apr 2021 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RkkhsEozBnURaQnJYC6jjxXXOR0oW8cR1pxzW5Rj2yI=; b=GB+P02jfnOHJgfkZR5wqZ8o6Up
        nNnVQuVlcFb04WA/EVCy+ZboMc5cK+Xdmwk+sHEZBXzrYRluMNqVLT6inwHQkd0j6wfMpLl8vgLyG
        j1XfpKl07aB/naFxmM9Bxxmh7DvWOsXlifTUyZ8OOib5DpRJmXqjx6O5UJVGZ6gxfb50=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lZI6d-00067B-AS; Wed, 21 Apr 2021 21:01:47 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-04-21
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <c5410ff3-8341-f8fe-d9cf-a12df54ca8c0@nbd.name>
Date:   Wed, 21 Apr 2021 21:01:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's an updated request for 5.13 with mostly bugfixes. It replaces the
one from 2021-04-17

- Felix

The following changes since commit afda33499bea154dc792338c5c51a2038a206785:

  rtlwifi: implement set_tim by update beacon content (2021-04-21 12:39:33 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-04-21

for you to fetch changes up to 3df932141e4fa3a39f8e0839af9ee7bdedb1da0c:

  mt76: mt7921: reinit wpdma during drv_own if necessary (2021-04-21 20:55:56 +0200)

----------------------------------------------------------------
mt76 patches for 5.13

* testmode improvements
* bugfixes
* device tree power limits support for 7615 and newer
* hardware recovery fixes
* mt7663 reset/init fixes
* mt7915 flash pre-calibration support
* mt7921/mt7663 runtime power management fixes

----------------------------------------------------------------
Colin Ian King (1):
      mt76: mt7615: Fix a dereference of pointer sta before it is null checked

Dan Carpenter (3):
      mt76: mt7615: fix a precision vs width bug in printk
      mt76: mt7915: fix a precision vs width bug in printk
      mt76: mt7921: fix a precision vs width bug in printk

Felix Fietkau (6):
      mt76: flush tx status queue on DMA reset
      mt76: add functions for parsing rate power limits from DT
      mt76: mt7615: implement support for using DT rate power limits
      mt76: mt7615: fix hardware error recovery for mt7663
      mt76: mt7615: fix entering driver-own state on mt7663
      mt76: mt7615: load ROM patch before checking patch semaphore status

Lorenzo Bianconi (43):
      mt76: mt7921: add mt7921_dma_cleanup in mt7921_unregister_device
      dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
      mt76: mt7615: do not use mt7615 single-sku values for mt7663
      mt76: introduce single-sku support for mt7663/mt7921
      mt76: mt7921: move hw configuration in mt7921_register_device
      mt76: improve mcu error logging
      mt76: mt7921: run mt7921_mcu_fw_log_2_host holding mt76 mutex
      mt76: mt7921: do not use 0 as NULL pointer
      mt76: connac: move mcu_update_arp_filter in mt76_connac module
      mt76: mt7921: remove leftover function declaration
      mt76: mt7921: fix a race between mt7921_mcu_drv_pmctrl and mt7921_mcu_fw_pmctrl
      mt76: mt7663: fix a race between mt7615_mcu_drv_pmctrl and mt7615_mcu_fw_pmctrl
      mt76: connac: introduce wake counter for fw_pmctrl synchronization
      mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
      mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
      mt76: dma: add the capability to define a custom rx napi poll routine
      mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx napi
      mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx napi
      mt76: connac: unschedule ps_work in mt76_connac_pm_wake
      mt76: connac: check wake refcount in mcu_fw_pmctrl
      mt76: connac: remove MT76_STATE_PM in mac_tx_free
      mt76: mt7921: get rid of useless MT76_STATE_PM in mt7921_mac_work
      mt76: connac: alaways wake the device before scanning
      mt76: mt7615: rely on pm refcounting in mt7615_led_set_config
      mt76: connac: do not run mt76_txq_schedule_all directly
      mt76: connac: use waitqueue for runtime-pm
      mt76: remove MT76_STATE_PM in tx path
      mt76: mt7921: add awake and doze time accounting
      mt76: mt7921: enable sw interrupts
      mt76: mt7921: move mt7921_dma_reset in dma.c
      mt76: mt7921: introduce mt7921_wpdma_reset utility routine
      mt76: mt7921: introduce mt7921_dma_{enable,disable} utilities
      mt76: mt7921: introduce mt7921_wpdma_reinit_cond utility routine
      mt76: move token_lock, token and token_count in mt76_dev
      mt76: move token utilities in mt76 common module
      mt76: mt7921: get rid of mcu_reset function pointer
      mt76: mt7921: improve doze opportunity
      mt76: mt7663: add awake and doze time accounting
      mt76: connac: unschedule mac_work before going to sleep
      mt76: mt7921: introduce mt7921_mcu_sta_add routine
      mt76: debugfs: introduce napi_threaded node
      mt76: move mt76_token_init in mt76_alloc_device
      mt76: mt7921: reinit wpdma during drv_own if necessary

Ryder Lee (6):
      mt76: mt7615: fix memleak when mt7615_unregister_device()
      mt76: mt7915: fix memleak when mt7915_unregister_device()
      mt76: mt7915: only free skbs after mt7915_dma_reset() when reset happens
      mt76: mt7615: only free skbs after mt7615_dma_reset() when reset happens
      mt76: mt7615: use ieee80211_free_txskb() in mt7615_tx_token_put()
      mt76: mt7915: add support for applying pre-calibration data

Sean Wang (7):
      mt76: mt7921: add dumping Tx power table
      mt76: mt7921: add wifisys reset support in debugfs
      mt76: mt7921: abort uncompleted scan by wifi reset
      mt76: connac: introduce mt76_connac_mcu_set_deep_sleep utility
      mt76: mt7921: enable deep sleep when the device suspends
      mt76: mt7921: fix possible invalid register access
      mt76: mt7921: mt7921_stop should put device in fw_own state

Shayne Chen (8):
      mt76: testmode: add support to send larger packet
      mt76: mt7915: rework mt7915_tm_set_tx_len()
      mt76: mt7915: fix rate setting of tx descriptor in testmode
      mt76: extend DT rate power limits to support 11ax devices
      mt76: mt7915: add support for DT rate power limits
      mt76: mt7915: rework the flow of txpower setting
      mt76: mt7915: directly read per-rate tx power from registers
      mt76: mt7915: do not read rf value from efuse in flash mode

 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 107 ++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/debugfs.c                      |  28 ++++++++++
 drivers/net/wireless/mediatek/mt76/dma.c                          |  10 ++--
 drivers/net/wireless/mediatek/mt76/dma.h                          |   1 +
 drivers/net/wireless/mediatek/mt76/eeprom.c                       | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mac80211.c                     |   3 ++
 drivers/net/wireless/mediatek/mt76/mcu.c                          |   4 --
 drivers/net/wireless/mediatek/mt76/mt76.h                         |  77 +++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |  32 +++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |  47 ++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |  22 ++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |  44 +++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |  43 ++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   | 198 +++++++++++++++++++++++++++++++++++++++++++--------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |  24 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |   7 +--
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c              |  16 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               |  23 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h                  |  11 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c              |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |  54 ++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              |  23 ++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  37 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c                  |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  78 +++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                | 165 ++++++++++++++++++----------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                |  51 ++++++------------
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  85 ++++++++++++++++--------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  95 ++++++++++++---------------------
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   8 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  19 +++----
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |  26 +--------
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |   5 ++
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |  22 ++------
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               | 144 ++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   | 240 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  36 ++++++-------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   | 193 ++++++++++++++-----------------------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |  62 +++++++++-------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   | 126 ++++++++++++++++++++++++++------------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  17 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  60 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  30 ++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h                  |  17 +++---
 drivers/net/wireless/mediatek/mt76/testmode.c                     | 159 +++++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/testmode.h                     |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c                           |  81 ++++++++++++++++++++++++++---
 55 files changed, 2224 insertions(+), 946 deletions(-)
