Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFF6EFD67
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 13:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbfKEMmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 07:42:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388494AbfKEMmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 07:42:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 32DE1614B9; Tue,  5 Nov 2019 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957722;
        bh=uDecwf7yzRzuuGHK0lJufoa8maCuv8bsAIyIYfckKrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayV2+3POc4nEdJ++rI0YRVzK6B9NOedCZ2AdKblfvo3CXPZ+EUagq62Tqo3Dih8oc
         LJyxaeE+hGa4BYyuXuB2Pyyl3rHLMQGL3YRDq5MHoD/6cbLJYVeupfRnLnT5FAaKQx
         cmBX0dhB2tq7b4rYHJ7Fi2qzZj09GfqjMTFRnO/Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C18961491;
        Tue,  5 Nov 2019 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957721;
        bh=uDecwf7yzRzuuGHK0lJufoa8maCuv8bsAIyIYfckKrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLQd7xbcplYNqiSneN0TtTm+oh/rYyDzlvW50kxgOsEQi+RKNLfhie7gV4ftWJUIb
         L328ZieuI5l6NL2I6GviYs26j9iKSrn8jdSeQ/fHAoKqcqnPjLssiIjxMzYbktPp7S
         oL2qtX1nRkCRkRR3xfcI1rEP5NK3Z6tie/yXdZvY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C18961491
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv8 5/6] nl80211: Add netlink attribute to configure TID specific tx rate
Date:   Tue,  5 Nov 2019 18:11:53 +0530
Message-Id: <1572957714-16085-6-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_TID_CONFIG_ATTR_TX_RATES in nl80211_tid_attr_config
to accept data TID specific TX bitrate configuration
through NL80211_CMD_SET_TID_CONFIG command. TID for which the
this configuration is to be applied is passed in
NL80211_TID_CONFIG_ATTR_TID attribute. TX bitrate mask values passed
in NL80211_ATTR_TX_RATES attribute and NL80211_TID_CONFIG_ATTR_TX_RATES
attribute will have types of the TX rate should be applied. This uses
nl80211_parse_tx_bitrate_mask to validate and calculate the bitrate
mask. When the user-space wants this configuration peer specific
rather than being applied for all the connected stations,
MAC address of the peer can be passed in NL80211_ATTR_MAC attribute.

Driver supporting this feature should advertise
NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK and supporting per-STA data TID
TX bitrate configuration should advertise
NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |    5 +++
 include/uapi/linux/nl80211.h |   39 +++++++++++++++++++++
 net/wireless/nl80211.c       |   79 +++++++++++++++++++++++++++++++++---------
 3 files changed, 106 insertions(+), 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index deeb1c1..69f4769 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -601,6 +601,7 @@ enum ieee80211_tid_conf_mask {
 	IEEE80211_TID_CONF_RETRY	= BIT(1),
 	IEEE80211_TID_CONF_AMPDU	= BIT(2),
 	IEEE80211_TID_CONF_RTSCTS	= BIT(3),
+	IEEE80211_TID_CONF_TX_BITRATE	= BIT(4),
 };
 
 /**
@@ -613,6 +614,8 @@ enum ieee80211_tid_conf_mask {
  * @retry_short: retry count value
  * @ampdu: Enable/Disable aggregation
  * @rtscts: Enable/Disable RTS/CTS
+ * @txrate_type: TX bitrate mask type
+ * @mask: bitrate to be applied for the TID
  */
 struct ieee80211_tid_cfg {
 	u8 tid;
@@ -622,6 +625,8 @@ struct ieee80211_tid_cfg {
 	int retry_short;
 	u8 ampdu;
 	u8 rtscts;
+	enum nl80211_tx_rate_setting txrate_type;
+	struct cfg80211_bitrate_mask *mask;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f75f243..034d8ff 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4696,6 +4696,18 @@ enum nl80211_tx_power_setting {
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
  * @NL80211_TID_CONFIG_DEFAULT: Default config for the TID. This is to
  *	notify driver to reset the previous config and use vif specific
@@ -4791,6 +4803,25 @@ enum nl80211_tid_config {
  *	NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL and supporting per station
  *	RTS_CTS configuration should advertise
  *	NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL.
+ * @NL80211_TID_CONFIG_ATTR_TX_RATES: Data frame TX rate mask should be applied
+ *	with the parameters passed through %NL80211_ATTR_TX_RATES. This
+ *	configuration is per TID, TID is specified with
+ *	%NL80211_TID_CONFIG_ATTR_TID.
+ *	If the peer MAC address is passed in %NL80211_ATTR_MAC, then this
+ *	configuration is applied to the data frame for the tid to that connected
+ *	station. This attribute will be useful to notfiy the driver that what
+ *	type of txrate should be applied(%enum enum nl80211_tx_rate_setting)
+ *	for the connected station (%NL80211_ATTR_MAC),
+ *	Station specific retry configuration is valid only for STA's
+ *	current connection. i.e. the configuration will be reset to default when
+ *	the station connects back after disconnection/roaming.
+ *	when user-space does not include %NL80211_ATTR_MAC, this configuration
+ *	should be treated as per-netdev configuration. This configuration will
+ *	be cleared when the interface goes down and on the disconnection from a
+ *	BSS. Driver supporting this feature should advertise
+ *	NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK and supporting per station
+ *	TX bitrate configuration should advertise
+ *	NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4801,6 +4832,8 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
+	NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE,
+	NL80211_TID_CONFIG_ATTR_TX_RATES,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5634,6 +5667,10 @@ enum nl80211_feature_flags {
  *	RTS_CTS control(enable/disable).
  * @NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL: Driver supports STA specific
  *	RTS_CTS control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK: Driver supports TID specific
+ *	TX bitrate configuration.
+ * @NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK: Driver supports STA specific
+ *	TX bitrate configuration.
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5688,6 +5725,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL,
 	NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL,
 	NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL,
+	NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK,
+	NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index abce915..81af51b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -321,6 +321,18 @@ static int validate_ie_attr(const struct nlattr *attr,
 		NLA_POLICY_RANGE(NLA_U8, 1, 20),
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
 	[NL80211_TID_CONFIG_ATTR_TID] = { .type = NLA_U8 },
@@ -333,6 +345,10 @@ static int validate_ie_attr(const struct nlattr *attr,
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 	[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TX_RATE_FIXED),
+	[NL80211_TID_CONFIG_ATTR_TX_RATES] =
+			NLA_POLICY_NESTED(nl80211_txattr_policy),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -4240,19 +4256,9 @@ static bool vht_set_mcs_mask(struct ieee80211_supported_band *sband,
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
@@ -4283,14 +4289,14 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
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
 
@@ -4766,7 +4772,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
-		err = nl80211_parse_tx_bitrate_mask(info, &params.beacon_rate);
+		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+						    NL80211_ATTR_TX_RATES,
+						    &params.beacon_rate);
 		if (err)
 			return err;
 
@@ -10510,7 +10518,8 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 	if (!rdev->ops->set_bitrate_mask)
 		return -EOPNOTSUPP;
 
-	err = nl80211_parse_tx_bitrate_mask(info, &mask);
+	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+					    NL80211_ATTR_TX_RATES, &mask);
 	if (err)
 		return err;
 
@@ -11105,7 +11114,9 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
-		err = nl80211_parse_tx_bitrate_mask(info, &setup.beacon_rate);
+		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
+						    NL80211_ATTR_TX_RATES,
+						    &setup.beacon_rate);
 		if (err)
 			return err;
 
@@ -13914,6 +13925,40 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE]) {
+		int idx;
+		enum nl80211_attrs attr;
+
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+				attrs[NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE],
+				NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK,
+				NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK);
+		if (err)
+			return err;
+
+		idx = NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE;
+		tid_conf->txrate_type = nla_get_u8(attrs[idx]);
+
+		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_TX_BITRATE;
+		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
+			tid_conf->mask =
+				kzalloc(sizeof(struct cfg80211_bitrate_mask),
+					GFP_KERNEL);
+			if (!tid_conf->mask)
+				return -ENOMEM;
+
+			attr = (enum nl80211_attrs) NL80211_TID_CONFIG_ATTR_TX_RATES;
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

