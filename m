Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EBF2C5913
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 17:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391506AbgKZQRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 11:17:21 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:11290 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKZQRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 11:17:21 -0500
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Nov 2020 08:17:21 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Nov 2020 08:17:19 -0800
X-QCInternal: smtphost
Received: from youghand-linux.qualcomm.com ([10.206.66.115])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 Nov 2020 21:47:02 +0530
Received: by youghand-linux.qualcomm.com (Postfix, from userid 2370257)
        id 5F17521B5F; Thu, 26 Nov 2020 21:47:01 +0530 (IST)
From:   Youghandhar Chintala <youghand@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pillair@codeaurora.org, dianders@chromium.org, kuabhs@chromium.org,
        briannorris@chromium.org,
        Youghandhar Chintala <youghand@codeaurora.org>
Subject: [PATCH] ath10k: skip the wait for completion to recovery in shutdown path
Date:   Thu, 26 Nov 2020 21:46:56 +0530
Message-Id: <20201126161656.18802-1-youghand@codeaurora.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in the shutdown callback we wait for recovery to complete
before freeing up the resources. This can lead to unwanted delay
during the shutdown and thereby increase the shutdown time.

As an attempt to take less time during shutdown, remove the wait for
recovery completion in the shutdown callback.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
Change-Id: I0474ab7dc3730aaacac888bb9a7acc2fa0e8b4f8
---
 drivers/net/wireless/ath/ath10k/snoc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 84666f72bdfa..15580a91fe98 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1790,9 +1790,6 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
 
 	reinit_completion(&ar->driver_recovery);
 
-	if (test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
-		wait_for_completion_timeout(&ar->driver_recovery, 3 * HZ);
-
 	set_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags);
 
 	ath10k_core_unregister(ar);
-- 
2.26.0

