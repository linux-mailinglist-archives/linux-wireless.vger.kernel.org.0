Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35715486DFE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 00:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiAFXn4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 18:43:56 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:31831 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343629AbiAFXnk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1641512620; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LDg2IuUpQHgd81Rt3y0bTVyxDjVuwqNi3C5sPLC5o3o=; b=foqCz47i2ZQ6LpVs6QfzOkx0e5iqMPeN+rdWdXPq7y+a2qYXmLbjMuOb5td2uNM7fmXcEsjj
 IBuNihnmXIwxg3TiErjgtJWCZWBiAga3jNH9ar5Q+MARiZnrwXxg5G243WPByOuwzt8Tq2Nf
 ALz3qDoKFFtJQmpAGK3KXCPHEqo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 61d77ea9b0cf5ba492d3acd3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 Jan 2022 23:43:37
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3500C43619; Thu,  6 Jan 2022 23:43:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53766C4338F;
        Thu,  6 Jan 2022 23:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 53766C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH v3] cfg80211: Handle driver updated MU-EDCA params
Date:   Thu,  6 Jan 2022 15:43:29 -0800
Message-Id: <1641512609-29774-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add necessary functions and attributes to receive updated MU-EDCA
parameters from driver and send to user space, where management
frame are updated to reflect latest parameters.

The updated parameters from driver are part of an AP mode feature
where firmware determines better MU-EDCA parameters based on channel
conditions. The updated parameters are used and reported to user space
to reflect in AP management frames. These dynamic parameter updates
are offloaded to firmware for better user experience, thus details on
algorithm are not provided. This is a driver specific feature, thus
no IEEE80211 spec references.

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
v3
 - modified commit message
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 13 +++++++++++++
 net/wireless/nl80211.c       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a887086cb103..7c8f0091bcb8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8422,4 +8422,16 @@ static inline int cfg80211_color_change_notify(struct net_device *dev)
 					 0, 0);
 }
 
+/**
+ * cfg80211_update_muedca_params_event - Notify userspace about updated
+ *	MU-EDCA parameters
+ *
+ * @wiphy: the wiphy
+ * @params: Updated MU-EDCA parameters
+ * @gfp: allocation flags
+ */
+void cfg80211_update_muedca_params_event(struct wiphy *wiphy,
+					 const struct ieee80211_mu_edca_param_set *params,
+					 gfp_t gfp);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e734826792f..5752ef962457 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1232,6 +1232,11 @@
  *	&NL80211_ATTR_FILS_NONCES - for FILS Nonces
  *		(STA Nonce 16 bytes followed by AP Nonce 16 bytes)
  *
+ * @NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS: Updated MU-EDCA parameters from
+ *	driver. This event is used to update dynamic MU-EDCA parameters in
+ *	management frames, coming from driver and now need to be reflected in
+ *	management frames.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1474,6 +1479,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_FILS_AAD,
 
+	NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2646,6 +2653,10 @@ enum nl80211_commands {
  *	switching on a different channel during CAC detection on the selected
  *	radar channel.
  *
+ * @NL80211_ATTR_HE_MUEDCA_PARAMS: MU-EDCA AC parameters for the
+ *	%NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS command in format described in
+ *	P802.11ax_D4.0 section 9.4.2.245
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3154,6 +3165,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_RADAR_OFFCHAN,
 
+	NL80211_ATTR_HE_MUEDCA_PARAMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bfa5d7428a3f..49c8249863e9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18512,6 +18512,42 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_update_owe_info_event);
 
+void
+cfg80211_update_muedca_params_event(struct wiphy *wiphy,
+				    const struct ieee80211_mu_edca_param_set *params,
+				    gfp_t gfp)
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
+		    sizeof(*params), params))
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

