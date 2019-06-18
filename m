Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596064997C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfFRGyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 02:54:19 -0400
Received: from nbd.name ([46.4.11.11]:59432 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfFRGyT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 02:54:19 -0400
Received: from p5dcfbabb.dip0.t-ipconnect.de ([93.207.186.187] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hd7Si-0000Ad-3q; Tue, 18 Jun 2019 08:19:20 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V3 2/2] mac80211: allow setting spatial reuse parameters from bss_conf
Date:   Tue, 18 Jun 2019 08:19:15 +0200
Message-Id: <20190618061915.7102-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618061915.7102-1-john@phrozen.org>
References: <20190618061915.7102-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Store the OBSS PD parameters inside bss_conf when bringing up an AP and/or
when a station connects to an AP. This allows the driver to configure the
HW accordingly.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       | 15 +++++++++++++
 include/net/mac80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 27 ++++++++++++++++++++++
 net/mac80211/cfg.c           |  5 ++++-
 net/mac80211/he.c            | 24 ++++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  3 +++
 net/mac80211/mlme.c          |  1 +
 net/wireless/nl80211.c       | 43 ++++++++++++++++++++++++++++++++++++
 8 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2d17e32eb438..49de2c69e63f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -249,6 +249,19 @@ struct ieee80211_rate {
 	u16 hw_value, hw_value_short;
 };
 
+/**
+ * struct ieee80211_he_obss_pd - AP settings for spatial reuse
+ *
+ * @enable: is the feature enabled.
+ * @min_offset: minimal tx power offset an associated station shall use
+ * @max_offset: maximum tx power offset an associated station shall use
+ */
+struct ieee80211_he_obss_pd {
+	bool enable;
+	u32 min_offset;
+	u32 max_offset;
+};
+
 /**
  * struct ieee80211_sta_ht_cap - STA's HT capabilities
  *
@@ -899,6 +912,7 @@ enum cfg80211_ap_settings_flags {
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
+ * @he_obss_pd: OBSS Packet Detection settings
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -926,6 +940,7 @@ struct cfg80211_ap_settings {
 	bool ht_required, vht_required;
 	bool twt_responder;
 	u32 flags;
+	struct ieee80211_he_obss_pd he_obss_pd;
 };
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4411120e5a9a..1a93ca593c28 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -318,6 +318,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_FTM_RESPONDER: fime timing reasurement request responder
  *	functionality changed for this BSS (AP mode).
  * @BSS_CHANGED_TWT: TWT status changed
+ * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
  *
  */
 enum ieee80211_bss_change {
@@ -349,6 +350,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_MCAST_RATE		= 1<<25,
 	BSS_CHANGED_FTM_RESPONDER	= 1<<26,
 	BSS_CHANGED_TWT			= 1<<27,
+	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -603,6 +605,7 @@ struct ieee80211_ftm_responder_params {
  *	nontransmitted BSSIDs
  * @profile_periodicity: the least number of beacon frames need to be received
  *	in order to discover all the nontransmitted BSSIDs in the set.
+ * @he_obss_pd: OBSS Packet Detection parameters.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -664,6 +667,7 @@ struct ieee80211_bss_conf {
 	u8 bssid_indicator;
 	bool ema_ap;
 	u8 profile_periodicity;
+	struct ieee80211_he_obss_pd he_obss_pd;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8fc3a43cac75..68ee35cbd75e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2356,6 +2356,9 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_TWT_RESPONDER: Enable target wait time responder support.
  *
+ * @NL80211_ATTR_HE_OBSS_PD: nested attribute for OBSS Packet Detection
+ *	functionality.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2813,6 +2816,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_TWT_RESPONDER,
 
+	NL80211_ATTR_HE_OBSS_PD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6488,4 +6493,26 @@ enum nl80211_peer_measurement_ftm_resp {
 	NL80211_PMSR_FTM_RESP_ATTR_MAX = NUM_NL80211_PMSR_FTM_RESP_ATTR - 1
 };
 
+/**
+ * enum nl80211_he_spr - spatial reuse attributes
+ * @__NL80211_HE_OBSS_PD_ATTR_INVALID: Invalid
+ *
+ * @NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET: the OBSS PD minimum tx power offset.
+ * @NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET: the OBSS PD maximum tx power offset.
+ *
+ * @__NL80211_HE_OBSS_PD_ATTR_LAST: Internal
+ * @NL80211_HE_OBSS_PD_ATTR_MAX: highest spiatl reuse attribute.
+ */
+enum nl80211_he_spr_attributes {
+	__NL80211_HE_OBSS_PD_ATTR_INVALID,
+
+	NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET,
+	NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET,
+
+	/* keep last */
+	__NL80211_ATTR_HE_OBSS_PD_LAST,
+	NL80211_HE_OBSS_PD_ATTR_MAX = __NL80211_ATTR_HE_OBSS_PD_LAST - 1,
+};
+
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fcf1dfc3a1cc..8a6a38d74878 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -976,7 +976,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_SSID |
 		      BSS_CHANGED_P2P_PS |
 		      BSS_CHANGED_TXPOWER |
-		      BSS_CHANGED_TWT;
+		      BSS_CHANGED_TWT |
+		      BSS_CHANGED_HE_OBSS_PD;
 	int err;
 	int prev_beacon_int;
 
@@ -1047,6 +1048,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.enable_beacon = true;
 	sdata->vif.bss_conf.allow_p2p_go_ps = sdata->vif.p2p;
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
+	memcpy(&sdata->vif.bss_conf.he_obss_pd, &params->he_obss_pd,
+	       sizeof(struct ieee80211_he_obss_pd));
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 769078ed5a12..5bb99bd3400c 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -53,3 +53,27 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 }
+
+void
+ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
+				const struct ieee80211_he_spr *he_spr_ie_elem)
+{
+	struct ieee80211_he_obss_pd *he_obss_pd =
+					&vif->bss_conf.he_obss_pd;
+	const u8 *data = he_spr_ie_elem->optional;
+
+	memset(he_obss_pd, 0, sizeof(*he_obss_pd));
+
+	if (!he_spr_ie_elem)
+		return;
+
+	if (he_spr_ie_elem->he_sr_control &
+	    IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
+		data++;
+	if (he_spr_ie_elem->he_sr_control &
+	    IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT) {
+		he_obss_pd->max_offset = *data++;
+		he_obss_pd->min_offset = *data++;
+		he_obss_pd->enable = true;
+	}
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0ee5d82e6734..07da9e49db94 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1873,6 +1873,9 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
 				  struct sta_info *sta);
+void
+ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
+				const struct ieee80211_he_spr *he_spr_ie_elem);
 
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b971b02d0d60..c5fee29ce03c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3373,6 +3373,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		if (elems.uora_element)
 			bss_conf->uora_ocw_range = elems.uora_element[0];
 
+		ieee80211_he_spr_ie_to_bss_conf(&sdata->vif, elems.he_spr);
 		/* TODO: OPEN: what happens if BSS color disable is set? */
 	}
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ff760ba83449..166bc66173f6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -574,6 +574,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SAE_PASSWORD] = { .type = NLA_BINARY,
 					.len = SAE_PASSWORD_MAX_LEN },
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
+	[NL80211_ATTR_HE_OBSS_PD] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -4348,6 +4349,40 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static const struct nla_policy
+			he_spr_policy[NL80211_HE_OBSS_PD_ATTR_MAX + 1] = {
+	[NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET] = { .type = NLA_U32 },
+	[NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET] = { .type = NLA_U32 },
+};
+
+static int nl80211_parse_he_obss_pd(struct nlattr *attrs,
+				    struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct nlattr *tb[NL80211_HE_OBSS_PD_ATTR_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, NL80211_HE_OBSS_PD_ATTR_MAX, attrs,
+			       he_spr_policy, NULL);
+	if (err)
+		return err;
+
+	if (!tb[NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET] ||
+	    !tb[NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET])
+		return -EINVAL;
+
+	he_obss_pd->min_offset =
+		nla_get_u32(tb[NL80211_ATTR_HE_OBSS_PD_MIN_OFFSET]);
+	he_obss_pd->max_offset =
+		nla_get_u32(tb[NL80211_ATTR_HE_OBSS_PD_MAX_OFFSET]);
+
+	if (he_obss_pd->min_offset >= he_obss_pd->max_offset)
+		return -EINVAL;
+
+	he_obss_pd->enable = true;
+
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -4632,6 +4667,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	params.twt_responder =
 		    nla_get_flag(info->attrs[NL80211_ATTR_TWT_RESPONDER]);
 
+	if (info->attrs[NL80211_ATTR_HE_OBSS_PD]) {
+		err = nl80211_parse_he_obss_pd(
+					info->attrs[NL80211_ATTR_HE_OBSS_PD],
+					&params.he_obss_pd);
+		if (err)
+			return err;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.20.1

