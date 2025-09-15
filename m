Return-Path: <linux-wireless+bounces-27303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE89DB5721B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C4E3B219E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A62E9EA8;
	Mon, 15 Sep 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="cpUgFndX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834C2E9EBB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923162; cv=none; b=CR+GV0WK9oKB6b8WqV7mFKO0Kyhb7TwdmW1HQ+RYIGXv8K3RA6UcIJZBXovMjFU0LkBYBhDSzbRLDQe//c2vs2/Mmz5iZKmqitNrg7gZss9rQn83GRhHnKGOWZIKS0sULKqeDjDcnCyE+Zat8NMEuYPB7RIIP+i24tOW9LBFjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923162; c=relaxed/simple;
	bh=PKw4MDpXjsWUbETZpVo3vrKffljzsw88SIj2SmYA6KE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oRnMjtfacT3yFSte71AnSe8NX4v9FMQTXuYGS3ZlxBxAX9yCPNyAQKz1OzUToPu8omNIKPliMwRkrjBLQb6I8ltXUELJ+VyF8jsnVjfk1TrlGhBP8OgAXGR+RemF6eH2r0zYm5+ZrO+LZYdWeuwE7ojkljG11LeUDd8TelGXvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=cpUgFndX; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ObXOQ1s3KdrgEepbmUFxsWVx/6vyW9kdvQOkkjpGeQ8=; b=cpUgFndXRwkUaNMCw9MCIbHRQ+
	nq1E8qlhLbTIDCCOsFaRl2Xh00oy705AEDGpIprNZoJfy2L2FhEwt5TL/C9oqENVKPBhgxMXOiAnp
	UXf3WjBHCZsV8HyrnjKeMkialg+pRqKGdUv292gthX+eJPtSfAzvUueRMdfTwS+QFyrA=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47D-0078GN-0G
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:11 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 01/15] wifi: mt76: mt7996: remove redundant per-phy mac80211 calls during restart
Date: Mon, 15 Sep 2025 09:58:56 +0200
Message-ID: <20250915075910.47558-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is only one wiphy, so extra calls must be removed.
For calls that need to remain per-wiphy, use mt7996_for_each_phy

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 137 +++++-------------
 1 file changed, 35 insertions(+), 102 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c1c4014e1475..f6c725f52c4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2220,13 +2220,10 @@ void mt7996_tx_token_put(struct mt7996_dev *dev)
 static int
 mt7996_mac_restart(struct mt7996_dev *dev)
 {
-	struct mt7996_phy *phy2, *phy3;
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt7996_phy *phy;
 	int i, ret;
 
-	phy2 = mt7996_phy2(dev);
-	phy3 = mt7996_phy3(dev);
-
 	if (dev->hif2) {
 		mt76_wr(dev, MT_INT1_MASK_CSR, 0x0);
 		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
@@ -2238,20 +2235,14 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0x0);
 	}
 
-	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt7996_for_each_phy(dev, phy)
+		set_bit(MT76_RESET, &phy->mt76->state);
 	wake_up(&dev->mt76.mcu.wait);
-	if (phy2)
-		set_bit(MT76_RESET, &phy2->mt76->state);
-	if (phy3)
-		set_bit(MT76_RESET, &phy3->mt76->state);
 
 	/* lock/unlock all queues to ensure that no tx is pending */
-	mt76_txq_schedule_all(&dev->mphy);
-	if (phy2)
-		mt76_txq_schedule_all(phy2->mt76);
-	if (phy3)
-		mt76_txq_schedule_all(phy3->mt76);
+	mt7996_for_each_phy(dev, phy)
+		mt76_txq_schedule_all(phy->mt76);
 
 	/* disable all tx/rx napi */
 	mt76_worker_disable(&dev->mt76.tx_worker);
@@ -2335,36 +2326,25 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 		goto out;
 
 	mt7996_mac_init(dev);
-	mt7996_init_txpower(&dev->phy);
-	mt7996_init_txpower(phy2);
-	mt7996_init_txpower(phy3);
+	mt7996_for_each_phy(dev, phy)
+		mt7996_init_txpower(phy);
 	ret = mt7996_txbf_init(dev);
+	if (ret)
+		goto out;
+
+	mt7996_for_each_phy(dev, phy) {
+		if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+			continue;
 
-	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
 		ret = mt7996_run(&dev->phy);
 		if (ret)
 			goto out;
 	}
 
-	if (phy2 && test_bit(MT76_STATE_RUNNING, &phy2->mt76->state)) {
-		ret = mt7996_run(phy2);
-		if (ret)
-			goto out;
-	}
-
-	if (phy3 && test_bit(MT76_STATE_RUNNING, &phy3->mt76->state)) {
-		ret = mt7996_run(phy3);
-		if (ret)
-			goto out;
-	}
-
 out:
 	/* reset done */
-	clear_bit(MT76_RESET, &dev->mphy.state);
-	if (phy2)
-		clear_bit(MT76_RESET, &phy2->mt76->state);
-	if (phy3)
-		clear_bit(MT76_RESET, &phy3->mt76->state);
+	mt7996_for_each_phy(dev, phy)
+		clear_bit(MT76_RESET, &phy->mt76->state);
 
 	napi_enable(&dev->mt76.tx_napi);
 	local_bh_disable();
@@ -2378,26 +2358,18 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 static void
 mt7996_mac_full_reset(struct mt7996_dev *dev)
 {
-	struct mt7996_phy *phy2, *phy3;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt7996_phy *phy;
 	int i;
 
-	phy2 = mt7996_phy2(dev);
-	phy3 = mt7996_phy3(dev);
 	dev->recovery.hw_full_reset = true;
 
 	wake_up(&dev->mt76.mcu.wait);
-	ieee80211_stop_queues(mt76_hw(dev));
-	if (phy2)
-		ieee80211_stop_queues(phy2->mt76->hw);
-	if (phy3)
-		ieee80211_stop_queues(phy3->mt76->hw);
+	ieee80211_stop_queues(hw);
 
 	cancel_work_sync(&dev->wed_rro.work);
-	cancel_delayed_work_sync(&dev->mphy.mac_work);
-	if (phy2)
-		cancel_delayed_work_sync(&phy2->mt76->mac_work);
-	if (phy3)
-		cancel_delayed_work_sync(&phy3->mt76->mac_work);
+	mt7996_for_each_phy(dev, phy)
+		cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
 	for (i = 0; i < 10; i++) {
@@ -2410,40 +2382,23 @@ mt7996_mac_full_reset(struct mt7996_dev *dev)
 		dev_err(dev->mt76.dev, "chip full reset failed\n");
 
 	ieee80211_restart_hw(mt76_hw(dev));
-	if (phy2)
-		ieee80211_restart_hw(phy2->mt76->hw);
-	if (phy3)
-		ieee80211_restart_hw(phy3->mt76->hw);
-
 	ieee80211_wake_queues(mt76_hw(dev));
-	if (phy2)
-		ieee80211_wake_queues(phy2->mt76->hw);
-	if (phy3)
-		ieee80211_wake_queues(phy3->mt76->hw);
 
 	dev->recovery.hw_full_reset = false;
-	ieee80211_queue_delayed_work(mt76_hw(dev),
-				     &dev->mphy.mac_work,
-				     MT7996_WATCHDOG_TIME);
-	if (phy2)
-		ieee80211_queue_delayed_work(phy2->mt76->hw,
-					     &phy2->mt76->mac_work,
-					     MT7996_WATCHDOG_TIME);
-	if (phy3)
-		ieee80211_queue_delayed_work(phy3->mt76->hw,
-					     &phy3->mt76->mac_work,
+	mt7996_for_each_phy(dev, phy)
+		ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 					     MT7996_WATCHDOG_TIME);
 }
 
 void mt7996_mac_reset_work(struct work_struct *work)
 {
-	struct mt7996_phy *phy2, *phy3;
+	struct ieee80211_hw *hw;
 	struct mt7996_dev *dev;
+	struct mt7996_phy *phy;
 	int i;
 
 	dev = container_of(work, struct mt7996_dev, reset_work);
-	phy2 = mt7996_phy2(dev);
-	phy3 = mt7996_phy3(dev);
+	hw = mt76_hw(dev);
 
 	/* chip full reset */
 	if (dev->recovery.restart) {
@@ -2474,7 +2429,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		return;
 
 	dev_info(dev->mt76.dev,"\n%s L1 SER recovery start.",
-		 wiphy_name(dev->mt76.hw->wiphy));
+		 wiphy_name(hw->wiphy));
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed_hif2))
 		mtk_wed_device_stop(&dev->mt76.mmio.wed_hif2);
@@ -2483,25 +2438,17 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		mtk_wed_device_stop(&dev->mt76.mmio.wed);
 
 	ieee80211_stop_queues(mt76_hw(dev));
-	if (phy2)
-		ieee80211_stop_queues(phy2->mt76->hw);
-	if (phy3)
-		ieee80211_stop_queues(phy3->mt76->hw);
 
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 
 	cancel_work_sync(&dev->wed_rro.work);
-	cancel_delayed_work_sync(&dev->mphy.mac_work);
-	if (phy2) {
-		set_bit(MT76_RESET, &phy2->mt76->state);
-		cancel_delayed_work_sync(&phy2->mt76->mac_work);
-	}
-	if (phy3) {
-		set_bit(MT76_RESET, &phy3->mt76->state);
-		cancel_delayed_work_sync(&phy3->mt76->mac_work);
+	mt7996_for_each_phy(dev, phy) {
+		set_bit(MT76_RESET, &phy->mt76->state);
+		cancel_delayed_work_sync(&phy->mt76->mac_work);
 	}
+
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
@@ -2553,11 +2500,8 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	}
 
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
-	clear_bit(MT76_RESET, &dev->mphy.state);
-	if (phy2)
-		clear_bit(MT76_RESET, &phy2->mt76->state);
-	if (phy3)
-		clear_bit(MT76_RESET, &phy3->mt76->state);
+	mt7996_for_each_phy(dev, phy)
+		clear_bit(MT76_RESET, &phy->mt76->state);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
@@ -2579,25 +2523,14 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	napi_schedule(&dev->mt76.tx_napi);
 	local_bh_enable();
 
-	ieee80211_wake_queues(mt76_hw(dev));
-	if (phy2)
-		ieee80211_wake_queues(phy2->mt76->hw);
-	if (phy3)
-		ieee80211_wake_queues(phy3->mt76->hw);
+	ieee80211_wake_queues(hw);
 
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt7996_update_beacons(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
-				     MT7996_WATCHDOG_TIME);
-	if (phy2)
-		ieee80211_queue_delayed_work(phy2->mt76->hw,
-					     &phy2->mt76->mac_work,
-					     MT7996_WATCHDOG_TIME);
-	if (phy3)
-		ieee80211_queue_delayed_work(phy3->mt76->hw,
-					     &phy3->mt76->mac_work,
+	mt7996_for_each_phy(dev, phy)
+		ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 					     MT7996_WATCHDOG_TIME);
 	dev_info(dev->mt76.dev,"\n%s L1 SER recovery completed.",
 		 wiphy_name(dev->mt76.hw->wiphy));
-- 
2.51.0


