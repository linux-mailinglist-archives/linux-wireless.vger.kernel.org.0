Return-Path: <linux-wireless+bounces-26992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3BAB434CA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9C5E8268
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CBB2BDC05;
	Thu,  4 Sep 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXBluWIy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230732F775
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972641; cv=none; b=lSHguoPEChsuBhVKXnUturmVz9nH+Uy1Cv6Ne7lk7z0ywC8+anC10bCc+mYH4ZcKQiNiFGWOGQem1N+2GjCU/Lb77gOYrmj/FoWIYUyvibiR8HBV2Rk1002BlCtqxdf6/hoB/h4ttb0DPntrYc1u6ZjvOfgjrZ7jsMdu3q9U1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972641; c=relaxed/simple;
	bh=c57YH64GVVAeKyKzS1CU5NHKdgxvqrYzn8ZtqROVA0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+sGYAZhOlfmwpAJlm90ItFd3XYYqmr5R+k4k1E1GVGCXV9tP3GBk+D773bVAiVNHbkNntJrP54S3A1HDQ0o8ZMsuCsEFM5OWWv2EbrWgmQ2kk/BDL5/LSHrpjyZRBhjLBPxHxYd/AvTywNhIJmS+z6+pLwEtPILp4/ZM6GgqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXBluWIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E98C4CEF0;
	Thu,  4 Sep 2025 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972641;
	bh=c57YH64GVVAeKyKzS1CU5NHKdgxvqrYzn8ZtqROVA0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fXBluWIykJ2uls6NGRZjd9d6LuD/afp5QlqIKv+8/dGw3zWGC1kOVlGY43OeDmc9e
	 ZSjrUHMgtoGnYrPnlgwba+5GnEZrn1Qcc7A4gBLXRcJecBO1vgyqop4TInKy4Ijeht
	 j3HYQmj/vJmSYuoWRqiqyM3c3Ti2CiEMe9074cjjgD63qWWuPpfK7hbUJxnv3sCZG2
	 OqzxWtj3+JBAWIuCQ7ILSFG5i/8iPnwRfgIaY4zVOk1wPdO1KjO3RKXA+Ik6RYog3A
	 zDg2N/Q6+G5m/IkCHgRrY2HlYQDujmIb3YRRECwSQw1bcES0ilHi1aUtiWqYZ1l7qS
	 vEr3d5K2LowYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 09:56:41 +0200
Subject: [PATCH mt76 3/4] wifi: mt76: mt7996: Implement MLD address
 translation for EAPOL
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-mlo-more-fixes-v1-3-89d8fed67f20@kernel.org>
References: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
In-Reply-To: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Do the MLD to link address translation for EAPOL frames in driver.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 32 ++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 33eb05dc5fc4826b5752fcee923213e051107074..588f4aed31eda30aa48eeb06cfcbf36a0e147682 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -962,7 +962,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	txwi[5] = cpu_to_le32(val);
 
 	val = MT_TXD6_DAS;
-	if (q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)
+	if ((q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0) ||
+	    skb->protocol == cpu_to_be16(ETH_P_PAE))
 		val |= MT_TXD6_DIS_MAT;
 
 	if (is_mt7996(&dev->mt76))
@@ -1049,6 +1050,35 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (id < 0)
 		return id;
 
+	/* Since the rules of HW MLD address translation are not fully
+	 * compatible with 802.11 EAPOL frame, we do the translation by
+	 * software
+	 */
+	if (tx_info->skb->protocol == cpu_to_be16(ETH_P_PAE) && sta->mlo) {
+		struct ieee80211_hdr *hdr = (void *)tx_info->skb->data;
+		struct ieee80211_bss_conf *link_conf;
+		struct ieee80211_link_sta *link_sta;
+
+		link_conf = rcu_dereference(vif->link_conf[wcid->link_id]);
+		if (!link_conf)
+			return -EINVAL;
+
+		link_sta = rcu_dereference(sta->link[wcid->link_id]);
+		if (!link_sta)
+			return -EINVAL;
+
+		memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
+		memcpy(hdr->addr2, link_conf->addr, ETH_ALEN);
+		if (ieee80211_has_a4(hdr->frame_control)) {
+			memcpy(hdr->addr3, sta->addr, ETH_ALEN);
+			memcpy(hdr->addr4, vif->addr, ETH_ALEN);
+		} else if (ieee80211_has_tods(hdr->frame_control)) {
+			memcpy(hdr->addr3, sta->addr, ETH_ALEN);
+		} else if (ieee80211_has_fromds(hdr->frame_control)) {
+			memcpy(hdr->addr3, vif->addr, ETH_ALEN);
+		}
+	}
+
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	memset(txwi_ptr, 0, MT_TXD_SIZE);
 	/* Transmit non qos data by 802.11 header and need to fill txd by host*/

-- 
2.50.1


