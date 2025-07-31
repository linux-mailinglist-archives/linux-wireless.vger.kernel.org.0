Return-Path: <linux-wireless+bounces-26064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA3B16FBA
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68E916B6A6
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557920AF9C;
	Thu, 31 Jul 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7I95YL6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634618D643
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958511; cv=none; b=sP1SL5a/LOagBnvsLhuGaCci3NioeWXCWCyUU932HQIuxx17flfu+aQVF01YOPLWV3gCCKYwT5Q3new7xpCcFuc2nGuOeguTpiMKAJEnW6uX+RvO3QcBAnlxU2r1XvoFJ7VnIhEUbfFiYCeDGAZPnuJJTVOPfnh9vNVpXOKj4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958511; c=relaxed/simple;
	bh=Zv9B1BZcj1iBDiQ4v2rREb+WvVu5FDMKWGif82SnQKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYU7U+K/PcbqymUGkolrDi5OabjgfHnXbSs1RHQ+UI7Ji8pmYayqYX5E+LHU4Yfzxx/DbgO5me/yNrCmkma5br6dP21NReHLY7bamzSDhmzU+7y+xSDBdSY+FqbWy1o66NogUiRceGdqj84UfFKGF/unkcreKR7ziALt/LxwcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7I95YL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EFFC4CEEF;
	Thu, 31 Jul 2025 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753958510;
	bh=Zv9B1BZcj1iBDiQ4v2rREb+WvVu5FDMKWGif82SnQKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p7I95YL6cC6m65vfvHBDENenBKmvl3aM1tKl2HjcRjgto6795iom4/kctdssoKPVC
	 RSKeMOjkswPBnVBY76m/A+ILgKsFNVXlZX/Q3+/bI1P5SRit0dmNqsqjR9HoVgNfdj
	 1yyCvehGEA71nfzdC3WRTCyvNsd2/UqthL5Fh7+yT2P8iiWC/Ymsz6wIqbG7Lb3mWi
	 Zqn0G975em3y8ZTKbP23O4Ve4RaoqY0WO1ht6fZaq0OZhwvmV0Q99dpOzMQbmPPKpA
	 9LSDIui1VpAClUWoecT9vLgPprsdnxMDo1RyLBP2sx3DxDLgiUxryz49jGNgW6ZSVa
	 4/+FcnzY26mbA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 31 Jul 2025 12:41:24 +0200
Subject: [PATCH mt76 2/2] wifi: mt76: mt7996: Set proper link destination
 address in mt7996_tx()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-mt7996-mlo-devel-v1-2-7ff4094285d0@kernel.org>
References: <20250731-mt7996-mlo-devel-v1-0-7ff4094285d0@kernel.org>
In-Reply-To: <20250731-mt7996-mlo-devel-v1-0-7ff4094285d0@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Overwrite 802.11 destination address with in-use link address for MLD
capable VIFs in mt7996_tx routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 34 ++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 662ce4bb5178a4b8765b2b337ea6baea649d3ef2..3d5ba568243b04465530ff788b7f625c9721e25d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1252,21 +1252,20 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		      struct ieee80211_tx_control *control,
 		      struct sk_buff *skb)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct ieee80211_sta *sta = control->sta;
+	struct mt7996_sta *msta = sta ? (void *)sta->drv_priv : NULL;
 	struct mt76_phy *mphy = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
+	struct mt7996_vif *mvif = vif ? (void *)vif->drv_priv : NULL;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 	u8 link_id = u32_get_bits(info->control.flags,
 				  IEEE80211_TX_CTRL_MLO_LINK);
-	struct mt7996_sta *msta;
-	struct mt7996_vif *mvif;
 
 	rcu_read_lock();
 
-	msta = control->sta ? (void *)control->sta->drv_priv : NULL;
-	mvif = vif ? (void *)vif->drv_priv : NULL;
-
 	/* Use primary link_id if the value from mac80211 is set to
 	 * IEEE80211_LINK_UNSPECIFIED.
 	 */
@@ -1277,6 +1276,31 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 			link_id = mvif->mt76.deflink_id;
 	}
 
+	if (ieee80211_vif_is_mld(vif)) {
+		struct ieee80211_bss_conf *link_conf;
+
+		if (msta) {
+			struct ieee80211_link_sta *link_sta;
+
+			link_sta = rcu_dereference(sta->link[link_id]);
+			if (!link_sta)
+				link_sta = rcu_dereference(sta->link[msta->deflink_id]);
+
+			if (link_sta) {
+				memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
+				if (ether_addr_equal(sta->addr, hdr->addr3))
+					memcpy(hdr->addr3, link_sta->addr, ETH_ALEN);
+			}
+		}
+
+		link_conf = rcu_dereference(vif->link_conf[link_id]);
+		if (link_conf) {
+			memcpy(hdr->addr2, link_conf->addr, ETH_ALEN);
+			if (ether_addr_equal(vif->addr, hdr->addr3))
+				memcpy(hdr->addr3, link_conf->addr, ETH_ALEN);
+		}
+	}
+
 	if (mvif) {
 		struct mt76_vif_link *mlink = &mvif->deflink.mt76;
 

-- 
2.50.1


