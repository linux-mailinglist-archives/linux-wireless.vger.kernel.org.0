Return-Path: <linux-wireless+bounces-26990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C18B434C7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769A85656E9
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E862BE059;
	Thu,  4 Sep 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2PEC7P7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FA32F775
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972636; cv=none; b=JMLsj/+48aqj00jUE0KN9vavKs5IrRL2df98SLTihzPKDIYMP2BfA3cygf3NXtQfBTcAFA8uYr7yFEtUH6h9zh1yqbbLJIGZpoPs+nqQh7JFRzPFW5m3LLzB/rDh5klDemaCTQrtgGu6mARZI44oDKe8IayCaMjTavD5Oyu8cs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972636; c=relaxed/simple;
	bh=nH1eMkt9+F83fYnXjSaQxEn/zpIxbfy/fTkLBMIxBic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fyrbLxSXhbVg1FHes87IQMc1uuCHQyAfyqolFYORXBSVQAY31C2sLDEiwdQgdPz+WOGl2guNB0MGhlcMWPnKu0xnAjsWtvjItzfkQrf4+flZhXESg6Nv7dAVusDryMRHDSiX32D7VCPNZ4S0t4ai+wepX4hPHlUySDygjKB9Ajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2PEC7P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6AEC4CEF0;
	Thu,  4 Sep 2025 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972635;
	bh=nH1eMkt9+F83fYnXjSaQxEn/zpIxbfy/fTkLBMIxBic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F2PEC7P7PfI5B1Dttu09Dy3C+hMeE9l9PrulUsn+Yqs4HUe1VQaXNcOjTPXvZcIev
	 vQq75jfjCk8hq8czRGbCcsHt0p730fKi7KOEJjYkrmY1+8Az9+hbMQwiBr+qOCGpQH
	 FUg+LBDYS0UyNuO86PzMFzj/S06EEFvDNBPbY/VDYBIXJR+tjvdrho4pMMewWYhgFS
	 9kzhaWAQMzFdWEViVCa92gdXPuvgApcTOD4euW8AVDEeXW8A0Afxi9HAfdkRQFaw+q
	 pZ99Le7B5gGJBoELZot/b8+J85xp2lru3lQlVtVI7FZVnNpnsJbPmGhvFLxpIPJpD8
	 03yEUhmaupDMA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 09:56:39 +0200
Subject: [PATCH mt76 1/4] wifi: mt76: mt7996: Fix
 mt7996_reverse_frag0_hdr_trans for MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-mlo-more-fixes-v1-1-89d8fed67f20@kernel.org>
References: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
In-Reply-To: <20250904-mt7996-mlo-more-fixes-v1-0-89d8fed67f20@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Update mt7996_reverse_frag0_hdr_trans routine to support MLO.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c525fe68897d5ba5412dabb8c1341a5ce55205d8..646c6f2f72918bbbdceddb5321c862f326d803b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -229,7 +229,9 @@ static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct ethhdr *eth_hdr = (struct ethhdr *)(skb->data + hdr_gap);
-	struct mt7996_sta *msta = (struct mt7996_sta *)status->wcid;
+	struct mt7996_sta_link *msta_link = (void *)status->wcid;
+	struct mt7996_sta *msta = msta_link->sta;
+	struct ieee80211_bss_conf *link_conf;
 	__le32 *rxd = (__le32 *)skb->data;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
@@ -246,8 +248,11 @@ static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	if (!msta || !msta->vif)
 		return -EINVAL;
 
-	sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	sta = wcid_to_sta(status->wcid);
 	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+	link_conf = rcu_dereference(vif->link_conf[msta_link->wcid.link_id]);
+	if (!link_conf)
+		return -EINVAL;
 
 	/* store the info from RXD and ethhdr to avoid being overridden */
 	frame_control = le32_get_bits(rxd[8], MT_RXD8_FRAME_CONTROL);
@@ -260,7 +265,7 @@ static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	switch (frame_control & (IEEE80211_FCTL_TODS |
 				 IEEE80211_FCTL_FROMDS)) {
 	case 0:
-		ether_addr_copy(hdr.addr3, vif->bss_conf.bssid);
+		ether_addr_copy(hdr.addr3, link_conf->bssid);
 		break;
 	case IEEE80211_FCTL_FROMDS:
 		ether_addr_copy(hdr.addr3, eth_hdr->h_source);

-- 
2.50.1


