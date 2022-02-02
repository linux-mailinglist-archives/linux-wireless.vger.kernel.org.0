Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4397D4A6D4B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbiBBIt7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:49:59 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37924 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243066AbiBBIt6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:49:58 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBKo-0004v8-GD;
        Wed, 02 Feb 2022 10:49:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:34 +0200
Message-Id: <iwlwifi.20220202104617.70c8e3e7ee76.If317630de69ff1146bec7d47f5b83038695eb71d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/14] mac80211: limit bandwidth in HE capabilities
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we're limiting bandwidth for some reason such as regulatory
restrictions, then advertise that limitation just like we do
for VHT today, so the AP is aware we cannot use the higher BW
it might be using.

Fixes: 41cbb0f5a295 ("mac80211: add support for HE")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mesh.c        |  2 +-
 net/mac80211/mlme.c        | 11 ++++++++---
 net/mac80211/util.c        | 27 ++++++++++++++++++++++-----
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 330ea62231fa..da35791b8378 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2380,7 +2380,7 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
 u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
-u8 *ieee80211_ie_build_he_cap(u8 *pos,
+u8 *ieee80211_ie_build_he_cap(u32 disable_flags, u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
 void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 15ac08d111ea..6847fdf93439 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -580,7 +580,7 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return -ENOMEM;
 
 	pos = skb_put(skb, ie_len);
-	ieee80211_ie_build_he_cap(pos, he_cap, pos + ie_len);
+	ieee80211_ie_build_he_cap(0, pos, he_cap, pos + ie_len);
 
 	return 0;
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1eeabdf10052..55e21557a3d2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -635,7 +635,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb,
 				struct ieee80211_supported_band *sband)
 {
-	u8 *pos;
+	u8 *pos, *pre_he_pos;
 	const struct ieee80211_sta_he_cap *he_cap = NULL;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	u8 he_cap_size;
@@ -652,16 +652,21 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 
 	he_cap = ieee80211_get_he_iftype_cap(sband,
 					     ieee80211_vif_type_p2p(&sdata->vif));
-	if (!he_cap || !reg_cap)
+	if (!he_cap || !chanctx_conf || !reg_cap)
 		return;
 
+	/* get a max size estimate */
 	he_cap_size =
 		2 + 1 + sizeof(he_cap->he_cap_elem) +
 		ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem) +
 		ieee80211_he_ppe_size(he_cap->ppe_thres[0],
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
-	ieee80211_ie_build_he_cap(pos, he_cap, pos + he_cap_size);
+	pre_he_pos = pos;
+	pos = ieee80211_ie_build_he_cap(sdata->u.mgd.flags,
+					pos, he_cap, pos + he_cap_size);
+	/* trim excess if any */
+	skb_trim(skb, skb->len - (pre_he_pos + he_cap_size - pos));
 
 	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f71b042a5c8b..342c2bfe2709 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1974,7 +1974,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	if (he_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE)) {
-		pos = ieee80211_ie_build_he_cap(pos, he_cap, end);
+		pos = ieee80211_ie_build_he_cap(0, pos, he_cap, end);
 		if (!pos)
 			goto out_err;
 	}
@@ -2918,10 +2918,11 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
 				     he_cap->he_cap_elem.phy_cap_info);
 }
 
-u8 *ieee80211_ie_build_he_cap(u8 *pos,
+u8 *ieee80211_ie_build_he_cap(u32 disable_flags, u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end)
 {
+	struct ieee80211_he_cap_elem elem;
 	u8 n;
 	u8 ie_len;
 	u8 *orig_pos = pos;
@@ -2934,7 +2935,23 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 	if (!he_cap)
 		return orig_pos;
 
-	n = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem);
+	/* modify on stack first to calculate 'n' and 'ie_len' correctly */
+	elem = he_cap->he_cap_elem;
+
+	if (disable_flags & IEEE80211_STA_DISABLE_40MHZ)
+		elem.phy_cap_info[0] &=
+			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G);
+
+	if (disable_flags & IEEE80211_STA_DISABLE_160MHZ)
+		elem.phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+	if (disable_flags & IEEE80211_STA_DISABLE_80P80MHZ)
+		elem.phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+
+	n = ieee80211_he_mcs_nss_size(&elem);
 	ie_len = 2 + 1 +
 		 sizeof(he_cap->he_cap_elem) + n +
 		 ieee80211_he_ppe_size(he_cap->ppe_thres[0],
@@ -2948,8 +2965,8 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 	*pos++ = WLAN_EID_EXT_HE_CAPABILITY;
 
 	/* Fixed data */
-	memcpy(pos, &he_cap->he_cap_elem, sizeof(he_cap->he_cap_elem));
-	pos += sizeof(he_cap->he_cap_elem);
+	memcpy(pos, &elem, sizeof(elem));
+	pos += sizeof(elem);
 
 	memcpy(pos, &he_cap->he_mcs_nss_supp, n);
 	pos += n;
-- 
2.34.1

