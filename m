Return-Path: <linux-wireless+bounces-14445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960329AD9D8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 04:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525A228379F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696B145B0B;
	Thu, 24 Oct 2024 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pVguGusp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7A13E3F5
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736504; cv=none; b=e5tIILjjh94uVBYwc4/GCfBitU6+0p0TUlbbztw/s0Jml4j74bAy/zcinQPz3zKa5V/4A1tq2M6wpndisHFriGUbrAITeH8eCabYPunZdOrgKq/D4a9pqig1LOYj9pE1bicQ3haNP4OM/gi1eByL8LYNFKhwiCwRN3q1jr3/Nqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736504; c=relaxed/simple;
	bh=lRXxl1pEky2KQj3VHHse4Z2Uk2xLEg1AxljriGuMy7w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E0nYC94K00m9jAPghzelszIK65WqUkEotv+L48zSyIXjyNx8tkFy0nKIanzny6LscJBSarrFnyfe4cKm1EvLhzFMtkuPMjMllzWwWTjZGIaIlBKcnAKD8iDpi86xYRH871bx+0+ou1F7EsM2P6RJtCzJkugIHz162nIpCiyBfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pVguGusp; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b17b3f8091ae11efb88477ffae1fc7a5-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TxpVWTAXDeDiWPwWrae7vmrFsMqNNbBM2573sm7JwTs=;
	b=pVguGuspHMzXhLo0+npV3m8uC/UhYS+NzMKq/cTyA2YROn0m5yH7rqBNKKQ5ILQrvf48indB82cEUitlA8p9dl+IWDUHNEBQOexVT7OQpWKHAvatxLg1Vp0kGSVx6CjMiLElldmosKFpQm1xz7TvoOC62Cwi00EjykO2v+/oJus=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:fd93de4b-ea0e-4a9d-baf4-94466128bcba,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:1f9ac5cc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b17b3f8091ae11efb88477ffae1fc7a5-20241024
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <meichia.chiu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 576053991; Thu, 24 Oct 2024 10:21:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 10:21:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 10:21:33 +0800
From: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	<linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	MeiChia Chiu <MeiChia.Chiu@mediatek.com>, Peter Chiu
	<chui-hao.chiu@mediatek.com>
Subject: [PATCH] wifi: mac80211: Add ADDBA Extension element parsing logics
Date: Thu, 24 Oct 2024 10:21:05 +0800
Message-ID: <20241024022105.6810-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.365600-8.000000
X-TMASE-MatchedRID: l5qCKP2S+CY9PaPD4VZEncqXjImgj58bju+GX08gELAUtdRZTmEaIT/O
	C3yK2VFNYK6NT828Xh7y7+YHWQ1L0WMhTB8sj4eyJTeTSfxLkqmANGXBz7BHp9eRD+V8yu0DJLC
	p26f8YjS+MslyyVDSuFf+wCFGZIKvb3gilrWi3Gi5PNqdvNvYV3N3sLsG0mhuCqIJhrrDy2+/Z0
	rAfct0pun6DTnDw4pdvfjgZWRn16tNlZ1zEcyAY23NvezwBrVmZ/rAPfrtWC0BX1w330R6VqPFj
	JEFr+olwXCBO/GKkVr3FLeZXNZS4KBkcgGnJ4WmPP1lZIeXWqsQ4UEkN2J2kIzU1FEAnBSr4+cx
	joa0nBB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.365600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BFAC0764EEC1F35BD44764FC19E9CD41B3C921478F2AF59682A7B7577574A2DE2000:8
X-MTK: N

Add ADDBA Extension element parsing logics in ADDBA request/response

To support BA size of 1024,
the ADDBA Extension element is needed in ADDBA request/response.
Therefore, parsing logics is added for this missing piece.

Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Reviewed-by: Money Wang <money.wang@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
 include/linux/ieee80211.h |  2 ++
 net/mac80211/agg-tx.c     | 41 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 456bca45ff05..05dedc45505c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1445,6 +1445,8 @@ struct ieee80211_mgmt {
 					__le16 status;
 					__le16 capab;
 					__le16 timeout;
+					/* followed by BA Extension */
+					u8 variable[];
 				} __packed addba_resp;
 				struct{
 					u8 action_code;
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 04cb45cfb310..2070ca86be0c 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -66,10 +66,12 @@ static void ieee80211_send_addba_request(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
+	struct ieee80211_addba_ext_ie *addba_ext;
+	u8 ext_size = agg_size >= 1024 ? 2 + sizeof(*addba_ext) : 0;
+	u8 *pos;
 	u16 capab;
 
-	skb = dev_alloc_skb(sizeof(*mgmt) + local->hw.extra_tx_headroom);
-
+	skb = dev_alloc_skb(sizeof(*mgmt) + local->hw.extra_tx_headroom + ext_size);
 	if (!skb)
 		return;
 
@@ -93,6 +95,15 @@ static void ieee80211_send_addba_request(struct ieee80211_sub_if_data *sdata,
 	mgmt->u.action.u.addba_req.start_seq_num =
 					cpu_to_le16(start_seq_num << 4);
 
+	if (agg_size >= 1024) {
+		pos = skb_put_zero(skb, ext_size);
+		*pos++ = WLAN_EID_ADDBA_EXT;
+		*pos++ = sizeof(struct ieee80211_addba_ext_ie);
+		addba_ext = (struct ieee80211_addba_ext_ie *)pos;
+		addba_ext->data = u8_encode_bits(agg_size >> IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT,
+						 IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
+	}
+
 	ieee80211_tx_skb_tid(sdata, skb, tid, -1);
 }
 
@@ -460,8 +471,11 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	sta->ampdu_mlme.addba_req_num[tid]++;
 	spin_unlock_bh(&sta->lock);
 
-	if (sta->sta.deflink.he_cap.has_he) {
+	if (sta->sta.deflink.eht_cap.has_eht) {
 		buf_size = local->hw.max_tx_aggregation_subframes;
+	} else if (sta->sta.deflink.he_cap.has_he) {
+		buf_size = min_t(u16, local->hw.max_tx_aggregation_subframes,
+				 IEEE80211_MAX_AMPDU_BUF_HE);
 	} else {
 		/*
 		 * We really should use what the driver told us it will
@@ -961,8 +975,10 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_txq *txq;
+	struct ieee802_11_elems *elems;
 	u16 capab, tid, buf_size;
 	bool amsdu;
+	int ext_elem_len;
 
 	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
@@ -970,6 +986,25 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 	amsdu = capab & IEEE80211_ADDBA_PARAM_AMSDU_MASK;
 	tid = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_TID_MASK);
 	buf_size = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
+	ext_elem_len = len - offsetof(struct ieee80211_mgmt,
+				      u.action.u.addba_resp.variable);
+
+	if (ext_elem_len) {
+		elems = ieee802_11_parse_elems(mgmt->u.action.u.addba_resp.variable,
+					       ext_elem_len, true, NULL);
+
+		if (elems && !elems->parse_error) {
+			if (sta->sta.deflink.eht_cap.has_eht && elems->addba_ext_ie) {
+				u8 buf_size_1k = u8_get_bits(elems->addba_ext_ie->data,
+							     IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
+				buf_size |=
+					((u16)buf_size_1k) << IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT;
+			}
+		}
+
+		kfree(elems);
+	}
+
 	buf_size = min(buf_size, local->hw.max_tx_aggregation_subframes);
 
 	txq = sta->sta.txq[tid];
-- 
2.45.2


