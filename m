Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534773F7207
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhHYJkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 05:40:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14298 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbhHYJkB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 05:40:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629884356; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=fAWLIxIHD/SpkkEyKpzcQVs32Zf7McNYgvkMz3vLauk=; b=OKWIS18OdFU/im7wPnJsKb3EjA3jlhSKaX2kg5Ik7RdkeRiXMJ9UnExyf22fCxxT9H81QRQN
 N7Xs6dDYjI/ulQylpt61EKlHfWYVIOGAVoNIaexVgmwRtK8t+hslRcKNDuUMON+EhSpEgdQf
 g27MthdMzuRqPOiRcc/vgZMpKuE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61260fb5d15f4d68a2a738ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 09:39:01
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F0F1C43619; Wed, 25 Aug 2021 09:39:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EDB5C43617;
        Wed, 25 Aug 2021 09:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6EDB5C43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v2 06/12] ath11k: remove usage quota while processing rx packets
Date:   Wed, 25 Aug 2021 15:07:51 +0530
Message-Id: <1629884277-18759-7-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The usage of quota variable inside
ath11k_dp_rx_process_received_packets() is redundant.
Since we would queue only max packets to the list before
calling this function so it would never exceed quota. Hence Removing
usage of quota variable.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1d85e10..e105bdc 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2523,7 +2523,7 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 						  struct napi_struct *napi,
 						  struct sk_buff_head *msdu_list,
-						  int *quota, int mac_id)
+						  int mac_id)
 {
 	struct sk_buff *msdu;
 	struct ath11k *ar;
@@ -2557,7 +2557,6 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 		}
 
 		ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
-		(*quota)--;
 	}
 
 	rcu_read_unlock();
@@ -2574,7 +2573,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	int total_msdu_reaped = 0;
 	struct hal_srng *srng;
 	struct sk_buff *msdu;
-	int quota = budget;
 	bool done = false;
 	int buf_id, mac_id;
 	struct ath11k *ar;
@@ -2677,8 +2675,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		if (!num_buffs_reaped[i])
 			continue;
 
-		ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list[i],
-						      &quota, i);
+		ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list[i], i);
 
 		ar = ab->pdevs[i].ar;
 		rx_ring = &ar->dp.rx_refill_buf_ring;
@@ -2687,7 +2684,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 					   HAL_RX_BUF_RBM_SW3_BM);
 	}
 exit:
-	return budget - quota;
+	return total_msdu_reaped;
 }
 
 static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
-- 
2.7.4

