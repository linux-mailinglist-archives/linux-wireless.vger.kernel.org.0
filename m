Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107536CAB8D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 19:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjC0RKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjC0RKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 13:10:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3D26A5
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 10:09:19 -0700 (PDT)
X-UUID: 190fcd90ccc211eda9a90f0bb45854f4-20230328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YAv0Wi3X954pmJJBqclo21Wb/tgaAhifxnVKR9tPy8g=;
        b=Me9BmoUaBIaZvVuKZCY/bnLdQQOyhRCqSHzOvLveTwspgRPJFNf9ezA8F+EVjJfAxbJkKMg/819eFrT+1sRXQnHX+tLa599lKop4ux4ZXxXAppGErJk8soDn2xfMtE4Sq6jrCYh1jDB+9IMPTXH8yfRXEIWR2g7UPyv9hbdJd4E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:376d1847-df53-404a-adde-46940680f2dd,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:d08112f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 190fcd90ccc211eda9a90f0bb45854f4-20230328
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2095619849; Tue, 28 Mar 2023 01:09:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 28 Mar 2023 01:09:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 28 Mar 2023 01:09:12 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] wifi: mac80211: enable EHT mesh support
Date:   Tue, 28 Mar 2023 01:07:42 +0800
Message-ID: <1e0ddb9001312451c3e99c4eed2072caf8075f61.1679935259.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <06c13635fc03bcff58a647b8e03e9f01a74294bd.1679935259.git.ryder.lee@mediatek.com>
References: <06c13635fc03bcff58a647b8e03e9f01a74294bd.1679935259.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to AP beacon, this enables the basic mesh EHT mode, including
EHT operation IE and the fixed field of EHT operation information IE.
As for the optional part (i.e. preamble puncturing bitmap) will be
added in future patch.

Tested-by: Lian Chen <lian.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - move ieee80211_ie_len_eht_cap fix to a separate patch.
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mesh.c        | 73 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/mesh.h        |  4 +++
 net/mac80211/mesh_plink.c  | 16 +++++++--
 net/mac80211/util.c        | 71 ++++++++++++++++++++++++++++++++++++
 5 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ecc232eb1ee8..d2070613a5bb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2430,6 +2430,8 @@ void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 				    enum ieee80211_smps_mode smps_mode,
 				    struct sk_buff *skb);
 u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
+u8 *ieee80211_ie_build_eht_oper(u8 *pos, struct cfg80211_chan_def *chandef,
+				const struct ieee80211_sta_eht_cap *eht_cap);
 int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5a99b8f6e465..57dc7b009ce4 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -104,7 +104,7 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 				   ie->vht_operation, ie->ht_operation,
 				   &sta_chan_def);
-	ieee80211_chandef_he_6ghz_oper(sdata, ie->he_operation, NULL,
+	ieee80211_chandef_he_6ghz_oper(sdata, ie->he_operation, ie->eht_operation,
 				       &sta_chan_def);
 
 	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chandef,
@@ -638,6 +638,65 @@ int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+int mesh_add_eht_cap_ie(struct ieee80211_sub_if_data *sdata,
+			struct sk_buff *skb, u8 ie_len)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_supported_band *sband;
+	u8 *pos;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
+	if (!he_cap || !eht_cap ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+		return 0;
+
+	if (skb_tailroom(skb) < ie_len)
+		return -ENOMEM;
+
+	pos = skb_put(skb, ie_len);
+	ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + ie_len, false);
+
+	return 0;
+}
+
+int mesh_add_eht_oper_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *skb)
+{
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_supported_band *sband;
+	u32 len;
+	u8 *pos;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
+	if (!eht_cap ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+		return 0;
+
+	len = 2 + 1 + offsetof(struct ieee80211_eht_operation, optional) +
+		      offsetof(struct ieee80211_eht_operation_info, optional);
+
+	if (skb_tailroom(skb) < len)
+		return -ENOMEM;
+
+	pos = skb_put(skb, len);
+	ieee80211_ie_build_eht_oper(pos, &sdata->vif.bss_conf.chandef, eht_cap);
+
+	return 0;
+}
+
 static void ieee80211_mesh_path_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -696,6 +755,9 @@ ieee80211_mesh_update_bss_params(struct ieee80211_sub_if_data *sdata,
 	if (he_oper)
 		sdata->vif.bss_conf.he_oper.params =
 			__le32_to_cpu(he_oper->he_oper_params);
+
+	sdata->vif.bss_conf.eht_support =
+		!!ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 }
 
 /**
@@ -813,7 +875,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct mesh_csa_settings *csa;
 	enum nl80211_band band;
-	u8 ie_len_he_cap;
+	u8 ie_len_he_cap, ie_len_eht_cap;
 	u8 *pos;
 	struct ieee80211_sub_if_data *sdata;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.beacon);
@@ -826,6 +888,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 
 	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata,
 						NL80211_IFTYPE_MESH_POINT);
+	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata,
+						  NL80211_IFTYPE_MESH_POINT);
 	head_len = hdr_len +
 		   2 + /* NULL SSID */
 		   /* Channel Switch Announcement */
@@ -849,6 +913,9 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 		   2 + 1 + sizeof(struct ieee80211_he_operation) +
 			   sizeof(struct ieee80211_he_6ghz_oper) +
 		   2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
+		   ie_len_eht_cap +
+		   2 + 1 + offsetof(struct ieee80211_eht_operation, optional) +
+			   offsetof(struct ieee80211_eht_operation_info, optional) +
 		   ifmsh->ie_len;
 
 	bcn = kzalloc(sizeof(*bcn) + head_len + tail_len, GFP_KERNEL);
@@ -969,6 +1036,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
 	    mesh_add_he_oper_ie(sdata, skb) ||
 	    mesh_add_he_6ghz_cap_ie(sdata, skb) ||
+	    mesh_add_eht_cap_ie(sdata, skb, ie_len_eht_cap) ||
+	    mesh_add_eht_oper_ie(sdata, skb) ||
 	    mesh_add_vendor_ies(sdata, skb))
 		goto out_free;
 
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index b2b717a78114..3c2d57df2747 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -204,6 +204,10 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 			struct sk_buff *skb);
 int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
 			    struct sk_buff *skb);
+int mesh_add_eht_cap_ie(struct ieee80211_sub_if_data *sdata,
+			struct sk_buff *skb, u8 ie_len);
+int mesh_add_eht_oper_ie(struct ieee80211_sub_if_data *sdata,
+			 struct sk_buff *skb);
 void mesh_rmc_free(struct ieee80211_sub_if_data *sdata);
 int mesh_rmc_init(struct ieee80211_sub_if_data *sdata);
 void ieee80211s_init(void);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index ddfe5102b9a4..8f168bc4e4b8 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -219,12 +219,14 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 	bool include_plid = false;
 	u16 peering_proto = 0;
 	u8 *pos, ie_len = 4;
-	u8 ie_len_he_cap;
+	u8 ie_len_he_cap, ie_len_eht_cap;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.self_prot);
 	int err = -ENOMEM;
 
 	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata,
 						NL80211_IFTYPE_MESH_POINT);
+	ie_len_eht_cap = ieee80211_ie_len_eht_cap(sdata,
+						  NL80211_IFTYPE_MESH_POINT);
 	skb = dev_alloc_skb(local->tx_headroom +
 			    hdr_len +
 			    2 + /* capability info */
@@ -241,6 +243,9 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			    2 + 1 + sizeof(struct ieee80211_he_operation) +
 				    sizeof(struct ieee80211_he_6ghz_oper) +
 			    2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
+			    ie_len_eht_cap +
+			    2 + 1 + offsetof(struct ieee80211_eht_operation, optional) +
+				    offsetof(struct ieee80211_eht_operation_info, optional) +
 			    2 + 8 + /* peering IE */
 			    sdata->u.mesh.ie_len);
 	if (!skb)
@@ -332,7 +337,9 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 		    mesh_add_vht_oper_ie(sdata, skb) ||
 		    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
 		    mesh_add_he_oper_ie(sdata, skb) ||
-		    mesh_add_he_6ghz_cap_ie(sdata, skb))
+		    mesh_add_he_6ghz_cap_ie(sdata, skb) ||
+		    mesh_add_eht_cap_ie(sdata, skb, ie_len_eht_cap) ||
+		    mesh_add_eht_oper_ie(sdata, skb))
 			goto free;
 	}
 
@@ -451,6 +458,11 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					  elems->he_6ghz_capa,
 					  &sta->deflink);
 
+	ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband, elems->he_cap,
+					    elems->he_cap_len,
+					    elems->eht_cap, elems->eht_cap_len,
+					    &sta->deflink);
+
 	if (bw != sta->sta.deflink.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 210fdca7ff48..8d0a15086870 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3459,6 +3459,77 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
 	return pos;
 }
 
+u8 *ieee80211_ie_build_eht_oper(u8 *pos, struct cfg80211_chan_def *chandef,
+				const struct ieee80211_sta_eht_cap *eht_cap)
+
+{
+	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *eht_mcs_nss =
+					&eht_cap->eht_mcs_nss_supp.only_20mhz;
+	struct ieee80211_eht_operation *eht_oper;
+	struct ieee80211_eht_operation_info *eht_oper_info;
+	u8 eht_oper_len = offsetof(struct ieee80211_eht_operation, optional);
+	u8 eht_oper_info_len =
+		offsetof(struct ieee80211_eht_operation_info, optional);
+	u8 chan_width = 0;
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 1 + eht_oper_len + eht_oper_info_len;
+	*pos++ = WLAN_EID_EXT_EHT_OPERATION;
+
+	eht_oper = (struct ieee80211_eht_operation *)pos;
+
+	memcpy(&eht_oper->basic_mcs_nss, eht_mcs_nss, sizeof(*eht_mcs_nss));
+	eht_oper->params |= IEEE80211_EHT_OPER_INFO_PRESENT;
+	pos += eht_oper_len;
+
+	eht_oper_info =
+		(struct ieee80211_eht_operation_info *)eht_oper->optional;
+
+	eht_oper_info->ccfs0 =
+		ieee80211_frequency_to_channel(chandef->center_freq1);
+	if (chandef->center_freq2)
+		eht_oper_info->ccfs1 =
+			ieee80211_frequency_to_channel(chandef->center_freq2);
+	else
+		eht_oper_info->ccfs1 = 0;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_320:
+		chan_width = IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ;
+		eht_oper_info->ccfs1 = eht_oper_info->ccfs0;
+		if (chandef->chan->center_freq < chandef->center_freq1)
+			eht_oper_info->ccfs0 -= 16;
+		else
+			eht_oper_info->ccfs0 += 16;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		eht_oper_info->ccfs1 = eht_oper_info->ccfs0;
+		if (chandef->chan->center_freq < chandef->center_freq1)
+			eht_oper_info->ccfs0 -= 8;
+		else
+			eht_oper_info->ccfs0 += 8;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_80P80:
+		chan_width = IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		chan_width = IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		chan_width = IEEE80211_EHT_OPER_CHAN_WIDTH_40MHZ;
+		break;
+	default:
+		chan_width = IEEE80211_EHT_OPER_CHAN_WIDTH_20MHZ;
+		break;
+	}
+	eht_oper_info->control = chan_width;
+	pos += eht_oper_info_len;
+
+	/* TODO: eht_oper_info->optional */
+
+	return pos;
+}
+
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
 			       struct cfg80211_chan_def *chandef)
 {
-- 
2.18.0

