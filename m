Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34249935
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFRGrP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 02:47:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50842 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRGrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7195A6090E; Tue, 18 Jun 2019 05:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835661;
        bh=hYZlPB8cfboWOiTPiKAqbZ4/qj71YHuEyKAr/DVSb+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYFIV0n6WDEERZzNKEpHiXsgemkTQR8M6ZP+BLHDf/l1pbOSosddPYK6PQSSbGho2
         uuK9yd7k/nai/5bVa6wOO9q9ecmmWy5S9RUzYIMs1SRAN8/4rXV1nrleqfvgQ8DZLv
         3Hgk88wF7Xx7ry9+q1GWIDD9igMWud8NHRmYhDig=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D07D6074C;
        Tue, 18 Jun 2019 05:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835660;
        bh=hYZlPB8cfboWOiTPiKAqbZ4/qj71YHuEyKAr/DVSb+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRbJpKzi0Dlyj/zfaBLXyvpNDcCy351R3WQoevorctU5+nIEB0gZ5laXVeu3pyNBk
         fMZ5NBLdgvjxZU0jd4bqSu/i/WRTtjDT3iju2rhFIy5ICI8ugnbMR9x3tkt/LRrVGp
         rJwv9o4DerGhhe18uKOYHZ5hngQ1M50VxZSoEzd0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D07D6074C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv6 3/9] nl80211: Add netlink attribute for AMPDU aggregation enable/disable
Date:   Tue, 18 Jun 2019 10:57:06 +0530
Message-Id: <1560835632-17405-4-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_TID_ATTR_CONFIG_AMPDU_CTRL in nl80211_attr_tid_config
to accept TID specific AMPDU aggregation enable/disable configuration
through NL80211_CMD_SET_TID_CONFIG command. TID for which the
aggregation control configuration is to be applied is passed in
NL80211_TID_ATTR_CONFIG_TID attribute. When the user-space wants this
configuration peer specific rather than being applied for all the
connected stations, MAC address of the peer can be passed in
NL80211_ATTR_MAC attribute.

Driver supporting this feature should advertise
NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL and supporting per-STA data TID
ampdu configuration should advertise NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |    3 +++
 include/uapi/linux/nl80211.h |   22 ++++++++++++++++++++++
 net/wireless/nl80211.c       |   25 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 91bcb07..d2814e8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -528,6 +528,7 @@ struct cfg80211_chan_def {
 enum ieee80211_tid_conf_mask {
 	IEEE80211_TID_CONF_NOACK	= BIT(0),
 	IEEE80211_TID_CONF_RETRY	= BIT(1),
+	IEEE80211_TID_CONF_AMPDU	= BIT(2),
 };
 
 /**
@@ -538,6 +539,7 @@ enum ieee80211_tid_conf_mask {
  * @noack: noack configuration value for the TID
  * @retry_long: retry count value
  * @retry_short: retry count value
+ * @ampdu: Enable/Disable aggregation
  */
 struct ieee80211_tid_cfg {
 	u8 tid;
@@ -545,6 +547,7 @@ struct ieee80211_tid_cfg {
 	u8 noack;
 	int retry_long;
 	int retry_short;
+	u8 ampdu;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d30d7c9..465dbc6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4712,6 +4712,21 @@ enum nl80211_tid_config {
  *	the max value should be advertised by the driver through
  *	max_data_retry_count. when this attribute is not present, the driver
  *	would use the default configuration.
+ * @NL80211_TID_ATTR_CONFIG_AMPDU_CTRL: Enable/Disable aggregation for the TID
+ *	specified in %%NL80211_TID_ATTR_CONFIG_TID. Its type is u8,
+ *	if the peer MAC address	is passed in %NL80211_ATTR_MAC, the aggregation
+ *	configuration is applied
+ *	to the data frame for the tid to that connected station.
+ *	Station specific aggregation configuration is valid only for STA's
+ *	current connection. i.e. the configuration will be reset to default when
+ *	the station connects back after disconnection/roaming.
+ *	when user-space does not include %NL80211_ATTR_MAC, this configuration
+ *	should be treated as per-netdev configuration. This configuration will
+ *	be cleared when the interface goes down and on the disconnection from a
+ *	BSS. Driver supporting this feature should advertise
+ *	NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL and supporting per station
+ *	aggregation configuration should advertise
+ *	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL.
  */
 enum nl80211_tid_attr_config {
 	__NL80211_TID_ATTR_INVALID,
@@ -4720,6 +4735,7 @@ enum nl80211_tid_attr_config {
 	NL80211_TID_ATTR_CONFIG_RETRY,
 	NL80211_TID_ATTR_CONFIG_RETRY_SHORT,
 	NL80211_TID_ATTR_CONFIG_RETRY_LONG,
+	NL80211_TID_ATTR_CONFIG_AMPDU_CTRL,
 
 	/* keep last */
 	__NL80211_TID_ATTR_CONFIG_AFTER_LAST,
@@ -5545,6 +5561,10 @@ enum nl80211_feature_flags {
  *	count functionality.
  * @NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG: Driver supports STA specific
  *	data retry count functionality.
+ * @NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL: Driver supports TID specific
+ *	aggregation control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL: Driver supports per STA
+ *	specific TID aggregation control(enable/disable).
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5595,6 +5615,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG,
 	NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL,
+	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a21a4f4..a8982de 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -289,6 +289,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_TID_ATTR_CONFIG_RETRY] = { .type = NLA_FLAG },
 	[NL80211_TID_ATTR_CONFIG_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 0),
 	[NL80211_TID_ATTR_CONFIG_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 0),
+	[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -13661,6 +13663,29 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		}
 	}
 
+	if (attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL)) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
+					    "TID specific configuration not "
+					    "supported");
+			return -ENOTSUPP;
+		}
+
+		if (peer && !wiphy_ext_feature_isset(&rdev->wiphy,
+				NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL)) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
+					    "peer specfic TID configuration not "
+					    "supported");
+			return -ENOTSUPP;
+		}
+
+		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_AMPDU;
+		tid_conf->ampdu =
+			nla_get_u8(attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL]);
+	}
 	return 0;
 }
 
-- 
1.7.9.5

