Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F026C0CB7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCTJEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 05:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCTJEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 05:04:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726C0E3B6
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 02:04:10 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8Oiuk011611;
        Mon, 20 Mar 2023 09:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=qX1zSXC14jS26upULSeJeN1INE+4o0vg26j8+oy9NzE=;
 b=KRx7YV6NMdb1l44Q7+vUL4QfhSZp1G+AG7FRZle+Nd173Aj9c0zRetgS769vR7DW4r+Y
 meT0UM/bQPl/bOh1ltZRr9zNfFOuEvvLJ/vOs1X5OJp+Mdyyikrgbdz2CpZlNEzoYndN
 POuuOzLI6HafMWml8NsE6SX9ZKPLUmeH5vrMPvxmi/F9p+jgUuqTvU5NPCwF+uPo9GQD
 LgmFyGqIOsLilFxE6exiUFBUPtCqrk3YIp/ddEDbeCXikdjj1RnkCmkflyQGxKOtqGF0
 JdoelCXffjvzBy2BpRItVucM+h/9bUDYkbszib7SLPITT9a2fFK0+3PKYXQZwnPmE72j Jg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pd2nv4n63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 09:04:06 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32K945v1012788;
        Mon, 20 Mar 2023 09:04:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3pe2d4j031-1;
        Mon, 20 Mar 2023 09:04:05 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32K944lA012783;
        Mon, 20 Mar 2023 09:04:05 GMT
Received: from hprem-linux.qualcomm.com (hprem-linux.qualcomm.com [10.201.162.248])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 32K944Kn012772;
        Mon, 20 Mar 2023 09:04:04 +0000
Received: by hprem-linux.qualcomm.com (Postfix, from userid 4146166)
        id 92EC6B003A2; Mon, 20 Mar 2023 14:34:02 +0530 (IST)
From:   Harshitha Prem <quic_hprem@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix incorrect handling of AMSDU frames
Date:   Mon, 20 Mar 2023 14:34:00 +0530
Message-Id: <20230320090400.30027-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jKH19elZ_wcSU3EvKJJFqEeNfAljEiFt
X-Proofpoint-GUID: jKH19elZ_wcSU3EvKJJFqEeNfAljEiFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=809 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200075
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a data traffic with size greater than 1500 is initiated,
say size 65500, it is sent as a set of AMSDUs (3 MSDUs)
in a MPDU.

These AMSDUs are incorrectly classified as multicast
and peer id gets changed, except for first msdu,
because of mcast_bcast bit derived from rx_desc
for every msdu received.

The mcast_bcast bit in rx_desc is only valid for
first msdu. Hence, add changes to derive mcast_bcast
only if it is a first msdu.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 0adcbcfa0db5..46ba6ea1a5b3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -196,7 +196,8 @@ static void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 static bool ath12k_dp_rx_h_is_mcbc(struct ath12k_base *ab,
 				   struct hal_rx_desc *desc)
 {
-	return ab->hw_params->hal_ops->rx_desc_is_mcbc(desc);
+	return (ath12k_dp_rx_h_first_msdu(ab, desc) &&
+		ab->hw_params->hal_ops->rx_desc_is_mcbc(desc));
 }
 
 static bool ath12k_dp_rxdesc_mac_addr2_valid(struct ath12k_base *ab,
-- 
2.17.1

