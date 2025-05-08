Return-Path: <linux-wireless+bounces-22730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE0EAAF61D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 10:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A881C0680C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECE24C67B;
	Thu,  8 May 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d0tLTIhd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD956BFC0;
	Thu,  8 May 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694544; cv=none; b=dxQiGsPa8colJGLr9roVG5vsC7n6VlwPSp9E7IaE3p4OYTbisSopD2SRddNLf8Yxc+QzrLexiwWP3A9W4w9YZiPexpYyW9GOA0A/xZy+sLR/gNQdB8TRZqgJpAqUlSjbry+pW5KDQA3gC0iWO4TXQmXPfFMfR/aIeDKjl/eUT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694544; c=relaxed/simple;
	bh=h3hoUGoTGLj696UzC1mrfDHBmmf6gv4n414GMVdO/vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mh9rbJFeNqcE79ULjZIgairytRFZk1nWv31okahfOJ2Xtw4emHh0dr++PcfSWIsWivrqUkOD9mAxk3mdyw+aTrBz9VsZalYOGETQUCOAHjzmuK3f+YAMB6edtv12MSUjgyRKwXO4jmvajm26Q8G/j1CX5/uxnF+/i91fLZ2zywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d0tLTIhd; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 35a558562bea11f082f7f7ac98dee637-20250508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lEyZ+D8xZT7McsFHXW2Qp2/8UB4rXLb9GNlZlQlr1nQ=;
	b=d0tLTIhd1HF4wrj+rLzlltSe9q8O6iqJ2Twt6sT7u2vEAfMCoyIZGCDE/gg5J2Fm6yv9GP9wMC/vxqwRvUOkMN2HN91zE6PhRsRBEFhEc3TZ97KwzOPoyXvy+nRwmldm+AdoiDO/UQMJMuzxFwUhMlbyQFz+f+kbR9Mc0KeVEKc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:09da3b62-c35b-4fec-94ab-a7ac9cd9fd1e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:7f174d51-76c0-4e62-bb75-246dfb0889c6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 35a558562bea11f082f7f7ac98dee637-20250508
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 143013446; Thu, 08 May 2025 16:55:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 8 May 2025 16:55:35 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 8 May 2025 16:55:35 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>, Niklas Schnelle
	<niks@kernel.org>
Subject: [PATCH v2] wifi: mt76: mt7925: fix missing hdr_trans_tlv command for broadcast wtbl
Date: Thu, 8 May 2025 16:55:34 +0800
Message-ID: <20250508085534.305242-1-mingyen.hsieh@mediatek.com>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The hdr_trans_tlv function call has been moved inside the conditional block
to ensure it is executed when info->enable is true.

Cc: stable@vger.kernel.org
Fixes: cb1353ef3473 ("wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Niklas Schnelle <niks@kernel.org>
---
v2:
    add tested-by tag
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a42b584634ab..fd756f0d18f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2183,14 +2183,14 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 			mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
 			mt7925_mcu_sta_eht_mld_tlv(skb, info->vif, info->link_sta->sta);
 		}
-
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
 	}
 
 	if (!info->enable) {
 		mt7925_mcu_sta_remove_tlv(skb);
 		mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF,
 					sizeof(struct tlv));
+	} else {
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
 	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
-- 
2.34.1


