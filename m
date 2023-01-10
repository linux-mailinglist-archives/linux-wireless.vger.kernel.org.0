Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B56664005
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 13:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjAJMNJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 07:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbjAJMMf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 07:12:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D484C707
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 04:10:45 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A52AEO000718;
        Tue, 10 Jan 2023 12:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=8V6385O9I03FlBBmY00jjqr3kQVCNdGNU1h4m8bM3PY=;
 b=OPWVNmXto1KjHGHsUSt9sIV8qcZ4px30lamRSyvw38oZIFVKVpZVLQsuj8QS3/kgar3I
 nznjeeuN7EIWkiqaa8MxVFEQzgGUXPFXToeITK2ecgnnhV8VvXznOLX6R7XX72smhyaK
 EiD9IllrnlRMb8ckNUlWNYINp0PXjvsLf/yq2NzRlOY47mOaPoBQiAXpE1RXMjeNViiB
 tBh5iWs1NF3yf/tU0SnTVyRFVvVhH5bwNfkStaV/fZroN153N3OukRTow7uKAVkh4QRK
 dONGLLVf3FSWzM1EpPRu3n8WQOO3DQLNTeBnOvfcXAKTljrrk0TxilIyHmo945L3ubyd wQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n11fs8u45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:10:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ACAdv2020031
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:10:39 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 04:10:37 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 0/3] wifi: ath11k: add support to parse new WMI event for 6 GHz
Date:   Tue, 10 Jan 2023 17:40:21 +0530
Message-ID: <20230110121024.14051-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LYthq5Ysg8ZVwLaH7oodpOknuKlxrQvI
X-Proofpoint-ORIG-GUID: LYthq5Ysg8ZVwLaH7oodpOknuKlxrQvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=935 suspectscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100073
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to support different power levels of 6 GHz AP and client,
new WMI event for regulatory - WMI_REG_CHAN_LIST_CC_EXT_EVENTID is
added in firmware. This event provides new parameters required for
6 GHz regulatory rules.

Firmware advertises its capability of handling new event in WMI
service ready event. Based on that, host needs to set
host_service_flags in WMI init command to indicate that host supports
processing of new WMI event. Based on advertised host capability,
firmware decides to send old event WMI_REG_CHAN_LIST_CC_EVENTID or
new event WMI_REG_CHAN_LIST_CC_EXT_EVENTID.

Add support for parsing 2.4 GHz, 5 GHz and 6 GHz reg rules and other
parameters from WMI_REG_CHAN_LIST_CC_EXT_EVENTID.

Aditya Kumar Singh (3):
  wifi: ath11k: use proper regulatory reference for bands
  wifi: ath11k: add support to parse new WMI event for 6 GHz
  wifi: ath11k: add debug prints in regulatory WMI event processing
---
v3: fix new warnings in [2/3] and [3/3]. (exceeds 90 columns warnings)

v2: fix warning reported by kernel test robot in [2/3]
---
 drivers/net/wireless/ath/ath11k/reg.c |  59 ++-
 drivers/net/wireless/ath/ath11k/wmi.c | 571 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h | 333 +++++++++++++--
 3 files changed, 873 insertions(+), 90 deletions(-)


base-commit: 5834aa7099b0f7c16cfc24af0aca4e065c568347
-- 
2.17.1

