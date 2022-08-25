Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648CE5A0EDC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiHYLSx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 07:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbiHYLSv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 07:18:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF9AEDAB
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 04:18:50 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P7M4F4008784;
        Thu, 25 Aug 2022 11:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VrnuQVlvW0eBSZPhY7alecQe/5kRTJKdZyTh53QQ2/Y=;
 b=bDnwNc5cOFJLXTZOloO+bDOvKXQfkQeWow60mk9VUjclRHEGdVOCnYAnKeKk2dUsE7cc
 B5glOC2zxvy5Y0TTzcHsCSf/idl7Zuc8TDGfPusSASo+lJrwlkK9XxXMdEMUAAOmpsXr
 yMrqTSOH5HyKaePasNeHCc8/lHUVUednzujIAW/VutWBH5oY6sdU2F9r8xbrgC4fhrFt
 Q17R++AfBqYYBTf0THGOLqCBipfSadyjSPZ4d+o8ok/9oa62jZn9YfNlzcnKScCw1hXL
 DiWlSezeCbM9tND2xOgFxdJWG0OPGq2Oy47vU7m7UIDCjGl/TrYMKVYkB3G0eN0e673H Fw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j64mm8q1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PBIcMN017263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:38 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 25 Aug 2022 04:18:36 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 1/4] ath11k: Fix double free issue during SRNG deinit
Date:   Thu, 25 Aug 2022 16:48:15 +0530
Message-ID: <20220825111818.30869-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
References: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KTCqRjw6hJ-Q9qqKs5c9E5XW34K4WCz8
X-Proofpoint-ORIG-GUID: KTCqRjw6hJ-Q9qqKs5c9E5XW34K4WCz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=747
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently struct ath11k_hal::srng_config pointer is not assigned
to NULL after freeing the memory in ath11k_hal_srng_deinit().
This could lead to double free issue in a scerario where
ath11k_hal_srng_deinit() is invoked back to back.

In the current code, although the chances are very low, the above
said scenario could happen when hardware recovery has failed and
then there is another FW assert where ath11k_hal_srng_deinit() is
invoked once again as part of recovery. Addressing this issue is
important when low power mode support is enabled in the driver
(will be added by a future patch) where this scenario is likely.

Fix this by assigning the struct ath11k_hal::srng_config pointer
to NULL after freeing the memory.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index bda71ab5a1f2..ebdf3b1a6661 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1319,6 +1319,7 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 	ath11k_hal_free_cont_rdp(ab);
 	ath11k_hal_free_cont_wrp(ab);
 	kfree(hal->srng_config);
+	hal->srng_config = NULL;
 }
 EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
-- 
2.37.1

