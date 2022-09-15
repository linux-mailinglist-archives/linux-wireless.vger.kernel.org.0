Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6CC5B9989
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 13:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIOL0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIOL0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 07:26:23 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BD7C1E7
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5v0ZBtUeyEC75pXbCIQA9GPfqBnDjz5d6JXGokecHOM=; b=Zhp5O6iJAAnpYjXS/5FTyko0O2
        hdD6d8NBiTr2ern7GbVhhO3Hqy6fxu67czQ6PkQhwEwk8aYJSyXux3Tdt8pidKKODblJNxR8FEcgW
        cNWGmrxSTONQtjRgWx8F9NVwyLNXn4OFN8CO0JMuZ44DdpeBRX4kVUMIUZFpe6OB5UOk=;
Received: from p200300daa7301d00b82a348903aff2a7.dip0.t-ipconnect.de ([2003:da:a730:1d00:b82a:3489:3af:f2a7] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oYn0e-00594P-B4; Thu, 15 Sep 2022 13:26:20 +0200
Message-ID: <77c2969a-90fe-5b04-f580-3ff807a7ac3d@nbd.name>
Date:   Thu, 15 Sep 2022 13:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2022-09-15
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

here's my first pull request for 6.1

- Felix

The following changes since commit d5350756c03cdf18696295c6b11d7acc4dbf825c:

   wifi: rtl8xxxu: Remove copy-paste leftover in gen2_update_rate_mask (2022-09-12 14:57:54 +0300)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-09-15

for you to fetch changes up to cb74c8f8dbb10c0c8dc42c8693e238fd0ab98517:

   wifi: mt76: mt7921s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() (2022-09-15 13:21:39 +0200)

----------------------------------------------------------------
mt76 patches for 6.1

- fixes
- suspend/resume improvements
- tx status reporting improvements

----------------------------------------------------------------
Dan Carpenter (3):
       wifi: mt76: mt7915: fix an uninitialized variable bug
       wifi: mt76: mt7921: fix use after free in mt7921_acpi_read()
       wifi: mt76: mt7921: delete stray if statement

Deren Wu (4):
       wifi: mt76: mt7921e: fix rmmod crash in driver reload test
       wifi: mt76: mt7921e: fix random fw download fail
       wifi: mt76: mt7663s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
       wifi: mt76: mt7921s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()

Gergo Koteles (1):
       wifi: mt76: mt76_usb.mt76u_mcu.burst is always false remove related code

Howard Hsu (2):
       wifi: mt76: mt7915: fix mcs value in ht mode
       wifi: mt76: mt7915: do not check state before configuring implicit beamform

Lorenzo Bianconi (9):
       wifi: mt76: connac: introduce mt76_connac_reg_map structure
       wifi: mt76: add rx_check callback for usb devices
       wifi: mt76: mt7921: move mt7921_rx_check and mt7921_queue_rx_skb in mac.c
       wifi: mt76: sdio: add rx_check callback for sdio devices
       wifi: mt76: mt7615: add mt7615_mutex_acquire/release in mt7615_sta_set_decap_offload
       wifi: mt76: mt7915: fix possible unaligned access in mt7915_mac_add_twt_setup
       wifi: mt76: connac: fix possible unaligned access in mt76_connac_mcu_add_nested_tlv
       wifi: mt76: mt7663s: add rx_check callback
       wifi: mt76: fix uninitialized pointer in mt7921_mac_fill_rx

Ming Yen Hsieh (1):
       wifi: mt76: mt7921: introduce Country Location Control support

Ruffalo Lavoisier (1):
       wifi: mt76: connac: fix in comment

Ryder Lee (2):
       wifi: mt76: move move mt76_sta_stats to mt76_wcid
       wifi: mt76: add PPDU based TxS support for WED device

Sean Wang (11):
       wifi: mt76: mt7921e: fix race issue between reset and suspend/resume
       wifi: mt76: mt7921s: fix race issue between reset and suspend/resume
       wifi: mt76: mt7921u: fix race issue between reset and suspend/resume
       wifi: mt76: mt7921u: remove unnecessary MT76_STATE_SUSPEND
       wifi: mt76: sdio: fix the deadlock caused by sdio->stat_work
       wifi: mt76: sdio: poll sta stat when device transmits data
       wifi: mt76: mt7921: add mt7921_mutex_acquire at mt7921_[start, stop]_ap
       wifi: mt76: mt7921: add mt7921_mutex_acquire at mt7921_sta_set_decap_offload
       wifi: mt76: mt7921: fix the firmware version report
       wifi: mt76: mt7921: get rid of the false positive reset
       wifi: mt76: mt7921: reset msta->airtime_ac while clearing up hw value

Shayne Chen (1):
       wifi: mt76: testmode: use random payload for tx packets

YN Chen (1):
       wifi: mt76: sdio: fix transmitting packet hangs

  drivers/net/wireless/mediatek/mt76/mt76.h             |  50 ++++++++++++++++-------------
  drivers/net/wireless/mediatek/mt76/mt7615/main.c      |   4 +++
  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |  16 +++-------
  drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt76_connac.h      |  11 +++++--
  drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h |   8 +++++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  76 ++++++++++++++++++++++++++++----------------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  12 +++++--
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  11 ++++++-
  drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c  |  30 +++++-------------
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |   6 ++--
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  27 +++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  19 ++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  10 +++---
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   2 --
  drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |  21 +++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |  12 +++----
  drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c  |   5 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h    |   5 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c       | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  28 +++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       | 198 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |  39 ++++++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  99 +++++++++++++++++++++++++++++-----------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c   | 148 --------------------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c   |   9 ++----
  drivers/net/wireless/mediatek/mt76/mt7921/regs.h      |   2 ++
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |  29 ++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   7 +----
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |  40 +++++++++++++++---------
  drivers/net/wireless/mediatek/mt76/sdio.c             |   8 ++---
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c        |  23 +++++++++-----
  drivers/net/wireless/mediatek/mt76/testmode.c         |   8 +++--
  drivers/net/wireless/mediatek/mt76/usb.c              |   5 +++
  37 files changed, 859 insertions(+), 516 deletions(-)
