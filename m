Return-Path: <linux-wireless+bounces-37048-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VtpMFL24F2qwOggAu9opvQ
	(envelope-from <linux-wireless+bounces-37048-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 05:38:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB85EC39D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 05:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB14C30242B4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 03:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EC2DAFA9;
	Thu, 28 May 2026 03:38:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD961FCE;
	Thu, 28 May 2026 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939509; cv=none; b=YWyT+cj4tbyaTFdoj3fN6XmDOf6z1nCGPcID3G4Q9grwOc6JsE7BvBMra5GB3eMbDmyra3NsiE4UdhHThlf4E158QKubJG70qm3ZiFOU7Dl1XP7WsCVj8J0XuqXg5305a2Vzy++amQOdHmJBpAR4E6Hxlm9wdjBTtBFklI9Ho0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939509; c=relaxed/simple;
	bh=Mq7h9kxddK+WBFeYldWHhdNTq1vVteEPNopCmPaz6d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An/1QQ493SZl/kP02JS1QxmS5v40Xz4MtJQbSxvBeoqbsn073xoohdea4Xdkmwg37EgaEYUOLudFJO4i3F06zcjgLrcjoIonVS5EpE5ZP/kMSwkZlKi8gDC7zMhagCkuiH6C869gjCqmRrUPSEJFTNNCyrs/488OiKJHUsffxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab5ad48c5a4611f1aa26b74ffac11d73-20260528
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7a828153-7aa4-495a-a2e8-16286402c62e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:4a09221e07cf789a4913c9d7f23183cc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab5ad48c5a4611f1aa26b74ffac11d73-20260528
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1218919271; Thu, 28 May 2026 11:38:19 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH v2] wifi: mt76: add wcid publish check in mt76_sta_add
Date: Thu, 28 May 2026 11:38:14 +0800
Message-ID: <20260528033814.46418-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-37048-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liujiajia@kylinos.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 4DEB85EC39D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since mt7925_mac_sta_add publishes wcid, add publish check in mt76_sta_add
to avoid reinitializing the wcid->poll_list.

Found dev->sta_poll_list corruption when using mt7925 and 7.1-rc4.
According to the corruption information, prev->next was changed to itself.

wlan0: disconnect from AP 90:fb:5d:94:8b:e3 for new auth to 90:fb:5d:94:8b:e2
wlan0: authenticate with 90:fb:5d:94:8b:e2 (local address=84:9e:56:9c:7e:6b)
wlan0: send auth to 90:fb:5d:94:8b:e2 (try 1/3)
 slab kmalloc-8k start ffff8c80958a6000 pointer offset 4160 size 8192
list_add corruption. prev->next should be next (ffff8c808a7488f8), but was ffff8c80958a7040. (prev=ffff8c80958a7040).

 mt76_wcid_add_poll+0x95/0xd0 [mt76]
 mt7925_mac_add_txs.part.0+0xa5/0xe0 [mt7925_common]
 mt7925_rx_check+0xa7/0xc0 [mt7925_common]
 mt76_dma_rx_poll+0x50d/0x790 [mt76]
 mt792x_poll_rx+0x52/0xe0 [mt792x_lib]

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---

Changes in v2:
  - use dev->wcid table instead of adding MT_WCID_FLAG_DRV_PUBLSH for
    wcid publish check suggested by Sean
  - subject and commit message update

---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 4ae5e4715a9c..b78b4cd206e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1576,6 +1576,7 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	struct mt76_dev *dev = phy->dev;
+	struct mt76_wcid *published;
 	int ret;
 	int i;
 
@@ -1595,11 +1596,19 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		mtxq->wcid = wcid->idx;
 	}
 
-	ewma_signal_init(&wcid->rssi);
-	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
+	published = rcu_dereference_protected(dev->wcid[wcid->idx],
+					      lockdep_is_held(&dev->mutex));
+	if (published != wcid) {
+		WARN_ON_ONCE(published);
+		ewma_signal_init(&wcid->rssi);
+		rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
+		mt76_wcid_init(wcid, phy->band_idx);
+	} else {
+		wcid->phy_idx = phy->band_idx;
+	}
+
 	phy->num_sta++;
 
-	mt76_wcid_init(wcid, phy->band_idx);
 out:
 	mutex_unlock(&dev->mutex);
 
-- 
2.53.0


