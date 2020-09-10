Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D65263E72
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgIJHVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:21:41 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:41502
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728617AbgIJHU7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 03:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599722459;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=AD9isEXpGm9GphaBTQ+NXNSJRx6ncGuSPZFftyjcgqw=;
        b=FOFYO9M26rDo3o7sw94SH4hhCUsKFGpD07N+om5vRBEnfcLLJYB067881bH1vgFe
        Rlv5dlet39Oz3aY+2GJW07LGt6A0RbuLLHf3zwCiH6V9DNOofzHR5XShF0LDbD19Ixa
        Ja9cOdVa90OPbkVLftZ0XKmf2dO0g8G7BJ/j7uYw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599722459;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=AD9isEXpGm9GphaBTQ+NXNSJRx6ncGuSPZFftyjcgqw=;
        b=gzHXLLGEKARAd1VmkN8bvg5dsCOT02dmlxuJmuZtAjBwvQeV4pdg5F0u0i1k9apm
        se3HSTUpDSutPDue/f3N9x8ZVHLhWb9RUF2IjXixiN9C+c71hVqFXQW/sjAb3fNo1ZQ
        4l4Gi7ETwdqv+BHDisuR04y9PMvIw3OnL67imy8E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3171CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: fix link error when CONFIG_REMOTEPROC is disabled
Date:   Thu, 10 Sep 2020 07:20:59 +0000
Message-ID: <0101017476e38f40-c4168ac4-c00a-4220-a032-fe17e4a157cb-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.10-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If CONFIG_REMOTEPROC was disabled the linking failed with:

ERROR: modpost: "rproc_get_by_phandle" [drivers/net/wireless/ath/ath11k/ath11k.ko] undefined!

Compile tested only.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 1ff8ed786d5d ("ath11k: use remoteproc only with AHB devices")
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 437b1123a34f..413811edd083 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -784,6 +784,9 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 	struct rproc *prproc;
 	phandle rproc_phandle;
 
+	if (!IS_ENABLED(CONFIG_REMOTEPROC))
+		return 0;
+
 	if (ab->bus_params.mhi_support)
 		return 0;
 
-- 
2.7.4

