Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACB6E76F1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjDSJ7O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 05:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjDSJ7L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 05:59:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2358814453
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 02:58:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J9WIfE032428;
        Wed, 19 Apr 2023 09:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=nraxzcYXsGeNLGsYi+VqecXFFW2kNnGQ85j73xb3WM8=;
 b=I3Vs45kiuC0M/ioBq5SixBuCR6+stWyNfVQ5N6ZH5tjZ1DkXldpHb4q3fPyCMsCIkFNw
 8tmR5s0Pzpw3pjQKGFsNix7O52wwUNc5sgFecHi8g+HReLLJLEDCKQi+aQ3FMCApAmY8
 swQBOzhTOOl5QZNZ6XKdNAsjvzzyrhYSJbZRM8mAjQ9+GGcn/YK+cd36Wj0rubOh6qrv
 Uzm9HKd8D9HruOD1KrEsOJR8CXWc7OGBQFqC2AjTZyRnmJ3yCg/F91WrlA/6juS2O+hT
 6kgZ/T8b7jxqLEko7CvfJ/Sxrzxy9MXTmDbCff+4O0ezJhPp5qa5aYJjakKZoPa7/Cz+ YQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q292h8mdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 09:58:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33J9w1fE016973;
        Wed, 19 Apr 2023 09:58:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3pyn0kf1pq-1;
        Wed, 19 Apr 2023 09:58:01 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33J9w0Qc016964;
        Wed, 19 Apr 2023 09:58:00 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33J9w0tD016960;
        Wed, 19 Apr 2023 09:58:00 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id D8AFD1100068; Wed, 19 Apr 2023 15:27:59 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: fix potential wmi_mgmt_tx_queue race condition
Date:   Wed, 19 Apr 2023 15:27:58 +0530
Message-Id: <20230419095758.19998-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EoJPcOCfLn77mnG_llHgkue4PlI0t1X0
X-Proofpoint-GUID: EoJPcOCfLn77mnG_llHgkue4PlI0t1X0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_05,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=708 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190086
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
---
v2:
    - Corrected patch format
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

