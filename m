Return-Path: <linux-wireless+bounces-29505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D111FCA3BE1
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 14:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B976D300BFA6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D7342C80;
	Thu,  4 Dec 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO4nD5tP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26433B6FF
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854035; cv=none; b=lZA9oPiYt8zuqlAMcK4TpUBtTi9mqrP5IC2XtUSnof4Y2qqINEA7ApPvfHi/iKBn8qF88fKYHue9X/G5qRyJkw1oJ2NNBRYHJD6DY0iPz3KQjJ6GiAzRut0sRntyppspyt928BS6dlLjiyjlJWXqNh+IIdElAk1NFxsh1oLUsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854035; c=relaxed/simple;
	bh=RfEto5ZhzzmOQyTL3lH3OKGraSwXsCAmzi9q4NcxOKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCuAoqkpaid88w+iDnhysIIN7SbJiztwYH5JRAUbouE1543ZwAE1xLzu2GwGygZ+BDyHy16K1LMjxxYrNUMDu6KcSBNdKy9BdFhLyXxoirf0j3hyDv51B2sm4z/FwWpVmSY76jVrHUyXJJ5Sm6zgoRRelVzvEXkiNy+8rZmB9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO4nD5tP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436D4C113D0;
	Thu,  4 Dec 2025 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854035;
	bh=RfEto5ZhzzmOQyTL3lH3OKGraSwXsCAmzi9q4NcxOKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mO4nD5tPms/n1SRcoVWXidSmJheoCCSJ1tsCACG9A/EI4l5ea0XrTQJYCdsH5ttYG
	 GdBxptd8opD0C6A6mWbETT5G25PynSPJl+7NwRXKlE1wh1YEcrrjQuN64yseRZoSTA
	 jE8I75h5/HVBI1AWr42+BGa3Vlw5olITa5Lw3nY8HCyZcYf7LsUtK1mGkSx6EJLXtm
	 diUHbDj180YJ4SEZKIQ9VvrJi/pHTmTurGgDyulEaQgx5kM8EJT6tibdTOe7NVJxX8
	 XfHjFcoSUTjvfJ0idqQzrTgYakjRfJW5whYya0/mdfXfYEfjaQO5PKJF62M26m3oHo
	 BwmHpyCfQDM9g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 14:13:30 +0100
Subject: [PATCH mt76 3/3] wifi: mt76: mt7996: Switch to the secondary link
 if the default one is removed
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-txq-wicd-fix-v1-3-1f4b2f2b3b2c@kernel.org>
References: <20251204-mt76-txq-wicd-fix-v1-0-1f4b2f2b3b2c@kernel.org>
In-Reply-To: <20251204-mt76-txq-wicd-fix-v1-0-1f4b2f2b3b2c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Switch to the secondary link if available in mt7996_mac_sta_remove_links
routine if the primary one is removed.
Moreover reset secondary link index for single link scenario.

Fixes: 85cd5534a3f2e ("wifi: mt76: mt7996: use correct link_id when filling TXD and TXP")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 52 ++++++++++++++++--------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 8bf85a9beee7dc8c6741568af5b36cf89f0c1a88..1baace971ec3511dba3e8a64c236a2b55f9dbd36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -945,6 +945,22 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static void
+mt7996_sta_init_txq_wcid(struct ieee80211_sta *sta, int idx)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct mt76_txq *mtxq;
+
+		if (!sta->txq[i])
+			continue;
+
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+		mtxq->wcid = idx;
+	}
+}
+
 static int
 mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 			 struct ieee80211_bss_conf *link_conf,
@@ -962,21 +978,10 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 		return -ENOSPC;
 
 	if (msta->deflink_id == IEEE80211_LINK_UNSPECIFIED) {
-		int i;
-
 		msta_link = &msta->deflink;
 		msta->deflink_id = link_id;
 		msta->seclink_id = msta->deflink_id;
-
-		for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
-			struct mt76_txq *mtxq;
-
-			if (!sta->txq[i])
-				continue;
-
-			mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
-			mtxq->wcid = idx;
-		}
+		mt7996_sta_init_txq_wcid(sta, idx);
 	} else {
 		msta_link = kzalloc(sizeof(*msta_link), GFP_KERNEL);
 		if (!msta_link)
@@ -1058,13 +1063,28 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 		mphy->num_sta--;
 		if (msta->deflink_id == link_id) {
-			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
-			continue;
+			if (msta->seclink_id == msta->deflink_id) {
+				/* no secondary link available */
+				msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+				msta->seclink_id = msta->deflink_id;
+			} else {
+				struct mt7996_sta_link *msta_seclink;
+
+				/* switch to the secondary link */
+				msta->deflink_id = msta->seclink_id;
+				msta_seclink = mt76_dereference(
+						msta->link[msta->seclink_id],
+						mdev);
+				if (msta_seclink)
+					mt7996_sta_init_txq_wcid(sta,
+						msta_seclink->wcid.idx);
+			}
 		} else if (msta->seclink_id == link_id) {
-			msta->seclink_id = IEEE80211_LINK_UNSPECIFIED;
+			msta->seclink_id = msta->deflink_id;
 		}
 
-		kfree_rcu(msta_link, rcu_head);
+		if (msta_link != &msta->deflink)
+			kfree_rcu(msta_link, rcu_head);
 	}
 }
 

-- 
2.52.0


