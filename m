Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59365706A5D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEQOAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjEQOAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 10:00:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C53C30
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 07:00:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HAOHlH016339;
        Wed, 17 May 2023 13:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Wu3P6bt1l+ytrSVClzTyytbsCDgT7/IV3/48siddHdM=;
 b=jVEBgFOHVC2m/tjudC7w8G/YdCznm+Fjb8SkEZhG5DfEDvSTVNHvxfyJ1QrQ6b60B++V
 W+C65SfXakQtAwC/5KNjCAiemYx7XNo6hz/Neg+8KBzJ+O91Xtei0Sqpqk4fN0d92MMO
 QZN9naUxx9Ob448zxD9HnxePN6nTKFSZNE3keDp78JMR1YTyq+jI94FRUClBAPfQAlA7
 XC+jOJJ6nG71pg63I5x9XEfMQdFDHF1aCmu7KI3TgVfVUEl5/ltl3/L+W6pXc/Ns16zO
 wdJdYacQdakEXmDsjl7x0+Zm9LQkByKP6kakPyO2ZXsXMRkn3GSp8O8yqHGnwYotczc6 8w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmcc62e9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 13:59:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HDxx9D026683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 13:59:59 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 06:59:57 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v4 0/4] ath11k: factory test mode support
Date:   Wed, 17 May 2023 19:29:30 +0530
Message-ID: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VZcZWKr-9iGahiI_uPV_nprAHcJSsRhu
X-Proofpoint-ORIG-GUID: VZcZWKr-9iGahiI_uPV_nprAHcJSsRhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=666 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
v4:
- used pending branch commit as baseline for v4.

v3:
- added Tested-on tag in patch 1/4 and 2/4.

v2:
- added separate patch for removal of ath11k_tm_event_wmi()
- added separate patch for changes in ath11k_tm_cmd_get_version()
- removed unused cmd and updated documentation for enum ath11k_tm_cmd
- changed warning print to debug print
---

 drivers/net/wireless/ath/ath11k/ahb.c        |   3 +-
 drivers/net/wireless/ath/ath11k/core.c       |  21 +-
 drivers/net/wireless/ath/ath11k/core.h       |  16 +-
 drivers/net/wireless/ath/ath11k/debug.h      |   1 +
 drivers/net/wireless/ath/ath11k/mac.c        |  11 +-
 drivers/net/wireless/ath/ath11k/pci.c        |   3 +-
 drivers/net/wireless/ath/ath11k/qmi.c        |  10 +-
 drivers/net/wireless/ath/ath11k/testmode.c   | 363 ++++++++++++++++---
 drivers/net/wireless/ath/ath11k/testmode.h   |   7 +-
 drivers/net/wireless/ath/ath11k/testmode_i.h |  18 +-
 drivers/net/wireless/ath/ath11k/wmi.c        |  11 +-
 drivers/net/wireless/ath/ath11k/wmi.h        |  22 ++
 drivers/net/wireless/ath/ath11k/wow.c        |   3 +-
 13 files changed, 422 insertions(+), 67 deletions(-)


base-commit: 610b78b97bad8f3e77c27a15e9a03cbbb4109697
-- 
2.17.1

