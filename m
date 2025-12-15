Return-Path: <linux-wireless+bounces-29746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C2CBCA9A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 07:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39DCB3035D2E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 06:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD930BB83;
	Mon, 15 Dec 2025 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qxoneFVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9B30C625
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780692; cv=none; b=AXz3tHEn/EzEUgEOYnCkD8quWuN1siGSPe0c68ZTyna2ma0MQCIwch4kIonArMlf2JbrpYVWgcCm/nyeqyOEl0Q8P2I7wogNEPJeIjKjaL+uYwu7AZQdo+XguL0yNUxaootvJGEo1hRXbCRSMafzmXBFSgDGwoPkXFH4EitGUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780692; c=relaxed/simple;
	bh=ypt7WF0YHDTtk4FNcJ4c4wllgLkcsSwuEyzbCNiRNWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RK6HTQpK6QHoNn6Wf3YIbKUEyKgSCV1ECdKpMxf2A5UMM7KYVi30Y1oTbmgZDhzvPspAMmN2gXyBvxe7e/Unth5iLrH3Zbib/UVRFQ7XnrL882YtgUWp2wZRWcARS03rHf8VwLsPRpwia//yhO55/l4AiBpkgjhx6Pvfj5ocDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qxoneFVC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 99bb622ed98011f0b33aeb1e7f16c2b6-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+efuKcWtgTDRo9XgQSpQQ2x/P7lFj6YofLZn0vxgKlk=;
	b=qxoneFVCGumMCUHveF9lRFPVI/ha1TxMexy4IX8uf2mjOqW8ftXoIED45Q1fLxXkrYXZAQj70WhCvHdFOrrLNn9InxrmUIpGDSvfDh/3puCtVkNrdeOWQrfLU+lmBASK/29gB22OKsdtIVhGBYODJOLIJW+A5XH35H0HTqok0nk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ba5601a8-a576-404d-92e3-d2c9d0eb8f06,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:bc7ac602-1fa9-44eb-b231-4afc61466396,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 99bb622ed98011f0b33aeb1e7f16c2b6-20251215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1366454380; Mon, 15 Dec 2025 14:38:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 14:37:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 14:37:59 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Subject: [PATCH mt76 v2 1/7] wifi: mt76: mt7996: extend CSA and CCA support for MLO
Date: Mon, 15 Dec 2025 14:37:22 +0800
Message-ID: <20251215063728.3013365-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Use correct link_id to report CSA and CCA countdown events, and also
modify mt7996_channel_switch_beacon() to set beacon with the correct
link_id.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  23 ++-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 159 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |   8 +-
 3 files changed, 131 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index beed795edb24..9b4bfb071292 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -927,9 +927,30 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 			     struct cfg80211_chan_def *chandef)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_band_phy(dev, chandef->chan->band);
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf, vif->bss_conf.enable_beacon);
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		struct mt7996_vif_link *link =
+			mt7996_vif_link(dev, vif, link_id);
+
+		if (!link || link->phy != phy)
+			continue;
+
+		/* Reset beacon when channel switch triggered during CAC to let
+		 * FW correctly perform CSA countdown
+		 */
+		if (!cfg80211_reg_can_beacon(hw->wiphy, &phy->mt76->chandef,
+					     vif->type))
+			mt7996_mcu_add_beacon(hw, vif, link_conf, false);
+
+		mt7996_mcu_add_beacon(hw, vif, link_conf, true);
+		break;
+	}
+
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 14a88ef79b6c..7be03bbf34d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -390,13 +390,117 @@ int mt7996_mcu_wa_cmd(struct mt7996_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 				 sizeof(req), false);
 }
 
+struct mt7996_mcu_countdown_data {
+	struct mt76_phy *mphy;
+	u8 omac_idx;
+};
+
 static void
 mt7996_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	if (!vif->bss_conf.csa_active || vif->type == NL80211_IFTYPE_STATION)
+	struct mt7996_mcu_countdown_data *cdata = (void *)priv;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf = NULL;
+	unsigned long valid_links = vif->valid_links ?: BIT(0);
+	unsigned int link_id;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		return;
+
+	for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt76_vif_link *mlink =
+			rcu_dereference(mvif->mt76.link[link_id]);
+
+		if (mlink && mlink->band_idx == cdata->mphy->band_idx &&
+		    mlink->omac_idx == cdata->omac_idx) {
+			link_conf = rcu_dereference(vif->link_conf[link_id]);
+			break;
+		}
+	}
+
+	if (!link_conf || !link_conf->csa_active)
 		return;
 
-	ieee80211_csa_finish(vif, 0);
+	ieee80211_csa_finish(vif, link_conf->link_id);
+}
+
+static void
+mt7996_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7996_mcu_countdown_data *cdata = (void *)priv;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf = NULL;
+	unsigned long valid_links = vif->valid_links ?: BIT(0);
+	unsigned int link_id;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		return;
+
+	for_each_set_bit(link_id, &valid_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt76_vif_link *mlink =
+			rcu_dereference(mvif->mt76.link[link_id]);
+
+		if (mlink && mlink->band_idx == cdata->mphy->band_idx &&
+		    mlink->omac_idx == cdata->omac_idx) {
+			link_conf = rcu_dereference(vif->link_conf[link_id]);
+			break;
+		}
+	}
+
+	if (!link_conf || !link_conf->color_change_active)
+		return;
+
+	ieee80211_color_change_finish(vif, link_conf->link_id);
+}
+
+static void
+mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+#define UNI_EVENT_IE_COUNTDOWN_CSA 0
+#define UNI_EVENT_IE_COUNTDOWN_BCC 1
+	struct header {
+		u8 band;
+		u8 rsv[3];
+	};
+	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
+	const char *data = (char *)&rxd[1], *tail;
+	struct header *hdr = (struct header *)data;
+	struct tlv *tlv = (struct tlv *)(data + 4);
+	struct mt7996_mcu_countdown_notify *event;
+	struct mt7996_mcu_countdown_data cdata;
+
+	if (hdr->band >= ARRAY_SIZE(dev->mt76.phys))
+		return;
+
+	cdata.mphy = dev->mt76.phys[hdr->band];
+	if (!cdata.mphy)
+		return;
+
+	tail = skb->data + skb->len;
+	data += sizeof(*hdr);
+	while (data + sizeof(*tlv) < tail && le16_to_cpu(tlv->len)) {
+		event = (struct mt7996_mcu_countdown_notify *)tlv->data;
+
+		cdata.omac_idx = event->omac_idx;
+
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_IE_COUNTDOWN_CSA:
+			ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7996_mcu_csa_finish, &cdata);
+			break;
+		case UNI_EVENT_IE_COUNTDOWN_BCC:
+			ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
+					IEEE80211_IFACE_ITER_RESUME_ALL,
+					mt7996_mcu_cca_finish, &cdata);
+			break;
+		default:
+			break;
+		}
+
+		data += le16_to_cpu(tlv->len);
+		tlv = (struct tlv *)data;
+	}
 }
 
 static void
@@ -476,57 +580,6 @@ mt7996_mcu_rx_log_message(struct mt7996_dev *dev, struct sk_buff *skb)
 	wiphy_info(mt76_hw(dev)->wiphy, "%s: %.*s", type, len, data);
 }
 
-static void
-mt7996_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-	if (!vif->bss_conf.color_change_active || vif->type == NL80211_IFTYPE_STATION)
-		return;
-
-	ieee80211_color_change_finish(vif, 0);
-}
-
-static void
-mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
-{
-#define UNI_EVENT_IE_COUNTDOWN_CSA 0
-#define UNI_EVENT_IE_COUNTDOWN_BCC 1
-	struct header {
-		u8 band;
-		u8 rsv[3];
-	};
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt7996_mcu_rxd *rxd = (struct mt7996_mcu_rxd *)skb->data;
-	const char *data = (char *)&rxd[1], *tail;
-	struct header *hdr = (struct header *)data;
-	struct tlv *tlv = (struct tlv *)(data + 4);
-
-	if (hdr->band >= ARRAY_SIZE(dev->mt76.phys))
-		return;
-
-	if (hdr->band && dev->mt76.phys[hdr->band])
-		mphy = dev->mt76.phys[hdr->band];
-
-	tail = skb->data + skb->len;
-	data += sizeof(struct header);
-	while (data + sizeof(struct tlv) < tail && le16_to_cpu(tlv->len)) {
-		switch (le16_to_cpu(tlv->tag)) {
-		case UNI_EVENT_IE_COUNTDOWN_CSA:
-			ieee80211_iterate_active_interfaces_atomic(mphy->hw,
-					IEEE80211_IFACE_ITER_RESUME_ALL,
-					mt7996_mcu_csa_finish, mphy->hw);
-			break;
-		case UNI_EVENT_IE_COUNTDOWN_BCC:
-			ieee80211_iterate_active_interfaces_atomic(mphy->hw,
-					IEEE80211_IFACE_ITER_RESUME_ALL,
-					mt7996_mcu_cca_finish, mphy->hw);
-			break;
-		}
-
-		data += le16_to_cpu(tlv->len);
-		tlv = (struct tlv *)data;
-	}
-}
-
 static int
 mt7996_mcu_update_tx_gi(struct rate_info *rate, struct all_sta_trx_rate *mcu_rate)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index e0b83ac9f5e2..fc8b09e76f01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -52,12 +52,10 @@ struct mt7996_mcu_thermal_enable {
 	u8 rsv[2];
 } __packed;
 
-struct mt7996_mcu_csa_notify {
-	struct mt7996_mcu_rxd rxd;
-
+struct mt7996_mcu_countdown_notify {
 	u8 omac_idx;
-	u8 csa_count;
-	u8 band_idx;
+	u8 count;
+	u8 csa_failure_reason; /* 0: success, 1: beacon disabled */
 	u8 rsv;
 } __packed;
 
-- 
2.51.0


