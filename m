Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38B623B348
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 05:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgHDDd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 23:33:58 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13936 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728516AbgHDDd4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 23:33:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596512036; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Gk/Om31or3lvmAOLnkFUo/B2U3neGTDk6SRFZjkCs9U=; b=ILNMjPSHiw72BXL2PSUz+ZGB0y2iWgDzsRpP+oH9uw41kjBdhF83QFU1wLdx+fJ9Wh8YZ0bv
 t/gMxbpGiGgnxLpD/VIJWbMQ6Lh5uQDgSTPwAeVDxnKIl4KYn/Qi1sbi2iXs+hzRsLHCyYQM
 6Q0XY5K2uoIglMB2LlBPKG6A+Wo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5f28d71af89b692ba260f14f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 03:33:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4F68C433C9; Tue,  4 Aug 2020 03:33:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vjakkam-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 658BAC433C6;
        Tue,  4 Aug 2020 03:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 658BAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjakkam@codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] cfg80211: Add feature flag to indicate RSNXE IE support in FT
Date:   Tue,  4 Aug 2020 09:02:50 +0530
Message-Id: <1596511970-8415-1-git-send-email-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new feature flag that drivers in which FT handshake is offloaded,
to advertise support for interoperability with legacy clients which
doesn't support using RSNXE IE for MIC calculation in FT handshake. The
userspace can choose to enable/disable FT protocols that require RSNXE IE
to be used based on this flag advertised by drivers.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 631f3a99..83e8079 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5820,6 +5820,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK: Device wants to do 4-way
  *	handshake with PSK in AP mode (PSK is passed as part of the start AP
  *	command).
+ * @NL80211_EXT_FEATURE_FT_RSNXE: Driver supports RSNXE element in FT handshake
+ *	and interoperable with legacy clients that doesn't support using RSNXE
+ *	IE for MIC computation in FT handshake.
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
@@ -5878,6 +5881,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS,
 	NL80211_EXT_FEATURE_OPERATING_CHANNEL_VALIDATION,
 	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
+	NL80211_EXT_FEATURE_FT_RSNXE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

