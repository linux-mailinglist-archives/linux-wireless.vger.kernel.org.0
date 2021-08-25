Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3F3F7200
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 11:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhHYJjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 05:39:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbhHYJjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 05:39:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629884340; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cSjpKxnMW2nVzM98G6vYq2CvXAbSsJtK4DM8yThjHEU=; b=DnNzaki+IGwImSREfsYVEWa5qH+dGccR4x75U5W5P+aLOufd8QUJZmdtiGHeG/z0S9vVOpXX
 JA6WHA7Gj6VUA8CxzmVXANHghOJ3hDcwUTpCoFIKLSGb8/OMRT2SmHx1aohAdmvQRXRopIRs
 keqIb0VIpaglp1xu4aFVRtwDRkw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61260faf4d644b7d1c884173 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 09:38:55
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40818C43460; Wed, 25 Aug 2021 09:38:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 993BDC43617;
        Wed, 25 Aug 2021 09:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 993BDC43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v2 04/12] ath11k: avoid additional access to ath11k_hal_srng_dst_num_free
Date:   Wed, 25 Aug 2021 15:07:49 +0530
Message-Id: <1629884277-18759-5-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index b84c2db..994959b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2623,7 +2623,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 				 DMA_FROM_DEVICE);
 
 		num_buffs_reaped[mac_id]++;
-		total_msdu_reaped++;
 
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
 					desc.info0);
@@ -2646,10 +2645,15 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
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
2.7.4

