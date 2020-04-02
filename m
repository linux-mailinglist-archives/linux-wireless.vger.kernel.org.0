Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87B219C8A9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbgDBSTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBSTV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:21 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01B5215A4;
        Thu,  2 Apr 2020 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851561;
        bh=KjppzVDV4ZXKFstxVUXkmnuy1kl9/6VwhwlFAYkoy2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/ttmdljUoAZUkbtMDs17Ix2SbfxyaUhD+wWOKz50/m0wkK8x4TvzCCcbS7lYGtTy
         3zm7D/QvuHTcB9A7TzUbyFOqqeW/lohkSgkaoyc7ktxsgVZaPaZMyVne3hDKiatlxg
         Wi/dl4qh+0/T2IO2BRPcF40ZXcWyqpcJf+qVmqQY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 5/9] mt76: mt7615: move mt7615_mac_wtbl_addr in mac.h
Date:   Thu,  2 Apr 2020 20:18:52 +0200
Message-Id: <e1da450929d881718cfbbad2ef5da94abea34dcb.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585851049.git.lorenzo@kernel.org>
References: <cover.1585851049.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_mac_wtbl_addr in mac.h and add inline qualifier in order to
be reused adding usb support to mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 5 -----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f68fa82ef5b0..e6e5c02da4fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -721,11 +721,6 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
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
index 422a140fd812..2c368b99cc0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -407,4 +407,9 @@ mt7615_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 	return (struct mt7615_txp_common *)(txwi + MT_TXD_SIZE);
 }
 
+static inline u32 mt7615_mac_wtbl_addr(struct mt7615_dev *dev, int wcid)
+{
+	return MT_WTBL_BASE(dev) + wcid * MT_WTBL_ENTRY_SIZE;
+}
+
 #endif
-- 
2.25.1

