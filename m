Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D913362F1D
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhDQKP6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 06:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhDQKP6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 06:15:58 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD3C061574
        for <linux-wireless@vger.kernel.org>; Sat, 17 Apr 2021 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IoVpqXi7oeeD6lLbfXQ9ykLtWvTHn4xVUIQubWXVLEg=; b=GODMzwSq6P4mvgeKbmskRKXms3
        l+w1p54En2m02VXX959M4p9WwO0O/4GhPKEeBvUl+5/41gI9R2Mfh+Zm3yMrk5djXR5f8epmh9vv4
        REZDCpBA7cgdYgGHi7V+l9rqsqNg4sbuzLnU9azMyyYV53saDR/moII6Wi3h2Lt/WI0k=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lXhz7-00008k-Hy; Sat, 17 Apr 2021 12:15:29 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-04-17
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <2f595f22-8d0b-e19e-68ed-110d7a2af96c@nbd.name>
Date:   Sat, 17 Apr 2021 12:15:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my next pull request for 5.13 with mostly bugfixes

- Felix

The following changes since commit 197b9c152badc4003b1e10837f4536cb66a50f3c:

  Merge tag 'iwlwifi-next-for-kalle-2021-04-12-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2021-04-17 11:38:01 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-04-17

for you to fetch changes up to 6d1139807236382f2722da43f3c2b89de51b55cd:

  mt76: mt7915: directly read per-rate tx power from registers (2021-04-17 11:27:53 +0200)

----------------------------------------------------------------
mt76 patches for 5.13

* testmode improvements
* bugfixes
* device tree power limits support for 7615 and newer
* hardware recovery fixes
* mt7663 reset/init fixes
* mt7915 flash pre-calibration support

----------------------------------------------------------------
Felix Fietkau (6):
      mt76: flush tx status queue on DMA reset
      mt76: add functions for parsing rate power limits from DT
      mt76: mt7615: implement support for using DT rate power limits
      mt76: mt7615: fix hardware error recovery for mt7663
      mt76: mt7615: fix entering driver-own state on mt7663
      mt76: mt7615: load ROM patch before checking patch semaphore status

Lorenzo Bianconi (7):
      mt76: mt7921: add mt7921_dma_cleanup in mt7921_unregister_device
      dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
      mt76: mt7615: do not use mt7615 single-sku values for mt7663
      mt76: introduce single-sku support for mt7663/mt7921
      mt76: mt7921: move hw configuration in mt7921_register_device
      mt76: improve mcu error logging
      mt76: mt7921: run mt7921_mcu_fw_log_2_host holding mt76 mutex

Ryder Lee (6):
      mt76: mt7615: fix memleak when mt7615_unregister_device()
      mt76: mt7915: fix memleak when mt7915_unregister_device()
      mt76: mt7915: only free skbs after mt7915_dma_reset() when reset happens
      mt76: mt7615: only free skbs after mt7615_dma_reset() when reset happens
      mt76: mt7615: use ieee80211_free_txskb() in mt7615_tx_token_put()
      mt76: mt7915: add support for applying pre-calibration data

Sean Wang (3):
      mt76: mt7921: add dumping Tx power table
      mt76: mt7921: add wifisys reset support in debugfs
      mt76: mt7921: abort uncompleted scan by wifi reset

Shayne Chen (7):
      mt76: testmode: add support to send larger packet
      mt76: mt7915: rework mt7915_tm_set_tx_len()
      mt76: mt7915: fix rate setting of tx descriptor in testmode
      mt76: extend DT rate power limits to support 11ax devices
      mt76: mt7915: add support for DT rate power limits
      mt76: mt7915: rework the flow of txpower setting
      mt76: mt7915: directly read per-rate tx power from registers

 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 107 +++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/eeprom.c                       | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h                         |  17 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |  17 +++++--
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |  15 +++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |   8 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   4 ++
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   | 112 ++++++++++++++++++++++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |  23 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c              |   9 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               |  15 ++++--
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h                  |  11 ++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              | 133 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  24 +++++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c                  |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   2 +
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  78 +++++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                | 163 ++++++++++++++++++-----------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                |  51 +++++++------------
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  82 +++++++++++++++++-------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  33 ++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   8 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  14 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |  25 ---------
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |   5 ++
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |  22 ++------
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               | 109 ++++++++++++++++++++++++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  23 ++++-----
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   |  10 ++++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |   4 ++
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |  25 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  17 +++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  32 +++++++++++-
 drivers/net/wireless/mediatek/mt76/testmode.c                     | 159 ++++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/testmode.h                     |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c                           |   2 +-
 40 files changed, 1396 insertions(+), 393 deletions(-)
