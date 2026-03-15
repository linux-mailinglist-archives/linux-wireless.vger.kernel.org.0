Return-Path: <linux-wireless+bounces-33242-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDNYO6SJtmlmDAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33242-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F64290688
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906543019F28
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F8B27281E;
	Sun, 15 Mar 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFLMAINd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537A22068D
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773570447; cv=none; b=E4IIWgY+Ty9alv7KXtRnOljO3iAVDuk5k7SVQ92JAqCiUKHTfl3L+U/kNc+PyraqQHEoALaGEbx4MQDwLSDOrAW78Q4EwYvF719nvakx6mqAc1KM4YkaD2i8AX7+b/yGyyI65qTsO8T18f38kXygX0xbT9sUAE50Ok6u96Seikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773570447; c=relaxed/simple;
	bh=g6taqoJma99e09pGekb7abf4NFspxcrhz3CA76z5Rbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsyoFufZ0stQ+NvGrL6ByLWMfbD8D1gNSuSr5IMCqVttqvObB//6XHuP9gewrqQEms2G3kaAy5apjFSmzwFdvRwXQ2A/D40BaACRhHZoNTw1zoUQ52D41MWtN48Opls/WWp6eO1JEafHC8NdmpNDgsPIwvnh0oB3Dg7+810S8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFLMAINd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8182AC19424;
	Sun, 15 Mar 2026 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773570446;
	bh=g6taqoJma99e09pGekb7abf4NFspxcrhz3CA76z5Rbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FFLMAINdtlxIOL5aPjDYxk8K8LciA1vjxukSp9GR5DlAEifZUGqm83B+RkRx7mM8X
	 VzxRYPx6yL5EaVR849FuTYZPLddXh20IPJKIEXUOv4Wi2yGg39phJ6eM30FraxPu/l
	 bdQxv/i6Om8IWrLauDQaroLOJ8kgJoQCBU1VasyTNfysfan5LSl9iAUVsddRbX5XFf
	 YTtlvaWBYuz9Q2r0t8hG/9KgY/8IsoHUn9YuaPsKzjRR7c5RQ0sb3yrmwF9v1kxvDK
	 ZN7ivllmlybVHM71NhZHvHeB8hbmZG8IwI5M3d+irA/atoCQlxEojMCyDvERw7WtkA
	 XUgItsCTm3Jmg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Mar 2026 11:26:29 +0100
Subject: [PATCH mt76 6/6] wifi: mt76: mt7996: Destroy active sta links in
 mt7996_mac_sta_remove()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-mt7996-mlo-link-reconf-v1-6-a8a634fbc927@kernel.org>
References: <20260315-mt7996-mlo-link-reconf-v1-0-a8a634fbc927@kernel.org>
In-Reply-To: <20260315-mt7996-mlo-link-reconf-v1-0-a8a634fbc927@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33242-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93F64290688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to vif link management, postpone sta link destuction in
mt7996_mac_sta_remove() introducing mt7996_mac_sta_remove_link utility
routine and just disable sta link running mt7996_mac_sta_remove_links
routine.
This is a preliminary patch in order to support MLO link reconfiguration
in MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 22 +------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 67 +++++++++++++---------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  5 +-
 3 files changed, 45 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 5e5b6198f8be5707deb6746d2da899930e20da7b..bffcbfb0fa3ea6a8cc1c237039c0ecc70c2830f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2372,26 +2372,8 @@ mt7996_mac_reset_sta_iter(void *data, struct ieee80211_sta *sta)
 	struct mt7996_dev *dev = data;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(msta->link); i++) {
-		struct mt7996_sta_link *msta_link = NULL;
-		struct mt7996_phy *phy;
-
-		msta_link = rcu_replace_pointer(msta->link[i], msta_link,
-						lockdep_is_held(&dev->mt76.mutex));
-		if (!msta_link)
-			continue;
-
-		mt7996_mac_sta_deinit_link(dev, msta_link);
-		phy = __mt7996_phy(dev, msta_link->wcid.phy_idx);
-		if (phy)
-			phy->mt76->num_sta--;
-
-		if (msta_link != &msta->deflink)
-			kfree_rcu(msta_link, rcu_head);
-	}
-
-	msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
-	msta->seclink_id = msta->deflink_id;
+	for (i = 0; i < ARRAY_SIZE(msta->link); i++)
+		mt7996_mac_sta_remove_link(dev, sta, i, true);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ac82ea3f066a618d4a91c0a88922cf77bd0533da..a8a6552d49f69a447eed8fc9c6620c43b0f868c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1179,9 +1179,17 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 	return 0;
 }
 
-void mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
-				struct mt7996_sta_link *msta_link)
+void mt7996_mac_sta_remove_link(struct mt7996_dev *dev,
+				struct ieee80211_sta *sta,
+				unsigned int link_id, bool flush)
 {
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link;
+
+	msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+	if (!msta_link)
+		return;
+
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta_link->wcid.poll_list))
 		list_del_init(&msta_link->wcid.poll_list);
@@ -1189,31 +1197,13 @@ void mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
 		list_del_init(&msta_link->rc_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	rcu_assign_pointer(dev->mt76.wcid[msta_link->wcid.idx], NULL);
 	mt76_wcid_cleanup(&dev->mt76, &msta_link->wcid);
-	mt76_wcid_mask_clear(dev->mt76.wcid_mask, msta_link->wcid.idx);
-}
-
-static void
-mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, unsigned long links)
-{
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt76_dev *mdev = &dev->mt76;
-	unsigned int link_id;
 
-	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct mt7996_sta_link *msta_link = NULL;
+	if (msta_link->wcid.link_valid) {
 		struct mt7996_phy *phy;
 
-		msta_link = rcu_replace_pointer(msta->link[link_id], msta_link,
-						lockdep_is_held(&mdev->mutex));
-		if (!msta_link)
-			continue;
-
 		mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-		mt7996_mac_sta_deinit_link(dev, msta_link);
 
 		phy = __mt7996_phy(dev, msta_link->wcid.phy_idx);
 		if (phy)
@@ -1230,7 +1220,7 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 				/* switch to the secondary link */
 				msta_seclink = mt76_dereference(
 						msta->link[msta->seclink_id],
-						mdev);
+						&dev->mt76);
 				if (msta_seclink) {
 					msta->deflink_id = msta->seclink_id;
 					mt7996_sta_init_txq_wcid(sta,
@@ -1240,12 +1230,29 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		} else if (msta->seclink_id == link_id) {
 			msta->seclink_id = msta->deflink_id;
 		}
+		msta_link->wcid.link_valid = false;
+	}
 
+	if (flush) {
+		rcu_assign_pointer(msta->link[link_id], NULL);
+		rcu_assign_pointer(dev->mt76.wcid[msta_link->wcid.idx], NULL);
+		mt76_wcid_mask_clear(dev->mt76.wcid_mask, msta_link->wcid.idx);
 		if (msta_link != &msta->deflink)
 			kfree_rcu(msta_link, rcu_head);
 	}
 }
 
+static void
+mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, unsigned long links,
+			    bool flush)
+{
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS)
+		mt7996_mac_sta_remove_link(dev, sta, link_id, flush);
+}
+
 static int
 mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, unsigned long new_links)
@@ -1257,11 +1264,15 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf;
 		struct ieee80211_link_sta *link_sta;
+		struct mt7996_sta_link *msta_link;
 		struct mt7996_vif_link *link;
 		struct mt76_phy *mphy;
 
-		if (rcu_access_pointer(msta->link[link_id]))
+		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		if (msta_link) {
+			msta_link->wcid.link_valid = true;
 			continue;
+		}
 
 		link_conf = link_conf_dereference_protected(vif, link_id);
 		if (!link_conf) {
@@ -1298,7 +1309,7 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	return 0;
 
 error_unlink:
-	mt7996_mac_sta_remove_links(dev, vif, sta, new_links);
+	mt7996_mac_sta_remove_links(dev, vif, sta, new_links, true);
 
 	return err;
 }
@@ -1315,7 +1326,7 @@ mt7996_mac_sta_change_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt7996_mac_sta_remove_links(dev, vif, sta, rem);
+	mt7996_mac_sta_remove_links(dev, vif, sta, rem, false);
 	ret = mt7996_mac_sta_add_links(dev, vif, sta, add);
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -1424,10 +1435,12 @@ static void
 mt7996_mac_sta_remove(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		      struct ieee80211_sta *sta)
 {
-	unsigned long links = sta->valid_links ? sta->valid_links : BIT(0);
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	int i;
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7996_mac_sta_remove_links(dev, vif, sta, links);
+	for (i = 0; i < ARRAY_SIZE(msta->link); i++)
+		mt7996_mac_sta_remove_link(dev, sta, i, true);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index e0a5c4eeb5165f2b789bbbf7d731a8ff3aaab49f..bdcf7245795497655c3e49c72b522dd25db5a251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -867,8 +867,9 @@ void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
 				  struct mt7996_vif_link *link,
 				  struct mt7996_sta_link *msta_link,
 				  u8 flowid);
-void mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
-				struct mt7996_sta_link *msta_link);
+void mt7996_mac_sta_remove_link(struct mt7996_dev *dev,
+				struct ieee80211_sta *sta,
+				unsigned int link_id, bool flush);
 void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 			      struct ieee80211_sta *sta,
 			      struct ieee80211_twt_setup *twt);

-- 
2.53.0


