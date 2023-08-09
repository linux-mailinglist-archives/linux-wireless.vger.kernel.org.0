Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D77751E9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 06:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHIE1w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 00:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjHIE1u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 00:27:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E81BD9
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 21:27:50 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3792hujW012267;
        Wed, 9 Aug 2023 04:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=QPsZKWKd0LivvISknRnHXiUVmi5rXSktn9Xo3buFCdg=;
 b=HMzcpLMmqdM5/1D4FT3XUHI1dEsso0dmocqbpfOjBbLKzkKPVVNkD1Cumc3ikPTtrnn/
 cGjmMmi/wVIeG0u0vyAwsPOzqI7qGLG6yxb/5E1H2TR0ZJQgZKOmpKCpXclq/T9DszVW
 Odu69RqDQA24gvS7ziVcnsz9x0dCrsa1FXtyRFlAou/ZgKGvPpnTjDXrCOezcgFes5Lg
 jVsIF7LxOwGVm8Vk8c1xaKEEk0r0MVJaRFXXLjy7Hz1Ixu0Y5W7/gOy5W9CNWUGjYjru
 Y2FMsl87EidNPp3UnfHWEMcXZRBlFVWHs5ALnSZiZe2D80FL0ubSL1djOkOSXSFtwX5S Vw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbmrqhtge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 04:27:45 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3794Ripq001627;
        Wed, 9 Aug 2023 04:27:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3sb7rw5a6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 09 Aug 2023 04:27:44 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3794Q7IB032352;
        Wed, 9 Aug 2023 04:27:44 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3794Rhbw001620;
        Wed, 09 Aug 2023 04:27:44 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 9F023B003AB; Wed,  9 Aug 2023 09:57:42 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: fix undefined behavior with __fls in dp
Date:   Wed,  9 Aug 2023 09:57:38 +0530
Message-Id: <20230809042738.13394-3-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230809042738.13394-1-quic_hprem@quicinc.com>
References: <20230809042738.13394-1-quic_hprem@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xV8-LCLUmznwn-DVmhxBtv1HDC9hX6-q
X-Proofpoint-ORIG-GUID: xV8-LCLUmznwn-DVmhxBtv1HDC9hX6-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_01,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090038
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When max virtual ap interfaces are configured in all the bands
with ACS and hostapd restart is done every 60s,
a crash is observed at random times because of handling the
uninitialized peer fragments.

During the crash, the fragment id of that packet was 0 and
__fls returned a junk value. Hence, it was identified that "__fls"
would have an undefined behavior if the argument is passed as "0".
Therefore, add changes to handle the same.

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

