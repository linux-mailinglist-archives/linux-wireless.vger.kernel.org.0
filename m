Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8986C42D808
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Oct 2021 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhJNLVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 07:21:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50540 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJNLVc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 07:21:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634210367; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vfOxo/5ZWmikGRxjNTGyGNlOO3G2Fx1sjLi+kLS524g=; b=tPOfvLi8QAyoXUI0RBsi+26TR5sVSHxbEU3KlatSID9KmW0ElvuRanj++6DeUEbxzmazVD0c
 gk7uQ9s2EhVbeabveR3WtDW3ViHIciZDhUJ74qfRc0244BevsiCA6ZkybnQl5jlcRrTpaTV2
 n9BfTcATUWnnO8PVhI6Fl8vOOTk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61681226f3e5b80f1ffddb88 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Oct 2021 11:19:02
 GMT
Sender: vjakkam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 271A6C4360D; Thu, 14 Oct 2021 11:19:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-vjakkam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E6EBC43460;
        Thu, 14 Oct 2021 11:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5E6EBC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] nl80211: Indicate SA Query procedures offload for AP SME device
Date:   Thu, 14 Oct 2021 16:48:51 +0530
Message-Id: <1634210331-9001-1-git-send-email-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add AP SME device feature flag to advertise that the SA Query procedures
are handled in driver.

If this flag is advertised SA Query request or response frames from peers
are not reported to userspace. Thus userspace components shall skip SA
Query specific validations.

Ex: When AP started with Operating Channel Validation(OCV) support and
channel switch occurs, hostapd starts SA Query timer for OCV enabled
STAs. Hostapd sends deauth to the STAs which didn't send SA Query
request before timeout, Hostapd can skip such validations when this flag
advertised.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
 include/uapi/linux/nl80211.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index eda608b..99746aa 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5735,13 +5735,17 @@ enum nl80211_tdls_operation {
 	NL80211_TDLS_DISABLE_LINK,
 };
 
-/*
+/**
  * enum nl80211_ap_sme_features - device-integrated AP features
- * Reserved for future use, no bits are defined in
- * NL80211_ATTR_DEVICE_AP_SME yet.
+ * @NL80211_DEVICE_AP_SME_SA_QUERY_OFFLOAD: Driver handles SA Query procedures.
+ *	If this flag is advertised by the driver, SA Query request/response
+ *	frames are handled within the driver and won't be reported to userspace.
+ *	Userspace shall skip SA Query specific validations if the driver is
+ *	advertizing this capability.
+ */
 enum nl80211_ap_sme_features {
+	NL80211_DEVICE_AP_SME_SA_QUERY_OFFLOAD		= 1 << 0,
 };
- */
 
 /**
  * enum nl80211_feature_flags - device/driver features
-- 
2.7.4

