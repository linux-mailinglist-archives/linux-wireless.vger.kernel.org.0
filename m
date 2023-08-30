Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9AD78E091
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbjH3UZh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbjH3UZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 16:25:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1493019E
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 12:47:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UGdJop010523;
        Wed, 30 Aug 2023 19:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=V3ZqCuKCyuAfBLwifHHJpScX9Qr85Utyh9yk4Xoaefg=;
 b=XlSY4Dd13BQhntBpS/sz2vkp+UhYLv/qw0hYBm7UNx2RXSl9QW3KmQ3mCI73RjOTErAL
 1uL9f85/TZR7Yri/bR4VuhxSvmswZMbIz5+ZDHQJa9sEaWz85WUGsk0EuAqTvgTCW0L5
 HHyOh75PH4eLVugogduNQKE9LFfdPPT81yucXxyIgQqWwkyOWXufnN+wZhfzvtL7aF0N
 FEco8TzV3JmriDD63a2Qy3jufQgo4Y8ES47cTIuUI80JEEsLejELzM8J1iRcrcSg5iBw
 PkDbTJ6aB3Y0RIJh7zrRWTa7dR4AFFxpA+Kly04QYJX4ayK5dNlUGOl2msAvuKNhnScc wA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sswbv1pbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 19:46:32 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37UJkJtm012562;
        Wed, 30 Aug 2023 19:46:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3sqafmkk3b-1;
        Wed, 30 Aug 2023 19:46:19 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UJkJLa012557;
        Wed, 30 Aug 2023 19:46:19 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-sidhanta-lv.qualcomm.com [10.47.205.116])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 37UJkJwY012555;
        Wed, 30 Aug 2023 19:46:19 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 4194996)
        id 0A376500193; Wed, 30 Aug 2023 12:46:19 -0700 (PDT)
From:   Sidhanta Sahu <quic_sidhanta@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sidhanta Sahu <quic_sidhanta@quicinc.com>
Subject: [PATCH] wifi: ath12k: Set default beacon mode to burst mode
Date:   Wed, 30 Aug 2023 12:46:17 -0700
Message-Id: <20230830194617.26400-1-quic_sidhanta@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U7ow81VEntAqphrPZhwIAXCyqbGXebUy
X-Proofpoint-GUID: U7ow81VEntAqphrPZhwIAXCyqbGXebUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 mlxlogscore=854 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300179
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, firmware does not like when beacon mode is set as staggered
mode for more than one beaconing vifs. Beacon mode for multiple
beaconing (transmitted) vifs are expected to be in burst mode. So set
beacon mode to burst mode by default.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1bb9802ef569..b16cbc3c906d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2314,7 +2314,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_BEACON) {
 		param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
-		param_value = WMI_BEACON_STAGGERED_MODE;
+		param_value = WMI_BEACON_BURST_MODE;
 		ret = ath12k_wmi_pdev_set_param(ar, param_id,
 						param_value, ar->pdev->pdev_id);
 		if (ret)
-- 
2.17.1

