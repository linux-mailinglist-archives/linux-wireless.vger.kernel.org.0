Return-Path: <linux-wireless+bounces-29313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758BC83456
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4807B34CA3A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242DF288C26;
	Tue, 25 Nov 2025 03:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W8K316VD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFA27FD7C
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042455; cv=none; b=PpNqQIJ2eXgHxLOGN3t4qFxE/A5zsYgeZUk4L9YbxusYrRoZf1jMq+9q7DEIrmj8Q3cUNCeBVGoI/eS5rg4m+txVLDH7B5pFnYUMsuDEyL5jXFMbFsw2Mr7YCG4BR6kop9ibx3bud9BBTbPpjwhkGn/H3F1i4q7y8nyQhmeezlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042455; c=relaxed/simple;
	bh=HO9iZ8m7DBu3VzsVTezXz1sFaVALDlXga7iihLoNQaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akM+7xm6S1kOjVKZ+gTYQAQqVQE7ZUNFMK5UMX22panRWKGjgeVVwd1+Tl/bMox45U1CISW2CX85KMqCvjUFT8kiM0aFbTPC0qh/HKe33xeJnCDUJOhJfVi6+6bfexMxm2qfB7howWLRj/RQnXDPc4Ot0q0dGrLU5FMSwbXCFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=W8K316VD; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 74be675cc9b111f0b33aeb1e7f16c2b6-20251125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1Y/PI2A3oeyS15yxpv+6ssIPwevk/9gAcNFTpTMuK/c=;
	b=W8K316VDIzk7+45T99UMGNf897AEq4IbLuzuq6tVWKNbpK4joON6Ine4y9wV09Mf7/PVyL8hOKnQiYKT3/N+/lMPlheNpvRWr8t5QbNE6rN4QzszKVmR/wx1NMzUvZSKIYyC5vpaDpSyFPYRy4kyHlSn/LhrFG8JOGkT5UAx6JE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:daff87cf-275f-4d20-8b24-bb785bc30d65,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:66152abb-0c02-41a0-92a3-94dc7dc7eeca,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 74be675cc9b111f0b33aeb1e7f16c2b6-20251125
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1305475201; Tue, 25 Nov 2025 11:47:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 25 Nov 2025 11:47:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 25 Nov 2025 11:47:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 3/7] wifi: mt76: mt7996: set specific BSSINFO and STAREC commands after channel switch
Date: Tue, 25 Nov 2025 11:46:35 +0800
Message-ID: <20251125034639.1416214-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251125034639.1416214-1-shayne.chen@mediatek.com>
References: <20251125034639.1416214-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

After channel switch, some tags of BSSINFO (rfch) and STAREC (bfer,
rate_ctrl) commands should also be updated. Otherwise, a BSS might not be
able to transmit with its peer using correct bandwidth.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 14 ++++-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 59 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 18c6cdaae20b..afc0ca3f3939 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -962,12 +962,24 @@ mt7996_post_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_phy *phy = mt7996_band_phy(dev, chandef->chan->band);
-	int ret;
+	struct mt7996_vif_link *link;
+	int ret = -EINVAL;
 
 	mutex_lock(&dev->mt76.mutex);
 
+	link = mt7996_vif_conf_link(dev, vif, link_conf);
+	if (!link)
+		goto out;
+
+	ret = mt7996_mcu_update_bss_rfch(phy, link);
+	if (ret)
+		goto out;
+
+	ieee80211_iterate_stations_mtx(hw, mt7996_mcu_update_sta_rec_bw, link);
+
 	ret = mt7996_mcu_rdd_resume_tx(phy);
 
+out:
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index c18c809ac77a..8f2b3f4f25ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1231,6 +1231,22 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+int mt7996_mcu_update_bss_rfch(struct mt7996_phy *phy, struct mt7996_vif_link *link)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct sk_buff *skb;
+
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &link->mt76,
+					 MT7996_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7996_mcu_bss_rfch_tlv(skb, phy);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
 int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *link_conf)
 {
@@ -2590,6 +2606,49 @@ int mt7996_mcu_teardown_mld_sta(struct mt7996_dev *dev,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
 
+void mt7996_mcu_update_sta_rec_bw(void *data, struct ieee80211_sta *sta)
+{
+	struct mt7996_vif_link *link = (struct mt7996_vif_link *)data;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link;
+	struct mt7996_dev *dev;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_sta *link_sta;
+	struct ieee80211_vif *vif;
+	struct sk_buff *skb;
+	int link_id;
+
+	if (link->mt76.mvif != &msta->vif->mt76)
+		return;
+
+	dev = link->phy->dev;
+	link_id = link->msta_link.wcid.link_id;
+	link_sta = link_sta_dereference_protected(sta, link_id);
+	if (!link_sta)
+		return;
+
+	msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+	if (!msta_link)
+		return;
+
+	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+	link_conf = link_conf_dereference_protected(vif, link_id);
+	if (!link_conf)
+		return;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
+					      &msta_link->wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return;
+
+	mt7996_mcu_sta_bfer_tlv(dev, skb, link_conf, link_sta, link);
+	mt7996_mcu_sta_rate_ctrl_tlv(skb, dev, vif, link_conf, link_sta, link);
+
+	mt76_mcu_skb_send_msg(&dev->mt76, skb,
+			      MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
 static int
 mt7996_mcu_sta_key_tlv(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		       struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index d31864f973cc..8f1043159f58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -670,6 +670,8 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_bss_conf *link_conf,
 			    struct mt76_vif_link *mlink,
 			    struct mt7996_sta_link *msta_link, int enable);
+int mt7996_mcu_update_bss_rfch(struct mt7996_phy *phy,
+			       struct mt7996_vif_link *link);
 int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 		       struct ieee80211_bss_conf *link_conf,
 		       struct ieee80211_link_sta *link_sta,
@@ -679,6 +681,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 int mt7996_mcu_teardown_mld_sta(struct mt7996_dev *dev,
 				struct mt7996_vif_link *link,
 				struct mt7996_sta_link *msta_link);
+void mt7996_mcu_update_sta_rec_bw(void *data, struct ieee80211_sta *sta);
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 struct ieee80211_vif *vif, bool enable);
-- 
2.51.0


