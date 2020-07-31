Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51579234B47
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 20:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbgGaSk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 14:40:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:45623 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387676AbgGaSk4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 14:40:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596220856; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=OREqPJteIHJk2Pk5IqpgXTMFw64sVxYctCvrweMhIWg=; b=b856dJFS1GxfqejMy/v4rvslag/rOBVYEe14fD5OS9oxy+OdlJdSuoY4h7I4JI5rLPqPepnh
 dNpB8FKHZ4NepN0zs8XXDnvMr3wBBuSC2iZWZeaP+IU6V2s+U7+PdEh76GAIqQZBR7NiiE2n
 aaoIApebjhFccgoD/G11lOpBpWY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5f2465aeeecfc978d3a0ee50 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 18:40:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91962C433C6; Fri, 31 Jul 2020 18:40:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-102-34-nat.elisa-mobile.fi [85.76.102.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52DBAC433C9;
        Fri, 31 Jul 2020 18:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52DBAC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] mac80211: Handle special status codes in SAE commit
Date:   Fri, 31 Jul 2020 21:38:30 +0300
Message-Id: <20200731183830.18735-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SAE authentication has been extended with H2E (IEEE 802.11 REVmd) and PK
(WFA) options. Those extensions use special status code values in the
SAE commit messages (Authentication frame with transaction sequence
number 1) to identify which extension is in use. mac80211 was
interpreting those new values as the AP denying authentication and that
resulted in failure to complete SAE authentication in some cases.

Fix this by adding exceptions for the new status code values 126 and
127.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/linux/ieee80211.h | 2 ++
 net/mac80211/mlme.c       | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 9f732499ea88..c47f43e65a2f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2561,6 +2561,8 @@ enum ieee80211_statuscode {
 	/* 802.11ai */
 	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 108,
 	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 109,
+	WLAN_STATUS_SAE_HASH_TO_ELEMENT = 126,
+	WLAN_STATUS_SAE_PK = 127,
 };
 
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 839d0367446c..8b7ca8ddfe20 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2988,7 +2988,10 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
 
 		if (auth_alg == WLAN_AUTH_SAE &&
-		    status_code == WLAN_STATUS_ANTI_CLOG_REQUIRED)
+		    (status_code == WLAN_STATUS_ANTI_CLOG_REQUIRED ||
+		     (auth_transaction == 1 &&
+		      (status_code == WLAN_STATUS_SAE_HASH_TO_ELEMENT ||
+		       status_code == WLAN_STATUS_SAE_PK))))
 			return;
 
 		sdata_info(sdata, "%pM denied authentication (status %d)\n",
-- 
2.20.1

