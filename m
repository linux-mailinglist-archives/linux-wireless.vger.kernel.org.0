Return-Path: <linux-wireless+bounces-33240-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NZzMJqJtmlmDAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33240-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A26290681
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD09301ECEB
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481C26ED41;
	Sun, 15 Mar 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PghcMoSe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8122068D
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773570442; cv=none; b=kNk3sFIld6C939HvUR0d7m0CzKIwkjB4OH3PwdYFOWdDAkN4f1JjxROyNIvSjI5OgSMXqeNmXG6NbT2HsXR3kc+78iFEZNRbfgqyTKv6pLGO1BQF75EIrtC9pG7Lr/TZUIKBPvq1QaCxM91ayV2joDEcloBGp0PR1/6Dn8TkSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773570442; c=relaxed/simple;
	bh=RpoF+B4D/eUYxEn76AnVBIL0u0AIFSztUUSg3zdlIFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIpzwSu5CUIZMopJPIhxtWk+l40dIDsgBXtAL3xgMnHSpZdCeczWWx7lE9cnAVeSCd7xixyM8pgGCBZIxXRiQHB3T94O4z116i9yNfuuq2mIb7rrFuT/6qCSzKkc74o1VQEW+fZ62uHgPP9ZIvN9UhaBro/D501NND5/2Fy2iV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PghcMoSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E42C2BC9E;
	Sun, 15 Mar 2026 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773570441;
	bh=RpoF+B4D/eUYxEn76AnVBIL0u0AIFSztUUSg3zdlIFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PghcMoSekIlNfqQOdvR3I44/qOAtlLmPazjq748mGrOfI+lpl0lZIE4k5EHAB8vju
	 M80InoE/DDEDji2pURzrjMgaoC9QQPMRFP10noBjX6s9F3GHTVbD1AYKkYOfitWfH4
	 2JbpdXUgHrf/Wx4J+en6V3FAeJMRe5c3/r1pfMwYI3iGiZ/sxsBd0SKE4Wxg2LX7gv
	 ibwnPvHnoeY4W/kGwo7BUXx0cmjeYNEfAbEkP0452gSsrhgWLB7gjCNNEEHj/tQ3ZP
	 pKOuwYy9UlxESG2rv4XjEG7ls7kBWfveiXnnZNE+HHYPMA5/s5V8NsThxl6rHmVxiw
	 GlPCn0xUO/ufw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Mar 2026 11:26:27 +0100
Subject: [PATCH mt76 4/6] wifi: mt76: mt7996: Destroy vif active links in
 mt7996_remove_interface()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-mt7996-mlo-link-reconf-v1-4-a8a634fbc927@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-33240-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 64A26290681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MT7996 hw requires to remove active links from the mcu BSSINFO table
destroying the interface. For this reason introduce mt7996_vif_link_destroy
routine and remove active (non-offchannel) vif links running
mt7996_remove_interface routine.
This is a preliminary patch in order to support MLO link reconfiguration
in MT7996 driver.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 108 +++++++++++++++--------
 1 file changed, 72 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index feee93340a6c691d38858230a5f05627aac1c07f..d8ef41c39a7f3d8801e05bfa6e2d22ed9d0371b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -306,6 +306,10 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	};
 	int mld_idx, idx, ret;
 
+	if ((mvif->mt76.valid_links & BIT(link_conf->link_id)) &&
+	    !mlink->offchannel)
+		return 0;
+
 	mlink->idx = __ffs64(~dev->mt76.vif_mask);
 	if (mlink->idx >= mt7996_max_interface_num(dev))
 		return -ENOSPC;
@@ -393,65 +397,40 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	return 0;
 }
 
-void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
-			    struct ieee80211_bss_conf *link_conf,
-			    struct mt76_vif_link *mlink)
+static void mt7996_vif_link_destroy(struct mt7996_phy *phy,
+				    struct mt7996_vif_link *link,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *link_conf)
 {
-	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
 	unsigned int link_id = msta_link->wcid.link_id;
-	struct mt7996_phy *phy = mphy->priv;
-	struct mt7996_dev *dev = phy->dev;
+	struct mt76_vif_link *mlink = &link->mt76;
 	struct mt7996_key_iter_data it = {
 		.cmd = SET_KEY,
 		.link_id = link_id,
 	};
+	struct mt7996_dev *dev = phy->dev;
 	int idx = msta_link->wcid.idx;
 
-	if (!mlink->wcid->offchannel)
-		ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
-
 	if (!link_conf)
 		link_conf = &vif->bss_conf;
 
+	if (!mlink->wcid->offchannel)
+		ieee80211_iter_keys(phy->mt76->hw, vif, mt7996_key_iter, &it);
+
 	mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
 			   CONN_STATE_DISCONNECT, false);
 	mt7996_mcu_add_bss_info(phy, vif, link_conf, mlink, msta_link, false);
-
 	mt7996_mcu_add_dev_info(phy, vif, link_conf, mlink, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	if (!mlink->wcid->offchannel) {
-		if (vif->txq && mvif->mt76.deflink_id == link_id) {
-			struct ieee80211_bss_conf *iter;
-			struct mt76_txq *mtxq;
-
-			mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
-			mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-			/* Primary link will be removed, look for a new one */
-			for_each_vif_active_link(vif, iter, link_id) {
-				struct mt7996_vif_link *link;
-
-				if (link_id == msta_link->wcid.link_id)
-					continue;
-
-				link = mt7996_vif_link(dev, vif, link_id);
-				if (!link)
-					continue;
-
-				mtxq->wcid = link->msta_link.wcid.idx;
-				mvif->mt76.deflink_id = link_id;
-				break;
-			}
-		}
-		mvif->mt76.valid_links &= ~BIT(link_id);
-	}
-
 	dev->mt76.vif_mask &= ~BIT_ULL(mlink->idx);
 	dev->mld_idx_mask &= ~BIT_ULL(link->mld_idx);
 	phy->omac_mask &= ~BIT_ULL(mlink->omac_idx);
+	if (!mlink->wcid->offchannel)
+		mvif->mt76.valid_links &= ~BIT(link_id);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta_link->wcid.poll_list))
@@ -467,6 +446,44 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	}
 }
 
+void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink)
+{
+	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta_link *msta_link = &link->msta_link;
+	struct mt7996_phy *phy = mphy->priv;
+
+	/* Hw requires to destroy active links tearing down the interface, so
+	 * postpone it removing the interface.
+	 */
+	if (mlink->wcid->offchannel) {
+		mt7996_vif_link_destroy(phy, link, vif, link_conf);
+	} else if (vif->txq &&
+		   mvif->mt76.deflink_id == msta_link->wcid.link_id) {
+		struct ieee80211_bss_conf *iter;
+		struct mt76_txq *mtxq;
+		unsigned int link_id;
+
+		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		/* Primary link will be removed, look for a new one */
+		for_each_vif_active_link(vif, iter, link_id) {
+			if (link_id == msta_link->wcid.link_id)
+				continue;
+
+			link = mt7996_vif_link(phy->dev, vif, link_id);
+			if (!link)
+				continue;
+
+			mtxq->wcid = link->msta_link.wcid.idx;
+			mvif->mt76.deflink_id = link_id;
+			break;
+		}
+	}
+}
+
 static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
 {
 	struct mt7996_dev *dev = phy->dev;
@@ -570,10 +587,29 @@ static void mt7996_remove_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 static void mt7996_remove_interface(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif)
 {
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	unsigned long rem_links = mvif->mt76.valid_links;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_radio_data rdata = {};
+	unsigned int link_id;
 	int i;
 
+	/* Remove all active links */
+	for_each_set_bit(link_id, &rem_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt7996_vif_link *link;
+		struct mt7996_phy *phy;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
+
+		phy = __mt7996_phy(dev, link->msta_link.wcid.phy_idx);
+		if (!phy)
+			continue;
+
+		mt7996_vif_link_destroy(phy, link, vif, NULL);
+	}
+
 	ieee80211_iterate_active_interfaces_mtx(hw, 0, mt7996_remove_iter,
 						&rdata);
 	mt76_vif_cleanup(&dev->mt76, vif);

-- 
2.53.0


