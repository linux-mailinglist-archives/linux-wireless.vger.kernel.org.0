Return-Path: <linux-wireless+bounces-4975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9896B881080
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8142836EC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C663F9CD;
	Wed, 20 Mar 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N+NOqquq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB613D54B
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932976; cv=none; b=muUG/3M10k5IPtXyhqf3oo3pAfjCdXiAA1c/w9e2hizKNjZRfhKSjKt6KupvIfvTvFARMsz/h4YuvdURWBUiXFPGH1xmLErYV9tjNmYjGHeycVIZ6DeR6LgAnXOgpUD7MLQIRCrB/o+ce1MClRGRkKkXCDkcByeoY08BlQogg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932976; c=relaxed/simple;
	bh=Jafwo9PWgSuocZ2PHN7Jb+KGIcuzc1EbBMKoFDmn0vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7Lm8LJty6KM8yhJzWgRNuOrWuswzPPH47fVcJfeAvj6UrGkNcuLF4OGokuJwE5T1vunRws3slGB/HcWmvUrWi/HiRjcApVm/Vq6H7ySPl56sQK+V6IQW0bI9dZJpf39wQ7joM2yOAi1Y7WfJIlWgvYSfmVx5pwXlb0ycJb40GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N+NOqquq; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4fe585aae6aa11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IuSTDGeofZhD3L2ID+12WcjJiSjw0EsOzM85qlyQ3e4=;
	b=N+NOqquqz+WVRGwysktPv/V8F0DEJ7cWkfdGn8+mAt0zOCaQHz1FEbzZgAV6RwnL11Yq8rTIbjaao9hyJz8gq6V/GGf/s3ixF+T+2OztgQ1L9L0kEr7MGghNaz/yGccYxjsWA7h+hfViu/47kEsmAu8+zSz6hJnWRSZ2Scr8SXk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4c46471d-f40e-4fed-b697-dcc6f74566a6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:dc05a090-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4fe585aae6aa11eeb8927bc1f75efef4-20240320
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 245555959; Wed, 20 Mar 2024 19:09:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 19:09:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 19:09:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 07/10] wifi: mt76: connac: enable critical packet mode support for mt7992
Date: Wed, 20 Mar 2024 19:09:15 +0800
Message-ID: <20240320110918.3488-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320110918.3488-1-shayne.chen@mediatek.com>
References: <20240320110918.3488-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

For mt7992 chipsets, critical packet mode should be properly configured
to let the HW SDO module correctly fill the AC queue in TX descriptors of
some higher priority packets such as ARP and ICMP.
Without this patch, HW queues may hang when running MU traffic.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt7996/main.c    |  8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c     | 13 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h  |  1 +
 4 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 608deb47dada..836cc4d5b1d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1220,6 +1220,7 @@ enum {
 	MCU_EXT_CMD_TXDPD_CAL = 0x60,
 	MCU_EXT_CMD_CAL_CACHE = 0x67,
 	MCU_EXT_CMD_RED_ENABLE = 0x68,
+	MCU_EXT_CMD_CP_SUPPORT = 0x75,
 	MCU_EXT_CMD_SET_RADAR_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 995c265442df..338ff10b121d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -35,6 +35,14 @@ int mt7996_run(struct ieee80211_hw *hw)
 		ret = mt7996_mcu_set_hdr_trans(dev, true);
 		if (ret)
 			goto out;
+
+		if (is_mt7992(&dev->mt76)) {
+			u8 queue = mt76_connac_lmac_mapping(IEEE80211_AC_VI);
+
+			ret = mt7996_mcu_cp_support(dev, queue);
+			if (ret)
+				goto out;
+		}
 	}
 
 	mt7996_mac_enable_nf(dev, phy->mt76->band_idx);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index d5e35f6dd52e..ccae954a22f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4530,3 +4530,16 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WM_UNI_CMD(TXPOWER), true);
 }
+
+int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode)
+{
+	__le32 cp_mode;
+
+	if (mode < mt76_connac_lmac_mapping(IEEE80211_AC_BE) ||
+	    mode > mt76_connac_lmac_mapping(IEEE80211_AC_VO))
+		return -EINVAL;
+
+	cp_mode = cpu_to_le32(mode);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WA_EXT_CMD(CP_SUPPORT),
+				 &cp_mode, sizeof(cp_mode), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c30d133d9a71..b9b0bb4c408b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -612,6 +612,7 @@ int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif
 int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta);
+int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
-- 
2.39.2


