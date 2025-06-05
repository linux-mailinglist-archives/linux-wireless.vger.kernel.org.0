Return-Path: <linux-wireless+bounces-23758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F8ACEE69
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57AA3AC533
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E861547C9;
	Thu,  5 Jun 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIwEy9UF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AF3C465
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122309; cv=none; b=Av7+/aUaLRLiOBEp1QYgq7KYL31RIO7Pc42wtx7E6osKHd6jXVllYUGjl2ny2PJCumzdt5pPk/gyK0nslU59qL3AOf3FJbeU+VbiRytEgMw1VpwQy9EGF/iz6xx8JgP6kH3vlEc6fC8JBtgOiAVIypKudLF0sNoHNnjydOXH390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122309; c=relaxed/simple;
	bh=+EbdnKGqeXIQ6r1cYATj3UjjPd1X6oB6b0iOJMSSB4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSkaLaTfX7B+6aHeZorFEkWg+urjbNSzDekADPnrcMOm+l38uCl20QI6g6sI3NldGpVvEU3hchpl2HFh/PaFx7hPgcdWtB1EKCJ1wpo9SMOKASaISCDOvFJHkGxIQIVnGIhcrOJNQcHp++8C8F3jiTJozE/gLqnCUmS2NrNT5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIwEy9UF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F641C4CEE7;
	Thu,  5 Jun 2025 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122308;
	bh=+EbdnKGqeXIQ6r1cYATj3UjjPd1X6oB6b0iOJMSSB4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hIwEy9UFek2bJ/MTmm2e2OR15E7mjDyL18jWBXC3YSLFvma7xGd0M69C/WCth5WeU
	 ToPUweUREatEw6BAoe6fSq2or4pb0VQKLUPpy+JgrLO0JNWKYei6s2BkeQ5cmIKd1m
	 SRfnrLXlgI4jT8rUy7jUkNsLlSJKAhH3dG73MqkQbEpR98OSyDNX1aHPO9NrVDq2qK
	 m1gqYvvu5ZJrzM7YOjmM5zEgF6y6ycyQL/qgf83F+kIpY76Siyikb3p78rPH4BbkWC
	 4qBHzyWiYxYlSTia9h8363A4ljWeXS+UZsNuaXMlbp0iPukxNfepnUjMW93Sm5sn3G
	 KjE6+JVxgHhww==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 05 Jun 2025 13:14:17 +0200
Subject: [PATCH mt76 2/5] wifi: mt76: Move RCU section in
 mt7996_mcu_set_fixed_field()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-mt7996-sleep-while-atomic-v1-2-d46d15f9203c@kernel.org>
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

Since mt76_mcu_skb_send_msg() routine can't be executed in atomic context,
move RCU section in mt7996_mcu_set_fixed_field() and execute
mt76_mcu_skb_send_msg() in non-atomic context. This is a preliminary
patch to fix a 'sleep while atomic' issue in mt7996_mac_sta_rc_work().

Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 68 ++++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 10 ++--
 4 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0dbd4662bc842947abf09f9ae3aa4a1d4b86cba8..7444bd374b50bdfdcf7e1973993f496b740a1c51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2405,11 +2405,10 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 			       IEEE80211_RC_BW_CHANGED))
 			mt7996_mcu_add_rate_ctrl(dev, vif, link_conf,
 						 link_sta, link, msta_link,
-						 true);
+						 link_id, true);
 
 		if (changed & IEEE80211_RC_SMPS_CHANGED)
-			mt7996_mcu_set_fixed_field(dev, link_sta, link,
-						   msta_link, NULL,
+			mt7996_mcu_set_fixed_field(dev, msta, NULL, link_id,
 						   RATE_PARAM_MMPS_UPDATE);
 
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 78ae9f5cb1760ababc088fc21bfc3957cfe02506..a096b5bab001de8d4fe3270ab37b1a6dab702ab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1114,7 +1114,8 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 			err = mt7996_mcu_add_rate_ctrl(dev, vif, link_conf,
 						       link_sta, link,
-						       msta_link, false);
+						       msta_link, link_id,
+						       false);
 			if (err)
 				return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index f0adc0b4b8b6ccdc6ce11991a4d99b89500fe7a9..33c61e795b734e84af42fdea5ba33975e3e3365a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1905,22 +1905,35 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				     MCU_WM_UNI_CMD(RA), true);
 }
 
-int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev,
-			       struct ieee80211_link_sta *link_sta,
-			       struct mt7996_vif_link *link,
-			       struct mt7996_sta_link *msta_link,
-			       void *data, u32 field)
+int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct mt7996_sta *msta,
+			       void *data, u8 link_id, u32 field)
 {
-	struct sta_phy_uni *phy = data;
+	struct mt7996_vif *mvif = msta->vif;
+	struct mt7996_sta_link *msta_link;
 	struct sta_rec_ra_fixed_uni *ra;
+	struct sta_phy_uni *phy = data;
+	struct mt76_vif_link *mlink;
 	struct sk_buff *skb;
+	int err = -ENODEV;
 	struct tlv *tlv;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
+	rcu_read_lock();
+
+	mlink = rcu_dereference(mvif->mt76.link[link_id]);
+	if (!mlink)
+		goto error_unlock;
+
+	msta_link = rcu_dereference(msta->link[link_id]);
+	if (!msta_link)
+		goto error_unlock;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, mlink,
 					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		goto error_unlock;
+	}
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
 	ra = (struct sta_rec_ra_fixed_uni *)tlv;
@@ -1935,27 +1948,45 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev,
 		if (phy)
 			ra->phy = *phy;
 		break;
-	case RATE_PARAM_MMPS_UPDATE:
+	case RATE_PARAM_MMPS_UPDATE: {
+		struct ieee80211_sta *sta = wcid_to_sta(&msta_link->wcid);
+		struct ieee80211_link_sta *link_sta;
+
+		link_sta = rcu_dereference(sta->link[link_id]);
+		if (!link_sta) {
+			dev_kfree_skb(skb);
+			goto error_unlock;
+		}
+
 		ra->mmps_mode = mt7996_mcu_get_mmps_mode(link_sta->smps_mode);
 		break;
+	}
 	default:
 		break;
 	}
 	ra->field = cpu_to_le32(field);
 
+	rcu_read_unlock();
+
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+error_unlock:
+	rcu_read_unlock();
+
+	return err;
 }
 
 static int
 mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
 			       struct ieee80211_link_sta *link_sta,
 			       struct mt7996_vif_link *link,
-			       struct mt7996_sta_link *msta_link)
+			       struct mt7996_sta_link *msta_link,
+			       u8 link_id)
 {
 	struct cfg80211_chan_def *chandef = &link->phy->mt76->chandef;
 	struct cfg80211_bitrate_mask *mask = &link->bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
+	struct mt7996_sta *msta = msta_link->sta;
 	struct sta_phy_uni phy = {};
 	int ret, nrates = 0;
 
@@ -1996,8 +2027,7 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
 
 	/* fixed single rate */
 	if (nrates == 1) {
-		ret = mt7996_mcu_set_fixed_field(dev, link_sta, link,
-						 msta_link, &phy,
+		ret = mt7996_mcu_set_fixed_field(dev, msta, &phy, link_id,
 						 RATE_PARAM_FIXED_MCS);
 		if (ret)
 			return ret;
@@ -2018,8 +2048,7 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
 		else
 			mt76_rmw_field(dev, addr, GENMASK(15, 12), phy.sgi);
 
-		ret = mt7996_mcu_set_fixed_field(dev, link_sta, link,
-						 msta_link, &phy,
+		ret = mt7996_mcu_set_fixed_field(dev, msta, &phy, link_id,
 						 RATE_PARAM_FIXED_GI);
 		if (ret)
 			return ret;
@@ -2027,8 +2056,7 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev,
 
 	/* fixed HE_LTF */
 	if (mask->control[band].he_ltf != GENMASK(7, 0)) {
-		ret = mt7996_mcu_set_fixed_field(dev, link_sta, link,
-						 msta_link, &phy,
+		ret = mt7996_mcu_set_fixed_field(dev, msta, &phy, link_id,
 						 RATE_PARAM_FIXED_HE_LTF);
 		if (ret)
 			return ret;
@@ -2150,7 +2178,8 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
 			     struct ieee80211_bss_conf *link_conf,
 			     struct ieee80211_link_sta *link_sta,
 			     struct mt7996_vif_link *link,
-			     struct mt7996_sta_link *msta_link, bool changed)
+			     struct mt7996_sta_link *msta_link,
+			     u8 link_id, bool changed)
 {
 	struct sk_buff *skb;
 	int ret;
@@ -2178,7 +2207,8 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
 	if (ret)
 		return ret;
 
-	return mt7996_mcu_add_rate_ctrl_fixed(dev, link_sta, link, msta_link);
+	return mt7996_mcu_add_rate_ctrl_fixed(dev, link_sta, link, msta_link,
+					      link_id);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 1ad6bc046f7c01d43452252ed46677d42e0c8850..a529c2bae7cbf83589650c593f033e6ec5e714a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -625,18 +625,16 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
 			     struct ieee80211_bss_conf *link_conf,
 			     struct ieee80211_link_sta *link_sta,
 			     struct mt7996_vif_link *link,
-			     struct mt7996_sta_link *msta_link, bool changed);
+			     struct mt7996_sta_link *msta_link,
+			     u8 link_id, bool changed);
 int mt7996_set_channel(struct mt76_phy *mphy);
 int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		      struct ieee80211_bss_conf *link_conf);
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version);
-int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev,
-			       struct ieee80211_link_sta *link_sta,
-			       struct mt7996_vif_link *link,
-			       struct mt7996_sta_link *msta_link,
-			       void *data, u32 field);
+int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct mt7996_sta *msta,
+			       void *data, u8 link_id, u32 field);
 int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
 int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len);
 int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);

-- 
2.49.0


