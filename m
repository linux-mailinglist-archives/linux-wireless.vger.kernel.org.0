Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820753F7F0C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 01:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhHYXkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 19:40:13 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64826 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhHYXkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 19:40:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629934766; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FBhtRsz7II9iVtWFFo0AZP2XK3ulX6YiKBXT1VTeed0=; b=wyqngNYeOBzZYDbdPxR7tIy/wmR6yd5HV5DSz5jpXM6bFuwf/hMQ5wKZyRiUDGs7phI2OfVB
 4F8uSeBD5pHcZljWhyWbuHTNHY/6Vj10VXn1+VbtyG0notwlD5CpwV6TkG4GkH2m9Y/UJDu8
 D4kys+T9IU1ArkUk09vC+E7Nfoc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6126d4a8b52e91333c4b4911 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 23:39:20
 GMT
Sender: srirrama=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 036B9C4360D; Wed, 25 Aug 2021 23:39:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from srirrama-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1285C4338F;
        Wed, 25 Aug 2021 23:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C1285C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Sriram R <srirrama@codeaurora.org>
Subject: [PATCH] cfg80211: Fetch wiphy DFS domain if it is self-managed
Date:   Thu, 26 Aug 2021 05:08:50 +0530
Message-Id: <1629934730-16388-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently during CAC start or other radar events, the DFS
domain is fetched from cfg based on global DFS setting.

But this could be different in case of self managed wiphy's
in case the self managed driver updates its database or supports
regions which has DFS domain set to UNSET in cfg80211 local
regdomain.

This avoids AP bringup failure for these self-managed drivers
when such conflict occurs.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 net/wireless/reg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index c2d0ff7..78626e7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -171,6 +171,7 @@ enum nl80211_dfs_regions reg_get_dfs_region(struct wiphy *wiphy)
 {
 	const struct ieee80211_regdomain *regd = NULL;
 	const struct ieee80211_regdomain *wiphy_regd = NULL;
+	enum nl80211_dfs_regions dfs_region;
 
 	rcu_read_lock();
 	regd = get_cfg80211_regdom();
@@ -182,6 +183,13 @@ enum nl80211_dfs_regions reg_get_dfs_region(struct wiphy *wiphy)
 	if (!wiphy_regd)
 		goto out;
 
+	/* In case the wiphy is self managed, return its dfs domain */
+	if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) {
+		dfs_region = wiphy_regd->dfs_region;
+		rcu_read_unlock();
+		return dfs_region;
+	}
+
 	if (wiphy_regd->dfs_region == regd->dfs_region)
 		goto out;
 
-- 
2.7.4

