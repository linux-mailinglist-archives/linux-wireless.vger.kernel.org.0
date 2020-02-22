Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E59168F18
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgBVN1Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:27:24 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:52818 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgBVN1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:27:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582378043; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lm/s0o/uficKeoKuo4iCsIN6R6Bp586AJ7wf/WKuJ+k=; b=AK4IVuSUDqaW1ydxS27OBD5C4pYgStj7Rdn90nJpU2aJznRPmq4YoACaaWYljtd3KAM6OuMu
 WAAfqQz/mAR7nnSEeWDo4yBb2u3NCgXx5r+cCVxUeJfBadP8F+TSaoElbidAzsZpgJSSHK5O
 W32fvqphD4xLpsvu7I6o+XUWB8g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e512c3b.7f6e3a9d49d0-smtp-out-n01;
 Sat, 22 Feb 2020 13:27:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0EC48C433A2; Sat, 22 Feb 2020 13:27:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (176-93-35-56.bb.dnainternet.fi [176.93.35.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94277C43383;
        Sat, 22 Feb 2020 13:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94277C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 7/7] mac80211: Enable Beacon protection
Date:   Sat, 22 Feb 2020 15:25:48 +0200
Message-Id: <20200222132548.20835-7-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222132548.20835-1-jouni@codeaurora.org>
References: <20200222132548.20835-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now that there is support for BIGTK configuration and AP/STA
functionality for using BIP with Beacon frames, indicate support for the
Beacon protection functionality.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index cae3a34d3503..b32cacb83053 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -591,6 +591,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_PROTECTION);
 
 	if (!ops->hw_scan) {
 		wiphy->features |= NL80211_FEATURE_LOW_PRIORITY_SCAN |
-- 
2.20.1
