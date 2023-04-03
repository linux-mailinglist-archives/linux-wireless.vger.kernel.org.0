Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920D26D4EC5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjDCRSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDCRSV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 13:18:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD003F9
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:18:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333GrwjJ031148;
        Mon, 3 Apr 2023 17:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2IKGJSGRDgCTFOID39/BQnrOwlJxEKuvnOW895Mwc6o=;
 b=V5HrSkEZttrgo5qim/cWEOdVLdlsEH6bvvEto5eHBvx+QTRjovom7QIuQr7jwZO/OoAg
 foRhlr/lg2uv2MBLuesnyzu5oK1tYUZ/BNUlNmvF0uM9pYa6RCTlKb6a4XKXE7/5JzlE
 4W6PIO83b94ZMm7DmtGvzrtvnI/64xQQpdieRh+TKr/A8oDqm8n6y282xmYSKBxWXGHa
 k5tZUOYiJvaGD3Y1DP0Ltxsry+gskk7DCs8YkkEr+1qMg+gdJAvb+yP9ITWkxCNSndMg
 BVh61WpR8bvn3HXwf/kLfm4w3Xh6ZV2oyL64BhTSiA61Dh0zmgCaiax6m3lM7qmL/M6x pA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pquxth69k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 17:18:16 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 333HIBpO030158;
        Mon, 3 Apr 2023 17:18:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ppdpkepnh-1;
        Mon, 03 Apr 2023 17:18:11 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 333HIBr6030153;
        Mon, 3 Apr 2023 17:18:11 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 333HIBPE030152;
        Mon, 03 Apr 2023 17:18:11 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id 355871100076; Mon,  3 Apr 2023 22:48:10 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix potential wmi_mgmt_tx_queue race condition
Date:   Mon,  3 Apr 2023 22:48:06 +0530
Message-Id: <20230403171806.12805-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -WCGk4UhNoM6I7k5SnsvjfDeATYi9HEE
X-Proofpoint-ORIG-GUID: -WCGk4UhNoM6I7k5SnsvjfDeATYi9HEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_14,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=718 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030130
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthik M <quic_karm@quicinc.com>

During stress test with maximum VAPs and peer connected, below warning
is seen:

[ 1079.110967] ath12k_pci 0004:01:00.0: mgmt tx queue is full
[ 1079.117708] ath12k_pci 0004:01:00.0: failed to queue management frame -28
[ 1079.123191] ath12k_pci 0004:01:00.0: mgmt tx queue is full
[ 1079.129960] ath12k_pci 0004:01:00.0: failed to queue management frame -28
[ 1079.135641] ath12k_pci 0004:01:00.0: mgmt tx queue is full

This is caused by potential race condition while accessing skb_queue_len().
When ath12k_mgmt_over_wmi_tx_work() and ath12k_mac_mgmt_tx() is called concurrently,
then skb_queue_len() might fetch list length which is modified by skb_queue_tail()
or skb_dequeue().

Replace skb_queue_len() with skb_queue_len_lockless() which will
prevent concurrent modified access using READ_ONCE(). And also use '>=',
in case we queue a few SKBs simultaneously.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthik M <quic_karm@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0e5cc477ba56..cc458fed5e78 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4489,7 +4489,7 @@ static int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
 		return -ENOSPC;
 	}
 
-	if (skb_queue_len(q) == ATH12K_TX_MGMT_NUM_PENDING_MAX) {
+	if (skb_queue_len_lockless(q) >= ATH12K_TX_MGMT_NUM_PENDING_MAX) {
 		ath12k_warn(ar->ab, "mgmt tx queue is full\n");
 		return -ENOSPC;
 	}
-- 
2.17.1

