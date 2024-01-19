Return-Path: <linux-wireless+bounces-2234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6AC832608
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD045285825
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846A20B04;
	Fri, 19 Jan 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i8jT+lvM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC331E896
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654665; cv=none; b=HButDvlu6dvHzrlPMa3krfdnT7gBWW6+QgDy/b2QKW6M6oSpOzKqFET/2CqrpY1NmeVGh01ark91K4dLW2PogJ0FKubNaFJ2zRpGxJ8q8MeLQh3MZgPPMz3LwxX9nNcMD7Ch9kg9EuKI1SSc60CR+RZ2PsAZ3WEfCSFaj+yyV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654665; c=relaxed/simple;
	bh=iQ50UnkfJ9pI/F2P/t14Iwlu+lRPaxoMbDXYBIB9DmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y13D7raseG0QSu4CoopeTw8DDGsF/QokEHdMPLjsyDsojmgZSkXflvBdya0pt0jOk01mmue5PqXExOlTrpVFml9q7Re/uZ/vRMmtBRxTobjcx7RYT2p+Y3293Q2Qbrj7vevg2XfjiBn1cuA8APZDDog8EozfWxKvpzJ2GuO5Y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i8jT+lvM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: caaebc52b6a811ee9e680517dc993faa-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Sda5kZdyKKIJK2I43a9AKWlXy5NJNzHmEBQEBx80YOQ=;
	b=i8jT+lvM/S1eTHOHt1/bEwktxXxlL9i202KCL7GMJALLS3pi1DS1ZYqrzZZgyglA3tBhpZaUTD+FwaAqANgk7WEvsYQgKYLrifEyLg5I6z7u8IxXip2PqWpDbC8h/TTG4vpkrfuIBrUu9DUMXsuE+vYJDEg5RIUd5lIyZtv/P4E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:501bc3b6-2cbf-4286-88ad-20b23242e9fe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:077b6e8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: caaebc52b6a811ee9e680517dc993faa-20240119
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1358174282; Fri, 19 Jan 2024 16:57:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 06/12] wifi: mt76: mt7996: fix HE beamformer phy cap for station vif
Date: Fri, 19 Jan 2024 16:57:02 +0800
Message-ID: <20240119085708.23592-6-shayne.chen@mediatek.com>
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
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Set correct beamformer capabilities for station vif in HE PHY
capability IE.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 0cf0d1fe420a..1a1a60744272 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1012,11 +1012,12 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 	/* the maximum cap is 4 x 3, (Nr, Nc) = (3, 2) */
 	elem->phy_cap_info[7] |= min_t(int, sts - 1, 2) << 3;
 
-	if (vif != NL80211_IFTYPE_AP)
+	if (!(vif == NL80211_IFTYPE_AP || vif == NL80211_IFTYPE_STATION))
 		return;
 
 	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
-	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+	if (vif == NL80211_IFTYPE_AP)
+		elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 		       sts - 1) |
-- 
2.39.2


