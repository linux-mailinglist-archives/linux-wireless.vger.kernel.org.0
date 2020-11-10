Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE42AE3CE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 00:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgKJXDJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 18:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732168AbgKJXDJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 18:03:09 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC6620679;
        Tue, 10 Nov 2020 23:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605049388;
        bh=VLUSoeH+KVLxOwJUH5scfNhzeCX+zPbxoA7PgkULHRY=;
        h=From:To:Cc:Subject:Date:From;
        b=zrxg/y1bwqzllczMnBcVPxC6L+X+VJotGAFGwa6QdrfEgxYavKcokDf3JpwMPAb4O
         T1o7RQMG2QxFi/UNDtbWX86L+GrlJ/PrONEScgV1oaPXFjwmTnPUtI8d5o+0SOSUTV
         WzTowwSbGEk3U1SEoWIiRkowRpcv91RFCle5CgyA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 00/10] mt76: move hw data queues in mt76_phy
Date:   Wed, 11 Nov 2020 00:02:50 +0100
Message-Id: <cover.1605048763.git.lorenzo@kernel.org>
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

Lorenzo Bianconi (10):
  mt76: move mt76_init_tx_queue in common code
  mt76: sdio: introduce mt76s_alloc_tx_queue
  mt76: sdio: rely on mt76_queue in mt76s_process_tx_queue signature
  mt76: mt7663s: rely on mt76_queue in mt7663s_tx_run_queue signature
  mt76: dma: rely on mt76_phy and mt76_queue in mt76_dma_tx_cleanup
    signature
  mt76: rely on mt76_phy in tx_queue_skb signature
  mt76: introduce mt76_init_mcu_queue utility routine
  mt76: rely on mt76_queue in tx_queue_skb_raw signature
  mt76: move mcu queues to mt76_dev q_mcu array
  mt76: move tx hw data queues in mt76_phy

 drivers/net/wireless/mediatek/mt76/debugfs.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/dma.c      | 27 ++++---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 26 +++++--
 drivers/net/wireless/mediatek/mt76/mcu.c      |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 63 +++++++++++++---
 .../wireless/mediatek/mt76/mt7603/beacon.c    | 28 ++++---
 .../net/wireless/mediatek/mt76/mt7603/dma.c   | 63 +++++++---------
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  9 ++-
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 12 +--
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 17 ++---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   | 53 +++++--------
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 11 ++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  9 ++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  4 +-
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 28 ++++---
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 72 ++++++++----------
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  4 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 17 ++---
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 56 +++++---------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 12 +--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 11 +--
 drivers/net/wireless/mediatek/mt76/sdio.c     | 75 ++++++++++++-------
 drivers/net/wireless/mediatek/mt76/testmode.c |  6 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 33 ++++----
 drivers/net/wireless/mediatek/mt76/usb.c      | 17 +++--
 30 files changed, 362 insertions(+), 313 deletions(-)

-- 
2.26.2

