Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900DB42FDC9
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbhJOWFn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Oct 2021 18:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhJOWFm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Oct 2021 18:05:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08BA860C4B;
        Fri, 15 Oct 2021 22:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634335415;
        bh=RTLMiY0Rt50rxOAtZS0epmEkTqpM76XfSvGmONsiArA=;
        h=From:To:Cc:Subject:Date:From;
        b=UZSI+yocTz9Y4vB/FJsJnJm4zuwyvxu1MFUQuDmbh2aQhaGnNrECFJpY8wto2sxo4
         IGCPNmutDs7qGgQB2dkorER1FcBDlQrre9OjqRnbRJ8gBzaMebxD/Obl4DuDCbVEot
         HBzzNnxSfeoUqjJpN/A5IEyti62DzrRxbWqS4FM/UMeQsluS+R9x1bIaoA8dzRtfNh
         u4qnS3EN16eCiMoUrF+sG4M0A1UO4C+VovEM66QiS2JR9Btk6lSLM81RxtpdLHDjRV
         JfDE7ew4kV57vZU3K6no5Qa48hC6dVBy09WD3y61CxHM7Wl05KE7EeCwarihb+4iIE
         5A7LbBQkDZnZA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: get rid of unused variable in mt7921_tx_complete_skb
Date:   Sat, 16 Oct 2021 00:03:24 +0200
Message-Id: <79ea05e0d369d0f416a93fc1a913f9dc42178edc.1634335352.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused dev variable in mt7921_tx_complete_skb routine

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 0b51db9656e7..ae67e93524c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1356,15 +1356,11 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 
 void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
-	struct mt7921_dev *dev;
-
 	if (!e->txwi) {
 		dev_kfree_skb_any(e->skb);
 		return;
 	}
 
-	dev = container_of(mdev, struct mt7921_dev, mt76);
-
 	/* error path */
 	if (e->skb == DMA_DUMMY_DATA) {
 		struct mt76_txwi_cache *t;
-- 
2.31.1

