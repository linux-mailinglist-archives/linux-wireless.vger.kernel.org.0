Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E122D7D0E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405532AbgLKRhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:37:51 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:37205 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395385AbgLKRgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708188; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=rjrRPQnX6JAGdRz9UQMxfR6QsX6oI7Dun72G8V0zKPc=; b=xIRFuTIfydMD3AhNobu8mV8lMaQ5dOuQa8JUc/6P1qQlmBNJXbxD64ogqRIaI97M62AOC0kv
 VMnSy/SdxOGoFSLWQuwSCxK16f8hdO6IiM7+KLyXFilZs80YVYIvmHDvJsLDYp+JVP03Klq2
 g0szpOgxn9si8lrTq9FL8FlAQpA=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fd3ae0035a25d1b16de48aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6AA28C433C6; Fri, 11 Dec 2020 17:35:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FBD4C43461;
        Fri, 11 Dec 2020 17:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FBD4C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/10] ath11k: pci: read select_window register to ensure write is finished
Date:   Fri, 11 Dec 2020 19:35:43 +0200
Message-Id: <1607708150-21066-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Just when resume from WoW, the write to select_window doesn't take
effect immediately, so read the register again to ensure the write
operation is finished.

Another change is to reset select_window to ZERO because this
register isn't restored after WoW, so the content of this register
becomes ZERO too.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 770cefd53290..ee1c2edefa20 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -126,6 +126,7 @@ static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offse
 	if (window != ab_pci->register_window) {
 		iowrite32(WINDOW_ENABLE_BIT | window,
 			  ab->mem + WINDOW_REG_ADDRESS);
+		ioread32(ab->mem + WINDOW_REG_ADDRESS);
 		ab_pci->register_window = window;
 	}
 }
-- 
2.7.4

