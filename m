Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B3793115
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjIEVlS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbjIEVlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 17:41:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12410F5
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 14:40:37 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385JPRwM022989;
        Tue, 5 Sep 2023 21:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=QLCZeJmP+8FVnWoQVzQw0ttWKSbb0QiAN1JR6PAmcaY=;
 b=TGEPrqNYUOdyNICjp1eUghxlQsj+HS8NU62Dv0Ch95+1YwR55rWy8qskEfhopkh+5pur
 c3x+FRrg/QvOQUXwx1RIKG2dG8l6ppBEvCu7rE4fQ5am3QsWwWqqy6xCx+1bg08ID2UE
 2p/KoYoUYv9xNuNtOuBpAMqfyu00/Oh1W2R2cBKTIie4t3mCYSxE0iv1K/jgg3TQY97O
 lXv7JHOdXVK16iW18q+CLQ25qC8ifylq+G+msBU0eXJxhLPSyfrzQVz5gXdvt2MpaAiL
 cKiMZHW6WSLfEC2WbLuGDt2TYxfLGqkst+ixJ6t1pvZjtuC3wUWQ08t9Fa//pYEHD5us Cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swsp5adgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 21:39:46 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 385LdjDO013914;
        Tue, 5 Sep 2023 21:39:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3sux4ky9ex-1;
        Tue, 05 Sep 2023 21:39:45 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385LcW7v013054;
        Tue, 5 Sep 2023 21:39:45 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-sidhanta-lv.qualcomm.com [10.47.205.116])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 385LdjJo013906;
        Tue, 05 Sep 2023 21:39:45 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 4194996)
        id D0F9450017D; Tue,  5 Sep 2023 14:39:44 -0700 (PDT)
From:   Sidhanta Sahu <quic_sidhanta@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sidhanta Sahu <quic_sidhanta@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Set default beacon mode to burst mode
Date:   Tue,  5 Sep 2023 14:39:43 -0700
Message-Id: <20230905213943.12275-1-quic_sidhanta@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z49P9fYDczGLLdPZd_iMiyaKiu6uwn4f
X-Proofpoint-GUID: z49P9fYDczGLLdPZd_iMiyaKiu6uwn4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=947 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050188
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
v2: Modified the debug log.

 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1bb9802ef569..d38b85eaed37 100644
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
@@ -2322,7 +2322,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 				    arvif->vdev_id);
 		else
 			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-				   "Set staggered beacon mode for VDEV: %d\n",
+				   "Set burst beacon mode for VDEV: %d\n",
 				   arvif->vdev_id);
 
 		ret = ath12k_mac_setup_bcn_tmpl(arvif);
-- 
2.17.1

