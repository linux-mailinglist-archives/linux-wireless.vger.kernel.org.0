Return-Path: <linux-wireless+bounces-16791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C799FC400
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 08:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3731640EE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394354670;
	Wed, 25 Dec 2024 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bzFBlhVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E735AD4B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735112272; cv=none; b=JhZDRoO0o3B5uN+mUImHAivIBTdq17Z7cHH2CET/TbPkMlM0Mr2xHuAt1Gq5r3ij7WO0xQYaE5F7ljY5TfN3SsptX4sXhsHqCuJffKKaoMYVzc1ifR9T2BEPQ2bxCOv/hKkzDJe4hq/0biRkUBVJBf1zsM+5z6ySk7LYCPgx1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735112272; c=relaxed/simple;
	bh=nQMcLuIU/1ibryI2M9zrhViV4G3Za2nZXwWXK4Lbi4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hx1UIsok/ckJJWTGnzqE2Wg7dSbqSg6Dtb6FKtTuXnjMTgXTtzAyksqTKGHxCd1oSg5MZ0je1JaJgyHjbKe4zTrV0Zbal94ML4h23bxR1oR0hJick8qFP3vPWPJNOhNiatL9duxrXF40bqD5EgzsY+cZdewz7YUAUibJ5dIMl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bzFBlhVg; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 206d66a6c29311ef99858b75a2457dd9-20241225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fcQwHaODYzY5B8jzlndOF7RHeG7DDbHPryeyMjYiZUg=;
	b=bzFBlhVg0YyL8D+DerUkAWmwYzMOpcEYR1yyM+1qBSNYWYFiiyb9h6kJlSLK/z7HDBB8BqczQCr4vxDewOLkHoIdictm/88JomlVNF/FtCAhrspB8NsPjUQAD8KKPlasLGad4VeCodIHUPTZKi6gmf6an0UnK74+PXA1ZwgU0MU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:420932a9-ceb0-401a-8716-d8f9d0b91ca5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:98dbd618-ec44-4348-86ee-ebcff634972b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 206d66a6c29311ef99858b75a2457dd9-20241225
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1502814146; Wed, 25 Dec 2024 15:37:43 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Dec 2024 15:37:41 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Dec 2024 15:37:41 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: cfg80211: copy multi-link element from the multi-link probe request's frame body to the generated elements
Date: Wed, 25 Dec 2024 15:37:25 +0800
Message-ID: <20241225073725.847062-1-michael-cy.lee@mediatek.com>
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

According to Draft P802.11be_D7.0 clause 35.3.4.2, if a multi-link
request requests an MLD with which an AP corresponding to the
nontransmitted BSSID, the corresponding multi-link probe response
shall carry a basic multi-mink element of that MLD in the frame body
of the multi-link probe response, whose location is outside of the
Multiple BSSID element carried in the frame.

Therefore additional handing is needed for parsing multi-link probe
response and generating the merged elements so that the MLD in the frame
body can be correctly copied to the generated elements. Otherwise, the
nontransmitted BSS looks like non-MLD.

Signed-off-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 net/wireless/scan.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 8e3d46bf4836..b244378e0bad 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -272,12 +272,19 @@ cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 {
 	const struct element *non_inherit_elem, *parent, *sub;
 	u8 *pos = new_ie;
-	u8 id, ext_id;
+	const u8 *mbssid_index_ie;
+	u8 id, ext_id, bssid_index = 255;
 	unsigned int match_len;
 
 	non_inherit_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
 						  subie, subie_len);
 
+	mbssid_index_ie = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX, subie,
+					   subie_len);
+	if (mbssid_index_ie && mbssid_index_ie[1] > 0 &&
+	    mbssid_index_ie[2] > 0 && mbssid_index_ie[2] <= 46)
+		bssid_index = mbssid_index_ie[2];
+
 	/* We copy the elements one by one from the parent to the generated
 	 * elements.
 	 * If they are not inherited (included in subie or in the non
@@ -316,6 +323,24 @@ cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 			continue;
 		}
 
+		/* For ML probe response, match the MLE in the frame body with
+		 * MLD id being 'bssid_index'
+		 */
+		if (parent->id == WLAN_EID_EXTENSION && parent->datalen > 1 &&
+		    parent->data[0] == WLAN_EID_EXT_EHT_MULTI_LINK &&
+		    bssid_index == ieee80211_mle_get_mld_id(parent->data + 1)) {
+			if (!cfg80211_copy_elem_with_frags(parent,
+							   ie, ielen,
+							   &pos, new_ie,
+							   new_ie_len))
+				return 0;
+
+			/* Continue here to prevent processing the MLE in
+			 * sub-element, which AP MLD should not carry
+			 */
+			continue;
+		}
+
 		/* Already copied if an earlier element had the same type */
 		if (cfg80211_find_elem_match(id, ie, (u8 *)parent - ie,
 					     &ext_id, match_len, 0))
-- 
2.25.1


