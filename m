Return-Path: <linux-wireless+bounces-2236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6583260A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA2928583B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172424214;
	Fri, 19 Jan 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ds3CnSEm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9A1E89C
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654665; cv=none; b=Img4ifE0xA7X6YlSS7WfLDGU833nxEv8eIioEkWgRhDZULVLRBDjaFyfkrVTRsgkTWPwwlvG2WXcw481lcvwlyWiKED/GGmsEVeOC+iYh//OSh3Kzp/sY9I9YNtcAZuqrE/O6vF5JyqOOfxnTf9XuXIVX8I0KcAzmX4xX1a03eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654665; c=relaxed/simple;
	bh=RiHfs2t8eC9XHLYWhG/Gz1tK/tPTRMAgu2qCucUaZvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYS+tQc3dAxP6VXpIYzTVPHvTS5Okv59fcDHG++pa3oOFGh8TVKwseFx9y+KNAdz0NQSqAbcGKeK3W8o09FKEQEy2gcJARsvL5aQtfi7TzdeHAgtx4xNwqxbgS5u7ZE6xWFKWHaBY7UZaYPn9bXzpok8S0MFuudbTtEGMjNVu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ds3CnSEm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb58bb26b6a811eea2298b7352fd921d-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i0tTUYG/l096SaouHUHaEj3UA6G711wmON0ZnJcg88U=;
	b=Ds3CnSEm+wuUIJQNy2Pogdd0ofo7Yq1+Cdqe4DrRbHJA8+/BE6yBYv11ZOlQnFaZmSA6q2WER0H1wv9k/YC4bFu7FgbatwFcCS2IcGIZsb1H/cOZOmrMIDSfg7zr32YII+kG3DotFQxF/uhwu9BTRz7igidZLc8lL9qfrWi73fM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:ba0d438b-710c-44e4-b009-dc24477dd48d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:4f6b0783-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cb58bb26b6a811eea2298b7352fd921d-20240119
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1789146826; Fri, 19 Jan 2024 16:57:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 16:57:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 16:57:36 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 08/12] wifi: mt76: mt7996: fix efuse reading issue
Date: Fri, 19 Jan 2024 16:57:04 +0800
Message-ID: <20240119085708.23592-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240119085708.23592-1-shayne.chen@mediatek.com>
References: <20240119085708.23592-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.043400-8.000000
X-TMASE-MatchedRID: VznsoVq3PH9SNowC8HfcvawxbZnudyr7sf4f4CxxueRcKZwALwMGs/6g
	KWYq1ITooTxdbGQ8kfwC3W6W/V0xYnEjLiYgp5vhA9lly13c/gFFYhJJXmHGLzedlpL1W1muo8W
	MkQWv6iXBcIE78YqRWvcUt5lc1lLgKIzdZS3ou0VFaSM+D4UQdQcyQ+B2gGCtNkD6/9XZIwemn6
	BX+CRbAUaLb0kHLLsxqncS7g+aykUBkdT7XBfqWBr2ss3528c3nGbTGsob6Gh5lSmbrC6fdtr/T
	o2FgNrjDLMIOOVTHz12N6Rg5qIpOg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.043400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	98D9EF30CF52C2C16583273733CDCD06F84DE4356006C5185B8227AC61B1AA1B2000:8
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


