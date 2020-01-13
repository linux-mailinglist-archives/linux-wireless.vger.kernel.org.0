Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88C1391DC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAMNMA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 08:12:00 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43230 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728650AbgAMNL7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 08:11:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578921118; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=gqkD+3asom3GmeKEsLjlvKXdDEp0YmSj1+qVNskHImQ=; b=wKRltW7V5bASOcUIkcUMhXbqLs2HAWnFsxId5CmaGobg3CsSJxP8W/Hiy/Qn7XVZyZPJH/CP
 /DV6y3/A3wf3MS+BA1uN7K8ikURMyw/vAd2SZLgIE7UssreL2/4Q8q4ps8P0+TY5VhEGoQZr
 RHxw5S9MJRL3s8ghPvoGOFfGZOo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c6c9c.7f06ad9c54c8-smtp-out-n03;
 Mon, 13 Jan 2020 13:11:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F28FCC447A3; Mon, 13 Jan 2020 13:11:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F5FAC4479C;
        Mon, 13 Jan 2020 13:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F5FAC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv9 4/6] nl80211: Add support to configure TID specific RTSCTS configuration
Date:   Mon, 13 Jan 2020 18:41:28 +0530
Message-Id: <1578921090-9758-5-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
References: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

This patch adds support to configure per TID RTSCTS control
configuration to enable/disable through the
NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL attribute.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |    4 ++++
 include/uapi/linux/nl80211.h |    9 +++++++++
 net/wireless/nl80211.c       |   13 +++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ccb9505..62085a6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -606,6 +606,8 @@ enum ieee80211_tid_conf_mask {
 				BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG),
 	IEEE80211_TID_CONF_AMPDU	=
 				BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL),
+	IEEE80211_TID_CONF_RTSCTS	=
+				BIT(NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL),
 };
 
 /**
@@ -619,6 +621,7 @@ enum ieee80211_tid_conf_mask {
  * @retry_long: retry count value
  * @retry_short: retry count value
  * @ampdu: Enable/Disable aggregation
+ * @rtscts: Enable/Disable RTS/CTS
  */
 struct ieee80211_tid_cfg {
 	bool config_override;
@@ -628,6 +631,7 @@ struct ieee80211_tid_cfg {
 	int retry_long;
 	int retry_short;
 	u8 ampdu;
+	u8 rtscts;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b28c51c..c4ac7d7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4769,6 +4769,8 @@ enum nl80211_tid_config {
  *	max_data_retry_count.
  * @NL80211_TID_CONFIG_ATTR_AMPDU_CTRL: Enable/Disable aggregation for the TID
  *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. Its type is u8,
+ * @NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL: Enable/Disable RTS_CTS for the TID
+ *	specified in %%NL80211_TID_CONFIG_ATTR_TIDS. It is u8 type.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4778,6 +4780,7 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY_SHORT,
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
+	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5614,6 +5617,10 @@ enum nl80211_feature_flags {
  *	aggregation control(enable/disable).
  * @NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL_CONFIG: Driver supports per STA
  *	specific TID aggregation control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL_CONFIG: Driver supports TID specific
+ *	RTS_CTS control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL_CONFIG: Driver supports STA specific
+ *	RTS_CTS control(enable/disable).
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5669,6 +5676,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PER_STA_RETRY_LONG_CONFIG,
 	NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b60669f..8388dbf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -331,6 +331,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 1),
 	[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -13923,6 +13925,17 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]);
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+						       attrs, tid_conf,
+						       RTSCTS_CTRL);
+		if (err)
+			return err;
+
+		tid_conf->rtscts =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5
