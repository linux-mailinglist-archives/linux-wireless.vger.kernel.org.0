Return-Path: <linux-wireless+bounces-28649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D02C3949D
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 07:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D00D4E20D2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DD2D94A0;
	Thu,  6 Nov 2025 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="piVKpoqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81D2D8781
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411389; cv=none; b=lWq9bnMgsXzqb0OthoAG8mJlD3F/EBIpbzKtB0pE9b564em4eGRB/zF6wXKOupV+OpyQsRABMKDWal2kxNF2eOMGgtGHm1ciOWh9POKcVIUWDsX4xmFGm0GRnWgzNMZTwDnV5a6Vt/Pr+U3Fr0T1M5Mct4nDmEKSWehkHyuJ4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411389; c=relaxed/simple;
	bh=Xu1xqRbJcfrHRh0B/P6MrC7kxR8VDHXAGrt39Kbh/IY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMYpk8xUyE6wvwqEJoXZbVTxl/Z8QuPC+6km/COfd9TUUkLruNqn7pUR+OXGyT8+011aPuWOnwTsE++nXkdOtouz0IzWikgXOxM9R27fKynWeFllRQ68xhaZ0jCl/8BY3fOD2BWjdiumU9jybgJPV46zIJTz8fmwfIzI++FiNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=piVKpoqN; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6c35672badb11f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j/JbcvvpXqlSsVupkccc+rlTyXgBtDi3c1/kNprVr7w=;
	b=piVKpoqNVmS+qaQ0S+32vQ8G3QbjoU39gCVyERnrOlkDczbcmgxTUEUrL4OJjejVd27619kWlBUcODWGom/okoyWdmrOwmBZMGPWHDi311Ek1LmMmMNtWhVpcfqo2H28rscYsu4dPyAr38QXh65rkHmTeJplkdPaeM2TneH44GA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dcdd508e-863b-4d25-8387-4da9d9cb015d,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:7cfdfa18-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d6c35672badb11f08ac0a938fc7cd336-20251106
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 405479720; Thu, 06 Nov 2025 14:43:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:43:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:42:59 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 v2 03/12] wifi: mt76: mt7996: fix implicit beamforming support for mt7992
Date: Thu, 6 Nov 2025 14:41:54 +0800
Message-ID: <20251106064203.1000505-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106064203.1000505-1-shayne.chen@mediatek.com>
References: <20251106064203.1000505-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Fix the ibf_timeout field for mt7996, mt7992 and mt7990 chipsets. For
the mt7992, this value shall be set as 0xff, while the others shall be
set as 0x18.

Fixes: ad4c9a8a9803 ("wifi: mt76: mt7996: add implicit beamforming support for mt7992")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e97984693290..82dd34a8780f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1825,8 +1825,8 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	bf->ibf_nrow = tx_ant;
 
 	if (link_sta->eht_cap.has_eht || link_sta->he_cap.has_he)
-		bf->ibf_timeout = is_mt7996(&dev->mt76) ? MT7996_IBF_TIMEOUT :
-							  MT7992_IBF_TIMEOUT;
+		bf->ibf_timeout = is_mt7992(&dev->mt76) ? MT7992_IBF_TIMEOUT :
+							  MT7996_IBF_TIMEOUT;
 	else if (!ebf && link_sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->ncol)
 		bf->ibf_timeout = MT7996_IBF_TIMEOUT_LEGACY;
 	else
-- 
2.51.0


