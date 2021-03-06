Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5832FBD9
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCFQUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Mar 2021 11:20:45 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:39282 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhCFQUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Mar 2021 11:20:18 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 92C1713C2B0;
        Sat,  6 Mar 2021 08:20:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 92C1713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1615047615;
        bh=gMgxTHT74qe6UZbTRcWVGVXn3sEYAq+wdjMwGx5Hq/o=;
        h=From:To:Cc:Subject:Date:From;
        b=Bohlmz88CNrfo6/w7BLfPJ6AA/qBt+cVqgdJbW4oxve1oXGF/P+QqIhM7lYqRP/r9
         PxmLhOVhb7j7rloZBllihp8FY5dNSiiOHRNY0vuvLWZSa0D1f4MCypCgu9NqVJk1j3
         bBOJHwDPaYy78fRduonFU6q1Gb/Cy6rT8lu/Fsos=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wireless:  Allow disabling TWT
Date:   Sat,  6 Mar 2021 08:20:10 -0800
Message-Id: <20210306162010.16706-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Allow disabling TWT feature at association time.  Useful for testing
and possibly for working around AP TWT bugs.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  1 +
 net/mac80211/ieee80211_i.h   |  3 ++-
 net/mac80211/mesh.c          |  2 +-
 net/mac80211/mlme.c          | 25 ++++++++++++++++++++++---
 net/mac80211/util.c          | 14 ++++++++++++--
 net/wireless/nl80211.c       |  7 +++++++
 7 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 76360dcb7867..098bdde3623c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2582,6 +2582,7 @@ struct cfg80211_auth_request {
  *	userspace if this flag is set. Only applicable for cfg80211_connect()
  *	request (connect callback).
  * @ASSOC_REQ_DISABLE_HE:  Disable HE
+ * @ASSOC_REQ_DISABLE_TWT:  Disable TWT
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
@@ -2589,6 +2590,7 @@ enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_USE_RRM			= BIT(2),
 	CONNECT_REQ_EXTERNAL_AUTH_SUPPORT	= BIT(3),
 	ASSOC_REQ_DISABLE_HE			= BIT(4),
+	ASSOC_REQ_DISABLE_TWT			= BIT(5),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 5188fe581efc..55e7be30a930 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3046,6 +3046,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_SAR_SPEC,
 
 	NL80211_ATTR_DISABLE_HE,
+	NL80211_ATTR_DISABLE_TWT,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7261e3e74791..7951c6377fc8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -371,6 +371,7 @@ enum ieee80211_sta_flags {
 	IEEE80211_STA_DISABLE_WMM	= BIT(14),
 	IEEE80211_STA_ENABLE_RRM	= BIT(15),
 	IEEE80211_STA_DISABLE_HE	= BIT(16),
+	IEEE80211_STA_DISABLE_TWT	= BIT(17),
 };
 
 struct ieee80211_mgd_auth_data {
@@ -2247,7 +2248,7 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
 u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
-u8 *ieee80211_ie_build_he_cap(u8 *pos,
+u8 *ieee80211_ie_build_he_cap(struct ieee80211_sub_if_data *sdata, u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
 void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 97095b7c9c64..62d40c212b34 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -580,7 +580,7 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return -ENOMEM;
 
 	pos = skb_put(skb, ie_len);
-	ieee80211_ie_build_he_cap(pos, he_cap, pos + ie_len);
+	ieee80211_ie_build_he_cap(sdata, pos, he_cap, pos + ie_len);
 
 	return 0;
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8ecf5bdebf6e..c137a8b5d8e1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -703,7 +703,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 		ieee80211_he_ppe_size(he_cap->ppe_thres[0],
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
-	ieee80211_ie_build_he_cap(pos, he_cap, pos + he_cap_size);
+	ieee80211_ie_build_he_cap(sdata, pos, he_cap, pos + he_cap_size);
 
 	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
 }
@@ -918,6 +918,16 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	    ext_capa && ext_capa->datalen >= 3)
 		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 
+	/* Apply overrides as needed. */
+	if (ifmgd->flags & IEEE80211_STA_DISABLE_TWT) {
+		if (ext_capa) {
+			if (ext_capa && ext_capa->datalen > 10) {
+				ext_capa->data[9] &= ~(WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT);
+				ext_capa->data[9] &= ~(WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT);
+			}
+		}
+	}
+
 	/* if present, add any custom IEs that go before HT */
 	if (assoc_data->ie_len) {
 		static const u8 before_ht[] = {
@@ -3306,15 +3316,21 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 	}
 }
 
-static bool ieee80211_twt_req_supported(const struct sta_info *sta,
+static bool ieee80211_twt_req_supported(struct ieee80211_sub_if_data *sdata,
+					const struct sta_info *sta,
 					const struct ieee802_11_elems *elems)
 {
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+
 	if (elems->ext_capab_len < 10)
 		return false;
 
 	if (!(elems->ext_capab[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
 		return false;
 
+	if (ifmgd->flags & IEEE80211_STA_DISABLE_TWT)
+		return false;
+
 	return sta->sta.he_cap.he_cap_elem.mac_cap_info[0] &
 		IEEE80211_HE_MAC_CAP0_TWT_RES;
 }
@@ -3323,7 +3339,7 @@ static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
 				    struct sta_info *sta,
 				    struct ieee802_11_elems *elems)
 {
-	bool twt = ieee80211_twt_req_supported(sta, elems);
+	bool twt = ieee80211_twt_req_supported(sdata, sta, elems);
 
 	if (sdata->vif.bss_conf.twt_requester != twt) {
 		sdata->vif.bss_conf.twt_requester = twt;
@@ -5799,6 +5815,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (req->flags & ASSOC_REQ_DISABLE_HE)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 
+	if (req->flags & ASSOC_REQ_DISABLE_TWT)
+		ifmgd->flags |= IEEE80211_STA_DISABLE_TWT;
+
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
 		goto err_clear;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4751e5a45311..da4f0dc101d9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2088,7 +2088,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 
 	he_cap = ieee80211_get_he_sta_cap(sband);
 	if (he_cap) {
-		pos = ieee80211_ie_build_he_cap(pos, he_cap, end);
+		pos = ieee80211_ie_build_he_cap(sdata, pos, he_cap, end);
 		if (!pos)
 			goto out_err;
 
@@ -3039,13 +3039,14 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
 				     he_cap->he_cap_elem.phy_cap_info);
 }
 
-u8 *ieee80211_ie_build_he_cap(u8 *pos,
+u8 *ieee80211_ie_build_he_cap(struct ieee80211_sub_if_data *sdata, u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end)
 {
 	u8 n;
 	u8 ie_len;
 	u8 *orig_pos = pos;
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
 	/* Make sure we have place for the IE */
 	/*
@@ -3070,6 +3071,15 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 
 	/* Fixed data */
 	memcpy(pos, &he_cap->he_cap_elem, sizeof(he_cap->he_cap_elem));
+
+	/* Apply overrides as needed. */
+	if (ifmgd->flags & IEEE80211_STA_DISABLE_TWT) {
+		struct ieee80211_he_cap_elem *hec;
+		hec = (struct ieee80211_he_cap_elem *)(pos);
+		hec->mac_cap_info[0] &= ~(IEEE80211_HE_MAC_CAP0_TWT_REQ);
+		hec->mac_cap_info[0] &= ~(IEEE80211_HE_MAC_CAP0_TWT_RES);
+	}
+
 	pos += sizeof(he_cap->he_cap_elem);
 
 	memcpy(pos, &he_cap->he_mcs_nss_supp, n);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ea169cd232c8..69f42b05bac7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -733,6 +733,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_DISABLE_TWT] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -10125,6 +10126,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
 		req.flags |= ASSOC_REQ_DISABLE_HE;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_TWT]))
+		req.flags |= ASSOC_REQ_DISABLE_TWT;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&req.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
@@ -10937,6 +10941,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
 		connect.flags |= ASSOC_REQ_DISABLE_HE;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_TWT]))
+		connect.flags |= ASSOC_REQ_DISABLE_TWT;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&connect.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
-- 
2.20.1

