Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9653710AA83
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 07:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfK0GEO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 01:04:14 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:34688
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbfK0GEO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 01:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574834653;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=v2TL8JjA1UFCJVbjuSoZ2qp2ZKyNT0/o7iQcl3kD3yM=;
        b=Xzy0fW5CVGZ5ltfL3gukAP9V5lSVtcTE6bNYcUYxB9f2RcidRMLTuNLnju3nB9wB
        MEXrnG07oq0mkWAyvReUaduE16TjArFTtDb0m7sYDenzkPbgcR6S9Pz574PDWtlmzoU
        BZPV9wjD8xFXv21H1LbzsE++mpyNSrMZOLooTJRA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574834653;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=v2TL8JjA1UFCJVbjuSoZ2qp2ZKyNT0/o7iQcl3kD3yM=;
        b=dxkIOJvibWwoYVpNKYB3pHPPPyMB6hHmxsislArb7yWQUrLZNfqwJozq4f6RZDow
        WOGY3ko4BVIMNjgbC3HCc0oEMvqXSmqLy6ivWaomIw2aBr4FruMyENaTLBvEKJmJS0b
        W5JqWT8kCXzkxwR44VrSukps2MNLaYhhYZJXajG4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 617A9C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: enable wow feature for sdio chip
Date:   Wed, 27 Nov 2019 06:04:13 +0000
Message-ID: <0101016eab75c9ce-0fc306b4-0804-4829-bf57-85d803251a00-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.27-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sdio does not support wow, this patch is to enable it. When system enter
sleep state, if wowlan is enabled, then sdio chip will keep power if
platform support keep power, after resume, it will not need to re-load
firmware again.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 60849ab8088f..bd94dbb23741 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1889,7 +1889,7 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
 
 static int ath10k_sdio_hif_suspend(struct ath10k *ar)
 {
-	return -EOPNOTSUPP;
+	return 0;
 }
 
 static int ath10k_sdio_hif_resume(struct ath10k *ar)
@@ -2040,7 +2040,26 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
  */
 static int ath10k_sdio_pm_suspend(struct device *device)
 {
-	return 0;
+	struct sdio_func *func = dev_to_sdio_func(device);
+	struct ath10k_sdio *ar_sdio = sdio_get_drvdata(func);
+	struct ath10k *ar = ar_sdio->ar;
+	mmc_pm_flag_t pm_flag, pm_caps;
+	int ret;
+
+	if (!device_may_wakeup(ar->dev))
+		return 0;
+
+	pm_flag = MMC_PM_KEEP_POWER;
+
+	ret = sdio_set_host_pm_flags(func, pm_flag);
+	if (ret) {
+		pm_caps = sdio_get_host_pm_caps(func);
+		ath10k_warn(ar, "failed to set sdio host pm flags (0x%x, 0x%x): %d\n",
+			    pm_flag, pm_caps, ret);
+		return ret;
+	}
+
+	return ret;
 }
 
 static int ath10k_sdio_pm_resume(struct device *device)
-- 
2.23.0

