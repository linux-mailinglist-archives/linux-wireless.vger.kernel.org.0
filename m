Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908902826F7
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Oct 2020 23:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJCV5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Oct 2020 17:57:50 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:45791 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgJCV5u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Oct 2020 17:57:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601762268; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=38JBZv6Qq8iCTAEvKdSFNizUFjo+oP2Jt45stTuZvgw=; b=TWy90KIZSkm7hthgMrPnKtsFiKgdoMH7/uw0/aob69xhwgFX5ijcNeQQaNB3a+AwAYTYj1Z4
 NasmKqCxECZJDC+4vn4X5ptR69aANrehFAZf/CSKAvyBZS1Tg92ms1ObvYtTljcXbGKOEZMW
 /0hTwQYpz6U3qxgo8asFuQZRHOk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f78f3dc06d81bc48dc0c0cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 03 Oct 2020 21:57:48
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F35BEC433FE; Sat,  3 Oct 2020 21:57:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA0FEC433CA;
        Sat,  3 Oct 2020 21:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA0FEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v2] cfg80211: add support to configure HE MCS for beacon rate
Date:   Sat,  3 Oct 2020 14:57:37 -0700
Message-Id: <1601762257-14934-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows an option to configure a single HE MCS beacon tx rate.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
v2: clear mcs ratemask when beacon tx rate is not set.

 include/uapi/linux/nl80211.h |  9 +++++++--
 net/wireless/nl80211.c       | 48 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 47700a2b9af9..0c9f0b8a1e4e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1750,8 +1750,9 @@ enum nl80211_commands {
  *	specify just a single bitrate, which is to be used for the beacon.
  *	The driver must also specify support for this with the extended
  *	features NL80211_EXT_FEATURE_BEACON_RATE_LEGACY,
- *	NL80211_EXT_FEATURE_BEACON_RATE_HT and
- *	NL80211_EXT_FEATURE_BEACON_RATE_VHT.
+ *	NL80211_EXT_FEATURE_BEACON_RATE_HT,
+ *	NL80211_EXT_FEATURE_BEACON_RATE_VHT and
+ *	NL80211_EXT_FEATURE_BEACON_RATE_HE.
  *
  * @NL80211_ATTR_FRAME_MATCH: A binary attribute which typically must contain
  *	at least one byte, currently used with @NL80211_CMD_REGISTER_FRAME.
@@ -5896,6 +5897,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP: Driver/device supports
  *	unsolicited broadcast probe response transmission
  *
+ * @NL80211_EXT_FEATURE_BEACON_RATE_HE: Driver supports beacon rate
+ *	configuration (AP/mesh) with HE rates.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5956,6 +5960,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD_AP,
 	NL80211_EXT_FEATURE_FILS_DISCOVERY,
 	NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP,
+	NL80211_EXT_FEATURE_BEACON_RATE_HE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 91d4550677d0..c1c1f516b093 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4591,7 +4591,8 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					 struct nlattr *attrs[],
 					 enum nl80211_attrs attr,
 					 struct cfg80211_bitrate_mask *mask,
-					 struct net_device *dev)
+					 struct net_device *dev,
+					 bool is_beacon_tx_rate)
 {
 	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -4672,14 +4673,20 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					nla_len(tb[NL80211_TXRATE_HT]),
 					mask->control[band].ht_mcs))
 				return -EINVAL;
-		}
+		} else if (is_beacon_tx_rate)
+			memset(&mask->control[band].ht_mcs, 0,
+			       sizeof(mask->control[band].ht_mcs));
+
 		if (tb[NL80211_TXRATE_VHT]) {
 			if (!vht_set_mcs_mask(
 					sband,
 					nla_data(tb[NL80211_TXRATE_VHT]),
 					mask->control[band].vht_mcs))
 				return -EINVAL;
-		}
+		} else if (is_beacon_tx_rate)
+			memset(&mask->control[band].vht_mcs, 0,
+			       sizeof(mask->control[band].vht_mcs));
+
 		if (tb[NL80211_TXRATE_GI]) {
 			mask->control[band].gi =
 				nla_get_u8(tb[NL80211_TXRATE_GI]);
@@ -4691,6 +4698,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 				     nla_data(tb[NL80211_TXRATE_HE]),
 				     mask->control[band].he_mcs))
 			return -EINVAL;
+		else if (is_beacon_tx_rate)
+			memset(&mask->control[band].he_mcs, 0,
+			       sizeof(mask->control[band].he_mcs));
+
 		if (tb[NL80211_TXRATE_HE_GI])
 			mask->control[band].he_gi =
 				nla_get_u8(tb[NL80211_TXRATE_HE_GI]);
@@ -4732,7 +4743,7 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 				   enum nl80211_band band,
 				   struct cfg80211_bitrate_mask *beacon_rate)
 {
-	u32 count_ht, count_vht, i;
+	u32 count_ht, count_vht, count_he, i;
 	u32 rate = beacon_rate->control[band].legacy;
 
 	/* Allow only one rate */
@@ -4765,7 +4776,21 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 	}
 
-	if ((count_ht && count_vht) || (!rate && !count_ht && !count_vht))
+	count_he = 0;
+	for (i = 0; i < NL80211_HE_NSS_MAX; i++) {
+		if (hweight16(beacon_rate->control[band].he_mcs[i]) > 1) {
+			return -EINVAL;
+		} else if (beacon_rate->control[band].he_mcs[i]) {
+			count_he++;
+			if (count_he > 1)
+				return -EINVAL;
+		}
+		if (count_he && rate)
+			return -EINVAL;
+	}
+
+	if ((count_ht && count_vht && count_he) ||
+	    (!rate && !count_ht && !count_vht && !count_he))
 		return -EINVAL;
 
 	if (rate &&
@@ -4780,6 +4805,10 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	    !wiphy_ext_feature_isset(&rdev->wiphy,
 				     NL80211_EXT_FEATURE_BEACON_RATE_VHT))
 		return -EINVAL;
+	if (count_he &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_BEACON_RATE_HE))
+		return -EINVAL;
 
 	return 0;
 }
@@ -5240,7 +5269,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
 						    &params.beacon_rate,
-						    dev);
+						    dev, true);
 		if (err)
 			return err;
 
@@ -11084,7 +11113,7 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 
 	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 					    NL80211_ATTR_TX_RATES, &mask,
-					    dev);
+					    dev, false);
 	if (err)
 		return err;
 
@@ -11693,7 +11722,7 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
 						    &setup.beacon_rate,
-						    dev);
+						    dev, true);
 		if (err)
 			return err;
 
@@ -14473,7 +14502,8 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
 			attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
 			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
-						    &tid_conf->txrate_mask, dev);
+						    &tid_conf->txrate_mask, dev,
+						    false);
 			if (err)
 				return err;
 
-- 
2.7.4

