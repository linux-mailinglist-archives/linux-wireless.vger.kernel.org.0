Return-Path: <linux-wireless+bounces-14808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21909B8CB7
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 09:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC7B23069
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8515687C;
	Fri,  1 Nov 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h0GFmca9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF5156879
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448779; cv=none; b=oNFJk9nIEqWpavgjv2E7xSqn5Z4ypQH/I8xVqN3ANsVUfk1ftOBdv7XMBeEEkBcQTUFTNcKJA6HoM46Zf3EvTRNaKTWr1Q6aGu47dvDDtLbjO1waY/LmdqOySbHOjCL3o3jfBPxhmpfZXbIxkJrCAo31HTga0VR1oIG8asntId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448779; c=relaxed/simple;
	bh=ePelJAOYuxY8JxhO38HS8bn9JMMzPs/JJvxVs5Ijusw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oiDWjtvupKOdunIBk2WmcxxdMvwFpiJqHkP64k5mbr1z0vqiqOyqGw9zjftETp7nhO5bsiJ0Yc7t6ICzKNQ3T/jzpcctKgX50tVEiL0aqiX5946lGtSS09m25c5SYQMReoe2O0JppwRdCKy45VaHNzweBTVk7l914pZ4KbQBjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=h0GFmca9; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 173da904982911efb88477ffae1fc7a5-20241101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=p21M7mko/v90TFPnykxFUlxJZuzWC05tCWN+cJswq1Q=;
	b=h0GFmca9jhqQRvV7KAlK7oHjAxkdGwJ4lku7xJ1eA/tr/e4V6r8HQk8Z/wiutdoqEGg0fgXxWb4th+eEipcrpCIYXlQDpLJ8JBNGirItDTFxyoyCDBgDd20Mj+Y0N5Y9/lRv/P6IMKVVFqWYF/ZnBzp12p8WN5JvMRNpJLL/wr0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:369971ff-5a16-4a0b-b0a2-8ea2f6b76754,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0fcdc3,CLOUDID:1fe18648-ca13-40ea-8070-fa012edab362,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 173da904982911efb88477ffae1fc7a5-20241101
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 148020157; Fri, 01 Nov 2024 16:12:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Nov 2024 16:12:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Nov 2024 16:12:50 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
Date: Fri, 1 Nov 2024 16:12:49 +0800
Message-ID: <20241101081249.27834-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Use tlv instead of skb, because using skb will get invalid data
with wrong offset.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0c2a2337c313..9b6aff463063 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -823,7 +823,7 @@ mt7925_mcu_get_nic_capability(struct mt792x_dev *dev)
 			mt7925_mcu_parse_phy_cap(dev, tlv->data);
 			break;
 		case MT_NIC_CAP_CHIP_CAP:
-			memcpy(&dev->phy.chip_cap, (void *)skb->data, sizeof(u64));
+			memcpy(&dev->phy.chip_cap, (void *)tlv->data, sizeof(u64));
 			break;
 		case MT_NIC_CAP_EML_CAP:
 			mt7925_mcu_parse_eml_cap(dev, tlv->data);
-- 
2.45.2


