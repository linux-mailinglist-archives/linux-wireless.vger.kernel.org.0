Return-Path: <linux-wireless+bounces-29539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B585CA7258
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1C83024E5C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CC314A95;
	Fri,  5 Dec 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFlgqxvU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF72E6125
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930300; cv=none; b=RB0JBIOOBwSAFrCpURnrz5lwNRl2oxpviuIlsC6OeDQEkW6fSsems1j5MJFGmqVg4yoRzUJ8Dw6tNkUlc5bb6Rwv5s74VWn4CBc6VrAEN6qcwvbst8FXGLnSMCjQ/qDFkAWs/VFOvyervjDqZo1DMItvEGas5QEv1uonbuty56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930300; c=relaxed/simple;
	bh=xzqTEQWlL2osp14A8v9rgJIJ+HBndeX+dXJ6PqlMsSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fierFK0h09IF5EmFong0pi0YN7b5VR7ldrwCH6FOdaJxe5HEWVpbLyW8Kj7qN9gz5h5EC46fiIWd/PZRubhwr4a4gFLS0YwN4ukxmi4ZRKoBcRNgaPX2EZpUT0Fizo1Ar7R1kKi0+MmtR47xFo9jYDm7jewLJHO2abFcOUMVd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFlgqxvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5BFC4CEF1;
	Fri,  5 Dec 2025 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764930298;
	bh=xzqTEQWlL2osp14A8v9rgJIJ+HBndeX+dXJ6PqlMsSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RFlgqxvU6m+guTVl1YRJFX8cKwpsgb+KzPhf9cdvSF+gLYpmI1tgPTPRF4z6SQvMN
	 X0RcEhRUua5rZINpreDUT0NYGNFwvf4PdUUvBxjE/zEgGfuoZhibqiR0vsZq06jA+h
	 1PKbbyVYjo1Fxm3HpL32wrMR3rHEpd894LnoVayrzKChBrC1ml3pOhvAgBSTwEjtmX
	 iyQlTYiV02jirjKqJ0nWspjsy7+UJV79KyTqkRyfxVI2o75Tii3xYOn84JjPS8FMFq
	 MNgd+bhCP409gmh04/owUgTB9baepSBxl9T5uyaktSZREdpXT0aQqNC/JqEQ8SqWvv
	 t9GFZOY9o541A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 05 Dec 2025 11:24:36 +0100
Subject: [PATCH mt76 v2 1/4] wifi: mt76: mt7996: Set mtxq->wcid just for
 primary link
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-mt76-txq-wicd-fix-v2-1-f19ba48af7c1@kernel.org>
References: <20251205-mt76-txq-wicd-fix-v2-0-f19ba48af7c1@kernel.org>
In-Reply-To: <20251205-mt76-txq-wicd-fix-v2-0-f19ba48af7c1@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
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


