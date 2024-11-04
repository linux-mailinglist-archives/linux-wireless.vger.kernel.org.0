Return-Path: <linux-wireless+bounces-14853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF149BAC03
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 06:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100FD1F21945
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 05:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5112C484;
	Mon,  4 Nov 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hgpDreY8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F510F1
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730697301; cv=none; b=W4tuomiiKLA66/QE1JwhV3vJIhB+oSyUWSkQRhRb7e2OMhQdVQCcUhP4tb4sSX9m7HGJerw0aEHXYZ9oLC1zrft7EiDeZcv3Y/j4bEJsjoo0xu4K4SbQQ3qa4R4XGVEPWFDOWm77DoidAWa/LV91pHJHxI/HkhxFUd0J4MmRDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730697301; c=relaxed/simple;
	bh=paKaJwGHXjwLZwGD04sLRr9w3mKfFsDVH6Ik9SN5PCE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DjkViXr/F3yVvKb0BLRo50MlZ53VOSSf5CILrWkP9FM+LryOYG2pDCnam4gtlyl9NH2JWmKUvC1wb1854ipfx5FL0uZAw/VFC98NOYju1yTs6hY+y7I6fBzelPo+T6QiASCAmVQ+Aa35FD3T5ZTR/QClgEwQ0wQjfr03nozNZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hgpDreY8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b87a2c5e9a6b11efb88477ffae1fc7a5-20241104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yUCYHw7khHoCO1t2Y7CbcGcUg+wa95k4lCS42nnuKdY=;
	b=hgpDreY84sBA/hPpOAigP+9lSnnd7qidRiF1vxOs1KavZAyZCJVkaB8o2VtVQKoBqeJylAU0MZBMNEUm1Df1javo28ALp+kZFXj+KSsWQ59UL6dKu359YbmR0PiEJJdRWmLxnrEMZ2z32ezXEez1E6yeeaaFeSqvLEv6PiQ2pHE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:c6b926dc-8f0a-4eb7-b133-a22a120ecef6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0fcdc3,CLOUDID:63d67d07-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b87a2c5e9a6b11efb88477ffae1fc7a5-20241104
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 844077716; Mon, 04 Nov 2024 13:14:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Nov 2024 13:14:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Nov 2024 13:14:48 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
Date: Mon, 4 Nov 2024 13:14:47 +0800
Message-ID: <20241104051447.4286-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-3.791700-8.000000
X-TMASE-MatchedRID: mvQ5OXqkleF3jyG1lXn0RLMjW/sniEQKfiuvKi9huaYFi3R9x/2qQsHt
	HEmxq9+Y32QTkj7KSP7bCHv011Gy9Uibx2WCCMTIngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPI0PU
	0TdJoUtdOHQWzTBvDVjaZuQtaXB65G+CCkpJR1ck6IRYfe9h6Igm3AqTtXDcfSVcF4gli7G7oM6
	wHK262gsECmoVvhxxOslfTc7QVzKWOh+wyNBrFXDJiNuKohDcKzKSG3JdyKAPqtV2AGMNParsc3
	Lhg3nYY
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-3.791700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 378397D9253B17FAECA106672662722972B3A117A8C14293E4F3F60E155DAC602000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Use tlv instead of skb, because using skb will get valid data
with wrong offset.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
 - Considering the CPU endian order, add le64_to_cpu().

 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0c2a2337c313..81ddcf72bcd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -823,7 +823,7 @@ mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
 			mt7925_mcu_parse_phy_cap(dev, tlv->data);
 			break;
 		case MT_NIC_CAP_CHIP_CAP:
-			memcpy(&dev->phy.chip_cap, (void *)skb->data, sizeof(u64));
+			dev->phy.chip_cap = le64_to_cpu(*(__le64 *)tlv->data);
 			break;
 		case MT_NIC_CAP_EML_CAP:
 			mt7925_mcu_parse_eml_cap(dev, tlv->data);
-- 
2.45.2


