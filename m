Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E256AECD89
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2019 07:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKBGIC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Nov 2019 02:08:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBGIC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Nov 2019 02:08:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3386B6126D; Sat,  2 Nov 2019 06:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572674881;
        bh=OzDWEz0D3IWHlcA4gpZX3A3ihcCV+CLpFFPHBlkZ6BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYPLK3Z3ECVSWK607tQ+t1UKpqD3NvIqHP5xD8lIGxwL3/2+lujqLxcNbvrPV7GN/
         ySQYK04DadCv4LNr6GeWyLGVBLXv96Spya1BLee9pZ8H6ANqkmIv1JIkz4AfBBd/qv
         F6Kg0/1BZzYGTOAgjTbVj3r581XBa9kfv56Dk2wE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C91261466;
        Sat,  2 Nov 2019 06:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572674880;
        bh=OzDWEz0D3IWHlcA4gpZX3A3ihcCV+CLpFFPHBlkZ6BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUvPJ8IvL0YSKBNZqEYzwuHaJsMUJB6EVUMb8kW20hRAVsJHPE2S20CMTowjzeefB
         muQkeA3itGhsrJF7Jo4lja6U4A2O97qjo1UjsPouVKCdDrauc5GCy8NPf5fL5xHeeG
         o1969YiaXeSPtsZDShjrtxgZ4aEoWdYfrj23L7zs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C91261466
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv7 2/6] nl80211: Add new netlink attribute for TID speicific retry count
Date:   Sat,  2 Nov 2019 11:37:46 +0530
Message-Id: <1572674870-23517-3-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572674870-23517-1-git-send-email-tamizhr@codeaurora.org>
References: <1572674870-23517-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch introduced below NL attributes to add support for
configuring data TID specific retry count

NL80211_TID_CONFIG_ATTR_RETRY
NL80211_TID_CONFIG_ATTR_RETRY_SHORT
NL80211_TID_CONFIG_ATTR_RETRY_LONG

These attributes are added in NL80211_ATTR_TID_CONFIG nested attribute.
This will be useful for the driver which supports data TID specific retry
count configuration rather using phy level retry configuration.
This TID specific retry configuration will have more precedence than
phy level configuration. This configuration can be applied for a
specific peer. To apply this configuration specific to a peer
rather than being applied for all the connected stations,
MAC address of the peer can be passed in NL80211_ATTR_MAC attribute.

Driver should advertise WIPHY_FLAG_HAS_MAX_DATA_RETRY_COUNT and
max_data_retry_count value to notify user space to avoid of passing
greater than the allowed limit.

Driver supporting TID specific retry configuration should advertise
NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG and per STA specific
data TID retry configuration should advertise
NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |    9 ++++++++
 include/uapi/linux/nl80211.h |   48 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       |   45 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 58e956d..dd40774 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -598,6 +598,7 @@ struct cfg80211_chan_def {
 
 enum ieee80211_tid_conf_mask {
 	IEEE80211_TID_CONF_NOACK	= BIT(0),
+	IEEE80211_TID_CONF_RETRY	= BIT(1),
 };
 
 /**
@@ -606,11 +607,15 @@ enum ieee80211_tid_conf_mask {
  * @tid_conf_mask: bitmap indicating which parameter changed
  *	see %enum ieee80211_tid_conf_mask
  * @noack: noack configuration value for the TID
+ * @retry_long: retry count value
+ * @retry_short: retry count value
  */
 struct ieee80211_tid_cfg {
 	u8 tid;
 	u32 tid_conf_mask;
 	u8 noack;
+	int retry_long;
+	int retry_short;
 };
 
 /**
@@ -4567,6 +4572,8 @@ struct cfg80211_pmsr_capabilities {
  *	@support_mbssid must be set for this to have any effect.
  *
  * @pmsr_capa: peer measurement capabilities
+ * @max_data_retry_count: Maximum limit can be configured as retry count
+ *	for a TID.
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
@@ -4711,6 +4718,8 @@ struct wiphy {
 
 	const struct cfg80211_pmsr_capabilities *pmsr_capa;
 
+	u8 max_data_retry_count;
+
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c0b43da..69b3229 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2389,6 +2389,8 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
  *	nested attribute with %NL80211_TID_CONFIG_ATTR_* sub-attributes.
+ * @NL80211_ATTR_MAX_RETRY_COUNT: The upper limit for the retry count
+ *	configuration that the driver can accept.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -2853,6 +2855,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_WIPHY_EDMG_BW_CONFIG,
 
 	NL80211_ATTR_TID_CONFIG,
+	NL80211_ATTR_MAX_RETRY_COUNT,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -4722,11 +4725,50 @@ enum nl80211_tid_config {
  *	advertise NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG and
  *	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG for supporting  per sta
  *	configuration.
+ * @NL80211_TID_CONFIG_ATTR_RETRY: Data TID retry count should be applied
+ *	with the value passed through %NL80211_TID_CONFIG_ATTR_RETRY_LONG
+ *	and/or %NL80211_TID_CONFIG_ATTR_RETRY_SHORT. This configuration
+ *	is per-TID, and the TID is specified with %NL80211_TID_CONFIG_ATTR_TID.
+ *	If the peer MAC address is passed in %NL80211_ATTR_MAC, the retry
+ *	configuration is applied to the data frame for the tid to that
+ *	connected station.
+ *	This attribute will be useful to notfiy the driver to apply default
+ *	retry values for the connected station (%NL80211_ATTR_MAC), when the
+ *	command received without %NL80211_ATTR_RETRY_LONG and/or
+ *	%NL80211_ATTR_RETRY_SHORT.
+ *	Station specific retry configuration is valid only for STA's
+ *	current connection. i.e. the configuration will be reset to default when
+ *	the station connects back after disconnection/roaming.
+ *	when user-space does not include %NL80211_ATTR_MAC, this configuration
+ *	should be treated as per-netdev configuration. This configuration will
+ *	be cleared when the interface goes down and on the disconnection from a
+ *	BSS. When retry count has never been configured using this command, the
+ *	other available radio level retry configuration
+ *	(%NL80211_ATTR_WIPHY_RETRY_SHORT and %NL80211_ATTR_WIPHY_RETRY_LONG)
+ *	should be used. Driver supporting this feature should advertise
+ *	NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG and supporting per station
+ *	retry count configuration should advertise
+ *	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG.
+ * @NL80211_TID_CONFIG_ATTR_RETRY_SHORT: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. It is u8 type, min value is 1 and
+ *	the max value should be advertised by the driver through
+ *	max_data_retry_count. when this attribute is not present, the driver
+ *	would use the default configuration.
+ * @NL80211_TID_CONFIG_ATTR_RETRY_LONG: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
+ *	the max value should be advertised by the driver through
+ *	max_data_retry_count. when this attribute is not present, the driver
+ *	would use the default configuration.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
 	NL80211_TID_CONFIG_ATTR_TID,
 	NL80211_TID_CONFIG_ATTR_NOACK,
+	NL80211_TID_CONFIG_ATTR_RETRY,
+	NL80211_TID_CONFIG_ATTR_RETRY_SHORT,
+	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5548,6 +5590,10 @@ enum nl80211_feature_flags {
  *	policy functionality.
  * @NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG: Driver supports STA specific NoAck
  *	policy functionality.
+ * @NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG: Driver supports per TID data retry
+ *	count functionality.
+ * @NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG: Driver supports STA specific
+ *	data retry count functionality.
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5596,6 +5642,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c5c3af5..7facc93 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -326,6 +326,9 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_TID_CONFIG_ATTR_TID] = { .type = NLA_U8 },
 	[NL80211_TID_CONFIG_ATTR_NOACK] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_RETRY] = { .type = NLA_FLAG },
+	[NL80211_TID_CONFIG_ATTR_RETRY_SHORT] = { .type = NLA_U8},
+	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = { .type = NLA_U8},
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -2028,6 +2031,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			}
 		}
 
+		if (rdev->wiphy.max_data_retry_count) {
+			if (nla_put_u8(msg, NL80211_ATTR_MAX_RETRY_COUNT,
+			    rdev->wiphy.max_data_retry_count))
+				goto nla_put_failure;
+		}
+
 		state->split_start++;
 		if (state->split)
 			break;
@@ -13839,6 +13848,42 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_NOACK]);
 	}
 
+	if (nla_get_flag(attrs[NL80211_TID_CONFIG_ATTR_RETRY])) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+				attrs[NL80211_TID_CONFIG_ATTR_RETRY],
+				NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG,
+				NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG);
+		if (err)
+			return err;
+
+		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_RETRY;
+		if (attrs[NL80211_TID_CONFIG_ATTR_RETRY_SHORT]) {
+			tid_conf->retry_short =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RETRY_SHORT]);
+			if (tid_conf->retry_short >
+					rdev->wiphy.max_data_retry_count)
+				return -EINVAL;
+		} else {
+			/* Use driver default retry count or VIF specific
+			 * retry count
+			 */
+			tid_conf->retry_short = -1;
+		}
+
+		if (attrs[NL80211_TID_CONFIG_ATTR_RETRY_LONG]) {
+			tid_conf->retry_long =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RETRY_LONG]);
+			if (tid_conf->retry_long >
+					rdev->wiphy.max_data_retry_count)
+				return -EINVAL;
+		} else {
+			/* Use driver default retry count or VIF specific
+			 * retry count
+			 */
+			tid_conf->retry_long = -1;
+		}
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

