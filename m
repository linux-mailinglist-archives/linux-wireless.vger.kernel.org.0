Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82622B5B6C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgKQI52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 03:57:28 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:57540 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgKQI52 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 03:57:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605603447; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Xb6leVpvlrMtZV5MU909J2Hf63pXgecUd/SdaJjNzow=; b=FMZ829nCtgfSn0CgTKm7v28Pu83+1lEzikhHDt8gq3e5Pu2YpziAB5HYN7LR0OUnmNMmYudB
 2rY7JWSdOHkMjLgp0soE8DZq+n4twNS7A6nnsdDYnevwE6LdaUDIFVl7i2Sfm3Nx8XZJfT1Z
 y43cG/W4d7DXd0R170U40Bye9E0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fb39077309342b914c17756 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 08:57:27
 GMT
Sender: kathirve=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64B2FC43461; Tue, 17 Nov 2020 08:57:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akalaise-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirve)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EEF66C43460;
        Tue, 17 Nov 2020 08:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEF66C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kathirve@codeaurora.org
From:   Karthikeyan Kathirvel <kathirve@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: [PATCH] mac80211: choosing first valid channel from the list
Date:   Tue, 17 Nov 2020 14:27:16 +0530
Message-Id: <1605603436-12856-1-git-send-email-kathirve@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Though the first channel from sband channel list is invalid
or disabled still mac80211 is choosing this disabled channel
as a default channel for monitor interface. This will end-up
in choosing wrong channel.

Fixed by assigning the first available valid or enabled channel
to the respective radios.

Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
---
 net/mac80211/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 523380a..1dfcccf 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -982,8 +982,15 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			continue;
 
 		if (!dflt_chandef.chan) {
+			/*
+			 * Assigning the first enabled channel to dflt_chandef from the
+			 * list of channels available specific to country
+			 */
+			for (i = 0; i < sband->n_channels; i++)
+				if (!(sband->channels[i].flags & IEEE80211_CHAN_DISABLED))
+					break;
 			cfg80211_chandef_create(&dflt_chandef,
-						&sband->channels[0],
+						&sband->channels[i == sband->n_channels ? 0 : i],
 						NL80211_CHAN_NO_HT);
 			/* init channel we're on */
 			if (!local->use_chanctx && !local->_oper_chandef.chan) {
-- 
2.7.4

