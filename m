Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ADC672369
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjARQds (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjARQdD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:33:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DEC2311F
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C559B81DA5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 16:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CC1C433D2;
        Wed, 18 Jan 2023 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674059464;
        bh=xF2DiJLPCoAtFdiGut0siS0ADaiXblCR+ZZv+5ehvcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esVG8c3GDH6vd/wROluW+aKjBwFBMY6lVHa4ypLmeAugbMlbomx8GR4RMvGTWVQf+
         LWO6noAQV9GLS7Py2Qp4dtEUsQ8Ly/jE662PiR694Wkrd5l/U6n8ZXzIgZ6p9xCryi
         tI4DhGk3StYQCLQv/gSnYKc8lQbxClQ9i3hfheWw/zI5TSNNA4jTjSSgs2engyJCxo
         yHQG9YC4yTbqwCBdtN7Mw+xKOicDSZOXibM1s8GDejZcio4VT3MW61M0FTqtn/MYpP
         YgjWzalaYM3f/FOTfLWecD+f2tuSLuUDGCCMBA9dVWx54KNIECPfzb9JdyJEsotv0N
         6BSJEANFUsDhQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 2/4] wifi: mt76: mt7996: rely on mt76_connac_txp_skb_unmap
Date:   Wed, 18 Jan 2023 17:30:39 +0100
Message-Id: <fb3800e3c65308846da93f14b707cb702925e554.1674059222.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674059222.git.lorenzo@kernel.org>
References: <cover.1674059222.git.lorenzo@kernel.org>
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

Drop mt7996_txp_skb_unmap routine since it is equivalent to
mt76_connac_txp_skb_unmap().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 4e4b596ea37d..7fefb3f71940 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1168,18 +1168,6 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
-static void
-mt7996_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	struct mt76_connac_txp_common *txp;
-	int i;
-
-	txp = mt7996_txwi_to_txp(dev, t);
-	for (i = 0; i < txp->fw.nbuf; i++)
-		dma_unmap_single(dev->dev, le32_to_cpu(txp->fw.buf[i]),
-				 le16_to_cpu(txp->fw.len[i]), DMA_TO_DEVICE);
-}
-
 static void
 mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
 		 struct ieee80211_sta *sta, struct list_head *free_list)
@@ -1189,7 +1177,7 @@ mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
 	__le32 *txwi;
 	u16 wcid_idx;
 
-	mt7996_txp_skb_unmap(mdev, t);
+	mt76_connac_txp_skb_unmap(mdev, t);
 	if (!t->skb)
 		goto out;
 
-- 
2.39.0

