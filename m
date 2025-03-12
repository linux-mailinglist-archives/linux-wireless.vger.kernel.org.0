Return-Path: <linux-wireless+bounces-20247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10629A5DB3A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417CC7AB886
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0B241691;
	Wed, 12 Mar 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpmJEhP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2424168F
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778095; cv=none; b=gg/RrUnUnFTlCgdnvwvhkT41DvCHGtFDAf1PMKVQjTohpEPTYZxGnNJulJcwEQfxV2dr8VWBx+d7V8X+VEwYRjF+K9O4tkgDswP8G4xRv/V1vNMpixR+/mV/fj7r0Ho1kx/lBj7c/mkYIAvGByFsLT/oG9sRV161OKEzWkdtwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778095; c=relaxed/simple;
	bh=pV0wMRVJdZx0GGHAFXpYdrUB+nz6p/5vFjYGRVyVErE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nz1UcBjPVphffe9+bjAjjh9KV06bDMgqU5c+D6oyG4XygSXKLvKo6212iw71D2P/xzf1/GDQ1r5xjQHjagsfp9AbFrMu8UQYlDfaGOm/OzzJeK7b5EWZ5fohUCsifRaGLwmyJ6X2xS+nNWlWYRB1UXhHYS6Zt1XAgmAy2yR55xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpmJEhP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01F2C4CEE3;
	Wed, 12 Mar 2025 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778095;
	bh=pV0wMRVJdZx0GGHAFXpYdrUB+nz6p/5vFjYGRVyVErE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hpmJEhP1hMpGXNoHcPfRkMXqjDkP5S+jvIEBCwxwau4AN0S/l+8HrDTAjiY5Twem4
	 xqOnJIUSN0Pa2H79swjZIg26CA/4RXQVH8ELKJ3mIxAq1G2xWcK5CjUQSNZKvW8yKO
	 rRleEl1gLxRD8BmSnZpDRifNIZ7tDmjIEAAUPWP5QWNY4H+4B65QXbFOWYx3gQfGpT
	 hxbPtiG01hV8Uhm8Hgfbpzprfr56An7/POl9M+4tunh/16TrGjeWKyArFzO4Ax78QB
	 dEkJulOLbxaPazj1balVbbVKfGbJsdOVt4npWzZyYN/G/rGmM74F7VVXCFhQfajyC0
	 zhBVwgtokmq4g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:14:05 +0100
Subject: [PATCH 21/21] wifi: mt76: mt7996: Update mt7996_tx to MLO support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-21-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Rework mt7996_tx routine in order to support multi-link
setup.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 31 +++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index adeb267b2801894590f90d02e902ebec602de98a..91c64e3a0860ff0dc5405627b23f79f4ebd1dafd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1200,12 +1200,18 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	u8 link_id = u32_get_bits(info->control.flags,
+				  IEEE80211_TX_CTRL_MLO_LINK);
+
+	rcu_read_lock();
 
 	if (vif) {
-		struct mt7996_vif *mvif;
+		struct mt7996_vif *mvif = (void *)vif->drv_priv;
+		struct mt76_vif_link *mlink;
 
-		mvif = (struct mt7996_vif *)vif->drv_priv;
-		wcid = &mvif->deflink.msta_link.wcid;
+		mlink = rcu_dereference(mvif->mt76.link[link_id]);
+		if (mlink && mlink->wcid)
+			wcid = mlink->wcid;
 
 		if (mvif->mt76.roc_phy &&
 		    (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN)) {
@@ -1217,19 +1223,22 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (control->sta) {
-		struct mt7996_sta_link *msta_link;
-
-		msta_link = (struct mt7996_sta_link *)control->sta->drv_priv;
-		wcid = &msta_link->wcid;
-	}
-
 	if (!mphy) {
 		ieee80211_free_txskb(hw, skb);
-		return;
+		goto unlock;
 	}
 
+	if (control->sta) {
+		struct mt7996_sta *msta = (void *)control->sta->drv_priv;
+		struct mt7996_sta_link *msta_link;
+
+		msta_link = rcu_dereference(msta->link[link_id]);
+		if (msta_link)
+			wcid = &msta_link->wcid;
+	}
 	mt76_tx(mphy, control->sta, wcid, skb);
+unlock:
+	rcu_read_unlock();
 }
 
 static int mt7996_set_rts_threshold(struct ieee80211_hw *hw, u32 val)

-- 
2.48.1


