Return-Path: <linux-wireless+bounces-20295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17215A5EB39
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 06:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52242175F6B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 05:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788D153BD9;
	Thu, 13 Mar 2025 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VJ0NJdyo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6E143C5D;
	Thu, 13 Mar 2025 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844454; cv=none; b=qDo7HfWosTqef6Gd6hjzHi7KNWe8HV0OWYHQNhOLw+veefc13F5Fz5XjhXB7NjAwQLxie9xR7+tX6qCevWIGQeXk8Xk19OvqbzTziC/FpE8x65qTHGDQw9kM3nmvFebU6MbeeEN2wxP3g/pB67ZKhpOO5BvS2VeOEMM6X3wCFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844454; c=relaxed/simple;
	bh=cvJ1WpjwNFMYh8KgdX6oaa5Mr+MKL+ruG6bYl3buYMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EnwvgoABjGtiEitCYdfGPiQnvnjsw7M/dRZ9+A/WHtpGH3FS6PNx4RNx6t4eNPq1Rkp8tsEMTYEFvKuMprYNeuCMR9iTIC5nM0+lckSTD4AfmXBON17BHFSIK+8nOcTz3jF7CcWhByKvrTOJVJvwNiDvCJfZduzr6bIua7x68w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VJ0NJdyo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b641dcb2ffcd11ef8eb9c36241bbb6fb-20250313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mZm0cGChy0M1KXw6dogHejr3MLrplygnDxjWXUInMMk=;
	b=VJ0NJdyoD37pRp90jYG5jRMTlF8v6IDoYMImKv8jlzt6NFH31TMpnb2Oo7jQAPS1oC3DwbIT9Zlm6Dl5ff5ho0pkZy5uBoTVtwiStn22lHAMnQVmvhfUNHHeVvZFdQNdzW9ekxlKxh0tX6knVyJJ0NEG2akHjUVaINQre4QcMVo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:4c355ff4-d6ec-4cae-8e9b-c85763b3516a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:fc4461ce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b641dcb2ffcd11ef8eb9c36241bbb6fb-20250313
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1790761732; Thu, 13 Mar 2025 13:40:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Mar 2025 13:40:45 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Mar 2025 13:40:45 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH] wifi: mt76: mt792x: re-register CHANCTX_STA_CSA only for the mt7921 series
Date: Thu, 13 Mar 2025 13:40:44 +0800
Message-ID: <20250313054044.2638837-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

CSA is currently not supported on mt7925, so CSA is only registered for
the mt7921 series

Cc: stable@vger.kernel.org
Fixes: 8aa2f59260eb ("wifi: mt76: mt7921: introduce CSA support")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 8799627f6292..0f7806f6338d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -665,7 +665,8 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
-	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
+	if (is_mt7921(&dev->mt76))
+		ieee80211_hw_set(hw, CHANCTX_STA_CSA);
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
-- 
2.45.2


