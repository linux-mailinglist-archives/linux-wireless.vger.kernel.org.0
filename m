Return-Path: <linux-wireless+bounces-20232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB670A5DB29
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CF176F43
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486E22E011;
	Wed, 12 Mar 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNK+dRsG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489C22DFB5
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778057; cv=none; b=JX/evZaHnhUrXMm4VwpqSj6DqhEq8z6Lc4RUDuNixwMILkkZ8UxaYB95QRM1WTctyZRQxXFpEEMtJT36W4CX3IRmfY2FYHuNHo0aU5IAWaZWlAYkhfWi23tG0RE46K0Ema2VGNhOvOYbz5lOFqMds6e+yaGnFq7dbsY16HhWbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778057; c=relaxed/simple;
	bh=/x3wzMFh/aAQSrh9GQyvDMBbUMhJalBSiaTbjau5OB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbqpWWPD3ywKEdyIq3P7a+wc2rT/P2AFxncaBeUEI33Em8S57ZrgdvJx2RHl2n0IiwGKhH+DuHxcunptVqkerBYgsacz6jCzEalujPwnJNUaHqBTTKj2hakPth1L+Gpu6Od7KC4aJuFvO9RnKOqP6Lqp8k5WTSnSKINv83r19Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNK+dRsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE04C4CEE3;
	Wed, 12 Mar 2025 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778056;
	bh=/x3wzMFh/aAQSrh9GQyvDMBbUMhJalBSiaTbjau5OB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SNK+dRsGd8967b7lHWF3nG9KTtKxsL9Nj5zDeNjfselbC4eh5E/ApH8d9qBn4gGrN
	 LbPruumpPzpkOtVndvTh2a3KMKqICq1Vw9hbQ11F4uoEtd+fdfHWDTy8SaC/ABO2fy
	 1cJJav6I2QOhLz60efOQmxTm02qazwmtbK14LCMnNDVT+ZNyBzo5GxigeiSJ9f6SqE
	 qM0TPTZpfTd6S2oKguuZQFfBXvObiAz8AG3Eu1VNcElGmd/lZQOBWMzLtXfC+mRfLY
	 k0P2zogdIHcN1/Pt0efamcyLkWKkO054QTUcqyJ/TXFD+axBNt6DWnj1V2BM7sMwv6
	 /AvPcYORcaiWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:50 +0100
Subject: [PATCH 06/21] wifi: mt76: mt7996: rework mt7996_rx_get_wcid to
 support MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-6-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

The wcid idx and band idx in the TXS are sometimes mismatched since the
FW will select a transmission link according to a private algorithm.
That is, the wcid idx in the TXS would be the one registered by the
driver rather than the actual wcid idx used during transmission.
However, the band idx in the TXS is the band select for transmission.
Therefore, we should get the driver-registered wcid in order
to notify the driver the packet has been acked; otherwise,
the driver will be unable to match the transmitted packet and its TXS.
This is a preliminary patch to enable MLO for MT7996 driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 33 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9f8436edc81377d852dd4e7221575c7e1255187c..b8d88fdee97a3567b57a20d0322859b7ae8ce88a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -53,29 +53,48 @@ static const struct mt7996_dfs_radar_spec jp_radar_specs = {
 };
 
 static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
-					    u16 idx, bool unicast)
+					    u16 idx, u8 band_idx)
 {
 	struct mt7996_sta_link *msta_link;
 	struct mt7996_sta *msta;
+	struct mt7996_vif *mvif;
 	struct mt76_wcid *wcid;
+	int i;
 
 	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
 		return NULL;
 
 	wcid = rcu_dereference(dev->mt76.wcid[idx]);
-	if (unicast || !wcid)
-		return wcid;
+	if (!wcid)
+		return NULL;
 
-	if (!wcid->sta)
+	if (!mt7996_band_valid(dev, band_idx))
 		return NULL;
 
+	if (wcid->phy_idx == band_idx)
+		return wcid;
+
 	msta_link = container_of(wcid, struct mt7996_sta_link, wcid);
 	msta = msta_link->sta;
-
 	if (!msta || !msta->vif)
 		return NULL;
 
-	return &msta->vif->deflink.msta_link.wcid;
+	mvif = msta->vif;
+	for (i = 0; i < ARRAY_SIZE(mvif->mt76.link); i++) {
+		struct mt76_vif_link *mlink;
+
+		mlink = rcu_dereference(mvif->mt76.link[i]);
+		if (!mlink)
+			continue;
+
+		if (mlink->band_idx != band_idx)
+			continue;
+
+		msta_link = rcu_dereference(msta->link[i]);
+		break;
+	}
+
+	return &msta_link->wcid;
 }
 
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask)
@@ -483,7 +502,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
-	status->wcid = mt7996_rx_get_wcid(dev, idx, unicast);
+	status->wcid = mt7996_rx_get_wcid(dev, idx, band_idx);
 
 	if (status->wcid) {
 		struct mt7996_sta_link *msta_link;

-- 
2.48.1


