Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3E0626A49
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiKLPlI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiKLPlH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E31AF18
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E621B80939
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96372C433D7;
        Sat, 12 Nov 2022 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267663;
        bh=x3LV9TMY6bfjLXTedMNIozmiE7q5xtmghtIOIaFBnu4=;
        h=From:To:Cc:Subject:Date:From;
        b=ct0h2heQSPxo8fD82ucBRgd/MM4OEzLcmRuJZrpAgHV7ncRn3yobkanJRT9oEDxfy
         ok/ovHWMXnL6o2BRKXZkwlFpcbskQL3tbAE9wvtWXNjsIETsX99qcagI3XoQdeOiTR
         P7bG9O6mDGD1SEBfhpNj050u3qekclZeEa6EbOHNmylgaYtQAlmJCW21D8ypPzRmfP
         5LBrzXFM157dwLNZVyFmI9rSd48DTC8e/31U39iHq6QE0hrzoP92IVA5Evp6hEsO6m
         JpWVTO8l/T6KjTFa9f47ru+h09yuiO5iOXwJywQo1arQv9rsI9W9VTDiZ1NZhCeMzq
         rzbNIFfPMuCGg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 0/8] mt7915: introduce WED RX support
Date:   Sat, 12 Nov 2022 16:40:33 +0100
Message-Id: <cover.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to TX counterpart available on MT7622 and MT7986, introduce RX Wireless
Ethernet Dispatch available on MT7986 SoC in order to offload traffic received
by wlan nic to the wired interfaces (lan/wan).

This series is based on the following net-next series:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=573c38533c0d7f7a8964530c2c606eb691ba28ec

Lorenzo Bianconi (4):
  wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf
  wifi: mt76: add WED RX support to mt76_dma_rx_fill
  wifi: mt76: add WED RX support to dma queue alloc
  wifi: mt76: mt7915: enable WED RX support

Sujuan Chen (4):
  wifi: mt76: introduce rxwi and rx token utility routines
  wifi: mt76: add info parameter to rx_skb signature
  wifi: mt76: connac: introduce mt76_connac_mcu_sta_wed_update utility
    routine
  wifi: mt76: mt7915: enable WED RX stats

 drivers/net/wireless/mediatek/mt76/dma.c      | 244 +++++++++++---
 drivers/net/wireless/mediatek/mt76/dma.h      |   8 +
 drivers/net/wireless/mediatek/mt76/mac80211.c |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  26 +-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |   2 +-
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  22 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  26 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  44 ++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   8 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  22 ++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 319 +++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |   7 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     |   2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  30 ++
 drivers/net/wireless/mediatek/mt76/usb.c      |   2 +-
 24 files changed, 630 insertions(+), 162 deletions(-)

-- 
2.38.1

