Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA576E116
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjHCHRd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 03:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjHCHRc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 03:17:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F81FF
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 00:17:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3736tPbv012904;
        Thu, 3 Aug 2023 07:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=/+SWBkaNqbq4PTexI2U/+sTAk2dhPJMwEtSmyDHUKuY=;
 b=WzwTl8UFvqJDlN7RWdXAoy7j1qUgkN3eiBRDxyUnwYvL24eY6ANxT8fwfVFTViUCKVqO
 GJee7tMAlcLRnCWlleOmj4b4Oq/vaxkaaItgnJmpivPXXVvjr8WQ8V291gpQ26OAEEpH
 CdiKbRLUJ9EbXALZuk3+Qg8IeiA1MyiYv1W7P/GVdUsOjSCoArwQnrlHuwMydqSkJ/6c
 8ynYz05ov/wX5SX+3A9BxYYUDxmHxtjPmx+GBTbxO9K3o1SXytKzOac2+HbO3FJboWHG
 2knbenYVVAUV2VGYx1mpdedAoq4K0ANUoW/MvEaRa6pVqS/6R+lpMZ8pYuKcyqUTHQ/z LA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s82wx8f7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:17:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3737HH8b017300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 07:17:17 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 00:17:15 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH v5 0/5] fix wrong TX power and frequency in regdomain by dynamic switch 6 GHz reg rules of LPI/SP/VLP for station mode
Date:   Thu, 3 Aug 2023 03:16:56 -0400
Message-ID: <20230803071701.15084-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QiWHiHEd7-oDUQOZ5mC-xSs3xxwFT0Yc
X-Proofpoint-GUID: QiWHiHEd7-oDUQOZ5mC-xSs3xxwFT0Yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_04,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=967 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v5: change per Kalle and rebased to ath.git ath-202306211808
   1. ath11k_ieee80211_ap_pwr_type_convert() to ath11k_reg_ap_pwr_convert()
   2. used list_first_entry_or_null() and add comments
   3. ath11k_dbg() to ath11k_warn()
   4. ath11k_hw_supports_6g_cc_ext() to ath11k_mac_supports_6g_cc_ext()
   5. add mesh in commit log

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
  wifi: ath11k: add support to select 6 GHz regulatory type
  wifi: ath11k: store cur_regulatory_info for each radio
  wifi: ath11k: update regulatory rules when interface added
  wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band
    for station

 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  28 +++++
 drivers/net/wireless/ath/ath11k/mac.h  |   3 +-
 drivers/net/wireless/ath/ath11k/reg.c  |  72 +++++++++---
 drivers/net/wireless/ath/ath11k/reg.h  |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c  | 150 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.h  |   5 +
 7 files changed, 201 insertions(+), 62 deletions(-)


base-commit: b21fe5be53eb873c02e7479372726c8aeed171e3
-- 
2.40.1

