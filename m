Return-Path: <linux-wireless+bounces-20946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC46A75705
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113343AF007
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67C1DC992;
	Sat, 29 Mar 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="APeo9DS8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DF1D47A6
	for <linux-wireless@vger.kernel.org>; Sat, 29 Mar 2025 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743263267; cv=none; b=AYURUhqe4yY16ig/a1fT2PORlHJkq/NK5LIC0bsOOyF9WWExh6ODS8b5zS3I62pmVgWTrHlEBMTq4BvsPxEL50CJnKk3PF4RaMG9jgaobJdCLonqtUj42Sm48T0+7Ogst5FvZRNlW2VsS3RFTsQ4KFt+appnNFGVK4jhDtFMXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743263267; c=relaxed/simple;
	bh=nccKHvDqEW9G7chflGt4UuogdYPV/UlYIih13a+/77g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPrl8KmgoxbKkIM3NL1gzR2quIJhYuZJDeTY+ArhELcDIS9JCT2lt6MCGM/A1QK9mGjSEG/CP65xBBDbIQNg9UcD71rm2GnWkJHlYLupM5XZ/As9QcA3JM3Xj6h9kJAqKPnplxuMVyMSL5ig7lInIjBSEkGO9Emn63q+Vl4BlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=APeo9DS8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 24c70b140cb511f0aae1fd9735fae912-20250329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wA6tB5jf2eHCDBLI/SlO3iktMUtN5Y+F51SNFTax68w=;
	b=APeo9DS82GURhNNUiwRejFN94DhUsrsnwUyN0eyJrAIcwfzb82Gp4lGD/raogWpslj1ixDNDhKqnoBFsIeZp8MWc9z79TvlwtmAznoRkvwFb+dqxgdYvT9JBopZgK5BQ0t18h6MXhX2YFsKyi1kpzJh1rRxijZAeoptVh4bAD/I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1a3d937a-4a20-4a4e-8d3b-05f34263d13b,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:e7f9b64a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 24c70b140cb511f0aae1fd9735fae912-20250329
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 413143942; Sat, 29 Mar 2025 23:47:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 29 Mar 2025 23:47:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 29 Mar 2025 23:47:38 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next v2 06/10] wifi: mt76: mt7996: add eeprom support for mt7990
Date: Sat, 29 Mar 2025 23:47:26 +0800
Message-ID: <20250329154731.2113551-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250329154731.2113551-1-shayne.chen@mediatek.com>
References: <20250329154731.2113551-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Add eeprom definition and default bin file for mt7990.
This is a preliminary patch to support mt7990 chipset.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 51b09956486b..6f3eb053ef02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -17,6 +17,8 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
 		return is_mt7996(&dev->mt76) ? 0 : -EINVAL;
 	case MT7992_DEVICE_ID:
 		return is_mt7992(&dev->mt76) ? 0 : -EINVAL;
+	case MT7990_DEVICE_ID:
+		return is_mt7990(&dev->mt76) ? 0 : -EINVAL;
 	default:
 		return -EINVAL;
 	}
@@ -39,6 +41,10 @@ static char *mt7996_eeprom_name(struct mt7996_dev *dev)
 				return MT7992_EEPROM_DEFAULT_MIX;
 			return MT7992_EEPROM_DEFAULT;
 		}
+	case MT7990_DEVICE_ID:
+		if (dev->var.fem == MT7996_FEM_INT)
+			return MT7990_EEPROM_DEFAULT_INT;
+		return MT7990_EEPROM_DEFAULT;
 	case MT7996_DEVICE_ID:
 	default:
 		switch (dev->var.type) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f017d30e1c49..a4c2986fcffd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -943,6 +943,9 @@ static int mt7996_variant_type_init(struct mt7996_dev *dev)
 		else
 			return -EINVAL;
 		break;
+	case MT7990_DEVICE_ID:
+		var_type = MT7990_VAR_TYPE_23;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 148271fcd88f..2dd33f303a06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -73,6 +73,9 @@
 #define MT7992_EEPROM_DEFAULT_23	"mediatek/mt7996/mt7992_eeprom_23.bin"
 #define MT7992_EEPROM_DEFAULT_23_INT	"mediatek/mt7996/mt7992_eeprom_23_2i5i.bin"
 
+#define MT7990_EEPROM_DEFAULT		"mediatek/mt7996/mt7990_eeprom.bin"
+#define MT7990_EEPROM_DEFAULT_INT	"mediatek/mt7996/mt7990_eeprom_2i5i.bin"
+
 #define MT7996_EEPROM_SIZE		7680
 #define MT7996_EEPROM_BLOCK_SIZE	16
 #define MT7996_TOKEN_SIZE		16384
@@ -143,6 +146,10 @@ enum mt7992_var_type {
 	MT7992_VAR_TYPE_23,
 };
 
+enum mt7990_var_type {
+	MT7990_VAR_TYPE_23,
+};
+
 enum mt7996_fem_type {
 	MT7996_FEM_EXT,
 	MT7996_FEM_INT,
-- 
2.39.2


