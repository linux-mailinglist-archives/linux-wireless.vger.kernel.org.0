Return-Path: <linux-wireless+bounces-20920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2A3A743A7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86FF3AEB88
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7DC211713;
	Fri, 28 Mar 2025 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sKxQv8O3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B0211489
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141248; cv=none; b=Ij6GZ7Bs3L3wk9IrioQMzJFEDQGufAWnyf6iNxOQMOZN7Fn6ypGN74FuS63JxY41WA7fWsnBGO7MT2TcmeG9JQCvP6xMBCjNjd6QORcuw/ILoUaUHMR+Jm7sIlAdwIOSjD4jA8kP3c7KxNbkdCbds1AWGxXOGTe0D3tpIIw5GEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141248; c=relaxed/simple;
	bh=slYi5JPhrAXzP5ONxIjaoIgG5RHpG5+4Qiv42uEFyPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdyYKxXKZJ7c1aRboknEDhxZDiIkXeO7JhIA4NRrkxZOZ2krHqDK89KUwqHZi+JFusQqleyiNzKZ7JcPRetyDr84Y/NHvADZ9gUTB7nQvGDd049ik6tFGZLU6/yqYYuGwCTkt3uI89/ES7/JiB/cOUBGrbJTChSPgp6V9UM00IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sKxQv8O3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0af8f8860b9911f0aae1fd9735fae912-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bE7DuDSTFqH1HmS0tJowwRUHqJhiLzwWQvWJd3DnfyI=;
	b=sKxQv8O3luhFlKg/wK0cq6AUxokl33ZLFoFVM00CzHHjjL1wRFyidHftj+fWEMn5ORsasE2neYm4qt8FoAPX/Xc/Mv4SVo8/cR6F5u6rVzboseemzjwiV7aUNDQHEiQDZ44Mj4IUvU3H1pMyDlU8pZOX70BX4KK3L4LYgC9B0I8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6bce00f8-3f3e-48fe-a437-ac37c0d16750,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:049c67a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0af8f8860b9911f0aae1fd9735fae912-20250328
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1255489574; Fri, 28 Mar 2025 13:53:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Howard Hsu <howard-yh.hsu@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>
Subject: [PATCH 07/10] wifi: mt76: mt7996: adjust HW capabilities for mt7990
Date: Fri, 28 Mar 2025 13:50:55 +0800
Message-ID: <20250328055058.1648755-8-shayne.chen@mediatek.com>
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

From: Peter Chiu <chui-hao.chiu@mediatek.com>

This is a preliminary patch to support mt7990 chipset.

Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 9 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 2865cab31390..9192fbdbc7da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -440,6 +440,9 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = max_subframes;
 	hw->max_tx_aggregation_subframes = max_subframes;
+	if (is_mt7990(mdev) && dev->has_eht)
+		hw->max_tx_aggregation_subframes = 512;
+
 	hw->netdev_features = NETIF_F_RXCSUM;
 	if (mtk_wed_device_active(wed))
 		hw->netdev_features |= NETIF_F_HW_TC;
@@ -1064,10 +1067,10 @@ void mt7996_set_stream_vht_txbf_caps(struct mt7996_phy *phy)
 	*cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
 		IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 
-	if (is_mt7996(phy->mt76->dev))
-		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 3);
-	else
+	if (is_mt7992(phy->mt76->dev))
 		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 4);
+	else
+		*cap |= FIELD_PREP(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK, 3);
 
 	*cap &= ~(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK |
 		  IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 2dd33f303a06..92b01ed82e7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -14,7 +14,7 @@
 #define MT7996_MAX_RADIOS		3
 #define MT7996_MAX_INTERFACES		19	/* per-band */
 #define MT7996_MAX_WMM_SETS		4
-#define MT7996_WTBL_BMC_SIZE		(is_mt7992(&dev->mt76) ? 32 : 64)
+#define MT7996_WTBL_BMC_SIZE		(is_mt7996(&dev->mt76) ? 64 : 32)
 #define MT7996_WTBL_RESERVED		(mt7996_wtbl_size(dev) - 1)
 #define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
 					 mt7996_max_interface_num(dev))
@@ -482,7 +482,7 @@ mt7996_phy3(struct mt7996_dev *dev)
 static inline bool
 mt7996_band_valid(struct mt7996_dev *dev, u8 band)
 {
-	if (is_mt7992(&dev->mt76))
+	if (!is_mt7996(&dev->mt76))
 		return band <= MT_BAND1;
 
 	return band <= MT_BAND2;
-- 
2.39.2


