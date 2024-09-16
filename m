Return-Path: <linux-wireless+bounces-12883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD36979AE9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 08:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B627B21106
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93409DDC5;
	Mon, 16 Sep 2024 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bSRrdGSh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCB200A3
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726466551; cv=none; b=nqUjz79AnXwPn1pAevR4dNqcyDU6p2ywl2RBuuMAx5Ls6QPVkuDp+rzYlyuLAcvcwlbev1GRbc4Y3xaHuVyhwehkOIy+/dSyembVExfAmUERAzvJNMqzXAX1JO6xGMosc41asU4lOe6LYCtuEn/xiuU0PV1Ncyf6KxRs9z0bXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726466551; c=relaxed/simple;
	bh=tYACraa5HhBi9MxzA/F5grlapYIO2mSSooyYY6oVewg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aUSzAyVuqt1X1seR4ks8F/DWSFP7KPz2J1jg4xnFLpXji7xddshiREknk+QPk8PhbdM/DzYF10kGjjP5hLspnYMA+YAwT+Gt3s9Y29aMZZZIKRAWQpNg4GbGwez+FhqHYiBoe6Ru7hvoLBgVNUmBfVhYJ4tEswUqSOaWDmWxJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bSRrdGSh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3cdd2ca473f111efb66947d174671e26-20240916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Fckwj3nLjM8tiqxRm0YG0eLNs4gyS2cZWVzKMAGEK48=;
	b=bSRrdGShG3I4HyaczlNyGTYvAp9aWea/PRLyGuFPD7bf9HLMWIMbsRUyyFvUHiK4cz7/v+dVZOBZ52640kOJgZ8JHciw0yNH3WxzAiTsuOsQqzPPsiggHXmHmQG7lfVWgMbLuFuK4VZltT/QomRDwqwCmc//hf4RX0mK9flupGE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6bc32ea3-580a-4217-bf40-f9579bece5ff,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:103e13b7-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3cdd2ca473f111efb66947d174671e26-20240916
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 87881376; Mon, 16 Sep 2024 14:02:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Sep 2024 14:02:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Sep 2024 14:02:19 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>, "Ming
 Yen Hsieh" <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921s: fix a potential firmware freeze during startup
Date: Mon, 16 Sep 2024 14:01:57 +0800
Message-ID: <20240916060157.10157-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.301600-8.000000
X-TMASE-MatchedRID: Grh+eIkfeaLEAUxgQzN5HWcJkKl3v/LDEjUQ5RU6WJIlZZ7scaajMkUW
	SNUeoUM2IV4u8YKdeKtTXYUSVoVZ2Tp3zB6h4uJpVU3yVpaj3Qw38FNTll9lElIv9dBw/gcUz+O
	IW+Zar23i8zVgXoAltsIJ+4gwXrEtwrbXMGDYqV8gWATM4opXZoTscaT4k0SKWWvYHIcZ4GNkZU
	D2MrVksYDfkIsQmt1xVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.301600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 046DF7B7912FC4E4B38280D0975DC6C0996AC2F4CF287C7417537ADDDCD70AAA2000:8

From: Leon Yen <leon.yen@mediatek.com>

The maximum command quota of the firmware may be exceeded because the
command to retrieve the quota setting has not been taken into account.

This patch considers not only the quota usage of the command retrieving
quota settings but also limits the total quota usage.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 5 ++++-
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c  | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0b75a45ad2e8..4432020b7f7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -636,6 +636,7 @@ struct mt76_sdio {
 	u8 hw_ver;
 	wait_queue_head_t wait;
 
+	int pse_mcu_quota_max;
 	struct {
 		int pse_data_quota;
 		int ple_data_quota;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 02c1de8620a7..ddc5986086d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -507,7 +507,10 @@ static void mt7921_mcu_parse_tx_resource(struct mt76_dev *dev,
 
 	tx_res = (struct mt7921_tx_resource *)skb->data;
 	sdio->sched.pse_data_quota = le32_to_cpu(tx_res->pse_data_quota);
-	sdio->sched.pse_mcu_quota = le32_to_cpu(tx_res->pse_mcu_quota);
+	sdio->pse_mcu_quota_max = le32_to_cpu(tx_res->pse_mcu_quota);
+	/* The mcu quota usage of this function itself must be taken into consideration */
+	sdio->sched.pse_mcu_quota =
+		sdio->sched.pse_mcu_quota ? sdio->pse_mcu_quota_max : sdio->pse_mcu_quota_max - 1;
 	sdio->sched.ple_data_quota = le32_to_cpu(tx_res->ple_data_quota);
 	sdio->sched.pse_page_size = le16_to_cpu(tx_res->pse_page_size);
 	sdio->sched.deficit = tx_res->pp_padding;
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index ddd8c0cc744d..0a927a7313a6 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -46,6 +46,10 @@ static int mt76s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
 		return 0;
 
 	sdio->sched.pse_mcu_quota += pse_mcu_quota;
+	if (sdio->pse_mcu_quota_max &&
+	    sdio->sched.pse_mcu_quota > sdio->pse_mcu_quota_max) {
+		sdio->sched.pse_mcu_quota = sdio->pse_mcu_quota_max;
+	}
 	sdio->sched.pse_data_quota += pse_data_quota;
 	sdio->sched.ple_data_quota += ple_data_quota;
 
-- 
2.45.2


