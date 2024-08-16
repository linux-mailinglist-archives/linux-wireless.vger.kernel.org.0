Return-Path: <linux-wireless+bounces-11531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE3954629
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015C3285555
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC9113B593;
	Fri, 16 Aug 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="alaWVQsP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF8129A78
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801810; cv=none; b=T158t7cVL1qrzYAT3ypq6GYKtf/EBC1M054qCDRl4hJ83i51fe3K6RxBWkg4hGZzRBlNTeKExXRe7Tw86T6GfmZJrUNmImPePoL0sDvoyS37xmIoaBzVmiuj13qoPGcuJ51sF6IcknUzWg4t8WSyU83HLqo8n/f7ShG8teJbHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801810; c=relaxed/simple;
	bh=ll2JhiFjPNPaXjXoD15qsjuJsChZsOQefLsCcd2s8/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEKkgI3ktj/20K51lMwNIqIm4P8Togg3yqTjYIiCOHAoA3mKDFXFbXR4TGN1Eln7LXcEhS1OzuRivh8sEWl//yeDh5BcofzlPSW4OWNvjppB5s+JHIiX9GcFYImt+4FCbexpq4rV2yPyITcAlrYMpTzkJL2XafdZPi1Zg0JZpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=alaWVQsP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e63d50125bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lAqw9ka0nn0S859j6xPD1mbCrC9FnM9RnqTZHXq9OMA=;
	b=alaWVQsPBGOQSHI4mERnIwSRiLV7pmj77t0PBIv8ME7Imkj+AkdzUc7FXXrZiUXHDoQR2bdqv8+tlPGZBVR4GYg1eYUucqYR20lGanPP8DaBF5NjetNrDMzH/CbQRpQZpq2woiTg9RXDYS15O98IV1EbluY7YpILFCenEGtXqok=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f3f331fe-ad1f-40c9-832a-f6c9d75e9d77,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:4bac403f-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e63d50125bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1479687662; Fri, 16 Aug 2024 17:49:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 17:49:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:49:59 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 02/12] wifi: mt76: mt7996: fix traffic delay when switching back to working channel
Date: Fri, 16 Aug 2024 17:46:26 +0800
Message-ID: <20240816094635.2391-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240816094635.2391-1-shayne.chen@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-3.692600-8.000000
X-TMASE-MatchedRID: eim6YYjnci0VAKRaMHqjDkf49ONH0RaSzSnbR3NwN1x+YFLISofIH9x+
	57h9IgNOg9nZBGeTizrSB/GPHxZWljEV1fJb8/5dbc297PAGtWYO2nfS7LtDc+WADIjXHIobKT3
	PsaLyojRvW4oU3XnAkBruuR1H7YPj9tiEgCVL0jh05zsoB1UKTn0tCKdnhB589yM15V5aWpj6C0
	ePs7A07QDtYjZXhssCCwQwd9u+WCA1aQxNd787cwJtzLNqef0oGXx8LLVfIc2urR6T5OLxsw5uA
	YA3tXk4AzCuQBzc7hvBPtF8G90o2ywJhKn2m7AVSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvr
	HlT8euIiT2wjObmjrMC+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-3.692600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 395AA2904F97960DC682A8E0FAB40F3B8E5CC53415AF45723FE01D3B5E872BE42000:8
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

During scanning, UNI_CHANNEL_RX_PATH tag is necessary for the firmware to
properly stop and resume MAC TX queue. Without this tag, HW needs more time
to resume traffic when switching back to working channel.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index bce082038219..f3f78e11a65f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -307,6 +307,10 @@ int mt7996_set_channel(struct mt7996_phy *phy)
 	if (ret)
 		goto out;
 
+	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_RX_PATH);
+	if (ret)
+		goto out;
+
 	ret = mt7996_dfs_init_radar_detector(phy);
 	mt7996_mac_cca_stats_reset(phy);
 
-- 
2.39.2


