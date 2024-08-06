Return-Path: <linux-wireless+bounces-10983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF7948705
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 03:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11478282B3B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33664A;
	Tue,  6 Aug 2024 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DAwrwcWW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C4EC4
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722908065; cv=none; b=SRoqaxFmUk2Olzf1Lbm2gQVtR0cgU/fz3c9h/bIzognK2FkywPfD0q6ViV4g3bDS+8cCMNGk2JEyT53QljlCJ3Yo5Oj5pH2IhDBvtN+2ylzZQSoLZo+CmTZNBKadQGRNs96gMnBMog1AuM/jjakXTRRa4/5lyU3G9/Zv9ZlhqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722908065; c=relaxed/simple;
	bh=rxYvGLSzf5ZH7F1Mw/DkNOMua8w8DUE/sEfMnBmwVsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jykT/30osBNWqiJZzXHpQ8JFsp6tHYM2ak37f0QAaFSfP1KX5Xc3bZwBOJdhPK/CZqC+4qsD+6kpMdUkxU5XBHHObuigYoZbqGNMzor3jJLl2onse3kGdYMrJgPCVNU6kwlglhyyj5hWXGVlJqOHGrnRI/w15Dw7IVyj4SihO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DAwrwcWW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fadb5a74539311ef87684b57767b52b1-20240806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yA/pLuSk66sK8UsQhzMj528hGdJ/mrt4nVFSOMEKOzU=;
	b=DAwrwcWWcD4MZGu28ekQXsxzAoXteKCSrB0EI7gU+7WEzr5cNmD3qBS/3V38RopBngxK/JGJXA0ZjJQzY76Dhj1rt3w1pX4bOWi7gLgOdAhMY3xMkcZ576C8QAjsHGk6eZGcLMWfVG8UZvCmLrWXGMQJ3pwJsnFV2lJ2EMq5bWU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5a97128f-6675-476d-a035-ede0ce3fd919,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:1e34376e-a1c8-43d5-b285-20e4a374b307,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fadb5a74539311ef87684b57767b52b1-20240806
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1712585814; Tue, 06 Aug 2024 09:34:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Aug 2024 09:34:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Aug 2024 09:34:10 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix wrong UNII-4 freq range check for the channel usage
Date: Tue, 6 Aug 2024 09:34:08 +0800
Message-ID: <20240806013408.17874-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The check should start from 5845 to 5925, which includes
channels 169, 173, and 177.

Fixes: 09382d8f8641 ("wifi: mt76: mt7921: update the channel usage when the regd domain changed")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ef0c721d26e3..57672c69150e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -83,7 +83,7 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 		}
 
 		/* UNII-4 */
-		if (IS_UNII_INVALID(0, 5850, 5925))
+		if (IS_UNII_INVALID(0, 5845, 5925))
 			ch->flags |= IEEE80211_CHAN_DISABLED;
 	}
 
-- 
2.18.0


