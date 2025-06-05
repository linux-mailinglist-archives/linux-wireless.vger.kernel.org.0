Return-Path: <linux-wireless+bounces-23759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7BACEE6A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95AD3AC429
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C829A2;
	Thu,  5 Jun 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAJF+LtO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C501B0F17
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122311; cv=none; b=n6ErWvxi5oXwPhDGsdjzjB2GX+LS/e9OQOHUtOJd2TsIFAiAr51LXkZ3cScRGv+Q4tHnLIBGn4BhMnuc7twsGjQviPEihJrLQtPaLq0hAZyMcQw4/7MnWIGfbHwPFnpVYAgA+7eVy3W1e/Mlp4jhN6WQs3M6AyfEbjDuc91CTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122311; c=relaxed/simple;
	bh=+lGeltGQPf3DCcY3IFCOLgWZkSx9KL9W5sFwu21Q4yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvNFuz0rkORcddOXNCzHHlXiG8T7jitn/e1O/fbK9G+W3xPu3+vP2nWThhbU7ChDAVyjfqiEymIAOfdiUyGyHm/1uVx7ht7nJ1YgYDu0N8+o7foOfVN/pS4IzqlejoKhCRz1RCAUpWQNVgZJ+PhY3dRSGJBbv/xxEexbuBRQxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAJF+LtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCB8C4CEE7;
	Thu,  5 Jun 2025 11:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122311;
	bh=+lGeltGQPf3DCcY3IFCOLgWZkSx9KL9W5sFwu21Q4yg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SAJF+LtO9Ezr7zMlP1VCN0XVTLDws/ztsAqDXkp3CAT8Z8cpfG2JVnv6bBdCcXviy
	 2ARxUXsT9z80UM2OZ0b4VC7HKcAHWOQ9xrh9q5Hk6Ghn0WTVZ7vwrj3UrdkpVnc3Z0
	 8oIHV7H8NrimXzhPbzaM8qgKC90ydhKZ/RjhwwFJGmmVc1PqVMU/PT6SQk7XvIXvDN
	 OElzHKILzuRubSTrj9Ih+4pAHxLw6QvNagkv5w6h3fM5AyveOu7YPgUEfxqJ0Ku/AR
	 4+RnQVycd99S8/fwFQYR2wW8FE/7Ewi3ExzCLQQkDgFEJE5BdpA3WbeO0Ugtqv+ha/
	 IsuqjLjSyHFtA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 05 Jun 2025 13:14:18 +0200
Subject: [PATCH mt76 3/5] wifi: mt76: Move RCU section in
 mt7996_mcu_add_rate_ctrl_fixed()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-mt7996-sleep-while-atomic-v1-3-d46d15f9203c@kernel.org>
References: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
In-Reply-To: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Greear <greearb@candelatech.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Since mt7996_mcu_set_fixed_field() can't be executed in a RCU critical
section, move RCU section in mt7996_mcu_add_rate_ctrl_fixed() and run
mt7996_mcu_set_fixed_field() in non-atomic context. This is a
preliminary patch to fix a 'sleep while atomic' issue in
mt7996_mac_sta_rc_work().

Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 86 ++++++++++++++++---------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 33c61e795b734e84af42fdea5ba33975e3e3365a..742497ba2a6bcd73e3660e626e4a756d79a467bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1977,51 +1977,74 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct mt7996_sta *msta,
 }
 
 static int
-mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
-			       struct ieee80211_link_sta *link_sta,
-			       struct mt7996_vif_link *link,
-			       struct mt7996_sta_link *msta_link,
-			       u8 link_id)
+mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct mt7996_sta *msta,
+			       struct ieee80211_vif *vif, u8 link_id)
 {
-	struct cfg80211_chan_def *chandef = &link->phy->mt76->chandef;
-	struct cfg80211_bitrate_mask *mask = &link->bitrate_mask;
-	enum nl80211_band band = chandef->chan->band;
-	struct mt7996_sta *msta = msta_link->sta;
+	struct ieee80211_link_sta *link_sta;
+	struct cfg80211_bitrate_mask mask;
+	struct mt7996_sta_link *msta_link;
+	struct mt7996_vif_link *link;
 	struct sta_phy_uni phy = {};
-	int ret, nrates = 0;
+	struct ieee80211_sta *sta;
+	int ret, nrates = 0, idx;
+	enum nl80211_band band;
+	bool has_he;
 
 #define __sta_phy_bitrate_mask_check(_mcs, _gi, _ht, _he)			\
 	do {									\
-		u8 i, gi = mask->control[band]._gi;				\
+		u8 i, gi = mask.control[band]._gi;				\
 		gi = (_he) ? gi : gi == NL80211_TXRATE_FORCE_SGI;		\
 		phy.sgi = gi;							\
-		phy.he_ltf = mask->control[band].he_ltf;			\
-		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) {	\
-			if (!mask->control[band]._mcs[i])			\
+		phy.he_ltf = mask.control[band].he_ltf;				\
+		for (i = 0; i < ARRAY_SIZE(mask.control[band]._mcs); i++) {	\
+			if (!mask.control[band]._mcs[i])			\
 				continue;					\
-			nrates += hweight16(mask->control[band]._mcs[i]);	\
-			phy.mcs = ffs(mask->control[band]._mcs[i]) - 1;		\
+			nrates += hweight16(mask.control[band]._mcs[i]);	\
+			phy.mcs = ffs(mask.control[band]._mcs[i]) - 1;		\
 			if (_ht)						\
 				phy.mcs += 8 * i;				\
 		}								\
 	} while (0)
 
-	if (link_sta->he_cap.has_he) {
+	rcu_read_lock();
+
+	link = mt7996_vif_link(dev, vif, link_id);
+	if (!link)
+		goto error_unlock;
+
+	msta_link = rcu_dereference(msta->link[link_id]);
+	if (!msta_link)
+		goto error_unlock;
+
+	sta = wcid_to_sta(&msta_link->wcid);
+	link_sta = rcu_dereference(sta->link[link_id]);
+	if (!link_sta)
+		goto error_unlock;
+
+	band = link->phy->mt76->chandef.chan->band;
+	has_he = link_sta->he_cap.has_he;
+	mask = link->bitrate_mask;
+	idx = msta_link->wcid.idx;
+
+	if (has_he) {
 		__sta_phy_bitrate_mask_check(he_mcs, he_gi, 0, 1);
 	} else if (link_sta->vht_cap.vht_supported) {
 		__sta_phy_bitrate_mask_check(vht_mcs, gi, 0, 0);
 	} else if (link_sta->ht_cap.ht_supported) {
 		__sta_phy_bitrate_mask_check(ht_mcs, gi, 1, 0);
 	} else {
-		nrates = hweight32(mask->control[band].legacy);
-		phy.mcs = ffs(mask->control[band].legacy) - 1;
+		nrates = hweight32(mask.control[band].legacy);
+		phy.mcs = ffs(mask.control[band].legacy) - 1;
 	}
+
+	rcu_read_unlock();
+
 #undef __sta_phy_bitrate_mask_check
 
 	/* fall back to auto rate control */
-	if (mask->control[band].gi == NL80211_TXRATE_DEFAULT_GI &&
-	    mask->control[band].he_gi == GENMASK(7, 0) &&
-	    mask->control[band].he_ltf == GENMASK(7, 0) &&
+	if (mask.control[band].gi == NL80211_TXRATE_DEFAULT_GI &&
+	    mask.control[band].he_gi == GENMASK(7, 0) &&
+	    mask.control[band].he_ltf == GENMASK(7, 0) &&
 	    nrates != 1)
 		return 0;
 
@@ -2034,16 +2057,16 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
 	}
 
 	/* fixed GI */
-	if (mask->control[band].gi != NL80211_TXRATE_DEFAULT_GI ||
-	    mask->control[band].he_gi != GENMASK(7, 0)) {
+	if (mask.control[band].gi != NL80211_TXRATE_DEFAULT_GI ||
+	    mask.control[band].he_gi != GENMASK(7, 0)) {
 		u32 addr;
 
 		/* firmware updates only TXCMD but doesn't take WTBL into
 		 * account, so driver should update here to reflect the
 		 * actual txrate hardware sends out.
 		 */
-		addr = mt7996_mac_wtbl_lmac_addr(dev, msta_link->wcid.idx, 7);
-		if (link_sta->he_cap.has_he)
+		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 7);
+		if (has_he)
 			mt76_rmw_field(dev, addr, GENMASK(31, 24), phy.sgi);
 		else
 			mt76_rmw_field(dev, addr, GENMASK(15, 12), phy.sgi);
@@ -2055,7 +2078,7 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
 	}
 
 	/* fixed HE_LTF */
-	if (mask->control[band].he_ltf != GENMASK(7, 0)) {
+	if (mask.control[band].he_ltf != GENMASK(7, 0)) {
 		ret = mt7996_mcu_set_fixed_field(dev, msta, &phy, link_id,
 						 RATE_PARAM_FIXED_HE_LTF);
 		if (ret)
@@ -2063,6 +2086,11 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
 	}
 
 	return 0;
+
+error_unlock:
+	rcu_read_unlock();
+
+	return -ENODEV;
 }
 
 static void
@@ -2181,6 +2209,7 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
 			     struct mt7996_sta_link *msta_link,
 			     u8 link_id, bool changed)
 {
+	struct mt7996_sta *msta = msta_link->sta;
 	struct sk_buff *skb;
 	int ret;
 
@@ -2207,8 +2236,7 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
 	if (ret)
 		return ret;
 
-	return mt7996_mcu_add_rate_ctrl_fixed(dev, link_sta, link, msta_link,
-					      link_id);
+	return mt7996_mcu_add_rate_ctrl_fixed(dev, msta, vif, link_id);
 }
 
 static int

-- 
2.49.0


