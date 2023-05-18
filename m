Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E623707EA3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjERK6D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERK6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 06:58:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F141713
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 03:58:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9jnE4027342;
        Thu, 18 May 2023 10:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=+O8R9+PF1o/LWQjR3Z4t4oslJpzFOKFKZAaUDWtXniM=;
 b=Rn145ReH2vriJ+fnJ+KkvF+ifVdd/ZpuHwdCJMGElKYiSYTH7QkgcWJ46B6+M2NhmWCd
 OGt7UFqoeiUg6Ote0INHf6lI+kdIojjVQTDyQ85HZjtmb8i7tQlCDTxPndKN8xtCyZ6E
 YId/xUEbwiDKLlxZpBF5QkwsaHGrmpFVDLNCBYErE+FXeKj2ASLyp1FNY+x3x5EXBQIx
 CTJCEuRlAA1rMyEzZ0tW11M5MbMX4Kn54ZtsnqhWUS02ANeI1DVlDJyg5mrT91qz75u0
 2E00pqLMR6/V5xxQ00mCWnWflCO7H2f/eIXYFVj1LkmlNZVCxBETdwN8i23sVodB1ChC ng== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnbxqgsg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:57:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IAvvWs029784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:57:57 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 03:57:55 -0700
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH] wifi: ath12k: check hardware major version for WCN7850
Date:   Thu, 18 May 2023 18:57:41 +0800
Message-ID: <20230518105741.1281424-1-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4mzUu_X-y5xBKSyKBXCWy11q0mdo0ppL
X-Proofpoint-GUID: 4mzUu_X-y5xBKSyKBXCWy11q0mdo0ppL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is to check the hardware major version for WCN7850 so only
supported hardware is initialized. Now only WCN7850 with major
version 2 is supported.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 9f174daf324c..5990a55801f0 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1227,8 +1227,20 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	case WCN7850_DEVICE_ID:
 		ab_pci->msi_config = &ath12k_msi_config[0];
 		ab->static_window_map = false;
-		ab->hw_rev = ATH12K_HW_WCN7850_HW20;
 		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
+		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
+					   &soc_hw_version_minor);
+		switch (soc_hw_version_major) {
+		case ATH12K_PCI_SOC_HW_VERSION_2:
+			ab->hw_rev = ATH12K_HW_WCN7850_HW20;
+			break;
+		default:
+			dev_err(&pdev->dev,
+				"Unknown hardware version found for WCN7850: 0x%x\n",
+				soc_hw_version_major);
+			ret = -EOPNOTSUPP;
+			goto err_pci_free_region;
+		}
 		break;
 
 	default:

base-commit: 610b78b97bad8f3e77c27a15e9a03cbbb4109697
-- 
2.34.1

