Return-Path: <linux-wireless+bounces-28299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F3C0D20D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7B3E4F22E6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3E2F7AB5;
	Mon, 27 Oct 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="i4KoaIb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F829277009;
	Mon, 27 Oct 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564012; cv=none; b=Y7YpNWkNawzjcA8/Y5JViIdNEJmA6C5zImHv3unk04WQxZyT6Xm7BNHejh6H28VcotlnLAt2G8KqXjcWZLWKl19McX390YnhZti0efssg8qYSA+mxhLW/Xm3yoqbkSHsqx9oUu05rgYC/XL+4RxVrh7dEI6pTxgVPFI2Cw91n7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564012; c=relaxed/simple;
	bh=fjm8yvFYC8cR6SwgXPJS061q92TCW0t0h8zbh/5FYA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7Ngu+XqSHTf4D9vtA0jF4AmoycOKKKix04Zb9sikirSlC18V25S61SrpWViepWHIU58m5CtJ/k9uMZhGwEIIpJpkp0VfiSMuPzX/nohRXuZ1poyzWeUnRDFbhLwRNBCYWBxmhW3eQric23faU556eT3R0GiO8PimA/JceFvf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=i4KoaIb1; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.19])
	by mail.ispras.ru (Postfix) with ESMTPSA id EC9094076720;
	Mon, 27 Oct 2025 11:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EC9094076720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761563998;
	bh=3b8+dgXV3WJv5lmeh/9J2OvWUpTiG7OLoFwtgYBjv4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4KoaIb1fDzMVyDm880+cH551/IhKGdpfS+LuzVRllkeNSTsjqVvnKqU9Tztzlasi
	 4jWfOoQyS8DQGdpxGsJTNNN5B6pCVvHTgEE6O17ydXNQSPaysRF/e6vPyla9mY1slh
	 PKYWTBc+0of8I9G5lwPkgnOdOeaBy6oyM2a2Z3KU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matvey Kovalev <matvey.kovalev@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH mt76 2/2] wifi: mt76: adjust BSS conf pointer handling
Date: Mon, 27 Oct 2025 14:18:40 +0300
Message-ID: <20251027111843.38975-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027111843.38975-1-pchelkin@ispras.ru>
References: <20251027111843.38975-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a BSS conf pointer to mt76_connac2_mac_tx_rate_val() currently has
two inconsistencies.

When called from mt76_connac2_mac_write_txwi(), BSS conf is got by
dereferencing a vif pointer.  A NULL vif isn't accounted for though the
function itself supposes it to be NULL and tries to handle this case in
previous checks.  This looks like a cosmetic change since the drivers
calling the function (namely, mt7915 and mt7921) set WANT_MONITOR_VIF flag
so judging by info->control.vif initialization inside ieee80211_tx_*()
routines it can't actually come as NULL here.

The same holds for the BSS conf pointer handling inside
mt76_connac2_mac_tx_rate_val().  It is dereferenced before being checked
for NULL.  The function supposes to handle the case so reorder the check
and dereference of the pointer.  Again, this looks like a syntax issue
only.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Co-developed-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 7af6a578562f..3304b5971be0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -297,16 +297,18 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 				 struct ieee80211_bss_conf *conf,
 				 bool beacon, bool mcast)
 {
-	struct mt76_vif_link *mvif = mt76_vif_conf_link(mphy->dev, conf->vif, conf);
-	struct cfg80211_chan_def *chandef = mvif->ctx ?
-					    &mvif->ctx->def : &mphy->chandef;
-	u8 nss = 0, mode = 0, band = chandef->chan->band;
-	int rateidx = 0, mcast_rate;
-	int offset = 0;
+	u8 nss = 0, mode = 0, band = NL80211_BAND_2GHZ;
+	int rateidx = 0, offset = 0, mcast_rate;
+	struct cfg80211_chan_def *chandef;
+	struct mt76_vif_link *mvif;
 
 	if (!conf)
 		goto legacy;
 
+	mvif = mt76_vif_conf_link(mphy->dev, conf->vif, conf);
+	chandef = mvif->ctx ? &mvif->ctx->def : &mphy->chandef;
+	band = chandef->chan->band;
+
 	if (is_mt7921(mphy->dev)) {
 		rateidx = ffs(conf->basic_rates) - 1;
 		goto legacy;
@@ -584,8 +586,9 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 		bool multicast = ieee80211_is_data(hdr->frame_control) &&
 				 is_multicast_ether_addr(hdr->addr1);
-		u16 rate = mt76_connac2_mac_tx_rate_val(mphy, &vif->bss_conf, beacon,
-							multicast);
+		u16 rate = mt76_connac2_mac_tx_rate_val(mphy,
+							vif ? &vif->bss_conf : NULL,
+							beacon, multicast);
 		u32 val = MT_TXD6_FIXED_BW;
 
 		/* hardware won't add HTC for mgmt/ctrl frame */
-- 
2.51.0


