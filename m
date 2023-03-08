Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673056B1063
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCHRrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 12:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHRrW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 12:47:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69A25E0C
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 09:47:21 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328FppDB025718;
        Wed, 8 Mar 2023 17:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VrPTUXeRxpjx48Cu+QwL/LBYT0vzLDXbb6DdPuMN5mc=;
 b=HLl7T561Y6nXVy29QdkfFytxPf7vdjvkCWn2uxL97BllKebj6nSPyvcICL+k5G+3Pa9i
 JgFpsdUnCTE14+uqtKDjQHwi3bLvpipQKOSBe/ubBbMX/KoC4iqZK0ycxJt+CIUc3KuQ
 mq1OlytgJ9WW2Rr8nEgamsr8Y12O9zQaEKBXHI9UMzx6dBhHYltRJ+V2q9wn4okiDojL
 zO8JBG11pMq4SQlsOP+mhqpvoAhLQ2eQF+0BoHeRP9VfyKL7EfMsO8lH3X6ibY5fpDxd
 DldXKOiim42Xuo4J9cA9JX/k3OYs7D0aTL9UphrkP62r16O2Rh2lOBnAw1CcWM0OgZ/8 +Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6wcmg9u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 17:47:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328HlERv017743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 17:47:14 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 09:47:13 -0800
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: Fix incorrect update of BCC counters in peer stats
Date:   Wed, 8 Mar 2023 09:47:03 -0800
Message-ID: <20230308174703.12270-3-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
References: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8BvpquOoC63xXmv2jUPGVgqHtr4c-hXC
X-Proofpoint-ORIG-GUID: 8BvpquOoC63xXmv2jUPGVgqHtr4c-hXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_11,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080152
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix typos causing incorrect update of BCC counters in 11ax mode.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal_rx.c | 4 ++--
 drivers/net/wireless/ath/ath11k/hal_rx.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 7f39c6fb7408..d462b36c3cb2 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1023,7 +1023,7 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		info1 = __le32_to_cpu(vht_sig->info1);
 
 		ppdu_info->ldpc = FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING,
-					    info0);
+					    info1);
 		ppdu_info->mcs = FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO1_MCS,
 					   info1);
 		gi_setting = FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO1_GI_SETTING,
@@ -1446,7 +1446,7 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		 * PHYRX_OTHER_RECEIVE_INFO TLV.
 		 */
 		ppdu_info->rssi_comb =
-			FIELD_GET(HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB,
+			FIELD_GET(HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RSSI_COMB,
 				  __le32_to_cpu(rssi->info0));
 
 		if (db2dbm) {
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index f6bae07abfd3..064796935f9c 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -385,7 +385,7 @@ struct hal_rx_he_sig_b2_ofdma_info {
 	__le32 info0;
 } __packed;
 
-#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB	GENMASK(15, 8)
+#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RSSI_COMB	GENMASK(15, 8)
 
 #define HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20	GENMASK(7, 0)
 
-- 
2.17.1

