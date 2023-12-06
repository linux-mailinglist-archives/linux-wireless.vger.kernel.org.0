Return-Path: <linux-wireless+bounces-450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FA806547
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB5B1F211E7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 02:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F35463B2;
	Wed,  6 Dec 2023 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hXGY7TC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDF1A5
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 18:49:45 -0800 (PST)
X-UUID: 198ba52293e211ee8051498923ad61e6-20231206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LoDR6yW5PhaOI9nXfn4sNBMu5ukjVwmKI+VJR2t82HE=;
	b=hXGY7TC+sxlmrtHGpr5yMl4ASXuMFXHMLrgQe8fK3E8Bn41W9p5ZRa2U3KmNl9s+I7oONg2xzYx7irNl6hgXzBfH1NbVCIEWZxaDuQ8pdKDAjHoXauvNHaJZJ4BqZekNl9u04sjxtR4X06+zKWj/tfQhouZ1+nj9qF7KYf+/TSQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:828c328a-49b5-48ad-82ef-bb2c909b3cd8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:fc9755fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 198ba52293e211ee8051498923ad61e6-20231206
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <allen.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1106730928; Wed, 06 Dec 2023 10:49:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Dec 2023 10:49:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Dec 2023 10:49:38 +0800
From: Allen Ye <allen.ye@mediatek.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, "Money . Wang" <money.wang@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, Allen.Ye <allen.ye@mediatek.com>
Subject: [PATCH] wifi: mac80211: Update bssid indicator with real BSS numbers
Date: Wed, 6 Dec 2023 10:49:11 +0800
Message-ID: <20231206024911.7668-1-allen.ye@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.102400-8.000000
X-TMASE-MatchedRID: kgKXJcFYqZi2jsN8aguKvC97pb4g5HCtvtVce6w5+K9bLUcJ8BGOxWD/
	jkY+Hb4O08QE6X8k+fyUTQ2JYQzY2yE6c9JYhNJ6k3ewifG2MNPm1SQ5tAvJo9qtffjsN+cnq3c
	ttlDobAypYSDa5JlKKGijwWv+7EDclwV2iaAfSWcURSScn+QSXt0H8LFZNFG73Yq8RVaZivWmra
	jv7qH7k7zHx35ro84oE/svZgTKKT+OAG8otMPC8qehxTSuqyLn
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.102400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F1F1717A581B2F9DE085D79198B1B8E48C4B0560DDCDE47B740B2AA210E968702000:8
X-MTK: N

From: "Allen.Ye" <allen.ye@mediatek.com>

The cnt member in mbssid is the count of total number of MBSSID elements
instead of BSSID. Therefore, we fix this by reading the MaxBSSID Indicator
field directly.

Signed-off-by: Evelyn.Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Money.Wang <money.wang@mediatek.com>
Signed-off-by: Allen.Ye <allen.ye@mediatek.com>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 606b1b2e4123..f90bcd59f85a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1164,9 +1164,11 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	/* copy in optional mbssid_ies */
 	if (mbssid) {
 		u8 *pos = new->tail + new->tail_len;
+		const struct element *mbssid_elem;
 
 		new->mbssid_ies = (void *)pos;
 		pos += struct_size(new->mbssid_ies, elem, mbssid->cnt);
+		mbssid_elem = (const struct element *)pos;
 		pos += ieee80211_copy_mbssid_beacon(pos, new->mbssid_ies,
 						    mbssid);
 		if (rnr) {
@@ -1175,8 +1177,7 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			ieee80211_copy_rnr_beacon(pos, new->rnr_ies, rnr);
 		}
 		/* update bssid_indicator */
-		link_conf->bssid_indicator =
-			ilog2(__roundup_pow_of_two(mbssid->cnt + 1));
+		link_conf->bssid_indicator = mbssid_elem->data[0];
 	}
 
 	if (csa) {
-- 
2.18.0


