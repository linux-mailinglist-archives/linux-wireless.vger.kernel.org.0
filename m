Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529E75F64B4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJFLAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJFLAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:00:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950EF6B174
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:00:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296Af2ik003372;
        Thu, 6 Oct 2022 11:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=uh+BE9MCHmRKFwJ4hLzJJMhKAn4hSl6c0tz630U90vY=;
 b=Hmm42z47Ei+VePY7zzblQw9feQzh0l+MiB7wvqIy1PPStPgRGJGewhFpKJTky8cJ6DXR
 vEU+UPRJkIHiOHyeekdWIIXa5ahiXmdjANnb9hlMsw9LhL5ib3vbnSUpm5G7IY92nGos
 8cyH/unuOXiR7rC+vkXq8zHYtrqzEMaCz45ssG8zr2Af4Q6F83ipUWnOIP9FbZlmYU/m
 kTjOE6svraqcytB5A9Um+NWKjtbYsPjb+hUr3WzAbqislJYkTkQU7CiNX0nJYdkxJks9
 4uKvAdpXAKjTmHkOtcmqZzYKwhzFccEM0nrFLreSD5cLrtxBuKn6fePXUBtBucLSQRw9 8g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k1qykrrbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:00:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B0C1H026182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:00:12 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 04:00:10 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCH 0/8] wifi: ath11k: Add support for IPQ5018
Date:   Thu, 6 Oct 2022 16:29:05 +0530
Message-ID: <20221006105913.18356-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j3fSzC7R8qf5CchcXDkIGbvrjg54HvXQ
X-Proofpoint-GUID: j3fSzC7R8qf5CchcXDkIGbvrjg54HvXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=793 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1
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
