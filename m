Return-Path: <linux-wireless+bounces-24827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2E8AF93AF
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768AC1882DAE
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E872F85FB;
	Fri,  4 Jul 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awkigmuy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243E2F7D00
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634527; cv=none; b=norqLZEqxB4hw+wB32Waqn9mhAZ2OpholI17Fu5g0hPdkcEpxAtj3oz4S/aaFluLOG82NunSIJBEHjuP3xLcVr4RTW3I7+/onl3X7c1wi1IPWalTXfOlLoUXA3G8I7pEgQVxjo1IxkzzQmdYaUVcgyHuR4uL78HcF7UtuS44BV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634527; c=relaxed/simple;
	bh=39hY2F0ott1qjBh2ftxiTYkWDUh3jwxaH6fQRoh6TII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMYthD9mCj8PuGDRl5xHiD7odkzW0tpv79EDCrb9nx0u2fMWG8lIwCsuK0kO6uvzffiPnkIWUHlh0wP+664rBv8zc8IJDXozVgRxXrFxNcFqDCbf1LTdv8grQvKWz128+mQZtX8aeK3Hy79QRywGg14Yk6PbmZ+m35BEH1QY1PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awkigmuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA45C4CEEB;
	Fri,  4 Jul 2025 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634525;
	bh=39hY2F0ott1qjBh2ftxiTYkWDUh3jwxaH6fQRoh6TII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Awkigmuyabfa7AhvWadxvI8cdtn0u2/2dltpr/froiwIlRJKztJsVFl2yhOiPg0kh
	 AyVWRSUQH0bObs3nh39VTp1TB/T8XzZuapKeA/vHiiqTMnidxskR5XaYXYco+dwChg
	 Z0T98o1ZpFK7LXdWwuTOLg9BvmIrgLMTbptWhXPY+hBpfLNizVpcZqK3E658A0KuLg
	 5LqBlOZa6ZM2Sgqfpx0f65WxVPbAL6AmbYOonw3advGHdtBGD+g69wlUUyXteHfvxu
	 1A2RNG9Vw60jyjgU6fhcpRXSVHN6JRv2OuxB9w3MKZYh1DUxSHVIBlFdQQAEQJyFwx
	 BD2uZ40/0KnhA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:12 +0200
Subject: [PATCH mt76 8/9] wifi: mt76: mt7996: Add MLO support to
 mt7996_tx_check_aggr()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-8-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Generalize mt7996_tx_check_aggr() and mt7996_txwi_free() routines to
introduce MLO support for MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 44 ++++++++++++-------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0844f27b8458fe53c0765ece70fe91acdfc6510a..02e10d744feb45048401ef15e74c3e03b53b5e08 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1129,15 +1129,14 @@ u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
 }
 
 static void
-mt7996_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
+mt7996_tx_check_aggr(struct ieee80211_link_sta *link_sta,
+		     struct mt76_wcid *wcid, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt7996_sta_link *msta_link;
-	struct mt7996_sta *msta;
 	u16 fc, tid;
 
-	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+	if (!(link_sta->ht_cap.ht_supported || link_sta->he_cap.has_he))
 		return;
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
@@ -1146,7 +1145,8 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
 
 	if (is_8023) {
 		fc = IEEE80211_FTYPE_DATA |
-		     (sta->wme ? IEEE80211_STYPE_QOS_DATA : IEEE80211_STYPE_DATA);
+		     (link_sta->sta->wme ? IEEE80211_STYPE_QOS_DATA
+					 : IEEE80211_STYPE_DATA);
 	} else {
 		/* No need to get precise TID for Action/Management Frame,
 		 * since it will not meet the following Frame Control
@@ -1162,19 +1162,16 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
 	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
 		return;
 
-	msta = (struct mt7996_sta *)sta->drv_priv;
-	msta_link = &msta->deflink;
-
-	if (!test_and_set_bit(tid, &msta_link->wcid.ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
+	if (!test_and_set_bit(tid, &wcid->ampdu_state))
+		ieee80211_start_tx_ba_session(link_sta->sta, tid, 0);
 }
 
 static void
 mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
-		 struct ieee80211_sta *sta, struct list_head *free_list)
+		 struct ieee80211_link_sta *link_sta,
+		 struct mt76_wcid *wcid, struct list_head *free_list)
 {
 	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_wcid *wcid;
 	__le32 *txwi;
 	u16 wcid_idx;
 
@@ -1183,12 +1180,10 @@ mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
 		goto out;
 
 	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
-	if (sta) {
-		wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (link_sta) {
 		wcid_idx = wcid->idx;
-
 		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-			mt7996_tx_check_aggr(sta, t->skb);
+			mt7996_tx_check_aggr(link_sta, wcid, t->skb);
 	} else {
 		wcid_idx = le32_get_bits(txwi[9], MT_TXD9_WLAN_IDX);
 	}
@@ -1207,8 +1202,8 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_phy *phy2 = mdev->phys[MT_BAND1];
 	struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
+	struct ieee80211_link_sta *link_sta = NULL;
 	struct mt76_txwi_cache *txwi;
-	struct ieee80211_sta *sta = NULL;
 	struct mt76_wcid *wcid = NULL;
 	LIST_HEAD(free_list);
 	struct sk_buff *skb, *tmp;
@@ -1245,7 +1240,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		 */
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TXFREE_INFO_PAIR) {
-			struct mt7996_sta_link *msta_link;
+			struct ieee80211_sta *sta;
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
@@ -1254,9 +1249,11 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			if (!sta)
 				goto next;
 
-			msta_link = container_of(wcid, struct mt7996_sta_link,
-						 wcid);
-			mt76_wcid_add_poll(&dev->mt76, &msta_link->wcid);
+			link_sta = rcu_dereference(sta->link[wcid->link_id]);
+			if (!link_sta)
+				goto next;
+
+			mt76_wcid_add_poll(&dev->mt76, wcid);
 next:
 			/* ver 7 has a new DW with pair = 1, skip it */
 			if (ver == 7 && ((void *)(cur_info + 1) < end) &&
@@ -1289,7 +1286,8 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			if (!txwi)
 				continue;
 
-			mt7996_txwi_free(dev, txwi, sta, &free_list);
+			mt7996_txwi_free(dev, txwi, link_sta, wcid,
+					 &free_list);
 		}
 	}
 
@@ -1748,7 +1746,7 @@ void mt7996_tx_token_put(struct mt7996_dev *dev)
 
 	spin_lock_bh(&dev->mt76.token_lock);
 	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7996_txwi_free(dev, txwi, NULL, NULL);
+		mt7996_txwi_free(dev, txwi, NULL, NULL, NULL);
 		dev->mt76.token_count--;
 	}
 	spin_unlock_bh(&dev->mt76.token_lock);

-- 
2.50.0


