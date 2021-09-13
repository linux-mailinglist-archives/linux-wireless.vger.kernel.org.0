Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A3408826
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhIMJ0j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 05:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238002AbhIMJ0i (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 05:26:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B49760FDA;
        Mon, 13 Sep 2021 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631525123;
        bh=7JKGk/hI6Mbzhb2ocsTH1G+QftEl4bWeB3tPR1oABqY=;
        h=From:To:Cc:Subject:Date:From;
        b=mLKB7vaxZX8TV04eDAZ1JCJwNzeADwyjhbNz4Xg+lYfM5REU9K5EoG/264E+DkM5e
         dx0/DD8vMeFy8vWjN6n8pZ6gTeR0hOzUGXe/+75ZHYd70WpNRKcqBtBP+kv8I6iQZH
         PnHxihFCZrEKYhbNGFDkN9EqvQ8mP2qXABrPKuWqje2qCv9yJNxoYd1Z49ZYo7Mtyh
         xOSlL1+J9ubfYbFicXy2DhW3Ej1Zxl7KDIYewcE24wZTO4/mESmP742eawdI2575u/
         MzF7VF/0x1AkoAYrYVnVbw/4vyxYbzx0qpD6qZMdj3/AcrbEGl4Y+3JbK4CXsqGPb7
         +fHVpEECzuYoQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        greearb@candelatech.com, mrkiko.rs@gmail.com
Subject: [PATCH 0/4] Introduce packet_id for txs pktid management
Date:   Mon, 13 Sep 2021 11:25:01 +0200
Message-Id: <cover.1631525026.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce per-wcid idr to manage packet id for txs. This allow fast idr
lookup and skb queueing at the same time.

Lorenzo Bianconi (4):
  mt76: introduce packet_id idr
  mt76: remove mt76_wcid pointer from mt76_tx_status_check signature
  mt76: substitute sk_buff_head status_list with spinlock_t status_lock
  mt76: schedule status timeout at dma completion

 drivers/net/wireless/mediatek/mt76/mac80211.c | 13 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 45 ++++++++----
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 ++
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  3 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 ++
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 ++
 drivers/net/wireless/mediatek/mt76/sdio.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 70 +++++++++++++------
 drivers/net/wireless/mediatek/mt76/usb.c      |  2 +-
 19 files changed, 117 insertions(+), 55 deletions(-)

-- 
2.31.1

