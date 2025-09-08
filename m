Return-Path: <linux-wireless+bounces-27075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B25B48516
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 09:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A5C17774D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB0137932;
	Mon,  8 Sep 2025 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GjtJDYMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2D13B5A9;
	Mon,  8 Sep 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316338; cv=none; b=bFtmS38zvoxiaiB8kKIqNj+OU8p3NXcymOorz47VInxIDWXya4A8CSlQxOv6TM+2u1gbuxvL4ViK6vkNOykUNhy8NNZ058BVygtkspNqm0wBGoG2M/daUuXUirDH9onBGM/UvnYC1+efhTzWFzO2tnuek8ELPG8zuu3m+KTzH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316338; c=relaxed/simple;
	bh=vXLhg4p2HJ/hAKMDRlchZwNn6+waVINrGjrM8ypMtrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qXF51F2ZDLz436wPfbyM042okwjNML6Y4qnd9pe1NB+nStkeFDQtes84LmQjsN4HBqQV6OlJu7DrV3RaHZ8Qq8NAnLm8laH0T6REBFmV1VUbdBmdmXOITlxcWMEdCXma8Uwkpax/9I5/JtZwjf8k3qaDd/SDCb/ZOUQxClWBKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GjtJDYMx; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ff5bd6fc8c8411f0b33aeb1e7f16c2b6-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JzvTKSBojOyOHfeUH4od6Fjnx/Xmw/ekzsIFLVMxL68=;
	b=GjtJDYMxCzfz8SN1+4kUj70+uZAPIxs9twzRV1h6hOdE9EbpxXPIW2ZB890iWnhszSKfGoRsfd9DGbKHfFC04zhBvywrZT2eKcHuLVtmtrKDpFRlAcJfxNU1ejgzNRa4ZM3W4Ll4EeEgAs4af/9+/cYD5jRNN+bAQKF8yRiqD/g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:598e7c82-80ee-48b2-b154-06b01b45c306,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:f1326cf,CLOUDID:bde10ef8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ff5bd6fc8c8411f0b33aeb1e7f16c2b6-20250908
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 988733491; Mon, 08 Sep 2025 15:25:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 15:25:27 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 15:25:27 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH] wifi: mt76: mt7925: fix incorrect length field in txpower command
Date: Mon, 8 Sep 2025 15:25:26 +0800
Message-ID: <20250908072526.1833938-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Set `tx_power_tlv->len` to `msg_len` instead of `sizeof(*tx_power_tlv)`
to ensure the correct message length is sent to firmware.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 484bf11070c9..930a8cb83701 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3940,7 +3940,7 @@ mt7925_mcu_rate_txpower_band(struct mt76_phy *phy,
 		memcpy(tx_power_tlv->alpha2, dev->alpha2, sizeof(dev->alpha2));
 		tx_power_tlv->n_chan = num_ch;
 		tx_power_tlv->tag = cpu_to_le16(0x1);
-		tx_power_tlv->len = cpu_to_le16(sizeof(*tx_power_tlv));
+		tx_power_tlv->len = cpu_to_le16(msg_len);
 
 		switch (band) {
 		case NL80211_BAND_2GHZ:
-- 
2.34.1


