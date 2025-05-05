Return-Path: <linux-wireless+bounces-22446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F8AA8E1A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2845C1700C7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8C1E7C24;
	Mon,  5 May 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dH5jH/7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31D1E5B66
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433220; cv=none; b=JFkHVLSNvGWFxblD5G1G6bt8aeHv7CWIF1kQZR0lMZGp7AlEjs8RgTkhOx2S4Y5hJwNoNjH8gHV6QGkLYLq6zI91Y7FVxeRjwnueJEaq/ni2RqBJ0dJaxADMb/exbwsV7uT3yKMdmSiCD7Y5lrCa/QfJTbhwqI0tgO13jlNv3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433220; c=relaxed/simple;
	bh=sAmvz61r2MJWgdpmi24SZcC4yLnePXHltl34hRyqFH0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sZJEjbWLueha3SgnV8oMi1tVAfJP+GieTN1R0COuLK3gdZ4vRt+aMwPr+id5gyKVmKTym4ga8PEcnHUQoaTPtMeywcNsBuuvTiszedYq4za1kY2Y6b/cLDz6zIFdDFZ3SPd3In9xDZo5sRtM4awz5vx6Jy0DwffROGRRwjDTvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dH5jH/7L; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c40af0be298911f0813e4fe1310efc19-20250505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=h4P39E1QGiODNj6DPGFAGPEV/IZtN/MIkl9xBL7KDoI=;
	b=dH5jH/7LdDaV11OU/48hhSmt6jTMSXFv0Tex16A0uNfV7o3w+6tWaSMrVL00xA+FhQZH9vGdCvTHM0y4t6zire5PLWllpbMOuSqinl2ap8xG2bzdFqhtfhqMe/OvOt+xk7fi9WzObeJt36EL0AqODY9SWr/ttgmGY8pBmylZ/x4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:81c844dc-27d0-4527-a2f2-16132bc1f17b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:0b25ea7f-99e0-42db-8543-075f2c30d73f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c40af0be298911f0813e4fe1310efc19-20250505
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 864984967; Mon, 05 May 2025 16:20:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 5 May 2025 16:20:09 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 5 May 2025 16:20:09 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [PATCH] wifi: mac80211: fix the type of status_code for negotiated TID to Link Mapping
Date: Mon, 5 May 2025 16:19:46 +0800
Message-ID: <20250505081946.3927214-1-michael-cy.lee@mediatek.com>
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

The status code should be type of __le16.

Fixes: 83e897a961b8 ("wifi: ieee80211: add definitions for negotiated TID to Link map")
Fixes: 8f500fbc6c65 ("wifi: mac80211: process and save negotiated TID to Link mapping request")
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
 include/linux/ieee80211.h |  2 +-
 net/mac80211/mlme.c       | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 508d466de1cc..457b4fba88bd 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1526,7 +1526,7 @@ struct ieee80211_mgmt {
 				struct {
 					u8 action_code;
 					u8 dialog_token;
-					u8 status_code;
+					__le16 status_code;
 					u8 variable[];
 				} __packed ttlm_res;
 				struct {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c010bb3d24e3..5d1cd42160a0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7675,6 +7675,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_res);
 	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
 		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
+	u16 status_code;
 
 	skb = dev_alloc_skb(local->tx_headroom + hdr_len + ttlm_max_len);
 	if (!skb)
@@ -7697,19 +7698,18 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 		WARN_ON(1);
 		fallthrough;
 	case NEG_TTLM_RES_REJECT:
-		mgmt->u.action.u.ttlm_res.status_code =
-			WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING;
+		status_code = WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING;
 		break;
 	case NEG_TTLM_RES_ACCEPT:
-		mgmt->u.action.u.ttlm_res.status_code = WLAN_STATUS_SUCCESS;
+		status_code = WLAN_STATUS_SUCCESS;
 		break;
 	case NEG_TTLM_RES_SUGGEST_PREFERRED:
-		mgmt->u.action.u.ttlm_res.status_code =
-			WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED;
+		status_code = WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED;
 		ieee80211_neg_ttlm_add_suggested_map(skb, neg_ttlm);
 		break;
 	}
 
+	mgmt->u.action.u.ttlm_res.status_code = cpu_to_le16(status_code);
 	ieee80211_tx_skb(sdata, skb);
 }
 
@@ -7875,7 +7875,8 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	 * This can be better implemented in the future, to handle request
 	 * rejections.
 	 */
-	if (mgmt->u.action.u.ttlm_res.status_code != WLAN_STATUS_SUCCESS)
+	if (le16_to_cpu(mgmt->u.action.u.ttlm_res.status_code) !=
+	    WLAN_STATUS_SUCCESS)
 		__ieee80211_disconnect(sdata);
 }
 
-- 
2.25.1


