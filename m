Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4571481A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjE2KmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjE2KmK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A24D8
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E1F26117D
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630B1C433D2;
        Mon, 29 May 2023 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356925;
        bh=CmX+NyWutRvJjpcLPw93kHmJ/xA/S+GbD4+05GXuTxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lC/ofyhVmbVELFFeyDbCbdwP5HrJeM68CQvR+npj2Vva/+Hb2eUYcJyclywpBgx32
         WzIuqGVQ2xFY5yh3lhnpYQh+4R9P26m3KOkMLHaJL0CW2Dw2lzlVc8yIKpFvxK/f/i
         e9VgrOsbSFRMXbXDpXK92V4lTHJEOKklKgtc3IPSBh0q0lZQg5IrWQj4JHt3Z1IyJO
         2tvSZOfUK6mhfpiWRYVBDzJyOzUvgu1iPQY+Hhna4kgRLcDP6kQtO/Lq1ahGxaFFm3
         drRDWUCAFhxzNdNg5lFpQQRZUXU1NzYNU8IRYaD0G3R8CWoRaRlBWhzbdQ7EULFkc0
         YvKfaCwDisWDA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 09/13] wifi: mt76: mt7615: rely on shared poll_list field
Date:   Mon, 29 May 2023 12:41:00 +0200
Message-Id: <b05ef344d7cef16153a2f2ed61353283d092edcf.1685356673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685356673.git.lorenzo@kernel.org>
References: <cover.1685356673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index a6d267c56dd4..8bf5a51cbb58 100644
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
@@ -914,8 +914,8 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 		bool clear = false;
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
-					poll_list);
-		list_del_init(&msta->poll_list);
+					wcid.poll_list);
+		list_del_init(&msta->wcid.poll_list);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
@@ -1541,8 +1541,8 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	sta = wcid_to_sta(wcid);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->poll_list))
-		list_add_tail(&msta->poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&msta->wcid.poll_list))
+		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	if (mt7615_mac_add_txs_skb(dev, msta, pid, txs_data))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2a5462bd54c2..5c342d85b8d8 100644
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
@@ -629,7 +629,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->poll_list);
+	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
@@ -678,8 +678,8 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mt7615_mcu_add_bss_info(phy, vif, sta, false);
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->poll_list))
-		list_del_init(&msta->poll_list);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 7386495f8299..6a7c14dbf72e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -125,7 +125,6 @@ struct mt7615_sta {
 
 	struct mt7615_vif *vif;
 
-	struct list_head poll_list;
 	u32 airtime_ac[8];
 
 	struct ieee80211_tx_rate rates[4];
-- 
2.40.1

