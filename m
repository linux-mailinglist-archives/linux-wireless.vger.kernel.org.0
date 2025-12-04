Return-Path: <linux-wireless+bounces-29504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E48CA3BE0
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 14:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DCFA300A6CA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65C341AB6;
	Thu,  4 Dec 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhd29DNA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21334252B
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854033; cv=none; b=PgYu2+DQ8Mv41aNYoIYVZ+vAY+AMv7nx7KjMGQVzLEn30TO3Iau/XJPNOu/vvD6CdThROFetHnGL8nU+23ZmzMve1SPrx0VX49pctbK3hvjKILIyZQM4xP2rNubtdgh50BC16XG+x/yx1Pvecs1EaZ1T4CQRiNMYRZcwtcC65X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854033; c=relaxed/simple;
	bh=j2sszEHvbo+AG1hndOWuS1qSVFTizaaquasEEngVdcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mhve2a3AUnIhpMm8ENA0jgE9PVkRiQy+N7K02ZA0pTcZJu/LCWvsSOzpvlnRVZ9Rtqr9OK3SjhE36jd08CAZI+n/4ScL0OsdOgrQoBuQb3PLKrFoVqZOCoHWnV5FEaH7JR65LjOh7n4WdtjbHxlWgE8Xs7qDKvKwT6RMI6XZJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhd29DNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28BEC16AAE;
	Thu,  4 Dec 2025 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854033;
	bh=j2sszEHvbo+AG1hndOWuS1qSVFTizaaquasEEngVdcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lhd29DNACs57cZtRRAVVINI7OhUHBJpQMIkfydpX5nOpuHaAgWxRRpobPMp4G+YGN
	 TQMNvPvVubsSyvlEVrp6Fw9KUS1GBajwsub6Dk3pVtp3ofRwqd95XITFF3PPOreXAv
	 HH4Y5cjmDVfvkgQkZKnevFjqSKocN5riF81D1juHs8mvpjchI7WQAtORUP0AZGL0+z
	 Knz7OB6uM48Vm5upEYVIc9ig9oLzE4/83MPxG9TmR3rSIclKrOTT72uun47WZ+ujD3
	 61pT9AhtoxdZHmwWVBhbAPGRhrkVrFs6EV5q5CatL0z9/72CpRTUH3bv62yLo4QPK7
	 Vrou1YfI22H7w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 14:13:29 +0100
Subject: [PATCH mt76 2/3] wifi: mt76: mt7996: Reset mtxq->idx if primary
 link is removed in mt7996_vif_link_remove()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-txq-wicd-fix-v1-2-1f4b2f2b3b2c@kernel.org>
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

Reset WCID index in mt76_txq struct if primary link is removed in
mt7996_vif_link_remove routine.

Fixes: a3316d2fc669f ("wifi: mt76: mt7996: set vif default link_id adding/removing vif links")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 0ad0152478a7e1b11bfe5d68d750cb8332d54290..8bf85a9beee7dc8c6741568af5b36cf89f0c1a88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -409,12 +409,23 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *iter;
 		unsigned int link_id;
 
+		/* Primary link will be removed, look for a new one */
 		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
 		for_each_vif_active_link(vif, iter, link_id) {
-			if (link_id != IEEE80211_LINK_UNSPECIFIED) {
-				mvif->mt76.deflink_id = link_id;
-				break;
+			struct mt7996_vif_link *link;
+
+			link = mt7996_vif_link(dev, vif, link_id);
+			if (!link)
+				continue;
+
+			if (vif->txq) {
+				struct mt76_txq *mtxq;
+
+				mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+				mtxq->wcid = link->msta_link.wcid.idx;
 			}
+			mvif->mt76.deflink_id = link_id;
+			break;
 		}
 	}
 

-- 
2.52.0


