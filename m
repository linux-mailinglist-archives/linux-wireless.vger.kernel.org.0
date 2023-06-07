Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC18725B0C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbjFGJs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 05:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbjFGJs5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 05:48:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80D2E49
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 02:48:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576696F005271;
        Wed, 7 Jun 2023 09:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=/nI7CUzaIcSsaCUjTTzxiqtpVi7uGvWztGJLNE6bl4k=;
 b=JL6k97WgUGhpOvUrAGpwi0GOwKNFdh1qLcTpwu79zlLkfiDgkdee8oQ9dWjxoOscWZ/w
 vGdvYKbm1+ZtaAvD9rG9SBERX2Vqc1AZnRALh6nqLHnQBBYB4kbQuudyYjCOeboPL9bI
 1FGIHSR2PD5MGV2j03QqJYbHiYIKLi6pWHY4PQQpq2VtmQIXlyMkS+O75MyeatLwxd9i
 kY5xJ2TiUpREXZScx0ClAbcOFya7UNikr5OXmxjiEyg1Iwno1RHJM+l/iCsvxvye7SYI
 8CjFUbXxY3ZOFIRAwsWrq2B4d01qCYGpTS+/acf11qEz7jBKoGgyQf2doQCVB++vqav4 1A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7k1h6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 09:48:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3579moQN031420
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 09:48:50 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 02:48:34 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH v4 0/5] fix wrong TX power and frequency in regdomain by dynamic switch 6 GHz reg rules of LPI/SP/VLP for station mode
Date:   Wed, 7 Jun 2023 05:48:05 -0400
Message-ID: <20230607094810.26707-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r9cSM7-N8IT6eIb29f44UOTkF8kbf7ki
X-Proofpoint-ORIG-GUID: r9cSM7-N8IT6eIb29f44UOTkF8kbf7ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently when wlan load up, station always use the 6 GHz reg rules of
AP mode by commit 91fa00fa6922 ("wifi: ath11k: add support to parse new
WMI event for 6 GHz"), then the tx power and frequency are not correct,
so fix it by dynamic switch to client mode LPI/SP/VLP for station after
interface added and connected for station.

v4: (NOT depends to any patch now).
   1. removed patches which depends on
      wifi: cfg80211: save Power Spectral Density (PSD) of the regulatory rule
      https://lore.kernel.org/linux-wireless/20230315132904.31779-3-quic_adisi@quicinc.com/
      removed:
      [v3,08/15] wifi: ath11k: save power spectral density(psd) of regulatory rule
      [v3,09/15] wifi: ath11k: add parse of transmit power envelope element
      [v3,10/15] wifi: ath11k: save max tx power in vdev start response event from firmware
      [v3,11/15] wifi: ath11k: fill parameters for vdev_set_tpc_power wmi command
      [v3,12/15] wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
      [v3,13/15] wifi: ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 GHz
      [v3,14/15] wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      [v3,15/15] wifi: ath11k: send TPC power to firmware for 6 GHz station

   2. rebased to ath.git ath-202304281700

   3. deleted "wifi: ath11k: Add support to parse new wmi event for 6 GHz regulatory" which is alreay upstream.

link of v3: 
   [v3,00/15] wifi: ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
   https://patchwork.kernel.org/project/linux-wireless/cover/20220913051518.23051-1-quic_wgong@quicinc.com/

v3:
   1. added "ath11k: fix a possible dead lock caused by ab->base_lock".
   3. deleted "ath11k: add support for extended wmi service bit" which is alreay upstream.

v2:
   1. change some minor comments by Kalle.
   2. rebased to ath.git ath-202112220603

Baochen Qiang (1):
  wifi: ath11k: fix a possible dead lock caused by ab->base_lock

Wen Gong (4):
  wifi: ath11k: add support to select 6 GHz Regulatory type
  wifi: ath11k: store cur_regulatory_info for each radio
  wifi: ath11k: update regulatory rules when interface added
  wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band
    for station

 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/hw.c   |   6 ++
 drivers/net/wireless/ath/ath11k/hw.h   |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  |  33 +++++++
 drivers/net/wireless/ath/ath11k/mac.h  |   2 +-
 drivers/net/wireless/ath/ath11k/reg.c  |  72 +++++++++++---
 drivers/net/wireless/ath/ath11k/reg.h  |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.c  | 131 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.h  |   5 +
 9 files changed, 198 insertions(+), 60 deletions(-)


base-commit: 0a00db612b6df1fad80485e3642529d1f28ea084
-- 
2.40.1

