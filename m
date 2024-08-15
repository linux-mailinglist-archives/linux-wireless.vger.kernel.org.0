Return-Path: <linux-wireless+bounces-11448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB73952808
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 04:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23707B20AA4
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32981BF37;
	Thu, 15 Aug 2024 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EhvLsG96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104B18C0C;
	Thu, 15 Aug 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690606; cv=none; b=M5CGA62P1aydZLZkwbJWNMWWmI082F7pfp4FvR6OZ4YLNR4/aQUFJAj8tctzts2Ag3p07panDRd6O4CxwyvyS2x2pCSNGVouXmSJiGPVSCmafjHNpo+4HtSe1p47AXKI0z2T9mKzxJOF056xX9ey/pSS9QHYai98I3iqNDZT9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690606; c=relaxed/simple;
	bh=qoaWrAb8kjBtgWeIJuuD1ayfZGcAGUFf/DgXrhGn7xI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=plx1c73cjEehBZo5roFCgx4zwNzFUL6ggRHFJNXfYmbNBqBcTWNwk3Zu20GDdA2qfmbbTgKqc02Zi247/OiVxAU3UgEQrK46t9b53GQi+48lwE/8wndU5kw+r4vSYmp359rx3yn+M1YOz2pUWSbrRl3xIE2ac02DaFBxk8PJZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EhvLsG96; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fdb25da45ab111ef8b96093e013ec31c-20240815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IreNKXAd6Wij/T8hdkR8/W4pp0PDvrbdbTuyMa714HU=;
	b=EhvLsG968NWKTBd2Vn1QWFfmTlDmR4DbviJhNXnuSEnEWBM5g3ZaKGRjmTIwBbk5eJGJQzJkLaA0PJFMhlE3Y3ToJotfW2mrqqyWUkFF9gHTrNkv5VlB9ndkQsHUrG/EHPpJe/VZPLtUSbfaGPq6WLk1vsnv/buqlG/+bbKXcEM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7ccb41eb-044a-499b-8505-d0852749139d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:b11c9cfe-77bb-433c-b174-ffb8012693b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fdb25da45ab111ef8b96093e013ec31c-20240815
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1470514797; Thu, 15 Aug 2024 10:56:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Aug 2024 10:56:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Aug 2024 10:56:35 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH] wifi: mt76: mt7921: fix wrong UNII-4 freq range check for the channel usage
Date: Thu, 15 Aug 2024 10:56:33 +0800
Message-ID: <20240815025633.20974-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.808800-8.000000
X-TMASE-MatchedRID: PwZ81m9fkLYO9fZKTjt+z/havVZP5tTaKFFZAe4nyZ4Fi3R9x/2qQjEG
	FjeZwyRU/Wti4Vzf8lvbCHv011Gy9U/CFiHta6tDngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
	uXd3MZDX371moSn0VOAmbF1rkLU7qU7EZP1t1XBI2LIqpGKMvSJdTpzr1FBoedipJQCO3xTig3f
	bPV9K2v+/Dm8xfT8B7S7S4JFB9LdNl6jZ5qkH35hdGg+ZY7eN6THB2Q+oKru8MTI34nyF36MJL1
	aANdU8K+rL5VW+ofZc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.808800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7E10A3FC5E124F9FF0A490BB7CFDBDE5BE3AD67CB69DD3D00DA2ED5DBE0B567E2000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The check should start from 5845 to 5925, which includes
channels 169, 173, and 177.

Cc: stable@vger.kernel.org
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


