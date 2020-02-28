Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F0B173858
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 14:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB1N3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 08:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgB1N3o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 08:29:44 -0500
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C92F246A3;
        Fri, 28 Feb 2020 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582896584;
        bh=ueRno9wU2ahuD234sm4+J9KY4nKcWSDVStSvZRzy9lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGD05IUSKBqdOO9G5aRu5joFlfEMQ8Dmcx6Ea7sPvYcvHjbo0YJWw09yLLGYOojUE
         6OX0wc+PPMNYFqn8tJT9zV3RxQ2Hlbc3zrFq4KmaEksHo5+dSqnrjutL53EQOsyZJp
         WpSQSW6UbBU2dHcgfgjCBwVNp68xSvosJrd19T3c=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 6/6] mt76: mt7615: move mt7615_mac_wtbl_addr in mac.h
Date:   Fri, 28 Feb 2020 14:29:27 +0100
Message-Id: <aa1b3a566fe014718d7ab4de7207f3bf8bf88bdc.1582893136.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582893136.git.lorenzo@kernel.org>
References: <cover.1582893136.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_mac_wtbl_addr in mac.h to reuse it in mt7663u driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 5 -----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index a14ca0825582..dcd1141792d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -707,11 +707,6 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 		mt7615_txp_skb_unmap_hw(dev, &txp->hw);
 }
 
-static u32 mt7615_mac_wtbl_addr(struct mt7615_dev *dev, int wcid)
-{
-	return MT_WTBL_BASE(dev) + wcid * MT_WTBL_ENTRY_SIZE;
-}
-
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask)
 {
 	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 5fe6a0e667a9..0fb9c0b2bca4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -405,4 +405,9 @@ mt7615_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 	return (struct mt7615_txp_common *)(txwi + MT_TXD_SIZE);
 }
 
+static inline u32 mt7615_mac_wtbl_addr(struct mt7615_dev *dev, int wcid)
+{
+	return MT_WTBL_BASE(dev) + wcid * MT_WTBL_ENTRY_SIZE;
+}
+
 #endif
-- 
2.24.1

