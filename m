Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418DA73A679
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFVQvg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjFVQvd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FCE1FFC
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78AF361883
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 16:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78964C433C8;
        Thu, 22 Jun 2023 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452691;
        bh=PZTAbF6b7uwM84lI4GVQP4ziJQ1aX6hWvlu+AQeHHqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmpfSFw8Z2MkbTfDs8sGGT6DavI1q42n6YfG7ER1xbanUj2v9XR+CuGfzj9la6mh1
         KtsZUkTq5ajh5CT01YyTFeMzfu6GkNo5I2kSkuGn2MJZgGbEVUxhoDb295iDdeAiOO
         Ia5FLF0BwGx21H8Y0daFS8Ma4sk+1mHtrU48A9UhocPHjzVGnrwxjR8/0TWVa7tOiS
         3aiOgEBLJpK1SyKnNA6Ib3psNiOXjcPjmPCYU3dW+P7W9Ok8AeAqUF4k1UalhQnoqg
         xLS+/iM71aJVdKZbJ/j8Em4K3FVjCqlMijHbqOqSF00OpWS0ofmDvuqk2KAVSiZMMH
         fhEhst1y0YRSg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, deren.wu@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH v4 08/15] wifi: mt76: mt7615: rely on shared poll_list field
Date:   Thu, 22 Jun 2023 18:50:25 +0200
Message-ID: <d4d0c97b0e489f7592d5ed399d60ecfcfe373af3.1687452202.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687452202.git.lorenzo@kernel.org>
References: <cover.1687452202.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on poll_list field in mt76_wcid structure and get rid of
private copy.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |  1 -
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f275c0fb0bf6..7ba789834e8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -388,8 +388,8 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 		msta = container_of(status->wcid, struct mt7615_sta, wcid);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->poll_list))
-			list_add_tail(&msta->poll_list,
+		if (list_empty(&msta->wcid.poll_list))
+			list_add_tail(&msta->wcid.poll_list,
 				      &dev->mt76.sta_poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
@@ -914,10 +914,10 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 		bool clear = false;
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
-					poll_list);
+					wcid.poll_list);
 
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		list_del_init(&msta->poll_list);
+		list_del_init(&msta->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
@@ -1516,8 +1516,8 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	sta = wcid_to_sta(wcid);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&msta->wcid.poll_list))
+		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	if (mt7615_mac_add_txs_skb(dev, msta, pid, txs_data))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e14f1f30ac31..200b1752ca77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -222,7 +222,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	idx = MT7615_WTBL_RESERVED - mvif->mt76.idx;
 
-	INIT_LIST_HEAD(&mvif->sta.poll_list);
+	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
@@ -275,8 +275,8 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mt7615_mutex_release(dev);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
@@ -657,7 +657,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->poll_list);
+	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
@@ -706,8 +706,8 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mt7615_mcu_add_bss_info(phy, vif, sta, false);
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 765ba986f07c..a20322aae967 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -125,7 +125,6 @@ struct mt7615_sta {
 
 	struct mt7615_vif *vif;
 
-	struct list_head poll_list;
 	u32 airtime_ac[8];
 
 	struct ieee80211_tx_rate rates[4];
-- 
2.41.0

