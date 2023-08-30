Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2604778D1F2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbjH3CMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 22:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbjH3CLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 22:11:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2850D1AE
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 19:11:49 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U1Ubmu015968;
        Wed, 30 Aug 2023 02:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Duu9okkbYfP9xoqLhr72dovNWVSGEARPq0KAlwVjnu0=;
 b=Abqv0Rm+B9u1Nz7GgVAcV1i5AbvqsA4SDlQAlA/7uAjceQSJdmyf2S3R4MtvCHtf5SQo
 ww2LHOQ0CkE5LN6LGN0SteNedBOY6wb049VlvJ/Dhp8oCVNdZ6FH0QEZV71LzT/LODrO
 cEeIch4OwpdUUsDrjS6FqKTas/3GbmlrNVZLJ6UhroS/2WA0trB+T2NSMJxdfkBLWTj3
 DO4x95ZH3SmSAiLuH9m7eXQ1AEgJC66PVQfy+RNXqNgswmXuucXWPGsnkYwx3MqjZVPz
 AYE9do+nXYU6yLsTRBmZRs/RPZgG/TZ2U2ZeHxEZp9g/Aq26Ho3xMcUjq41YbAOoAVWN 5Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssv0y02ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 02:11:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U2BkhP030533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 02:11:46 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 19:11:44 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: fix DMA unmap warning on NULL DMA address
Date:   Wed, 30 Aug 2023 10:11:31 +0800
Message-ID: <20230830021131.5610-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aqECxv9xe0WoVowN3lVlxuWlFknInZkW
X-Proofpoint-ORIG-GUID: aqECxv9xe0WoVowN3lVlxuWlFknInZkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=650 suspectscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In ath12k_dp_tx(), if we reach fail_dma_unmap due to some errors,
current code does DMA unmap unconditionally on skb_cb->paddr_ext_desc.
However, skb_cb->paddr_ext_desc may be NULL and thus we get below
warning:

kernel: [ 8887.076212] WARNING: CPU: 3 PID: 0 at drivers/iommu/dma-iommu.c:1077 iommu_dma_unmap_page+0x79/0x90

Fix it by checking skb_cb->paddr_ext_desc before unmap it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 8874c815d7fa..c0ae2fd443cc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -330,8 +330,10 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 
 fail_unmap_dma:
 	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
-	dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-			 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+	if (skb_cb->paddr_ext_desc)
+		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+				 sizeof(struct hal_tx_msdu_ext_desc),
+				 DMA_TO_DEVICE);
 
 fail_remove_tx_buf:
 	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);

base-commit: a62b0aeb556839fb6abb9835874443b08fe95598
-- 
2.25.1

