Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509076CB7BD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC1HMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1HMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:12:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142AA1BE4
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:12:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6XjKa014868;
        Tue, 28 Mar 2023 07:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=4qsfF7Si0E9VXY3AGa3sbwb6eomXilHPwlzZsE98B6w=;
 b=CiRD+GKOYs8+z8ojkrLnggcqyXVzChCcEW7I2ReT+X1MVg+30stLDEoX6Hitzl1t2TgH
 tCPPww2EdLvTAI8Um4iOTLv7K0sw9Edq6BaD5jG/1v4XVa6ILZhsHUaJgxXU2GL18trD
 8TRGDOQ5XqDLaxAbCKoaAeQUn9PvRw1thCgCP7zyqMYkVp1HiCPBcvJNY3C+TUg0UUW6
 IfeftgTmU4mq5Y3sidQNWfcpFQ53Y8a5oS/mAD/NdZ83yhY1L1Jqd9enZOp4kDzt1t4/
 oD8cAKkkKJcbTDp70JGjHCZHE+rRcFQq4xHraDsB6qHJIJCeCduabYuugVQJ2vPTpTzR 8Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkcm2t7g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 07:12:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S7C8cE016332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 07:12:08 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 00:12:06 -0700
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH] wifi: ath11k: Disable Spectral scan upon removing interface
Date:   Tue, 28 Mar 2023 12:41:50 +0530
Message-ID: <20230328071150.29645-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pc1UPArUCbp6Q0143cVZ4FakS75Df3bh
X-Proofpoint-GUID: pc1UPArUCbp6Q0143cVZ4FakS75Df3bh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=777 bulkscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280058
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host might receive spectral events during interface
down sequence and this might create below errors.

failed to handle dma buf release event -22
failed to handle dma buf release event -22

Fix this by disabling spectral config during remove interface.

Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cad832e0e6b8..3ce6075af5dd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6652,6 +6652,11 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
+	ret = ath11k_spectral_vif_stop(arvif);
+	if (ret)
+		ath11k_warn(ab, "failed to stop spectral for vdev %i: %d\n",
+			    arvif->vdev_id, ret);
+
 	if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
 		ath11k_mac_11d_scan_stop(ar);
 

base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.17.1

