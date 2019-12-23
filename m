Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5BE1299F8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWSxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 13:53:11 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:35494 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbfLWSxL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 13:53:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577127190; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=mTzTzOD7S8buDM8TD/7EmZ1ftkKNvO20o6VgJnaxfKs=; b=LRDzr4D4E5uY6DmruPF+3J16Q8FXqHWJNrbXysBJdP2wxFmgiJF9qdUcRfsP2GzlDS8UKPB5
 LLAvZ8jYrYPKF40KoSAKcfJvGmK/4vvTDu0Fdu1a7hDmY6dPPv7q44SVPlrr9vBnwuPdO9p8
 Rxddfe18DKK/sg2mdZOrZCC+2/c=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e010d12.7f95a4c16650-smtp-out-n03;
 Mon, 23 Dec 2019 18:53:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D608C34175; Mon, 23 Dec 2019 18:53:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vjakkam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2BD6C58A2A;
        Mon, 23 Dec 2019 18:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2BD6C58A2A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjakkam@codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] cfg80211: Enhance the AKM advertizement to support per interface.
Date:   Tue, 24 Dec 2019 00:22:55 +0530
Message-Id: <20191223185255.1009-1-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit ab4dfa20534e ("cfg80211: Allow drivers to advertise supported AKM
suites") introduces the support to advertize the AKM support.

This needs an enhancement to advertize the AKM support per interface type,
specifically for the cfg80211-based drivers that implement SME and use
different mechanisms to support the AKM's for each interface type (e.g.,
the support for SAE, OWE AKM's take different paths for such drivers on
STA/AP mode).

User space would like to know if such driver has the implementation for
an AKM on a respective interface type.

This commit aims the same and replaces the earlier mechanism of advertizing
the AKM per wiphy.

User space shall assume that all AKMs for each interface type are
supported, if the driver does not advertize this capability.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
 include/net/cfg80211.h       | 20 +++++++++++++-----
 include/uapi/linux/nl80211.h |  7 ++++++
 net/wireless/nl80211.c       | 41 ++++++++++++++++++++++++++++++++----
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 059524b87c4c..3e92e674a941 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4370,6 +4370,16 @@ struct cfg80211_pmsr_capabilities {
 	} ftm;
 };
 
+/**
+ * struct ieee80211_akm_suites - supported akm suites
+ * @akm_suites: points to an array of supported akm suites
+ * @n_akm_suites: number of supported AKM suites
+ */
+struct ieee80211_akm_suites {
+	const u32 *akm_suites;
+	int n_akm_suites;
+};
+
 /**
  * struct wiphy - wireless hardware description
  * @reg_notifier: the driver's regulatory notification callback,
@@ -4382,8 +4392,6 @@ struct cfg80211_pmsr_capabilities {
  * @signal_type: signal type reported in &struct cfg80211_bss.
  * @cipher_suites: supported cipher suites
  * @n_cipher_suites: number of supported cipher suites
- * @akm_suites: supported AKM suites
- * @n_akm_suites: number of supported AKM suites
  * @retry_short: Retry limit for short frames (dot11ShortRetryLimit)
  * @retry_long: Retry limit for long frames (dot11LongRetryLimit)
  * @frag_threshold: Fragmentation threshold (dot11FragmentationThreshold);
@@ -4543,6 +4551,9 @@ struct cfg80211_pmsr_capabilities {
  *	@support_mbssid must be set for this to have any effect.
  *
  * @pmsr_capa: peer measurement capabilities
+ *
+ * @supported_akm_suites: supported akm suites info per interface, points to an
+ *	array indexed by interface type
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
@@ -4587,9 +4598,6 @@ struct wiphy {
 	int n_cipher_suites;
 	const u32 *cipher_suites;
 
-	int n_akm_suites;
-	const u32 *akm_suites;
-
 	u8 retry_short;
 	u8 retry_long;
 	u32 frag_threshold;
@@ -4687,6 +4695,8 @@ struct wiphy {
 
 	const struct cfg80211_pmsr_capabilities *pmsr_capa;
 
+	const struct ieee80211_akm_suites *supported_akm_suites;
+
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 341e0e8cae46..3b11df917818 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2400,6 +2400,11 @@ enum nl80211_commands {
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
  *	(u16).
  *
+ * @NL80211_ATTR_SUPPORTED_AKM_SUITES: Used for AKM suite capability
+ *	advertisement per interface. This is a nested attribute of
+ *	%NL80211_ATTR_FRAME_TYPE attributes, containing the supported AKM's
+ *	per interface.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2864,6 +2869,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_VLAN_ID,
 
+	NL80211_ATTR_SUPPORTED_AKM_SUITES,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fa3526592c51..e27f0f9e5848 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1885,6 +1885,41 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int
+nl80211_send_akm_suites(struct sk_buff *msg,
+			const struct ieee80211_akm_suites *supported_akm_suites)
+{
+	struct nlattr *nl_ftypes, *nl_ifs;
+	enum nl80211_iftype ift;
+	const struct ieee80211_akm_suites *supported_akms;
+
+	if (!supported_akm_suites)
+		return 0;
+
+	nl_ifs = nla_nest_start(msg, NL80211_ATTR_SUPPORTED_AKM_SUITES);
+	if (!nl_ifs)
+		return -ENOBUFS;
+
+	for (ift = 0; ift < NUM_NL80211_IFTYPES; ift++) {
+		nl_ftypes = nla_nest_start(msg, ift);
+		if (!nl_ftypes)
+			return -ENOBUFS;
+
+		supported_akms = &supported_akm_suites[ift];
+		if (supported_akms->akm_suites &&
+		    nla_put(msg, NL80211_ATTR_AKM_SUITES,
+			    sizeof(u32) * supported_akms->n_akm_suites,
+			    supported_akms->akm_suites)) {
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
@@ -2437,10 +2472,8 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		state->split_start++;
 		break;
 	case 15:
-		if (rdev->wiphy.akm_suites &&
-		    nla_put(msg, NL80211_ATTR_AKM_SUITES,
-			    sizeof(u32) * rdev->wiphy.n_akm_suites,
-			    rdev->wiphy.akm_suites))
+		if (nl80211_send_akm_suites(msg,
+					    rdev->wiphy.supported_akm_suites))
 			goto nla_put_failure;
 
 		/* done */
-- 
2.20.1
