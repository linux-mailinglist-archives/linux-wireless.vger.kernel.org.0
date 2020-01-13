Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162EC1391D9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 14:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAMNL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 08:11:58 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:55873 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbgAMNL6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 08:11:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578921117; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=x3aF706hfsGSdI8HJfzIAiqHizZ03zQjWDj6r7mlftE=; b=v/hHF3wWWSOq7B7yMRpjf/MkBtB/GG4wFUIt/x9nVPwM5ljDHF8rRt3iVq41XMUCwSk/imib
 PojSvhl2CkILkcWJxPWnyJ8Lidj4fVcdBOUMYLUZhueRSHDmJYXc9Rm8ORk4XBoP46ou0K0w
 GltlIX38/TMkUGUv9DkEsbPG4Gg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c6c9a.7fba6da05298-smtp-out-n03;
 Mon, 13 Jan 2020 13:11:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFD63C447A5; Mon, 13 Jan 2020 13:11:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43C39C447A4;
        Mon, 13 Jan 2020 13:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43C39C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv9 3/6] nl80211: Add support to configure TID specific AMPDU configuration
Date:   Mon, 13 Jan 2020 18:41:27 +0530
Message-Id: <1578921090-9758-4-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
References: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

This patch adds support to configure per TID AMPDU control
configuration to enable/disable aggregation through the
NL80211_TID_CONFIG_ATTR_AMPDU_CTRL attribute.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |    4 ++++
 include/uapi/linux/nl80211.h |    9 +++++++++
 net/wireless/nl80211.c       |   13 +++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c2dec5e..ccb9505 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -604,6 +604,8 @@ enum ieee80211_tid_conf_mask {
 				BIT(NL80211_TID_CONFIG_ATTR_RETRY_SHORT),
 	IEEE80211_TID_CONF_RETRY_LONG	=
 				BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG),
+	IEEE80211_TID_CONF_AMPDU	=
+				BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL),
 };
 
 /**
@@ -616,6 +618,7 @@ enum ieee80211_tid_conf_mask {
  * @noack: noack configuration value for the TID
  * @retry_long: retry count value
  * @retry_short: retry count value
+ * @ampdu: Enable/Disable aggregation
  */
 struct ieee80211_tid_cfg {
 	bool config_override;
@@ -624,6 +627,7 @@ struct ieee80211_tid_cfg {
 	enum nl80211_tid_config noack;
 	int retry_long;
 	int retry_short;
+	u8 ampdu;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cdd259b..b28c51c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4767,6 +4767,8 @@ enum nl80211_tid_config {
  *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
  *	the max value should be advertised by the driver through
  *	max_data_retry_count.
+ * @NL80211_TID_CONFIG_ATTR_AMPDU_CTRL: Enable/Disable aggregation for the TID
+ *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. Its type is u8,
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4775,6 +4777,7 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_NOACK,
 	NL80211_TID_CONFIG_ATTR_RETRY_SHORT,
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
+	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5607,6 +5610,10 @@ enum nl80211_feature_flags {
  *	retry_long count functionality.
  * @NL80211_EXT_FEATURE_PER_STA_RETRY_LONG_CONFIG: Driver supports STA specific
  *	data retry_long count functionality.
+ * @NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL_CONFIG: Driver supports TID specific
+ *	aggregation control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL_CONFIG: Driver supports per STA
+ *	specific TID aggregation control(enable/disable).
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5660,6 +5667,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PER_STA_RETRY_SHORT_CONFIG,
 	NL80211_EXT_FEATURE_PER_TID_RETRY_LONG_CONFIG,
 	NL80211_EXT_FEATURE_PER_STA_RETRY_LONG_CONFIG,
+	NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL_CONFIG,
+	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL_CONFIG,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bb26e3d..b60669f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -329,6 +329,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 	[NL80211_TID_CONFIG_ATTR_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 1),
 	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 1),
+	[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -13910,6 +13912,17 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 	}
 
+	if (attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+						       attrs, tid_conf,
+						       AMPDU_CTRL);
+		if (err)
+			return err;
+
+		tid_conf->ampdu =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]);
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5
