Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A0108E82
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfKYNKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 08:10:02 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:43714
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbfKYNKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 08:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574687401;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=2Owm28Qx56PjGaPFd81gPGhv/n64vef1LWZesWq1Udw=;
        b=L+DGKJyDqBBxkX7/QBB8yd/qud5NjT1JE/k4PstMSujc8p0apRbAXekc11ZlZt3m
        ilFUKSKcUk57Ty/VhVD/BiNQ0Xd8nbtnLHIzw/EL4RMDAmBK7752BX5QdWx4q8RNodn
        V7VdYYR97xPpriocjqrUrleBYDKRKKlXTWzegYnM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574687401;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=2Owm28Qx56PjGaPFd81gPGhv/n64vef1LWZesWq1Udw=;
        b=GczSXnqM4rQoN5Yx0OH0yDS3T/NzzBdkqCMCQOAohabV5Fx79ypR3rDtLLIUOasF
        C2hg505mI/jbdSvUGzoxp9hi3vt1uiGYZ7dyA67zmjAatI2AdO784ww/jsPnICKV++s
        5F8M4NGlW/o8sKQ4/q2KyCNlAaDot5UNKdbsktH0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8196C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH] ath10k: move non-fatal warn logs to dbg level
Date:   Mon, 25 Nov 2019 13:10:01 +0000
Message-ID: <0101016ea2aee542-7e69e860-2ad6-4897-959f-e934f1a459bb-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.25-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During driver load below warn logs are printed in the console if
firmware doesn't support some optional HTC services, ex:pktlog.
It is likely some older fw version may not support PKTLOG HTC
service as legacy fw uses HTC DATA service  for pktlog.
Move this log to debug level to remove un-necessary warn message
on console.

htc.c:803:  ath10k_warn(ar, "unsupported HTC service id: %d\n",
htc.c:881:  ath10k_warn(ar, "unsupported HTC service id: %d\n",

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 28daed5981a1..367b762632d1 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -809,8 +809,8 @@ int ath10k_htc_connect_service(struct ath10k_htc *htc,
 						&ep->ul_pipe_id,
 						&ep->dl_pipe_id);
 	if (status) {
-		ath10k_warn(ar, "unsupported HTC service id: %d\n",
-			    ep->service_id);
+		ath10k_dbg(ar, ATH10K_DBG_BOOT, "unsupported HTC service id: %d\n",
+			   ep->service_id);
 		return status;
 	}
 
@@ -887,8 +887,8 @@ static bool ath10k_htc_pktlog_svc_supported(struct ath10k *ar)
 						&ul_pipe_id,
 						&dl_pipe_id);
 	if (status) {
-		ath10k_warn(ar, "unsupported HTC service id: %d\n",
-			    ATH10K_HTC_SVC_ID_HTT_LOG_MSG);
+		ath10k_dbg(ar, ATH10K_DBG_BOOT, "unsupported HTC pktlog service id: %d\n",
+			   ATH10K_HTC_SVC_ID_HTT_LOG_MSG);
 
 		return false;
 	}
-- 
2.22.0

