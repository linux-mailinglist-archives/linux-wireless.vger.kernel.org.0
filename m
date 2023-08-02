Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584D76C8E0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 11:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjHBJAA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHBI76 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 04:59:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738EC2704
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 01:59:57 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3723ooRO003360;
        Wed, 2 Aug 2023 08:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=BPNj3WBwZPid6XX1bIT2mYw1j4mY+nQIjFgJv4VMRrM=;
 b=CEPFZ0K5STQif94eiC04YvHSbgO2ZZWbHjEwQ0CKaQZavdCJzRndW7x0DIPurzwQD+SS
 F+No4lesbqX5RraKOZs7cAXVdMVV/0v0fiM9XDghBCC+n1PUoSDF+rJfuZYL2CXXL1+c
 rx5o0I70rbocu/+hN6AbzNsEh2V6Sqk4WLo5rKYwi6dkX6GScNlZQtbT5e48KV0KkEXy
 G2zbK2iJgbI3G813ltOcWvBB79cuxrvHzv+seMQQW90ZZWhC0vPsBedHyIVe+KaylgS+
 qM9DW0Yxaf1Fk4aeiohPbVenis/U1nIHiDPkLIMmfWbu/Ficg/LRXE2VNSsa1lm9czHC eQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75dg9xg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:59:54 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3728xqTe024024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:59:52 GMT
Received: from mdharane-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 01:59:51 -0700
From:   Manish Dharanenthiran <quic_mdharane@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran <quic_mdharane@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: fix WARN_ON during ath12k_mac_update_vif_chan
Date:   Wed, 2 Aug 2023 14:28:51 +0530
Message-ID: <20230802085852.19821-2-quic_mdharane@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802085852.19821-1-quic_mdharane@quicinc.com>
References: <20230802085852.19821-1-quic_mdharane@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TotQ17KKdDHu1EaQV0ImR8RioII7V87K
X-Proofpoint-ORIG-GUID: TotQ17KKdDHu1EaQV0ImR8RioII7V87K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=776 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix WARN_ON() from ath12k_mac_update_vif_chan() if vdev is not up.
Since change_chanctx can be called even before vdev_up.

Do vdev stop followed by a vdev start in case of vdev is down.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1bb9802ef569..0ab95e138d1d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5698,13 +5698,28 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		if (WARN_ON(!arvif->is_started))
 			continue;
 
-		if (WARN_ON(!arvif->is_up))
-			continue;
+		/* Firmware expect vdev_restart only if vdev is up.
+		 * If vdev is down then it expect vdev_stop->vdev_start.
+		 */
+		if (arvif->is_up) {
+			ret = ath12k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
+			if (ret) {
+				ath12k_warn(ab, "failed to restart vdev %d: %d\n",
+					    arvif->vdev_id, ret);
+				continue;
+			}
+		} else {
+			ret = ath12k_mac_vdev_stop(arvif);
+			if (ret) {
+				ath12k_warn(ab, "failed to stop vdev %d: %d\n",
+					    arvif->vdev_id, ret);
+				continue;
+			}
 
-		ret = ath12k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
-		if (ret) {
-			ath12k_warn(ab, "failed to restart vdev %d: %d\n",
-				    arvif->vdev_id, ret);
+			ret = ath12k_mac_vdev_start(arvif, &vifs[i].new_ctx->def);
+			if (ret)
+				ath12k_warn(ab, "failed to start vdev %d: %d\n",
+					    arvif->vdev_id, ret);
 			continue;
 		}
 
-- 
2.17.1

