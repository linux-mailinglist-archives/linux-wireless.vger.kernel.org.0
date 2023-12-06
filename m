Return-Path: <linux-wireless+bounces-449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F0806543
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8C91C20DF1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 02:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DADD6AA7;
	Wed,  6 Dec 2023 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e4g9PBgZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73C181
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 18:48:28 -0800 (PST)
X-UUID: e97cdf2293e111ee8051498923ad61e6-20231206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lkky2+2gf5KSjnXjeHOkgH+At/uP60zFAcftF3L3xOA=;
	b=e4g9PBgZx87IB85KjcL0tXwXwl/rxKFGuGJnRxg3KeukwExqMxyzsIRSAJnihVmYRHIEam1v2OzBVqfqmbQgKJABH3fPY/AKURn/LsyOn6Lc/4GhoHw9j3jfM0mrGzlg+3dor6/fp32Ju46JGsTU6w6qfq+7UoH8C/zHFaf/e1M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:dfb8e913-44c4-4133-b6d2-d8298963f142,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:129455fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e97cdf2293e111ee8051498923ad61e6-20231206
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <allen.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1297972835; Wed, 06 Dec 2023 10:48:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Dec 2023 10:48:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Dec 2023 10:48:16 +0800
From: Allen Ye <allen.ye@mediatek.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, "Money . Wang" <money.wang@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, Allen.Ye <allen.ye@mediatek.com>
Subject: [PATCH] wifi: mac80211: Fix SMPS action frame ht cap check
Date: Wed, 6 Dec 2023 10:47:08 +0800
Message-ID: <20231206024708.24831-1-allen.ye@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-4.650400-8.000000
X-TMASE-MatchedRID: MfleD8Y7obIiXL+V+zm5iRz2MDiYujy5J/I0ITC6MIXtrvVsQ0WdM3VR
	68i/XPHyIeBgEHp7T0GISleZ//blDUl8m7ENQmOXGfRQPgZTkiosL3b83U5aWdEsTITobgNEU7g
	EPucszGePqQJ9fQR1zo3/d0NuPcI1dzV8xDXMCuTuykw7cfAoIFY5BBJri9sdmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ19+9ZqEp9FTiOzrPFOrvm+E2taTfkzTK6SSmgndBeJfEt5C8QACngQ6Axq
	h5n9t0n/POc2x/QXMENRquzAcsw5jW1wfllTMfMEm//fmW4iWAXRoPmWO3jekxwdkPqCq7vDEyN
	+J8hd+jCS9WgDXVPCvqy+VVvqH2X
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-4.650400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C38E01A2F9F061E7AA757A5702C2F5699F2967AF10FCF3B65BEAD53E233032E82000:8
X-MTK: N

From: "Allen.Ye" <allen.ye@mediatek.com>

Since there is no HT BSS in 6GHz, the HT Cap check would stop 6G HE/EHT
BSS from processing the HT action frame for SM Power Save which can be
also used in an HE BSS. Therefore, we remove the HT Cap check in 6GHz and
add the HE check accordingly.

Signed-off-by: Money.Wang <money.wang@mediatek.com>
Signed-off-by: Allen.Ye <allen.ye@mediatek.com>
---
 net/mac80211/rx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 64352e4e6d00..f8cd14dc58ec 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3482,7 +3482,8 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_HT:
 		/* reject HT action frames from stations not supporting HT */
-		if (!rx->link_sta->pub->ht_cap.ht_supported)
+		if (status->band != NL80211_BAND_6GHZ &&
+		    !rx->link_sta->pub->ht_cap.ht_supported)
 			goto invalid;
 
 		if (sdata->vif.type != NL80211_IFTYPE_STATION &&
@@ -3502,6 +3503,12 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			enum ieee80211_smps_mode smps_mode;
 			struct sta_opmode_info sta_opmode = {};
 
+			if (status->band == NL80211_BAND_6GHZ &&
+			    rx->link_sta->pub->he_cap.has_he &&
+			    !(rx->link_sta->pub->he_cap.he_cap_elem.mac_cap_info[5] &
+			    IEEE80211_HE_MAC_CAP5_HE_DYNAMIC_SM_PS))
+				goto invalid;
+
 			if (sdata->vif.type != NL80211_IFTYPE_AP &&
 			    sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
 				goto handled;
-- 
2.18.0


