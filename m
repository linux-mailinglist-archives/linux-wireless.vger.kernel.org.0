Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E61EFD66
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 13:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfKEMmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 07:42:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbfKEMmB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 07:42:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01B7761496; Tue,  5 Nov 2019 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957720;
        bh=K89Xyn91bB7ybsklN+PqW4i7qZ8u2rcPRiQCw1m3hsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeEtG0acAONjMFYvdISKFy9GU+oy+fyu1sZVhwPdMtlC3MY/Rvvxg7dnHpOOGGDjb
         dKL4dIeuH1Wy38NLqZE6I7Gwin8uiqptBO1k2RSpbeJYYfs19uD+eE/rHc+ULre+t0
         1L/HaKPfnyklBlH65A5YxZrpw0/H7arNI5ZAnDPY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17AF66148C;
        Tue,  5 Nov 2019 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957719;
        bh=K89Xyn91bB7ybsklN+PqW4i7qZ8u2rcPRiQCw1m3hsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REpcznbC9NzcK6YYpQ4J9cHHKgb7A0Jza4w0gw4v2hZWFFWfYQA05WoVp0mfvIeiB
         mPXH5H6z6exq25q7NTHcYauvej84P+S0M88LnlcwI+2fmyB2n//qRfsmmLa/UfZEEv
         D2AMk0uW8i2j0REkQ5QxAeNdSVCjceUtAx81EekE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17AF66148C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv8 4/6] nl80211: Add netlink attribute to enable/disable RTS_CTS
Date:   Tue,  5 Nov 2019 18:11:52 +0530
Message-Id: <1572957714-16085-5-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL in nl80211_attr_tid_config
to accept TID specific RTS_CTS enable/disable configuration
through NL80211_CMD_SET_TID_CONFIG command. TID for which the
RTS_CTS control configuration is to be applied is passed in
NL80211_TID_CONFIG_ATTR_TID attribute. When the user-space wants this
configuration peer specific rather than being applied for all the
connected stations, MAC address of the peer can be passed in
NL80211_ATTR_MAC attribute.

Driver supporting this feature should advertise
NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL and supporting per-STA data TID
RTS_CTS configuration should advertise NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/cfg80211.h       |    3 +++
 include/uapi/linux/nl80211.h |   22 ++++++++++++++++++++++
 net/wireless/nl80211.c       |   16 ++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index baed260..deeb1c1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -600,6 +600,7 @@ enum ieee80211_tid_conf_mask {
 	IEEE80211_TID_CONF_NOACK	= BIT(0),
 	IEEE80211_TID_CONF_RETRY	= BIT(1),
 	IEEE80211_TID_CONF_AMPDU	= BIT(2),
+	IEEE80211_TID_CONF_RTSCTS	= BIT(3),
 };
 
 /**
@@ -611,6 +612,7 @@ enum ieee80211_tid_conf_mask {
  * @retry_long: retry count value
  * @retry_short: retry count value
  * @ampdu: Enable/Disable aggregation
+ * @rtscts: Enable/Disable RTS/CTS
  */
 struct ieee80211_tid_cfg {
 	u8 tid;
@@ -619,6 +621,7 @@ struct ieee80211_tid_cfg {
 	int retry_long;
 	int retry_short;
 	u8 ampdu;
+	u8 rtscts;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 32ca476..f75f243 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4776,6 +4776,21 @@ enum nl80211_tid_config {
  *	NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL and supporting per station
  *	aggregation configuration should advertise
  *	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL.
+ * @NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL: Enable/Disable RTS_CTS for the TID
+ *	specified in %%NL80211_TID_CONFIG_ATTR_TID. It is u8 type, if the
+ *	peer MAC address is passed in %NL80211_ATTR_MAC, then this
+ *	configuration is applied to the data frame for the tid to that
+ *	connected station.
+ *	Station specific RTS_CTS configuration is valid only for STA's
+ *	current connection. i.e. the configuration will be reset to default when
+ *	the station connects back after disconnection/roaming.
+ *	when user-space does not include %NL80211_ATTR_MAC, this configuration
+ *	should be treated as per-netdev configuration. This configuration will
+ *	be cleared when the interface goes down and on the disconnection from a
+ *	BSS. Driver supporting this feature should advertise
+ *	NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL and supporting per station
+ *	RTS_CTS configuration should advertise
+ *	NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4785,6 +4800,7 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_RETRY_SHORT,
 	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
+	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5614,6 +5630,10 @@ enum nl80211_feature_flags {
  *	aggregation control(enable/disable).
  * @NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL: Driver supports per STA
  *	specific TID aggregation control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL: Driver supports TID specific
+ *	RTS_CTS control(enable/disable).
+ * @NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL: Driver supports STA specific
+ *	RTS_CTS control(enable/disable).
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5666,6 +5686,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG,
 	NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL,
 	NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL,
+	NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL,
+	NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5ac8862..abce915 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -331,6 +331,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = { .type = NLA_U8},
 	[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL] =
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
+	[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL] =
+			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 };
 
 const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
@@ -13898,6 +13900,20 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		tid_conf->ampdu =
 			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]);
 	}
+
+	if (attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]) {
+		err = nl80211_check_tid_config_support(rdev, extack, peer,
+				attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL],
+				NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL,
+				NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL);
+		if (err)
+			return err;
+
+		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_RTSCTS;
+		tid_conf->rtscts =
+			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

