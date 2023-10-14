Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4531B7C9279
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 05:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJND1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJND1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 23:27:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D3BE
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 20:27:16 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39E3Qt3J027062;
        Sat, 14 Oct 2023 03:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WoRIoC2pNy+mVCrK4MWkNJ/kwgApnFh/V14PjpnJc54=;
 b=PYQ6wyH56czXX6OxHKvfD3+0SIDZwad5Cj74uM7HzXskk7KX/U6wGyFD7TimV3Oed6zF
 2x38R5StXEA4QW71ACNkMCTHfhVXCT5+vEvue4yJo+UUn73DiAMAsKHNq7ICnv2Bz5KV
 rABBHcY357vkno76kFSZUQkbXAmz7RMcnYutxuGn/5czLsSi9mhhDJJsAm6tUuQs2Y+F
 oOvTzVyi+/ke3ma09JxZTwCR+Xnh8mnNaEqPkpWiHuDBZkTb1Els+yRkJG7kna4iBuEI
 d+phBHmCFixtHIwbAxxbw1L7hh3FZ2aJ881R3LYgWjGXMt7KdH3u/XTrAgwxoN0UmYtq pA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqgbt06k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 03:27:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39E3RAjk030511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 03:27:10 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 20:27:09 -0700
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: rename the variable naming convention
Date:   Sat, 14 Oct 2023 08:56:48 +0530
Message-ID: <20231014032650.32605-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y8DTqIgvWRIk_HZEts-HF8KOnbJcdm0f
X-Proofpoint-ORIG-GUID: Y8DTqIgvWRIk_HZEts-HF8KOnbJcdm0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=648
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310140029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, the identifier sc is used to represent an instance of
SoC structure. But in ath11k ab is refer to the SoC data structure.
So rename the variable name.

Karthikeyan Periyasamy (2):
  wifi: ath11k: rename the wmi_sc naming convention to wmi_ab
  wifi: ath11k: rename the sc naming convention to ab

 drivers/net/wireless/ath/ath11k/hif.h     | 54 +++++++++++------------
 drivers/net/wireless/ath/ath11k/pcic.c    |  6 +--
 drivers/net/wireless/ath/ath11k/thermal.c | 22 ++++-----
 drivers/net/wireless/ath/ath11k/thermal.h |  8 ++--
 drivers/net/wireless/ath/ath11k/wmi.c     | 32 +++++++-------
 5 files changed, 61 insertions(+), 61 deletions(-)


base-commit: acbc21b2b1b18429244266f70a44b7043d391eae
-- 
2.17.1

