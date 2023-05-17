Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DE706A60
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 16:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjEQOAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjEQOAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 10:00:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E026EA9
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 07:00:10 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HDnWTt004396;
        Wed, 17 May 2023 14:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xb927NTpoJ1hUH7azTaCV8UHp8t7MyISLywrX7RiDGk=;
 b=lvCv5RCf+KZiAxHjWeqc24KbqECXbd54Y2timIYrT7+pV5jc8OEvLG1eX4WAHJ8MBNpM
 oZUo9yxNzvV/I8P8+ot24PRFsIbxh99Y/VR3QrMLvIw1+03klHByg9p7E4X6hbxaufIE
 1tI2ZfZ1sfctukeQVZNEqAFw5Uhu2hum6lu1V8rmiBb/uGEVwPPdLvdwPoRlFRsi3Qs8
 zKN0M9KCdOgf3DTEHsNs0OPKsKezY89Lq9upOA0wkzRkgP9dslgcv3U6CEF8ejp9E5Jq
 TDOS4F3VKOPam5uydDHqpERHoyuFTN123+FOXrcrVn+nvLIApmeYecjL72WzQ3N6G2B4 MA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmts28su7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:00:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HE07WK006345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:00:07 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 07:00:05 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH v4 4/4] wifi: ath11k: Allow ath11k to boot without caldata in ftm mode
Date:   Wed, 17 May 2023 19:29:34 +0530
Message-ID: <20230517135934.16408-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
References: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ono_IMHOjtTZgcSEKYHDDTrsAj5INEEk
X-Proofpoint-ORIG-GUID: Ono_IMHOjtTZgcSEKYHDDTrsAj5INEEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Currently, if ath11k is unable to load the calibration data file it will
always exit. However the calibration data may not be present in factory
test mode, so update the logic to allow the driver to execute in FTM mode
even if downloading the calibration data fails.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index ab923e24b0a9..fa94ad828599 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -2457,6 +2457,14 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
 
 		fw_entry = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_CAL_FILE);
 		if (IS_ERR(fw_entry)) {
+			/* Caldata may not be present during first time calibration in
+			 * factory hence allow to boot without loading caldata in ftm mode
+			 */
+			if (ath11k_ftm_mode) {
+				ath11k_info(ab,
+					    "Booting without cal data file in factory test mode\n");
+				return 0;
+			}
 			ret = PTR_ERR(fw_entry);
 			ath11k_warn(ab,
 				    "qmi failed to load CAL data file:%s\n",
-- 
2.17.1

