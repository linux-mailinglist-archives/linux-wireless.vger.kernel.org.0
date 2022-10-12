Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4A5FCABB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJLShG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJLShF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 14:37:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986FA6F546
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 11:37:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CGeOBg006401;
        Wed, 12 Oct 2022 18:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=zH9E5mTn/MnoPvBc3jO3qr502s/aQlo3hB8caxiLngc=;
 b=N+rMuJWnl46TYBoIvaJiJEcF/Q3HBE6cwMPyvh4CvgYTH+JLu/T6SR7ZKpoceloRn/hQ
 0c46PjrUG1DPpJHhMZBM8kRue10WIpxz8mCXk+fW7S5njUJnfZc0gCoC1AjS6Vo+neSg
 tTYcSRbQtQBfYf+/9XGm/TKN03X2JzBo0TGPwL28Jj/ZtOSthFqGZt0E1P6VrjLFxq7y
 OCNXZ/2GU/Bgv0BG1rXt3qZUaadvgDRzv8fwRDg9hkphCSUvU7q18kYqqD2UaIUx06vm
 9yDB0X/R0crcZnmiQ2oZO116Rd4xC8dFtGF5E0E7ogSBmRf0OdUnm1bh3FJQJf/MHkZU RA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5j7b2y87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CIauLO011434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 18:36:56 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 12 Oct 2022 11:36:55 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 1/4] wifi: ath11k: modify accessor macros to match index size
Date:   Wed, 12 Oct 2022 11:36:44 -0700
Message-ID: <1665599807-12908-2-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665599807-12908-1-git-send-email-quic_msinada@quicinc.com>
References: <1665599807-12908-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wz-1vNd732tpvibCh56EeNnBE3TwMXmD
X-Proofpoint-ORIG-GUID: Wz-1vNd732tpvibCh56EeNnBE3TwMXmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxlogscore=739 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120120
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HE PHY is only 11 bytes, therefore it should be using byte indexes
instead of dword. Change corresponding macros to reflect this.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8f2c07d70a4a..368b7755e800 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2857,30 +2857,32 @@ struct rx_reorder_queue_remove_params {
 #define WMI_VDEV_PARAM_TXBF_SU_TX_BFER BIT(2)
 #define WMI_VDEV_PARAM_TXBF_MU_TX_BFER BIT(3)
 
-#define HECAP_PHYDWORD_0	0
-#define HECAP_PHYDWORD_1	1
-#define HECAP_PHYDWORD_2	2
+#define HE_PHYCAP_BYTE_0	0
+#define HE_PHYCAP_BYTE_1	1
+#define HE_PHYCAP_BYTE_2	2
+#define HE_PHYCAP_BYTE_3	3
+#define HE_PHYCAP_BYTE_4	4
 
-#define HECAP_PHY_SU_BFER		BIT(31)
+#define HECAP_PHY_SU_BFER		BIT(7)
 #define HECAP_PHY_SU_BFEE		BIT(0)
 #define HECAP_PHY_MU_BFER		BIT(1)
-#define HECAP_PHY_UL_MUMIMO		BIT(22)
-#define HECAP_PHY_UL_MUOFDMA		BIT(23)
+#define HECAP_PHY_UL_MUMIMO		BIT(6)
+#define HECAP_PHY_UL_MUOFDMA		BIT(7)
 
 #define HECAP_PHY_SUBFMR_GET(hecap_phy) \
-	FIELD_GET(HECAP_PHY_SU_BFER, hecap_phy[HECAP_PHYDWORD_0])
+	FIELD_GET(HECAP_PHY_SU_BFER, hecap_phy[HE_PHYCAP_BYTE_3])
 
 #define HECAP_PHY_SUBFME_GET(hecap_phy) \
-	FIELD_GET(HECAP_PHY_SU_BFEE, hecap_phy[HECAP_PHYDWORD_1])
+	FIELD_GET(HECAP_PHY_SU_BFEE, hecap_phy[HE_PHYCAP_BYTE_4])
 
 #define HECAP_PHY_MUBFMR_GET(hecap_phy) \
-	FIELD_GET(HECAP_PHY_MU_BFER, hecap_phy[HECAP_PHYDWORD_1])
+	FIELD_GET(HECAP_PHY_MU_BFER, hecap_phy[HE_PHYCAP_BYTE_4])
 
 #define HECAP_PHY_ULMUMIMO_GET(hecap_phy) \
-	FIELD_GET(HECAP_PHY_UL_MUMIMO, hecap_phy[HECAP_PHYDWORD_0])
+	FIELD_GET(HECAP_PHY_UL_MUMIMO, hecap_phy[HE_PHYCAP_BYTE_2])
 
 #define HECAP_PHY_ULOFDMA_GET(hecap_phy) \
-	FIELD_GET(HECAP_PHY_UL_MUOFDMA, hecap_phy[HECAP_PHYDWORD_0])
+	FIELD_GET(HECAP_PHY_UL_MUOFDMA, hecap_phy[HE_PHYCAP_BYTE_2])
 
 #define HE_MODE_SU_TX_BFEE	BIT(0)
 #define HE_MODE_SU_TX_BFER	BIT(1)
-- 
2.7.4

