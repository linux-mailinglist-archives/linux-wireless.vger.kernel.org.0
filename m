Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69D475BC54
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGUCfO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 22:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGUCfN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 22:35:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D201FCC
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 19:35:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1mi48011932;
        Fri, 21 Jul 2023 02:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4UJBjrb/tMVmQ+KW0G7h9Cb38raqN9h+/coW/5SBaXU=;
 b=cH/qDBw4Sqi2SqITDQgV4JHoH678IgAMGMRTQtTnKHLh5R9nybvzS6SD10wR/Ifs5Hjy
 NXIhAl1A7/DahhXZBUIb3AP6elfZDDy0NBO4KkfS3aptqqDxoxVV4dI2SR4lDALmVFR9
 24pqH5QRkiMzT5/try5x81cQxLN/YdjX8fyYnCfq/3lDBDy9OKdsLhKt0z3O71ISV84p
 Y4lurHtwNZ6MW2XiGXxjPXY8XftFbVM7r8k6Xmfr10v+mErCISJQLCnWoczET/jjJaS7
 0KJUWWSrQ/7L7UbwrExm6arbkJWNU6JHO3F3djEuwm5Br2kia9QE5aAiNBQ3frqds4+M jQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxpyquc3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2Z4KM003117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:04 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 19:35:03 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 3/3] wifi: ath12k: Turn on suspend/resume switch for WCN7850
Date:   Fri, 21 Jul 2023 10:34:46 +0800
Message-ID: <20230721023446.3706-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721023446.3706-1-quic_bqiang@quicinc.com>
References: <20230721023446.3706-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rn7mAvglvhvxHBn-OyNhAS94AGi0X3Ok
X-Proofpoint-ORIG-GUID: rn7mAvglvhvxHBn-OyNhAS94AGi0X3Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=828 malwarescore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307210021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now suspend/resume functionality is implemented, so change
supports_suspend to true to make it work for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 5991cc91cd00..e7d1bff4d636 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -947,7 +947,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.idle_ps = true,
 		.download_calib = false,
-		.supports_suspend = false,
+		.supports_suspend = true,
 		.tcl_ring_retry = false,
 		.reoq_lut_support = false,
 		.supports_shadow_regs = true,
-- 
2.25.1

