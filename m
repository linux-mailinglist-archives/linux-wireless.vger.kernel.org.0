Return-Path: <linux-wireless+bounces-11595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FC9560F8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 03:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C801B22109
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32D182B3;
	Mon, 19 Aug 2024 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FaauE4Z2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBD1BC20
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724032432; cv=none; b=orErdExxt+dZ++sbOTdEJY3cFhie0nA7wblcdfOwQCglgx53VKFWtp1Q2JH8niWiaF3z5S2stf80abav2/wyYUe3wGLRzx8Ra+Am3Hd5ydkMVGHZSPjlii46OeWz2+oo2seLbkUqzCkQO1yYgKmTI5GyNLmMi5mlhdhdO9TCJcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724032432; c=relaxed/simple;
	bh=SpruAEWANYjCa1HTK7MNqzYMDiPFl8ctNdfBGcYruTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ7ldWVjz510P9eRK9YHagYPb16ZIV7OpIzHF0FGD6Hxh82TQ2vhTB9sgVJhQX1IRcNsQDSB77RvkHGSj1zmi3z5uW7dZ0LMFDGGE74p3sh33GD3aZZYzbwsCkDzWOfk/YVkhfB07pgTKrv2DwcTKiJOSuIB+pCNZbHmTvmCjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FaauE4Z2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d9d2abae5dcd11ef8b96093e013ec31c-20240819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9lXFEKYRP6cX54am0HUFt00DDuPh2zJC7xV1hZiNIZY=;
	b=FaauE4Z2+TjAjjGuMOPHeTrdt1D1RbWa+6EGSRnKczLvLJQhXOftLajoMi8Y/Or1HujJ7tii8Qq2hjVCiz9qOBb+p3gG/wD9JNUb1WMV3f5pZyzlRgaVUdm9YYzIaXrkG/qsBB7eiep7QIuLwQzZ9qbSgyYeWE5Zof71TduPrtw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:1fae310b-8a96-411e-957c-e5d4330ced1c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:4a2eccce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d9d2abae5dcd11ef8b96093e013ec31c-20240819
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1947335380; Mon, 19 Aug 2024 09:53:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Aug 2024 09:53:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Aug 2024 09:53:36 +0800
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
Subject: [PATCH 2/2] wifi: mt76: mt7925: replace chan config with extend txpower config for clc
Date: Mon, 19 Aug 2024 09:53:34 +0800
Message-ID: <20240819015334.14580-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240819015334.14580-1-mingyen.hsieh@mediatek.com>
References: <20240819015334.14580-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.076600-8.000000
X-TMASE-MatchedRID: EJLkrvRJ8yw0Z9sXcK7F6SmjEOrcO6AyTJDl9FKHbrnBz2A0dX3336PF
	jJEFr+olKE0Je8DR/D4NXwNUB3oA790H8LFZNFG7MGpgBNI6BaMAmqpN/LW/FDsL6l6VX2Q6YfM
	MqExvS6ooATlh54i3zaT85cjPvuTpPy8ILgLs3TgHwrRMBVxcR6V3yIRdB6FsUv+hgGJf01iAhO
	caQrQ0U1GyRcoeF18qmKP0zzpTAeGwod8xOMKmvMCBO+zxAW5pftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.076600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9ED05BC689255F93E55A654E4361CF77CD3BFF8DE060F7051FE9EA8C806E78452000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Since MT792x_CLC_CHAN is currently not in use, we have added an
extension for setting txpower to replace it.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 7fa74d59cc48..ab12616ec2b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -68,7 +68,7 @@ struct mt792x_fw_features {
 
 enum {
 	MT792x_CLC_POWER,
-	MT792x_CLC_CHAN,
+	MT792x_CLC_POWER_EXT,
 	MT792x_CLC_MAX_NUM,
 };
 
-- 
2.18.0


