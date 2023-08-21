Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42A27829DE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjHUND6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjHUND5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 09:03:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFBD1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 06:03:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LCemQb008796;
        Mon, 21 Aug 2023 13:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=uyXGncq/f4hBvQS8lwFth4qDyrZodq82lpuqhWakyiY=;
 b=QaEAZxAfID71Z7vzmpEhvb9rQRMmg+weUg2Bxva24N0glQDmuLA4nVwmDfutPsm+v2bv
 VDAaKaUTYfejq+vQAP8t+5zxSF8lD9OeOUIKQ6ydChxwhroBv7yfoH7pJl+4JyBrIOLk
 EUwr6UEaA6ZgzM4nuHRqQlEhoB5UbwuULgfFBRWnnvTyyiYU8H3MGFoHzUovOzg2v2r9
 hSRf0soGDMjDOryiSyJQMpqBHyXgEHunhD+Kf/LHNG+kYDUt5MrvwMV/BHiIK0l/w33P
 XhmULHgGk+JNDWwQFuo0+mEtqg+qclQOxLL2y4lJSW2wi138jekK7KF3uVTnvf6yY9AB nA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjken40fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 13:03:49 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37LCwY4I010711;
        Mon, 21 Aug 2023 13:03:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3sm5yq1bs4-1;
        Mon, 21 Aug 2023 13:03:48 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LD3mgl018225;
        Mon, 21 Aug 2023 13:03:48 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 37LD3l33018213;
        Mon, 21 Aug 2023 13:03:48 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id D1C14B003AB; Mon, 21 Aug 2023 18:33:46 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath12k: fix undefined behavior with __fls in dp
Date:   Mon, 21 Aug 2023 18:33:43 +0530
Message-Id: <20230821130343.29495-3-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821130343.29495-1-quic_hprem@quicinc.com>
References: <20230821130343.29495-1-quic_hprem@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0j6cMiPrREydGKQBtv6_vK4IgBqInMbC
X-Proofpoint-GUID: 0j6cMiPrREydGKQBtv6_vK4IgBqInMbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210120
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When max virtual ap interfaces are configured in all the bands
with ACS and hostapd restart is done every 60s,
a crash is observed at random times because of handling the
uninitialized peer fragments with fragment id of packet as 0.

"__fls" would have an undefined behavior if the argument is passed
as "0". Hence, added changes to handle the same.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 5923c7c9eaff..ea8dfea22be6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3238,7 +3238,7 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 		goto out_unlock;
 	}
 
-	if (frag_no > __fls(rx_tid->rx_frag_bitmap))
+	if ((!rx_tid->rx_frag_bitmap || frag_no > __fls(rx_tid->rx_frag_bitmap)))
 		__skb_queue_tail(&rx_tid->rx_frags, msdu);
 	else
 		ath12k_dp_rx_h_sort_frags(ab, &rx_tid->rx_frags, msdu);
-- 
2.17.1

