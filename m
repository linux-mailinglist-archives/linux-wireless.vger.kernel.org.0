Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AB5F9730
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJJDdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 23:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJDdA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 23:33:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100DA1B785
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 20:32:56 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A3C3nq000533;
        Mon, 10 Oct 2022 03:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Qb8Uz92RvqxoZ/U5HyycwC7Sm1QLXoJ+L6oWadr4khM=;
 b=DMSse3DLb8N7O/FoQR8kfcMX3y80ASnTVax6S4zc5PzXg+c9hilTugeXwqrr2LmqCbqm
 y/aGMScejJ/TFx1VePoI8z4LTNfRuG9O5Vr8tHkRNCFUl7pmXOjBzltVG/A2roOnWf7g
 pDPzF6bsbAnjjupZAalpb+1V7CFTgrwL1BrswZujIuGxR/rj3G4/qp+KeQFkkebgYYmA
 iqL0gcOgvQLkXvIevcqaQZk+08OLU1c6S+0KeYaSCpiE6KBTVtaF4vQRLlmD4i305Kwr
 0vPv2IXYqiG4k1tPu2+WwSmNljC1zRyQAsUpNYrHP91RLYo26WtYQjFvkmy8wtmqq6OA WQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k32gek3us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 03:32:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29A3WlZL018699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 03:32:47 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 9 Oct 2022 20:32:46 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath11k: Send PME message during wakeup from D3cold
Date:   Mon, 10 Oct 2022 11:32:37 +0800
Message-ID: <20221010033237.415478-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YOHyZI4rP-KocY1uVukdU862mGBPuHHy
X-Proofpoint-ORIG-GUID: YOHyZI4rP-KocY1uVukdU862mGBPuHHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are seeing system stuck on some specific platforms due to
WLAN chip fails to wakeup from D3cold state.

With this flag, firmware will send PME message during wakeup
and this issue is gone.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 84e3abecbdac..145f20a681bd 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -19,6 +19,7 @@
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
 #define PLATFORM_CAP_PCIE_GLOBAL_RESET	0x08
+#define PLATFORM_CAP_PCIE_PME_D3COLD	0x10
 
 #define FW_BUILD_ID_MASK "QC_IMAGE_VERSION_STRING="
 
@@ -1752,6 +1753,8 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 	if (ab->hw_params.global_reset)
 		req.nm_modem |= PLATFORM_CAP_PCIE_GLOBAL_RESET;
 
+	req.nm_modem |= PLATFORM_CAP_PCIE_PME_D3COLD;
+
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi host cap request\n");
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,

base-commit: 023baf1318ef21442fab3842bf03883bc81223e0
-- 
2.25.1

