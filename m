Return-Path: <linux-wireless+bounces-4970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B265988107B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15FB1C232C8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A213BBE7;
	Wed, 20 Mar 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e8PGsVVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6103B1B2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932973; cv=none; b=WaSiEcgQz1175GWX1w3sdfb9Q7wNm4LCA/Ul7cb18OB21tU5E1CAt60wQ4GJPhj6QJ/bTCJCKee+iieh5A0+hy2zs+IX7aymBk1YlK+A7Hb8CkH76jGxJCMoXTZnQFsJPeP2J/wCp/sKUs79iHmI2C3aMN6ak6+JNl4jFruppio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932973; c=relaxed/simple;
	bh=xAg3o3MYGemKMz5HT566q7uez7D1soD9Mwv9KDIxMdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lFCdNpuzfB/jjLZeDyCNLlBcmSULYmgIO7HtPqRvL8Wl28WaMYIBPogVSmoHFADcTgSUaozh8sIO6wx+QdrSXSxdNdIdgqMhQDfIcVG583ZEQ2rei9iXo4tkXoTqysDsbXPmDC8YDzSclGibP4IoTN7kIcZJf5cKjl27MOEpX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e8PGsVVa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f5d8fd8e6aa11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4RmRPQOxTja+Dc054BF6i570PC+NgnM2JTTvi1wznRw=;
	b=e8PGsVVao0WWpAjbsK0aBZrh8e4/F7LNyaxRK9YNfH56oH8F2woVQ7YLdY023xPSufdIpgCkU2Tcl2NuYnOdibDNYLEbrk/88iv0UwNet5daBZMr0h4fBGg/XYDsjTX9Loav7ZRatDcWBieBWAYwkqP8Ryy2fd6cLa1LduL4Kjo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:fc82f40a-d3fe-4b90-a12e-7adbefd3b086,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c205a090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f5d8fd8e6aa11eeb8927bc1f75efef4-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1787517799; Wed, 20 Mar 2024 19:09:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 19:09:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 19:09:23 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 01/10] wifi: mt76: connac: use peer address for station BMC entry
Date: Wed, 20 Mar 2024 19:09:09 +0800
Message-ID: <20240320110918.3488-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Set peer address and aid for the BMC wtbl of station interface. For some
functions such as parsing MU_EDCA parameters from beacon, firmware will
need the peer address to do correct parsing.
Without this patch, MU uplink traffic would get suffered.

Reported-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  9 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c  | 15 ++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c   |  6 +++---
 .../net/wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +-
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index af0c2b2aacb0..e6cc3a68954b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -392,7 +392,14 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 
 	if (!sta) {
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
-		eth_broadcast_addr(basic->peer_addr);
+
+		if (is_mt799x(dev) && vif->type == NL80211_IFTYPE_STATION &&
+		    !is_zero_ether_addr(vif->bss_conf.bssid)) {
+			memcpy(basic->peer_addr, vif->bss_conf.bssid, ETH_ALEN);
+			basic->aid = cpu_to_le16(vif->cfg.aid);
+		} else {
+			eth_broadcast_addr(basic->peer_addr);
+		}
 		return;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f7da8d6dd903..995c265442df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -238,7 +238,11 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mt7996_init_bitrate_mask(vif);
 
 	mt7996_mcu_add_bss_info(phy, vif, true);
-	mt7996_mcu_add_sta(dev, vif, NULL, true);
+	/* defer the first STA_REC of BMC entry to BSS_CHANGED_BSSID for STA
+	 * interface, since firmware only records BSSID when the entry is new
+	 */
+	if (vif->type != NL80211_IFTYPE_STATION)
+		mt7996_mcu_add_sta(dev, vif, NULL, true, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 
 out:
@@ -256,7 +260,7 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
-	mt7996_mcu_add_sta(dev, vif, NULL, false);
+	mt7996_mcu_add_sta(dev, vif, NULL, false, false);
 	mt7996_mcu_add_bss_info(phy, vif, false);
 
 	if (vif == phy->monitor_vif)
@@ -599,7 +603,8 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	    (changed & BSS_CHANGED_ASSOC && vif->cfg.assoc) ||
 	    (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon)) {
 		mt7996_mcu_add_bss_info(phy, vif, true);
-		mt7996_mcu_add_sta(dev, vif, NULL, true);
+		mt7996_mcu_add_sta(dev, vif, NULL, true,
+				   !!(changed & BSS_CHANGED_BSSID));
 	}
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT)
@@ -688,7 +693,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ret = mt7996_mcu_add_sta(dev, vif, sta, true);
+	ret = mt7996_mcu_add_sta(dev, vif, sta, true, true);
 	if (ret)
 		return ret;
 
@@ -702,7 +707,7 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	int i;
 
-	mt7996_mcu_add_sta(dev, vif, sta, false);
+	mt7996_mcu_add_sta(dev, vif, sta, false, false);
 
 	mt7996_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index b44abe2acc81..df6be2091615 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2133,7 +2133,7 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 }
 
 int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable)
+		       struct ieee80211_sta *sta, bool enable, bool newly)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta;
@@ -2149,8 +2149,8 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, sta, enable,
-				      !rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, sta, enable, newly);
+
 	if (!enable)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 36d1f247d55a..c30d133d9a71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -450,7 +450,7 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
 int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
 			    struct ieee80211_vif *vif, int enable);
 int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable);
+		       struct ieee80211_sta *sta, bool enable, bool newly);
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);
-- 
2.39.2


