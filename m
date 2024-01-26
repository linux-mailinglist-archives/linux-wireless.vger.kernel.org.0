Return-Path: <linux-wireless+bounces-2541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9083D904
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80E7B33648
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11063513;
	Fri, 26 Jan 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gGAKENn8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C561634ED
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260209; cv=none; b=jdTprVQ7fJhCWpCl8FGn3xY1hqoJiKJ68TGGYXIg+1/T7FTHpKWkCceDhoghVG1pUZT8c1ditVllAAm0e7O1B6wjvXyhE3BCeMkAduux5zq2NBef96T+b/h1Ry9vLLwxltszIYWLXI6cAl+2pq7ky4sbnkwLOpvTwDTvTMjc0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260209; c=relaxed/simple;
	bh=RiHfs2t8eC9XHLYWhG/Gz1tK/tPTRMAgu2qCucUaZvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ze2d0GKqF7TX5AbXYlQfeOEf+JmgYNM588UxHYH+VnoQQh1GFoYWarlLPtQrX3JMnknTO7oqkxR4nJrYnk/TbS5EDRCaFNBhlLZ9wO6F7a4ln1Bq3dBklv3rk4pUz9YEqdqxGLL1DJVhfE2AAr8PlsSt9ZJXNt8HUQzoyGatxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gGAKENn8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9945d24bc2a11eea2298b7352fd921d-20240126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i0tTUYG/l096SaouHUHaEj3UA6G711wmON0ZnJcg88U=;
	b=gGAKENn8kbN0UDhHBsMRcZdp5Nq6dXdiWSIzvOj9iEuLgOPx4jyp0G2p5+B+mwl2CABzFpmCO2maFcFO1TPiA8o3usY8grRFKlBpobAnID+2OyFSfVVjYC+Yp/sdpGzEQ0P2mAEpU2CkgFJWDl2E6BnLUH3zFGP2azRsoLk3hIQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:e50229b9-0c76-436b-b88d-d1be022ccc37,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:ba74c97f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a9945d24bc2a11eea2298b7352fd921d-20240126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1491577793; Fri, 26 Jan 2024 17:09:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Jan 2024 17:09:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Jan 2024 17:09:50 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 08/12] wifi: mt76: mt7996: fix efuse reading issue
Date: Fri, 26 Jan 2024 17:09:19 +0800
Message-ID: <20240126090923.6357-8-shayne.chen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.043400-8.000000
X-TMASE-MatchedRID: x6uIgBUWMExSNowC8HfcvawxbZnudyr7sf4f4CxxueRcKZwALwMGs/6g
	KWYq1ITooTxdbGQ8kfwC3W6W/V0xYnEjLiYgp5vhA9lly13c/gFFYhJJXmHGLzedlpL1W1muo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtmmHg2AUelbqxO8JSOpBiNh+lFc9A/GtbyzXVRC64Z28IAx
	97KXaIZVBSxT21jAwKg2fNerP8R4UrO1calJcwRGtVO+1/nsrzwZBgUyJVEbl6Fw8/PpTMRaVvm
	iAyeA2kc5MSfkiJFI5p3LlElBHTlw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.043400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BFF3DCCF9A4B2133C0AB3B8D74946D1C3A571E0511A9D01D6C574CE17A26189F2000:8
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

The efuse data starts from the 48th bytes instead of 64th bytes in the
returned event skb.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 55512e62f98b..140123a42110 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3547,7 +3547,7 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
 		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
 		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
 
-		skb_pull(skb, 64);
+		skb_pull(skb, 48);
 		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
 	}
 
-- 
2.39.2


