Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488BD3A8AD7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFOVQm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:16:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40679 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhFOVQm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:16:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623791677; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vdwvR5rnGJ6D8aCJjKEH3CzQd36qt64o5iCHJ2mXe/o=; b=ww6dA6k2h5FGNhm8Bp62g0TLm2xCxju2oZZSTGtSI6XbYMHOOAHtPw8ac5yBblCjKzF5eOVJ
 0q8jMjRUmBZKapFkHr+mCkwd3wqpmly/oxjsAF7BggnCygzg4IoPZHmwkcPYS5s+8JTRnzcF
 WjxkSW3cq8+N2lCS520w0F+56pU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60c9183ded59bf69cc36e3df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 21:14:37
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A3F0C43217; Tue, 15 Jun 2021 21:14:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-78-13-nat.elisa-mobile.fi [85.76.78.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B6EFC43460;
        Tue, 15 Jun 2021 21:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B6EFC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 04/12] ath11k: avoid additional access to ath11k_hal_srng_dst_num_free
Date:   Wed, 16 Jun 2021 00:13:59 +0300
Message-Id: <20210615211407.92233-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615211407.92233-1-jouni@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

In ath11k_dp_process_rx(), after processing rx_desc from
ath11k_hal_srng_dst_get_next_entry(), ath11k_hal_srng_dst_num_free()
is accessed everytime because of done flag is not set.

To avoid this additional access to ath11k_hal_srng_dst_num_free(),
increment total_msdu_reaped only when continuation is not set and
update done flag correspondingly.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 32c348812769..54ab69959c98 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2628,7 +2628,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 				 DMA_FROM_DEVICE);
 
 		num_buffs_reaped[mac_id]++;
-		total_msdu_reaped++;
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
 					desc.info0);
@@ -2651,10 +2650,15 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		__skb_queue_tail(&msdu_list, msdu);
 
-		if (total_msdu_reaped >= quota && !rxcb->is_continuation) {
+		if (rxcb->is_continuation) {
+			done = false;
+		} else {
+			total_msdu_reaped++;
 			done = true;
-			break;
 		}
+
+		if (total_msdu_reaped >= budget)
+			break;
 	}
 
 	/* Hw might have updated the head pointer after we cached it.
-- 
2.25.1

