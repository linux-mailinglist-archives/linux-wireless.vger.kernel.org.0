Return-Path: <linux-wireless+bounces-20236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363ABA5DB2D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48B4188C71E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854822DFB5;
	Wed, 12 Mar 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCDPRyqY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368122E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778067; cv=none; b=rlUGhhSRvDfVO/0Uy6URW/P2+9R0x8q+QrxdfccUS1wHglg3VSNtiQyOvy9bhET1U2gVjAvFUIF6uBLiYLKzL5Fsm1YPv+bVoVY+MFC/ce0wGHw8PS3oxKnHBPIqMNPaC9z6YpbvoXqdPS92+wg5Ur4m0Bd3o3I5SJ/Fwf/5LaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778067; c=relaxed/simple;
	bh=Apq6zmVAGnuN+5hg+hrKs89pEY3E/XKyZ94bOW+pK8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5bs3J4OUKiaDTXNlg71y7BIAV/Enhev0D3eizNsUcNQFcuez98k4aI/AA6gb+R7h2ywMMvSPKm6cKkRxXaTMQHwzzfbosgLZWs+Cv/TysJBCLBzmSkOhg9mbychGvFzjf1C7UEWitmx0syKrtEfh6WfcPHw4P6TnP74gLCiZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCDPRyqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593ACC4CEF1;
	Wed, 12 Mar 2025 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778066;
	bh=Apq6zmVAGnuN+5hg+hrKs89pEY3E/XKyZ94bOW+pK8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LCDPRyqYpB3mnx9KkqpNXZC1CPhFx2X+EApdNsfdCwz8qHukevl4p6JHqqNa2wHD8
	 UJl3Us0EXYFssSRv0gQNTuVFn8H9X2gSqKL3wN02qlF6j+JRJ3XdXUtBQR1+rrzqHs
	 ZPuW2U6c/Gwy+EjHEQvzwMbjnU77bEepoUO7n/sIsvKDFQoo/vyUTVmnX95HVl5VAS
	 yTDLm/jh/74lCtLRAa6C82QehfV7fPHH3HAkmnUnyxShvwZPYOfrOkvZJns+FakeDM
	 8fLawP0hpT12VwCSBcXovQzRDEz5cLremovZQyfSFa+3j1RAy/kXj5XCcS75D5of2K
	 YSj8x96qdD7Fw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:54 +0100
Subject: [PATCH 10/21] wifi: mt76: mt7996: rework mt7996_sta_hw_queue_read
 to support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-10-015b3d6fd928@kernel.org>
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

Extend mt7996_sta_hw_queue_read to support multi-link setup.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    | 54 +++++++++++++++-------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index d453c2fc97e4fad10a29093b70e2ede8375ee0d8..4a28db17a2874078489e08ac8a038a51834b33a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -616,29 +616,51 @@ static void
 mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
+	struct mt7996_vif *mvif = msta->vif;
+	struct mt7996_dev *dev = mvif->deflink.phy->dev;
+	struct ieee80211_link_sta *link_sta;
 	struct seq_file *s = data;
-	u8 ac;
+	struct ieee80211_vif *vif;
+	unsigned int link_id;
 
-	for (ac = 0; ac < 4; ac++) {
-		u32 qlen, ctrl, val;
-		u32 idx = msta_link->wcid.idx >> 5;
-		u8 offs = msta_link->wcid.idx & GENMASK(4, 0);
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	rcu_read_lock();
 
-		ctrl = BIT(31) | BIT(11) | (ac << 24);
-		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(ac, idx));
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt7996_sta_link *msta_link;
+		struct mt76_vif_link *mlink;
+		u8 ac;
 
-		if (val & BIT(offs))
+		mlink = rcu_dereference(mvif->mt76.link[link_id]);
+		if (!mlink)
 			continue;
 
-		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl | msta_link->wcid.idx);
-		qlen = mt76_get_field(dev, MT_FL_Q3_CTRL,
-				      GENMASK(11, 0));
-		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
-			   sta->addr, msta_link->wcid.idx,
-			   msta->vif->deflink.mt76.wmm_idx, ac, qlen);
+		msta_link = rcu_dereference(msta->link[link_id]);
+		if (!msta_link)
+			continue;
+
+		for (ac = 0; ac < 4; ac++) {
+			u32 idx = msta_link->wcid.idx >> 5, qlen, ctrl, val;
+			u8 offs = msta_link->wcid.idx & GENMASK(4, 0);
+
+			ctrl = BIT(31) | BIT(11) | (ac << 24);
+			val = mt76_rr(dev, MT_PLE_AC_QEMPTY(ac, idx));
+
+			if (val & BIT(offs))
+				continue;
+
+			mt76_wr(dev,
+				MT_FL_Q0_CTRL, ctrl | msta_link->wcid.idx);
+			qlen = mt76_get_field(dev, MT_FL_Q3_CTRL,
+					      GENMASK(11, 0));
+			seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
+				   sta->addr, msta_link->wcid.idx,
+				   mlink->wmm_idx, ac, qlen);
+		}
 	}
+
+	rcu_read_unlock();
 }
 
 static int

-- 
2.48.1


