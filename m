Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2503A1BED68
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 03:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD3BGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 21:06:53 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:58368 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726419AbgD3BGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 21:06:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 1161C4F8012;
        Thu, 30 Apr 2020 01:06:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W62SyVQg8wf1; Thu, 30 Apr 2020 01:06:47 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 6DA4C4F8013;
        Thu, 30 Apr 2020 01:06:44 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 3/5] nl80211: support scan frequencies in KHz
Date:   Wed, 29 Apr 2020 18:06:40 -0700
Message-Id: <20200430010642.22552-4-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430010642.22552-1-thomas@adapt-ip.com>
References: <20200430010642.22552-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the driver advertises NL80211_EXT_FEATURE_SCAN_FREQ_KHZ
userspace can omit NL80211_ATTR_SCAN_FREQUENCIES in favor
of an NL80211_ATTR_SCAN_FREQ_KHZ. To get scan results in
KHz userspace must also set the
NL80211_SCAN_FLAG_FREQ_KHZ.

This lets nl80211 remain compatible with older userspaces
while not requring and sending redundant (and potentially
incorrect) scan frequency sets.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---
v3:
- report SCAN_FREQ_KHZ in scan results
- advertise SCAN_FREQ_KHZ support in feature flag
- add SCAN_FLAG_FREQ_KHZ so user can select scan result
  frequency units
---
 include/uapi/linux/nl80211.h | 13 ++++++++-
 net/mac80211/main.c          |  2 ++
 net/wireless/nl80211.c       | 52 +++++++++++++++++++++++++++---------
 3 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0ceb4de52d9a..b6012aa5103b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2492,7 +2492,7 @@ enum nl80211_commands {
  *	an %NL80211_ATTR_WIPHY_FREQ_OFFSET.
  * @NL80211_ATTR_CENTER_FREQ1_OFFSET: Center frequency offset in KHz for the
  *	first channel segment specified in %NL80211_ATTR_CENTER_FREQ1.
- *
+ * @NL80211_ATTR_SCAN_FREQ_KHZ: nested attribute with KHz frequencies
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -2972,6 +2972,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_RECEIVE_MULTICAST,
 	NL80211_ATTR_WIPHY_FREQ_OFFSET,
 	NL80211_ATTR_CENTER_FREQ1_OFFSET,
+	NL80211_ATTR_SCAN_FREQ_KHZ,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -5721,6 +5722,11 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS: management frame registrations
  *	are possible for multicast frames and those will be reported properly.
  *
+ * @NL80211_EXT_FEATURE_SCAN_FREQ_KHZ: This driver supports receiving and
+ *	reporting scan request with %NL80211_ATTR_SCAN_FREQ_KHZ. In order to
+ *	report %NL80211_ATTR_SCAN_FREQ_KHZ, %NL80211_SCAN_FLAG_FREQ_KHZ must be
+ *	included in the scan request.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5774,6 +5780,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_DEL_IBSS_STA,
 	NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS,
 	NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT,
+	NL80211_EXT_FEATURE_SCAN_FREQ_KHZ,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -5885,6 +5892,9 @@ enum nl80211_timeout_reason {
  * @NL80211_SCAN_FLAG_MIN_PREQ_CONTENT: minimize probe request content to
  *	only have supported rates and no additional capabilities (unless
  *	added by userspace explicitly.)
+ * @NL80211_SCAN_FLAG_FREQ_KHZ: report scan results with
+ *	%NL80211_ATTR_SCAN_FREQ_KHZ. This also means
+ *	%NL80211_ATTR_SCAN_FREQUENCIES will not be included.
  */
 enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_LOW_PRIORITY				= 1<<0,
@@ -5900,6 +5910,7 @@ enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_HIGH_ACCURACY				= 1<<10,
 	NL80211_SCAN_FLAG_RANDOM_SN				= 1<<11,
 	NL80211_SCAN_FLAG_MIN_PREQ_CONTENT			= 1<<12,
+	NL80211_SCAN_FLAG_FREQ_KHZ				= 1<<13,
 };
 
 /**
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 06c90d360633..ac74bd780b42 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -596,6 +596,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_SCAN_FREQ_KHZ);
 
 	if (!ops->hw_scan) {
 		wiphy->features |= NL80211_FEATURE_LOW_PRIORITY_SCAN |
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fb056613a23f..decd37fd470e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -664,6 +664,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
 	[NL80211_ATTR_RECEIVE_MULTICAST] = { .type = NLA_FLAG },
 	[NL80211_ATTR_WIPHY_FREQ_OFFSET] = NLA_POLICY_RANGE(NLA_U32, 0, 999),
+	[NL80211_ATTR_SCAN_FREQ_KHZ] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -7761,6 +7762,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_scan_request *request;
+	struct nlattr *scan_freqs = NULL;
+	bool scan_freqs_khz = false;
 	struct nlattr *attr;
 	struct wiphy *wiphy;
 	int err, tmp, n_ssids = 0, n_channels, i;
@@ -7779,9 +7782,17 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
-	if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]) {
-		n_channels = validate_scan_freqs(
-				info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]);
+	if (info->attrs[NL80211_ATTR_SCAN_FREQ_KHZ]) {
+		if (!wiphy_ext_feature_isset(wiphy,
+					     NL80211_EXT_FEATURE_SCAN_FREQ_KHZ))
+			return -EOPNOTSUPP;
+		scan_freqs = info->attrs[NL80211_ATTR_SCAN_FREQ_KHZ];
+		scan_freqs_khz = true;
+	} else if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES])
+		scan_freqs = info->attrs[NL80211_ATTR_SCAN_FREQUENCIES];
+
+	if (scan_freqs) {
+		n_channels = validate_scan_freqs(scan_freqs);
 		if (!n_channels) {
 			err = -EINVAL;
 			goto unlock;
@@ -7829,13 +7840,16 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	i = 0;
-	if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]) {
+	if (scan_freqs) {
 		/* user specified, bail out if channel not found */
-		nla_for_each_nested(attr, info->attrs[NL80211_ATTR_SCAN_FREQUENCIES], tmp) {
+		nla_for_each_nested(attr, scan_freqs, tmp) {
 			struct ieee80211_channel *chan;
+			int freq = nla_get_u32(attr);
 
-			chan = ieee80211_get_channel(wiphy, nla_get_u32(attr));
+			if (!scan_freqs_khz)
+				freq = MHZ_TO_KHZ(freq);
 
+			chan = ieee80211_get_channel_khz(wiphy, freq);
 			if (!chan) {
 				err = -EINVAL;
 				goto out_free;
@@ -15270,14 +15284,28 @@ static int nl80211_add_scan_req(struct sk_buff *msg,
 	}
 	nla_nest_end(msg, nest);
 
-	nest = nla_nest_start_noflag(msg, NL80211_ATTR_SCAN_FREQUENCIES);
-	if (!nest)
-		goto nla_put_failure;
-	for (i = 0; i < req->n_channels; i++) {
-		if (nla_put_u32(msg, i, req->channels[i]->center_freq))
+	if (req->flags & NL80211_SCAN_FLAG_FREQ_KHZ) {
+		nest = nla_nest_start_noflag(msg,
+					     NL80211_ATTR_SCAN_FREQ_KHZ);
+		if (!nest)
+			goto nla_put_failure;
+		for (i = 0; i < req->n_channels; i++) {
+			if (nla_put_u32(msg, i,
+				   ieee80211_channel_to_khz(req->channels[i])))
+				goto nla_put_failure;
+		}
+		nla_nest_end(msg, nest);
+	} else {
+		nest = nla_nest_start_noflag(msg,
+					     NL80211_ATTR_SCAN_FREQUENCIES);
+		if (!nest)
 			goto nla_put_failure;
+		for (i = 0; i < req->n_channels; i++) {
+			if (nla_put_u32(msg, i, req->channels[i]->center_freq))
+				goto nla_put_failure;
+		}
+		nla_nest_end(msg, nest);
 	}
-	nla_nest_end(msg, nest);
 
 	if (req->ie &&
 	    nla_put(msg, NL80211_ATTR_IE, req->ie_len, req->ie))
-- 
2.20.1

