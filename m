Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5848C1B0072
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 06:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgDTEIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 00:08:04 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18627 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgDTEID (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 00:08:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587355682; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=uLPkUHJ5Dt3/qR98hS3/FxF3xjg5xJm+1i981Umx2XM=; b=TMXsoaue1i3tsoPtMNt7bDNNHkRTN53KikN/yEu+gxrACjO6+81Gk/lZ2GQRlMyygjLNPxCT
 3Lm4lqjvIhjzy7TgjP1MFp7D1PoA2xNQrHmHYZTu0iRlHbJLQt8D+WJYvQp6tQLhBGFmuZJU
 5IU+jMO3zyd8mhMgSDME5Jerzwo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9d2021.7f4aaf71a1f0-smtp-out-n03;
 Mon, 20 Apr 2020 04:08:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C70B2C433F2; Mon, 20 Apr 2020 04:08:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DBBDC433CB;
        Mon, 20 Apr 2020 04:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DBBDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] nl80211: Add support to configure TID specific Tx rate configuration
Date:   Mon, 20 Apr 2020 09:37:37 +0530
Message-Id: <1587355657-11727-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support to configure per TID Tx Rate configuration
through NL80211_TID_CONFIG_ATTR_TX_RATE* attributes. And it uses
nl80211_parse_tx_bitrate_mask api to validate the Tx rate mask.

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |   26 +++++++++--------
 include/uapi/linux/nl80211.h |   21 ++++++++++++++
 net/wireless/nl80211.c       |   64 +++++++++++++++++++++++++++++++-----------
 3 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 70e48f6..77ab2be 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -626,6 +626,18 @@ struct cfg80211_chan_def {
 	struct ieee80211_edmg edmg;
 };
 
+/*
+ * cfg80211_bitrate_mask - masks for bitrate control
+ */
+struct cfg80211_bitrate_mask {
+	struct {
+		u32 legacy;
+		u8 ht_mcs[IEEE80211_HT_MCS_MASK_LEN];
+		u16 vht_mcs[NL80211_VHT_NSS_MAX];
+		enum nl80211_txrate_gi gi;
+	} control[NUM_NL80211_BANDS];
+};
+
 /**
  * struct cfg80211_tid_cfg - TID specific configuration
  * @config_override: Flag to notify driver to reset TID configuration
@@ -647,6 +659,8 @@ struct cfg80211_tid_cfg {
 	u8 retry_long, retry_short;
 	enum nl80211_tid_config ampdu;
 	enum nl80211_tid_config rtscts;
+	enum nl80211_tx_rate_setting txrate_type;
+	struct cfg80211_bitrate_mask txrate_mask;
 };
 
 /**
@@ -1000,18 +1014,6 @@ struct cfg80211_acl_data {
 	struct mac_address mac_addrs[];
 };
 
-/*
- * cfg80211_bitrate_mask - masks for bitrate control
- */
-struct cfg80211_bitrate_mask {
-	struct {
-		u32 legacy;
-		u8 ht_mcs[IEEE80211_HT_MCS_MASK_LEN];
-		u16 vht_mcs[NL80211_VHT_NSS_MAX];
-		enum nl80211_txrate_gi gi;
-	} control[NUM_NL80211_BANDS];
-};
-
 /**
  * enum cfg80211_ap_settings_flags - AP settings flags
  *
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b69116..74f2678 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4800,6 +4800,17 @@ enum nl80211_tid_config {
 	NL80211_TID_CONFIG_DISABLE,
 };
 
+/* enum nl80211_tx_rate_setting - TX rate configuration type
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
 /* enum nl80211_tid_config_attr - TID specific configuration.
  * @NL80211_TID_CONFIG_ATTR_PAD: pad attribute for 64-bit values
  * @NL80211_TID_CONFIG_ATTR_VIF_SUPP: a bitmap (u64) of attributes supported
@@ -4834,6 +4845,14 @@ enum nl80211_tid_config {
  * @NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL: Enable/Disable RTS_CTS for the TIDs
  *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. It is u8 type, using
  *	the values from &nl80211_tid_config.
+ * @NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE: This attribute will be useful
+ *	to notfiy the driver that what type of txrate should be used
+ *	for the TIDs specified in %NL80211_TID_CONFIG_ATTR_TIDS. using
+ *	the values form &nl80211_tx_rate_setting.
+ * @NL80211_TID_CONFIG_ATTR_TX_RATE: Data frame TX rate mask should be applied
+ *	with the parameters passed through %NL80211_ATTR_TX_RATES.
+ *	configuration is applied to the data frame for the tid to that connected
+ *	station.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4847,6 +4866,8 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
+	NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE,
+	NL80211_TID_CONFIG_ATTR_TX_RATE,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 692bcd3..739bbf8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -331,6 +331,18 @@ static int validate_ie_attr(const struct nlattr *attr,
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
 	[NL80211_TID_CONFIG_ATTR_VIF_SUPP] = { .type = NLA_U64 },
@@ -345,6 +357,10 @@ static int validate_ie_attr(const struct nlattr *attr,
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 	[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TX_RATE_FIXED),
+	[NL80211_TID_CONFIG_ATTR_TX_RATE] =
+			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -4401,19 +4417,9 @@ static bool vht_set_mcs_mask(struct ieee80211_supported_band *sband,
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
@@ -4444,14 +4450,14 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
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
 
@@ -4954,7 +4960,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
-		err = nl80211_parse_tx_bitrate_mask(info, &params.beacon_rate);
+		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+						    NL80211_ATTR_TX_RATES,
+						    &params.beacon_rate);
 		if (err)
 			return err;
 
@@ -10735,7 +10743,8 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 	if (!rdev->ops->set_bitrate_mask)
 		return -EOPNOTSUPP;
 
-	err = nl80211_parse_tx_bitrate_mask(info, &mask);
+	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+					    NL80211_ATTR_TX_RATES, &mask);
 	if (err)
 		return err;
 
@@ -11332,7 +11341,9 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
-		err = nl80211_parse_tx_bitrate_mask(info, &setup.beacon_rate);
+		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+						    NL80211_ATTR_TX_RATES,
+						    &setup.beacon_rate);
 		if (err)
 			return err;
 
@@ -14104,6 +14115,25 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE]) {
+		int idx;
+		enum nl80211_attrs attr;
+
+		idx = NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE;
+		tid_conf->txrate_type = nla_get_u8(attrs[idx]);
+		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
+			attr =
+			(enum nl80211_attrs)NL80211_TID_CONFIG_ATTR_TX_RATE;
+			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
+						    &tid_conf->txrate_mask);
+			if (err)
+				return err;
+
+			tid_conf->mask |= BIT(NL80211_TID_CONFIG_ATTR_TX_RATE);
+		}
+		tid_conf->mask |= BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE);
+	}
+
 	if (peer)
 		mask = rdev->wiphy.tid_config_support.peer;
 	else
-- 
1.7.9.5
