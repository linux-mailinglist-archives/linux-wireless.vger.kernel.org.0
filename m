Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AF652FFD
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 11:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiLUK4b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 05:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiLUK4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 05:56:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098B218AB
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 02:56:06 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL8bWho018874;
        Wed, 21 Dec 2022 10:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=3ZJmyzXJ9XxGRztUt+7RZSsAg3BtgdA8IBNzisZVUYs=;
 b=mePzKw2h6enDRYGQBrW1wqXpkSsIVxrzfWSJ5EHgDgRGq6g03Gmn/6nIe0hXnSsrzXUs
 OikB+BkuV1TF5PFfyfz/TcDoJl/gwJKcdMsCsM8dl9mZnV/sLcPJxC3NCsg5R4i71BUK
 /Ez/4iVYcI4UEUd5H8DBj74OjfQwqoFbdCsHfLAW+SuezPrWnXB6xLFZ62miufZaQCSk
 CR3JXGbHtrNuCyOw93W3Eg6tRNAiUrbkWoTUi9IF7F8wn76hcyef8+cZNklAuWCCydbg
 hEqkfNLmzIkcLhFjJ6noLdCetVniutEj8JHPoXcudR8yU1QP0MByW6GziktGFXnQQvSf 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjw8tmbku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:55:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLAttXp029938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:55:55 GMT
Received: from tmariyap-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 02:55:54 -0800
From:   Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Subject: [PATCH 0/4] Fix clang warnings
Date:   Wed, 21 Dec 2022 16:25:25 +0530
Message-ID: <20221221105529.19345-1-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z5mfGfs7oiMKdbpvZznzhaph8gVyAGXa
X-Proofpoint-GUID: Z5mfGfs7oiMKdbpvZznzhaph8gVyAGXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_05,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1011
 mlxlogscore=571 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212210088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series fixes below clang warnings in the ath12k driver.
 * uninitilized variable
 * out of bounds

Thiraviyam Mariyappan (4):
  wifi: ath12k: Fix uninitilized variable clang warnings
  wifi: ath12k: hal_rx: Use memset_startat() for clearing queue
    descriptors
  wifi: ath12k: dp_mon: Fix out of bounds clang warning
  wifi: ath12k: dp_mon: Fix uninitialized warning related to the pktlog

 drivers/net/wireless/ath/ath12k/dbring.c | 2 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c | 8 +-------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 3 +--
 drivers/net/wireless/ath/ath12k/hal_rx.c | 9 +++------
 drivers/net/wireless/ath/ath12k/mac.c    | 4 ++--
 5 files changed, 8 insertions(+), 18 deletions(-)


base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
-- 
2.17.1

