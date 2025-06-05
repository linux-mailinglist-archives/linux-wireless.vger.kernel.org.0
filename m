Return-Path: <linux-wireless+bounces-23760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F4AACEE6C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A97178314
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F51B0F17;
	Thu,  5 Jun 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JigQayQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE23C465
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122314; cv=none; b=VulOJgJlLT3LufLzSMMZdUtfJkLfWw8fxnqV0u2iyMs0VZrs+X1JfU7uUUv3jED217Wph9vHVi38YTnIrS4yNh/gGJ4c5FGPAuNTAttWmZOnsRV0P8vur6Mlx9IwrKoTWfOUjE95R8REZLi5w50dZ2mEYqdViyDqXqs4i1oUIhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122314; c=relaxed/simple;
	bh=KcQumna6h2x+9rO/0vXE9bDt2GkL03POAiZICd71E6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0bbirbRsWt+pgJvcoPn1A6Q75dPSU7aR2SJjyHVAjOP1phH87JL4wssEDQYpuKhQz8PHCz9AWg4I2JDosnbrTtXIKUfRYp/K7nYKGsvsV3fxsaohFxwBdFj0UYMUm6q1YNEwUA/p840/GbIDQo8Q6skXbkB07x+nS7XyC8ZWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JigQayQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B409AC4CEEB;
	Thu,  5 Jun 2025 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122314;
	bh=KcQumna6h2x+9rO/0vXE9bDt2GkL03POAiZICd71E6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JigQayQP+k+6dF4dKOQFKMLhceMkigMy/i0s/hnvZ9G3ioPd+v8zG0trBFo66A6Mi
	 Jyt5egnjzrpsALGwx1c8yN7JA64xR4JEM9QUJgwc1q92qdfDf+7v1AyZd0a9FkHVwI
	 cKf/CQi9vwy/03VYBm/DuOZ8DCQ5VlmxegFf8338SUJKTAfzYNGLilVuah4Qn8unWd
	 MKlBPkE6G8KEH73k2K0eqC09hroH68BDbBgl026S8D/w3BY4Jc6QofoYVvOjeX+THj
	 0uI6o56D5qWx0aJDtJzaxX8dn3m3WWQ2PAwd5AcxREU/Ij9v/TQclPJ5OMIHiO1o5K
	 js9c/EvWbA25g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 05 Jun 2025 13:14:19 +0200
Subject: [PATCH mt76 4/5] wifi: mt76: Move RCU section in
 mt7996_mcu_add_rate_ctrl()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-mt7996-sleep-while-atomic-v1-4-d46d15f9203c@kernel.org>
References: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
In-Reply-To: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Greear <greearb@candelatech.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Since mt76_mcu_skb_send_msg() routine can't be executed in atomic context,
move RCU section in mt7996_mcu_add_rate_ctrl() and execute
mt76_mcu_skb_send_msg() in non-atomic context. This is a preliminary
patch to fix a 'sleep while atomic' issue in mt7996_mac_sta_rc_work().

Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  6 +--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 50 +++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 10 ++---
 4 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 7444bd374b50bdfdcf7e1973993f496b740a1c51..5561b1098e3fb0d25551fde3cfdb3057217395fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2403,8 +2403,7 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
 			       IEEE80211_RC_NSS_CHANGED |
 			       IEEE80211_RC_BW_CHANGED))
-			mt7996_mcu_add_rate_ctrl(dev, vif, link_conf,
-						 link_sta, link, msta_link,
+			mt7996_mcu_add_rate_ctrl(dev, msta_link->sta, vif,
 						 link_id, true);
 
 		if (changed & IEEE80211_RC_SMPS_CHANGED)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a096b5bab001de8d4fe3270ab37b1a6dab702ab1..07dd75ce94a5f204dcd4d659a777151bb9fcf8d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1112,10 +1112,8 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			if (err)
 				return err;
 
-			err = mt7996_mcu_add_rate_ctrl(dev, vif, link_conf,
-						       link_sta, link,
-						       msta_link, link_id,
-						       false);
+			err = mt7996_mcu_add_rate_ctrl(dev, msta_link->sta, vif,
+						       link_id, false);
 			if (err)
 				return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 742497ba2a6bcd73e3660e626e4a756d79a467bf..77ab1f4854a43643c296f6ed28c08da99bfdcb04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2201,23 +2201,44 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 	memset(ra->rx_rcpi, INIT_RCPI, sizeof(ra->rx_rcpi));
 }
 
-int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_bss_conf *link_conf,
-			     struct ieee80211_link_sta *link_sta,
-			     struct mt7996_vif_link *link,
-			     struct mt7996_sta_link *msta_link,
-			     u8 link_id, bool changed)
+int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct mt7996_sta *msta,
+			     struct ieee80211_vif *vif, u8 link_id,
+			     bool changed)
 {
-	struct mt7996_sta *msta = msta_link->sta;
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_link_sta *link_sta;
+	struct mt7996_sta_link *msta_link;
+	struct mt7996_vif_link *link;
+	struct ieee80211_sta *sta;
 	struct sk_buff *skb;
-	int ret;
+	int ret = -ENODEV;
+
+	rcu_read_lock();
+
+	link = mt7996_vif_link(dev, vif, link_id);
+	if (!link)
+		goto error_unlock;
+
+	msta_link = rcu_dereference(msta->link[link_id]);
+	if (!msta_link)
+		goto error_unlock;
+
+	sta = wcid_to_sta(&msta_link->wcid);
+	link_sta = rcu_dereference(sta->link[link_id]);
+	if (!link_sta)
+		goto error_unlock;
+
+	link_conf = rcu_dereference(vif->link_conf[link_id]);
+	if (!link_conf)
+		goto error_unlock;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
 					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		goto error_unlock;
+	}
 
 	/* firmware rc algorithm refers to sta_rec_he for HE control.
 	 * once dev->rc_work changes the settings driver should also
@@ -2231,12 +2252,19 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
 	 */
 	mt7996_mcu_sta_rate_ctrl_tlv(skb, dev, vif, link_conf, link_sta, link);
 
+	rcu_read_unlock();
+
 	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				    MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 	if (ret)
 		return ret;
 
 	return mt7996_mcu_add_rate_ctrl_fixed(dev, msta, vif, link_id);
+
+error_unlock:
+	rcu_read_unlock();
+
+	return ret;
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index a529c2bae7cbf83589650c593f033e6ec5e714a8..33ac16b64ef113eff3f7749963e34a49b3c67ac3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -620,13 +620,9 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy,
 			    struct mt7996_vif_link *link,
 			    struct ieee80211_he_obss_pd *he_obss_pd);
-int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev,
-			     struct ieee80211_vif *vif,
-			     struct ieee80211_bss_conf *link_conf,
-			     struct ieee80211_link_sta *link_sta,
-			     struct mt7996_vif_link *link,
-			     struct mt7996_sta_link *msta_link,
-			     u8 link_id, bool changed);
+int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct mt7996_sta *msta,
+			     struct ieee80211_vif *vif, u8 link_id,
+			     bool changed);
 int mt7996_set_channel(struct mt76_phy *mphy);
 int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif,

-- 
2.49.0


