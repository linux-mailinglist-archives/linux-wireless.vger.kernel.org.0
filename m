Return-Path: <linux-wireless+bounces-12053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F2E960658
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D15428212E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240019CCED;
	Tue, 27 Aug 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="s56hYQC/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D118D65C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752529; cv=none; b=kScjwNGnbfncSvVmaShHK/3Bh6KvFkBUN+cJ10PiziQ/hL3EfRRC5AD2J+IzDCItZFLK3KYZmEsAJU9WB4WxxECBAlBpDKCBWhgyh0wSYLRR2JQLbHiuu/LrvhhrxW3sCsC1oVAy+EwgFT15B7VPs7MXJ7upqie8Hx8m2WOJgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752529; c=relaxed/simple;
	bh=cf7mpzTdqUDvGoAVcBpjwHE1ffg0pBxCHe73Jt3WpaQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj9Y8FoIRQZOHGic7EQuhkQR1ldu6dt8yjkmyJqWZbxhLtaMNpOMNg7/ajAtledUFxi3TFSKiKef/9re20poBI/T6uTgAPZ3UftioL6IIG9ZXOKG0/kg+KmQias/zLQ2u/M3tfcY/hutU4tx0BgiMFVQDsG5+Er+5kMUSOj60HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=s56hYQC/; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p3aHoapBM2LKw2r5UIeTGMAjRnbjJJNj/hAyCtC44pk=; b=s56hYQC/VI5cSffrpPmLkvqKDc
	1soXI0xbBux3AsXzOLTVjODPZMvvzRVmmcJr2m4rTMhaumuDl+9kc3mrFPAOjdDkE1ff7iguah1H0
	k2oGBUOZ1Xy1IG2NJUQh8Pk/CCGFzcm3KRxah6Z1YE8OEcnY87LT3noPB2LRPXl8nS7o=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWn-004Ww8-1x
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:17 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 19/24] wifi: mt76: mt7915: improve hardware restart reliability
Date: Tue, 27 Aug 2024 11:30:06 +0200
Message-ID: <20240827093011.18621-19-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- use reconfig_complete to restart mac_work / queues
- reset full wtbl after firmware init
- clear wcid and vif mask to avoid leak
- fix sta poll list corruption

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 27 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 12 +++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 ++
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index fc03cb499e71..54974ff72a5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1463,26 +1463,27 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 		if (!mt7915_mac_restart(dev))
 			break;
 	}
-	mutex_unlock(&dev->mt76.mutex);
 
 	if (i == 10)
 		dev_err(dev->mt76.dev, "chip full reset failed\n");
 
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	while (!list_empty(&dev->mt76.sta_poll_list))
+		list_del_init(dev->mt76.sta_poll_list.next);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	memset(dev->mt76.wcid_mask, 0, sizeof(dev->mt76.wcid_mask));
+	dev->mt76.vif_mask = 0;
+
+	i = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
+	dev->mt76.global_wcid.idx = i;
+	dev->recovery.hw_full_reset = false;
+
+	mutex_unlock(&dev->mt76.mutex);
+
 	ieee80211_restart_hw(mt76_hw(dev));
 	if (ext_phy)
 		ieee80211_restart_hw(ext_phy->hw);
-
-	ieee80211_wake_queues(mt76_hw(dev));
-	if (ext_phy)
-		ieee80211_wake_queues(ext_phy->hw);
-
-	dev->recovery.hw_full_reset = false;
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
-				     MT7915_WATCHDOG_TIME);
-	if (ext_phy)
-		ieee80211_queue_delayed_work(ext_phy->hw,
-					     &ext_phy->mac_work,
-					     MT7915_WATCHDOG_TIME);
 }
 
 /* system error recovery */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e80db20035ab..51885484aab6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1682,6 +1682,17 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 }
 #endif
 
+static void
+mt7915_reconfig_complete(struct ieee80211_hw *hw,
+			 enum ieee80211_reconfig_type reconfig_type)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+
+	ieee80211_wake_queues(hw);
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+				     MT7915_WATCHDOG_TIME);
+}
+
 const struct ieee80211_ops mt7915_ops = {
 	.add_chanctx = ieee80211_emulate_add_chanctx,
 	.remove_chanctx = ieee80211_emulate_remove_chanctx,
@@ -1740,4 +1751,5 @@ const struct ieee80211_ops mt7915_ops = {
 	.net_fill_forward_path = mt7915_net_fill_forward_path,
 	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
+	.reconfig_complete = mt7915_reconfig_complete,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 81375b5d0021..72c8e574dfb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2362,6 +2362,8 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	mt76_connac_mcu_del_wtbl_all(&dev->mt76);
+
 	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
 	     is_mt7915(&dev->mt76)) ||
 	    !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
-- 
2.46.0


