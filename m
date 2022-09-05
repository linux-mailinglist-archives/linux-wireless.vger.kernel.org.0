Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92B5ACCA0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 09:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiIEHWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbiIEHVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 03:21:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934AA45F42
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 00:18:37 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2856Idor017127;
        Mon, 5 Sep 2022 07:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=49JFsfWcNrYz92Y06DpW4qLA3V9lV4dCiXLrFNTjGhw=;
 b=AnDQHIRYj5m5WKCBJ1vbel1xNf6nR+mjHzYpoL1DuED+/1YkqiGlnk46CiGGHhrsg/EQ
 DxkzBEOuZX4+6/6b9Vo8u2NEdg9M7CE/bPKgEJOG6yjAW6U6hAtTIBZQmIveGX4IyKTW
 1t6+hGz3IkhheKiMXS3/M3xhHUxpO64gyfUuo5FBN2NnYUDIE/emNAsezZaSXJR/NsS2
 tJ4S6rp0dgB3pSmwrB5uTBMWoBkCVoWnyClqxa2ubMAKabft9pGqjRhO+oxV7tA3gIEb
 GuOXGuKG3XmbztdO4uuYEbn4ko4Hl5bP8O7+B4n5/4igAtBkxLSiosCuuhHKuJgC664b aA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jcgu4sv6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 07:18:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2857IMCt002182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Sep 2022 07:18:22 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 5 Sep 2022 00:18:21 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath11k: Throughput fixes for WCN6750
Date:   Mon, 5 Sep 2022 12:48:02 +0530
Message-ID: <20220905071805.31625-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pthUIccOHHXwSKv6Ul8DcNSH_xb151Ro
X-Proofpoint-ORIG-GUID: pthUIccOHHXwSKv6Ul8DcNSH_xb151Ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=444
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix throughput issues on WCN6750. This includes 160 MHz
throughput fixes in both TX & RX directions.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Manikanta Pubbisetty (3):
  wifi: ath11k: Enable threaded NAPI
  wifi: ath11k: Add multi TX ring support for WCN6750
  wifi: ath11k: Increase TCL data ring size for WCN6750
---
V2:
- Commit log changes
- Rebased on ToT

 drivers/net/wireless/ath/ath11k/ahb.c    |   1 +
 drivers/net/wireless/ath/ath11k/core.c   |  20 +++-
 drivers/net/wireless/ath/ath11k/dp.c     |  26 ++---
 drivers/net/wireless/ath/ath11k/dp.h     |   4 +
 drivers/net/wireless/ath/ath11k/dp_tx.c  |  19 ++--
 drivers/net/wireless/ath/ath11k/hal.c    |   2 +-
 drivers/net/wireless/ath/ath11k/hal.h    |   2 +
 drivers/net/wireless/ath/ath11k/hal_tx.c |   4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h |   2 +
 drivers/net/wireless/ath/ath11k/hw.c     | 117 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hw.h     |  12 +++
 drivers/net/wireless/ath/ath11k/pcic.c   |   1 +
 12 files changed, 179 insertions(+), 31 deletions(-)


base-commit: e4a590b08d1309181f3904ae2fc622e018991ca9
-- 
2.37.1

