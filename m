Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5C168F17
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgBVN1R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:27:17 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:52818 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgBVN1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:27:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582378036; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uGb4PD3+QgbOk5IT0XjgVnounPn0xPFqQJE3vMqnfvs=; b=ipJzOaWFsgGW9zCKHZHqMcv3xZP4Sk1MqtYQLyqY5cS1HdFyS82NNiLs06+0olzzsAyvNTFN
 rkYfft78s3aMpTrQgfZ79S2CeKNJz1ltuZDLU+Q3SI2aPrw/3DVXRfiMbpaS+u54JAgh1vq7
 UA17RXF4RNeN/VzBRHiTid9WHMo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e512c2b.7fe2ead8dce0-smtp-out-n01;
 Sat, 22 Feb 2020 13:27:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BD5E4C4479C; Sat, 22 Feb 2020 13:27:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (176-93-35-56.bb.dnainternet.fi [176.93.35.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 305E4C43383;
        Sat, 22 Feb 2020 13:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 305E4C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/7] cfg80211: More error messages for key addition failures
Date:   Sat, 22 Feb 2020 15:25:42 +0200
Message-Id: <20200222132548.20835-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These were helpful while working with extensions to NL80211_CMD_NEW_KEY,
so add more explicit error reporting for additional cases that can fail
while that command is being processed.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/wireless/nl80211.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f0112dabe21e..447c388b5905 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3980,8 +3980,10 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
-	if (!key.p.key)
+	if (!key.p.key) {
+		GENL_SET_ERR_MSG(info, "no key");
 		return -EINVAL;
+	}
 
 	if (info->attrs[NL80211_ATTR_MAC])
 		mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
@@ -3995,8 +3997,10 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 
 	/* for now */
 	if (key.type != NL80211_KEYTYPE_PAIRWISE &&
-	    key.type != NL80211_KEYTYPE_GROUP)
+	    key.type != NL80211_KEYTYPE_GROUP) {
+		GENL_SET_ERR_MSG(info, "key type not pairwise or group");
 		return -EINVAL;
+	}
 
 	if (key.type == NL80211_KEYTYPE_GROUP &&
 	    info->attrs[NL80211_ATTR_VLAN_ID])
@@ -4007,15 +4011,22 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 
 	if (cfg80211_validate_key_settings(rdev, &key.p, key.idx,
 					   key.type == NL80211_KEYTYPE_PAIRWISE,
-					   mac_addr))
+					   mac_addr)) {
+		GENL_SET_ERR_MSG(info, "key setting validation failed");
 		return -EINVAL;
+	}
 
 	wdev_lock(dev->ieee80211_ptr);
 	err = nl80211_key_allowed(dev->ieee80211_ptr);
-	if (!err)
+	if (err)
+		GENL_SET_ERR_MSG(info, "key not allowed");
+	if (!err) {
 		err = rdev_add_key(rdev, dev, key.idx,
 				   key.type == NL80211_KEYTYPE_PAIRWISE,
 				    mac_addr, &key.p);
+		if (err)
+			GENL_SET_ERR_MSG(info, "key addition failed");
+	}
 	wdev_unlock(dev->ieee80211_ptr);
 
 	return err;
-- 
2.20.1
