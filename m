Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB0140904
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 12:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgAQLfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 06:35:23 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:23554 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgAQLfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 06:35:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579260922; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hQAYMS5w0nfqbw/xx3GxacA2M4Gb0moYxdfIQjWYFfA=; b=hjFgLuA63bSIcg9l1nTEOxJ3ur7d4nlxFVrKqc0i6bdBBsayNHIig3I4oa/MCO2c+lVwMYQw
 60VkYKO0aWnBXFISlaGqIaDibR6gsFrFk5Of/JZbnp+FEcwB3gshVWYCsLJSAAjQdJ7bO3tN
 ivOmQ3to4qmPLxj+HdpdOTxnG5Y=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e219bf8.7f721a7550d8-smtp-out-n02;
 Fri, 17 Jan 2020 11:35:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 291A3C447A6; Fri, 17 Jan 2020 11:35:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vjakkam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A4B5C4479C;
        Fri, 17 Jan 2020 11:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A4B5C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjakkam@codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Veerendranath Jakkam <vjakkam@codeaurora.org>
Subject: [PATCH v2] cfg80211: Enhance the AKM advertizement to support per interface.
Date:   Fri, 17 Jan 2020 17:05:07 +0530
Message-Id: <20200117113507.13503-1-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191223185255.1009-1-vjakkam@codeaurora.org>
References: <20191223185255.1009-1-vjakkam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit ab4dfa20534e ("cfg80211: Allow drivers to advertise supported AKM
suites") introduces the support to advertize supported AKMs to userspace.

This needs an enhancement to advertize the AKM support per interface type,
specifically for the cfg80211-based drivers that implement SME and use
different mechanisms to support the AKM's for each interface type (e.g.,
the support for SAE, OWE AKM's take different paths for such drivers on
STA/AP mode).

Add a new nl80211 attribute to provide supported AKMs per interface type
to userspace.

This commit aims the same and enhances the earlier mechanism of advertizing
the AKMs per wiphy. AKMs advertized in akm_suites are default capabilities
if not advertized for a specific interface type in iftype_akm_suites.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
Changelog:
v1->v2:
 -Keep advertizing support for AKM suites per wiphy
 -AKM suites per interface overrides wiphy AKM suites for specific interface
 -Rename new nl80211 attribute to NL80211_ATTR_IFTYPE_AKM_SUITES
---
 include/net/cfg80211.h       | 22 +++++++++++++++++++-
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 39 ++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fa027d0d031b..10533dff2102 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4398,6 +4398,18 @@ struct cfg80211_pmsr_capabilities {
 	} ftm;
 };
 
+/**
+ * struct wiphy_iftype_akm_suites - supported akm suites per interface type
+ * @iftype: interface type
+ * @akm_suites: points to an array of supported akm suites
+ * @n_akm_suites: number of supported AKM suites
+ */
+struct wiphy_iftype_akm_suites {
+	enum nl80211_iftype iftype;
+	const u32 *akm_suites;
+	int n_akm_suites;
+};
+
 /**
  * struct wiphy - wireless hardware description
  * @reg_notifier: the driver's regulatory notification callback,
@@ -4410,8 +4422,13 @@ struct cfg80211_pmsr_capabilities {
  * @signal_type: signal type reported in &struct cfg80211_bss.
  * @cipher_suites: supported cipher suites
  * @n_cipher_suites: number of supported cipher suites
- * @akm_suites: supported AKM suites
+ * @akm_suites: supported AKM suites. These are the default AKMs supported if
+ *	the supported AKMs not advertized for a specific interface type in
+ *	iftype_akm_suites.
  * @n_akm_suites: number of supported AKM suites
+ * @iftype_akm_suites: array of supported akm suites info per interface.
+ * @num_iftype_akm_suites: number of interface types for which supported akm
+ *	suites are specified separately.
  * @retry_short: Retry limit for short frames (dot11ShortRetryLimit)
  * @retry_long: Retry limit for long frames (dot11LongRetryLimit)
  * @frag_threshold: Fragmentation threshold (dot11FragmentationThreshold);
@@ -4618,6 +4635,9 @@ struct wiphy {
 	int n_akm_suites;
 	const u32 *akm_suites;
 
+	const struct wiphy_iftype_akm_suites *iftype_akm_suites;
+	unsigned int num_iftype_akm_suites;
+
 	u8 retry_short;
 	u8 retry_long;
 	u32 frag_threshold;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 809ef9165684..a6b688e8834e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2402,6 +2402,10 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
  *
+ * @NL80211_ATTR_IFTYPE_AKM_SUITES: Used for AKM suite capability advertisement
+ *	per interface. This is a nested attribute of %NL80211_ATTR_IFTYPE to
+ *	specify supported AKMs per interface type.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2868,6 +2872,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_BSS_COLOR,
 
+	NL80211_ATTR_IFTYPE_AKM_SUITES,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 00f24d4c623e..f6d5e0c70bab 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1893,6 +1893,42 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int
+nl80211_send_iftype_akm_suites(struct cfg80211_registered_device *rdev,
+			struct sk_buff *msg)
+{
+	int i;
+	struct nlattr *nl_ftypes, *nl_ifs;
+	const struct wiphy_iftype_akm_suites *iftype_akms;
+
+	if (!rdev->wiphy.iftype_akm_suites)
+		return 0;
+
+	nl_ifs = nla_nest_start(msg, NL80211_ATTR_IFTYPE_AKM_SUITES);
+	if (!nl_ifs)
+		return -ENOBUFS;
+
+	for (i = 0; i < rdev->wiphy.num_iftype_akm_suites; i++) {
+		iftype_akms = &rdev->wiphy.iftype_akm_suites[i];
+
+		nl_ftypes = nla_nest_start(msg, iftype_akms->iftype);
+		if (!nl_ftypes)
+			return -ENOBUFS;
+
+		if (iftype_akms->akm_suites &&
+		    nla_put(msg, NL80211_ATTR_AKM_SUITES,
+			    sizeof(u32) * iftype_akms->n_akm_suites,
+			    iftype_akms->akm_suites)) {
+			return -ENOBUFS;
+		}
+		nla_nest_end(msg, nl_ftypes);
+	}
+
+	nla_nest_end(msg, nl_ifs);
+
+	return 0;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2451,6 +2487,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			    rdev->wiphy.akm_suites))
 			goto nla_put_failure;
 
+		if (nl80211_send_iftype_akm_suites(rdev, msg))
+				goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.20.1
