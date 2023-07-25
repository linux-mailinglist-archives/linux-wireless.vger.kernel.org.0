Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69687627E0
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 02:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGZAvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 20:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZAve (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 20:51:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE6128
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 17:51:33 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PMQoeG020870;
        Tue, 25 Jul 2023 22:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=PFUbhwWNmxyiL7SbYzd0Vl2bo/toQY9AVNp04fCJHlQ=;
 b=dtPbt8cDqB/vwWwcvTN5JTeyHwZdxkhYOROX5tRyf3Gq8PTqn5iJg0wx38Ku4Y5QaudK
 VqzMYhE4gTmpbS0nrX6sO15goHrjzcJhEtDmIxZg/MKXjYKHnOsYH1VPRMl1INym/eGk
 FpeyOxq5srcHqjxOrYHTrXFdG3bf5fWS+AI+VkcJ09yZmx/nw3+mmfolZ2EZshlyW37g
 8uAqQ6gtDiUhKpPpT1UE4lSQI4wY6iLjNtBs7jVF0nFBzq2BEAvcdBwsp8dCeqGkIkR5
 Vqb4tTcpn4KC/BAhQhh3dMqZmBmPXXJ8aKR3Qs/xPmoN4gpkGrKMF2x1g9jiA1fK2u8g Gg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dauhfa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PMejxE022981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:45 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 15:40:44 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v5 00/11] wifi: ath12k: (v5) EHT support
Date:   Tue, 25 Jul 2023 15:40:23 -0700
Message-ID: <20230725224034.14045-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 44Oshj-ejWws08nkcut4YXKy8Z0fjM2o
X-Proofpoint-ORIG-GUID: 44Oshj-ejWws08nkcut4YXKy8Z0fjM2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v5: Addressed comments v4 on patches #3, #4 and #6, changelog included
in the respective patches.
v4: Modified patch 3 to support WCN7850.
v3: Modified patches 6 and 9 to fix some issues,
changelog included in the respective patches.
v2: This version modifies only few commit descriptions,
changelog included in the respective patches.

Following list gives the details for each patch.
1-4: Propagation of EHT capabilities from target to userspace.
5: Addition of EHT phy modes.
6-9: EHT related additions in peer association.
10: Process the new WMI service ready ext2 event.
11: Preamble puncturing support.

Aloka Dixit (9):
  wifi: ath12k: rename HE capabilities setup/copy functions
  wifi: ath12k: move HE capabilities processing to a new function
  wifi: ath12k: WMI support to process EHT capabilities
  wifi: ath12k: propagate EHT capabilities to userspace
  wifi: ath12k: prepare EHT peer assoc parameters
  wifi: ath12k: add WMI support for EHT peer
  wifi: ath12k: peer assoc for 320 MHz
  wifi: ath12k: parse WMI service ready ext2 event
  wifi: ath12k: configure puncturing bitmap

Muna Sinada (1):
  wifi: ath12k: add EHT PHY modes

Pradeep Kumar Chitrapu (1):
  wifi: ath12k: add MLO header in peer association

 drivers/net/wireless/ath/ath12k/core.h |  24 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 543 ++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h  |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 252 +++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h  | 116 +++++-
 5 files changed, 827 insertions(+), 110 deletions(-)


base-commit: 9102ee8eaa6d29624ed2068396502ad8545f2ff0
-- 
2.39.0

