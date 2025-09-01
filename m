Return-Path: <linux-wireless+bounces-26892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F725B3E3D3
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B812217C4F7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC5F4207A;
	Mon,  1 Sep 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwGvLLvz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3633086
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731767; cv=none; b=bmJ04mOzX20/iIUrROah8asjHSS60XghJOClyDQU77OoA+kR9sXbYG5G1Mpd+m3LgKU/wADPcHFlqVPCauvA/fie5yUFDSL35AKZdbWqzdPrZCJnYjpS6TY5ryR9xQVEoqhoLIkqTKVWC2HQtNep22XljbwkP9EE71ybH2UipMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731767; c=relaxed/simple;
	bh=SjG+q9Jk6pllyjgr9OYtJrRLi5STYvgdqR2S+b1zO+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MIrNPD2qaS7eP+k3ZG9oRexmW8GzcqMLCJBU72uqb/eDwlFP5D1c45xFJksRe7esrPhCWxSXupWf5A43C5JvMwEBrsgyk84MFoJC/u20ueA09qZuC8jb31XX1Wek611NaFTQgVxjAZlRePvnAKbzEmAT7KctafBSkdSjAsOLP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwGvLLvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380E6C4CEF0;
	Mon,  1 Sep 2025 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756731766;
	bh=SjG+q9Jk6pllyjgr9OYtJrRLi5STYvgdqR2S+b1zO+0=;
	h=From:Date:Subject:To:Cc:From;
	b=DwGvLLvzpQqLjo3gR3m5TDfTg4XQCb40KNA46dhNRiWDUjPVakCI8Idd2IAMyH4lr
	 xfsuH8MruAkq/g6vgph+DIU+jkrrdM9a2zQ/z7bGe+uO0079KK9dZ6fODhFyq0Pp0c
	 PRpREL481cHrL/UjYaPf2a4I3199ANNu/fCntQGUR7xenhus91CWtLxB/K5IN9xbTw
	 HgyP9frTIbjvGpPU1S4Ctyaka/CydZCtFdeKpQW4v6R5nR/P5jpFBOh2H9wKlvY8jc
	 qODCpb0fvPgXwQzIf/biK0syYvYqAMJ0pM3+irbmkivhrsE+ohULZ1bwGBVIzUkOi/
	 vnDjVanoryfoA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Sep 2025 15:02:33 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Enable MLO support for client
 interfaces
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mt7996-enable-mlo-client-v1-1-50c46317325d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGiZtWgC/x3MQQqEMAxA0atI1gZMh1bjVcSFo1EDtUorIoh3n
 zLLt/j/gSRRJUFbPBDl0qR7yKCygHEdwiKoUzaYytiqMYzbWTM7lDB8veDmdxy9SjiRiMk66/h
 jCHJ+RJn1/q+7/n1/VJiuD2oAAAA=
X-Change-ID: 20250829-mt7996-enable-mlo-client-119156569321
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Report MT7996 MLO STA capabilities to mac80211 stack.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 52 ++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 52 +-----------------------
 drivers/net/wireless/mediatek/mt76/mt7996/init.c |  8 ++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 32 ++++++++++++---
 5 files changed, 88 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3afe4c4cd7bbec5d317be4155f232eec7d41b62e..903e5a4251a47f92e2f647c84ade5eff06b24eba 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -2019,3 +2019,55 @@ void mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif)
 		mt76_abort_roc(mvif->roc_phy);
 }
 EXPORT_SYMBOL_GPL(mt76_vif_cleanup);
+
+u16 mt76_select_links(struct ieee80211_vif *vif, int max_active_links)
+{
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct  {
+		u8 link_id;
+		enum nl80211_band band;
+	} data[IEEE80211_MLD_MAX_NUM_LINKS];
+	unsigned int link_id;
+	int i, n_data = 0;
+	u16 sel_links = 0;
+
+	if (!ieee80211_vif_is_mld(vif))
+		return 0;
+
+	if (vif->active_links == usable_links)
+		return vif->active_links;
+
+	rcu_read_lock();
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = rcu_dereference(vif->link_conf[link_id]);
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].band = link_conf->chanreq.oper.chan->band;
+		n_data++;
+	}
+	rcu_read_unlock();
+
+	for (i = 0; i < n_data; i++) {
+		int j;
+
+		if (!(BIT(data[i].link_id) & vif->active_links))
+			continue;
+
+		sel_links = BIT(data[i].link_id);
+		for (j = 0; j < n_data; j++) {
+			if (data[i].band != data[j].band) {
+				sel_links |= BIT(data[j].link_id);
+				if (hweight16(sel_links) == max_active_links)
+					break;
+			}
+		}
+		break;
+	}
+
+	return sel_links;
+}
+EXPORT_SYMBOL_GPL(mt76_select_links);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8dd5c29fb75b5c0c879350f3af15b71f12630a96..d518a5441418bce5ae477e7f15dde56b6cb5b87d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1871,6 +1871,7 @@ mt76_vif_init(struct ieee80211_vif *vif, struct mt76_vif_data *mvif)
 }
 
 void mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif);
+u16 mt76_select_links(struct ieee80211_vif *vif, int max_active_links);
 
 static inline struct mt76_vif_link *
 mt76_vif_link(struct mt76_dev *dev, struct ieee80211_vif *vif, int link_id)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 47abf5f0486076a77b949a6d59b2eddba4b186ce..f9ab24b05327c57f0b094a552d3bc598f9a74dc1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -988,56 +988,6 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
 
-static u16
-mt7925_mac_select_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
-{
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	struct  {
-		u8 link_id;
-		enum nl80211_band band;
-	} data[IEEE80211_MLD_MAX_NUM_LINKS];
-	u8 link_id, i, j, n_data = 0;
-	u16 sel_links = 0;
-
-	if (!ieee80211_vif_is_mld(vif))
-		return 0;
-
-	if (vif->active_links == usable_links)
-		return vif->active_links;
-
-	rcu_read_lock();
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference(vif->link_conf[link_id]);
-
-		if (WARN_ON_ONCE(!link_conf))
-			continue;
-
-		data[n_data].link_id = link_id;
-		data[n_data].band = link_conf->chanreq.oper.chan->band;
-		n_data++;
-	}
-	rcu_read_unlock();
-
-	for (i = 0; i < n_data; i++) {
-		if (!(BIT(data[i].link_id) & vif->active_links))
-			continue;
-
-		sel_links = BIT(data[i].link_id);
-
-		for (j = 0; j < n_data; j++) {
-			if (data[i].band != data[j].band) {
-				sel_links |= BIT(data[j].link_id);
-				break;
-			}
-		}
-
-		break;
-	}
-
-	return sel_links;
-}
-
 static void
 mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
 {
@@ -1048,7 +998,7 @@ mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
 	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
 	enum nl80211_band band = chandef->chan->band, secondary_band;
 
-	u16 sel_links = mt7925_mac_select_links(mdev, vif);
+	u16 sel_links = mt76_select_links(vif, 2);
 	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
 
 	if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 29e0cf966bcac5ab805b927fd73b7a23d15877ec..428b431b2910a06b7f3daded9cea1bbe1427fbb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -78,6 +78,14 @@ static const struct wiphy_iftype_ext_capab iftypes_ext_capa[] = {
 		.mld_capa_and_ops =
 			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS,
 					 MT7996_MAX_RADIOS - 1),
+	}, {
+		.iftype = NL80211_IFTYPE_STATION,
+		.extended_capabilities = if_types_ext_capa_ap,
+		.extended_capabilities_mask = if_types_ext_capa_ap,
+		.extended_capabilities_len = sizeof(if_types_ext_capa_ap),
+		.mld_capa_and_ops =
+			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS,
+					 MT7996_MAX_RADIOS - 1),
 	},
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 7f3a117c52bd3438b6bb41a068bbf11658dfba42..341ed090d2b85bac3ad99035a8649c9bdbd78424 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1212,6 +1212,24 @@ mt7996_mac_sta_remove(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static void
+mt7996_set_active_links(struct ieee80211_vif *vif)
+{
+	u16 active_links;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!ieee80211_vif_is_mld(vif))
+		return;
+
+	active_links = mt76_select_links(vif, MT7996_MAX_RADIOS);
+	if (hweight16(active_links) < 2)
+		return;
+
+	ieee80211_set_active_links_async(vif, active_links);
+}
+
 static int
 mt7996_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		 struct ieee80211_sta *sta, enum ieee80211_sta_state old_state,
@@ -1229,16 +1247,18 @@ mt7996_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mt7996_mac_sta_remove(dev, vif, sta);
 
 	if (old_state == IEEE80211_STA_AUTH &&
-	    new_state == IEEE80211_STA_ASSOC)
+	    new_state == IEEE80211_STA_ASSOC) {
+		mt7996_set_active_links(vif);
 		ev = MT76_STA_EVENT_ASSOC;
-	else if (old_state == IEEE80211_STA_ASSOC &&
-		 new_state == IEEE80211_STA_AUTHORIZED)
+	} else if (old_state == IEEE80211_STA_ASSOC &&
+		   new_state == IEEE80211_STA_AUTHORIZED) {
 		ev = MT76_STA_EVENT_AUTHORIZE;
-	else if (old_state == IEEE80211_STA_ASSOC &&
-		 new_state == IEEE80211_STA_AUTH)
+	} else if (old_state == IEEE80211_STA_ASSOC &&
+		   new_state == IEEE80211_STA_AUTH) {
 		ev = MT76_STA_EVENT_DISASSOC;
-	else
+	} else {
 		return 0;
+	}
 
 	return mt7996_mac_sta_event(dev, vif, sta, ev);
 }

---
base-commit: 035ba65d13516fa2afa78203ba3ef54fd70584af
change-id: 20250829-mt7996-enable-mlo-client-119156569321

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


