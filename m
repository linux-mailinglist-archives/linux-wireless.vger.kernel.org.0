Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2257E2C01A2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 09:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgKWIpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 03:45:13 -0500
Received: from z5.mailgun.us ([104.130.96.5]:53027 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKWIpN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 03:45:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606121113; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=picD/oosaJe7dkANl9Ga8X6sohugMNk22SHGnNTU+jk=; b=vR/4vmmw1hLoA4oxM1yDFkumt9AJeTU7QwTELm6TuGgnv7cm5EgbRMdbQZPCsRAvej7u0uQG
 XgfEpCgWeJ1vyaIPbo8YtEmUYYghlt5wqkPjEv/qdlnNFlYVYKZdqFAVXdDwCwrtfGXoS3r4
 uP7PqfB4Me5kD3HNyHWuikO5Rs0=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fbb7695d64ea0b703f032fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 08:45:09
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E8D8C433C6; Mon, 23 Nov 2020 08:45:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75A9AC433ED;
        Mon, 23 Nov 2020 08:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75A9AC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] mac80211: change back to return true by default of ieee80211_chandef_he_6ghz_oper
Date:   Mon, 23 Nov 2020 16:45:52 +0800
Message-Id: <1606121152-3452-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The default value is true returned by ieee80211_chandef_he_6ghz_oper,
change it to true same with before.

Fixes: 1d00ce807efa ("mac80211: support S1G association")

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 49342060490f..94e624e9439b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3455,7 +3455,7 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 
 	*chandef = he_chandef;
 
-	return false;
+	return true;
 }
 
 bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
-- 
2.23.0

