Return-Path: <linux-wireless+bounces-11532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F101595462C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E19285DB6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5FF16F0D2;
	Fri, 16 Aug 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MhQxnBrI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A815B102
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801823; cv=none; b=ig6oYlVgCeoUTqjk4TSmvZGUrCP4NiksA1b5KMjt1hM0TLsWcA1udElVtk0+JU4VVStwwGBgVWsFfaLW4uuuimkG1ifO5O43AGPMahqnfz0U2eM5s8bO9qIlYdO4qgWmOq2C3TbZWtVZPZG0HKElelVbMH7k86CljoYJgbigeYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801823; c=relaxed/simple;
	bh=F+NdsPwnM9dmzi+rqmdG6mzvGr9a/8fAhmk23RXdvgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3j13FdRtbKtNav/jXp0tiSz/AaQouzGKik64JZdhsYGF700+KEC+zNY0sQAKIr5+/LbQjnjRS8liIUrmiajJOQTcJM3ceSAfg9tLOn0XlvtgNA2LCTFMs0tl3uR3o+jV+PUdF6SCElNIpuhn2aiG4+rGfMpDGWBPdsSxS4b6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MhQxnBrI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f00b99285bb411ef8b96093e013ec31c-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DHtJQXl9I4VE1DNLkw9ZHfypQqZaoP+abQZ/1/h9Hwg=;
	b=MhQxnBrIH5c+hO5pQoniUloaJD0vwy2hoiAvhJTwPjY/DicV5akHtGtIytDnWBdRvRdH42/4b743xhDxjJYLsn+oNqu1fxOILM9d2iUaPEnE7lRZ+eVUrS5b+ujdBPPxEh1vlQJQz8jZgsVYongFpxqkUdMne5TA21DhBMTnVaw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:376e4f5a-d8ea-485f-b09c-23f7a66a7eb2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:0bad403f-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f00b99285bb411ef8b96093e013ec31c-20240816
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 991457903; Fri, 16 Aug 2024 17:50:15 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH 08/12] wifi: mt76: mt7996: fix EHT beamforming capability check
Date: Fri, 16 Aug 2024 17:46:31 +0800
Message-ID: <20240816094635.2391-7-shayne.chen@mediatek.com>
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

If a VIF acts as a beamformer, it should check peer's beamformee
capability, and vice versa.

Fixes: ba01944adee9 ("wifi: mt76: mt7996: add EHT beamforming support")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e68724e54013..daef014954d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1429,10 +1429,10 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 
 		if (bfee)
 			return vif->bss_conf.eht_su_beamformee &&
-			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
+			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
 		else
 			return vif->bss_conf.eht_su_beamformer &&
-			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
+			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
 	}
 
 	if (sta->deflink.he_cap.has_he) {
-- 
2.39.2


