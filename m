Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60431A48C9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 19:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJRFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 13:05:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47827 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgDJRFm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 13:05:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586538342; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Kv7myonseSRBAS2TYbse5+s5rqqp2VnQhWcDuHD0LYw=; b=r8mq23Iblxz/nLklqy5shbkLXV4uRyWIiEgL/BTv/K16MuIhPPqqprjmMGc5Ra+jC3q/iEEy
 m8aHoRi5WGJpvIfG4Vh8qB4fDa/UjbN7yNm3s3scKk1TgA36vXwHsEdB+KjsW6Ensydf9mcB
 gD/P63PhW08CTDw7+kmu5BjGzn8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e90a753.7f5456de4298-smtp-out-n05;
 Fri, 10 Apr 2020 17:05:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A79FC432C2; Fri, 10 Apr 2020 17:05:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A143C433BA;
        Fri, 10 Apr 2020 17:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A143C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH] ath11k: Cleanup in pdev destroy and mac register during crash on recovery
Date:   Fri, 10 Apr 2020 22:36:43 +0530
Message-Id: <1586538405-16226-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Debugfs pdev entries should be cleaned up during the crash
on recovery. If not, mac register will fail for the reason
that it is already registered during core reconfigure.

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.c | 3 +++
 drivers/net/wireless/ath/ath11k/mac.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 8d48517..825e7ba6 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -803,6 +803,9 @@ static ssize_t ath11k_debug_dump_soc_rx_stats(struct file *file,
 
 int ath11k_debug_pdev_create(struct ath11k_base *ab)
 {
+	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
 	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
 
 	if (IS_ERR_OR_NULL(ab->debugfs_soc)) {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9f8bc19..4783394 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5891,6 +5891,9 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	int i;
 	int ret;
 
+	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
-- 
1.9.1
