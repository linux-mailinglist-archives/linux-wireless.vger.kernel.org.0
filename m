Return-Path: <linux-wireless+bounces-17007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499ED9FFBD9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C95E18839C0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAB1632DF;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="fw55bjkO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1E1684A4
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835724; cv=none; b=rtdSYyI8J5xtB0KW/LIH6j3wqvrsyforTv995hB6Lz3rRB7ou8yBCn/fxuv9jfnM86YDbOHCxiJpiRrguNzpDa9g6306YSImQsIQR4pADvLg7NBqTPn+cWZxkbkRfiWr27Jr7ahMYi9BEC/bdsJWcyvHJva+hjhNvxp8RI3Nw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835724; c=relaxed/simple;
	bh=i6llASfDMATG4bddpyZ7udFUFRX7wbUZ6KxqxyJQsCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpvk88TO8JDGO7KjQghKJ+1P39+DlqJi7NBkTPOpaox+QndwO8oy31U88Ha091geA0gfIQUDa2byOm4ixNpLNNEfeRWNORlBOFzsAt59ui0XdMMpfvQybPAPtZTQVcPC4gdoyVPWEuqUq0+00Y8sLth3fHp30QJsSmL2cD9u7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=fw55bjkO; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=r+Fqw0rmevsz2FDVL+WuuD0rXP+Sx2PTlNptOZbqhzw=; b=fw55bjkO9/XLzqYw6r6Jw3q68I
	qIfWLeiBbTMlZzqyltCePM3KKBfTNNJYga1asqqnSls3XK0fR2NkZJaHKKY1IRf6dPjR6JuQY/+3o
	80Eu4qWL1WssyRtYsgnFBXlVLixUCEcF5NyWlmWqUOEbKMRomfwX3sNe5j36M052s1+s=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAD-0008GS-2y
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:13 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 16/24] wifi: mt76: mt7996: prepare mt7996_mcu_add_beacon for MLO support
Date: Thu,  2 Jan 2025 17:35:00 +0100
Message-ID: <20250102163508.52945-16-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass in struct ieee80211_bss_conf.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 51 ++++++++++---------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +-
 4 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2656e3f85bdc..89523afa4aca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1593,7 +1593,7 @@ mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_AP:
-		mt7996_mcu_add_beacon(hw, vif, vif->bss_conf.enable_beacon);
+		mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 6e90ecfecd8f..ae4fad290785 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -669,7 +669,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		mvif->beacon_rates_idx =
 			mt7996_get_rates_table(hw, vif, true, false);
 
-		mt7996_mcu_add_beacon(hw, vif, info->enable_beacon);
+		mt7996_mcu_add_beacon(hw, vif, info);
 	}
 
 	if (changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -690,7 +690,7 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7996_mcu_add_beacon(hw, vif, true);
+	mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 43c728d39077..a66ccc2512af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2411,9 +2411,9 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
-			 struct sk_buff *skb,
-			 struct ieee80211_mutable_offsets *offs)
+mt7996_mcu_beacon_cntdwn(struct sk_buff *rskb, struct sk_buff *skb,
+			 struct ieee80211_mutable_offsets *offs,
+			 bool csa)
 {
 	struct bss_bcn_cntdwn_tlv *info;
 	struct tlv *tlv;
@@ -2422,7 +2422,7 @@ mt7996_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
 	if (!offs->cntdwn_counter_offs[0])
 		return;
 
-	tag = vif->bss_conf.csa_active ? UNI_BSS_INFO_BCN_CSA : UNI_BSS_INFO_BCN_BCC;
+	tag = csa ? UNI_BSS_INFO_BCN_CSA : UNI_BSS_INFO_BCN_BCC;
 
 	tlv = mt7996_mcu_add_uni_tlv(rskb, tag, sizeof(*info));
 
@@ -2432,16 +2432,13 @@ mt7996_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
 
 static void
 mt7996_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
-		       struct ieee80211_vif *vif, struct bss_bcn_content_tlv *bcn,
+		       struct bss_bcn_content_tlv *bcn,
 		       struct ieee80211_mutable_offsets *offs)
 {
 	struct bss_bcn_mbss_tlv *mbss;
 	const struct element *elem;
 	struct tlv *tlv;
 
-	if (!vif->bss_conf.bssid_indicator)
-		return;
-
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_MBSSID, sizeof(*mbss));
 
 	mbss = (struct bss_bcn_mbss_tlv *)tlv;
@@ -2484,7 +2481,8 @@ mt7996_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
 }
 
 static void
-mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+mt7996_mcu_beacon_cont(struct mt7996_dev *dev,
+		       struct ieee80211_bss_conf *link_conf,
 		       struct sk_buff *rskb, struct sk_buff *skb,
 		       struct bss_bcn_content_tlv *bcn,
 		       struct ieee80211_mutable_offsets *offs)
@@ -2498,9 +2496,9 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	if (offs->cntdwn_counter_offs[0]) {
 		u16 offset = offs->cntdwn_counter_offs[0];
 
-		if (vif->bss_conf.csa_active)
+		if (link_conf->csa_active)
 			bcn->csa_ie_pos = cpu_to_le16(offset - 4);
-		if (vif->bss_conf.color_change_active)
+		if (link_conf->color_change_active)
 			bcn->bcc_ie_pos = cpu_to_le16(offset - 3);
 	}
 
@@ -2511,12 +2509,11 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
-int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
-			  struct ieee80211_vif *vif, int en)
+int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link_conf)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_vif_link *mlink = mt76_vif_conf_link(&dev->mt76, vif, link_conf);
 	struct ieee80211_mutable_offsets offs;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb, *rskb;
@@ -2524,15 +2521,18 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct bss_bcn_content_tlv *bcn;
 	int len;
 
-	if (vif->bss_conf.nontransmitted)
+	if (link_conf->nontransmitted)
 		return 0;
 
-	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76,
+	if (!mlink)
+		return -EINVAL;
+
+	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, mlink,
 					  MT7996_MAX_BSS_OFFLOAD_SIZE);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
 
-	skb = ieee80211_beacon_get_template(hw, vif, &offs, 0);
+	skb = ieee80211_beacon_get_template(hw, vif, &offs, link_conf->link_id);
 	if (!skb) {
 		dev_kfree_skb(rskb);
 		return -EINVAL;
@@ -2546,21 +2546,22 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	}
 
 	info = IEEE80211_SKB_CB(skb);
-	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
+	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, mlink->band_idx);
 
 	len = ALIGN(sizeof(*bcn) + MT_TXD_SIZE + skb->len, 4);
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_CONTENT, len);
 	bcn = (struct bss_bcn_content_tlv *)tlv;
-	bcn->enable = en;
-	if (!en)
+	bcn->enable = link_conf->enable_beacon;
+	if (!bcn->enable)
 		goto out;
 
-	mt7996_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
-	mt7996_mcu_beacon_mbss(rskb, skb, vif, bcn, &offs);
-	mt7996_mcu_beacon_cntdwn(vif, rskb, skb, &offs);
+	mt7996_mcu_beacon_cont(dev, link_conf, rskb, skb, bcn, &offs);
+	if (link_conf->bssid_indicator)
+		mt7996_mcu_beacon_mbss(rskb, skb, bcn, &offs);
+	mt7996_mcu_beacon_cntdwn(rskb, skb, &offs, link_conf->csa_active);
 out:
 	dev_kfree_skb(skb);
-	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
+	return mt76_mcu_skb_send_msg(&dev->mt76, rskb,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 006269d75e5e..7b12b1f8898b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -534,7 +534,7 @@ int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 				struct cfg80211_he_bss_color *he_bss_color);
 int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			  int enable);
+			  struct ieee80211_bss_conf *link_conf);
 int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 				    struct ieee80211_vif *vif, u32 changed);
 int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
-- 
2.47.1


