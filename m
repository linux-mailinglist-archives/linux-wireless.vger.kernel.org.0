Return-Path: <linux-wireless+bounces-20244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E064A5DB37
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7977AB6BA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CBE2405E5;
	Wed, 12 Mar 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC+TH0LI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082423FC7D
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778087; cv=none; b=tUAiyetq7twS48fs9eTucRV4uR+pZiRXglkPbknM9k5sNv5NXqeIuwso2zB39W77aFo2IBR2izq7cb1M4SuxJDcxwkXTD4yHXUakuIH6yygTkPMMS/pa8f0XecBABDWnehYLReyeVXGxmOjaxRM0UiqXpZU2UkMG7rtKln+qbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778087; c=relaxed/simple;
	bh=4ZaNPtKmjehzI82M7KLgZa7FjF1q/x0G0f5lQ/Nm54w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTauFMqoNXm/mrhOMrOSUv5dBz0LoD7aCKSQ/3i8dZplIqdN8aJEAB4axyjVqQszQFCU+PeC9bWMsnIQG+prHZEljezz1tON42dGHfARsRSYMvJ/WQOWHWKjxkSUBP/+/fhpkZn+cIt/f5Jhx5KymzbwtJP8lbBgiHPB8sjAyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC+TH0LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04B2C4CEE3;
	Wed, 12 Mar 2025 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778087;
	bh=4ZaNPtKmjehzI82M7KLgZa7FjF1q/x0G0f5lQ/Nm54w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VC+TH0LI7DoJxVsbEomdR9CDlxCi3ukZUEs+F3MY9l5s4IxdsrvBkmXxEMa+l7ckA
	 L7QY+MwkGORAu2kbffdbwd/AHDR/CGO/kQ71A+30QfVaTlGwqkGcALQ5Vm1vTdAduc
	 Tq8oeM4e5dgk/2E3VTsyGC9VHJTGGAtbDVjlQiErZe9vyBmpCA4bW/x+YWXys8HEpy
	 oxu342EZCyiWVaQ8oOWmv6mnLo6YUhC5+qqzHGXdska4HjyqO8WyrjlkJZv2uvwH7N
	 gnNUisWlvhlzuAn/Fcx0D/egbBtNE6wH+15ahHqw3KV5WSxi+oBgEBx2Ru28dmand2
	 2MBHF0Fpx75sw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:14:02 +0100
Subject: [PATCH 18/21] wifi: mt76: mt7996: set vif default link_id
 adding/removing vif links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-18-015b3d6fd928@kernel.org>
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

This info will be consumed by subsequent patches (e.g. in set/get tsf
routines).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index bcca1850d471bc43390c2f9e2ffecf6d9a05f377..40efba5bcaac364f8aa1ebf528e283494178616b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -271,6 +271,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			struct mt76_vif_link *mlink)
 {
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
@@ -338,6 +339,9 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, NULL);
 
+	if (mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
+		mvif->mt76.deflink_id = link_conf->link_id;
+
 	return 0;
 }
 
@@ -346,6 +350,7 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			    struct mt76_vif_link *mlink)
 {
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
@@ -359,6 +364,19 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
+	if (mvif->mt76.deflink_id == link_conf->link_id) {
+		struct ieee80211_bss_conf *iter;
+		unsigned int link_id;
+
+		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
+		for_each_vif_active_link(vif, iter, link_id) {
+			if (link_id != IEEE80211_LINK_UNSPECIFIED) {
+				mvif->mt76.deflink_id = link_id;
+				break;
+			}
+		}
+	}
+
 	dev->mt76.vif_mask &= ~BIT_ULL(mlink->idx);
 	phy->omac_mask &= ~BIT_ULL(mlink->omac_idx);
 
@@ -443,6 +461,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mt76_vif_init(vif, &mvif->mt76);
 
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+	mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
 
 out:
 	mutex_unlock(&dev->mt76.mutex);

-- 
2.48.1


