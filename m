Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1215F64BB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJFLAy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJFLAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:00:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05431642E
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:00:32 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296AqtKO031912;
        Thu, 6 Oct 2022 11:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=DWUH9uLqRl7NKbF5zKLbwmsWEM8k+wPwt9fNa1FuLYw=;
 b=hdqPjvS4SCXR5r4zCMlxRZTH7C7geZ4tkKXnn+QKxrsjTf0hj+0tuN+eXHLAqTtzWA6L
 6+bApAGOX5usqTtpO2+upyyJkzSYhmf9956/O1rRr8E/1tup6I6/2UQh6jGCqF1Eij1z
 lcLJ2b2bVP8Ynq2cvId4kM0SQ4/oUoVjp1VL6QiLLBTYM8MCZcNvSYew1pALvZWKgXUA
 vhbqyOC8U8MC6Vnk3SPPdF2cGivB34I53mBFbdyk+egSWdx9WuYTN+AEM55Xv71zaHPO
 pk7RrXU/CxcApcxtuv9QNeVG6DyquDx61heGCiiyDr0Bf/feQJsMjkfMc2T1cgbY7441 4Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k1wnbg0ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:00:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B0U6A004558
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:00:30 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 04:00:28 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 8/8] wifi: ath11k: add ipq5018 device support
Date:   Thu, 6 Oct 2022 16:29:13 +0530
Message-ID: <20221006105913.18356-9-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006105913.18356-1-quic_kathirve@quicinc.com>
References: <20221006105913.18356-1-quic_kathirve@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1j4CaEial8WTfpYWj7OSY9RhuvmdS3vo
X-Proofpoint-ORIG-GUID: 1j4CaEial8WTfpYWj7OSY9RhuvmdS3vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxlogscore=969 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ipq5018 is a ahb 2ghz device, enable the compatible support for
ipq5018 in ahb.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 231414e677b1..2bc45a7e51cb 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -32,6 +32,9 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 	{ .compatible = "qcom,wcn6750-wifi",
 	  .data = (void *)ATH11K_HW_WCN6750_HW10,
 	},
+	{ .compatible = "qcom,ipq5018-wifi",
+	  .data = (void *)ATH11K_HW_IPQ5018_HW10,
+	},
 	{ }
 };
 
-- 
2.38.0

