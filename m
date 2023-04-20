Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441976E93B3
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDTMJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjDTMJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:09:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A971FE2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:09:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KC0sQ7008501;
        Thu, 20 Apr 2023 12:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=SvHlo6PQyT7VLm7pCERh4t25/DIR/z/OORaQLZH4Euw=;
 b=VYjP/r7JrtyOlanWBRqLWKh5q7LhlRKWrq98VDPI1tNfl58X19bhIMnrqUaoihsEFaln
 ONU8Ht9Q6AD6Hemj7FBLkA0igZuGSau9pMPPSQ5o1Q8T1PW3OhE382tJVYs2dycT6JwW
 Bc/mWJ8vPnepxlVE5LGujzQXzVcYefUVrummtCvxQH6ScaDJENl9Psp60z0ZD/jhy6n3
 ZmC6aCxRvkWmRfj3W2Gl2RsM950VYLSCjr3k5Hknpy+/lhBJ3Val3rjVnK8yeUBoWC0U
 HA4mQZBDDAip+jX9PR2HWT+Tp+GwCt+n/TsdZWc4FQhN1idgFFmPx+dMqHmNJBWyfrPr Ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2uj3sany-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:09:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KC9C7i024992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:09:12 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Apr 2023 05:09:10 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 0/4] ath11k: factory test mode support
Date:   Thu, 20 Apr 2023 17:38:36 +0530
Message-ID: <20230420120840.18712-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 494X6Jx0-Nk3B4XnPCAB57_9Jh0C60g6
X-Proofpoint-ORIG-GUID: 494X6Jx0-Nk3B4XnPCAB57_9Jh0C60g6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_08,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=705
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Device is booted in factory test mode to calibrate the board.
The commands are sent from a userspace application, which is
sent to firmware using wmi commands. Firmware will send the
response back to the application which stores the calibration
data in caldata.bin file. This file will be loaded when the
device boots up normally next time.

Govindaraj Saminathan (3):
  wifi: ath11k: remove unused function ath11k_tm_event_wmi
  wifi: ath11k: optimize ath11k_tm_cmd_get_version
  wifi: ath11k: factory test mode support

Sowmiya Sree Elavalagan (1):
  wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

---
v3:
- added Tested-on tag in patch 1/4 and 2/4.

v2:
- added separate patch for removal of ath11k_tm_event_wmi()
- added separate patch for changes in ath11k_tm_cmd_get_version()
- removed unused cmd and updated documentation for enum ath11k_tm_cmd
- changed warning print to debug print
---

Govindaraj Saminathan (3):
  wifi: ath11k: remove unused function ath11k_tm_event_wmi
  wifi: ath11k: optimize ath11k_tm_cmd_get_version
  wifi: ath11k: factory test mode support

Sowmiya Sree Elavalagan (1):
  wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

 drivers/net/wireless/ath/ath11k/ahb.c        |   3 +-
 drivers/net/wireless/ath/ath11k/core.c       |  20 +-
 drivers/net/wireless/ath/ath11k/core.h       |  15 +-
 drivers/net/wireless/ath/ath11k/mac.c        |  13 +-
 drivers/net/wireless/ath/ath11k/pci.c        |   3 +-
 drivers/net/wireless/ath/ath11k/qmi.c        |  10 +-
 drivers/net/wireless/ath/ath11k/testmode.c   | 320 ++++++++++++++++---
 drivers/net/wireless/ath/ath11k/testmode.h   |  20 +-
 drivers/net/wireless/ath/ath11k/testmode_i.h |  16 +
 drivers/net/wireless/ath/ath11k/wmi.c        |  40 ++-
 drivers/net/wireless/ath/ath11k/wmi.h        |  20 ++
 drivers/net/wireless/ath/ath11k/wow.c        |   3 +-
 12 files changed, 419 insertions(+), 64 deletions(-)


base-commit: 12f167f02a1abe2c8817496a902de00758285b92
-- 
2.17.1

