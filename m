Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39666D503C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjDCSZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjDCSYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 14:24:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C630E1
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 11:24:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333BljHN014926;
        Mon, 3 Apr 2023 18:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=A5APZ+Xhfly3fRRj86i2YSPpoV7OZRDxHqxy76ekAzY=;
 b=fJ/5zIxgoocay255V1HxSVLmyr+hBQoHb2oVqVqr0QAyCe3IRqEDzY9nw8zZ9Ttn8K5Y
 dsHJFvgscSoHuJqRR83hL62EhG3TjsAWUCYuLyrqVJkhS0rsUjIqfyGvkUoQ1q9PEm5R
 cVT9irgpxnyI37aN5DhdnOFZSR+0d8C9T8z9x7sOI0Evg4KbTRjrPVUd3VSb5Pn9FxpB
 VGRncXXrCj9rnwqYrZ5MipHMWk6i5bjQzPZYcYOfhc3e5kERdpTFd1vXD97EuVUHseB/
 i7HzPo98UqLzp+ZUqnYahXiqzY82BIn7BEHNZcVqD8hj53T1Sd+hlOEZFUuIEg6VOPd6 jw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqw36s5ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:24:29 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 333ILFSw029565;
        Mon, 3 Apr 2023 18:24:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3pr09uajn4-1;
        Mon, 03 Apr 2023 18:24:28 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 333INHIm000475;
        Mon, 3 Apr 2023 18:24:28 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 333IORl4002480;
        Mon, 03 Apr 2023 18:24:28 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 7F31BB003D4; Mon,  3 Apr 2023 23:54:26 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH 2/3] wifi: ath11k: Prevent REO cmd failures
Date:   Mon,  3 Apr 2023 23:54:19 +0530
Message-Id: <20230403182420.23375-3-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403182420.23375-1-quic_hprem@quicinc.com>
References: <20230403182420.23375-1-quic_hprem@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B8wiHBQVMUedvF4CQjAUXXtk27yEkRw3
X-Proofpoint-GUID: B8wiHBQVMUedvF4CQjAUXXtk27yEkRw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030141
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prevent REO cmd failures causing double free by increasing REO cmd
ring size and moving REO status ring mask to IRQ group 3 from group
0 to separate from tx completion ring on IRQ group 0 which may delay
reo status processing.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp.h | 2 +-
 drivers/net/wireless/ath/ath11k/hw.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index be9eafc872b3..6022e27ba91d 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -214,7 +214,7 @@ struct ath11k_pdev_dp {
 #define DP_REO_REINJECT_RING_SIZE	32
 #define DP_RX_RELEASE_RING_SIZE		1024
 #define DP_REO_EXCEPTION_RING_SIZE	128
-#define DP_REO_CMD_RING_SIZE		128
+#define DP_REO_CMD_RING_SIZE		256
 #define DP_REO_STATUS_RING_SIZE		2048
 #define DP_RXDMA_BUF_RING_SIZE		4096
 #define DP_RXDMA_REFILL_RING_SIZE	2048
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 60ac215e0678..9a12cc955fa1 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1224,6 +1224,7 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074 = {
 		ATH11K_RX_WBM_REL_RING_MASK_0,
 	},
 	.reo_status = {
+		0, 0, 0,
 		ATH11K_REO_STATUS_RING_MASK_0,
 	},
 	.rxdma2host = {
-- 
2.17.1

