Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCA183DAB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCMAAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 20:00:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33027 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgCMAAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 20:00:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584057615; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=TR+RffbEXunkl0g/CHTkw+214M37pgfn0kdGoLtSHwU=; b=uRnbrnH69FKVpnGlabNm+KnLAWXLPYJ48tnG9NzVBIm72Ophi/tfQliCmpQc2b598dVk/HIs
 /5IXPWas15qqph3gKfdg9ORDLEGePdmzYn9jntD50XBCUtNLdZX9e1sXfcUQgRGXJWS060Uf
 mwczsbnieAvtyDGPJbCMFSWnqnc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6accfd.7fafbc2e56c0-smtp-out-n02;
 Thu, 12 Mar 2020 23:59:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06E04C433CB; Thu, 12 Mar 2020 23:59:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (178-55-160-207.bb.dnainternet.fi [178.55.160.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9ED9C433D2;
        Thu, 12 Mar 2020 23:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9ED9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Veerendranath Jakkam <vjakkam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] cfg80211: Configure PMK lifetime and reauth threshold for PMKSA entries
Date:   Fri, 13 Mar 2020 01:59:03 +0200
Message-Id: <20200312235903.18462-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Veerendranath Jakkam <vjakkam@codeaurora.org>

Drivers that trigger roaming need to know the lifetime of the configured
PMKSA for deciding whether to trigger the full or PMKSA cache based
authentication. The configured PMKSA is invalid after the PMK lifetime
has expired and must not be used after that and the STA needs to
disassociate if the PMK expires. Hence the STA is expected to refresh
the PMK with a full authentication before this happens (e.g., when
reassociating to a new BSS the next time or by performing EAPOL
reauthentication depending on the AKM) to avoid unnecessary
disconnection.

The PMK reauthentication threshold is the percentage of the PMK lifetime
value and indicates to the driver to trigger a full authentication roam
(without PMKSA caching) after the reauthentication threshold time, but
before the PMK timer has expired. Authentication methods like SAE need
to be able to generate a new PMKSA entry without having to force a
disconnection after this threshold timeout. If no roaming occurs between
the reauthentication threshold time and PMK lifetime expiration,
disassociation is still forced.

The new attributes for providing these values correspond to the dot11
MIB variables dot11RSNAConfigPMKLifetime and
dot11RSNAConfigPMKReauthThreshold.

This type of functionality is already available in cases where user
space component is in control of roaming. This commit extends that same
capability into cases where parts or all of this functionality is
offloaded to the driver.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/cfg80211.h       | 13 +++++++++++++
 include/uapi/linux/nl80211.h | 27 +++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 11 +++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e511b225be29..c8bce1b74319 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2696,6 +2696,17 @@ enum wiphy_params_flags {
  * @cache_id: 2-octet cache identifier advertized by a FILS AP identifying the
  *	scope of PMKSA. This is valid only if @ssid_len is non-zero (may be
  *	%NULL).
+ * @pmk_lifetime: Maximum lifetime for PMKSA in seconds
+ *	(dot11RSNAConfigPMKLifetime) or 0 if not specified.
+ *	The configured PMKSA must not be used for PMKSA caching after
+ *	expiration and any keys derived from this PMK become invalid on
+ *	expiration, i.e., the current association must be dropped if the PMK
+ *	used for it expires.
+ * @pmk_reauth_threshold: Threshold time for reauthentication (percentage of
+ *	PMK lifetime, dot11RSNAConfigPMKReauthThreshold) or 0 if not specified.
+ *	Drivers are expected to trigger a full authentication instead of using
+ *	this PMKSA for caching when reassociating to a new BSS after this
+ *	threshold to generate a new PMK before the current one expires.
  */
 struct cfg80211_pmksa {
 	const u8 *bssid;
@@ -2705,6 +2716,8 @@ struct cfg80211_pmksa {
 	const u8 *ssid;
 	size_t ssid_len;
 	const u8 *cache_id;
+	u32 pmk_lifetime;
+	u8 pmk_reauth_threshold;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b002ef2060fa..3d6da43145c9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2442,6 +2442,30 @@ enum nl80211_commands {
  *	on output (in wiphy attributes) it contains only the feature sub-
  *	attributes.
  *
+ * @NL80211_ATTR_PMK_LIFETIME: Maximum lifetime for PMKSA in seconds (u32,
+ *	dot11RSNAConfigPMKReauthThreshold; 0 is not a valid value).
+ *	An optional parameter configured through %NL80211_CMD_SET_PMKSA.
+ *	Drivers that trigger roaming need to know the lifetime of the
+ *	configured PMKSA for triggering the full vs. PMKSA caching based
+ *	authentication. This timeout helps authentication methods like SAE,
+ *	where PMK gets updated only by going through a full (new SAE)
+ *	authentication instead of getting updated during an association for EAP
+ *	authentication. No new full authentication within the PMK expiry shall
+ *	result in a disassociation at the end of the lifetime.
+ *
+ * @NL80211_ATTR_PMK_REAUTH_THRESHOLD: Reauthentication threshold time, in
+ *	terms of percentage of %NL80211_ATTR_PMK_LIFETIME
+ *	(u8, dot11RSNAConfigPMKReauthThreshold, 1..100). This is an optional
+ *	parameter configured through %NL80211_CMD_SET_PMKSA. Requests the
+ *	driver to trigger a full authentication roam (without PMKSA caching)
+ *	after the reauthentication threshold time, but before the PMK lifetime
+ *	has expired.
+ *
+ *	Authentication methods like SAE need to be able to generate a new PMKSA
+ *	entry without having to force a disconnection after the PMK timeout. If
+ *	no roaming occurs between the reauth threshold and PMK expiration,
+ *	disassociation is still forced.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2912,6 +2936,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_TID_CONFIG,
 
+	NL80211_ATTR_PMK_LIFETIME,
+	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 59f233790686..f6289bd2c2e2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -652,6 +652,8 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HE_BSS_COLOR] = NLA_POLICY_NESTED(he_bss_color_policy),
 	[NL80211_ATTR_TID_CONFIG] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_tid_config_attr_policy),
+	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
 };
 
 /* policy for the key attributes */
@@ -10488,6 +10490,15 @@ static int nl80211_setdel_pmksa(struct sk_buff *skb, struct genl_info *info)
 		pmksa.pmk_len = nla_len(info->attrs[NL80211_ATTR_PMK]);
 	}
 
+	if (info->attrs[NL80211_ATTR_PMK_LIFETIME])
+		pmksa.pmk_lifetime =
+			nla_get_u32(info->attrs[NL80211_ATTR_PMK_LIFETIME]);
+
+	if (info->attrs[NL80211_ATTR_PMK_REAUTH_THRESHOLD])
+		pmksa.pmk_reauth_threshold =
+			nla_get_u8(
+				info->attrs[NL80211_ATTR_PMK_REAUTH_THRESHOLD]);
+
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_STATION &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_CLIENT &&
 	    !(dev->ieee80211_ptr->iftype == NL80211_IFTYPE_AP &&
-- 
2.20.1
