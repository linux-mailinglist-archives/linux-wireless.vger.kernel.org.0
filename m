Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B7260F2A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgIHKCG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 06:02:06 -0400
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:47662
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729023AbgIHKCA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 06:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599559319;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=/WnOVNuZqkt/ALmLA1kdouN8QxOnf+7kb/JaqYcKkRk=;
        b=Rfk2VReX61W2na/feCGJXvkBvs1fTa8iyYqDjTh9Z1qD/TT0frUE80a41kSCG4WC
        klIt7mWSMqoKWCHpIptP3OfYD1m2yZTPrnhWvXAIJ/zAPUv468e/npsBGQ7SbnuPAjC
        hiTTin8ZsCuBtyzLc8fxEu+Uzxtb3qItkJtN8z1Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599559319;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=/WnOVNuZqkt/ALmLA1kdouN8QxOnf+7kb/JaqYcKkRk=;
        b=aGP3mS98lCStOIYI/Rasr80tsRe0lPTWkN8IPxgosFV51xAmkojRXr19jhSTYMSX
        zlNxpFpMsJde7MX2uQgpaCxQsoEUIiMMPyBdjyFqnreTQqhqBLk4pEl5gDXcXKpFQle
        EjrBXENrwXKyHSiI9guMzlGzA+wkfTzhZ2BvWFZk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9DCCC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath11k: remove calling ath11k_init_hw_params() second time
Date:   Tue, 8 Sep 2020 10:01:59 +0000
Message-ID: <010101746d2a40d3-25cd7dbe-c0dd-4fdf-8735-366d7fb40207-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.08-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During probe ath11k_init_hw_params() is called from ath11k_core_pre_init()
and is not needed agian in ath11k_core_init().

Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1

Fixes: 1ff8ed786d5d (ath11k: use remoteproc only with AHB devices)
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 648a697e414a..03e922111cd6 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -849,12 +849,6 @@ int ath11k_core_init(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ret = ath11k_init_hw_params(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to get hw params %d\n", ret);
-		return ret;
-	}
-
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
-- 
2.7.4

