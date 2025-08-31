Return-Path: <linux-wireless+bounces-26880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F44B3D58A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 00:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F390018985ED
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Aug 2025 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8B22F76F;
	Sun, 31 Aug 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxz1Y0SD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF24A04
	for <linux-wireless@vger.kernel.org>; Sun, 31 Aug 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756678496; cv=none; b=B1zqbJ46T29kk3jMgCKtizqH6MTKlD/dN9uBo4aEA32dp56OmAqcPclWnW766f9D8z6V2QGPT+BMJOFuEqKH3s0/xMkIkGUNPj54Ex0yPsz4Yk4HAfBcfeT8JGJAn/PQxv1OsHBZ+yAtWnnOA/ky+35jALv1YuKP4dY01Hdd8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756678496; c=relaxed/simple;
	bh=3Xss2Co3He96uRMaXnCLjMQL0IkTNyb4K4s+G1NFEY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n7igsw2I+ntYpg0pxOsq/jPxBulfB/OGZVWMgnriLJQNyRjFrx3vPPBRMalbo0oUYVxHxBvx+maiVXiyK0mgwgrl4jFTklIIr9rj/FtqiEepgPAfkBxxtKXrxKvODTf3F6pSWwbDD6jKZ/vJnubXs4tLc+USuj8kSC73j5S7+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxz1Y0SD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA38C4CEED;
	Sun, 31 Aug 2025 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756678496;
	bh=3Xss2Co3He96uRMaXnCLjMQL0IkTNyb4K4s+G1NFEY8=;
	h=From:Date:Subject:To:Cc:From;
	b=sxz1Y0SDU6qOkz8svjCRGFQhGoKXfbodfvAE42iVSDCQFREY0WK89E3wE01hjtyhd
	 OcoT4LPn+y1pV2o2H/GGHDioCq9NBBa5vmENZ6jteFJWhsU4Woz2R6oWYEUu6g1XNY
	 kHDfDtApSKifk/oWHXALG3q05tT5fcG8HEzCAV7UU3RJYtumkpnjobO3DYP9qkybMc
	 ypBn1hvE+I6DJdis3TSmGnJALGEPLAv8fKP86VlHbifBE05Y3nuneUcqc0ZfAHPaQw
	 HozvhyFowbj1AC08V73yPEqYWH5yZvLO7VZXn2zWkka+fslrA7c1PwG/YHwALtg3x7
	 U4mrqkGqThWzA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Sep 2025 00:14:37 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Use proper link_id in
 link_sta_rc_update callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mt7996-fix-link_sta_rc_update-callback-v1-1-e24caf196222@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEzJtGgC/x2NQQ7CIBAAv9Ls2U2gxFr8ijFkgVU3RWwAjUnTv
 0s8zmFmNqhchCuchw0Kf6TKK3fQhwHCg/KdUWJnGNV4VLPR+Gwnaye8yReT5MXVRq4E914jNcZ
 AKXkKC8aZlDFWs/cT9NhauCv/0eW67z+bvBSJeAAAAA==
X-Change-ID: 20250831-mt7996-fix-link_sta_rc_update-callback-d8a03391ebb6
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Do not always use deflink_id in link_sta_rc_update mac80211
callback but use the proper link_id provided by mac80211.

Fixes: 0762bdd30279f ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 43 +++++++++++++++---------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 7f3a117c52bd3438b6bb41a068bbf11658dfba42..21d290cad4f49b06c8dc8d3fc103da7ccaca99b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1662,19 +1662,13 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 	}
 }
 
-static void mt7996_link_rate_ctrl_update(void *data, struct ieee80211_sta *sta)
+static void mt7996_link_rate_ctrl_update(void *data,
+					 struct mt7996_sta_link *msta_link)
 {
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta *msta = msta_link->sta;
 	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
-	struct mt7996_sta_link *msta_link;
 	u32 *changed = data;
 
-	rcu_read_lock();
-
-	msta_link = rcu_dereference(msta->link[msta->deflink_id]);
-	if (!msta_link)
-		goto out;
-
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 
 	msta_link->changed |= *changed;
@@ -1682,8 +1676,6 @@ static void mt7996_link_rate_ctrl_update(void *data, struct ieee80211_sta *sta)
 		list_add_tail(&msta_link->rc_list, &dev->sta_rc_list);
 
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
-out:
-	rcu_read_unlock();
 }
 
 static void mt7996_link_sta_rc_update(struct ieee80211_hw *hw,
@@ -1691,11 +1683,32 @@ static void mt7996_link_sta_rc_update(struct ieee80211_hw *hw,
 				      struct ieee80211_link_sta *link_sta,
 				      u32 changed)
 {
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct ieee80211_sta *sta = link_sta->sta;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link;
 
-	mt7996_link_rate_ctrl_update(&changed, sta);
-	ieee80211_queue_work(hw, &dev->rc_work);
+	rcu_read_lock();
+
+	msta_link = rcu_dereference(msta->link[link_sta->link_id]);
+	if (msta_link) {
+		struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+		mt7996_link_rate_ctrl_update(&changed, msta_link);
+		ieee80211_queue_work(hw, &dev->rc_work);
+	}
+
+	rcu_read_unlock();
+}
+
+static void mt7996_sta_rate_ctrl_update(void *data, struct ieee80211_sta *sta)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link;
+	u32 *changed = data;
+
+	msta_link = rcu_dereference(msta->link[msta->deflink_id]);
+	if (msta_link)
+		mt7996_link_rate_ctrl_update(&changed, msta_link);
 }
 
 static int
@@ -1716,7 +1729,7 @@ mt7996_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	 * - multiple rates: if it's not in range format i.e 0-{7,8,9} for VHT
 	 * then multiple MCS setting (MCS 4,5,6) is not supported.
 	 */
-	ieee80211_iterate_stations_atomic(hw, mt7996_link_rate_ctrl_update,
+	ieee80211_iterate_stations_atomic(hw, mt7996_sta_rate_ctrl_update,
 					  &changed);
 	ieee80211_queue_work(hw, &dev->rc_work);
 

---
base-commit: 035ba65d13516fa2afa78203ba3ef54fd70584af
change-id: 20250831-mt7996-fix-link_sta_rc_update-callback-d8a03391ebb6

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


