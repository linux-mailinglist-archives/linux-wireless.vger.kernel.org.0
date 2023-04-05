Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF86D8A7C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjDEWRS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 18:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjDEWRM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 18:17:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C776B7
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 15:17:11 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335L22XI008457;
        Wed, 5 Apr 2023 22:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=R8ncFvCLQPnPx7umK9IQvUe/sHJyGe3E6GTifB1FMBo=;
 b=hwxy2wOnVrg4EJrPsSjLVh+QQRt9m6SnzpU3sFfpLpyOcA889SQiaTlY0OKPZ2cJ2E+1
 eCpfZf1i+vsGGrB5Q4Rf5vMRo5bQlMeUevO+8LMpivu6jX4yJlWkqDz3SFlJdvqwLFrg
 bmMRdS1IQn2thAPD1+PEu+hvXX6PLjizRbptPRQ/2Klf98ky1ULRyBlhQpjynx8tnqNp
 120VVJIrA+axeRrW1tlYfAlWmNLy3HdMkna4YIBPz2azgjhxQjsfIhgUzKGFtA6bqTh3
 r9I/X10JlsXp+EfiqQ7I4wXYcB+hu+MDoaaoWSrXQLOzNlARHUnSC1vuMDgrTBisQIk6 DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ps6vf9g8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 22:16:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335MGu4K030975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 22:16:56 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 15:16:56 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/7] v3: ath11k: MBSSID and EMA support in AP mode.
Date:   Wed, 5 Apr 2023 15:16:41 -0700
Message-ID: <20230405221648.17950-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3l3FquQ_rhh09a2tSuR8evKJYe9hbAIY
X-Proofpoint-ORIG-GUID: 3l3FquQ_rhh09a2tSuR8evKJYe9hbAIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050199
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for multiple BSSID (MBSSID) and enhanced multi-BSSID
advertisements (EMA) features in AP mode.
Set the extended capabilities, WMI resource config parameters to
advertise the driver support.
Set the MBSSID profile parameter such as BSSID index, total BSS count.
Retrieve and propagate the EMA beacon templates to firmware.
Set the vif security parameters for the non-transmitting profiles.

This is the next version for the following series:
https://patchwork.kernel.org/project/linux-wireless/list/?series=695229&state=%2A&archive=both
- Added 'wifi: ' to the title in all patches.
- Patch [v2,01/10] mac80211: generate EMA beacons in AP mode is
merged hence no dependency.
- Patch [v2,05/10] ath11k: create a structure for WMI vdev up parameters
is deleted from this version as it was not adding much value.
- Patch [v2,09/10] ath11k: EMA beacon support is split into two patches,
  6/7 and 7/7 to make the EMA additions clearer.
- Patch [v2,10/10] ath11k: configure WPA and RSN parameters for
  nontransmitting interface is incorporated in 6/7 as it is required
  to complete the MBSSID related support.

Aloka Dixit (7):
  wifi: ath11k: driver settings for MBSSID and EMA
  wifi: ath11k: MBSSID configuration during vdev create/start
  wifi: ath11k: rename MBSSID fields in wmi_vdev_up_cmd
  wifi: ath11k: MBSSID parameter configuration in AP mode
  wifi: ath11k: refactor vif parameter configurations
  wifi: ath11k: MBSSID beacon support
  wifi: ath11k: EMA beacon support

 drivers/net/wireless/ath/ath11k/hw.c  |   3 +
 drivers/net/wireless/ath/ath11k/hw.h  |   1 +
 drivers/net/wireless/ath/ath11k/mac.c | 307 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.c |  26 ++-
 drivers/net/wireless/ath/ath11k/wmi.h |  45 +++-
 5 files changed, 345 insertions(+), 37 deletions(-)


base-commit: bea046575a2e6d7d1cf63cc7ab032647a3585de5
-- 
2.39.0

