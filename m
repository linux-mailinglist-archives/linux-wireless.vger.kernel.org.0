Return-Path: <linux-wireless+bounces-573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53EC809C86
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 07:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E569282505
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 06:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545D63AA;
	Fri,  8 Dec 2023 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ow1uqMj3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CACD1708
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 22:38:51 -0800 (PST)
X-UUID: 6f9374b4959411eea5db2bebc7c28f94-20231208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=z+7//TjXr90B58SC9BAM6tUD4VYYh+8yYZBEuenz64Y=;
	b=Ow1uqMj3O+AS9w6aNrL53HBLYrfMrrYRrw7xWE3TDJUtIy/axkvHoOlQYJjOOU78ewedcjNajH9uwZIsd7MvMEQ9rbcr6OhI7e1oz/pNNGkc7mCMcrqHvMszBYPeGw8RKNliVHkpiA10GJFMdeuOsy0hEUk1VQuALK2YfBTA7Q0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:62a95550-6281-4e2f-a3ae-875ccb892c85,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ef55f0bc-2ac7-4da2-9f94-677a477649d9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6f9374b4959411eea5db2bebc7c28f94-20231208
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <allen.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 355470112; Fri, 08 Dec 2023 14:38:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Dec 2023 14:38:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Dec 2023 14:38:43 +0800
From: Allen Ye <allen.ye@mediatek.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, Allen Ye <allen.ye@mediatek.com>
Subject: [PATCH v2] wifi: mac80211: Update bssid indicator with real BSS numbers
Date: Fri, 8 Dec 2023 14:38:20 +0800
Message-ID: <20231208063820.25983-1-allen.ye@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.827400-8.000000
X-TMASE-MatchedRID: aIMFWkTGGx22jsN8aguKvC97pb4g5HCtvtVce6w5+K9bLUcJ8BGOxWD/
	jkY+Hb4OeejfEBgiuSAkTiFDx5Ln6W94Ipa1otxoP6pyf9NtizR6zDxGcFEbCkPL6pqegFS6jGT
	DyIuhciDc0NDBaoYShQ9CP6VIrQmOWt71IsCTbXGeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hfNj
	F5BHUO+wax7kVctRdPxm1GKEdCief7eCqlRXtydMSWMYvbQRfP1AnhESIjQag=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.827400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F4D371DF9CB6022027055843B20B7EDEC59B7FF7ECCFEFF863B2047F81BB808A2000:8
X-MTK: N

The cnt member in mbssid is the count of total number of MBSSID elements
instead of BSSID. Therefore, we fix this by reading the MaxBSSID Indicator
field directly.

Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Co-developed-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
---
v2:
  - Fix From and s-o-b format error
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


