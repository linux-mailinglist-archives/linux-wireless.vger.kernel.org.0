Return-Path: <linux-wireless+bounces-28658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5780C394B0
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 07:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A86B84E271E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA062E0401;
	Thu,  6 Nov 2025 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aexuec41"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522922E06ED
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411396; cv=none; b=QJs1BBNUhYqX8yR9Sf2EzR2lcmQ40jAVAfmobDxRAdT6fOaAxsYGnBsML5ayDYkLAX9XgvTG6UAGyh42INQXw0QfPQaheBnMoS+OhTqZ07sujypSOUpbfppxwuV4cJcIhnwd+DUzBdrKFQqtZ1cNlV2iJkLlyld/oPTl2GbgDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411396; c=relaxed/simple;
	bh=ThlBaE3lbaNOks3J0iJJZHaNuxfqBavHbfI+cfobe+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHiW8Y1u36+AbqOw1COQmGy1BhwhLB8iOaRBZUf9oGOk948kYwk19D0quZKgbiKG7u3BG3r/zRg30I4vi+Mz9rhq1ZUnZpYqRpYgXETHlq8z9sNEtEzoppalmLMfsd0iytsCNkOtUMJHMBfEJ17T+lRNgWuAh0aaIe0YqzJXq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aexuec41; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6f1f61cbadb11f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3ZJcP9oh3ZcO69Repi+RoJHOKDx05XPTK07oQN78cDc=;
	b=aexuec41uQyDZVOQQfueCqqiiUUk/CLfuKO8izeit+qmSoqUsHoak8iRUH8+GSJpmvvFthc+nOWzM5ESpggpLfVbMVCTNF14ZsX6AmK5F7GutalFPxMNd0j0J/Nx0qpc0oTGOnmv0lK5USrANwmy5nxzDHT5xWiL2kC4g9f3wHk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c573d588-5420-4ddb-b9ad-9834241ec313,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:5cfdfa18-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d6f1f61cbadb11f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 49329741; Thu, 06 Nov 2025 14:43:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:43:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:43:00 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 v2 05/12] wifi: mt76: mt7996: fix several fields in mt7996_mcu_bss_basic_tlv()
Date: Thu, 6 Nov 2025 14:41:56 +0800
Message-ID: <20251106064203.1000505-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106064203.1000505-1-shayne.chen@mediatek.com>
References: <20251106064203.1000505-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Fix several fields in mt7996_mcu_bss_basic_tlv() that were not obtained
from the correct link. Without this patch, the MLD station interface
does not function properly.

Fixes: 34a41bfbcb71 ("wifi: mt76: mt7996: prepare mt7996_mcu_add_dev/bss_info for MLO support")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 82dd34a8780f..f1892aaf6a91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1037,7 +1037,6 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct mt76_connac_bss_basic_tlv *bss;
 	u32 type = CONNECTION_INFRA_AP;
 	u16 sta_wlan_idx = wlan_idx;
-	struct ieee80211_sta *sta;
 	struct tlv *tlv;
 	int idx;
 
@@ -1048,14 +1047,18 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (enable) {
+			struct ieee80211_sta *sta;
+
 			rcu_read_lock();
-			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
-			/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
+			sta = ieee80211_find_sta(vif, link_conf->bssid);
 			if (sta) {
-				struct mt76_wcid *wcid;
+				struct mt7996_sta *msta = (void *)sta->drv_priv;
+				struct mt7996_sta_link *msta_link;
+				int link_id = link_conf->link_id;
 
-				wcid = (struct mt76_wcid *)sta->drv_priv;
-				sta_wlan_idx = wcid->idx;
+				msta_link = rcu_dereference(msta->link[link_id]);
+				if (msta_link)
+					sta_wlan_idx = msta_link->wcid.idx;
 			}
 			rcu_read_unlock();
 		}
@@ -1072,8 +1075,6 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*bss));
 
 	bss = (struct mt76_connac_bss_basic_tlv *)tlv;
-	bss->bcn_interval = cpu_to_le16(link_conf->beacon_int);
-	bss->dtim_period = link_conf->dtim_period;
 	bss->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
 	bss->sta_idx = cpu_to_le16(sta_wlan_idx);
 	bss->conn_type = cpu_to_le32(type);
@@ -1093,10 +1094,10 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 
 	memcpy(bss->bssid, link_conf->bssid, ETH_ALEN);
 	bss->bcn_interval = cpu_to_le16(link_conf->beacon_int);
-	bss->dtim_period = vif->bss_conf.dtim_period;
+	bss->dtim_period = link_conf->dtim_period;
 	bss->phymode = mt76_connac_get_phy_mode(phy, vif,
 						chandef->chan->band, NULL);
-	bss->phymode_ext = mt76_connac_get_phy_mode_ext(phy, &vif->bss_conf,
+	bss->phymode_ext = mt76_connac_get_phy_mode_ext(phy, link_conf,
 							chandef->chan->band);
 
 	return 0;
-- 
2.51.0


