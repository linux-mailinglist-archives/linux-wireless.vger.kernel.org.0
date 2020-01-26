Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DEA149CDC
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 21:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAZUar (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 15:30:47 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:31959 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgAZUar (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 15:30:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580070646; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oqk/Z/yXZvfhI71C4YEbLWeK9FF2RfSJuyzFOPeJgps=; b=f2VDpkQlGO2BTXr2CQiCz4LjoCMrODDYprrnmYd36CzIA1Pyo/Mc2qHrU02twSAHFd0bzX41
 yjfSNDk52pg+oEpknjccBQMbA/xYLPoja6jdxaj1akBlTbh4lglxekHOcrsLT5XVgw03IfQK
 ZJN+/X11x0Y525vk1B0k/HZl9/c=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2df6f5.7f28032c8110-smtp-out-n03;
 Sun, 26 Jan 2020 20:30:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7126EC43383; Sun, 26 Jan 2020 20:30:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vjakkam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BD4EC433CB;
        Sun, 26 Jan 2020 20:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BD4EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjakkam@codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Veerendranath Jakkam <vjakkam@codeaurora.org>
Subject: [PATCH v4] cfg80211: Enhance the AKM advertizement to support per interface.
Date:   Mon, 27 Jan 2020 02:00:32 +0530
Message-Id: <20200126203032.21934-1-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200126112113.19542-1-vjakkam@codeaurora.org>
References: <20200126112113.19542-1-vjakkam@codeaurora.org>
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

This commit aims the same and enhances the earlier mechanism of advertizing
the AKMs per wiphy. Add new nl80211 attributes and data structure to
provide supported AKMs per interface type to userspace.

the AKMs advertized in akm_suites are default capabilities if not
advertized for a specific interface type in iftype_akm_suites.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
 include/net/cfg80211.h       | 28 ++++++++++++++++++++++-
 include/uapi/linux/nl80211.h | 33 +++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 43 ++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fa027d0d031b..83e92d5c20d8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4398,6 +4398,21 @@ struct cfg80211_pmsr_capabilities {
 	} ftm;
 };
 
+/**
+ * struct wiphy_iftype_akm_suites - This structure encapsulates supported akm
+ * suites for interface types defined in @iftypes_mask. Each type in the
+ * @iftypes_mask must be unique across all instances of iftype_akm_suites.
+ *
+ * @iftypes_mask: bitmask of interfaces types
+ * @akm_suites: points to an array of supported akm suites
+ * @n_akm_suites: number of supported AKM suites
+ */
+struct wiphy_iftype_akm_suites {
+	u16 iftypes_mask;
+	const u32 *akm_suites;
+	int n_akm_suites;
+};
+
 /**
  * struct wiphy - wireless hardware description
  * @reg_notifier: the driver's regulatory notification callback,
@@ -4410,8 +4425,16 @@ struct cfg80211_pmsr_capabilities {
  * @signal_type: signal type reported in &struct cfg80211_bss.
  * @cipher_suites: supported cipher suites
  * @n_cipher_suites: number of supported cipher suites
- * @akm_suites: supported AKM suites
+ * @akm_suites: supported AKM suites. These are the default AKMs supported if
+ *	the supported AKMs not advertized for a specific interface type in
+ *	iftype_akm_suites.
  * @n_akm_suites: number of supported AKM suites
+ * @iftype_akm_suites: array of supported akm suites info per interface type.
+ *	Note that the bits in @iftypes_mask inside this structure cannot
+ *	overlap (i.e. only one occurrence of each type is allowed across all
+ *	instances of iftype_akm_suites).
+ * @num_iftype_akm_suites: number of interface types for which supported akm
+ *	suites are specified separately.
  * @retry_short: Retry limit for short frames (dot11ShortRetryLimit)
  * @retry_long: Retry limit for long frames (dot11LongRetryLimit)
  * @frag_threshold: Fragmentation threshold (dot11FragmentationThreshold);
@@ -4618,6 +4641,9 @@ struct wiphy {
 	int n_akm_suites;
 	const u32 *akm_suites;
 
+	const struct wiphy_iftype_akm_suites *iftype_akm_suites;
+	unsigned int num_iftype_akm_suites;
+
 	u8 retry_short;
 	u8 retry_long;
 	u32 frag_threshold;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 809ef9165684..0503a2ae7620 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2402,6 +2402,13 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
  *
+ * @NL80211_ATTR_IFTYPE_AKM_SUITES: nested array attribute, with each entry
+ *	using attributes from &enum nl80211_iftype_akm_attributes. This
+ *	attribute is sent in a response to %NL80211_CMD_GET_WIPHY indicating
+ *	supported AKM suites capability per interface. AKMs advertised in
+ *	%NL80211_ATTR_AKM_SUITES are default capabilities if AKM suites not
+ *	advertised for a specific interface type.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2868,6 +2875,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_BSS_COLOR,
 
+	NL80211_ATTR_IFTYPE_AKM_SUITES,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6614,4 +6623,28 @@ enum nl80211_bss_color_attributes {
 	NL80211_HE_BSS_COLOR_ATTR_MAX = __NL80211_HE_BSS_COLOR_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_iftype_akm_attributes - interface type AKM attributes
+ * @__NL80211_IFTYPE_AKM_ATTR_INVALID: Invalid
+ *
+ * @NL80211_IFTYPE_AKM_ATTR_IFTYPES: nested attribute containing a flag
+ *	attribute for each interface type that supports AKM suites specified in
+ *	%NL80211_IFTYPE_AKM_ATTR_SUITES
+ * @NL80211_IFTYPE_AKM_ATTR_SUITES: an array of u32. Used to indicate supported
+ *	AKM suites for the specified interface types.
+ *
+ * @__NL80211_IFTYPE_AKM_ATTR_LAST: Internal
+ * @NL80211_IFTYPE_AKM_ATTR_MAX: highest interface type AKM attribute.
+ */
+enum nl80211_iftype_akm_attributes {
+	__NL80211_IFTYPE_AKM_ATTR_INVALID,
+
+	NL80211_IFTYPE_AKM_ATTR_IFTYPES,
+	NL80211_IFTYPE_AKM_ATTR_SUITES,
+
+	/* keep last */
+	__NL80211_IFTYPE_AKM_ATTR_LAST,
+	NL80211_IFTYPE_AKM_ATTR_MAX = __NL80211_IFTYPE_AKM_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 00f24d4c623e..53a8cb23204f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1893,6 +1893,46 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int
+nl80211_put_iftype_akm_suites(struct cfg80211_registered_device *rdev,
+			      struct sk_buff *msg)
+{
+	int i;
+	struct nlattr *nested, *nested_akms;
+	const struct wiphy_iftype_akm_suites *iftype_akms;
+
+	if (!rdev->wiphy.num_iftype_akm_suites ||
+	    !rdev->wiphy.iftype_akm_suites)
+		return 0;
+
+	nested = nla_nest_start(msg, NL80211_ATTR_IFTYPE_AKM_SUITES);
+	if (!nested)
+		return -ENOBUFS;
+
+	for (i = 0; i < rdev->wiphy.num_iftype_akm_suites; i++) {
+		nested_akms = nla_nest_start(msg, i + 1);
+		if (!nested_akms)
+			return -ENOBUFS;
+
+		iftype_akms = &rdev->wiphy.iftype_akm_suites[i];
+
+		if (nl80211_put_iftypes(msg, NL80211_IFTYPE_AKM_ATTR_IFTYPES,
+					iftype_akms->iftypes_mask))
+			return -ENOBUFS;
+
+		if (nla_put(msg, NL80211_IFTYPE_AKM_ATTR_SUITES,
+			    sizeof(u32) * iftype_akms->n_akm_suites,
+			    iftype_akms->akm_suites)) {
+			return -ENOBUFS;
+		}
+		nla_nest_end(msg, nested_akms);
+	}
+
+	nla_nest_end(msg, nested);
+
+	return 0;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2451,6 +2491,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			    rdev->wiphy.akm_suites))
 			goto nla_put_failure;
 
+		if (nl80211_put_iftype_akm_suites(rdev, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.20.1
