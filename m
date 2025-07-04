Return-Path: <linux-wireless+bounces-24825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87895AF93AB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A2F1882EE9
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8992F85D5;
	Fri,  4 Jul 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr/rEHuw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97572F85C9
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634520; cv=none; b=sHPudOlQpelfStJvT6LRH6/tJZg/szS2D1GL6/291rvdVZYYfsGZmJ9DMLdnXFBjeYp5S1iNQn+vYepThkxIrrVTHBeDvC4gEZ3bekeD+rmzS8py+tGbyJianx2CDPkH7hN64yVCUULZFa3dEysSkLRwewk2UGWZE3lDo5nvgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634520; c=relaxed/simple;
	bh=0J163NQ2g6iT1JWmoTnRElFmVhhyQWnZB3Sm6WBqxYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAzO4qkNJqdlf6laBLvOMQ0Ethe+di3iWAXfkbfqPaSdzGbs78Yqi84rkfpnJvMVmwtj7FA/3PZwsVzM2cP6HabuGCevDS9SwbWYMHirgE7uzo3O9E3dDAegCPyMl8TMtr+77wcVgIW6wRAa5tHLaMsx3xNbXgxoq3VyPgDVXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr/rEHuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E2C4CEEB;
	Fri,  4 Jul 2025 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634520;
	bh=0J163NQ2g6iT1JWmoTnRElFmVhhyQWnZB3Sm6WBqxYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kr/rEHuwj5fB0VR4i2MVTfDTBCvShkGCupuPkp6XlfLP86Rk3VavV1JjZfEX2+/E1
	 tXmIsy3NSLe/b/jS35DS4Pujb2TaarVpaGB7XM7O5EaeeNzcexzNfVRKOzdr17JlUj
	 KFIDoKGExUYNUOGEfQEswH2hu4yJS2If/SDOMbdp9ucuCwrl6vNQAsmR9VgBnuGObs
	 xvi8g/5qxkg+G4N3Q6ftibwj865HZm2EUmz5xT3xRMpJqknzwOBXoWjdDOxR5TeOOn
	 PjWwE6G/4Xdx6y68XWx4sCPe0j/jdeAUjBehaan+WSKTJjcnpTtBpcQ9iw6LMSz+DN
	 AzXELV6R8DeKA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:10 +0200
Subject: [PATCH mt76 6/9] wifi: mt76: mt7996: Fix possible OOB access in
 mt7996_tx()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-6-356456c73f43@kernel.org>
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

Fis possible Out-Of-Boundary access in mt7996_tx routine if link_id is
set to IEEE80211_LINK_UNSPECIFIED

Fixes: 3ce8acb86b661 ("wifi: mt76: mt7996: Update mt7996_tx to MLO support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d1f90dea512bade652743611b7d062863a63ccfe..6404514556419f75b69a783d96b0920157263e04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1216,10 +1216,17 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 
 	if (vif) {
 		struct mt7996_vif *mvif = (void *)vif->drv_priv;
-		struct mt76_vif_link *mlink;
+		struct mt76_vif_link *mlink = &mvif->deflink.mt76;
 
-		mlink = rcu_dereference(mvif->mt76.link[link_id]);
-		if (mlink && mlink->wcid)
+		if (link_id < IEEE80211_LINK_UNSPECIFIED)
+			mlink = rcu_dereference(mvif->mt76.link[link_id]);
+
+		if (!mlink) {
+			ieee80211_free_txskb(hw, skb);
+			goto unlock;
+		}
+
+		if (mlink->wcid)
 			wcid = mlink->wcid;
 
 		if (mvif->mt76.roc_phy &&
@@ -1228,7 +1235,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 			if (mphy->roc_link)
 				wcid = mphy->roc_link->wcid;
 		} else {
-			mphy = mt76_vif_link_phy(&mvif->deflink.mt76);
+			mphy = mt76_vif_link_phy(mlink);
 		}
 	}
 
@@ -1237,7 +1244,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
-	if (control->sta) {
+	if (control->sta && link_id < IEEE80211_LINK_UNSPECIFIED) {
 		struct mt7996_sta *msta = (void *)control->sta->drv_priv;
 		struct mt7996_sta_link *msta_link;
 

-- 
2.50.0


