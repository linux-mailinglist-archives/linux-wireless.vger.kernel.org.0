Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100966485E2
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 16:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiLIPtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 10:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiLIPsu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 10:48:50 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D63A5C755
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=64ya3NDZlK80gtDu7HsFyY2Eau2xhqet+iOWTD3QZAQ=; b=SOq0yAh5jbdZiJ0QGgW1jxVMeA
        efyHUFXHEafEhWNIl7jzZk0CRc+P28diU8qwnNauVRiyLCieepfmcL4B7NlGWdE/UQku+rtLy7NOJ
        t55HcEMMqviK43HGIFVuSCZT6KC94XYiL9Buv9/+QdYo2cfvbYpggU0hXWZcQ/3mKoxg=;
Received: from p200300daa7161300207339adb4444dbf.dip0.t-ipconnect.de ([2003:da:a716:1300:2073:39ad:b444:4dbf] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p3fbO-007Qdw-9v; Fri, 09 Dec 2022 16:47:54 +0100
Message-ID: <fb35ede5-73c6-6d0b-34d1-8aa639a9adb0@nbd.name>
Date:   Fri, 9 Dec 2022 16:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2022-12-09
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

here's my second request for 6.2

- Felix

The following changes since commit 832c3f66f53f1eb20f424b916a311ad82074ef0d:

   Merge tag 'iwlwifi-next-for-kalle-2022-12-07' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2022-12-08 16:54:33 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-12-09

for you to fetch changes up to d878d3dc126db05b075147456644bd2d2ab1fb5e:

   wifi: mt76: mt7915: get rid of wed rx_buf_ring page_frag_cache (2022-12-09 16:46:28 +0100)

----------------------------------------------------------------
mt76 patches for 6.2

- fixes
- per-PHY LED support

----------------------------------------------------------------
Deren Wu (2):
       wifi: mt76: mt7921s: fix slab-out-of-bounds access in sdio host
       wifi: mt76: fix coverity uninit_use_in_call in mt76_connac2_reverse_frag0_hdr_trans()

Lorenzo Bianconi (10):
       wifi: mt76: mt7996: fix endianness warning in mt7996_mcu_sta_he_tlv
       wifi: mt76: mt76x0: fix oob access in mt76x0_phy_get_target_power
       wifi: mt76: move leds field in leds struct
       wifi: mt76: move leds struct in mt76_phy
       wifi: mt76: mt7915: enable per-phy led support
       wifi: mt76: mt7615: enable per-phy led support
       wifi: mt76: dma: do not increment queue head if mt76_dma_add_buf fails
       wifi: mt76: handle possible mt76_rx_token_consume failures
       wifi: mt76: dma: rely on queue page_frag_cache for wed rx queues
       wifi: mt76: mt7915: get rid of wed rx_buf_ring page_frag_cache

Quan Zhou (1):
       wifi: mt76: mt7921: add support to update fw capability with MTFG table

Ryder Lee (12):
       wifi: mt76: mt7915: fix mt7915_rate_txpower_get() resource leaks
       wifi: mt76: mt7996: fix insecure data handling of mt7996_mcu_ie_countdown()
       wifi: mt76: mt7996: fix insecure data handling of mt7996_mcu_rx_radar_detected()
       wifi: mt76: mt7996: fix integer handling issue of mt7996_rf_regval_set()
       wifi: mt76: mt7915: split mcu chan_mib array up
       wifi: mt76: mt7915: check return value before accessing free_block_num
       wifi: mt76: mt7996: check return value before accessing free_block_num
       wifi: mt76: mt7915: check the correctness of event data
       wifi: mt76: mt7915: drop always true condition of __mt7915_reg_addr()
       wifi: mt76: mt7996: drop always true condition of __mt7996_reg_addr()
       wifi: mt76: mt7996: fix unintended sign extension of mt7996_hw_queue_read()
       wifi: mt76: mt7915: fix unintended sign extension of mt7915_hw_queue_read()

Sean Wang (1):
       wifi: mt76: mt7921: resource leaks at mt7921_check_offload_capability()

Wang Yufen (1):
       wifi: mt76: mt7915: add missing of_node_put()

  drivers/net/wireless/mediatek/mt76/debugfs.c         |   2 +-
  drivers/net/wireless/mediatek/mt76/dma.c             |  35 +++++++++------------
  drivers/net/wireless/mediatek/mt76/mac80211.c        |  56 +++++++++++++++++++++-------------
  drivers/net/wireless/mediatek/mt76/mt76.h            |  12 +++++---
  drivers/net/wireless/mediatek/mt76/mt7603/init.c     |  34 ++++++++++-----------
  drivers/net/wireless/mediatek/mt76/mt7615/init.c     |  85 +++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c     |  16 ----------
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   |   6 ++++
  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c |  62 ++------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7615/regs.h     |   1 +
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/phy.c      |   7 ++++-
  drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |  35 +++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  |   6 ++--
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |  19 +++++++-----
  drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  81 ++++++++++++++++++++++++++++++-------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |  32 +++++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |  13 ++++++--
  drivers/net/wireless/mediatek/mt76/mt7915/soc.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c |  55 +++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h |  12 ++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |   4 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |   7 +++++
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c  |   5 +--
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c   |  18 +++++++----
  drivers/net/wireless/mediatek/mt76/mt7996/init.c     |  14 ++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      |  15 ++++++---
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c     |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h     |   1 -
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c       |   4 +++
  drivers/net/wireless/mediatek/mt76/tx.c              |   7 +++--
  include/linux/soc/mediatek/mtk_wed.h                 |   1 -
  34 files changed, 503 insertions(+), 274 deletions(-)
