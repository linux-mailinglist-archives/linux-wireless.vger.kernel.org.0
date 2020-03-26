Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A71193B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 09:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCZI5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 04:57:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:41168 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgCZI5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 04:57:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585213028; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SVDzVvh7UWTaHEiYnvLX3CtoVduMFxWY8h2LqYdjdho=; b=ZoH9tGp4nXVgUKiAM+EfALlGVJgs5le4qxJk1VL4xzeG0+h+qMBtmqbGyTL2/K18bV46vwPw
 8rGke60+/5RnZi9P68bx/fdCMAwyrygqvpcsI7gnsD4haXLAfqB4NOG5To5+dCzRjeuZSSgL
 il9VTauK5bLw2qIRdu7Rb1mOZUQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c6e54.7f65635f5e68-smtp-out-n02;
 Thu, 26 Mar 2020 08:56:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55A5AC433BA; Thu, 26 Mar 2020 08:56:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E092C433D2;
        Thu, 26 Mar 2020 08:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E092C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        Govindaraj Saminathan <gsamin@codeaurora.org>
Subject: [PATCH] ath10k: Fix the race condition in firmware dump work queue
Date:   Thu, 26 Mar 2020 14:27:57 +0530
Message-Id: <1585213077-28439-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is a race condition, when the user writes 'hw-restart' and
'hard' in the simulate_fw_crash debugfs file without any delay.
In the above scenario, the firmware dump work queue(scheduled by
'hard') should be handled gracefully, while the target is in the
'hw-restart'.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00044

Co-developed-by: Govindaraj Saminathan <gsamin@codeaurora.org>
Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index ded7a22..cd1c5d6 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2074,6 +2074,7 @@ static void ath10k_pci_hif_stop(struct ath10k *ar)
 	ath10k_pci_irq_sync(ar);
 	napi_synchronize(&ar->napi);
 	napi_disable(&ar->napi);
+	cancel_work_sync(&ar_pci->dump_work);
 
 	/* Most likely the device has HTT Rx ring configured. The only way to
 	 * prevent the device from accessing (and possible corrupting) host
-- 
1.9.1
