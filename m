Return-Path: <linux-wireless+bounces-10703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63295942436
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 03:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A15284CC6
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F58846F;
	Wed, 31 Jul 2024 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gBup2V05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47B747F
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390084; cv=none; b=msbjsgPqxrFXR22DUIzNliGzqzRhpT8D0JP5k3mwl1s+Tl9huJSFEbZ1q9TocbI52Rm1RmA4TCIxB7lEGM+HP0S/SXBdHhxpTNioNGNBQ19oj9U794B2ehFhcM/ABcYEanH7bwdQOOvcFt2zvvvtuvCzu2pTgIgry+MUJprhxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390084; c=relaxed/simple;
	bh=IgOLSoXTaoD6Ql/lcJLOZjwM8lE0xqVfQvGUtOWzO1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sLlSsgZpYPfUfWfGxaT6s7HRCgfYkErfQmmPznxhRCd2fAhbiW9Wp31hE1syNzvxGztHkqzCzixq6XghRFob3Pju6jZAFzttaGfGhPsZP4N28k0lRauCWAMeUhixSl8YXNkGfPS85YRYtm8q7KuXfx23F7sg5bTr8ZjWLra5LmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gBup2V05; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UInbde030011;
	Wed, 31 Jul 2024 01:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=z1vsEe2p2v5kX81MlLKumm
	fMBaE+uB+JZk73XpplM8Y=; b=gBup2V05GarHvZ//T33+grH+lbJ4XKyHA3rOxS
	02Tt/1auOibOlKT+R6duue+4lX6IsGd5d1+3MmObKyx2yPQj711DKWgrv0xI5Jvf
	k+etG4HDpF/zcn1UercaHzZozX2ic+LCgj/lxGLqmvYXd5hfL1QGvbmKxIWdyLQs
	l4oqhmOLXgacfpgYN0DJE/MgDfNWhKJKyS/BdokfahwdYepxnIP5d1IAFe9izngX
	3r7REfoody7/of1exRh/I2qjjKqQ54/UrIVS6eoLuYhtZ2R792XZnytEiKGLlcBL
	TqVgCBZPzaKh1Di2KnVEfViEHWtVHRwFmPZApDdFxdeliIVg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pq523mqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 01:41:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46V1fG79013364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 01:41:16 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 18:41:14 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH v5 1/2] wifi: ath11k: use union for vaddr and iaddr in target_mem_chunk
Date: Wed, 31 Jul 2024 09:41:03 +0800
Message-ID: <20240731014104.798028-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rdRuJSVTLblc4hHspld68Ihm0Llo33ez
X-Proofpoint-ORIG-GUID: rdRuJSVTLblc4hHspld68Ihm0Llo33ez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_21,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=795
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310010

The value of 'ab->hw_params.fixed_mem_region' determines that
only one variable 'vaddr' or 'iaddr' is used in target_mem_chunk.
So use an anonymous union instead, easy to check whether the
memory is set or not.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
v5: use an anonymous union.
---
 drivers/net/wireless/ath/ath11k/qmi.c | 17 ++++++++++-------
 drivers/net/wireless/ath/ath11k/qmi.h |  9 ++++++---
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 1bc648920ab6..dcfbc6d4f04f 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1955,13 +1955,15 @@ static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
 	int i;
 
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
-		if ((ab->hw_params.fixed_mem_region ||
-		     test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
-		     ab->qmi.target_mem[i].iaddr)
-			iounmap(ab->qmi.target_mem[i].iaddr);
+		if (!ab->qmi.target_mem[i].anyaddr)
+			continue;
 
-		if (!ab->qmi.target_mem[i].vaddr)
+		if (ab->hw_params.fixed_mem_region ||
+		    test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) {
+			iounmap(ab->qmi.target_mem[i].iaddr);
+			ab->qmi.target_mem[i].iaddr = NULL;
 			continue;
+		}
 
 		dma_free_coherent(ab->dev,
 				  ab->qmi.target_mem[i].prev_size,
@@ -2068,7 +2070,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			break;
 		case BDF_MEM_REGION_TYPE:
 			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
-			ab->qmi.target_mem[idx].vaddr = NULL;
+			ab->qmi.target_mem[idx].iaddr = NULL;
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
 			idx++;
@@ -2091,10 +2093,11 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 				} else {
 					ab->qmi.target_mem[idx].paddr =
 						ATH11K_QMI_CALDB_ADDRESS;
+					ab->qmi.target_mem[idx].iaddr = NULL;
 				}
 			} else {
 				ab->qmi.target_mem[idx].paddr = 0;
-				ab->qmi.target_mem[idx].vaddr = NULL;
+				ab->qmi.target_mem[idx].iaddr = NULL;
 			}
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 7e06d100af57..fdf9b5f8c19f 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_QMI_H
@@ -102,8 +102,11 @@ struct target_mem_chunk {
 	u32 prev_size;
 	u32 prev_type;
 	dma_addr_t paddr;
-	u32 *vaddr;
-	void __iomem *iaddr;
+	union {
+		u32 *vaddr;
+		void __iomem *iaddr;
+		void *anyaddr;
+	};
 };
 
 struct target_info {
-- 
2.25.1


