Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077F0755A2C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 05:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGQDpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 23:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGQDpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 23:45:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4D134
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 20:45:18 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H2EKDX028875;
        Mon, 17 Jul 2023 03:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4FcKocPxSjAm8i4HwSQrJeD5Kn+dKX2AlCl+DHVRGZI=;
 b=mcnLA4oi0A3ynFXAavUnVX7oUx4r7OomODpWTpN33Pecn+zfsEX5Kno4NUZlAQWmo83i
 UND270qxz+0+HjZoU/Ckrgg98bu40McC3SHL0bkwI6PM+7qrqBZ/r4qtl8C2wAf7dL8Z
 7mZOjx8h5h11MbTLtRRsMIuGD9HsawSe6CUmrhiNLsw4spXGpyzca31UPPYkebGA1tV6
 VFMIfDh0jJujx+PQZ2N/Nct/519twJDl5L3WJ1gU8hwrp+mNRqsyVo1BQnmcHHOJmUbL
 HxqZ3Iau8qVrdkqfq+iK94Evh9zZhRYWPX893EMxaui3Sp5/f9GFqI5oHk1qwcsFRRwZ VQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0etc43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 03:45:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H3jEVG016712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 03:45:14 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 20:45:13 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: add handler for scan event WMI_SCAN_EVENT_DEQUEUED
Date:   Sun, 16 Jul 2023 23:44:57 -0400
Message-ID: <20230717034457.22162-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AmiSgKBON0ZcbMtpVdW0peWhCn9AribJ
X-Proofpoint-ORIG-GUID: AmiSgKBON0ZcbMtpVdW0peWhCn9AribJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_03,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=761
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When wlan interface is up, and 11d scan is sent to the firmware, then
firmware needs to spend couple of seconds to complete the 11d scan. If
normal scan from user space arrives to ath12k at this moment, then the
normal scan request is also sent to the firmware, but the scan started
event will be reported to ath12k until the 11d scan complete. When timed
out for the scan started in ath12k, ath12k stops the normal scan and the
firmware reports WMI_SCAN_EVENT_DEQUEUED to ath12k for the normal scan.
ath12k has no handler for the event and then timed out for the scan
completed in ath12k_scan_stop(), and ath12k prints the following error
message.

[ 1491.604750] ath12k_pci 0000:02:00.0: failed to receive scan abort comple: timed out
[ 1491.604756] ath12k_pci 0000:02:00.0: failed to stop scan: -110
[ 1491.604758] ath12k_pci 0000:02:00.0: failed to start hw scan: -110

Add a handler for WMI_SCAN_EVENT_DEQUEUED and then complete the scan to
get rid of the above error message.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7ae0bb78b2b5..8329c1bcbb36 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5688,6 +5688,8 @@ static void ath12k_scan_event(struct ath12k_base *ab, struct sk_buff *skb)
 		ath12k_wmi_event_scan_start_failed(ar);
 		break;
 	case WMI_SCAN_EVENT_DEQUEUED:
+		__ath12k_mac_scan_finish(ar);
+		break;
 	case WMI_SCAN_EVENT_PREEMPTED:
 	case WMI_SCAN_EVENT_RESTARTED:
 	case WMI_SCAN_EVENT_FOREIGN_CHAN_EXIT:

base-commit: 0a00db612b6df1fad80485e3642529d1f28ea084
-- 
2.40.1

