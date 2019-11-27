Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A711010B0DC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0OIr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:47 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:45904
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfK0OIq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863726;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=md7/j1QlrNqqav8CI6ERp+evYArBgW9ZjxuEETO7bUg=;
        b=o9bL7iac6rkeVQvdmWEWGkOCgYPfkXOHShWW8mNLRHx1P5qS7BC9hOJPtfgCQreZ
        JeW3vmyj5+w0fv5F+OpgkGclCn/gq5SV5yLRSFxytji/tsP3Qnu/6hXtaKneVh1p39g
        xI4/CZEbCUPYvf5NJ9MyR4kN4eRqHNum5OqYd0aU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863726;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=md7/j1QlrNqqav8CI6ERp+evYArBgW9ZjxuEETO7bUg=;
        b=eJbV9lhv7Cr0sw4sxnAZhHa0lcM3ikxGqMe65srOcrXQFds+GmV3mDPC2VVsJUeV
        UBwpbQtYS2V1iJDAHLCUaPFExYfAvhlR0RrO2qV9AtZl1UXeSYnWgWiRKg+V40uTgtr
        1T8XC8lTkqoS8oNd0hXP5ofVzizrLbL4Txk7leOE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76122C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 01/10] ath11k: tracing: fix ath11k tracing
Date:   Wed, 27 Nov 2019 14:08:45 +0000
Message-ID: <0101016ead3164f5-3135488d-f71b-4fc9-834f-08a735724e15-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Add missing tracing subsystem define.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/trace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless/ath/ath11k/trace.h
index 400f759568e1..8700a622be7b 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -17,6 +17,9 @@
 static inline void trace_ ## name(proto) {}
 #endif /* !CONFIG_ATH11K_TRACING || __CHECKER__ */
 
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ath11k
+
 TRACE_EVENT(ath11k_htt_pktlog,
 	    TP_PROTO(struct ath11k *ar, const void *buf, u16 buf_len),
 
-- 
2.7.4

