Return-Path: <linux-wireless+bounces-24828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E0AF93B2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25234A3F63
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E92F94B4;
	Fri,  4 Jul 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG3HQW/E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA02F9484
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634528; cv=none; b=NojGpdPplFNj7BEMeCvQ/juOe1X5xMlgFZIKXZ06Must1gK6T5TsXlJ5e/13U2XbuNxZRf0EhFMqcFfYvOZhPIq3poYyWd8pb2iinNYKj5v1kFVt7PKwR8DvA4ZRNUBbf1CBSSCMTgSNBORKYPQgbMEmpwpEDeM0b/Pi6netGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634528; c=relaxed/simple;
	bh=MNN957gl/XvFVsV+v94sSjjJXgimNA11TE2gLceFiKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQMpSoSiKO103iX2McxHIM6N7XAN00vb9BrFb+o+l+7Cyq3BOSwK9acd2sULO1bSLUBlTgLhKIYKepl3zlZ3g/5GVU3bVAT5RKggF4+w8UM17ZBd9gg7cX4ZA+ZZCOG2zcloHF98ypSWbMhVdIfcDCtU+vuA5TTRclMj+qbGNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG3HQW/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75A6C4CEE3;
	Fri,  4 Jul 2025 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634528;
	bh=MNN957gl/XvFVsV+v94sSjjJXgimNA11TE2gLceFiKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TG3HQW/EXwpyrvLIWf6ZxyjxUFkliXFdXt15xnEykwu04weKly1VM4PwNr+fLibXf
	 K+bJiEpO7FTZa26CNyBzErF05GIHjXfYO4XJPLBmpViE3YppgkfbwH/fkTe8k9NPID
	 V2XfO22p92pgMGv19e2oYvPzXlXxydGtanQIVbvUfc1YYVU44I0JdmrIAcOdBgvKKq
	 6wiPLvX7B7tI97scXnclJr/hojA9GTKLEJI/0rrqZv8r057uDIe7Q1Qs/QBDU0Mjfw
	 R/hRXxHEqOxPw5awKfcOALD6YksJ1hAnFaNJVvZD1Z2VaQCWQTjUyerwwgC6IPku7M
	 Ji705VbFK2l6A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:13 +0200
Subject: [PATCH mt76 9/9] wifi: mt76: mt7996: Move num_sta accounting in
 mt7996_mac_sta_{add,remove}_links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-9-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Move phy num_sta accounting in mt7996_mac_sta_add() and
mt7996_mac_sta_remove() routines in order to take into account all
possibles MLO links.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 58 +++++++++++++-----------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ea0cdd092a3f396c2a8cb655ff941b833fb9983e..f846b8309ae2e9c39f9d5f2a21ca1edd89dcdf0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -960,8 +960,8 @@ mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
 }
 
 static void
-mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_sta *sta,
-			    unsigned long links)
+mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, unsigned long links)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt76_dev *mdev = &dev->mt76;
@@ -969,6 +969,8 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_sta *sta,
 
 	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct mt7996_sta_link *msta_link = NULL;
+		struct mt7996_vif_link *link;
+		struct mt76_phy *mphy;
 
 		msta_link = rcu_replace_pointer(msta->link[link_id], msta_link,
 						lockdep_is_held(&mdev->mutex));
@@ -976,6 +978,15 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_sta *sta,
 			continue;
 
 		mt7996_mac_sta_deinit_link(dev, msta_link);
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
+
+		mphy = mt76_vif_link_phy(&link->mt76);
+		if (!mphy)
+			continue;
+
+		mphy->num_sta--;
 		if (msta->deflink_id == link_id) {
 			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
 			continue;
@@ -997,6 +1008,7 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *link_conf;
 		struct ieee80211_link_sta *link_sta;
 		struct mt7996_vif_link *link;
+		struct mt76_phy *mphy;
 
 		if (rcu_access_pointer(msta->link[link_id]))
 			continue;
@@ -1023,12 +1035,19 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 					       link_id);
 		if (err)
 			goto error_unlink;
+
+		mphy = mt76_vif_link_phy(&link->mt76);
+		if (!mphy) {
+			err = -EINVAL;
+			goto error_unlink;
+		}
+		mphy->num_sta++;
 	}
 
 	return 0;
 
 error_unlink:
-	mt7996_mac_sta_remove_links(dev, sta, new_links);
+	mt7996_mac_sta_remove_links(dev, vif, sta, new_links);
 
 	return err;
 }
@@ -1045,7 +1064,7 @@ mt7996_mac_sta_change_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt7996_mac_sta_remove_links(dev, sta, rem);
+	mt7996_mac_sta_remove_links(dev, vif, sta, rem);
 	ret = mt7996_mac_sta_add_links(dev, vif, sta, add);
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -1054,25 +1073,21 @@ mt7996_mac_sta_change_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 
 static int
-mt7996_mac_sta_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+mt7996_mac_sta_add(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta)
 {
-	struct mt76_dev *mdev = mphy->dev;
-	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	unsigned long links = sta->valid_links ? sta->valid_links : BIT(0);
 	int err;
 
-	mutex_lock(&mdev->mutex);
+	mutex_lock(&dev->mt76.mutex);
 
 	msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
 	msta->vif = mvif;
 	err = mt7996_mac_sta_add_links(dev, vif, sta, links);
-	if (!err)
-		mphy->num_sta++;
 
-	mutex_unlock(&mdev->mutex);
+	mutex_unlock(&dev->mt76.mutex);
 
 	return err;
 }
@@ -1150,19 +1165,14 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mac_sta_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+mt7996_mac_sta_remove(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		      struct ieee80211_sta *sta)
 {
-	struct mt76_dev *mdev = mphy->dev;
-	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	unsigned long links = sta->valid_links ? sta->valid_links : BIT(0);
 
-	mutex_lock(&mdev->mutex);
-
-	mt7996_mac_sta_remove_links(dev, sta, links);
-	mphy->num_sta--;
-
-	mutex_unlock(&mdev->mutex);
+	mutex_lock(&dev->mt76.mutex);
+	mt7996_mac_sta_remove_links(dev, vif, sta, links);
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 static int
@@ -1170,20 +1180,16 @@ mt7996_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		 struct ieee80211_sta *sta, enum ieee80211_sta_state old_state,
 		 enum ieee80211_sta_state new_state)
 {
-	struct mt76_phy *mphy = mt76_vif_phy(hw, vif);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	enum mt76_sta_event ev;
 
-	if (!mphy)
-		return -EINVAL;
-
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE)
-		return mt7996_mac_sta_add(mphy, vif, sta);
+		return mt7996_mac_sta_add(dev, vif, sta);
 
 	if (old_state == IEEE80211_STA_NONE &&
 	    new_state == IEEE80211_STA_NOTEXIST)
-		mt7996_mac_sta_remove(mphy, vif, sta);
+		mt7996_mac_sta_remove(dev, vif, sta);
 
 	if (old_state == IEEE80211_STA_AUTH &&
 	    new_state == IEEE80211_STA_ASSOC)

-- 
2.50.0


