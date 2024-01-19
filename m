Return-Path: <linux-wireless+bounces-2240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E15F483260E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BDDB22184
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6828E07;
	Fri, 19 Jan 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U/ShzYpo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4C24208
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654667; cv=none; b=dWEaq/ZD2PsIvo8pkXiMpUcra3gfOJdF8/4ezdZhhb97wQCIJSUFhQBeQH++ny8GfnArDtDpgzvB5WnNzFHw80+RaPyyp5b1G2StzNlnRvrsCjmk/Xqk2DFAdswBGy5/3jQyhYKbuZ9MLiH1tViUdpIFgLTDfYsxvCLVkHqOwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654667; c=relaxed/simple;
	bh=NB6gkQjrqTYDnKz2ylAeilRdqpcQRvjYET53wp4mp8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syMwgc2io863VOLfB/lCwHjbaX5IBRcDvrsm02kx2r/ix45GXo3W8+1ABAnCYBY2LX3waqQ+fsQ1zUqp5zyNWp7BamtDbG90jb6Gl/v/VAeICGQC8fGDOHlJtAQx1Xw2lYa8JgQXaVH5HyO3OozmDq0GmBCBWfpqMmmxw+HCWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U/ShzYpo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb89b938b6a811ee9e680517dc993faa-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CprID0kYRxdIpvoTLuqLkrEdyQZnRVPhVd6rP/t5gIA=;
	b=U/ShzYpoVEKFnrobGjUiC9xSu1HYeFiDUc631MVOvhbcLPW4/6dFimaOrgsPpjUzLMNz4s9Hbb9MBOe40QehmYUKBv5ndlpBQgMGKK/D4u9hRt/Q7gyCVTiyYYfmGZUrHDci/aW52EvvpKZRjp0HMyocvr92Rb4Q8hyNt839u5g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:9b567c47-5f20-439a-844d-d4bc036ef1da,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:a7a2877f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cb89b938b6a811ee9e680517dc993faa-20240119
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1488538541; Fri, 19 Jan 2024 16:57:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 11/12] wifi: mt76: connac: set correct muar_idx for mt799x chipsets
Date: Fri, 19 Jan 2024 16:57:07 +0800
Message-ID: <20240119085708.23592-11-shayne.chen@mediatek.com>
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

Set the muar_idx to 0xe for the BMC WTBL entries of mt799x chipsets.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index fdde3d70b300..98d64d3d2993 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -227,6 +227,11 @@ static inline bool is_mt7992(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7992;
 }
 
+static inline bool is_mt799x(struct mt76_dev *dev)
+{
+	return is_mt7996(dev) || is_mt7992(dev);
+}
+
 static inline bool is_mt7622(struct mt76_dev *dev)
 {
 	if (!IS_ENABLED(CONFIG_MT7622_WMAC))
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 96494ba2fdf7..3140d0cc8f59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -283,6 +283,9 @@ __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 	};
 	struct sk_buff *skb;
 
+	if (is_mt799x(dev) && !wcid->sta)
+		hdr.muar_idx = 0xe;
+
 	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
 				     &hdr.wlan_idx_hi);
 	skb = mt76_mcu_msg_alloc(dev, NULL, len);
-- 
2.39.2


