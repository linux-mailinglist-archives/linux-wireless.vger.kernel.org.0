Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF7109CBD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfKZLFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:05:01 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:54794
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbfKZLE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766298;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=ZK+NUcSGGNvMSvXgZ5mg7LtdtWNwFFV+BgZ6jAGMsLY=;
        b=bLtJRbcYDQqOV6Y1v9sEU72Aj1oY5tmPdk3Vt3LAjFvMN5wsU2tBZrI8HrWux+0E
        JlJhcSamaRqn0Rc4cSk5NtLM1YjT2tD94gwAPko9t9Bgvdg6+6TJWszlOiWEpfdA/Fh
        8Oo5ijQj7AbaovtE9joHg++oN0dTbu65+f8A963o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766298;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=ZK+NUcSGGNvMSvXgZ5mg7LtdtWNwFFV+BgZ6jAGMsLY=;
        b=e3QAAbC8JPUYKXyf99Q6rSi2k4f+J5ym/vGJfBaNT+XSwt6p35Aw951Wj2c0YWBN
        RYjfi3mTFipp2XJiIjQiZ0uqxeIZFHN52zFdv/PlaOVr/azzt3z9sjn0mb0n02UXkAC
        gAlH2HaWf+zduyKBtLCNT5oC9SZDQkCMlfh66UDM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06398C447BB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 10/10] ath11k: Fix target crash due to WBM_IDLE_LINK ring desc shortage
Date:   Tue, 26 Nov 2019 11:04:58 +0000
Message-ID: <0101016ea762c61f-d2419749-a152-4e70-8e34-01fcbaed5532-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>

Make sure the number of WBM_IDLE_LINK ring descriptors is power
of 2. This increases the number of descriptors to 32k from the
current ~18k to fix the target assert because of the shortage in
the descriptors in WBM_IDLE_LINK ring. Remove unnecessary
power of 2 calculation in ath11k_dp_link_desc_setup() as it is
not required after this change.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index ff510e821a29..72c21cf6a352 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -478,6 +478,9 @@ static int ath11k_wbm_idle_ring_setup(struct ath11k_base *ab, u32 *n_link_desc)
 	*n_link_desc = n_mpdu_link_desc + n_mpdu_queue_desc +
 		      n_tx_msdu_link_desc + n_rx_msdu_link_desc;
 
+	if (*n_link_desc & (*n_link_desc - 1))
+		*n_link_desc = 1 << fls(*n_link_desc);
+
 	ret = ath11k_dp_srng_setup(ab, &dp->wbm_idle_ring,
 				   HAL_WBM_IDLE_LINK, 0, 0, *n_link_desc);
 	if (ret) {
@@ -499,9 +502,6 @@ int ath11k_dp_link_desc_setup(struct ath11k_base *ab,
 	u32 *desc;
 	int i, ret;
 
-	if (n_link_desc & (n_link_desc - 1))
-		n_link_desc = 1 << fls(n_link_desc);
-
 	tot_mem_sz = n_link_desc * HAL_LINK_DESC_SIZE;
 	tot_mem_sz += HAL_LINK_DESC_ALIGN;
 
-- 
2.7.4

