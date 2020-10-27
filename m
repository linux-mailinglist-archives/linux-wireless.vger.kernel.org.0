Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6899D29A944
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 11:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897551AbgJ0KMk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 06:12:40 -0400
Received: from z5.mailgun.us ([104.130.96.5]:51691 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897548AbgJ0KMj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 06:12:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603793558; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=v1NFjEJl7yYpVZoMJ1GgNlhxXOfxnhdd0meqZsJm4/c=; b=cyNy8G0SjdNNF1r8Aon/xSPdowyrc6nId0ihiZgxYbipUWv/2nzsNsrAEWZvPT1wqiwwWC3A
 TNQO/gkRyoNu1Xxwq6q7dHb7rbY1LLdTaeSztEfEd+Kzn9+6S1XK3w0qk7mMiNHPssmJ3E0f
 AgnvzpYeDcbbEpxChvTGqdrbEug=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f97f28efcd46a2b7600ee85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 10:12:30
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67A3BC43382; Tue, 27 Oct 2020 10:12:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-116-182-nat.elisa-mobile.fi [85.76.116.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F4C9C43387;
        Tue, 27 Oct 2020 10:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F4C9C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Rohan Dutta <drohan@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] cfg80211: Add support to configure SAE PWE value to drivers
Date:   Tue, 27 Oct 2020 12:09:10 +0200
Message-Id: <20201027100910.22283-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rohan Dutta <drohan@codeaurora.org>

Add support to configure SAE PWE preference from userspace to drivers in
both AP and STA modes. This is needed for cases where the driver takes
care of Authentication frame processing (SME in the driver) so that
correct enforcement of the acceptable PWE derivation mechanism can be
performed.

The userspace applications can pass the sae_pwe value using the
NL80211_ATTR_SAE_PWE attribute in the NL80211_CMD_CONNECT and
NL80211_CMD_START_AP commands to the driver. This allows selection
between the hunting-and-pecking loop and hash-to-element options for PWE
derivation. For backwards compatibility, this new attribute is optional
and if not included, the driver is notified of the value being
unspecified.

Signed-off-by: Rohan Dutta <drohan@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/cfg80211.h       |  9 +++++++++
 include/uapi/linux/nl80211.h | 26 ++++++++++++++++++++++++++
 net/wireless/nl80211.c       |  9 +++++++++
 3 files changed, 44 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 661edfc8722e..0ba8d1fa6eb9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1008,6 +1008,14 @@ struct survey_info {
  * @sae_pwd: password for SAE authentication (for devices supporting SAE
  *	offload)
  * @sae_pwd_len: length of SAE password (for devices supporting SAE offload)
+ * @sae_pwe: The mechanisms allowed for SAE PWE derivation
+ *	NL80211_SAE_PWE_UNSPECIFIED: Not-specified, used to indicate userspace
+ *		did not specify any preference. The driver should follow its
+ *		internal policy in such a scenario.
+ *	NL80211_SAE_PWE_HUNT_AND_PECK: Allow hunting-and-pecking loop only
+ *	NL80211_SAE_PWE_HASH_TO_ELEMENT: Allow hash-to-element only
+ *	NL80211_SAE_PWE_BOTH: Allow either hunting-and-pecking loop
+ *		or hash-to-element
  */
 struct cfg80211_crypto_settings {
 	u32 wpa_versions;
@@ -1026,6 +1034,7 @@ struct cfg80211_crypto_settings {
 	const u8 *psk;
 	const u8 *sae_pwd;
 	u8 sae_pwd_len;
+	enum nl80211_sae_pwe_mechanism sae_pwe;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 47700a2b9af9..2d733effcdaf 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2527,6 +2527,11 @@ enum nl80211_commands {
  *	override mask. Used with NL80211_ATTR_S1G_CAPABILITY in
  *	NL80211_CMD_ASSOCIATE or NL80211_CMD_CONNECT.
  *
+ * @NL80211_ATTR_SAE_PWE: Indicates the mechanism(s) allowed for SAE PWE
+ *	derivation in WPA3-Personal networks which are using SAE authentication.
+ *	This is a u8 attribute that encapsulates one of the values from
+ *	&enum nl80211_sae_pwe_mechanism.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3016,6 +3021,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_CAPABILITY,
 	NL80211_ATTR_S1G_CAPABILITY_MASK,
 
+	NL80211_ATTR_SAE_PWE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7124,4 +7131,23 @@ enum nl80211_unsol_bcast_probe_resp_attributes {
 	NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX =
 		__NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_LAST - 1
 };
+
+/**
+ * enum nl80211_sae_pwe_mechanism - The mechanism(s) allowed for SAE PWE
+ *	derivation. Applicable only when WPA3-Personal SAE authentication is
+ *	used.
+ *
+ * @NL80211_SAE_PWE_UNSPECIFIED: not specified, used internally to indicate that
+ *	attribute is not present from userspace.
+ * @NL80211_SAE_PWE_HUNT_AND_PECK: hunting-and-pecking loop only
+ * @NL80211_SAE_PWE_HASH_TO_ELEMENT: hash-to-element only
+ * @NL80211_SAE_PWE_BOTH: both hunting-and-pecking loop and hash-to-element
+ *	can be used.
+ */
+enum nl80211_sae_pwe_mechanism {
+	NL80211_SAE_PWE_UNSPECIFIED,
+	NL80211_SAE_PWE_HUNT_AND_PECK,
+	NL80211_SAE_PWE_HASH_TO_ELEMENT,
+	NL80211_SAE_PWE_BOTH,
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 554796a6c6fe..0928ecbe5bd6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -715,6 +715,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
 	[NL80211_ATTR_S1G_CAPABILITY_MASK] =
 		NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
+	[NL80211_ATTR_SAE_PWE] =
+		NLA_POLICY_RANGE(NLA_U8, NL80211_SAE_PWE_HUNT_AND_PECK,
+				 NL80211_SAE_PWE_BOTH),
 };
 
 /* policy for the key attributes */
@@ -9731,6 +9734,12 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 			nla_len(info->attrs[NL80211_ATTR_SAE_PASSWORD]);
 	}
 
+	if (info->attrs[NL80211_ATTR_SAE_PWE])
+		settings->sae_pwe =
+			nla_get_u8(info->attrs[NL80211_ATTR_SAE_PWE]);
+	else
+		settings->sae_pwe = NL80211_SAE_PWE_UNSPECIFIED;
+
 	return 0;
 }
 
-- 
2.20.1

