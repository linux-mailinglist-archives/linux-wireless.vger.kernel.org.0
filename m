Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1373F322145
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 22:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhBVVWG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 16:22:06 -0500
Received: from z11.mailgun.us ([104.130.96.11]:62095 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhBVVWE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 16:22:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614028898; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uqTLrCwBw4mrF8gNiVQFV4EBmM37BGXbbNVy5UvbM9g=; b=h8MRCPp7daqtPf8qo2ADkLPVXADx+3IpGmLrvNrlsVtsKWyQRnfX88KPaPM2IzLnGw6ZOXmO
 xzg2lHXZv2ywBZS+dAQlGdQJCBC0cQDfEZIcYzxt1g42K1FldQFY04LP7tZH6mMKeUNAfkBD
 Vvli0HRCIFBJjT2kafylAugkRf8=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60342041bf31d00be0266907 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 21:21:05
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CAD19C433CA; Mon, 22 Feb 2021 21:21:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04CC3C433C6;
        Mon, 22 Feb 2021 21:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04CC3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH] nl80211: Add missing line in nl80211_fils_discovery_policy
Date:   Mon, 22 Feb 2021 13:20:59 -0800
Message-Id: <20210222212059.22492-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add NL80211_FILS_DISCOVERY_ATTR_TMPL explicitly in
nl80211_fils_discovery_policy definition.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 net/wireless/nl80211.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 521d36bb0803..201a36ff91fa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -407,9 +407,10 @@ static const struct nla_policy
 nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
 	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
 	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
-	NLA_POLICY_RANGE(NLA_BINARY,
-			 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
-			 IEEE80211_MAX_DATA_LEN),
+	[NL80211_FILS_DISCOVERY_ATTR_TMPL] =
+			NLA_POLICY_RANGE(NLA_BINARY,
+					 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
+					 IEEE80211_MAX_DATA_LEN),
 };
 
 static const struct nla_policy

base-commit: 38b5133ad607ecdcc8d24906d1ac9cc8df41acd5
-- 
2.25.0

