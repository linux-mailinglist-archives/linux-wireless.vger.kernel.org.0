Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602887862DC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 23:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbjHWV6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbjHWV63 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 17:58:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC71704
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 14:58:02 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NLSid7004131;
        Wed, 23 Aug 2023 21:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=YC0FQIaaJq6wBHQ+liLvMdix0QXJqySr7hAis/eVPBE=;
 b=J7fjnwbnir+N4C0ukr5BSfLzJy4OhBuHdRPnF15TmOaYf5j1VrkZrYRbAuDS0vWgQjrp
 rdewRv74EQS/jb9pJVxxHgKP4JP3XgWR8MXey3YF+hF6YGgrWknxugxIPeauTfBPTF9s
 yr39b6VSiXnYFtrSEGVOu9KA8nnsm9NGzBmkVfGJjVJPYBVCh7Prs/7JBv51+t1HWtdC
 9UZUO944MWBnqy5qote3wHs6J7hYPfYCuodozO8dLEARQfeIn5GMmj3nKno6ET0hfesA
 kJ5WOktleubJWveveD1Olcx8dDFnD5r3/eErkBzg+TBfroESC4g0VMzDGFrhYBfvBXqs ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn208k9c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 21:57:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NLvsJc003676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 21:57:54 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 23 Aug 2023 14:57:53 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 1/2] wifi: ath11k: move references from rsvd2 to info fields
Date:   Wed, 23 Aug 2023 14:57:47 -0700
Message-ID: <1692827868-15667-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ojU-fT47TBfq1ioAqDpPfqKRg93NiH5D
X-Proofpoint-ORIG-GUID: ojU-fT47TBfq1ioAqDpPfqKRg93NiH5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_15,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 bulkscore=0 impostorscore=0 mlxlogscore=907 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove references to reserved fields and add new info fields for
struct hal_rx_ppdu_end_user_stats. Reserved fields should not be
accessed, therefore existing references to it are to be changed to
referencing specific info fields.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal_rx.c | 10 +++++-----
 drivers/net/wireless/ath/ath11k/hal_rx.h | 11 ++++++++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index e5ed5efb139e..1103d922320e 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -814,7 +814,7 @@ ath11k_hal_rx_handle_ofdma_info(void *rx_tlv,
 
 	rx_user_status->ul_ofdma_user_v0_word0 = __le32_to_cpu(ppdu_end_user->info6);
 
-	rx_user_status->ul_ofdma_user_v0_word1 = __le32_to_cpu(ppdu_end_user->rsvd2[10]);
+	rx_user_status->ul_ofdma_user_v0_word1 = __le32_to_cpu(ppdu_end_user->info9);
 }
 
 static inline void
@@ -825,11 +825,11 @@ ath11k_hal_rx_populate_byte_count(void *rx_tlv, void *ppduinfo,
 		(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
 
 	rx_user_status->mpdu_ok_byte_count =
-		FIELD_GET(HAL_RX_PPDU_END_USER_STATS_RSVD2_6_MPDU_OK_BYTE_COUNT,
-			  __le32_to_cpu(ppdu_end_user->rsvd2[6]));
+		FIELD_GET(HAL_RX_PPDU_END_USER_STATS_INFO8_MPDU_OK_BYTE_COUNT,
+			  __le32_to_cpu(ppdu_end_user->info7));
 	rx_user_status->mpdu_err_byte_count =
-		FIELD_GET(HAL_RX_PPDU_END_USER_STATS_RSVD2_8_MPDU_ERR_BYTE_COUNT,
-			  __le32_to_cpu(ppdu_end_user->rsvd2[8]));
+		FIELD_GET(HAL_RX_PPDU_END_USER_STATS_INFO9_MPDU_ERR_BYTE_COUNT,
+			  __le32_to_cpu(ppdu_end_user->info8));
 }
 
 static inline void
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 61bd8416c4fd..833440df7d5c 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -222,8 +222,8 @@ struct hal_rx_ppdu_start {
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP		GENMASK(15, 0)
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_EOSP_BITMAP	GENMASK(31, 16)
 
-#define HAL_RX_PPDU_END_USER_STATS_RSVD2_6_MPDU_OK_BYTE_COUNT	GENMASK(24, 0)
-#define HAL_RX_PPDU_END_USER_STATS_RSVD2_8_MPDU_ERR_BYTE_COUNT	GENMASK(24, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO7_MPDU_OK_BYTE_COUNT	GENMASK(24, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO8_MPDU_ERR_BYTE_COUNT	GENMASK(24, 0)
 
 struct hal_rx_ppdu_end_user_stats {
 	__le32 rsvd0[2];
@@ -236,7 +236,12 @@ struct hal_rx_ppdu_end_user_stats {
 	__le32 info4;
 	__le32 info5;
 	__le32 info6;
-	__le32 rsvd2[11];
+	__le32 rsvd2[5];
+	__le32 info7;
+	__le32 rsvd3;
+	__le32 info8;
+	__le32 rsvd3[2];
+	__le32 info9;
 } __packed;
 
 struct hal_rx_ppdu_end_user_stats_ext {
-- 
2.7.4

