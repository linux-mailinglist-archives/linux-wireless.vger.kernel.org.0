Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA83E89E2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 07:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhHKFqh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 01:46:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56117 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233776AbhHKFqg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 01:46:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628660773; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bZ8dYztixn6JeEegfUzvcJtqZyZLM9Na2ushwFl3Xxc=; b=Ajgs7AESW7RBIZ719gFMhu1YaBWcXm/9Rxc9t71RvDUCLPzUSlIXep5WTl9qraueO/XMlBp5
 jv/2jlGxOCf+XYOjQaElwcf/Gqj0u2B71L+jLU7Hqhql+347rAqhhnxdqXiWo7tQVAW/GpAY
 4A+qYKR0Nv8SIfK7oLIV0ChmAZM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61136411b3873958f545c95b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Aug 2021 05:45:53
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64D8BC43460; Wed, 11 Aug 2021 05:45:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19C78C433F1;
        Wed, 11 Aug 2021 05:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19C78C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH v2] cfg80211: Handle driver updated MU-EDCA params
Date:   Tue, 10 Aug 2021 22:45:43 -0700
Message-Id: <1628660743-24413-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add necessary functions and attributes to receive updated MU-EDCA
parameters from driver and send to user space, where management
frame are updated to reflect latest parameters.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 13 +++++++++++++
 net/wireless/nl80211.c       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 161cdf7df1a0..52770f108131 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8218,4 +8218,16 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
  */
 void cfg80211_bss_flush(struct wiphy *wiphy);
 
+/**
+ * cfg80211_update_muedca_params_event - Notify userspace about updated
+ *	MU-EDCA parameters
+ *
+ * @wiphy: the wiphy
+ * @params: Updated MU-EDCA parameters
+ * @gfp: allocation flags
+ */
+void cfg80211_update_muedca_params_event(struct wiphy *wiphy,
+					 struct ieee80211_mu_edca_param_set
+					 *params, gfp_t gfp);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index db474994fa73..c2d01881c324 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1185,6 +1185,11 @@
  *	passed using %NL80211_ATTR_SAR_SPEC. %NL80211_ATTR_WIPHY is used to
  *	specify the wiphy index to be applied to.
  *
+ * @NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS: Updated MU-EDCA parameters from
+ *	driver. This event is used to update dynamic MU-EDCA parameters in
+ *	management frames, coming from driver and now need to be reflected in
+ *	management frames.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1417,6 +1422,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_SAR_SPECS,
 
+	NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2560,6 +2567,10 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_HE_MUEDCA_PARAMS: MU-EDCA AC parameters for the
+ *	%NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS command in format described in
+ *	P802.11ax_D4.0 section 9.4.2.245
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3057,6 +3068,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_HE_MUEDCA_PARAMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 50eb405b0690..9abe66cef566 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18093,6 +18093,42 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_update_owe_info_event);
 
+void cfg80211_update_muedca_params_event(struct wiphy *wiphy,
+					 struct ieee80211_mu_edca_param_set
+					 *params, gfp_t gfp)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx))
+		goto nla_put_failure;
+
+	if (nla_put(msg, NL80211_ATTR_HE_MUEDCA_PARAMS,
+		    sizeof(struct ieee80211_mu_edca_param_set),
+		    (const void *)params))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, gfp);
+	return;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_update_muedca_params_event);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
-- 
2.7.4

