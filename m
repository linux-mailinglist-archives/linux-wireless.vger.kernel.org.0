Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03B97E8021
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKJSHL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345734AbjKJSGu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:06:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1BE9000
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 00:13:37 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7gTKE011102;
        Fri, 10 Nov 2023 08:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=txZZy8CL21otkiewHkKdEAcF3VMcwzBDxAnpSqKwR+c=;
 b=MVmGjSkGLWT1NRpSCsajc4xqKxBlO/a+dI2vWzv8bR4TlPBsU6FdlZbE3yTQWcx5E0fw
 y5/ezEXZTP/EofEX/Yzkh5YB0MgaXdkjXS7t643+7mLlZ9vUy0x3NJW60ecUAeawZSqG
 f2CDNJisRwxxqXIbkHVJrymmBr9juKVVjxEzGDFvMJVRrj+opbe/Uhy/jRKeJmxc7bTx
 /+FGHfsCztLfWpoI21M1/VRDortL2f/BtL9MIJlK+xsuY3xMIjLUgDy7zRD7W7rEtI/B
 GQ0y71AxU5OS0lhtdCY1vveMl7G/W2ZJNaHFLY8pUU3RrHBMgxynl53iZ8A+McWrMROC 8g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93qy9jv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:13:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8DXZB022106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:13:33 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 00:13:32 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 0/4] ath12k: Refactor Rxdma replenish arguments
Date:   Fri, 10 Nov 2023 13:43:13 +0530
Message-ID: <20231110081317.19608-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eI5UD6H4nch1rSWIDeQvRcKWk7VXFJhN
X-Proofpoint-GUID: eI5UD6H4nch1rSWIDeQvRcKWk7VXFJhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 phishscore=0 bulkscore=0
 spamscore=1 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=1 lowpriorityscore=0 mlxlogscore=190 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid the explicit arguments of Rxdma replenish to optimize the per packet
rx data path CPU cycles. Also refactor the Rxdma ring structure.

Karthikeyan Periyasamy (4):
  wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
  wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
  wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
  wifi: ath12k: refactor DP Rxdma ring structure

 drivers/net/wireless/ath/ath12k/dp.c     |   4 +-
 drivers/net/wireless/ath/ath12k/dp.h     |  11 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  10 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 143 ++++++++++-------------
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   6 +-
 6 files changed, 76 insertions(+), 100 deletions(-)


base-commit: 553d0057523dc1d6935160613f1fbf9bb8db88f6
-- 
2.17.1

