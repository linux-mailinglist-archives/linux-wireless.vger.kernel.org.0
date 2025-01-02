Return-Path: <linux-wireless+bounces-17005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025369FFBD7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109D1188372E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090519068E;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mPZCehzX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5B38F91
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835724; cv=none; b=cFkdibdmmHadyVUkRagMe7OCZpFIyuxe2vYq+WZhFef1kIt3Mob6Fk7cR31GFNq4QoXDGeowfxsZQdclUHsxR1koqr0AucTIzh5gj/AR4cNwugrkB2k0Tht4BrLPr+QPEzsv5ergrDQMoC5sZzUNbatxQA+jGtiC6UzAVC22Qzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835724; c=relaxed/simple;
	bh=1vTk87zdYIfMzFlN7aZy9U48ie2qqX3cM2rhsxMK/1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdD/uIYj/8RxdpnvYS1oLogeujOL+mShrvalCWg6pBxr7sap10UWV83cOOOmmXBIKtooyD4xeoc/I49FY8sJWdWxTwDbTwBqTZAdFtndsL/BJFeBuk8ZVWVrG1z9+yuIbMsQinOx3Wz24nopFe+bmkY7VUMtK4PY/H6dpJSgPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mPZCehzX; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MyHCHHwLkoPKDxHDoopbF85uamuUjEuoz8sburiUOsQ=; b=mPZCehzXjn0M4SB+vuEHjriC5m
	GvPsy8TCxkufXVMdCE1TEIWTA18TmoK7PFG/MteW069KuxdYd4ymzT/QszltsIv4hB9M0Tp3NN+wu
	//ysvStt63zlVXG59XKAswVgKEeIIjFEIjxmV+7sus1rzETavqj0peVWr80hSRiv8pLc=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAE-0008GS-0G
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:14 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 17/24] wifi: mt76: mt7996: prepare mt7996_mcu_set_tx for MLO support
Date: Thu,  2 Jan 2025 17:35:01 +0100
Message-ID: <20250102163508.52945-17-nbd@nbd.name>
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
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 9 +++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ae4fad290785..a1f1dee56dea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -469,7 +469,8 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       unsigned int link_id, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_vif_link *mlink = mt7996_vif_link(dev, vif, link_id);
 	static const u8 mq_to_aci[] = {
 		[IEEE80211_AC_VO] = 3,
 		[IEEE80211_AC_VI] = 2,
@@ -478,7 +479,7 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 
 	/* firmware uses access class index */
-	mvif->deflink.queue_params[mq_to_aci[queue]] = *params;
+	mlink->queue_params[mq_to_aci[queue]] = *params;
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
 
 	return 0;
@@ -656,7 +657,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 
 	/* ensure that enable txcmd_mode after bss_info */
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
-		mt7996_mcu_set_tx(dev, vif);
+		mt7996_mcu_set_tx(dev, vif, info);
 
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
 		mt7996_mcu_add_obss_spr(phy, vif, &info->he_obss_pd);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index a66ccc2512af..e694edf4fa9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3145,7 +3145,8 @@ int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans)
 				     MCU_WM_UNI_CMD(RX_HDR_TRANS), true);
 }
 
-int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
+int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		      struct ieee80211_bss_conf *link_conf)
 {
 #define MCU_EDCA_AC_PARAM	0
 #define WMM_AIFS_SET		BIT(0)
@@ -3154,12 +3155,12 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
 #define WMM_TXOP_SET		BIT(3)
 #define WMM_PARAM_SET		(WMM_AIFS_SET | WMM_CW_MIN_SET | \
 				 WMM_CW_MAX_SET | WMM_TXOP_SET)
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_vif_link *link = mt7996_vif_conf_link(dev, vif, link_conf);
 	struct {
 		u8 bss_idx;
 		u8 __rsv[3];
 	} __packed hdr = {
-		.bss_idx = mvif->deflink.mt76.idx,
+		.bss_idx = link->mt76.idx,
 	};
 	struct sk_buff *skb;
 	int len = sizeof(hdr) + IEEE80211_NUM_ACS * sizeof(struct edca);
@@ -3172,7 +3173,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
 	skb_put_data(skb, &hdr, sizeof(hdr));
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct ieee80211_tx_queue_params *q = &mvif->deflink.queue_params[ac];
+		struct ieee80211_tx_queue_params *q = &link->queue_params[ac];
 		struct edca *e;
 		struct tlv *tlv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7b12b1f8898b..2b5c7cb7e817 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -543,7 +543,8 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta, bool changed);
 int mt7996_set_channel(struct mt76_phy *mphy);
 int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
-int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif);
+int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		      struct ieee80211_bss_conf *link_conf);
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version);
 int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-- 
2.47.1


