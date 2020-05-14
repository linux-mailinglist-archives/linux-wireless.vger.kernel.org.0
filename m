Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8B1D2AB5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgENIyi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 04:54:38 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:51061 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENIyh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 04:54:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589446477; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6I003CpuY/pBMpQ63jSyy4e+Gdlel0wuWlUP+Z6PqGs=; b=gIm/qPT+daxO0KsJ4m4qfi23uATHvn9yVrn4gr5/Sn4EKl2wrpjIBK2wWrXxnOhjv2YcS/Dr
 Y+MtGGOzFZ3tHUc4QORide8yyB+fUc4kRjSTkYjWjcKPnPRTnXKEFKnVbs/pSv+wR8PgnbR+
 SaIIubuNII3k4K6HzyS42zRuSHE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd074b.7f4d2af02650-smtp-out-n01;
 Thu, 14 May 2020 08:54:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6EEB2C433BA; Thu, 14 May 2020 08:54:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from LIANGWEI1.qualcomm.com (unknown [112.64.61.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: liangwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D252FC433D2;
        Thu, 14 May 2020 08:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D252FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=liangwei@codeaurora.org
From:   Liangwei Dong <liangwei@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, liangwei@codeaurora.org
Subject: [PATCH] nl80211: fix p2p go mgmt send failure on DFS channel
Date:   Thu, 14 May 2020 16:54:31 +0800
Message-Id: <1589446471-208-1-git-send-email-liangwei@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Start Autonomous p2p GO on DFS channel and then trigger remote
p2p peer to connect to p2p GO. P2P remote device will send
P2P provision discovery request action frame to P2P GO on GO's
home channel - DFS. But when P2P GO sends Provision discovery
response action frame to P2P remote, Kernel rejects the mgmt
frame sending since Kernel doesn't allow "offchan" tx mgmt when
AP interface is active on DFS channel.

Fix by allow "offchan" tx mgmt if the requested channel is same
or compatible with AP's home channel.

Signed-off-by: Liangwei Dong <liangwei@codeaurora.org>
---
 net/wireless/nl80211.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3d27b24c68b2..f33fd923bb19 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10807,6 +10807,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_chan_def chandef;
+	const struct cfg80211_chan_def *compat_chandef;
 	int err;
 	void *hdr = NULL;
 	u64 cookie;
@@ -10874,9 +10875,15 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	wdev_lock(wdev);
-	if (params.offchan && !cfg80211_off_channel_oper_allowed(wdev)) {
-		wdev_unlock(wdev);
-		return -EBUSY;
+	if (params.offchan &&
+	    !cfg80211_off_channel_oper_allowed(wdev) &&
+	    !cfg80211_chandef_identical(&wdev->chandef, &chandef)) {
+		compat_chandef = cfg80211_chandef_compatible(&wdev->chandef,
+							     &chandef);
+		if (compat_chandef != &chandef) {
+			wdev_unlock(wdev);
+			return -EBUSY;
+		}
 	}
 	wdev_unlock(wdev);
 
-- 
2.26.2
