Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5383A8AD8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFOVQt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:16:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40679 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhFOVQt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:16:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623791684; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=c3q88Knu7cwzY3xC2USw2Q3EdFztRbY4JrUNMSZZP74=; b=VL07QTFifOjnLUYXu5gSsEqbUsKgOYQ6pt4/SBWy5RYyn1D0WVIrFXr5fzn2nOVcGo0pvVrw
 FEkiUXaGfqprejmyb75RXIqMRy1oM1VwkxEWT3iL3sW5Eba1nd4rSA3LzwIkf1jPw+mFiaKh
 piBSWnPjxJ6r6bY+mJccM03UdmQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c91844abfd22a3dcdc0705 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 21:14:44
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B0D2FC433F1; Tue, 15 Jun 2021 21:14:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-78-13-nat.elisa-mobile.fi [85.76.78.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F31BCC43460;
        Tue, 15 Jun 2021 21:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F31BCC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 06/12] ath11k: remove usage quota while processing rx packets
Date:   Wed, 16 Jun 2021 00:14:01 +0300
Message-Id: <20210615211407.92233-7-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615211407.92233-1-jouni@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

The usage of quota variable inside
ath11k_dp_rx_process_received_packets() is redundant. Since we would
queue only max packets to the list before calling this function so it
would never exceed quota. Hence remove use of the quota variable.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 5810110ff519..3ece90d890e5 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2528,7 +2528,7 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 						  struct napi_struct *napi,
 						  struct sk_buff_head *msdu_list,
-						  int *quota, int mac_id)
+						  int mac_id)
 {
 	struct sk_buff *msdu;
 	struct ath11k *ar;
@@ -2562,7 +2562,6 @@ static void ath11k_dp_rx_process_received_packets(struct ath11k_base *ab,
 		}
 
 		ath11k_dp_rx_deliver_msdu(ar, napi, msdu);
-		(*quota)--;
 	}
 
 	rcu_read_unlock();
@@ -2579,7 +2578,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	int total_msdu_reaped = 0;
 	struct hal_srng *srng;
 	struct sk_buff *msdu;
-	int quota = budget;
 	bool done = false;
 	int buf_id, mac_id;
 	struct ath11k *ar;
@@ -2682,8 +2680,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		if (!num_buffs_reaped[i])
 			continue;
 
-		ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list[i],
-						      &quota, i);
+		ath11k_dp_rx_process_received_packets(ab, napi, &msdu_list[i], i);
 
 		ar = ab->pdevs[i].ar;
 		rx_ring = &ar->dp.rx_refill_buf_ring;
@@ -2692,7 +2689,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 					   HAL_RX_BUF_RBM_SW3_BM);
 	}
 exit:
-	return budget - quota;
+	return total_msdu_reaped;
 }
 
 static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
-- 
2.25.1

