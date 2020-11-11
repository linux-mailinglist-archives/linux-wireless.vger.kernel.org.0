Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BAE2AF275
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 14:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgKKNsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 08:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgKKNrl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 08:47:41 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFB72072C;
        Wed, 11 Nov 2020 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605102460;
        bh=kUHoD25YTKL6mU4Rsz9LBsiClDaWvsYDCrIa2tKVCh8=;
        h=From:To:Cc:Subject:Date:From;
        b=nfJgTxczIbFMbkaI1RZjeAAsB9MT8201vx2R/Dye/7XyfFLR7BTZy6Agpzlebe0wW
         8rtEsSxTKFFfArcrhIGkuEtiSrcFJKsw8weOIVgJYJNt1EfZp+9k/knb2pdqAJvWtg
         q9fp1h3wpkV7Qu4gcvSh3I++FhxDu0cz183pg+cw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH v2 00/10] mt76: move hw data queues in mt76_phy
Date:   Wed, 11 Nov 2020 14:47:22 +0100
Message-Id: <cover.1605102251.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move hw data queues from mt76_dev to mt76_phy since mt7915 devices in dbdc mode
export per-phy hw data queues (while mcu hw queues are shared between primary
and ext phys). This is a preliminary series to enable dbdc mode for mt7915
driver.

Changes since v1:
- use mt76_dev in mt76_dma_tx_cleanup signature
- rely on on mt76_queue in tx_queue_skb signature

Lorenzo Bianconi (10):
  mt76: move mt76_init_tx_queue in common code
  mt76: sdio: introduce mt76s_alloc_tx_queue
  mt76: sdio: rely on mt76_queue in mt76s_process_tx_queue signature
  mt76: mt7663s: rely on mt76_queue in mt7663s_tx_run_queue signature
  mt76: dma: rely on mt76_queue in mt76_dma_tx_cleanup signature
  mt76: rely on mt76_queue in tx_queue_skb signature
  mt76: introduce mt76_init_mcu_queue utility routine
  mt76: rely on mt76_queue in tx_queue_skb_raw signature
  mt76: move mcu queues to mt76_dev q_mcu array
  mt76: move tx hw data queues in mt76_phy

 drivers/net/wireless/mediatek/mt76/debugfs.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/dma.c      | 26 ++++---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 26 +++++--
 drivers/net/wireless/mediatek/mt76/mcu.c      |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 60 ++++++++++++---
 .../wireless/mediatek/mt76/mt7603/beacon.c    | 26 ++++---
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 61 +++++++--------
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  9 ++-
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 12 +--
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 17 ++---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 53 +++++--------
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  9 ++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  8 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  4 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 28 ++++---
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 69 ++++++++---------
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  4 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 17 ++---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 54 ++++---------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 12 +--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 10 +--
 drivers/net/wireless/mediatek/mt76/sdio.c     | 75 ++++++++++++-------
 drivers/net/wireless/mediatek/mt76/testmode.c |  6 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 33 ++++----
 drivers/net/wireless/mediatek/mt76/usb.c      | 19 ++---
 30 files changed, 345 insertions(+), 315 deletions(-)

-- 
2.26.2

