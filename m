Return-Path: <linux-wireless+bounces-11535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46095462F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1731F22213
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC161714D7;
	Fri, 16 Aug 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cmy24cYx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2C16F26F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801825; cv=none; b=APzceOUuIAgL5t3Z7iu/ytpZVrAG3HZNTGIBBdDgal0DEscgBWk3sX9Mkt/uecqCqdsufdxhmYpBSuKem2g81KkwoAY+yovD65mWyNk7Iio3iTqmC15e1zEkIXFSbFQYCxkMq8W4f6JhvDZxQ56dddmtbCPp9wYUCa72F+gl4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801825; c=relaxed/simple;
	bh=KJihDMEuPjGVxFZ0FAEr3z2T4Gd8eBYlzrom6JBOrl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyE1RcCjIn5iN8GqUnyPqHcRZUNe86GfybG6rC+0HxnIudbTz2tw/mtkFlgLXukLKnU9WUXxvnfzzfWXyh6bClN90IGddAtUV8zbksW/m7wmtuGF8cQ3dV9U7/PEk68nU8zEDwsnvcQqV3Y7wxl1/1MWg7qZCAiH2vqFGiUAbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cmy24cYx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef59c13a5bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Jf3A24yvH8Wm1I7P4jjPt3Wwa2CzEZoNMFRqzd1/XCc=;
	b=cmy24cYxsXnCbVJ257z8jQpABqNJh/Eyf+cxo6FQL3R2aTSqJ6OkJO56aoAflprq62aZL6B6hTLrrA/uhk/uJBnS2/oIfDlWEa4OaHVWyOwmsxOUCH5eGiNBRgA41jbdJ+qmVtwGGW9PjjRPibMGaRZvtXzxJHhKYvJvdkW85nI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7070f8eb-4ad3-4d9f-953d-d8f1cf329ca6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:55c6b6c1-acff-4a0f-9582-14bcdf4ed7e0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ef59c13a5bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1442285021; Fri, 16 Aug 2024 17:50:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 17:50:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:50:15 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 09/12] wifi: mt76: mt7996: set correct value in beamforming mcu command for mt7992
Date: Fri, 16 Aug 2024 17:46:32 +0800
Message-ID: <20240816094635.2391-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240816094635.2391-1-shayne.chen@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Configure correct bf number and bitmap in beamforming mcu command for
mt7992 chipsets, which only support dual-band.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index daef014954d0..238b1f78ff7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3923,8 +3923,9 @@ int mt7996_mcu_set_txbf(struct mt7996_dev *dev, u8 action)
 
 		tlv = mt7996_mcu_add_uni_tlv(skb, action, sizeof(*req_mod_en));
 		req_mod_en = (struct bf_mod_en_ctrl *)tlv;
-		req_mod_en->bf_num = 3;
-		req_mod_en->bf_bitmap = GENMASK(2, 0);
+		req_mod_en->bf_num = mt7996_band_valid(dev, MT_BAND2) ? 3 : 2;
+		req_mod_en->bf_bitmap = mt7996_band_valid(dev, MT_BAND2) ?
+					GENMASK(2, 0) : GENMASK(1, 0);
 		break;
 	}
 	default:
-- 
2.39.2


