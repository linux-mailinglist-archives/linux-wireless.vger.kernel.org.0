Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180BB2D368D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgLHWzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 17:55:13 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:16831 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbgLHWzM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 17:55:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607468089; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=M4C8Hv3trDh1UuYvfdljSvHf3EmvTxzIJ9NvbIQLttQ=; b=Pe8uiZKhyvC08oTmbX3jFfFrcepp866RCCVwAZ9f+L2SgVsnC22KLyYeLH2dV4LzWxA+q7YL
 VVvwEoyveKczRV0UxtS6dvzjP8mkrbjq966QQTgJQ46czcMj/vQmduCezqxp9Ff33aEXGH78
 ENmh5pkFQwey8YaPWdJEfUHHVPI=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fd0041c2265ffd861ae1682 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 22:54:20
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B4D4C433CA; Tue,  8 Dec 2020 22:54:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DEB2C433ED;
        Tue,  8 Dec 2020 22:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DEB2C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH 1/2] cfg80211: Handling driver updated MU-EDCA params
Date:   Tue,  8 Dec 2020 14:54:03 -0800
Message-Id: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Added necessary functions and attributes to be able to pass driver
updated MU-EDCA parameters from mac80211 to user space.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 10 ++++++++++
 net/wireless/nl80211.c       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ab249ca5d5d1..83e6101ad681 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8038,4 +8038,16 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
  */
 void cfg80211_bss_flush(struct wiphy *wiphy);
 
+/**
+ * cfg80211_update_muedca_params_event - Notify the updated MU-EDCA parameters
+ *	to user space.
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
index 3e0d4a038ab6..0cd2e33f3df8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1178,6 +1178,11 @@
  *	includes the contents of the frame. %NL80211_ATTR_ACK flag is included
  *	if the recipient acknowledged the frame.
  *
+ * @NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS: Updated MU-EDCA parameters from
+ *	driver. This event is used to update dynamic MU-EDCA parameters in
+ *	Beacon frame, coming from driver and now need to be reflected in
+ *	Beacon frame.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1408,6 +1413,7 @@ enum nl80211_commands {
 
 	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
 
+	NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS,
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2534,6 +2540,9 @@ enum nl80211_commands {
  *	This is a u8 attribute that encapsulates one of the values from
  *	&enum nl80211_sae_pwe_mechanism.
  *
+ * @NL80211_ATTR_HE_MUEDCA_PARAMS: MU-EDCA AC parameters for the
+ *	%NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS command.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3025,6 +3034,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SAE_PWE,
 
+	NL80211_ATTR_HE_MUEDCA_PARAMS,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8811a4b69f21..75493758ec8e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17806,6 +17806,42 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
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

