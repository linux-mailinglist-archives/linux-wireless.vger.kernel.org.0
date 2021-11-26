Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF145E879
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 08:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359194AbhKZHao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 02:30:44 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:62761 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236781AbhKZH2l (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 02:28:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637911529; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=QhRsi3cdzessXvBblV40ey6FzsC0RKeS9ATHt1Q3dM4=; b=dKsfy65O1K+mPWIJi+vwDDe3HP3Ut1EhpWol+bwkwRtRDwNgpBTH6ttTKc+GTO+xrwrh76S6
 NS1dccTBkIq7zoMkxodeCV+v0MOuFDTIWqghzTZQZAD4wDqhQHi5c7KHPIJvZ0Yq43Fo/Gku
 OTMVbDDjJwuNsYpft1AJR/ujJOU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61a08be81abc6f02d05741e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 07:25:28
 GMT
Sender: vjakkam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1790C43616; Fri, 26 Nov 2021 07:25:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-vjakkam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07228C4338F;
        Fri, 26 Nov 2021 07:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 07228C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] nl80211: Add support to set AP settings flags with single attribute
Date:   Fri, 26 Nov 2021 12:55:18 +0530
Message-Id: <1637911519-21306-1-git-send-email-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In previous method each AP settings flag is represented by a top-level
flag attribute and conversion to enum cfg80211_ap_settings_flags had to
be done before sending them to driver. This commit is to make it easier
to define new AP settings flags and sending them to driver.

This commit also deprecate sending of
%NL80211_ATTR_EXTERNAL_AUTH_SUPPORT in %NL80211_CMD_START_AP. But to
maintain backwards compatibility checks for
%NL80211_ATTR_EXTERNAL_AUTH_SUPPORT in %NL80211_CMD_START_AP when
%NL80211_ATTR_AP_SETTINGS_FLAGS not present in %NL80211_CMD_START_AP.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
 include/net/cfg80211.h       | 11 -----------
 include/uapi/linux/nl80211.h | 20 +++++++++++++++++++-
 net/wireless/nl80211.c       |  8 ++++++--
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 362da9f..5ccd9b4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1188,17 +1188,6 @@ struct cfg80211_unsol_bcast_probe_resp {
 };
 
 /**
- * enum cfg80211_ap_settings_flags - AP settings flags
- *
- * Used by cfg80211_ap_settings
- *
- * @AP_SETTINGS_EXTERNAL_AUTH_SUPPORT: AP supports external authentication
- */
-enum cfg80211_ap_settings_flags {
-	AP_SETTINGS_EXTERNAL_AUTH_SUPPORT = BIT(0),
-};
-
-/**
  * struct cfg80211_ap_settings - AP configuration
  *
  * Used to configure an AP interface.
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e73482..52ac549 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2470,7 +2470,9 @@ enum nl80211_commands {
  *	space supports external authentication. This attribute shall be used
  *	with %NL80211_CMD_CONNECT and %NL80211_CMD_START_AP request. The driver
  *	may offload authentication processing to user space if this capability
- *	is indicated in the respective requests from the user space.
+ *	is indicated in the respective requests from the user space. (This flag
+ *	attribute deprecated for %NL80211_CMD_START_AP, use
+ *	%NL80211_ATTR_AP_SETTINGS_FLAGS)
  *
  * @NL80211_ATTR_NSS: Station's New/updated  RX_NSS value notified using this
  *	u8 attribute. This is used with %NL80211_CMD_STA_OPMODE_CHANGED.
@@ -2646,6 +2648,10 @@ enum nl80211_commands {
  *	switching on a different channel during CAC detection on the selected
  *	radar channel.
  *
+ * @NL80211_ATTR_AP_SETTINGS_FLAGS: u32 attribute contains ap settings flags,
+ *	enumerated in &enum nl80211_ap_settings_flags. This attribute shall be
+ *	used with %NL80211_CMD_START_AP request.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3154,6 +3160,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_RADAR_OFFCHAN,
 
+	NL80211_ATTR_AP_SETTINGS_FLAGS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7475,4 +7483,14 @@ enum nl80211_mbssid_config_attributes {
 	NL80211_MBSSID_CONFIG_ATTR_MAX = __NL80211_MBSSID_CONFIG_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_ap_settings_flags - AP settings flags
+ *
+ * @NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT: AP supports external
+ *	authentication.
+ */
+enum nl80211_ap_settings_flags {
+	NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT	= 1 << 0,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 83a1ba9..744917b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -777,6 +777,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 			NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_RADAR_OFFCHAN] = { .type = NLA_FLAG },
+	[NL80211_ATTR_AP_SETTINGS_FLAGS] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -5712,8 +5713,11 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	nl80211_calculate_ap_params(params);
 
-	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-		params->flags |= AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
+	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
+		params->flags = nla_get_u32(
+			info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS]);
+	else if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
+		params->flags |= NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
 
 	wdev_lock(wdev);
 	err = rdev_start_ap(rdev, dev, params);
-- 
2.7.4

