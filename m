Return-Path: <linux-wireless+bounces-24906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3B6AFC3CC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A6E189FDAE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF5219317;
	Tue,  8 Jul 2025 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npWx24+z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2ED2571B4
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958750; cv=none; b=RrmQoewFkMXqFPkI8a+S28UH/lsNrOC1M020lYHwKqrqs7TN1NNqVLHhE6N3s2SUcDxQsO7T0cecsUZIs2kzK+K+aiSR10sGV6JkHzwfxiotQivnJU6oVILu1Dw724svmqwMTZLPvuXFildH9tAuNSXKDvdDjhwunx9dAOEehMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958750; c=relaxed/simple;
	bh=SzEkAx2UZEVxCVcrkwBEfVoThhQdgL+QBqoVgAMyHC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmLl48rj1YDgakXTOIM3rCT7IAyCC18PvFnrvGvW1vJ7KZ5jsitVhtrWn8OfNZx0DtrmAMDQknkLMdZkvV69xbsUSEinhvH0myXA9ePyCuzYbcgoeHG8j1yjBiFxm3X64rFudatCDcOsauz48bw+vksZ6NPpZJSvkEWS9/yPKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npWx24+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B28BC4CEED;
	Tue,  8 Jul 2025 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751958750;
	bh=SzEkAx2UZEVxCVcrkwBEfVoThhQdgL+QBqoVgAMyHC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=npWx24+zEocZSkBx5yc5LFW1AegC30qV94/npSxPM7n5HbuFHtI/e/JBt3I2VGLMS
	 vHQ7bc8y39hzCG6l34Xl0hJpJPSygXJnC6bjvMrWsrsSz3z+IeBO8nCbf6BRMouo9g
	 6LcjWRRXm6xWcVvfcScve0Y8PTktbu5GLWYOLdAanehg5SAJmPp2Jg0732ZgDpWlud
	 e8mBZ/9g1XO6hvaKOfQaPkhtD9Gb3c7T1ns1GBybE2Jw4VtDMzrTPdpE+m3TTBvGbM
	 XrcR+786aPW7/tfb/TCSiCgQe9WYcypElh/aeisqpRvUAc4Oy9a73YzLlbCu7yiYka
	 LzTLTHcfElnkw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 08 Jul 2025 09:12:04 +0200
Subject: [PATCH mt76 1/2] wifi: mt76: mt7996: Overwrite unspecified link_id
 in mt7996_tx()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-mt7996-mlo-fixes-v2-v1-1-f2682818a8a3@kernel.org>
References: <20250708-mt7996-mlo-fixes-v2-v1-0-f2682818a8a3@kernel.org>
In-Reply-To: <20250708-mt7996-mlo-fixes-v2-v1-0-f2682818a8a3@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 MeiChia Chiu <meichia.chiu@mediatek.com>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Set link_id to msta or mvif primary value if it is set to
IEEE80211_LINK_UNSPECIFIED by mac80211 in mt7996_tx routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 26 ++++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f846b8309ae2e9c39f9d5f2a21ca1edd89dcdf0c..03ec3edc9a632390cb6d86d75b2e65a302a9a372 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1217,21 +1217,30 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 	u8 link_id = u32_get_bits(info->control.flags,
 				  IEEE80211_TX_CTRL_MLO_LINK);
+	struct mt7996_sta *msta;
+	struct mt7996_vif *mvif;
 
 	rcu_read_lock();
 
-	if (vif) {
-		struct mt7996_vif *mvif = (void *)vif->drv_priv;
+	msta = control->sta ? (void *)control->sta->drv_priv : NULL;
+	mvif = vif ? (void *)vif->drv_priv : NULL;
+
+	/* Use primary link_id if the value from mac80211 is set to
+	 * IEEE80211_LINK_UNSPECIFIED.
+	 */
+	if (link_id == IEEE80211_LINK_UNSPECIFIED) {
+		if (msta)
+			link_id = msta->deflink_id;
+		else if (mvif)
+			link_id = mvif->mt76.deflink_id;
+	}
+
+	if (mvif) {
 		struct mt76_vif_link *mlink = &mvif->deflink.mt76;
 
 		if (link_id < IEEE80211_LINK_UNSPECIFIED)
 			mlink = rcu_dereference(mvif->mt76.link[link_id]);
 
-		if (!mlink) {
-			ieee80211_free_txskb(hw, skb);
-			goto unlock;
-		}
-
 		if (mlink->wcid)
 			wcid = mlink->wcid;
 
@@ -1250,8 +1259,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
-	if (control->sta && link_id < IEEE80211_LINK_UNSPECIFIED) {
-		struct mt7996_sta *msta = (void *)control->sta->drv_priv;
+	if (msta && link_id < IEEE80211_LINK_UNSPECIFIED) {
 		struct mt7996_sta_link *msta_link;
 
 		msta_link = rcu_dereference(msta->link[link_id]);

-- 
2.50.0


