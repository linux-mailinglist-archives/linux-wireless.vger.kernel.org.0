Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023F975BE0A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 07:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGUFyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 01:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjGUFxd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 01:53:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954302726
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 22:53:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5hxVv025121;
        Fri, 21 Jul 2023 05:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=U8LRKtyFT85+iNUIj95aJBRmMti8NyPgBfDddPuni7M=;
 b=IBUbuoeedrq5pSyRIpBgvFIuWKWumJBpRBiBuexFPOSqAoIR5yP9odWXROtEsNON+VU0
 itruSyA3mK3nZxKSIf1+F9ci11wc3Gul23i1LJNbof6od7biUEd/1vO7mIdnBD/OIDwQ
 xs/o5ha5w/JjLDvwIPNZWB0Iztyak/fg1Xkd2JFYrrkuvjNAqAtIbl5XOl/kQbFj/6yD
 RG7LgfDX7m3o91zjYvNt02rJ57+/VKLZl2D+T1gvHn5UXpRF9GkdkIr8r3Ei0ljKoAA3
 1AAsd8swQyIYruG1TMgjI91oGhDcmLoI6nZJp36X8GK1E8LK3R/PCR9GLcFkXf2GzZrW yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ry3y1j8w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:53:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L5rM6r030451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:53:22 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:53:20 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 1/3] wifi: ath12k: configure RDDM size to MHI for device recovery
Date:   Fri, 21 Jul 2023 01:53:03 -0400
Message-ID: <20230721055305.20420-2-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721055305.20420-1-quic_wgong@quicinc.com>
References: <20230721055305.20420-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mczhhKezgGF5BIZhjJMRX8aa0MdX3hN5
X-Proofpoint-ORIG-GUID: mczhhKezgGF5BIZhjJMRX8aa0MdX3hN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=835 bulkscore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RDDM is RAM DUMP DEBUG module, it is used to debug issues when firmware
encounters an error.

The rddm_size is needed by firmware while MHI enter RDDM state. Add it
to support device recovery when ath12k receive MHI_CB_EE_RDDM message.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  | 3 +++
 drivers/net/wireless/ath/ath12k/hw.h  | 1 +
 drivers/net/wireless/ath/ath12k/mhi.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 5991cc91cd00..c69cfca67f7d 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -907,6 +907,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+		.rddm_size = 0,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -964,6 +965,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
 					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
+		.rddm_size = 0x780000,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1019,6 +1021,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+		.rddm_size = 0,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e6c4223c283c..7d82b76ad021 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -186,6 +186,7 @@ struct ath12k_hw_params {
 	const struct hal_ops *hal_ops;
 
 	u64 qmi_cnss_feature_bitmap;
+	u32 rddm_size;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 42f1140baa4f..91b2abf6da44 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -366,6 +366,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	mhi_ctrl->fw_image = ab_pci->amss_path;
 	mhi_ctrl->regs = ab->mem;
 	mhi_ctrl->reg_len = ab->mem_len;
+	mhi_ctrl->rddm_size = ab->hw_params->rddm_size;
 
 	ret = ath12k_mhi_get_msi(ab_pci);
 	if (ret) {
-- 
2.40.1

