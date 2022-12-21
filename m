Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC16653001
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiLUK4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 05:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiLUK4a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 05:56:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC617B71
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 02:56:29 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL63lUe016104;
        Wed, 21 Dec 2022 10:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+V7QXULflFlXLKTcvUar3DCET4UdTZ1AzZxVI39YnNM=;
 b=LvpB8F1Q1M29rIUu2Nt2YPzlcQ2TiGVZyDaMpPOccmqDOHwu7MmS3swPqzX6k/LiwOZ7
 PeLTXjNRzhi1ib8fJItT3N4Y3JPpZqkS6zNben9EeHv4nOoiDzBd6x3PLwvxeogUY1iA
 sdOBsWrpOlZ15+Z+65Bn5yVMlszUbsczo+6XNVI8Hf+ZUaiy2FW8MvpH4fgGw0BnuvUw
 w0HlTvGqbtZeelDhsSwxN8hgUx25X0K7rCSppll+u1KOMlXx59+WqWb3pDEjokfuwCPK
 KY13GdqBg3RES5iurMGsgvKoSldi/Rk4Dd9AMHuKktDZ+84SmSCEJ1ymoozxNUGHAIwv 4g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk83xu57v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:56:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLAuPQL007894
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:56:25 GMT
Received: from tmariyap-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 02:56:23 -0800
From:   Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: dp_mon: Fix uninitialized warning related to the pktlog
Date:   Wed, 21 Dec 2022 16:25:29 +0530
Message-ID: <20221221105529.19345-5-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221221105529.19345-1-quic_tmariyap@quicinc.com>
References: <20221221105529.19345-1-quic_tmariyap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OFls_oW5TAQYcxOPBLbgZOlo-iVZUvIq
X-Proofpoint-GUID: OFls_oW5TAQYcxOPBLbgZOlo-iVZUvIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_05,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=736
 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uninitialized warning in the code changes related to pktlog, which is not
completely supported in ath12k driver yet. Hence, remove the changes to
avoid the warning.

Warning:
drivers/net/wireless/ath/ath12k/dp_mon.c:2138:18: warning: variable 'rx_buf_sz' is uninitialized when used here [-Wuninitialized]

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f6f2e83f8f8e..a214797c96a2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2076,8 +2076,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
 	bool end_of_ppdu;
 	struct hal_rx_mon_ppdu_info *ppdu_info;
 	struct ath12k_peer *peer = NULL;
-	u32 rx_buf_sz;
-	u16 log_type = 0;
 
 	ppdu_info = &pmon->mon_ppdu_info;
 	memset(ppdu_info, 0, sizeof(*ppdu_info));
@@ -2133,10 +2131,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id, int *budget,
 		for (i = 0; i < dest_idx; i++) {
 			skb = pmon->dest_skb_q[i];
 
-			if (log_type)
-				trace_ath12k_htt_rxdesc(ar, skb->data,
-							log_type, rx_buf_sz);
-
 			if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
 				ath12k_dp_mon_rx_parse_mon_status(ar, pmon, mac_id,
 								  skb, napi);
-- 
2.17.1

