Return-Path: <linux-wireless+bounces-29503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0CACA3BDD
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 14:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8114930088D4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39534252B;
	Thu,  4 Dec 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6a/8v+t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9B342523
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854031; cv=none; b=ImfFhrZ2et/HtE4ShVahtYe/xwLyhnAjBjDy3e5UjW7o6pzPwt94qMPL8erYEkNbsijgX84scFT1HuD7in4apGWkSosaJRq2xl6eFML3vY1L+N3PWTfZk1vsnkUKiB0HloxDkZs+WnBDq5OTsPnE8Si6Y94iITHVMW3quRxS0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854031; c=relaxed/simple;
	bh=xzqTEQWlL2osp14A8v9rgJIJ+HBndeX+dXJ6PqlMsSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCkofPWvsaOBqca/N15LEr2uH1em2uI+/CwYtJPTCJ4/llD941BGrR4ErW6n9ka3HXdCbTryJq3roBhobabODmBvwIHkGxI/UjXlhEcD24/IX8sn9gmstAwhpYpR5ub7K7KwywenFASo0A+yxBhSrK2O7B62NoTm6iFV+jlhafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6a/8v+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1139C4CEFB;
	Thu,  4 Dec 2025 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854030;
	bh=xzqTEQWlL2osp14A8v9rgJIJ+HBndeX+dXJ6PqlMsSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W6a/8v+tZ1wBU7ORJU4gfxbgQSxoH7is6h7L5UXKeRinp4GFBPww6pt2tEnbwjUdu
	 QUmedV+m8MyDCjQ3dXw8taQIOL8v4et5PqJrbQZfF9qZ4BxcO9ZUZIUqezq1fM7m9N
	 DvNhsWGwiwkf8h2kyICYHgdUzSBbNOm0wFelS82XerPfwAOsmlt0ZnFMvh4+O6VDVQ
	 emy+qVeS09QrSZqZUtyeozPVvWVbpbyGsp4vRGRelgdEywjit2eq110pVMmQP+oBuX
	 KcwBLaHzyDkIL4oUzxDmuccpVXpXc9VrKVONnEm4dz0i5wUJH6BXOAR/7gpXh1HjI0
	 zcGZP2xNjFkRA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 14:13:28 +0100
Subject: [PATCH mt76 1/3] wifi: mt76: mt7996: Set mtxq->wcid just for
 primary link
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-txq-wicd-fix-v1-1-1f4b2f2b3b2c@kernel.org>
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

Set WCID index in mt76_txq struct just for the primary link in
mt7996_vif_link_add routine.

Fixes: 69d54ce7491d0 ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index beed795edb24c67e1b7b44fe87fd5de125a21d94..0ad0152478a7e1b11bfe5d68d750cb8332d54290 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -300,7 +300,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		.cmd = SET_KEY,
 		.link_id = link_conf->link_id,
 	};
-	struct mt76_txq *mtxq;
 	int mld_idx, idx, ret;
 
 	mlink->idx = __ffs64(~dev->mt76.vif_mask);
@@ -343,11 +342,6 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	if (vif->txq) {
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-		mtxq->wcid = idx;
-	}
-
 	if (vif->type != NL80211_IFTYPE_AP &&
 	    (!mlink->omac_idx || mlink->omac_idx > 3))
 		vif->offload_flags = 0;
@@ -371,8 +365,15 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
 
 	if (!mlink->wcid->offchannel &&
-	    mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
+	    mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED) {
+		if (vif->txq) {
+			struct mt76_txq *mtxq;
+
+			mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+			mtxq->wcid = idx;
+		}
 		mvif->mt76.deflink_id = link_conf->link_id;
+	}
 
 	return 0;
 }

-- 
2.52.0


