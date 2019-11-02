Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD93ECD8A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2019 07:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfKBGIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Nov 2019 02:08:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBGIE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Nov 2019 02:08:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C95861466; Sat,  2 Nov 2019 06:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572674883;
        bh=jlIRQ9hir4B18PN3RBDhSnqAzxvoeZdOPhx7RmYjjMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQaZfs4bnz5Kf9DUuScWhvYNoHwcRiZv7bHSdRD2PbsxeDxnjJlvHXzhkLNh7vrEE
         TV0/YEzgLZu9ac+03xUI1RCSWmtKDvmJEwy+FQoUh9j5WB0gzMMQkwCAgxvYgA3qys
         ZojRZwgctDGbO96WxznUKAFHG/DEPSnRp8+vyNRM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13B2161459;
        Sat,  2 Nov 2019 06:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572674882;
        bh=jlIRQ9hir4B18PN3RBDhSnqAzxvoeZdOPhx7RmYjjMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/2xHUW+NIDekfcu8T1h3t32Nu4k5CEeyno9o5jWDpioCkOS8EHHXn7gy3VjK0QcP
         2thGuquZko+5NrXzlO6TNO858CflMX/xYKM8LLHTL5oeMljBx8XfvtjhLSwez9dA6Z
         6/Ik9GEFRBvO1OmvOs33q6hEbe6V+/8rJvWI4wik=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13B2161459
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv7 3/6] nl80211: Add netlink attribute for AMPDU aggregation enable/disable
Date:   Sat,  2 Nov 2019 11:37:47 +0530
Message-Id: <1572674870-23517-4-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572674870-23517-1-git-send-email-tamizhr@codeaurora.org>
References: <1572674870-23517-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_TID_CONFIG_ATTR_AMPDU_CTRL in nl80211_attr_tid_config
to accept TID specific AMPDU aggregation enable/disable configuration
through NL80211_CMD_SET_TID_CONFIG command. TID for which the
aggregation control configuration is to be applied is passed in
NL80211_TID_CONFIG_ATTR_TID attribute. When the user-space wants this
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
 net/wireless/nl80211.c       |   14 ++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index dd40774..baed260 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -599,6 +599,7 @@ struct cfg80211_chan_def {
 enum ieee80211_tid_conf_mask {
 	IEEE80211_TID_CONF_NOACK	= BIT(0),
 	IEEE80211_TID_CONF_RETRY	= BIT(1),
+	IEEE80211_TID_CONF_AMPDU	= BIT(2),
 };
 
 /**
@@ -609,6 +610,7 @@ enum ieee80211_tid_conf_mask {
  * @noack: noack configuration value for the TID
  * @retry_long: retry count value
  * @retry_short: retry count value
+ * @ampdu: Enable/Disable aggregation
  */
 struct ieee80211_tid_cfg {
 	u8 tid;
@@ -616,6 +618,7 @@ struct ieee80211_tid_cfg {
 	u8 noack;
 	int retry_long;
 	int retry_short;
+	u8 ampdu;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 69b3229..32ca476 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4761,6 +4761,21 @@ enum nl80211_tid_config {
  *	the max value should be advertised by the driver through
  *	max_data_retry_count. when this attribute is not present, the driver
  *	would use the default configuration.
+ * @NL80211_TID_CONFIG_ATTR_AMPDU_CTRL: Enable/Disable aggregation for the TID
+ *	specified in %%NL80211_TID_CONFIG_ATTR_TID. Its type is u8,
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
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4769,6 +4784,7 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY,
 	NL80211_TID_CONFIG_ATTR_RETRY_SHORT,
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
+	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5594,6 +5610,10 @@ enum nl80211_feature_flags {
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
@@ -5644,6 +5664,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG,
 	NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL,
+	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7facc93..5ac8862 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -329,6 +329,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_TID_CONFIG_ATTR_RETRY] = { .type = NLA_FLAG },
 	[NL80211_TID_CONFIG_ATTR_RETRY_SHORT] = { .type = NLA_U8},
 	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = { .type = NLA_U8},
+	[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -13884,6 +13886,18 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		}
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+				attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL],
+				NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL,
+				NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL);
+		if (err)
+			return err;
+
+		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_AMPDU;
+		tid_conf->ampdu =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]);
+	}
 	return 0;
 }
 
-- 
1.7.9.5

