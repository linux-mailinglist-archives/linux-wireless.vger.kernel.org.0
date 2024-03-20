Return-Path: <linux-wireless+bounces-4969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03D588107A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C2528376A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41483BBE0;
	Wed, 20 Mar 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q1aALXCS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C7381AC
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932973; cv=none; b=hATAvlYdwcnoTAjPyGy4lz79jXrYNrYppYb4FxMNdpHplIq+tM8Sm0CCGzP/gI/PM564IBJ5RDyedAuSNUyHdKp+Qf8yjFB0XaOCMDvP+7ubp0NSbOJNpMp2wzEjHhhslK6LnEMG2sLA3aMZd8lLoe4/ATqDwtX0mfhHkp2wmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932973; c=relaxed/simple;
	bh=/LE61X8y/DdGcEpKMaHMMhHVEyTCNolALQsVuGo2OdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9vYwW96Q5VtjnZI1uEh+yKRYm4CBhG0W598kMA0NQkcFVEWGTC2fBLyGHQYL7hqsEZLuNqxYqGtPWmZf/SKHB1rRnKAQ17rBiObOwkltwSOue9kK8SOZqz16eCYFwEz3NQDAPq6+4JnCjyVpIxqxJRgGrl28Qi3jOTLzvdw9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Q1aALXCS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f5ee388e6aa11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gOrIZkIrcVV+GEoWV1OmKv6z/f07V5RnvOpBqKJxDOw=;
	b=Q1aALXCSvHu8+5CtOqR2lc6W2QCol0v7aHB3jaWo57YbwYiIVnRNwwY+/K+MabC1ctHr1aon9w+QfFHpJn5f2zQ2HYhPNIkbmr0uKwkuJxJtG0wh/qPEOuFmOAJGmcGOrkTm07Y4ny5wtg7r8GLEpfVP5Ganrl0EHSfbFD8+nIw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:077bf87f-4b6a-4c1a-92b4-59701bef646f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:dcd9b881-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4f5ee388e6aa11eeb8927bc1f75efef4-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 639166594; Wed, 20 Mar 2024 19:09:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 19:09:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 19:09:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 08/10] wifi: mt76: mt7996: add sanity checks for background radar trigger
Date: Wed, 20 Mar 2024 19:09:16 +0800
Message-ID: <20240320110918.3488-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320110918.3488-1-shayne.chen@mediatek.com>
References: <20240320110918.3488-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Check if background radar is enabled or not before manually triggering it,
and also add more checks in radar detected event.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c     | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 9bd953586b04..62c03d088925 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -225,6 +225,11 @@ mt7996_radar_trigger(void *data, u64 val)
 	if (val > MT_RX_SEL2)
 		return -EINVAL;
 
+	if (val == MT_RX_SEL2 && !dev->rdd2_phy) {
+		dev_err(dev->mt76.dev, "Background radar is not enabled\n");
+		return -EINVAL;
+	}
+
 	return mt7996_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE,
 				  val, 0, 0);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ccae954a22f8..c024f138f1ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -355,7 +355,10 @@ mt7996_mcu_rx_radar_detected(struct mt7996_dev *dev, struct sk_buff *skb)
 	if (r->band_idx >= ARRAY_SIZE(dev->mt76.phys))
 		return;
 
-	if (dev->rdd2_phy && r->band_idx == MT_RX_SEL2)
+	if (r->band_idx == MT_RX_SEL2 && !dev->rdd2_phy)
+		return;
+
+	if (r->band_idx == MT_RX_SEL2)
 		mphy = dev->rdd2_phy->mt76;
 	else
 		mphy = dev->mt76.phys[r->band_idx];
-- 
2.39.2


