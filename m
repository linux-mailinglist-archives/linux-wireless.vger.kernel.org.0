Return-Path: <linux-wireless+bounces-28561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C74FC34E2B
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 10:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFDFF4FE289
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801B302CAB;
	Wed,  5 Nov 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YqJ5jL17"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA53302CC7
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335097; cv=none; b=DE+hAt70In0kMcBAwI4IXzmsms71fjsEXH0lth/Tg+sdldhH8hn2t4AJ1M5GzlE20BSztZhiRvPssuRozgpLBPZ14s2Z8xzr/Uo7b1iy7A1Tf9uDcxXYx+z+xyso/e4yJzSm5l27CeNHK6CFXrcV2ZbDlO86KXgC8fKOsbyCc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335097; c=relaxed/simple;
	bh=+HM/LV9qhiQVuDtZjlOxGRkL2dhp0twEHHQjM/L40G4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3fG4g+/5Yp8uMXCvzWRc+ZvJVsHy1SFm088LrRHaOEuJ9QGlm/6IBEjTwv+gFavGV44ZCCNjGl+bTpwt2Da2rtKDX8FT3upIIsz6T71QRAUsq6Mlai1a8KHfmJsYEXGdJZzJbEU7/dyaEE+pl2+SZ35aCUmxE2AkiKeJyVy0E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YqJ5jL17; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 36192afaba2a11f0b33aeb1e7f16c2b6-20251105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ck3pytnjEP+Z1woejd35u89syHG3XzFHnYHjnbV9wC0=;
	b=YqJ5jL170R1UnyV7YhP3igjpsLkFx5DLOQNXoIwOtwY3FA8nJO8IvhVLjmrb+Gp60tgBDfVOQioEs2p7YoaQDmODpcmkfYqrrv6CCnAngwvgvghHEqfY+zLD/hYWgVSutaurXnU5++bB/6mvVpm+RUwCHU4oZeMYNAoajS9RbIc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:152d3921-d7cd-4cab-8ee2-087eecdcf8bc,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e90af218-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 36192afaba2a11f0b33aeb1e7f16c2b6-20251105
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1959082845; Wed, 05 Nov 2025 17:31:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 5 Nov 2025 17:31:29 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 5 Nov 2025 17:31:29 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 02/12] wifi: mt76: mt7996: no need to wait ACK event for SDO command
Date: Wed, 5 Nov 2025 17:30:50 +0800
Message-ID: <20251105093100.541408-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251105093100.541408-1-shayne.chen@mediatek.com>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
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

For the SDO unified command, driver does not need to wait for ACK event so
do not mark MCU_CMD_ACK in command header.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index dda01fa6d7bb..e97984693290 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -318,6 +318,9 @@ mt7996_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		else
 			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
 
+		if (mcu_cmd == MCU_UNI_CMD_SDO)
+			uni_txd->option &= ~MCU_CMD_ACK;
+
 		if ((cmd & __MCU_CMD_FIELD_WA) && (cmd & __MCU_CMD_FIELD_WM))
 			uni_txd->s2d_index = MCU_S2D_H2CN;
 		else if (cmd & __MCU_CMD_FIELD_WA)
-- 
2.51.0


