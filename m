Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A33631F03
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 12:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKULE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 06:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKULEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 06:04:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A58E63D4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 03:04:25 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL7wv2I018558;
        Mon, 21 Nov 2022 11:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=sXz76b6lVEdoLg3u/wiKDk8TD3JBebCLTsYMhypEq0I=;
 b=LR44CyUPMEeivy4iKL7iI6UZNtnDB3UhynONDYDG6n+FBgdlUDIFueCLJTHFawrQBglx
 pdiVzfNl3EHJ0TP4bVT4CQqLsjSwyE0cJq6mU2cjLV1oOBbwrMYvzYOWUPmhPMaQcqrF
 UaAQkHRXrO6RJVudl+EeCPwJ1cr3DbuiwcobVk6x7Lxpo7rBESQTTB3elxkPj9yX9T5L
 zwHufDDzrUuMaQJG8l8jQ49hCtSVjoMlT50VdR/swgq9SuR65ELMsLr9TPZtSEMkVZql
 06i+QaWOg/RmUG6XvcnVtHTpApqz6Pc6zJWFQXVT7nk6+pLh0uNTv8t4rjXxD+5mCKHs 4Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrfbv9du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALB4L7q023569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 11:04:21 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 03:04:20 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 0/3] Enable low power mode when WLAN is not active
Date:   Mon, 21 Nov 2022 16:33:56 +0530
Message-ID: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 45ZKwzzf-rEr_WY4SUrEYKGvG8YwSC8c
X-Proofpoint-ORIG-GUID: 45ZKwzzf-rEr_WY4SUrEYKGvG8YwSC8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16

Manikanta Pubbisetty (3):
  ath11k: Fix double free issue during SRNG deinit
  ath11k: Move hardware initialization logic to start()
  ath11k: Enable low power mode when WLAN is not active
---
V3:
 - Removed patch "ath11k: Fix failed to parse regulatory event print" as it is not needed anymore
 - Fixed a potential deadlock scenario reported by lockdep around ab->core_lock with V2 changes
 - Fixed other minor issues that were found during code review
 - Spelling corrections in the commit messages

V2:
 - "Enable low power mode when WLAN is not active" has been enabled only for WCN6750
   as the device shutdown and turn-on changes are not same for all chipsets in ath11k.
   A future patch will be sent to enable the logic for other devices.

 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/ahb.c  |  45 ++++
 drivers/net/wireless/ath/ath11k/core.c | 294 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/core.h |  10 +-
 drivers/net/wireless/ath/ath11k/hal.c  |   1 +
 drivers/net/wireless/ath/ath11k/hif.h  |  11 +
 drivers/net/wireless/ath/ath11k/mac.c  |  33 +--
 drivers/net/wireless/ath/ath11k/pci.c  |  26 +++
 drivers/net/wireless/ath/ath11k/qmi.c  |   3 +-
 8 files changed, 311 insertions(+), 112 deletions(-)


base-commit: ef907406320c7af8b6a9e0b140a11ebb3a0fa371
-- 
2.38.0

