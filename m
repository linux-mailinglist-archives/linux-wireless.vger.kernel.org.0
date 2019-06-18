Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67C34992F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 08:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfFRGrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 02:47:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfFRGrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB3CF6087F; Tue, 18 Jun 2019 05:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835659;
        bh=w0gQg8jE4StwZzKsn6H8J36E7/NZ4cdxLJEm4AxGU5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMYnNORWwHsa9miNOFFgGukqvPBt173efXBdgHepZ/c8Hqw0rsDtKa4kibv6Rvp2h
         1lIAXN7Q5nuZnrt08gl6ll1jMAWb8FgcqjvbUOclfEbXQWSQtm+mHjr47AVenNgXvh
         GWV/c6lgTk5xjevC73QttXl3A5spJSXFW3jWzUeI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2CC960767;
        Tue, 18 Jun 2019 05:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835658;
        bh=w0gQg8jE4StwZzKsn6H8J36E7/NZ4cdxLJEm4AxGU5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STyg1vHpHRHbLQyELudoqwxIY81ab4zcKSPCv4SQpU1yvBrclJxHosIXlrJ217rM9
         j05LvS2X58p8uxLPEcfif2b7WdLvyisgIF5bFPJ/2TIK71sCCPuffiy4LWY+m++pSx
         g6ImgkKV8NFQVHdJLRpa4Zbih28q7d/aW9eD7y7o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2CC960767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv6 2/9] nl80211: Add new netlink attribute for TID speicific retry count
Date:   Tue, 18 Jun 2019 10:57:05 +0530
Message-Id: <1560835632-17405-3-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch introduced below NL attributes to add support for
configuring data TID specific retry count

NL80211_TID_ATTR_CONFIG_RETRY
NL80211_TID_ATTR_CONFIG_RETRY_LONG
NL80211_TID_ATTR_CONFIG_RETRY_SHORT

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
 include/net/cfg80211.h       |   11 ++++++++++
 include/uapi/linux/nl80211.h |   48 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       |   44 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index af5d684..91bcb07 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -527,6 +527,7 @@ struct cfg80211_chan_def {
 
 enum ieee80211_tid_conf_mask {
 	IEEE80211_TID_CONF_NOACK	= BIT(0),
+	IEEE80211_TID_CONF_RETRY	= BIT(1),
 };
 
 /**
@@ -535,11 +536,15 @@ enum ieee80211_tid_conf_mask {
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
@@ -3925,6 +3930,7 @@ struct cfg80211_ops {
  *	beaconing mode (AP, IBSS, Mesh, ...).
  * @WIPHY_FLAG_HAS_STATIC_WEP: The device supports static WEP key installation
  *	before connection.
+ * @WIPHY_FLAG_HAS_MAX_DATA_RETRY_COUNT: Device supports data retry count call.
  */
 enum wiphy_flags {
 	/* use hole at 0 */
@@ -3951,6 +3957,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_HAS_STATIC_WEP		= BIT(24),
+	WIPHY_FLAG_HAS_MAX_DATA_RETRY_COUNT	= BIT(25),
 };
 
 /**
@@ -4466,6 +4473,8 @@ struct cfg80211_pmsr_capabilities {
  *	@support_mbssid must be set for this to have any effect.
  *
  * @pmsr_capa: peer measurement capabilities
+ * @max_data_retry_count: Maximum limit can be configured as retry count
+ *	for a TID.
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
@@ -4610,6 +4619,8 @@ struct wiphy {
 
 	const struct cfg80211_pmsr_capabilities *pmsr_capa;
 
+	u8 max_data_retry_count;
+
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e628f4e..d30d7c9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2364,6 +2364,8 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
  *	nested attribute with %NL80211_TID_ATTR_* sub-attributes.
+ * @NL80211_ATTR_MAX_RETRY_COUNT: The upper limit for the retry count
+ *	configuration that the driver can accept.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -2823,6 +2825,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_TWT_RESPONDER,
 
 	NL80211_ATTR_TID_CONFIG,
+	NL80211_ATTR_MAX_RETRY_COUNT,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -4673,11 +4676,50 @@ enum nl80211_tid_config {
  *	advertise NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG and
  *	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG for supporting  per sta
  *	configuration.
+ * @NL80211_TID_ATTR_CONFIG_RETRY: Data TID retry count should be applied
+ *	with the value passed through %NL80211_TID_ATTR_CONFIG_RETRY_LONG
+ *	and/or %NL80211_TID_ATTR_CONFIG_RETRY_SHORT. This configuration
+ *	is per-TID, and the TID is specified with %NL80211_TID_ATTR_CONFIG_TID.
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
+ * @NL80211_TID_ATTR_CONFIG_RETRY_SHORT: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. It is u8 type, min value is 1 and
+ *	the max value should be advertised by the driver through
+ *	max_data_retry_count. when this attribute is not present, the driver
+ *	would use the default configuration.
+ * @NL80211_TID_ATTR_CONFIG_RETRY_LONG: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
+ *	the max value should be advertised by the driver through
+ *	max_data_retry_count. when this attribute is not present, the driver
+ *	would use the default configuration.
  */
 enum nl80211_tid_attr_config {
 	__NL80211_TID_ATTR_INVALID,
 	NL80211_TID_ATTR_CONFIG_TID,
 	NL80211_TID_ATTR_CONFIG_NOACK,
+	NL80211_TID_ATTR_CONFIG_RETRY,
+	NL80211_TID_ATTR_CONFIG_RETRY_SHORT,
+	NL80211_TID_ATTR_CONFIG_RETRY_LONG,
 
 	/* keep last */
 	__NL80211_TID_ATTR_CONFIG_AFTER_LAST,
@@ -5499,6 +5541,10 @@ enum nl80211_feature_flags {
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
@@ -5547,6 +5593,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4881bfb6..a21a4f4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -286,6 +286,9 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_TID_ATTR_CONFIG_TID] = { .type = NLA_U8 },
 	[NL80211_TID_ATTR_CONFIG_NOACK] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_ATTR_CONFIG_RETRY] = { .type = NLA_FLAG },
+	[NL80211_TID_ATTR_CONFIG_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 0),
+	[NL80211_TID_ATTR_CONFIG_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 0),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -13617,6 +13620,47 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_ATTR_CONFIG_NOACK]);
 	}
 
+	if (nla_get_flag(attrs[NL80211_TID_ATTR_CONFIG_RETRY])) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG)) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    attrs[NL80211_TID_ATTR_CONFIG_RETRY],
+					    "TID specific configuration not "
+					    "supported");
+			return -ENOTSUPP;
+		}
+
+		if (peer && !wiphy_ext_feature_isset(&rdev->wiphy,
+				NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG)) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    attrs[NL80211_TID_ATTR_CONFIG_RETRY],
+					    "peer specfic TID configuration not "
+					    "supported");
+			return -ENOTSUPP;
+		}
+
+		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_RETRY;
+		if (attrs[NL80211_TID_ATTR_CONFIG_RETRY_SHORT]) {
+			tid_conf->retry_short =
+			nla_get_u8(attrs[NL80211_TID_ATTR_CONFIG_RETRY_SHORT]);
+			if (tid_conf->retry_short >
+					rdev->wiphy.max_data_retry_count)
+				return -EINVAL;
+		} else {
+			tid_conf->retry_short = -1;
+		}
+
+		if (attrs[NL80211_TID_ATTR_CONFIG_RETRY_LONG]) {
+			tid_conf->retry_long =
+			nla_get_u8(attrs[NL80211_TID_ATTR_CONFIG_RETRY_LONG]);
+			if (tid_conf->retry_long >
+					rdev->wiphy.max_data_retry_count)
+				return -EINVAL;
+		} else {
+			tid_conf->retry_long = -1;
+		}
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

