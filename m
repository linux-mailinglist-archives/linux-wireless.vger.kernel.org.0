Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5822258D3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGTHmy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 03:42:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13201 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgGTHmx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 03:42:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595230972; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=PSeYnBswFU5Fw3CqxsQiEKZDmGQbE6AV99Oqf6hKHrU=; b=lsijo1Zp1f9tIeafm2EYsMrX3q0NjC19dYaUCxcC+S31eQQGyer8ggwWMAb0xkd6rH9GpuTv
 zoMEVK3f0yPjbmwJFaYLPu0BZvd2Lx2xc2Dj98E3EqUhygqJg0hOuKYhBTPTAz2o41zrInb8
 BpXvZN2Xu2fDTSzsyw6aF+73bYc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f154af003c8596cdb5287ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 07:42:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7B83C433C6; Mon, 20 Jul 2020 07:42:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vjakkam-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92E4DC433C9;
        Mon, 20 Jul 2020 07:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92E4DC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjakkam@codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] cfg80211: Add support to advertize OCV support
Date:   Mon, 20 Jul 2020 13:12:25 +0530
Message-Id: <20200720074225.8990-1-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new feature flag that drivers can use to advertize support for
Operating Channel Validation (OCV) when using driver's SME for RSNA
handshakes.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
 include/uapi/linux/nl80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4e6339ab1fce..afccae23b0f5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5773,6 +5773,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS: The driver
  *	can report tx status for control port over nl80211 tx operations.
  *
+ * @NL80211_EXT_FEATURE_OPERATING_CHANNEL_VALIDATION: Driver supports Operating
+ *	Channel Validation (OCV) when using driver's SME for RSNA handshakes.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5828,6 +5831,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT,
 	NL80211_EXT_FEATURE_SCAN_FREQ_KHZ,
 	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS,
+	NL80211_EXT_FEATURE_OPERATING_CHANNEL_VALIDATION,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.20.1

