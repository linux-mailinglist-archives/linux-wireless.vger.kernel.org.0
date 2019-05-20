Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E05231EA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfETLCQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 07:02:16 -0400
Received: from nbd.name ([46.4.11.11]:47800 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732248AbfETLCP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 07:02:15 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSg3X-0003rt-MW; Mon, 20 May 2019 13:02:11 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH 5/7] mac80211: HE: allow setting spatial reuse parameters when bringing up an AP
Date:   Mon, 20 May 2019 13:02:02 +0200
Message-Id: <20190520110204.27588-6-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520110204.27588-1-john@phrozen.org>
References: <20190520110204.27588-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       | 15 +++++++++++++
 include/net/mac80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 27 +++++++++++++++++++++++
 net/mac80211/cfg.c           |  5 ++++-
 net/wireless/nl80211.c       | 42 ++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 044c519a008f..3f67f01b5f7a 100644
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
@@ -878,6 +891,7 @@ enum cfg80211_ap_settings_flags {
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
+ * @he_obss_pd: OBSS Packet Detection settings
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -905,6 +919,7 @@ struct cfg80211_ap_settings {
 	bool ht_required, vht_required;
 	bool twt_responder;
 	u32 flags;
+	struct ieee80211_he_obss_pd he_obss_pd;
 };
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a8e2381c9954..d81eea9140e5 100644
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
index 07d3f1949f96..78f3326ae0ea 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2310,6 +2310,9 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_TWT_RESPONDER: Enable target wait time responder support.
  *
+ * @NL80211_ATTR_HE_OBSS_PD: nested attribute for OBSS Packet Detection
+ *	functionality.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2763,6 +2766,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_TWT_RESPONDER,
 
+	NL80211_ATTR_HE_OBSS_PD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6390,4 +6395,26 @@ enum nl80211_peer_measurement_ftm_resp {
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
index 8be2f32fedfc..742b62187a4c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -940,7 +940,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_SSID |
 		      BSS_CHANGED_P2P_PS |
 		      BSS_CHANGED_TXPOWER |
-		      BSS_CHANGED_TWT;
+		      BSS_CHANGED_TWT |
+		      BSS_CHANGED_HE_OBSS_PD;
 	int err;
 	int prev_beacon_int;
 
@@ -1011,6 +1012,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.enable_beacon = true;
 	sdata->vif.bss_conf.allow_p2p_go_ps = sdata->vif.p2p;
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
+	memcpy(&sdata->vif.bss_conf.he_obss_pd, &params->he_obss_pd,
+	       sizeof(struct ieee80211_he_obss_pd));
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4dbb6b56853..266636ce3803 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -542,6 +542,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_pmsr_attr_policy),
 	[NL80211_ATTR_AIRTIME_WEIGHT] = NLA_POLICY_MIN(NLA_U16, 1),
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
+	[NL80211_ATTR_HE_OBSS_PD] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -4253,6 +4254,40 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
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
@@ -4536,6 +4571,13 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params.twt_responder =
 		    nla_get_flag(info->attrs[NL80211_ATTR_TWT_RESPONDER]);
 
+	if (info->attrs[NL80211_ATTR_HE_OBSS_PD]) {
+		err = nl80211_parse_he_obss_pd(info->attrs[NL80211_ATTR_HE_OBSS_PD],
+					       &params.he_obss_pd);
+		if (err)
+			return err;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.20.1

