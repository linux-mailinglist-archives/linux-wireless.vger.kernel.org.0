Return-Path: <linux-wireless+bounces-20914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775A2A743A2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2391F189338B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3602721129A;
	Fri, 28 Mar 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WC9PV36P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF519D086
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141246; cv=none; b=gYC/XZRofS/47NEGPZsBy/pO93p70nU9+3rjM2IW+Y26XOHKW+Yf5ccB124gC3DH1h1bl68JeaH33N48jNTeWTXpULmqOQalH9SH1+lM2jf0mhTohnO6j7X5EYHryKosrerzL80awxliX2S4hlFXxXNe/Y1eT1iKa/v9+g3I+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141246; c=relaxed/simple;
	bh=laBQ0BPWAzMVzYgh7JSuZoeaaxvI9iqh8HLfNtnPkJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZX0gvDgXjueceDiKDsUsx7K+kFmSVXAFQcu6UyPYgn+UBS94VAsz4w4fHQfeD19Lc0sllmCvBpJvOJFG5/Df0XMiUNW1lQLWPsYywKXBp+4dbF1WwuhcELTzjoVHeLa1ZwlGaTQb5iYofppEgn4nYOteu9okMrkX7sOL3wjcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WC9PV36P; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0ae494900b9911f08eb9c36241bbb6fb-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=69PLrnKDSkWLBAn6mbZ7O2rqd8N5RBtQ/FMsieVTxiI=;
	b=WC9PV36POorIbt8wGQJwp1Atk9Llsi1CbJdSm/YLcaqrhJ8a8L2IZQWDycqdBZXYGBBZUoJ5Gn9boTAZlQBX353uBaSeB4TAopTEQmOrDxK6pOSxf7TaKjMfa4RO8Wo6uD+g7dandbrdd8dtRPbaJ/S71AZkWTK/y5HsPae4abc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1b27d854-338f-4d12-b7af-360fd49be1d2,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:f9c9e6c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ae494900b9911f08eb9c36241bbb6fb-20250328
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 545018564; Fri, 28 Mar 2025 13:53:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:57 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 06/10] wifi: mt76: mt7996: add eeprom support for mt7990
Date: Fri, 28 Mar 2025 13:50:54 +0800
Message-ID: <20250328055058.1648755-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328055058.1648755-1-shayne.chen@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
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
index f017d30e1c49..2865cab31390 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -943,6 +943,9 @@ static int mt7996_variant_type_init(struct mt7996_dev *dev)
 		else
 			return -EINVAL;
 		break;
+	case MT7990_DEVICE_ID:
+		dev->var.type = MT7990_VAR_TYPE_23;
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


