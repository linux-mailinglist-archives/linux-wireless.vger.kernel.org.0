Return-Path: <linux-wireless+bounces-1212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7981C6E8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 09:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC54B227D6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B170101FB;
	Fri, 22 Dec 2023 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z9gW3/nl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D569FBE4
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9edd965aa0a711eeba30773df0976c77-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uSWtu7QGZlDy2U9rpLeluhtBrJ5IhbOXU4hBNtyp7lE=;
	b=Z9gW3/nlKBZJKVadETDNhZ1y6lUxEbpzMRnreGwFov/0SMPuL2UDB39IST4kYh7QVNFUJgm2aCZb0QZWwfrHJ8RuElahHkoUvCxqTI9n1IHMxvxZ2JrA7gTLH71XbdERoHUOMI5gv4YIF8qtI9AY9INzWSLdcL+3DADN4nkB4zk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f2e57e4b-17f2-4326-baac-3122c620f870,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:ec53768d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9edd965aa0a711eeba30773df0976c77-20231222
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 919059063; Fri, 22 Dec 2023 16:53:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 16:53:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 16:53:46 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Subject: [PATCH v1 2/4] wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz channel config from ACPI
Date: Fri, 22 Dec 2023 16:53:36 +0800
Message-ID: <20231222085338.4530-3-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231222085338.4530-1-mingyen.hsieh@mediatek.com>
References: <20231222085338.4530-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.013300-8.000000
X-TMASE-MatchedRID: PwZ81m9fkLbZK1rQqyNiGR3EEAbn+GRbI9yVcHNDU7a5ZjHyzYrpGt6M
	yUV+2+DZ+tt/G7x8wM7kQHSm+HqcuqPzznyWrbXqQpxiLlDD9FV9LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO0gCYMnfcK3PF5UWE0xOO8BLkvWsDkhjDg8nmtjrcR7Xbvmmn0nKMw9bk8+unopmQA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.013300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 778A392B4FBF824153A3D16F8A705AE2BB6A9F931D6633525BF85C5497578E862000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

In some case, the MTCL table will exist, but MTDS table will not.
So the SAR will init fail. This patch make MTCL and MTDS can exist
with no dependence.

Fixes: f965333e491e ("mt76: mt7921: introduce ACPI SAR support")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
index e7afea87e82e..8fee3d481df0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
@@ -66,13 +66,15 @@ mt792x_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
 }
 
 /* MTCL : Country List Table for 6G band */
-static void
+static int
 mt792x_asar_acpi_read_mtcl(struct mt792x_dev *dev, u8 **table, u8 *version)
 {
-	if (mt792x_acpi_read(dev, MT792x_ACPI_MTCL, table, NULL) < 0)
-		*version = 1;
-	else
-		*version = 2;
+	int ret;
+
+	*version = ((ret = mt792x_acpi_read(dev, MT792x_ACPI_MTCL, table, NULL)) < 0)
+		   ? 1 : 2;
+
+	return ret;
 }
 
 /* MTDS : Dynamic SAR Power Table */
@@ -166,16 +168,16 @@ int mt792x_init_acpi_sar(struct mt792x_dev *dev)
 	if (!asar)
 		return -ENOMEM;
 
-	mt792x_asar_acpi_read_mtcl(dev, (u8 **)&asar->countrylist, &asar->ver);
+	ret = mt792x_asar_acpi_read_mtcl(dev, (u8 **)&asar->countrylist, &asar->ver);
+	if (ret) {
+		devm_kfree(dev->mt76.dev, asar->countrylist);
+		asar->countrylist = NULL;
+	}
 
-	/* MTDS is mandatory. Return error if table is invalid */
 	ret = mt792x_asar_acpi_read_mtds(dev, (u8 **)&asar->dyn, asar->ver);
 	if (ret) {
 		devm_kfree(dev->mt76.dev, asar->dyn);
-		devm_kfree(dev->mt76.dev, asar->countrylist);
-		devm_kfree(dev->mt76.dev, asar);
-
-		return ret;
+		asar->dyn = NULL;
 	}
 
 	/* MTGS is optional */
@@ -290,7 +292,7 @@ int mt792x_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
 	const struct cfg80211_sar_capa *capa = phy->mt76->hw->wiphy->sar_capa;
 	int i;
 
-	if (!phy->acpisar)
+	if (!phy->acpisar || !((struct mt792x_acpi_sar *)phy->acpisar)->dyn)
 		return 0;
 
 	/* When ACPI SAR enabled in HW, we should apply rules for .frp
-- 
2.18.0


