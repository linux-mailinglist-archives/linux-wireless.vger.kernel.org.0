Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE05A0EDA
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 13:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiHYLSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 07:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiHYLSv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 07:18:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC77AEDAF
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 04:18:50 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P4SnDR001246;
        Thu, 25 Aug 2022 11:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6YZx9N0JVg7h8kheDQPnMX3LghnDBErISDw/AneuDAU=;
 b=Ew73FAihWlSPtICJ0DWaxUA3JwHKh+C12v2sDDoseePiA0oRYz+AEIh7G9Pva4typ7zd
 i4pNciNFWY2RECR8bol+rJ4Lr+JaiW+/omcWxfYDzYrHJXnwVWV9R/srPRSJfN7llQ69
 yYpuusLBe4OVtF4AHXeDZaHmQ0fWmJhCh1IEvBxPEUdlHi4f0mXRdvIvCEz5Z0kY/9zo
 okrbia8e3nF7bGsyNo8yHgxR5Y4isbGDw46jv2698NWc9f+mquYNiVemefGElb2g1XK9
 Uv14zCr0vXIywu2TO+YK7j6a0PFQ0AnGv2bqrtCgqURg2NfHOYC4IIyccfphF7pUeNQS Ww== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j5xcuhjfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PBIaIk004019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 11:18:36 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 25 Aug 2022 04:18:35 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 0/4] ath11k: Enable low power mode when WLAN is not active
Date:   Thu, 25 Aug 2022 16:48:14 +0530
Message-ID: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yDUUgbMNlgHqzQmKxS0uw_N7wji7Gmip
X-Proofpoint-ORIG-GUID: yDUUgbMNlgHqzQmKxS0uw_N7wji7Gmip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, WLAN chip is powered once during driver probe and is kept
ON (powered) always even when WLAN is not active; keeping the chip
powered ON all the time will consume extra power which is not
desirable for battery operated devices. Same is the case with non-WoW
suspend, chip will not be put into low power mode when the system is
suspended resulting in higher battery drain.

Send QMI MODE OFF command to firmware during WiFi OFF to put device
into low power mode.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Manikanta Pubbisetty (4):
  ath11k: Fix double free issue during SRNG deinit
  ath11k: Move hardware initialization logic to start()
  ath11k: Enable low power mode when WLAN is not active
  ath11k: Fix failed to parse regulatory event print
---
V2:
 - "Enable low power mode when WLAN is not active" has been enabled only for WCN6750
   as the device shutdown and turn-on changes are not same for all chipsets in ath11k.
   A future patch will be sent to enable the logic for other devices.

 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/ahb.c  |  45 +++++
 drivers/net/wireless/ath/ath11k/core.c | 229 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/core.h |   8 +-
 drivers/net/wireless/ath/ath11k/hal.c  |   1 +
 drivers/net/wireless/ath/ath11k/hif.h  |  12 ++
 drivers/net/wireless/ath/ath11k/mac.c  |  33 ++--
 drivers/net/wireless/ath/ath11k/pci.c  |  26 +++
 drivers/net/wireless/ath/ath11k/reg.c  |   2 +
 8 files changed, 264 insertions(+), 92 deletions(-)

-- 
2.37.1

