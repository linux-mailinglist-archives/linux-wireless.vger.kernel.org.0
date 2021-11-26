Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0961745E87A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 08:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359196AbhKZHao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 02:30:44 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:42992 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbhKZH2n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 02:28:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637911531; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MBMz0cO/oNQP/wB6HWt9zaLphI0aiUalenIK/sJd7II=; b=V72AMFh5Nv0U+t+NgiDhUs8rf3uxGFAlwPAbNh7aVH5yT9Ck3tV+4rYfQ2h59F7hk3ccYWtb
 xAU1BVSlM8d6L1N0xJl3GsdvXIi8qhPjPk25DX83o/O1afeKaCtvYXJbs6WBuJ9NliqTzySL
 ILgt3MtxanM7WOQ8qnlZTCi/3tw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61a08beae7d68470af0baded (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 07:25:30
 GMT
Sender: vjakkam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 26F27C43616; Fri, 26 Nov 2021 07:25:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-vjakkam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2126C4338F;
        Fri, 26 Nov 2021 07:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B2126C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] nl80211: Add support to offload SA Query procedures for AP SME device
Date:   Fri, 26 Nov 2021 12:55:19 +0530
Message-Id: <1637911519-21306-2-git-send-email-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637911519-21306-1-git-send-email-vjakkam@codeaurora.org>
References: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
 <1637911519-21306-1-git-send-email-vjakkam@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a flag attribute to use in ap settings to indicate userspace
supports offloading of SA Query procedures to driver. Also add AP SME
device feature flag to advertise that the SA Query procedures offloaded
to driver when userspace indicates support for offloading of SA Query
procedures.

Driver handles SA Query procedures in driver's SME it self and skip
sending SA Query request or response frames to userspace when userspace
indicates support for SA Query procedures offload. But if userspace
doesn't advertise support for SA Query procedures offload driver shall
not offload SA Query procedures handling.

Also userspace with SA Query procedures offload capability shall skip SA
Query specific validations when driver indicates support for handling SA
Query procedures.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
 include/uapi/linux/nl80211.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 52ac549..96fbb60 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5754,13 +5754,15 @@ enum nl80211_tdls_operation {
 	NL80211_TDLS_DISABLE_LINK,
 };
 
-/*
+/**
  * enum nl80211_ap_sme_features - device-integrated AP features
- * Reserved for future use, no bits are defined in
- * NL80211_ATTR_DEVICE_AP_SME yet.
+ * @NL80211_AP_SME_SA_QUERY_OFFLOAD: SA Query procedures offloaded to driver
+ *	when user space indicates support for SA Query procedures offload during
+ *	"start ap" with %NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT.
+ */
 enum nl80211_ap_sme_features {
+	NL80211_AP_SME_SA_QUERY_OFFLOAD		= 1 << 0,
 };
- */
 
 /**
  * enum nl80211_feature_flags - device/driver features
@@ -7488,9 +7490,15 @@ enum nl80211_mbssid_config_attributes {
  *
  * @NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT: AP supports external
  *	authentication.
+ * @NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT: Userspace supports SA Query
+ *	procedures offload to driver. If driver advertises
+ *	%NL80211_AP_SME_SA_QUERY_OFFLOAD in AP SME features, userspace shall
+ *	ignore SA Query procedures and validations when this flag is set by
+ *	userspace.
  */
 enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT	= 1 << 0,
+	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
 #endif /* __LINUX_NL80211_H */
-- 
2.7.4

