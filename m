Return-Path: <linux-wireless+bounces-20904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA232A74244
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 03:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58311171B09
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 02:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394D20DD48;
	Fri, 28 Mar 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s2GIa2A+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28913D89D
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743128953; cv=none; b=bZoFKVhTHqNgRv0XKZ2Ow820/T7UQ1UiM4bpLMHgeljOK3BamqGDK5fhdLh4ZJcVRhXTgyJlNDEAt5RY805uyQAIQm7AuRUic7t/1wYYtMKOI4x8GuIDflnJmlSsdGRnXAFejfvuvX8sk/vrz/H5FwZxnwC2UNudG4fnSLhZb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743128953; c=relaxed/simple;
	bh=8sNg+4pMpR31vW1qiUyAY2O7pEjuo455g18wfSKcrQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKdW7uEce+YlfH+FQo57ux5IliOY0tgcuhHI22McmEgf2uUJzqpifTlTVO2snfbpMRb3Y4a+XNHLK4YAEEUODL5TCwG1uH1SLyKTsKS1csRNBliCJyj7BKFQ7if/hkhkaeVuDxb6ob1NeRe29QSDNAirJ8BP/6dd2nwbvI1JiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s2GIa2A+; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 681312e40b7c11f0aae1fd9735fae912-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cj6WARRDUu81bD7FNguWIjaU7KS/9mR6wv5eamc6rus=;
	b=s2GIa2A+denD+6380Z6UxwwBMw0Oyo6Pb8gmBsvuG7iuDguR3dZdJw2UWRxXVIxQGOkxVRQCCKcRvKHogWEreRfmvQ07yowkPEsZ5OMqqiEGn54pj4SFPhyVufVOO9/pqyoUnuOr+lmyHcShiYB9xwZ3G5tCKdvyJ+hv6Uynk9o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:65793ade-f5b8-44a7-9b5b-58fe141366ae,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:a137a94a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 681312e40b7c11f0aae1fd9735fae912-20250328
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1545091463; Fri, 28 Mar 2025 10:28:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 10:28:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 10:28:58 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Ben Greear <greearb@candelatech.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76] Revert "wifi: mt76: mt7996: fill txd by host driver"
Date: Fri, 28 Mar 2025 10:28:47 +0800
Message-ID: <20250328022847.1612082-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This reverts commit 3b522cadedfe6e9e0e8193d7d4ab5aa8d0c73209.

The MTK connac3 has introduced new hardware, SDO (Software Defined
Offload), to offload the process of filling the TX descriptor. Initially,
there were some issues, but after several fixes, it should now be stable,
allowing us to revert this commit.

Additionally, activating SDO is essential for the proper functioning of
features like TX checksum offload.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a52b4e71b267..baa4aea109bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1017,8 +1017,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-	mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-			      pid, qid, 0);
+	memset(txwi_ptr, 0, MT_TXD_SIZE);
+	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
+	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
+		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+				      pid, qid, 0);
 
 	txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
@@ -1035,8 +1038,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 	txp->fw.nbuf = nbuf;
 
-	txp->fw.flags =
-		cpu_to_le16(MT_CT_INFO_FROM_HOST | MT_CT_INFO_APPLY_TXD);
+	txp->fw.flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
+
+	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
+		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
 
 	if (!key)
 		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
-- 
2.39.2


