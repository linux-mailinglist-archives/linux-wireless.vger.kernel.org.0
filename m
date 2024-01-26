Return-Path: <linux-wireless+bounces-2537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620683D742
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF622905D2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5163416;
	Fri, 26 Jan 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ANMCx5un"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91563122
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260207; cv=none; b=SC+mKzO6lkvDUKGlPh0wUl6aA+L5xuq/PAPfKDSgPKQutfTh4ACOijBSbk1632CacVtqTqbM/SzGnqoXGuL3IYghlaMaX2uMKdeh13lP+YbJcetMgxnSd8lozGA/Z1YlPDIpSAQvXBzOS650iOvnQrOddWan95DeD7PwtSvQ9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260207; c=relaxed/simple;
	bh=BxwgrU0ofL3JmxkJYtFcfTfbjdR19Rtt1wMPgUwUpu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVu1/ZTtCsS9LmlXghdr/e1qt6924oQZtHVIWpPvWsbRFD30JzAAeMn4G/PCfravM+k2W9rVrM1Sc567NSAINfLsxT5QToqPntN6IU3LWmsgPHJXpfDAc5H6704RyjTanDZixoUfz4U/YzGkR4c9nlBTTyW5hsYLc6KF9NPFM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ANMCx5un; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a912c9dabc2a11eea2298b7352fd921d-20240126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SwFyHTrfsGQICXRvxIQhK56mgj4YCkqjfngDkZlF91U=;
	b=ANMCx5und86J+mKal5Xw5Y86sFvMqX/FAw5mDaB5a6OAyp5Gr7uzryM/EyeBk4TQccfJhmM0ezjSgSrT4E3z8X57GLMSn8jS6RTLD+088mOSERNbatqQzBZo1TD+I/YC9ymOW9XehN5OpnUWeFY225oDEnv1m0RHUNUfFpAtf+Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:41273fe9-4175-49a8-97fb-1a86cb83dbbd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:b955b08e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a912c9dabc2a11eea2298b7352fd921d-20240126
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1463373812; Fri, 26 Jan 2024 17:09:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Jan 2024 17:09:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Jan 2024 17:09:49 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 03/12] wifi: mt76: mt7996: disable AMSDU for non-data frames
Date: Fri, 26 Jan 2024 17:09:14 +0800
Message-ID: <20240126090923.6357-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240126090923.6357-1-shayne.chen@mediatek.com>
References: <20240126090923.6357-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Disable AMSDU for non-data frames to prevent TX token leak issues.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 63d34844c122..0384fb059ddf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -732,6 +732,9 @@ mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
 
 	txwi[2] |= cpu_to_le32(val);
+
+	if (wcid->amsdu)
+		txwi[3] |= cpu_to_le32(MT_TXD3_HW_AMSDU);
 }
 
 static void
@@ -862,8 +865,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		val |= MT_TXD3_PROTECT_FRAME;
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
 		val |= MT_TXD3_NO_ACK;
-	if (wcid->amsdu)
-		val |= MT_TXD3_HW_AMSDU;
 
 	txwi[3] = cpu_to_le32(val);
 	txwi[4] = 0;
-- 
2.39.2


