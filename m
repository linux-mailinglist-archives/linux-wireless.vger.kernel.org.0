Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201A014247B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 08:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgATHvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 02:51:49 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:56137 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgATHvs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 02:51:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579506707; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cTuiiku28lJ1d53Ng1+e0vllcpPAyt/OLBQGBzYsikw=; b=fq/HlC4TT2hvAAoRFiE+/mZ6bUwr6SrC81dJW5oOpq72Rr0mEa3+dvL2SKgzye85XNkPWLZf
 ZxPMbR99n2lgFPjk/jYULdwI+Df3jyc/JcVICt2BpoBXGw37YtG5II4qvM9zkZT4cYrhEciS
 L8kvJY9EnA0v5/d0x2wvxJOkh5Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e255c10.7f081f4403b0-smtp-out-n02;
 Mon, 20 Jan 2020 07:51:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3C37C4479F; Mon, 20 Jan 2020 07:51:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE1DBC433CB;
        Mon, 20 Jan 2020 07:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE1DBC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv10 2/6] nl80211: Add support to configure TID specific retry configuration
Date:   Mon, 20 Jan 2020 13:21:23 +0530
Message-Id: <1579506687-18296-3-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
References: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

This patch adds support to configure per TID retry configuration
through the NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes. This TID specific
retry configuration will have more precedence than phy level
configuration.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |   12 ++++++++++++
 include/uapi/linux/nl80211.h |   27 +++++++++++++++++++++++++++
 net/wireless/nl80211.c       |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9b1415d..1c3d78a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -626,6 +626,10 @@ struct cfg80211_chan_def {
 
 enum ieee80211_tid_conf_mask {
 	IEEE80211_TID_CONF_NOACK	= BIT(NL80211_TID_CONFIG_ATTR_NOACK),
+	IEEE80211_TID_CONF_RETRY_SHORT	=
+				BIT(NL80211_TID_CONFIG_ATTR_RETRY_SHORT),
+	IEEE80211_TID_CONF_RETRY_LONG	=
+				BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG),
 };
 
 /**
@@ -636,12 +640,16 @@ enum ieee80211_tid_conf_mask {
  * @tid_conf_mask: bitmap indicating which parameter changed
  *	see &enum ieee80211_tid_conf_mask
  * @noack: noack configuration value for the TID
+ * @retry_long: retry count value
+ * @retry_short: retry count value
  */
 struct ieee80211_tid_cfg {
 	bool config_override;
 	u8 tid;
 	u32 tid_conf_mask;
 	enum nl80211_tid_config noack;
+	int retry_long;
+	int retry_short;
 };
 
 /**
@@ -4611,6 +4619,8 @@ struct cfg80211_pmsr_capabilities {
  *	@support_mbssid must be set for this to have any effect.
  *
  * @pmsr_capa: peer measurement capabilities
+ * @max_data_retry_count: Maximum limit can be configured as retry count
+ *	for a TID.
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
@@ -4755,6 +4765,8 @@ struct wiphy {
 
 	const struct cfg80211_pmsr_capabilities *pmsr_capa;
 
+	u8 max_data_retry_count;
+
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b8d4721..e7cdca5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2430,6 +2430,8 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
  *	nested attribute with &enum nl80211_tid_config_attr sub-attributes.
+ * @NL80211_ATTR_MAX_RETRY_COUNT: The upper limit for the retry count
+ *	configuration that the driver can accept.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -2898,6 +2900,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_HE_BSS_COLOR,
 
 	NL80211_ATTR_TID_CONFIG,
+	NL80211_ATTR_MAX_RETRY_COUNT,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -4759,12 +4762,24 @@ enum nl80211_tid_config {
  * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
  *	specified in %NL80211_TID_CONFIG_ATTR_TID. see %enum nl80211_tid_config.
  *	Its type is u8.
+ * @NL80211_TID_CONFIG_ATTR_RETRY_SHORT: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. It is u8 type, min value is 1 and
+ *	the max value should be advertised by the driver through
+ *	max_data_retry_count.
+ * @NL80211_TID_CONFIG_ATTR_RETRY_LONG: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
+ *	the max value should be advertised by the driver through
+ *	max_data_retry_count.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
 	NL80211_TID_CONFIG_ATTR_OVERRIDE,
 	NL80211_TID_CONFIG_ATTR_TIDS,
 	NL80211_TID_CONFIG_ATTR_NOACK,
+	NL80211_TID_CONFIG_ATTR_RETRY_SHORT,
+	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5593,6 +5608,14 @@ enum nl80211_feature_flags {
  *	policy functionality.
  * @NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG: Driver supports STA specific NoAck
  *	policy functionality.
+ * @NL80211_EXT_FEATURE_PER_TID_RETRY_SHORT_CONFIG: Driver supports per TID data
+ *	retry_short count functionality.
+ * @NL80211_EXT_FEATURE_PER_STA_RETRY_SHORT_CONFIG: Driver supports STA specific
+ *	data retry_long count functionality.
+ * @NL80211_EXT_FEATURE_PER_TID_RETRY_LONG_CONFIG: Driver supports per TID data
+ *	retry_long count functionality.
+ * @NL80211_EXT_FEATURE_PER_STA_RETRY_LONG_CONFIG: Driver supports STA specific
+ *	data retry_long count functionality.
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5643,6 +5666,10 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_AQL,
 	NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_RETRY_SHORT_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_RETRY_SHORT_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_RETRY_LONG_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_RETRY_LONG_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ed1a0f3..dcc4514a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -334,6 +334,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_TID_CONFIG_ATTR_TIDS] = { .type = NLA_U8 },
 	[NL80211_TID_CONFIG_ATTR_NOACK] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 1),
+	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 1),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -2461,6 +2463,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			    rdev->wiphy.akm_suites))
 			goto nla_put_failure;
 
+		if (rdev->wiphy.max_data_retry_count) {
+			if (nla_put_u8(msg, NL80211_ATTR_MAX_RETRY_COUNT,
+				       rdev->wiphy.max_data_retry_count))
+				goto nla_put_failure;
+		}
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -13920,6 +13928,34 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_NOACK]);
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_RETRY_SHORT]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+						       attrs, tid_conf,
+						       RETRY_SHORT);
+		if (err)
+			return err;
+
+		tid_conf->retry_short =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RETRY_SHORT]);
+
+		if (tid_conf->retry_short > rdev->wiphy.max_data_retry_count)
+			return -EINVAL;
+	}
+
+	if (attrs[NL80211_TID_CONFIG_ATTR_RETRY_LONG]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+						       attrs, tid_conf,
+						       RETRY_LONG);
+		if (err)
+			return err;
+
+		tid_conf->retry_long =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RETRY_LONG]);
+
+		if (tid_conf->retry_long > rdev->wiphy.max_data_retry_count)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5
