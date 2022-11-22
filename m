Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632DA633D78
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 14:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiKVNWX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 08:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiKVNWS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 08:22:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9079464A1E
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 05:22:13 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMBj8wT003626;
        Tue, 22 Nov 2022 13:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=YkBJEHiJeayRClsMFuf6Qr1QDZXYuPcYH7gAHaEdbEQ=;
 b=Jp6fvXWKufLK3b0Wi70VYWHuwF8BVS0l4ZlN80VsuipVmLR4V3sudO1LXEqHfIUAWwa4
 WhyLLAGLyR4yWJfIkFRpmYutejMgAiiv48gDHw5Zm9SoZMoFRgLPMXtwpXQGLSUEEYaZ
 lOtK+B6iBXuKXxZK3CQZ8H3iOsmBoLNRXbk7U+wIyeavDlpu70kCco/SRaXCxAzafKmX
 DrcVQ1hHqpiy6vIp241s6x37j6TPulbba7sU5cQmNU3iVzipiJi9elvDQe+j5l8mXEak
 XJC6Hu14gWHGRn5WXx69Uwtzd8NXycml41pgU9fZ7FN5nul0lm4PBpXo+aLuegykB6rh Sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0hwp9nt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 13:22:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AMDM6a3030510
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 13:22:06 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 22 Nov 2022 05:22:04 -0800
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCHv2 0/8] wifi: ath11k: Add support for IPQ5018
Date:   Tue, 22 Nov 2022 18:51:44 +0530
Message-ID: <20221122132152.17771-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AvTw6PjfNh22L3ZVkIl4LH-pF_PzBDz2
X-Proofpoint-ORIG-GUID: AvTw6PjfNh22L3ZVkIl4LH-pF_PzBDz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=733 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211220098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds support for IPQ5018.
   - IPQ5018 is a AHB based 2G 2x2 device.
   - The CE reg space in IPQ5018 is not part of WCSS as in IPQ8074
    or IPQ6018 and these sections (CE register space and WCSS) are not
    contiguous, hence the ce space is io remapped separately and
    the registers are handle accordingly based on the offset.
   - The rx descriptors are similar to QCN9074
   - The hw ops are similar to QCN9074 except for rx hash computation which
     is defined newly
   - The UMAC registers are different, hence new MACROS are defined for
    their usage.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
Tested-on Modes : AP, STA and Mesh

Sriram R (8):
  dt: bindings: net: add IPQ5018 compatible entry for ath11k
  ath11k: update ce configurations for IPQ5018
  ath11k: remap ce register space for IPQ5018
  ath11k: update hal srng regs for IPQ5018
  ath11k: initialize hw_ops for IPQ5018
  ath11k: add new hw ops for ipq5018 to get rx dest ring hashmap
  ath11k: add ipq5018 device support
Karthikeyan Kathirvel (1):
  ath11k: update hw params for IPQ5018

Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
v2:
	- Fixed Warnings
	- Updated Tested-on tag
	- Fixed pci device boot-up issues with this patchset

 .../bindings/net/wireless/qcom,ath11k.yaml         |   1 +
 drivers/net/wireless/ath/ath11k/ahb.c              |  71 +++-
 drivers/net/wireless/ath/ath11k/ce.h               |   5 +
 drivers/net/wireless/ath/ath11k/core.c             |  37 ++
 drivers/net/wireless/ath/ath11k/core.h             |   8 +
 drivers/net/wireless/ath/ath11k/dp.c               |   9 +-
 drivers/net/wireless/ath/ath11k/hal.c              |  48 ++-
 drivers/net/wireless/ath/ath11k/hal.h              |  15 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |  18 +-
 drivers/net/wireless/ath/ath11k/hw.c               | 371 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h               |  10 +
 11 files changed, 553 insertions(+), 40 deletions(-)
-- 
2.7.4
