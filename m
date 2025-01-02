Return-Path: <linux-wireless+bounces-17010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B79FFBDC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B177A15F4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E773017A5BE;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="XWvOeEoU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A9169AE6
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835725; cv=none; b=I0m1fa1yY4tjkjC617+D2wWX2ruQKOJx1JbPC//ZUe8R9up7C/GWu1sT9JAW9ufqIb7BQVK1Hnh34KQw2DRjRFLiVrMY3BuCWstSC8F/YCn2g02iEDz1KY2nzrdjoqqwRbfzzB2lXBqBA0zBWzlWkZT9R8dqGo/+Fg6PxBOPc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835725; c=relaxed/simple;
	bh=1z4PxIW/tBVxqLmsKM4YTRBkY6Ws5o+GuLqKjgxJQak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N05OhLaPrlZ//utbjusOoCyNn1ryEd36LiEU5c5TrGXGQNRTzzTi+zrUERxPsj83zcvkF9n6bOz5ax07ZsiG7WFL8WS7QOYYhS96+95m9YUBumCUulQDLCkqwjN9namffuabVJm+6N1pcWFMKlFXpk7CNUYFVXD8j5tp+q2p//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=XWvOeEoU; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ii0sHpg9Gt/0Mg7Do4M5834MeL9iR4iEjaZ0OAPazyQ=; b=XWvOeEoULMZcEtPAq5+U6x8bFy
	zkKoXGfZMQ5cFimuCixPrUFKLNXjqNypniQj79Q8WWw3E/exTosayOI47DqOKvbe9a/rNEd+QNJgw
	d7wSVn0ACCjufS69csn5h/NOdEkjtN+Uhfrd/3U6Chf5kkbfnTes13LKqZMWVxfSm4ug=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAE-0008GS-0s
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:14 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 18/24] wifi: mt76: mt7996: prepare mt7996_mcu_set_timing for MLO support
Date: Thu,  2 Jan 2025 17:35:02 +0100
Message-ID: <20250102163508.52945-18-nbd@nbd.name>
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

Pass in struct ieee80211_bss_conf in order to use link specific data.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a1f1dee56dea..95d915045cf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -643,7 +643,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-			mt7996_mcu_set_timing(phy, vif);
+			mt7996_mcu_set_timing(phy, vif, info);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e694edf4fa9b..e9d449bd55ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1108,13 +1108,14 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
-int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif)
+int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link_conf)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = phy->dev;
+	struct mt76_vif_link *mlink = mt76_vif_conf_link(&dev->mt76, vif, link_conf);
 	struct sk_buff *skb;
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76,
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, mlink,
 					 MT7996_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 2b5c7cb7e817..604b67ea12e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -562,7 +562,8 @@ int mt7996_mcu_set_radar_th(struct mt7996_dev *dev, int index,
 			    const struct mt7996_dfs_pattern *pattern);
 int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable);
 int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val);
-int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif);
+int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link_conf);
 int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
 int mt7996_mcu_get_temperature(struct mt7996_phy *phy);
 int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state);
-- 
2.47.1


