Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8256214247E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 08:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgATHvx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 02:51:53 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:44169 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbgATHvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 02:51:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579506712; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=PEdZ+Y4W9RN4Q8BfsRrhwSC1Nfqf9m+uSIqKlHKe2J8=; b=GhsvXkF0gT6nhE5t1EY2pGmrUVKA6g0bBGYpPB//tBMmnZ8+QsPYOG5jHP6LiyFHylAs1Ehn
 agXXGAfvVZXt9LOiWjFF11V8MjpTz5IXXFSWdGkkyD9h1WkwwcSshMtm5oIAUn3mSAS3tMMT
 v0UpVoIshn4Bu7RyoqHAGVPp96Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e255c14.7f98699c33e8-smtp-out-n01;
 Mon, 20 Jan 2020 07:51:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 57A0DC4479C; Mon, 20 Jan 2020 07:51:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52BA2C43383;
        Mon, 20 Jan 2020 07:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52BA2C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv10 5/6] nl80211: Add support to configure TID specific txrate configuration
Date:   Mon, 20 Jan 2020 13:21:26 +0530
Message-Id: <1579506687-18296-6-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
References: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

This patch adds support to configure per TID txrate configuration
configuration through the NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE
and NL80211_TID_CONFIG_ATTR_TX_RATE
attribute. TX bitrate mask values passed
in NL80211_ATTR_TX_RATES attribute and NL80211_TID_CONFIG_ATTR_TX_RATES
attribute will have types of the TX rate should be applied. This uses
nl80211_parse_tx_bitrate_mask to validate and calculate the bitrate
mask.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |    5 +++
 include/uapi/linux/nl80211.h |   24 +++++++++++++
 net/wireless/nl80211.c       |   77 ++++++++++++++++++++++++++++++++----------
 3 files changed, 89 insertions(+), 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 80fd868..58363e6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -634,6 +634,7 @@ enum ieee80211_tid_conf_mask {
 				BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL),
 	IEEE80211_TID_CONF_RTSCTS	=
 				BIT(NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL),
+	IEEE80211_TID_CONF_TX_BITRATE	= BIT(NL80211_TID_CONFIG_ATTR_TX_RATE),
 };
 
 /**
@@ -648,6 +649,8 @@ enum ieee80211_tid_conf_mask {
  * @retry_short: retry count value
  * @ampdu: Enable/Disable aggregation
  * @rtscts: Enable/Disable RTS/CTS
+ * @txrate_type: TX bitrate mask type
+ * @mask: bitrate to be applied for the TID
  */
 struct ieee80211_tid_cfg {
 	bool config_override;
@@ -658,6 +661,8 @@ struct ieee80211_tid_cfg {
 	int retry_short;
 	enum nl80211_tid_config ampdu;
 	enum nl80211_tid_config rtscts;
+	enum nl80211_tx_rate_setting txrate_type;
+	struct cfg80211_bitrate_mask *mask;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 63f89cb..0db55d7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4741,6 +4741,18 @@ enum nl80211_tx_power_setting {
 };
 
 /**
+ * enum nl80211_tx_rate_setting - TX rate configuration type
+ * @NL80211_TX_RATE_AUTOMATIC: automatically determine TX rate
+ * @NL80211_TX_RATE_LIMITED: limit the TX rate by the TX rate parameter
+ * @NL80211_TX_RATE_FIXED: fix TX rate to the TX rate parameter
+ */
+enum nl80211_tx_rate_setting {
+	NL80211_TX_RATE_AUTOMATIC,
+	NL80211_TX_RATE_LIMITED,
+	NL80211_TX_RATE_FIXED,
+};
+
+/**
  * enum nl80211_tid_config - TID config state
  * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
  * @NL80211_TID_CONFIG_DISABLE: Disable config for the TID
@@ -4776,6 +4788,10 @@ enum nl80211_tid_config {
  *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. Its type is u8,
  * @NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL: Enable/Disable RTS_CTS for the TID
  *	specified in %%NL80211_TID_CONFIG_ATTR_TIDS. It is u8 type.
+ * @NL80211_TID_CONFIG_ATTR_TX_RATE: Data frame TX rate mask should be applied
+ *	with the parameters passed through %NL80211_ATTR_TX_RATES. This
+ *	configuration is per TID, TID is specified with
+ *	%NL80211_TID_CONFIG_ATTR_TIDS.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4786,6 +4802,8 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
+	NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE,
+	NL80211_TID_CONFIG_ATTR_TX_RATE,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5630,6 +5648,10 @@ enum nl80211_feature_flags {
  *	RTS_CTS control(enable/disable).
  * @NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL_CONFIG: Driver supports STA specific
  *	RTS_CTS control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_TID_TX_RATE_CONFIG: Driver supports TID specific
+ *	TX bitrate configuration.
+ * @NL80211_EXT_FEATURE_PER_STA_TX_RATE_CONFIG: Driver supports STA specific
+ *	TX bitrate configuration.
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5688,6 +5710,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL_CONFIG,
 	NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_TX_RATE_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_TX_RATE_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0b987c3..2cd404f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -328,6 +328,18 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_HE_BSS_COLOR_ATTR_PARTIAL] = { .type = NLA_FLAG },
 };
 
+static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
+	[NL80211_TXRATE_LEGACY] = { .type = NLA_BINARY,
+				    .len = NL80211_MAX_SUPP_RATES },
+	[NL80211_TXRATE_HT] = { .type = NLA_BINARY,
+				.len = NL80211_MAX_SUPP_HT_RATES },
+	[NL80211_TXRATE_VHT] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = sizeof(struct nl80211_txrate_vht),
+	},
+	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
+};
+
 static const struct nla_policy
 nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_TID_CONFIG_ATTR_OVERRIDE] = { .type = NLA_FLAG },
@@ -340,6 +352,10 @@ static int validate_ie_attr(const struct nlattr *attr,
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 	[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TX_RATE_FIXED),
+	[NL80211_TID_CONFIG_ATTR_TX_RATE] =
+			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -4253,19 +4269,9 @@ static bool vht_set_mcs_mask(struct ieee80211_supported_band *sband,
 	return true;
 }
 
-static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
-	[NL80211_TXRATE_LEGACY] = { .type = NLA_BINARY,
-				    .len = NL80211_MAX_SUPP_RATES },
-	[NL80211_TXRATE_HT] = { .type = NLA_BINARY,
-				.len = NL80211_MAX_SUPP_HT_RATES },
-	[NL80211_TXRATE_VHT] = {
-		.type = NLA_EXACT_LEN_WARN,
-		.len = sizeof(struct nl80211_txrate_vht),
-	},
-	[NL80211_TXRATE_GI] = { .type = NLA_U8 },
-};
-
 static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
+					 struct nlattr *attrs[],
+					 enum nl80211_attrs attr,
 					 struct cfg80211_bitrate_mask *mask)
 {
 	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
@@ -4296,14 +4302,14 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	}
 
 	/* if no rates are given set it back to the defaults */
-	if (!info->attrs[NL80211_ATTR_TX_RATES])
+	if (!attrs[attr])
 		goto out;
 
 	/* The nested attribute uses enum nl80211_band as the index. This maps
 	 * directly to the enum nl80211_band values used in cfg80211.
 	 */
 	BUILD_BUG_ON(NL80211_MAX_SUPP_HT_RATES > IEEE80211_HT_MCS_MASK_LEN * 8);
-	nla_for_each_nested(tx_rates, info->attrs[NL80211_ATTR_TX_RATES], rem) {
+	nla_for_each_nested(tx_rates, attrs[attr], rem) {
 		enum nl80211_band band = nla_type(tx_rates);
 		int err;
 
@@ -4803,7 +4809,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
-		err = nl80211_parse_tx_bitrate_mask(info, &params.beacon_rate);
+		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+						    NL80211_ATTR_TX_RATES,
+						    &params.beacon_rate);
 		if (err)
 			return err;
 
@@ -10561,7 +10569,8 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 	if (!rdev->ops->set_bitrate_mask)
 		return -EOPNOTSUPP;
 
-	err = nl80211_parse_tx_bitrate_mask(info, &mask);
+	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+					    NL80211_ATTR_TX_RATES, &mask);
 	if (err)
 		return err;
 
@@ -11156,7 +11165,9 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
-		err = nl80211_parse_tx_bitrate_mask(info, &setup.beacon_rate);
+		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+						    NL80211_ATTR_TX_RATES,
+						    &setup.beacon_rate);
 		if (err)
 			return err;
 
@@ -13982,6 +13993,38 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE]) {
+		int idx;
+		enum nl80211_attrs attr;
+
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+						       attrs, tid_conf,
+						       TX_RATE);
+		if (err)
+			return err;
+		idx = NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE;
+		tid_conf->txrate_type = nla_get_u8(attrs[idx]);
+		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
+			/* Driver needs to take care of freeing this mask */
+			tid_conf->mask =
+				kzalloc(sizeof(struct cfg80211_bitrate_mask),
+					GFP_KERNEL);
+			if (!tid_conf->mask)
+				return -ENOMEM;
+
+			attr =
+			(enum nl80211_attrs)NL80211_TID_CONFIG_ATTR_TX_RATE;
+			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
+							    tid_conf->mask);
+			if (err) {
+				kfree(tid_conf->mask);
+				return err;
+			}
+		} else {
+			tid_conf->mask = NULL;
+		}
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5
