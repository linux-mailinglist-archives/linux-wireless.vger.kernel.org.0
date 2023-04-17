Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609BF6E3F18
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 07:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjDQFm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 01:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDQFmW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 01:42:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251AF40C3
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 22:42:14 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H4llJG024526;
        Mon, 17 Apr 2023 05:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0jKU9Mlm0ZKVHHJzbLmwZazaMsFq2HbOvPOZWngHFQY=;
 b=Da4Gdg+BBNKRw5BZCBN1xOVwWK+AAbklunk/VrEd0w59ppfygSJCQWq+a4JwrsDM7P/l
 IvkOAXEmhrkIRdX23XtlfmjMWSiucttoe+QPktWHs7HUKGVrEFECJh7m9hN/bl/EaJEm
 +DCRCVaKEyK5BPypoA1bGYy5hqMjmqMlZnoFNk+ETPu/ovBcHsu1t/eDPA7Jcd6clxPT
 MPmReY+0ev0LZcspq913qsVzUDOunQeOB2F0MUBIqV9liqsDsmZM5VxK9xwKr+vovRFB
 xHL+WOS6jW+PI81OyiE35nHr1lu5FKZHIEA7o1ut3L37I5QESyrfPBNi1gaMpjB4k9bP UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymp4ap4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:42:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H5g1kc004995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:42:01 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 16 Apr 2023 22:41:59 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v5 0/3] wifi: ath11k: Enable low power mode when WLAN is not active on WCN6750
Date:   Mon, 17 Apr 2023 11:11:42 +0530
Message-ID: <20230417054145.12359-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bz-md0TBXOM8ok0B3GDp410a7P5qIy5n
X-Proofpoint-ORIG-GUID: bz-md0TBXOM8ok0B3GDp410a7P5qIy5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Send QMI MODE OFF command to firmware during WiFi OFF to put WCN6750
into low power mode.

Following command is used to suspend the device,
echo mem > /sys/power/state

On WCN6750, it has been verified that the power from the firmware is
complete turned off when the device is suspended.

Although the changes are specific to WCN6750, these changes act as a
framework and can be used to bring in the support on other ath11k
devices with a future patch.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Manikanta Pubbisetty (3):
  wifi: ath11k: Fix double free issue during SRNG deinit
  wifi: ath11k: Move hardware initialization logic to start()
  wifi: ath11k: Enable low power mode when WLAN is not active
---
V5:
 - Thorough testing of the changes on other supported ath11k hardware
 - rmmod path of other supported devices is kept unchanged; only WCN6750
   will make use of the changes
 - Code has been refactored in a way so that the changes are easier to review
 - Commit message changes to include the command used for testing

V4:
 - Code changes in ath11k_core_stop_device()

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

 drivers/net/wireless/ath/ath11k/ahb.c  |  42 +++
 drivers/net/wireless/ath/ath11k/core.c | 497 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/core.h |  10 +-
 drivers/net/wireless/ath/ath11k/hal.c  |   1 +
 drivers/net/wireless/ath/ath11k/hif.h  |  11 +
 drivers/net/wireless/ath/ath11k/mac.c  |  33 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  23 ++
 drivers/net/wireless/ath/ath11k/qmi.c  |   3 +-
 8 files changed, 429 insertions(+), 191 deletions(-)


base-commit: 177555b57ca0a0519c12a2bdb64309ddbb363e11
-- 
2.17.1

