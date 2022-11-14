Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5275628A52
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiKNUT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiKNUTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71ACF7
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:25 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEHQE5F022027;
        Mon, 14 Nov 2022 20:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5leXdxAFfvB/GoG0Kak9Zli7VQ6QQKfXbYUkGYPS12s=;
 b=XDubkmcF3ma+qxUDCk8VUG3fww5PmA6MYEY1YK0AZdvxejmg0azsf/Xl67wv/CfrilMc
 chKwJ/T2p0a8JftHcnLSK8etu+wli9hyJiAL/d2weSBhkJoNRoX8Nhwc7DREYtsdFWe9
 SVSGYtUVygi5QDv2ntPGLilGI/0ASEjsk6Nr9O04VOKRnjWMYmBXTLYzt6UYLUmW+Onx
 tYbfNbBz7NbBHfXO3sLqdI82T2awfjOsnYVhZCG7A0hqOSLnWQNCzN/toDome6Y/rbZX
 k/Jx35gFCrmI/2e9zibnNMCnkSWFrdaYzNvJfaqA+QrlQZDz10G+qxpyr8aGPPoTyUXs 3g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kut23gghr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJL00025510
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:21 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:21 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 00/10] MBSSID and EMA support in AP mode
Date:   Mon, 14 Nov 2022 12:19:02 -0800
Message-ID: <20221114201912.22893-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bgnj7mRAQL91YbS2U0paw2q3A4WQ-BLe
X-Proofpoint-ORIG-GUID: Bgnj7mRAQL91YbS2U0paw2q3A4WQ-BLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for enhanced multiple BSSID (EMA AP) in MAC80211 and
ath11k driver.

All patches in this version are based on wireless-next tree.

Aloka Dixit (10):
  mac80211: generate EMA beacons in AP mode
  ath11k: add WMI resource config for EMA
  ath11k: set MBSSID and EMA driver capabilities
  ath11k: MBSSID configuration during vdev create/start
  ath11k: create a structure for WMI vdev up parameters
  ath11k: rename struct wmi_vdev_up_cmd members
  ath11k: configure MBSSID device parameters
  ath11k: move vif parameter setting in a different function
  ath11k: EMA beacon support
  ath11k: configure WPA and RSN parameters for nontransmitting interface

 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/hw.c   |   3 +
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 361 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.c  |  34 ++-
 drivers/net/wireless/ath/ath11k/wmi.h  |  66 ++++-
 include/net/mac80211.h                 |  68 +++++
 net/mac80211/cfg.c                     |   7 +-
 net/mac80211/ieee80211_i.h             |  10 +-
 net/mac80211/tx.c                      | 134 ++++++++-
 10 files changed, 621 insertions(+), 65 deletions(-)


base-commit: 901c247f9687b5aecc950a931a3b0e1930d02bfd
-- 
2.17.1

