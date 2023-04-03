Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC936D50E2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjDCSnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjDCSm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 14:42:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC5C12C
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 11:42:57 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3339l7aE010661;
        Mon, 3 Apr 2023 18:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=8/uHOvOozLT15jPkmcmF+4CrH3FLHEOuYWd0aFeryP4=;
 b=FKN951+BQrDnm6PnuE3wUGEIjwbhbiJCOtLqNT0oKuvZvYKkNuDX3ir41GNIDTrwNdTP
 4vSUKFTGJM5PXS+t3N5G0x9rDXSJV7A2UO+7E5C0Lho5XpQ+GfKpJ6NNC6JG7gaTV89x
 WfQRX1Z8fjC5DK+JOHClc9lp9Aq0W70vpaaylSn13Tp16JRo9aZ3gykG036/OVeoQi5l
 foqYSudSDzUORWEMKUD+hS1qrCcBo6RGgnHsXVzLfgnTB2grFeXInbbaz1sycFBdfhPo
 wJ12JUJNKplReIldIWMWfQeMXb0Q+B4M/AjcCaRH8vvU+JWJLzFbEvvrWpqd2yhhZNTx 6A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqtdn9m00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:42:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333IgraO023231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 18:42:53 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 11:42:51 -0700
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: fix undefined behavior with __fls in dp
Date:   Tue, 4 Apr 2023 00:11:55 +0530
Message-ID: <20230403184155.8670-3-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403184155.8670-1-quic_nmaran@quicinc.com>
References: <20230403184155.8670-1-quic_nmaran@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -vfwyMp5f6HpJRGuM4WFKDQPClR08rhw
X-Proofpoint-GUID: -vfwyMp5f6HpJRGuM4WFKDQPClR08rhw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030143
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Harshitha Prem <quic_hprem@quicinc.com>

"__fls" would have an undefined behavior if the argument is passed
as "0". Hence, added changes to handle the same.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 2893f6757e3e..384a774392e0 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3595,7 +3595,7 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 		goto out_unlock;
 	}
 
-	if (frag_no > __fls(rx_tid->rx_frag_bitmap))
+	if (!rx_tid->rx_frag_bitmap || (frag_no > __fls(rx_tid->rx_frag_bitmap)))
 		__skb_queue_tail(&rx_tid->rx_frags, msdu);
 	else
 		ath11k_dp_rx_h_sort_frags(ar, &rx_tid->rx_frags, msdu);
-- 
2.17.1

