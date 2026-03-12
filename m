Return-Path: <linux-wireless+bounces-33081-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOTtMWaOsmlINgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33081-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0F26FEE6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9C6030168AF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10013B3BF3;
	Thu, 12 Mar 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XHTajOTf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D618027
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309532; cv=none; b=nxOfNbStRLOUVJJQq/G8VxZdDJMQ7xwGqAWAtC+drb7lsnjZB0b1F0oNIncM/OErv8iNLUeqdNbka/bsL5GPjoRQcJ4UM2aZ3xc7qTAWVN0wt92vZVfl2tWiTF0sGLVnM1kGUa5e+tz3unsWuJCbFDEVQZNWMeqy2rnsHNlsZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309532; c=relaxed/simple;
	bh=hiqfHbsjfSqIdTIFKKKYeJcpyCowyw/eU0HwsorcirU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKwQv/XGwGbxrvr3kgUIpQ/i87TL1n+6v/jWugwff5+frFWEZUr0px4FTqs8JdcN8m4R33B7K6fxjNECGVCOdhhxTWSN/Ozda8R/AQHxTfaCXSVDRT1F8tSMT8kgMpi4ba7ZgB2jSzT4TbxNus2rp9MeB/Ke9NRlpBS4ErTEjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XHTajOTf; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a3f27021dfa11f1a02d4725871ece0b-20260312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fhFv8wOlQNn8u7Hm09A4AiE1G8Sr/2LMKSCJYaeXSgk=;
	b=XHTajOTfpoIgBbmkdPIvm+O9nGYGE3kDYqP7rQYYBUDS5JK9363XbZTwVNeFH6JCWxNPO0CN/52b9qxibLtddvc6jTnPmrvNtxgIchxQpAVnW/zLdGweG4J+po4PrjlHaiJAHzgYakOM6K4wMjCfNMhGqzkpBI2+wNv3+VD9HNU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3cbfc7b3-8adc-4c10-b494-d6cbf1bc43e0,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:7f6ea4d4-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:5,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a3f27021dfa11f1a02d4725871ece0b-20260312
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1892491523; Thu, 12 Mar 2026 17:58:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Mar 2026 17:58:36 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Mar 2026 17:58:36 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 6/6] wifi: mt76: mt7996: fix issues with manually triggered radar detection
Date: Thu, 12 Mar 2026 17:57:24 +0800
Message-ID: <20260312095724.2117448-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260312095724.2117448-1-shayne.chen@mediatek.com>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33081-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid]
X-Rspamd-Queue-Id: 7EC0F26FEE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Disallow triggering radar detection on non-DFS channels to prevent paused
TX queues from failing to resume, as a channel switch is not performed in
this case.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 76d623b2cafb..e26bed6b97e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -226,14 +226,23 @@ mt7996_radar_trigger(void *data, u64 val)
 #define RADAR_BACKGROUND	2
 	struct mt7996_dev *dev = data;
 	struct mt7996_phy *phy = mt7996_band_phy(dev, NL80211_BAND_5GHZ);
-	int rdd_idx;
+	struct cfg80211_chan_def *chandef;
+	int rdd_idx, ret;
 
 	if (!phy || !val || val > RADAR_BACKGROUND)
 		return -EINVAL;
 
-	if (val == RADAR_BACKGROUND && !dev->rdd2_phy) {
-		dev_err(dev->mt76.dev, "Background radar is not enabled\n");
-		return -EINVAL;
+	if (test_bit(MT76_SCANNING, &phy->mt76->state))
+		return -EBUSY;
+
+	if (val == RADAR_BACKGROUND) {
+		if (!dev->rdd2_phy || !cfg80211_chandef_valid(&dev->rdd2_chandef)) {
+			dev_err(dev->mt76.dev, "Background radar is not enabled\n");
+			return -EINVAL;
+		}
+		chandef = &dev->rdd2_chandef;
+	} else {
+		chandef = &phy->mt76->chandef;
 	}
 
 	rdd_idx = mt7996_get_rdd_idx(phy, val == RADAR_BACKGROUND);
@@ -242,6 +251,11 @@ mt7996_radar_trigger(void *data, u64 val)
 		return -EINVAL;
 	}
 
+	ret = cfg80211_chandef_dfs_required(dev->mt76.hw->wiphy, chandef,
+					    NL80211_IFTYPE_AP);
+	if (ret <= 0)
+		return ret;
+
 	return mt7996_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE, rdd_idx, 0);
 }
 
-- 
2.51.0


