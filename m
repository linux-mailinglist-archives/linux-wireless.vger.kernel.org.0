Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F5D7EFFF9
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Nov 2023 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjKRNqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Nov 2023 08:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKRNqB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Nov 2023 08:46:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C5192
        for <linux-wireless@vger.kernel.org>; Sat, 18 Nov 2023 05:45:58 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIDNglw024419;
        Sat, 18 Nov 2023 13:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=WIVSHzPUMBSWfExEXnkw0x/d4wXX6rzRV/LMUplqz2Q=;
 b=cX2Ttyl+rJTFn8LIXjRK7qzN/+dtvN9Pta3O7JBoUmgH4SxPiOKaWdiV/CelJrun4Iv/
 2tDjgTko6lcqO6R66XQpDLMADpUdpe52VL41cCxriSbMX+bW271DwTh7iZES/bsaaF82
 hf8ApRg8WHAOi1qMBcjTeopn/L4JDU0VppMU1NGRHg5XI5OQkaXZSWBhrozxHEQikrUa
 hxXEIdshNZFRSfzC85g8+z11onbBqu8fnqLIEEVAwTIil4h4rpw4fpy72wfpS/tEbXSS
 9SViPvUGxkBCK8e0ZwiBRG/Y41j901kjnyXJGHsqS/vGfDZjJGUpeFqdpu0URRmg2YEn QA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uejymrrxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 13:45:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AIDjs6A003738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 13:45:54 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 18 Nov 2023 05:45:52 -0800
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <lingbok@qti.qualcomm.com>
Subject: [PATCH] wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850
Date:   Sat, 18 Nov 2023 08:45:38 -0500
Message-ID: <20231118134538.19545-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oGUf3sKjH1VxM0up2Jtl0Phu7BDusAqy
X-Proofpoint-ORIG-GUID: oGUf3sKjH1VxM0up2Jtl0Phu7BDusAqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=742 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We observe some packets are discarded in ieee80211_rx_handlers_result
function for WCN7850. This is because the way to get multicast/broadcast
indicator with RX_MSDU_END_INFO5_DA_IS_MCBC & info5 is incorrect. It should
use RX_MSDU_END_INFO13_MCAST_BCAST & info13 to get multicast/broadcast
indicator.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index eca86fc25a60..4966887e312b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -889,8 +889,8 @@ static u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le16_to_cpu(desc->u.wcn7850.msdu_end.info5) &
-	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+	return __le16_to_cpu(desc->u.wcn7850.msdu_end.info13) &
+	       RX_MSDU_END_INFO13_MCAST_BCAST;
 }
 
 static void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,

base-commit: 23c5ea6737e45d5a6342c21884400e7697d7c342
-- 
2.34.1

