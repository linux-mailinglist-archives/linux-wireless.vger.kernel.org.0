Return-Path: <linux-wireless+bounces-17009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EEA9FFBDB
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505147A1582
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9301187848;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="KB1ZL4fA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D615381A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835725; cv=none; b=Sc9IxFcIUrhPmwnLB6dj9fbOJDUcwY8Z3FO5V43WK/fuAFZCXptKx3jiQlal7E14Movq+8ECfBErIL4MUz5YzudLVwSV8xGSsr8MFIQJrFfW/kTgb+XcGrTCz7HdxnW3423Nuecd2SRXMV8f/9gfUHOxYml+kW88+tG+Cm8t/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835725; c=relaxed/simple;
	bh=/d2VKEZTPeKNlSNnRFWudfikp4hFadFMTn1rvHmp9iw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xj4845JRPU+ITERJiHGm0AZZMFKSVUjxU3geCrfbz8ssdaffK2bLUho469/UIhSgEI62I1RmpHxd+qNdRY3A8agCVjvv/RvBkOfj8yvwfrQw4KqzdGvmw4oX/q/TFbeRcAxTcdJIOLwjlwVfyw42CzhoHDhE9pKPiPPVSqkulPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=KB1ZL4fA; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/37xu0HUGTvzMnxQiW2OBl+VUTEM2NI1CsVGPMUYurI=; b=KB1ZL4fAp5bfRmSxoZ4y4lfvmb
	2KkLn6m0KX3FvQXwnxEaFadVkazaVlnZwhyIClD1lkAf6DysrMRlx5Ban+J+aPs/jlVumG6TaSglI
	FFYM3j2tuGNidGHLP7F79aispUewMD64CDo0dc4LjKKPnEub/wolapP4DBA9cs7Q5O4Y=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAE-0008GS-1v
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:14 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 20/24] wifi: mt76: mt7996: prepare mt7996_mcu_update_bss_color for MLO support
Date: Thu,  2 Jan 2025 17:35:04 +0100
Message-ID: <20250102163508.52945-20-nbd@nbd.name>
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

Pass in struct mt76_vif_link in order to update the correct link.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 34 +++++--------------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  6 ++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +-
 3 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 95d915045cf7..ab875abfbd0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -540,29 +540,6 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-static void
-mt7996_update_bss_color(struct ieee80211_hw *hw,
-			struct ieee80211_vif *vif,
-			struct cfg80211_he_bss_color *bss_color)
-{
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_AP: {
-		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-
-		if (mvif->deflink.mt76.omac_idx > HW_BSSID_MAX)
-			return;
-		fallthrough;
-	}
-	case NL80211_IFTYPE_STATION:
-		mt7996_mcu_update_bss_color(dev, vif, bss_color);
-		break;
-	default:
-		break;
-	}
-}
-
 static u8
 mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       bool beacon, bool mcast)
@@ -618,9 +595,9 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt76_vif_link *mvif = mt76_vif_conf_link(&dev->mt76, vif, info);
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -662,8 +639,13 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
 		mt7996_mcu_add_obss_spr(phy, vif, &info->he_obss_pd);
 
-	if (changed & BSS_CHANGED_HE_BSS_COLOR)
-		mt7996_update_bss_color(hw, vif, &info->he_bss_color);
+	if (changed & BSS_CHANGED_HE_BSS_COLOR) {
+		if ((vif->type == NL80211_IFTYPE_AP &&
+		    mvif->omac_idx <= HW_BSSID_MAX) ||
+		   vif->type == NL80211_IFTYPE_STATION)
+			mt7996_mcu_update_bss_color(dev, mvif,
+						    &info->he_bss_color);
+	}
 
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8ae98b724668..83c079debf9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4143,16 +4143,16 @@ int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 	return mt7996_mcu_set_obss_spr_bitmap(phy, he_obss_pd);
 }
 
-int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+int mt7996_mcu_update_bss_color(struct mt7996_dev *dev,
+				struct mt76_vif_link *mlink,
 				struct cfg80211_he_bss_color *he_bss_color)
 {
 	int len = sizeof(struct bss_req_hdr) + sizeof(struct bss_color_tlv);
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct bss_color_tlv *bss_color;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76, len);
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, mlink, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 604b67ea12e4..0774ffdde65d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -531,7 +531,8 @@ int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);
-int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+int mt7996_mcu_update_bss_color(struct mt7996_dev *dev,
+				struct mt76_vif_link *mlink,
 				struct cfg80211_he_bss_color *he_bss_color);
 int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *link_conf);
-- 
2.47.1


