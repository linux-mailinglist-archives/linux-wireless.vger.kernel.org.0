Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90151707DDB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 12:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjERKR0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjERKRD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 06:17:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD83586
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 03:16:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9MxTn026082;
        Thu, 18 May 2023 10:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JEVX8pEPD94rUojJY4xzpBkzMAMLCprO2F1bVreNICg=;
 b=htIwSqlwgTuftXrKY9AHow/4f+J6ueKKe3OMAn2V2JR3EmeLjT8cZLDZ7G2u03RKWH/H
 JIWbBTzYwZ2ArXa0Xi4uyUQUSEb7d+Kuwd0LF5+YAEUryJ3xxO2ojvdhPwV/ExfEm8NL
 OR+c0ToeM09trbSVO+KAEskD8mSPnSh8wlRyEgyhUrp6McGiMSfgxvrX19mmS8gvu4a5
 JTYL7Wht4TBEgUZMBBcwaio0hBs0RbuMXtcdG8pbnOqPAF3UxO6IzgBraucZ0//DPrAE
 i3Zzhfy00Rpo9/J7ohfgJ9J20u9RBtzABkNypvr6ZMDgTSzLyTxoyahHVrlUlhQpvDgT tQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qned30eeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:16:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IAG7vd004981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:16:07 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 03:16:05 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: Add coredump support
Date:   Thu, 18 May 2023 15:45:44 +0530
Message-ID: <20230518101546.27998-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6rHvsek6QE15RQlhHByD61eCM1SDAzWo
X-Proofpoint-GUID: 6rHvsek6QE15RQlhHByD61eCM1SDAzWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=613 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for devcoredump in the driver. This helps in capturing
the snapshot of DDR memory that firmware uses in the event of a
firmware assert which aids in firmware debug.

First patch in the series adds the coredump infrastructure to the
driver but no hardware support is included. Second one in the series
adds the support to capture MSA memory during firmware assert on
WCN6750.

Manikanta Pubbisetty (2):
  wifi: ath11k: Add coredump support
  wifi: ath11k: Add coredump support of MSA region for WCN6750

 drivers/net/wireless/ath/ath11k/Kconfig    |   1 +
 drivers/net/wireless/ath/ath11k/Makefile   |   1 +
 drivers/net/wireless/ath/ath11k/ahb.c      | 127 +++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h      |   8 +-
 drivers/net/wireless/ath/ath11k/core.c     |  18 +-
 drivers/net/wireless/ath/ath11k/core.h     |  19 +-
 drivers/net/wireless/ath/ath11k/coredump.c | 225 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/coredump.h | 147 ++++++++++++++
 8 files changed, 541 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h


base-commit: 610b78b97bad8f3e77c27a15e9a03cbbb4109697
-- 
2.17.1

