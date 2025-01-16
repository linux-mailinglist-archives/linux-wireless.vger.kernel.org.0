Return-Path: <linux-wireless+bounces-17585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22162A13306
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329A8163B57
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6B156F3C;
	Thu, 16 Jan 2025 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZTFEiG7X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE343149C7B;
	Thu, 16 Jan 2025 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008500; cv=none; b=u5975kbJqPnATsKItMJSkUCJ7EiJW/A7BG9y0ODHcDxQNWL43RsXka7ylv+twEAZ1SgLp45JmuT1/byT5Fha1bwMJ0FuMHPqFThcKMOCPSWDDR9unONphS/em/iaw0R3xwf0QHepGzgY3B0dZRdlZUAVUGgETD5Gpni+xVDCFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008500; c=relaxed/simple;
	bh=3t9P/F5HlNviHtJo04PcOkCyQFWJeh4ZbRRu8zVuDiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rbctRKqwDzPyuP9EhfcgL0NjAF4CTpjlBQD4fcKAGifU6fTPZZv/f0gUpu3RzrS5vvyJtE+o8otT+B+oUZ4xJd9Y1bJpTTYzjlvUi3t6Q3VQMuExfFXleGDUoUBZNGE0ay7pwaWTzCVsnjVDCyD7tF+HPiOgae2h0RLwXJhkt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZTFEiG7X; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 220dd8d8d3d211ef99858b75a2457dd9-20250116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FN6+wwARl7QHcDNy3Z87Hw98GQbYtNMa8FngMTYhn4k=;
	b=ZTFEiG7XA+6DmwcXm2i1sulq71LoYbheRzRdoRzBS/PeD7u8uaNP8sK5/MXlKovrxzJxhiPqVH3ArJdRo79e7rqco31loJ9APVF1nHLCsDg2t7cdsafdWk/yY3s5ChTnWDg4cR6WGkUMnSsC4DCnucF3OG93eiHlxkviJScMiLg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:1f1e414b-d718-478e-850a-229411362e29,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:d20b1f85-0f10-4f52-bb41-91703793d3e4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 220dd8d8d3d211ef99858b75a2457dd9-20250116
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 611254022; Thu, 16 Jan 2025 14:21:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 Jan 2025 14:21:32 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 16 Jan 2025 14:21:32 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH] wifi: mt76: mt7925: fix country count limitation for CLC
Date: Thu, 16 Jan 2025 14:21:31 +0800
Message-ID: <20250116062131.3860198-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Due to the increase in the number of power tables for 6Ghz on CLC,
the variable nr_country is no longer sufficient to represent the
total quantity. Therefore, we have switched to calculating the
length of clc buf to obtain the correct power table.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 15815ad84713..6b83a1b17140 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3158,13 +3158,14 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		.acpi_conf = mt792x_acpi_get_flags(&dev->phy),
 	};
 	int ret, valid_cnt = 0;
-	u8 i, *pos;
+	u8 *pos, *last_pos;
 
 	if (!clc)
 		return 0;
 
 	pos = clc->data + sizeof(*seg) * clc->nr_seg;
-	for (i = 0; i < clc->nr_country; i++) {
+	last_pos = clc->data + le32_to_cpu(*(__le32 *)(clc->data + 4));
+	while (pos < last_pos) {
 		struct mt7925_clc_rule *rule = (struct mt7925_clc_rule *)pos;
 
 		pos += sizeof(*rule);
-- 
2.45.2


