Return-Path: <linux-wireless+bounces-1257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4BC81D20B
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 05:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFB61F228A0
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 04:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038FA10F4;
	Sat, 23 Dec 2023 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MLFnyUx9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94C1110
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c647cc60a14711eea5db2bebc7c28f94-20231223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HJrLG1zM8PTKraRTm33Q1ashFfc4kPfHJeFcFgICb/k=;
	b=MLFnyUx9NaIszp+9L6hTppeZMktz8MpKZLkm78SEAxvctH+XALfGFBjw3llsUtpDry7JRZ5i5SW+sXETHdhUkLME4HGHHhE6/AQ8SqQOp7GBhTueSPwEdwNX5y+i0rADaBo0mpcqMOkw3+v82ZGoUaufYwdJBmc3hlkMc0V5vJI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f79431fd-de29-454f-a549-c90eb551d0d8,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:5d391d7,CLOUDID:d659662e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c647cc60a14711eea5db2bebc7c28f94-20231223
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 880617386; Sat, 23 Dec 2023 12:00:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 23 Dec 2023 12:00:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 23 Dec 2023 12:00:12 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 1/3] wifi: mt76: usb: create a dedicated queue for psd traffic
Date: Sat, 23 Dec 2023 11:43:06 +0800
Message-ID: <3eb3a860ccdf465b77ae63d6ddcf6a584d1729ce.1703301666.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.304200-8.000000
X-TMASE-MatchedRID: P7IsGr2NQXpxERu/GEvUx57tR0mnRAg19k2LdvNVos40QmmUihPzrOD+
	bNUbvCNRThbvLLI8RvOP8lyp0EjHaun2wHlv5vGudXu122+iJtrGYnoF/CTeZZ6fSoF3Lt+MQeG
	LuticaUPbU8hbAd0JD341niV9KymzHxPMjOKY7A9t1O49r1VEa8RB0bsfrpPIXzYxeQR1Dvvndz
	T1VUm+yW0uVYlAtwt47fEUfA3jpjWYSNo3e1rEeo7dlbKe85Mf
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.304200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 401E56649758C30EA66F75B96BA1EB57C31FCB9DB5BEBF1839A7ED984E5D1A1B2000:8
X-MTK: N

From: Lorenzo Bianconi <lorenzo@kernel.org>

Create a dedicate queue for psd/mgmt traffic and do not rely on voice
one. This is a preliminary patch to fix mt7921u/mt7925 usb dmasl
configuration.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 1584665fe3cb..9958399ff57e 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -767,7 +767,7 @@ static void mt76u_status_worker(struct mt76_worker *w)
 	if (!test_bit(MT76_STATE_RUNNING, &dev->phy.state))
 		return;
 
-	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+	for (i = 0; i <= MT_TXQ_PSD; i++) {
 		q = dev->phy.q_tx[i];
 		if (!q)
 			continue;
@@ -928,14 +928,11 @@ static u8 mt76u_ac_to_hwq(struct mt76_dev *dev, u8 ac)
 
 static int mt76u_alloc_tx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q;
-	int i, j, err;
+	int i;
 
 	for (i = 0; i <= MT_TXQ_PSD; i++) {
-		if (i >= IEEE80211_NUM_ACS) {
-			dev->phy.q_tx[i] = dev->phy.q_tx[0];
-			continue;
-		}
+		struct mt76_queue *q;
+		int j, err;
 
 		q = devm_kzalloc(dev->dev, sizeof(*q), GFP_KERNEL);
 		if (!q)
@@ -969,7 +966,7 @@ static void mt76u_free_tx(struct mt76_dev *dev)
 
 	mt76_worker_teardown(&dev->usb.status_worker);
 
-	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+	for (i = 0; i <= MT_TXQ_PSD; i++) {
 		struct mt76_queue *q;
 		int j;
 
@@ -999,7 +996,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 
 		dev_err(dev->dev, "timed out waiting for pending tx\n");
 
-		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		for (i = 0; i <= MT_TXQ_PSD; i++) {
 			q = dev->phy.q_tx[i];
 			if (!q)
 				continue;
@@ -1013,7 +1010,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		/* On device removal we maight queue skb's, but mt76u_tx_kick()
 		 * will fail to submit urb, cleanup those skb's manually.
 		 */
-		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		for (i = 0; i <= MT_TXQ_PSD; i++) {
 			q = dev->phy.q_tx[i];
 			if (!q)
 				continue;
-- 
2.18.0


