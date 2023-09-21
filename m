Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4F7AA072
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjIUUhn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjIUUh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:37:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1C7EA1F
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76470C3279B;
        Thu, 21 Sep 2023 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293024;
        bh=CafFfhS++g5ES5lGvZKA5DFr08N/n5bxoMaqXT+Ze0A=;
        h=From:To:Cc:Subject:Date:From;
        b=QG8EUP1NJZ8AGMWliG2Piz983BGGzHDm4dPrrbrDR/fcxSWyE9hLkyT7qLrTiZy9x
         v/WaPgbnnr2a+XBHZatdusD+tVzxid1n98hGRqt6k9lXRVCu3aYvXETHarpPX5pf0x
         diEY7agkkmsVKXPolMT7bY9aDlYMg35rpCsm9htJQwVOmdBxkPwXXJ6wxtxj69++2t
         7jNgVSB9XTrby+svUpdrrlstFUnl+TCeQ0SbZWderZAz9gA0+A3jrGT4mjTP7lY0pr
         yVnboGYYZaRUEEe96Iwlm1ApF4KiAJkP4e4dPXChf7p94+8d6AklZa99Aa/U8om59D
         MtAhGCPKtWKCg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/9] wifi: mt7996: add wed support
Date:   Thu, 21 Sep 2023 12:43:29 +0200
Message-ID: <cover.1695292502.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to MT7915, introduce Wireless Ethernet Dispatcher (WED)
support for MT7996 driver to offload transmitted/received traffic.

Bo Jiao (1):
  wifi: mt76: mt7996: add wed rx support

Lorenzo Bianconi (7):
  wifi: mt76: mmio: move mt76_mmio_wed_{init,release}_rx_buf in common
    code
  wifi: mt76: move mt76_mmio_wed_offload_{enable,disable} in common code
  wifi: mt76: move mt76_net_setup_tc in common code
  wifi: mt76: introduce mt76_queue_is_wed_tx_free utility routine
  wifi: mt76: introduce wed pointer in mt76_queue
  wifi: mt76: increase MT_QFLAG_WED_TYPE size
  wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine

Sujuan Chen (1):
  wifi: mt76: mt7996: add wed tx support

 drivers/net/wireless/mediatek/mt76/dma.c      | 219 ++++++++++-----
 drivers/net/wireless/mediatek/mt76/dma.h      |  12 +
 drivers/net/wireless/mediatek/mt76/mac80211.c |  19 +-
 drivers/net/wireless/mediatek/mt76/mmio.c     |  97 +++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 102 ++++++-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |   9 +-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   3 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  16 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 107 +-------
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 258 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 156 ++++++++++-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  72 ++++-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  42 +++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  13 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 208 ++++++++++++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  67 ++++-
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  72 +++--
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  65 ++++-
 24 files changed, 1276 insertions(+), 299 deletions(-)

-- 
2.41.0

