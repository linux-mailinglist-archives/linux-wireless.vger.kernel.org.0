Return-Path: <linux-wireless+bounces-25173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739EAAFFC2D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 10:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC7E5A6999
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0C28C5B0;
	Thu, 10 Jul 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXpVEzP6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11228C5AF
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135997; cv=none; b=RZ1p6qxa63+ZCRwYC1BUBVuLVB3tYKmZm3uZ5CXQ1PQ+bkrAjltxydRZEYgLdJ745Be1CLW+7tvqtB791oWtqmBnF8yt/NvGC1grrJe5ZVQMoqy3ocZCvS7WXTf123lM6L82Gn+Yo5S1Ary1xl2+r0I1NMZcOSF0q25CjlU/rKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135997; c=relaxed/simple;
	bh=TK8f+x9z0S53lsJYOCmb+NOw7ZrgNPDi840QxYH9YA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KfXAJHC0BAeyL8hiTyfb/6XVOkmSVcTkDqstWKym5Z7hWfs+1D8l3kpKlYhG/LecyRqhobAx+XIRofrUHtL2+jGYG3G02ZrNlBdJTJrpcHmSfUmlUXqEpDTBSKbx7HM1vztJPrpNNsziS1tCY8Pl/TFX290o51WtJS/KpWa5miM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXpVEzP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB702C4CEE3;
	Thu, 10 Jul 2025 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135996;
	bh=TK8f+x9z0S53lsJYOCmb+NOw7ZrgNPDi840QxYH9YA4=;
	h=From:Date:Subject:To:Cc:From;
	b=KXpVEzP6hXS6kj7opJHrauBUisSMM9bRMJSC4kCPytimA3WyexB5a1IHacsP5HNsf
	 booHHtJhW6o+bXFdMMNmDcyRskJfgSzk1P1zbtYilHuMZ/D0NgSfgfIspffRXfPlZl
	 HtWpQXI3zbSSSFJwKOCXaM4rYFPhq/cTYfw9nT3U3TRd0hFXqA1/A8VDms491mrWN7
	 5IYuI0urUlQEaEGAeW3DCA7PNrFVFbwnlA0XHuLbtlfK0EZgjY+u/YiPHOYnEKUevo
	 dO6H2OItbQe+03RVjAiVnnzZ+liE4o9PyMB8dSWwg4NhYtbRVnAaHNMZz875Y42gpH
	 uF9NjvYLGfzUQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 10 Jul 2025 10:26:19 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Fix mt7996_mcu_bss_mld_tlv
 routine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mt7996-mlo-fixes-v3-v1-1-e7595b089f2c@kernel.org>
X-B4-Tracking: v=1; b=H4sIACp5b2gC/x3LSwqAMAwA0atI1gZaRdt6FXHhJ2rAqrRSBPHuB
 pePYR6IFJgiNNkDgRJHPnaBzjMY135fCHkSQ6GKShmt0F/GuRr9duDMN0VMJdrK2dEO5GbSIOc
 Z6G8ytt37frFcVANlAAAA
X-Change-ID: 20250710-mt7996-mlo-fixes-v3-8598c8be9fe1
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: MeiChia Chiu <meichia.chiu@mediatek.com>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, linux-wireless@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Bo Jiao <Bo.Jiao@mediatek.com>
X-Mailer: b4 0.14.2

Update mt7996_mcu_bss_mld_tlv routine to properly support MLO
configuring the BSS.

Fixes: 98686cd21624c ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 42 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 26 ++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  8 +++++
 4 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f846b8309ae2e9c39f9d5f2a21ca1edd89dcdf0c..f2880df17a41c2751f38a666a6bb767aa5008020 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -138,6 +138,28 @@ static int get_omac_idx(enum nl80211_iftype type, u64 mask)
 	return -1;
 }
 
+static int get_own_mld_idx(u64 mask, bool group_mld)
+{
+	u8 start = group_mld ? 0 : 16;
+	u8 end = group_mld ? 15 : 63;
+	int idx;
+
+	idx = get_free_idx(mask, start, end);
+	if (idx)
+		return idx - 1;
+
+	/* If the 16-63 range is not available, perform another lookup in the
+	 * range 0-15
+	 */
+	if (!group_mld) {
+		idx = get_free_idx(mask, 0, 15);
+		if (idx)
+			return idx - 1;
+	}
+
+	return -EINVAL;
+}
+
 static void
 mt7996_init_bitrate_mask(struct ieee80211_vif *vif, struct mt7996_vif_link *mlink)
 {
@@ -289,6 +311,15 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
+	if (!dev->mld_idx_mask) { /* first link in the group */
+		mvif->mld_group_idx = get_own_mld_idx(dev->mld_idx_mask, true);
+		mvif->mld_remap_idx = get_free_idx(dev->mld_remap_idx_mask,
+						   0, 15);
+	}
+	link->mld_idx = get_own_mld_idx(dev->mld_idx_mask, false);
+	if (link->mld_idx < 0)
+		return -ENOSPC;
+
 	link->phy = phy;
 	mlink->omac_idx = idx;
 	mlink->band_idx = band_idx;
@@ -301,6 +332,11 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		return ret;
 
 	dev->mt76.vif_mask |= BIT_ULL(mlink->idx);
+	if (!dev->mld_idx_mask) {
+		dev->mld_idx_mask |= BIT_ULL(mvif->mld_group_idx);
+		dev->mld_remap_idx_mask |= BIT_ULL(mvif->mld_remap_idx);
+	}
+	dev->mld_idx_mask |= BIT_ULL(link->mld_idx);
 	phy->omac_mask |= BIT_ULL(mlink->omac_idx);
 
 	idx = MT7996_WTBL_RESERVED - mlink->idx;
@@ -380,7 +416,13 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	}
 
 	dev->mt76.vif_mask &= ~BIT_ULL(mlink->idx);
+	dev->mld_idx_mask &= ~BIT_ULL(link->mld_idx);
 	phy->omac_mask &= ~BIT_ULL(mlink->omac_idx);
+	if (!(dev->mld_idx_mask & ~BIT_ULL(mvif->mld_group_idx))) {
+		/* last link */
+		dev->mld_idx_mask &= ~BIT_ULL(mvif->mld_group_idx);
+		dev->mld_remap_idx_mask &= ~BIT_ULL(mvif->mld_remap_idx);
+	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta_link->wcid.poll_list))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 0374872db4777cc85eed594f7d977dd822927b6d..5f8701753bcad5b42ca9a0c80fbcda15d4d5f092 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -902,17 +902,28 @@ mt7996_mcu_bss_txcmd_tlv(struct sk_buff *skb, bool en)
 }
 
 static void
-mt7996_mcu_bss_mld_tlv(struct sk_buff *skb, struct mt76_vif_link *mlink)
+mt7996_mcu_bss_mld_tlv(struct sk_buff *skb,
+		       struct ieee80211_bss_conf *link_conf,
+		       struct mt7996_vif_link *link)
 {
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct bss_mld_tlv *mld;
 	struct tlv *tlv;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_MLD, sizeof(*mld));
-
 	mld = (struct bss_mld_tlv *)tlv;
-	mld->group_mld_id = 0xff;
-	mld->own_mld_id = mlink->idx;
-	mld->remap_idx = 0xff;
+	mld->own_mld_id = link->mld_idx;
+	mld->link_id = link_conf->link_id;
+
+	if (ieee80211_vif_is_mld(vif)) {
+		mld->group_mld_id = mvif->mld_group_idx;
+		mld->remap_idx = mvif->mld_remap_idx;
+		memcpy(mld->mac_addr, vif->addr, ETH_ALEN);
+	} else {
+		mld->group_mld_id = 0xff;
+		mld->remap_idx = 0xff;
+	}
 }
 
 static void
@@ -1111,6 +1122,8 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 		goto out;
 
 	if (enable) {
+		struct mt7996_vif_link *link;
+
 		mt7996_mcu_bss_rfch_tlv(skb, phy);
 		mt7996_mcu_bss_bmc_tlv(skb, mlink, phy);
 		mt7996_mcu_bss_ra_tlv(skb, phy);
@@ -1121,7 +1134,8 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			mt7996_mcu_bss_he_tlv(skb, vif, link_conf, phy);
 
 		/* this tag is necessary no matter if the vif is MLD */
-		mt7996_mcu_bss_mld_tlv(skb, mlink);
+		link = container_of(mlink, struct mt7996_vif_link, mt76);
+		mt7996_mcu_bss_mld_tlv(skb, link_conf, link);
 	}
 
 	mt7996_mcu_bss_mbssid_tlv(skb, link_conf, enable);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 130ea95626d5b1aacf748d572c62307f19681851..7b21d6ae7e43505cb824e00f8b55b0add015a5e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -481,7 +481,8 @@ struct bss_mld_tlv {
 	u8 own_mld_id;
 	u8 mac_addr[ETH_ALEN];
 	u8 remap_idx;
-	u8 __rsv[3];
+	u8 link_id;
+	u8 __rsv[2];
 } __packed;
 
 struct sta_rec_ht_uni {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 1ad6bc046f7c01d43452252ed46677d42e0c8850..edab23f82a761fad6b7e55543860ed2f6c2873d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -248,11 +248,16 @@ struct mt7996_vif_link {
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 	struct cfg80211_bitrate_mask bitrate_mask;
+
+	u8 mld_idx;
 };
 
 struct mt7996_vif {
 	struct mt7996_vif_link deflink; /* must be first */
 	struct mt76_vif_data mt76;
+
+	u8 mld_group_idx;
+	u8 mld_remap_idx;
 };
 
 /* crash-dump */
@@ -337,6 +342,9 @@ struct mt7996_dev {
 	u32 q_int_mask[MT7996_MAX_QUEUE];
 	u32 q_wfdma_mask;
 
+	u64 mld_idx_mask;
+	u64 mld_remap_idx_mask;
+
 	const struct mt76_bus_ops *bus_ops;
 	struct mt7996_phy phy;
 

---
base-commit: e553ac0d7616d6bcd06ed0c5f6126ce83097b31a
change-id: 20250710-mt7996-mlo-fixes-v3-8598c8be9fe1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


