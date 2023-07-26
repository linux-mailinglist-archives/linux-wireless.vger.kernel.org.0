Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC37638A1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjGZOMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGZOLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67346AC
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:11:03 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QDJY5B008637;
        Wed, 26 Jul 2023 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=p1ohEOe5VjjgCu+evgrIYl0TzyzkvhxeeKuj62jTU2c=;
 b=mND3FEYsnNcllFaF6lK3Le5AqSl/zd5JxSG0RdanwF9uebyCIdtMgVaU5JLH2Y9Nvue5
 D/hNkNTJkF9jNSyKtiyymjjDW4cRh+7pC9jE3IM7DE4IhN+SuX+VcG7AoJwXubAKDbxY
 fcgEZbWs1ZpEp/QKDIvu5sZstNyC/lViVtU7K8zLEQ0GixFpa6xx8OjvA4TTYa791hV6
 KZczJ/3iLmzHYS68Cqhf3l2txAkrk64vStypa9SUHKYXanV+uNlXApxjBWADT+aEM5Vy
 +1qvleJJXD4AQr1jP0Bk/RIOd1PreX58xADSkBgjD4TTXN7ODsnc0zmqEPLxrOtbSOkd cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dauk2j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QEAqx7028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:10:52 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 07:10:51 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 0/3] wifi: ath11k: add coldboot calibration in QCN9074
Date:   Wed, 26 Jul 2023 19:40:29 +0530
Message-ID: <20230726141032.3061-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h7Z2azISA8fZlnXmmNMiBSIZ73W61wmW
X-Proofpoint-ORIG-GUID: h7Z2azISA8fZlnXmmNMiBSIZ73W61wmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=510 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset adds coldboot calibration support for QCN9074 in FTM mode.

Anilkumar Kolli (1):
  wifi: ath11k: Add coldboot calibration support for QCN9074

Seevalamuthu Mariappan (2):
  wifi: ath11k: Split coldboot calibration hw_param
  wifi: ath11k: Remove cal_done check during probe

 drivers/net/wireless/ath/ath11k/ahb.c  | 29 ++------------------
 drivers/net/wireless/ath/ath11k/core.c | 38 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  3 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  2 ++
 drivers/net/wireless/ath/ath11k/qmi.c  | 34 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/qmi.h  |  3 +-
 7 files changed, 69 insertions(+), 41 deletions(-)


base-commit: 9102ee8eaa6d29624ed2068396502ad8545f2ff0
-- 
2.17.1

