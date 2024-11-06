Return-Path: <linux-wireless+bounces-14945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE49BDB3C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 02:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75ED1F235A4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446E3D66;
	Wed,  6 Nov 2024 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pa2ONbeJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D8158DB2
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856756; cv=none; b=m8Z8SzRmXK7mm8ozjHKr5ijN7y7uYa9ndZHbuzOAafY6D/Vwxseu1jlvD2H2T08FNgLX9fpo+6yHzgU1PTJRwUeJgMTfEFTSb05Kz84kGNS67B8/Dz0wiDOuF4tkASsmfCfeTLECKSvhHgyxQoMrLsj2URBoH55FCkhvb+G3670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856756; c=relaxed/simple;
	bh=2gOsFGLk3AvMagSoYVS0KD1BPhpOK6rJZrqz5je8WbI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vvcr/YoEzL0p06u+y53HKZVgfiTZHd8tzBEJw59r99hxAAGSeHSiOIlrxeFlr1FnoGKZAfRUXNAQetJGUYlJFBe9XWQMcCnLqD0ZB3uFY3CAAhQCjNgfbZLudtY/5jeI+t1W92ukSeIIpoZExNvmdAOOw+WUE18FN50vxLL3ylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pa2ONbeJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fa4d6c9e9bde11efb88477ffae1fc7a5-20241106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ri1dP8qTmKMrFKqN7oRAYijy4l9bHKG+uziEJXybHfA=;
	b=pa2ONbeJUYCrFnnJISKyChnxtOxlZJtkCv1k2x2d9zrXv+VjxBXoyENWmT0r0PmSGC/ONrXTcqOPfaxDVPKmgDjS3ElNz34R/PJTtdKmy7S55GZGvQy7o1dN5Qx9K8I2UNpjx3rcPhizzzB+CRc79Mm/s+bLCxU5vyDXiUVqEWQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:43863807-c7b1-482f-8c8d-2eb3622a83b3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:cf309ee7-cb6b-4a59-bfa3-98f245b4912e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fa4d6c9e9bde11efb88477ffae1fc7a5-20241106
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 854749160; Wed, 06 Nov 2024 09:32:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Nov 2024 09:32:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Nov 2024 09:32:22 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7925: config the dwell time by firmware
Date: Wed, 6 Nov 2024 09:32:21 +0800
Message-ID: <20241106013221.18101-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.676100-8.000000
X-TMASE-MatchedRID: GLqgwom0iafeG4FwcWqASxuZoNKc6pl+5E5u1OdPWsQY0A95tjAn+9D1
	SFVeE0DsM+nnsEaleMpfMrorr76P9n45uBZmw209+Fq9Vk/m1NquiRuR9mCaunq20v2fBg+yKk6
	C52OIvQM6hUOcTonr9IAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGmGCGZ0is/hFpHlYEKjauX/oaw
	rSXN+oWyt8lLomVQ74Nhky21Ht6YHxJizFgOHBt/Xjw0U5wIKIxmggkozZRimqXQwORNRFP2Dg1
	oiqtsL2dATQdtPksR+3/JiWOe6GXXSWgQ2GpXdZbxffl9hhCBw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.676100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7F26C053AC1D8E30EB939707C38642E8135BCB38EA527B1764D0305CC61253102000:8

From: Michael Lo <michael.lo@mediatek.com>

To optimize the scan time of mt7925, remove the dwell time
setting for the scan command and let it be controlled by
the firmware as mt7921.

Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  - change author's mail format

 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0c2a2337c313..4226baf3cfcb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2643,14 +2643,12 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
 	return err;
 }
 
-#define MT76_CONNAC_SCAN_CHANNEL_TIME		60
-
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct cfg80211_scan_request *sreq = &scan_req->req;
-	int n_ssids = 0, err, i, duration;
+	int n_ssids = 0, err, i;
 	struct ieee80211_channel **scan_list = sreq->channels;
 	struct mt76_dev *mdev = phy->dev;
 	struct mt76_connac_mcu_scan_channel *chan;
@@ -2686,14 +2684,6 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	req->scan_type = sreq->n_ssids ? 1 : 0;
 	req->probe_req_num = sreq->n_ssids ? 2 : 0;
 
-	duration = MT76_CONNAC_SCAN_CHANNEL_TIME;
-	/* increase channel time for passive scan */
-	if (!sreq->n_ssids)
-		duration *= 2;
-	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
-	req->channel_min_dwell_time = cpu_to_le16(duration);
-	req->channel_dwell_time = cpu_to_le16(duration);
-
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_SSID, sizeof(*ssid));
 	ssid = (struct scan_ssid_tlv *)tlv;
 	for (i = 0; i < sreq->n_ssids; i++) {
-- 
2.45.2


