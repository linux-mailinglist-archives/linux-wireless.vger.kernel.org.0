Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1809707AA4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 09:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjERHLd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 03:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjERHLb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 03:11:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE7E10F5
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 00:11:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I62vdN019512;
        Thu, 18 May 2023 07:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZinPou2T9xQpwT4erP6BXpnOW1UNrk9U8CX7R1n5reI=;
 b=mANCVbZa9Ij4oaDQl91yFnVL5UdRdECusbXLfrLxnpScKNuGjWU9juIk+zJ2NshRcWU6
 q8ubVjowutMFyv5EeSKrvLVFBLUj7UUq/+GC7oDVidEBj7MQg1XFkxwOnM5kjjfRxJKZ
 VE3OVrimOvmE0DaIiVnvHfh+S9tH5M0mQa7vOdaonXb8Kpmv4za/mIh0JUDwZmf+O6FE
 qiFHpcMedBgYNEtgL0AHkd0b+r621SdyQ/uXiQVcxtDiuJqBTMnDbVLAnLvATIVx/4Pt
 wV1kq0sLlmnUho8F+WLZuvZh2r28VRgk56DoyNe0yMO2jD/1IWevPwVewVifr4E6IrBw Kw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73urt5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 07:11:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I7B3Hu025817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 07:11:03 GMT
Received: from bselvara-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 00:11:01 -0700
From:   Balamurugan S <quic_bselvara@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Balamurugan S <quic_bselvara@quicinc.com>
Subject: [PATCH] wifi: ath12k: Avoid NULL pointer access during management transmit cleanup
Date:   Thu, 18 May 2023 12:40:46 +0530
Message-ID: <20230518071046.14337-1-quic_bselvara@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2uPINWCWc_PtHNwxU9zDlijqKTDYyrte
X-Proofpoint-GUID: 2uPINWCWc_PtHNwxU9zDlijqKTDYyrte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=818 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently 'ar' reference is not added in skb_cb.
Though this is generally not used during transmit completion
callbacks, on interface removal the remaining idr cleanup callback
uses the ar pointer from skb_cb from management txmgmt_idr. Hence fill them
during transmit call for proper usage to avoid NULL pointer dereference.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d814d74bc168..a344211f5b53 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4443,6 +4443,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_vif *arvif,
 	int buf_id;
 	int ret;
 
+	ATH12K_SKB_CB(skb)->ar = ar;
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH12K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);

base-commit: 610b78b97bad8f3e77c27a15e9a03cbbb4109697
-- 
2.17.1

