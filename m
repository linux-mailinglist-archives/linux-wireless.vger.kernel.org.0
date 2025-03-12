Return-Path: <linux-wireless+bounces-20233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC6A5DB2A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428F2176D2E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC623F28B;
	Wed, 12 Mar 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPtDONtB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D022DFB5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778059; cv=none; b=dSU/cPOqdWPVTf7C/KWk0a1y6ezO2jFXq4UaxV0jeZGTi0Uf1eptL/m8Zu+T75HGAdcvf7nUfXoeGO/CQcFqURk4nicJ9m6povvt+QvM3I3QFoRZwlkARLOx+Vf7Vv4UmPwCD3FwgAM5INC4KVAYFNqNmqSUfkL+dbJZgexuGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778059; c=relaxed/simple;
	bh=Q/1lqny96ZWi4j5/QaIgLJgjqjSOFtGumXMHNNWeir0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2chbAcWe22E4OenYPO0G2JKEnKs90Sx/PXS1RrnUv7ptU6x46cFcWQgowdqiLQTuqqpLGXnFxZT5B5fGlNavTqm5aj7v2xXoveh/ayNCtqKBEyPAKaIYAfcfDJYiHfsU1L2DVLg1PjnAI6JUh3siitjVmlxzWGq5vdAtnW9VDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPtDONtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95437C4CEE3;
	Wed, 12 Mar 2025 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778058;
	bh=Q/1lqny96ZWi4j5/QaIgLJgjqjSOFtGumXMHNNWeir0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZPtDONtB0vhOHsB04hl1M5aDDoAuT2/0whZnk/X8Ot42nwLyXoP+wigFwXZ1rRuws
	 jSZp+2yoR+GXGA5xlabT07ii0xdCmhaTLPNSNGXOzyIA9Y5shaQT/S2mV7/5MSMdbo
	 Tog7eBhmb/nlQBy7DyLSFSkJ3zgUhHeiMGR+BmSPBFrzGCzK08lp9HGpfsCB73Sy1l
	 MkYGo6Ch14oYDPqkOMTQNaLNN12vQJ65sQGuQ6QIfx2P9P4hSk6H3zFeQOSrQff3qd
	 bGoUe4VdDVqxlM4TMP27diakKkk9U3dFbHCbHuKl5l8sMFRAQCJ+12QXLY7L+2vqGW
	 WOERFkGoaXIYg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:51 +0100
Subject: [PATCH 07/21] wifi: mt76: mt7996: rework mt7996_sta_set_4addr and
 mt7996_sta_set_decap_offload to support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-7-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Rework mt7996_sta_set_4addr and mt7996_sta_set_decap_offload routines in
order to properly support multi-link. This is a preliminary patch to enable
MLO for MT7996 driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 74 ++++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 11 +---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 +-
 3 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 642d633b5126ce81f3d32a9bd912603e2c328c8a..f7703e00712cd1a59484ceddfad5bd00b8814250 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1540,19 +1540,37 @@ static void mt7996_sta_set_4addr(struct ieee80211_hw *hw,
 				 struct ieee80211_sta *sta,
 				 bool enabled)
 {
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
-	if (enabled)
-		set_bit(MT_WCID_FLAG_4ADDR, &msta_link->wcid.flags);
-	else
-		clear_bit(MT_WCID_FLAG_4ADDR, &msta_link->wcid.flags);
+	mutex_lock(&dev->mt76.mutex);
 
-	if (!msta_link->wcid.sta)
-		return;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt7996_sta_link *msta_link;
+		struct mt7996_vif_link *link;
 
-	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
+
+		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		if (!msta_link)
+			continue;
+
+		if (enabled)
+			set_bit(MT_WCID_FLAG_4ADDR, &msta_link->wcid.flags);
+		else
+			clear_bit(MT_WCID_FLAG_4ADDR, &msta_link->wcid.flags);
+
+		if (!msta_link->wcid.sta)
+			continue;
+
+		mt7996_mcu_wtbl_update_hdr_trans(dev, vif, link, msta_link);
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 static void mt7996_sta_set_decap_offload(struct ieee80211_hw *hw,
@@ -1560,19 +1578,39 @@ static void mt7996_sta_set_decap_offload(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *sta,
 					 bool enabled)
 {
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
-	if (enabled)
-		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta_link->wcid.flags);
-	else
-		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta_link->wcid.flags);
+	mutex_lock(&dev->mt76.mutex);
 
-	if (!msta_link->wcid.sta)
-		return;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt7996_sta_link *msta_link;
+		struct mt7996_vif_link *link;
 
-	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
+
+		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		if (!msta_link)
+			continue;
+
+		if (enabled)
+			set_bit(MT_WCID_FLAG_HDR_TRANS,
+				&msta_link->wcid.flags);
+		else
+			clear_bit(MT_WCID_FLAG_HDR_TRANS,
+				  &msta_link->wcid.flags);
+
+		if (!msta_link->wcid.sta)
+			continue;
+
+		mt7996_mcu_wtbl_update_hdr_trans(dev, vif, link, msta_link);
+	}
+
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 static const char mt7996_gstrings_stats[][ETH_GSTRING_LEN] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 46c5e639b9630199ffa601e545fa76690f0101e3..7c097aaead328bd234d87e535497c2f788ffa4c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4465,17 +4465,12 @@ int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
 
 int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct ieee80211_vif *vif,
-				     struct ieee80211_sta *sta)
+				     struct mt7996_vif_link *link,
+				     struct mt7996_sta_link *msta_link)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta_link *msta_link;
-	struct mt7996_sta *msta;
 	struct sk_buff *skb;
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : NULL;
-	msta_link = msta ? &msta->deflink : &mvif->deflink.msta_link;
-
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
 					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c2a2916e0647cfdcbee9912e3915241465e32cac..f226090bcd02ea478113e4bccea0492cfa34477d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -749,7 +749,8 @@ int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif
 			       struct ieee80211_key_conf *key);
 int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct ieee80211_vif *vif,
-				     struct ieee80211_sta *sta);
+				     struct mt7996_vif_link *link,
+				     struct mt7996_sta_link *msta_link);
 int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,

-- 
2.48.1


