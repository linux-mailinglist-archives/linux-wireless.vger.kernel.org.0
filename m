Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78F932AFB2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhCCA2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:28:09 -0500
Received: from z11.mailgun.us ([104.130.96.11]:60276 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384601AbhCBPWk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 10:22:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614698433; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=X/rBB6Mfb3HTFcW5K4H5qHEV4T8XyPF6bjBJnHNM3aY=; b=oE0c5slesIwpaQDLUQiE738KJjqq+Bl/yUwsxdE7hV5FdS0h7JKb6jr6FWMRyjDNsP+jHhN2
 kOxnPUdYvq3O4L5y1Q84nd2tzRdAW7jthxCDhUW/xxzrNul8XDXFX1z5d3PlHUFXr8iPzFXw
 hkCiz6N4JhnZnzZX4ZwKfwOIKYk=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 603e50ce540e11609c9a36fb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 14:50:54
 GMT
Sender: vamsin=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92603C433ED; Tue,  2 Mar 2021 14:50:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-vamsin-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vamsin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C3AEC433CA;
        Tue,  2 Mar 2021 14:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C3AEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vamsin@codeaurora.org
From:   Vamsi Krishna <vamsin@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] nl80211: Add interface to indicate TDLS peer's HE capability
Date:   Tue,  2 Mar 2021 20:20:36 +0530
Message-Id: <1614696636-30144-1-git-send-email-vamsin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enhance enum nl80211_tdls_peer_capability to configure TDLS peer's
support for HE mode. Userspace decodes the TDLS setup response frame
and confugures the HE mode support to driver if the peer has advertized
HE mode support in TDLS setup response frame. The driver uses this
information to decide whether to include HE operation IE in TDLS setup
confirmation frame.

Signed-off-by: Vamsi Krishna <vamsin@codeaurora.org>

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ac78da9..adc890e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6295,11 +6295,13 @@ struct nl80211_vendor_cmd_info {
  * @NL80211_TDLS_PEER_HT: TDLS peer is HT capable.
  * @NL80211_TDLS_PEER_VHT: TDLS peer is VHT capable.
  * @NL80211_TDLS_PEER_WMM: TDLS peer is WMM capable.
+ * @NL80211_TDLS_PEER_HE: TDLS peer is HE capable.
  */
 enum nl80211_tdls_peer_capability {
 	NL80211_TDLS_PEER_HT = 1<<0,
 	NL80211_TDLS_PEER_VHT = 1<<1,
 	NL80211_TDLS_PEER_WMM = 1<<2,
+	NL80211_TDLS_PEER_HE = 1<<3,
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

