Return-Path: <linux-wireless+bounces-2239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0583260D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592871F23A46
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D8D288CF;
	Fri, 19 Jan 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N3f9ml0/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE981E89B
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654667; cv=none; b=AAMhcrE6qZ0bIfqEDAJ7C0RabqKTRSmNZRzkNL/cY2zxd9Y/bZlmDGKpZ8kB8nFgJDFzfWuB/ALkBoZTP76nrmN500PudDIs9P3EpPes5P5NEkOlL4iJ0RB6i5eqRthsA9t6SBMbIafwB7zChEx5QyRHsuZDyPkMKZ6wqaGSaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654667; c=relaxed/simple;
	bh=zWlc/S6DZ/fUTn9LwVH+0v5+9nwdAYr32erZ91OEyXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YBHShV7UC8kZfCM9/BeUDZ6lvXCISouO6cj/1fmLDKDesfcpATMnBKD/osWQYh2FAnQbzeGJIQC1Sy1bAAHJoyeOzs54uQHVDFe7eTMNyS8DFxAxjjxtRkfdakJ2fcd4h1Lvzfj2IIl2CJ0pLvQCoZG/VpVAFOHiu5TZnO9QJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N3f9ml0/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: caad9390b6a811ee9e680517dc993faa-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QfBJh/G27e2/TM1jxbBhY/qC7WJr1g5LZzWtbcjgAfw=;
	b=N3f9ml0/WZu7P1F6eqpfQXvavxnkJRceCQjkFmvBuNshR7mwCS0mqxUDi1ynU+7+Qfi06PnHTyKDxH96qc4hxdVgOAKAbYygrMB+ntRrxt1b0471B9ypitDL/8eOP1oKYAD+u1HVRG4z4hYCOxgjfdvOHb1qYULDi4z94wp6caI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:64c8cb4d-e5a6-4d8d-bad3-caad842d10de,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:396b0783-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: caad9390b6a811ee9e680517dc993faa-20240119
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1344398572; Fri, 19 Jan 2024 16:57:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 16:57:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 16:57:35 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 01/12] wifi: mt76: mt7996: check txs format before getting skb by pid
Date: Fri, 19 Jan 2024 16:56:57 +0800
Message-ID: <20240119085708.23592-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

The PPDU TXS does not include the error bit so it cannot use to report
status to mac80211. This patch fixes issue that STA wrongly detects if AP
is still alive.

Fixes: 2569ea5326e2 ("wifi: mt76: mt7996: enable PPDU-TxS to host")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 53258488d49f..a8414fbb07c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1188,25 +1188,28 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
 	struct ieee80211_tx_info *info;
 	struct sk_buff_head list;
 	struct rate_info rate = {};
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	bool cck = false;
 	u32 txrate, txs, mode, stbc;
 
 	txs = le32_to_cpu(txs_data[0]);
 
 	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
 
-	if (skb) {
-		info = IEEE80211_SKB_CB(skb);
-		if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-			info->flags |= IEEE80211_TX_STAT_ACK;
+	/* only report MPDU TXS */
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) == 0) {
+		skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+		if (skb) {
+			info = IEEE80211_SKB_CB(skb);
+			if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+				info->flags |= IEEE80211_TX_STAT_ACK;
 
-		info->status.ampdu_len = 1;
-		info->status.ampdu_ack_len =
-			!!(info->flags & IEEE80211_TX_STAT_ACK);
+			info->status.ampdu_len = 1;
+			info->status.ampdu_ack_len =
+				!!(info->flags & IEEE80211_TX_STAT_ACK);
 
-		info->status.rates[0].idx = -1;
+			info->status.rates[0].idx = -1;
+		}
 	}
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && wcid->sta) {
-- 
2.39.2


