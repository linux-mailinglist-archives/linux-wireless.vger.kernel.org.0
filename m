Return-Path: <linux-wireless+bounces-23376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E312AC3296
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 08:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF17218969BD
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 06:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F4185B48;
	Sun, 25 May 2025 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DewrPBEa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65770183CA6;
	Sun, 25 May 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748153518; cv=none; b=gfwwzYfMApMCl5/LPRtDTelQc6zWPxSANUrgyl9TkMJAfTWbLu0gFGInsBNBZYTZ4/r4noXMqY/pwEdCPMei4Fp/lIdASw3zobSBshluZUujB81mxdJkxCGFiTcnQHYEvWsmDkkXqox1/USw6QeHlhiRKG1wp0GgBwwt2zdk7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748153518; c=relaxed/simple;
	bh=zdpXILQJ+D8Hu8yCWXLz1BR2FvSPmn09UUyf8bO15do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM+RjW3JIC49WSTc8MXXLpNYzUyqHqGTzPSEmKf3ZsGJKIvECSAyDkdyvj8tSvPXCPo/iAVUxV9zb39cbTL0syVoyj57h6g5Kou6lms1nA1tPZP4970PKheQRrvvNsgZIhdfd3J+Uk3zsAz4SqELhuL8nQ0ocTJVV2V7Csu4t7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DewrPBEa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 250fbc82392f11f0813e4fe1310efc19-20250525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BKLaKat4eKcNZjCTNJxH1M1K9KYv239pmfyRmJpkuU4=;
	b=DewrPBEa70suHIYAWvFLlt6Sbxq7mVHewc2VaqKUSXSEUzpL9lKmHbnIfCuZClOf/ThHMVCWLIETM/HHTppMVGK/6t0ftUc2NTZqWaWkgkSPPz0iDRPCdVL31RCTzHDBxY5a+BHNhx3+19gnoK81Ytxs0JoazvyD5uGUYWHofrY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:9f9f7d7a-14fd-4022-b1aa-63c400f706d0,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:cba63ff1-2ded-45ed-94e2-b3e9fa87100d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 250fbc82392f11f0813e4fe1310efc19-20250525
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 76913326; Sun, 25 May 2025 14:11:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 25 May 2025 14:11:46 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sun, 25 May 2025 14:11:46 +0800
From: Deren Wu <Deren.Wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Allan Wang <allan.wang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Ryder Lee
	<ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] wifi: mt76: mt7921: prevent decap offload config before STA initialization
Date: Sun, 25 May 2025 14:11:22 +0800
Message-ID: <f23a72ba7a3c1ad38ba9e13bb54ef21d6ef44ffb.1748149855.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <35aedbffa050e98939264300407a52ba4e236d52.1748149855.git.deren.wu@mediatek.com>
References: <35aedbffa050e98939264300407a52ba4e236d52.1748149855.git.deren.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Deren Wu <deren.wu@mediatek.com>

The decap offload configuration should only be applied after the STA has
been successfully initialized. Attempting to configure it earlier can lead
to corruption of the MAC configuration in the chip's hardware state.

Add an early check for `msta->deflink.wcid.sta` to ensure the station peer
is properly initialized before proceeding with decapsulation offload
configuration.

Cc: stable@vger.kernel.org
Fixes: 24299fc869f7 ("mt76: mt7921: enable rx header traslation offload")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1fffa43379b2..77f73ae1d7ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1180,6 +1180,9 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
+	if (!msta->deflink.wcid.sta)
+		return;
+
 	mt792x_mutex_acquire(dev);
 
 	if (enabled)
-- 
2.18.0


