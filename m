Return-Path: <linux-wireless+bounces-24034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4355AD67E8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F08C7A7ABC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 06:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073291F0991;
	Thu, 12 Jun 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RrNJ+46u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAD1F3B98;
	Thu, 12 Jun 2025 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709258; cv=none; b=PZ97oKliv2T+bRxgNn4GYcuGWIRXrU5OND2hxlDhWEg6x72rs1baraLb/gqP1guKuaHUgXy7XYZ9ngGw8ZKNzFqDMzRdD16Vs88f9XP6Etz9CtXs2NlBj7dKCMSVhtU3kPvjd4Hw0uJ0KVS9ZN5Lb7rkrIFqjClzANX3ZcqIHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709258; c=relaxed/simple;
	bh=ojsbwyH59F5Jp9teEXuI0ovZhoR5vYZZ21JJdWmQpfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmOzZc7LXrvXdOErlRJayXQuQltzBH2DSAftddxm1dodpYfXphXU+JrvkKTl+5zgMZ7jPW06iPibUIhJxkpMDZm3eUOsKtNHpvGZRpceuTCpZOagRPK/+vPtsd7VSJydbzGQsBKHuKdXGQppOP6i7o2OlaLq7u91BtABuOYwOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RrNJ+46u; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 62395f80475511f0b910cdf5d4d8066a-20250612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NUZ6ZLFO3Sr7Q0l5Coxwe0qp3xU21QgYUZFflSsuWJE=;
	b=RrNJ+46ucyqHtH63F0+DjpDSXVhr/b9fhOmgWKGLy/yewS782DEN3CJXoe1GnxwDN/QLYP1K2ushvDptShLtaoCxdEM414+Ht1metKb8euXkcCQ41sBOOkJuOy2lNPl0BywDhfTWNLcFtPWkCc3KithjI6+rLRT3y6StQ/1SPs4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:6ed11a4e-0fca-462c-88a0-4208889f4b4a,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:09905cf,CLOUDID:ee006028-fdd2-4021-9c0c-83548fdcf243,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 62395f80475511f0b910cdf5d4d8066a-20250612
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 569675781; Thu, 12 Jun 2025 14:20:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 12 Jun 2025 14:20:47 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 12 Jun 2025 14:20:47 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	<stable@vger.kernel.org>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: fix invalid array index in ssid assignment during hw scan
Date: Thu, 12 Jun 2025 14:20:46 +0800
Message-ID: <20250612062046.160598-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Michael Lo <michael.lo@mediatek.com>

Update the destination index to use 'n_ssids', which is incremented only
when a valid SSID is present. Previously, both mt76_connac_mcu_hw_scan()
and mt7925_mcu_hw_scan() used the loop index 'i' for the destination
array, potentially leaving gaps if any source SSIDs had zero length.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index db85a9d984c5..660c8df89910 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1740,8 +1740,8 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (!sreq->ssids[i].ssid_len)
 			continue;
 
-		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
-		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
+		req->ssids[n_ssids].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(req->ssids[n_ssids].ssid, sreq->ssids[i].ssid,
 		       sreq->ssids[i].ssid_len);
 		n_ssids++;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 2bd506a4208c..66bac3047b2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3178,8 +3178,8 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (i > MT7925_RNR_SCAN_MAX_BSSIDS)
 			break;
 
-		ssid->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
-		memcpy(ssid->ssids[i].ssid, sreq->ssids[i].ssid,
+		ssid->ssids[n_ssids].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
+		memcpy(ssid->ssids[n_ssids].ssid, sreq->ssids[i].ssid,
 		       sreq->ssids[i].ssid_len);
 		n_ssids++;
 	}
-- 
2.34.1


