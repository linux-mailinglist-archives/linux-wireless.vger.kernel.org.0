Return-Path: <linux-wireless+bounces-11536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A786E954631
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5067B284C6E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36110175D32;
	Fri, 16 Aug 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mMvdUXzA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF01714BB
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801827; cv=none; b=BLqD+vIEs+9HVM4pQohuiWkA1h2xka5PrMs4wANzzp9KdLYqaDodbHSGmFBHgwJSB3PWp6AMHudIsMPuZmt982WH4Za8f4N8E3D0zjYeajEXXvu0AXEowL2QeK0DwU8SX+73Fv0fQARnsxvqRkfB/ApLzwtfisgylQoox+oTm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801827; c=relaxed/simple;
	bh=lQHwPwby+ftfXmYYR5pfcTxP9lDuPuMKlTcmuwi5JG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDqisqwLXudi8cTFwH6tHMHVfKLj/UgftIJeR4Zd4edGwYNMpkhMf4tq4BSZc2wt4FhMv0M49SJFR+SgZf2BJ2lQI0FPjTu8ywfRpBo4l5GBrIXu02aC5hsD0HNtEwcEcEOEhI/X/9B/Ri++dORtrDyi4JRl+ePcONg8bxQHeTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mMvdUXzA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef58c5965bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3ac/CoJAvnZ57l4lpWdjj1Y8Wm4d7QoaRRF8O7x0jEo=;
	b=mMvdUXzAgWy7imQRkUQ7vNCyQlcCMz0y5+wLVKct4RF04Jwk6HOsUJx/HTs9kOjYu+3as6sQQPP6n/S1i6ULDfiZBbETv60pe2aTHI47FPuFmo07IU/1iMKTkhjLvpq4H7LanXXme74IMlFm73OAZ9InHnjFowjbRFltCv0auec=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6c9ca8a2-ba48-4d69-a15b-8183cebb6451,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:56c6b6c1-acff-4a0f-9582-14bcdf4ed7e0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ef58c5965bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 902171879; Fri, 16 Aug 2024 17:50:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/12] wifi: mt76: mt7996: advertize beacon_int_min_gcd
Date: Fri, 16 Aug 2024 17:46:28 +0800
Message-ID: <20240816094635.2391-4-shayne.chen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.436600-8.000000
X-TMASE-MatchedRID: hJoPGlKDQFkVAKRaMHqjDj+qcn/TbYs0Xs5nqGvDCfOFAnvBzkQqV/9T
	oIqmlx19ThbvLLI8RvNI3Y0ZCr7oV+a9R6LXDub0ngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
	Wy9W70AHCttcwYNipXxf2ukFm4ENtlNViJYwGR5xLkSe5Uzq3PwzUb5WmzuH2dr83lAQ2WkSqne
	Bcz+h3ZtKryvPV5ZMDiumysd8Ts3NrUlhyhVbKc6Uwz4WJNe+7dmtRsRmKkASJZPT2ZDPuzPD2Q
	fzMDLjho65UufHcDvg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.436600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 395214C32238876138A90FB0F373515F65F97686783533E8248EBBD7D12D06B62000:8
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Advertize beacon_int_min_gcd as 100 to allow setting different beacon
intervals on different interfaces.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 283df84f1b43..4d6157e49b16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -42,6 +42,7 @@ static const struct ieee80211_iface_combination if_comb[] = {
 				       BIT(NL80211_CHAN_WIDTH_40) |
 				       BIT(NL80211_CHAN_WIDTH_80) |
 				       BIT(NL80211_CHAN_WIDTH_160),
+		.beacon_int_min_gcd = 100,
 	}
 };
 
-- 
2.39.2


