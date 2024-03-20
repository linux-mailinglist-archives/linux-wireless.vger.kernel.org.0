Return-Path: <linux-wireless+bounces-4971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C030788107C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468BBB23A7B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07F3D984;
	Wed, 20 Mar 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bcQfNcuJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27843B2BB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932974; cv=none; b=Um0cS8QMez7i4Inv+tfus+8N0D1soNx7lp5S4efSaNIYv5WxUqydEkI8QBMVzPrEKP3Xi60NQzXQ8ZJ6NemLAh0pWQDFNPm9b8YHHkdxnJFoq/t8ASRvjcORlxs0tIf9flsJL3BY5yY4qbvK+Gcm1fDZfeLhRCh1vehvOZXHfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932974; c=relaxed/simple;
	bh=6J0l661iN5wcu18RgmvwR3hlGKZn0vcaIneK0o/nrA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1aQOTvt+LcfzBfTiDihPonl+gQYI9wkiLfnoIfFk3ZkTEwjDjr8fHvq5T0aj61bUGXd1euhiHARnLfgXqYdJlDvwfmQoCweuD717KtMEoYxmFtN8XhVqUuqd4GaBw9NBjhYeFBuyf2Zi1i4K5QRU0siC7tp5txefOisYHi09N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bcQfNcuJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4ffee25ce6aa11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AA/zJxgLyXGzp1J2+WkEAN14CQdsA2D7Ovus/U+zG0U=;
	b=bcQfNcuJhHDikCqBtfquWtzYmuewzw2irQ61v8n8VKaFkgfVaDtkHOY7EcliTd96jaDX8hj49GNU3q2yPP1samE1THRFa06OXd1tGNTlCy0dbvr0VIsKhHkxOzAV22ANGDwAy8NEbM6dfvLnIVXyhorMM3sXsZy869FaOtzL2PU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:af344c14-f85b-40a9-b47f-6421f8b1daad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:db05a090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4ffee25ce6aa11eeb8927bc1f75efef4-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1858807238; Wed, 20 Mar 2024 19:09:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 06/10] wifi: mt76: mt7996: fix potential memory leakage when reading chip temperature
Date: Wed, 20 Mar 2024 19:09:14 +0800
Message-ID: <20240320110918.3488-6-shayne.chen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.866700-8.000000
X-TMASE-MatchedRID: Q/tsoOSh0kO72QdSbIBqAFz+axQLnAVBCt59Uh3p/NXgr/zYTDOZCFO4
	BD7nLMxnEPB80RQOifWDvCSgORorg6+/EguYor8cFEUknJ/kEl7dB/CxWTRRuzBqYATSOgWjIVo
	uPNaxr7bQ1l1qpCo/B9axUQUOK6+X5kN66jfD6Jji053WVk3w/Om7H5y9fALyQ99DMjxTAszir2
	K1f2u0rAcJ1KpoeGnSgITnGkK0NFNRskXKHhdfKpij9M86UwHhsKHfMTjCprzAgTvs8QFuaX7cG
	d19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.866700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B71DB43DC290BFF2A9CFE7C40720512F50044A0C33C64EB5C25BD89D4D2EA7D22000:8
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Without this commit, reading chip temperature will cause memory leakage.

Fixes: 6879b2e94172 ("wifi: mt76: mt7996: add thermal sensor device support")
Reported-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index c4eefc593a40..d5e35f6dd52e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3750,6 +3750,7 @@ int mt7996_mcu_get_temperature(struct mt7996_phy *phy)
 	} __packed * res;
 	struct sk_buff *skb;
 	int ret;
+	u32 temp;
 
 	ret = mt76_mcu_send_and_get_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(THERMAL),
 					&req, sizeof(req), true, &skb);
@@ -3757,8 +3758,10 @@ int mt7996_mcu_get_temperature(struct mt7996_phy *phy)
 		return ret;
 
 	res = (void *)skb->data;
+	temp = le32_to_cpu(res->temperature);
+	dev_kfree_skb(skb);
 
-	return le32_to_cpu(res->temperature);
+	return temp;
 }
 
 int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state)
-- 
2.39.2


