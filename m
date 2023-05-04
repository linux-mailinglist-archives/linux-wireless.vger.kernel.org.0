Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA006F6832
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjEDJVB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEDJVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 05:21:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D646449E
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 02:20:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34497sKx000414;
        Thu, 4 May 2023 09:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=2e9mKpX4jquIFxWiRs9n/qDHwhzSNlck3zRP6DvuIoc=;
 b=WnM3xQ/cH0LkDgZ7k7+2DkKpfrhJZS6yyoX/a31/hPLH28TK6QBLYzswnTyFF/jNOmvC
 kKLgg6U9/kqGJoGXoSHqQxlF39QzkLlS0hPLPNxyOt24Pabx8vC+SJ4zdgQoyHW7/8Y2
 wSQaJCEej/yTaXw0el3t490By2bxqvQ6yS7cHibdIW5tGV55LtEysBRkL30ODYUrKqWY
 iNtb7e82QmtCOxuAi+HaG3YhTuQu052ScNkyGkdHK6EPJYQVjszfibvSf+aU5vJRfVK+
 d/t6kGLq9WE2Pmxu2HA65wcuExQIij+vX9532f3JbaXITCZpVnX1jaPdJEgYq6uF9wj0 7g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc5bn0j1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:20:54 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3449Kriu022279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 09:20:53 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 May 2023 02:20:51 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH 1/2] ath11k: Relocate the func ath11k_mac_bitrate_mask_num_ht_rates() and change hweight16 to hweight8
Date:   Thu, 4 May 2023 14:50:32 +0530
Message-ID: <20230504092033.3542456-2-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pavVAVGN60JuqkSSa6_PBjm4uFUM4w9R
X-Proofpoint-GUID: pavVAVGN60JuqkSSa6_PBjm4uFUM4w9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=525 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Relocate the function ath11k_mac_bitrate_mask_num_ht_rates() definition
to call this function from other functions which helps to avoid the
compilation error (function not defined).

ht_mcs[] is 1 byte array and it is enough to use hweight8() instead
of hweight16(). Hence, fixed the same.

Tested on: Compile tested only.

Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 30 +++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 05920ad413c5..eb46d06272de 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -4159,6 +4159,20 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	return ret;
 }
 
+static int
+ath11k_mac_bitrate_mask_num_ht_rates(struct ath11k *ar,
+				     enum nl80211_band band,
+				     const struct cfg80211_bitrate_mask *mask)
+{
+	int num_rates = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
+		num_rates += hweight8(mask->control[band].ht_mcs[i]);
+
+	return num_rates;
+}
+
 static int
 ath11k_mac_bitrate_mask_num_vht_rates(struct ath11k *ar,
 				      enum nl80211_band band,
@@ -7542,20 +7556,6 @@ static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 	ath11k_mac_flush_tx_complete(ar);
 }
 
-static int
-ath11k_mac_bitrate_mask_num_ht_rates(struct ath11k *ar,
-				     enum nl80211_band band,
-				     const struct cfg80211_bitrate_mask *mask)
-{
-	int num_rates = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
-		num_rates += hweight16(mask->control[band].ht_mcs[i]);
-
-	return num_rates;
-}
-
 static bool
 ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
 				  enum nl80211_band band,
-- 
2.25.1

