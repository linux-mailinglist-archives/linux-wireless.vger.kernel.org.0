Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0292A7E0132
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Nov 2023 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347205AbjKCJiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Nov 2023 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347166AbjKCJiU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Nov 2023 05:38:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA51BD
        for <linux-wireless@vger.kernel.org>; Fri,  3 Nov 2023 02:38:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A38NQki017328;
        Fri, 3 Nov 2023 09:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=XD7wYxSQGIaI779dMXMYdFSKxOvx5+jeBJadQOVESFU=;
 b=jJpS0gjxrr7BsV/YyeukCNVWKTbAEGrwHyWmX52bMvLmdPvevYv7tfriFlc7pyvgaqHR
 VQDkcHH/7Tc4YBG6tGSPKiCSegUeXVmfnTLFcIOs9L1EWSSwkRBnxU9GpKmNuAp4ZZSJ
 EkSJ8l73usM0k/St6roumXCZwmmK/TuDBGaKnwkICaiUdWr8tQutKq6xc7mKweDhsSWD
 86mdD4BG/R6BaU7KPMJgdoPMr7faDChZz/+xeXoy0JDkpbDV0rGoYB0gq7k/E5UZxivj
 lcYy6ahJb2SAfr4IDx0J2f1MZOT0MujU7w87dqe2AidRSI3c7AWqAJKfvCSkHsrbqM8R 9g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4sft8jec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:38:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A39c6mb026207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 09:38:06 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 02:38:05 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH v2 0/4] ath12k: Factory test mode support
Date:   Fri, 3 Nov 2023 15:07:42 +0530
Message-ID: <20231103093746.24146-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PH2yO117DVMCJy7D1cQffoP8daUMfO-4
X-Proofpoint-ORIG-GUID: PH2yO117DVMCJy7D1cQffoP8daUMfO-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_09,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=947 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Device is booted in factory test mode for calibration.
The commands are sent from userspace application, which
is sent to firmware using wmi commands. Firmware sends
the response to driver as wmi events and driver sends
these events to the application via netlink message.

Also added changes related to correct pdev id access for
fw test cmd.

Aaradhana Sahu (3):
  wifi: ath: create common testmode_i.h file for ath drivers
  wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
  wifi: ath12k: add factory test mode support

Rajat Soni (1):
  wifi: ath12k: Fill pdev id for fw test cmd

---
v2:
  -Rebased on latest ath ToT
---

 drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/core.c        |  19 +-
 drivers/net/wireless/ath/ath12k/core.h        |  13 +
 drivers/net/wireless/ath/ath12k/debug.h       |   1 +
 drivers/net/wireless/ath/ath12k/dp.c          |   3 +
 drivers/net/wireless/ath/ath12k/mac.c         |  13 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   1 +
 drivers/net/wireless/ath/ath12k/testmode.c    | 413 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/testmode.h    |  42 ++
 drivers/net/wireless/ath/ath12k/wmi.c         |  38 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |  23 +-
 .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
 13 files changed, 625 insertions(+), 72 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)


base-commit: f24dee89bb8a7ef33c28e31632b1f3dd4e196413
-- 
2.17.1

