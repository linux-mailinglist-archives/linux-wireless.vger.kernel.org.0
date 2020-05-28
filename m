Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357261E5C4D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbgE1Jod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387459AbgE1Joa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:44:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28FC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 02:44:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeF5Q-004mD7-DA; Thu, 28 May 2020 11:44:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [RFC 08/10] mac80211: add HE 6 GHz Band Capability element
Date:   Thu, 28 May 2020 11:44:14 +0200
Message-Id: <20200528114415.535bddb18860.I3f9747c1147480f65445f13eda5c4a5ed4e86757@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528114415.3596a1eedb31.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
References: <20200528114415.3596a1eedb31.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajkumar Manoharan <rmanohar@codeaurora.org>

Construct HE 6 GHz band capability element (IEEE 802.11ax/D6.0,
9.4.2.261) for association request and mesh beacon. The 6 GHz
capability information is passed by driver through iftypes caps.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Link: https://lore.kernel.org/r/1589399105-25472-7-git-send-email-rmanohar@codeaurora.org
[handle SMPS, adjust for previous patches, reserve SKB space properly,
 change to handle SKB directly]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mesh.c        |  9 +++++++
 net/mac80211/mesh.h        |  2 ++
 net/mac80211/mesh_plink.c  |  4 +++-
 net/mac80211/mlme.c        |  3 +++
 net/mac80211/util.c        | 48 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index dac016636d12..344ea828e806 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2177,6 +2177,8 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
 u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
+void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
+				    struct sk_buff *skb);
 u8 *ieee80211_ie_build_he_oper(u8 *pos);
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5930d07b1e43..5e8d72bdbb98 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -587,6 +587,13 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb)
+{
+	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
+	return 0;
+}
+
 static void ieee80211_mesh_path_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -766,6 +773,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 		   2 + sizeof(struct ieee80211_vht_operation) +
 		   ie_len_he_cap +
 		   2 + 1 + sizeof(struct ieee80211_he_operation) +
+		   2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
 		   ifmsh->ie_len;
 
 	bcn = kzalloc(sizeof(*bcn) + head_len + tail_len, GFP_KERNEL);
@@ -885,6 +893,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	    mesh_add_vht_oper_ie(sdata, skb) ||
 	    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
 	    mesh_add_he_oper_ie(sdata, skb) ||
+	    mesh_add_he_6ghz_cap_ie(sdata, skb) ||
 	    mesh_add_vendor_ies(sdata, skb))
 		goto out_free;
 
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 953f720754e8..40492d1bd8fd 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -222,6 +222,8 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 		       struct sk_buff *skb, u8 ie_len);
 int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 			struct sk_buff *skb);
+int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb);
 void mesh_rmc_free(struct ieee80211_sub_if_data *sdata);
 int mesh_rmc_init(struct ieee80211_sub_if_data *sdata);
 void ieee80211s_init(void);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 737c5f4dbf52..3aca89c97f36 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -238,6 +238,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			    2 + sizeof(struct ieee80211_vht_operation) +
 			    ie_len_he_cap +
 			    2 + 1 + sizeof(struct ieee80211_he_operation) +
+			    2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
 			    2 + 8 + /* peering IE */
 			    sdata->u.mesh.ie_len);
 	if (!skb)
@@ -328,7 +329,8 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 		    mesh_add_vht_cap_ie(sdata, skb) ||
 		    mesh_add_vht_oper_ie(sdata, skb) ||
 		    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
-		    mesh_add_he_oper_ie(sdata, skb))
+		    mesh_add_he_oper_ie(sdata, skb) ||
+		    mesh_add_he_6ghz_cap_ie(sdata, skb))
 			goto free;
 	}
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a259b4487b60..f6ddce646f18 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -658,6 +658,8 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
 	ieee80211_ie_build_he_cap(pos, he_cap, pos + he_cap_size);
+
+	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
 }
 
 static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
@@ -731,6 +733,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 			2 + 1 + sizeof(struct ieee80211_he_cap_elem) + /* HE */
 				sizeof(struct ieee80211_he_mcs_nss_supp) +
 				IEEE80211_HE_PPE_THRES_MAX_LEN +
+			2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
 			assoc_data->ie_len + /* extra IEs */
 			(assoc_data->fils_kek_len ? 16 /* AES-SIV */ : 0) +
 			9, /* WMM */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 5d2c5ae8aadb..40c82951d801 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2839,6 +2839,54 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 	return pos;
 }
 
+void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
+				    struct sk_buff *skb)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_sband_iftype_data *iftd;
+	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
+	u8 *pos;
+	u16 cap;
+
+	sband = local->hw.wiphy->bands[NL80211_BAND_6GHZ];
+
+	if (!sband)
+		return;
+
+	iftd = ieee80211_get_sband_iftype_data(sband, iftype);
+	if (WARN_ON(!iftd))
+		return;
+
+	cap = le16_to_cpu(iftd->he_6ghz_capa.capa);
+	cap &= ~IEEE80211_HE_6GHZ_CAP_SM_PS;
+
+	switch (sdata->smps_mode) {
+	case IEEE80211_SMPS_AUTOMATIC:
+	case IEEE80211_SMPS_NUM_MODES:
+		WARN_ON(1);
+		/* fall through */
+	case IEEE80211_SMPS_OFF:
+		cap |= u16_encode_bits(WLAN_HT_CAP_SM_PS_DISABLED,
+				       IEEE80211_HE_6GHZ_CAP_SM_PS);
+		break;
+	case IEEE80211_SMPS_STATIC:
+		cap |= u16_encode_bits(WLAN_HT_CAP_SM_PS_STATIC,
+				       IEEE80211_HE_6GHZ_CAP_SM_PS);
+		break;
+	case IEEE80211_SMPS_DYNAMIC:
+		cap |= u16_encode_bits(WLAN_HT_CAP_SM_PS_DYNAMIC,
+				       IEEE80211_HE_6GHZ_CAP_SM_PS);
+		break;
+	}
+
+	pos = skb_put(skb, 2 + 1 + sizeof(cap));
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 1 + sizeof(cap);
+	*pos++ = WLAN_EID_EXT_HE_6GHZ_CAPA;
+	put_unaligned_le16(cap, pos);
+}
+
 u8 *ieee80211_ie_build_ht_oper(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
 			       const struct cfg80211_chan_def *chandef,
 			       u16 prot_mode, bool rifs_mode)
-- 
2.26.2

