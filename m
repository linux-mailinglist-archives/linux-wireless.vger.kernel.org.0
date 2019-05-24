Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9118228F82
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2019 05:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfEXDQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 23:16:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731490AbfEXDQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 23:16:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF0B16087D; Fri, 24 May 2019 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558667802;
        bh=KfH87lSkJ7hpFH9obuGjQSRv2pB4WFr3MC32uwO+sTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kIhf8neneuk7DcpISVKopnkCzP1+EKdClXCJpMYZhCB+P5tvTrRXvXgmd8QTxUbmS
         IyBsQqPPgrYbIRbVCaqTHT07S3Kgy6sUOxQBLruQlLUxJBV+4RAaIxDtJgO7deHm0P
         tmh89kAG+qy1eZao7LHpIu5L3QfK+zpJX79Sp7Bo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E86F602F8;
        Fri, 24 May 2019 03:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558667801;
        bh=KfH87lSkJ7hpFH9obuGjQSRv2pB4WFr3MC32uwO+sTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=otJwjpLpFBb0TjQccYs/C+mI+3wpz8JagCeiS/hh4Ne5qXe6SU/bt7gFK3ba5k4iO
         5S+rDmeYDv7kTL+JUWhj/yM2QM2xydxXtrZ5mRLvoHlLx4g8mu6Pu5c/reLucSNrzZ
         //0KSV0TJv4HxnvFnxycXRsXp7+GbuPoiJHZYM+o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E86F602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Fri, 24 May 2019 11:16:30 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH v2] ath10k: fix fw crash by moving chip reset after napi disabled
Date:   Fri, 24 May 2019 11:16:22 +0800
Message-Id: <1558667782-10998-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On SMP platform, when continuously running wifi up/down, the napi
poll can be scheduled during chip reset, which will call
ath10k_pci_has_fw_crashed() to check the fw status. But in the reset
period, the value from FW_INDICATOR_ADDRESS register will return
0xdeadbeef, which also be treated as fw crash. Fix the issue by
moving chip reset after napi disabled.

ath10k_pci 0000:01:00.0: firmware crashed! (guid 73b30611-5b1e-4bdd-90b4-64c81eb947b6)
ath10k_pci 0000:01:00.0: qca9984/qca9994 hw1.0 target 0x01000000 chip_id 0x00000000 sub 168c:cafe
ath10k_pci 0000:01:00.0: htt-ver 2.2 wmi-op 6 htt-op 4 cal otp max-sta 512 raw 0 hwcrypto 1
ath10k_pci 0000:01:00.0: failed to get memcpy hi address for firmware address 4: -16
ath10k_pci 0000:01:00.0: failed to read firmware dump area: -16
ath10k_pci 0000:01:00.0: Copy Engine register dump:
ath10k_pci 0000:01:00.0: [00]: 0x0004a000   0   0   0   0
ath10k_pci 0000:01:00.0: [01]: 0x0004a400   0   0   0   0
ath10k_pci 0000:01:00.0: [02]: 0x0004a800   0   0   0   0
ath10k_pci 0000:01:00.0: [03]: 0x0004ac00   0   0   0   0
ath10k_pci 0000:01:00.0: [04]: 0x0004b000   0   0   0   0
ath10k_pci 0000:01:00.0: [05]: 0x0004b400   0   0   0   0
ath10k_pci 0000:01:00.0: [06]: 0x0004b800   0   0   0   0
ath10k_pci 0000:01:00.0: [07]: 0x0004bc00   1   0   1   0
ath10k_pci 0000:01:00.0: [08]: 0x0004c000   0   0   0   0
ath10k_pci 0000:01:00.0: [09]: 0x0004c400   0   0   0   0
ath10k_pci 0000:01:00.0: [10]: 0x0004c800   0   0   0   0
ath10k_pci 0000:01:00.0: [11]: 0x0004cc00   0   0   0   0

Tested HW: QCA9984,QCA9887,WCN3990

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
Changes since v1:
- update commit message
---
 drivers/net/wireless/ath/ath10k/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 2bd6cba..80bcb2e 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2059,6 +2059,11 @@ static void ath10k_pci_hif_stop(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif stop\n");
 
+	ath10k_pci_irq_disable(ar);
+	ath10k_pci_irq_sync(ar);
+	napi_synchronize(&ar->napi);
+	napi_disable(&ar->napi);
+
 	/* Most likely the device has HTT Rx ring configured. The only way to
 	 * prevent the device from accessing (and possible corrupting) host
 	 * memory is to reset the chip now.
@@ -2072,10 +2077,6 @@ static void ath10k_pci_hif_stop(struct ath10k *ar)
 	 */
 	ath10k_pci_safe_chip_reset(ar);
 
-	ath10k_pci_irq_disable(ar);
-	ath10k_pci_irq_sync(ar);
-	napi_synchronize(&ar->napi);
-	napi_disable(&ar->napi);
 	ath10k_pci_flush(ar);
 
 	spin_lock_irqsave(&ar_pci->ps_lock, flags);
-- 
1.9.1

