Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8911323D084
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 21:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgHETtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgHEQyb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 12:54:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA8C0A8888
        for <linux-wireless@vger.kernel.org>; Wed,  5 Aug 2020 06:48:17 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k3Jm8-00Gocm-42; Wed, 05 Aug 2020 15:48:12 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: clean up code/policy a bit
Date:   Wed,  5 Aug 2020 15:47:16 +0200
Message-Id: <20200805154714.3ba1e233cfa0.I5dc8109b7ab5c3f4ae925f903a30cc9b35753262@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use the policy to validate minimum and exact lengths in
some attributes that weren't previously covered in the
right ways, and remove associated validation code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 60 +++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 42 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 279c87a2a523..57b989d53064 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -539,7 +539,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_BG_SCAN_PERIOD] = { .type = NLA_U16 },
 	[NL80211_ATTR_WDEV] = { .type = NLA_U64 },
 	[NL80211_ATTR_USER_REG_HINT_TYPE] = { .type = NLA_U32 },
-	[NL80211_ATTR_AUTH_DATA] = { .type = NLA_BINARY, },
+
+	/* need to include at least Auth Transaction and Status Code */
+	[NL80211_ATTR_AUTH_DATA] = NLA_POLICY_MIN_LEN(4),
+
 	[NL80211_ATTR_VHT_CAPABILITY] = NLA_POLICY_EXACT_LEN_WARN(NL80211_VHT_CAPABILITY_LEN),
 	[NL80211_ATTR_SCAN_FLAGS] = { .type = NLA_U32 },
 	[NL80211_ATTR_P2P_CTWINDOW] = NLA_POLICY_MAX(NLA_U8, 127),
@@ -561,7 +564,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_IE_RIC] = { .type = NLA_BINARY,
 				  .len = IEEE80211_MAX_DATA_LEN },
 	[NL80211_ATTR_CRIT_PROT_ID] = { .type = NLA_U16 },
-	[NL80211_ATTR_MAX_CRIT_PROT_DURATION] = { .type = NLA_U16 },
+	[NL80211_ATTR_MAX_CRIT_PROT_DURATION] =
+		NLA_POLICY_MAX(NLA_U16, NL80211_CRIT_PROTO_MAX_DURATION),
 	[NL80211_ATTR_PEER_AID] =
 		NLA_POLICY_RANGE(NLA_U16, 1, IEEE80211_MAX_AID),
 	[NL80211_ATTR_CH_SWITCH_COUNT] = { .type = NLA_U32 },
@@ -569,7 +573,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CSA_IES] = { .type = NLA_NESTED },
 	[NL80211_ATTR_CSA_C_OFF_BEACON] = { .type = NLA_BINARY },
 	[NL80211_ATTR_CSA_C_OFF_PRESP] = { .type = NLA_BINARY },
-	[NL80211_ATTR_STA_SUPPORTED_CHANNELS] = { .type = NLA_BINARY },
+	[NL80211_ATTR_STA_SUPPORTED_CHANNELS] = NLA_POLICY_MIN_LEN(2),
 	[NL80211_ATTR_STA_SUPPORTED_OPER_CLASSES] = { .type = NLA_BINARY },
 	[NL80211_ATTR_HANDLE_DFS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_OPMODE_NOTIF] = { .type = NLA_U8 },
@@ -625,6 +629,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 					.len = FILS_ERP_MAX_RRK_LEN },
 	[NL80211_ATTR_FILS_CACHE_ID] = NLA_POLICY_EXACT_LEN_WARN(2),
 	[NL80211_ATTR_PMK] = { .type = NLA_BINARY, .len = PMK_MAX_LEN },
+	[NL80211_ATTR_PMKR0_NAME] = NLA_POLICY_EXACT_LEN(WLAN_PMK_NAME_LEN),
 	[NL80211_ATTR_SCHED_SCAN_MULTI] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT] = { .type = NLA_FLAG },
 
@@ -738,7 +743,7 @@ nl80211_rekey_policy[NUM_NL80211_REKEY_DATA] = {
 		.type = NLA_BINARY,
 		.len = NL80211_KCK_EXT_LEN
 	},
-	[NL80211_REKEY_DATA_REPLAY_CTR] = NLA_POLICY_EXACT_LEN_WARN(NL80211_REPLAY_CTR_LEN),
+	[NL80211_REKEY_DATA_REPLAY_CTR] = NLA_POLICY_EXACT_LEN(NL80211_REPLAY_CTR_LEN),
 	[NL80211_REKEY_DATA_AKM] = { .type = NLA_U32 },
 };
 
@@ -778,7 +783,8 @@ nl80211_bss_select_policy[NL80211_BSS_SELECT_ATTR_MAX + 1] = {
 /* policy for NAN function attributes */
 static const struct nla_policy
 nl80211_nan_func_policy[NL80211_NAN_FUNC_ATTR_MAX + 1] = {
-	[NL80211_NAN_FUNC_TYPE] = { .type = NLA_U8 },
+	[NL80211_NAN_FUNC_TYPE] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_NAN_FUNC_MAX_TYPE),
 	[NL80211_NAN_FUNC_SERVICE_ID] = {
 				    .len = NL80211_NAN_FUNC_SERVICE_ID_LEN },
 	[NL80211_NAN_FUNC_PUBLISH_TYPE] = { .type = NLA_U8 },
@@ -4896,8 +4902,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params.ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
 		params.ssid_len =
 			nla_len(info->attrs[NL80211_ATTR_SSID]);
-		if (params.ssid_len == 0 ||
-		    params.ssid_len > IEEE80211_MAX_SSID_LEN)
+		if (params.ssid_len == 0)
 			return -EINVAL;
 	}
 
@@ -5836,11 +5841,9 @@ static int nl80211_parse_sta_channel_info(struct genl_info *info,
 		     nla_len(info->attrs[NL80211_ATTR_STA_SUPPORTED_CHANNELS]);
 		/*
 		 * Need to include at least one (first channel, number of
-		 * channels) tuple for each subband, and must have proper
-		 * tuples for the rest of the data as well.
+		 * channels) tuple for each subband (checked in policy),
+		 * and must have proper tuples for the rest of the data as well.
 		 */
-		if (params->supported_channels_len < 2)
-			return -EINVAL;
 		if (params->supported_channels_len % 2)
 			return -EINVAL;
 	}
@@ -8412,23 +8415,14 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 			}
 
 			if (ssid) {
-				if (nla_len(ssid) > IEEE80211_MAX_SSID_LEN) {
-					err = -EINVAL;
-					goto out_free;
-				}
 				memcpy(request->match_sets[i].ssid.ssid,
 				       nla_data(ssid), nla_len(ssid));
 				request->match_sets[i].ssid.ssid_len =
 					nla_len(ssid);
 			}
-			if (bssid) {
-				if (nla_len(bssid) != ETH_ALEN) {
-					err = -EINVAL;
-					goto out_free;
-				}
+			if (bssid)
 				memcpy(request->match_sets[i].bssid,
 				       nla_data(bssid), ETH_ALEN);
-			}
 
 			/* special attribute - old implementation w/a */
 			request->match_sets[i].rssi_thold = default_match_rssi;
@@ -9305,9 +9299,6 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 		auth_data = nla_data(info->attrs[NL80211_ATTR_AUTH_DATA]);
 		auth_data_len = nla_len(info->attrs[NL80211_ATTR_AUTH_DATA]);
-		/* need to include at least Auth Transaction and Status Code */
-		if (auth_data_len < 4)
-			return -EINVAL;
 	}
 
 	local_state_change = !!info->attrs[NL80211_ATTR_LOCAL_STATE_CHANGE];
@@ -12353,8 +12344,6 @@ static int nl80211_set_rekey_data(struct sk_buff *skb, struct genl_info *info)
 	if (!tb[NL80211_REKEY_DATA_REPLAY_CTR] || !tb[NL80211_REKEY_DATA_KEK] ||
 	    !tb[NL80211_REKEY_DATA_KCK])
 		return -EINVAL;
-	if (nla_len(tb[NL80211_REKEY_DATA_REPLAY_CTR]) != NL80211_REPLAY_CTR_LEN)
-		return -ERANGE;
 	if (nla_len(tb[NL80211_REKEY_DATA_KEK]) != NL80211_KEK_LEN &&
 	    !(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK &&
 	      nla_len(tb[NL80211_REKEY_DATA_KEK]) == NL80211_KEK_EXT_LEN))
@@ -12679,8 +12668,7 @@ static int nl80211_nan_add_func(struct sk_buff *skb,
 
 	func->cookie = cfg80211_assign_cookie(rdev);
 
-	if (!tb[NL80211_NAN_FUNC_TYPE] ||
-	    nla_get_u8(tb[NL80211_NAN_FUNC_TYPE]) > NL80211_NAN_FUNC_MAX_TYPE) {
+	if (!tb[NL80211_NAN_FUNC_TYPE]) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -13170,9 +13158,6 @@ static int nl80211_crit_protocol_start(struct sk_buff *skb,
 	duration =
 		nla_get_u16(info->attrs[NL80211_ATTR_MAX_CRIT_PROT_DURATION]);
 
-	if (duration > NL80211_CRIT_PROTO_MAX_DURATION)
-		return -ERANGE;
-
 	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
 	if (!ret)
 		rdev->crit_proto_nlportid = info->snd_portid;
@@ -13826,17 +13811,9 @@ static int nl80211_set_pmk(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	if (info->attrs[NL80211_ATTR_PMKR0_NAME]) {
-		int r0_name_len = nla_len(info->attrs[NL80211_ATTR_PMKR0_NAME]);
-
-		if (r0_name_len != WLAN_PMK_NAME_LEN) {
-			ret = -EINVAL;
-			goto out;
-		}
-
+	if (info->attrs[NL80211_ATTR_PMKR0_NAME])
 		pmk_conf.pmk_r0_name =
 			nla_data(info->attrs[NL80211_ATTR_PMKR0_NAME]);
-	}
 
 	ret = rdev_set_pmk(rdev, dev, &pmk_conf);
 out:
@@ -13895,8 +13872,7 @@ static int nl80211_external_auth(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_SSID]) {
 		params.ssid.ssid_len = nla_len(info->attrs[NL80211_ATTR_SSID]);
-		if (params.ssid.ssid_len == 0 ||
-		    params.ssid.ssid_len > IEEE80211_MAX_SSID_LEN)
+		if (params.ssid.ssid_len == 0)
 			return -EINVAL;
 		memcpy(params.ssid.ssid,
 		       nla_data(info->attrs[NL80211_ATTR_SSID]),
-- 
2.26.2

