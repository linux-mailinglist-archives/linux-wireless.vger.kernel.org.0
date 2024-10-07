Return-Path: <linux-wireless+bounces-13603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085CF992DD4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57A4280E68
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEF1D4354;
	Mon,  7 Oct 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PTx7hlff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF91D45E2
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309123; cv=none; b=jhtWlHIExuoyDRvrNVJxNVWO1pRoUmGtZyRVQa5HzWquGRCgkApZl1ahM+qN/Z2+6OLuIBNosZlZK+4wH88hHUpmq4Yv67WwN+rSrFvqj5DD3z8Gpm8gBcptkgPEZBDejVsylukLVqKBzXxFhJfiz8aER63eYRJuzCwVVdGPB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309123; c=relaxed/simple;
	bh=+NR/gzftuGKXn/urGk2NvII2unSGUCda0d/FerRGJdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W5VOQuXQhKef7V+4lJ3dYhuaFEIyvazlG+SXjv6/V1Q4y96qhPxQzlfnNl9zBrbbaI8/5SJ15BH1DAag7OpHTN4ILQEViaWQW2/m6LW5ELuDOQ5Xp6MsVy6DRO94ADw3JxNke9MhT/ynnmnS0BwrarBQSuzhezOYlju+y4pG3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PTx7hlff; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 504a4d0884b311ef8b96093e013ec31c-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ATimxhLnDANYMNPMxpqt7QVT0xGNiTFBMcTp6ckVdHA=;
	b=PTx7hlffCNtt4AYJpa6fv4WAw2QEm7XvOrj9vltfuD3sY6HpYRZ/Sb4Fe3g0Fxeay8JRU+00DtKwlzvo1esr3i0dR+3ArdYv3GuAwC6/2dew4RVnF/EFXzhqdRfLb6+JXE+WstPCg7SU2+vH07rao+EUQl+gxgyoQPfVNh3jr3I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e6dcc5c5-5965-4932-81cd-499aeb4089d6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:346ee140-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 504a4d0884b311ef8b96093e013ec31c-20241007
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1470070736; Mon, 07 Oct 2024 21:51:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 21:51:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 21:51:53 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	"Ryder Lee" <ryder.lee@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Frank Wunderlich
	<frank-w@public-files.de>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface combinations
Date: Mon, 7 Oct 2024 21:51:33 +0800
Message-ID: <20241007135133.5336-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.690600-8.000000
X-TMASE-MatchedRID: Tck8wxuMuYzAHHHFQcj2dge06kQGFaIW75oFMklhrngG2HMvWEJenuml
	/E2CK49bwhRO9036tr8uug82vqq5s8ot60/Xh7AB+YXwgWdSaC8raL2mh8ZVK/+am84b5ALE+Vi
	hXqn9xLHLlfTm7xmbgoAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGgmYwOHxlFtLpTNQm6sBpj6T2G
	yja3Qu86U3gJLi1iNP2cVbp8HJAFvAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.690600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 42C26800CFBBCB87A1219E76D155024E8DA548A6DE27E62152D2AAC8652A88ED2000:8
X-MTK: N

Setting beacon_int_min_gcd and NL80211_IFTYPE_ADHOC in the same interface
combination is invalid, which will trigger the following warning trace
and get error returned from wiphy_register().

[   10.080325] Call trace:
[   10.082761]  wiphy_register+0xc4/0x76c [cfg80211]
[   10.087465]  ieee80211_register_hw+0x800/0xac4 [mac80211]
[   10.092868]  mt76_register_device+0x16c/0x2c0 [mt76]
[   10.097829]  mt7996_register_device+0x740/0x844 [mt7996e]

Fix this by removing unused adhoc iftype.

Fixes: 948f65249868 ("wifi: mt76: mt7996: advertize beacon_int_min_gcd")
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f6a010b61a8a..2d36c7325137 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -16,9 +16,6 @@
 
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_ADHOC)
-	}, {
 		.max = 16,
 		.types = BIT(NL80211_IFTYPE_AP)
 #ifdef CONFIG_MAC80211_MESH
-- 
2.39.2


