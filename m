Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F97F415B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjKVJQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 04:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjKVJQU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 04:16:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D3E1A2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 01:16:16 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM7BNjF018219;
        Wed, 22 Nov 2023 09:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=H/VVYSY/t5R/HqAo1ZFABX4r81hnwduLE/DpKtLp57o=;
 b=LOVZnz3gM1Z1lDRxawmHfbJP62TVf3677xGpuF3bHeaLY1D3+lZRIolmHs4UsUT/wyki
 Fg8v/s05CcXymWrUystABsaR500nl4oEpAI0FKcL1vQ9Kr3wwl8msBt/VfO2PdiXB+45
 ncuqydyLPh4dQoH7enAaQeBnw8PcgQDzlU0Ato5KrilBfDFJhEt5QMgm7gDynRhptl+6
 M769ObPpbmJ0QQsCVJWGkUc3elpFFnWzKWmxP+Ur2o2DblcoyR5vA8bpTiO2hOIfwQJL
 +GDHFq6QICDwR2l/rqWAcDP83YESQA5n/OFhzMx1lPxjGlm/NMoApUZwzVts8xC3b0S4 hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh8mw8ygq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:16:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM9G9kk008001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:16:09 GMT
Received: from bqiang-Celadon-RN.lan (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 01:16:08 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v7 00/12] wifi: ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
Date:   Wed, 22 Nov 2023 17:15:41 +0800
Message-ID: <20231122091553.10837-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g_SMLb0OzHbMkfPFyCM6O35S-Dk8BP6S
X-Proofpoint-ORIG-GUID: g_SMLb0OzHbMkfPFyCM6O35S-Dk8BP6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxlogscore=767
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This introduced some new concept:
power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
power spectral density(psd)

This patchset is to implement the new rules for 6 GHz band in
ath11k.

ath11k parsed the reg rules from new WMI event
WMI_REG_CHAN_LIST_CC_EXT_EVENTID and parse the
transmit power envelope element in beacon of AP
and then set new WMI command WMI_VDEV_SET_TPC_POWER_CMDID
to firmware when connect to 6G AP, also support backward
compatibility with firmware which not support new wmi
cmd WMI_VDEV_SET_TPC_POWER_CMDID.

v7: address review comments per Kalle, Jeff and Aditya. Also rebased to ToT.

v6: (NOT depends to any patch now)
   1. The dependent patch "wifi: cfg80211: save power spectral density(psd) of regulatory rule"
      has upstream to wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=ddd7f45c899f7524bdbe6a32fe4906cde8b07b9b
      The prerequisite-patch is cherry-pick from wireless-next
      So add back the other patches in v3 since no dependency to cfg80211 public patch above now.
      [v3,08/15] wifi: ath11k: save power spectral density(psd) of regulatory rule
      [v3,09/15] wifi: ath11k: add parse of transmit power envelope element
      [v3,10/15] wifi: ath11k: save max tx power in vdev start response event from firmware
      [v3,11/15] wifi: ath11k: fill parameters for vdev_set_tpc_power wmi command
      [v3,12/15] wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
      [v3,13/15] wifi: ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 GHz
      [v3,14/15] wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      [v3,15/15] wifi: ath11k: send TPC power to firmware for 6 GHz station
   2. rename some "6g" to "6ghz"
   3. remove "static" for ath11k_reg_ap_pwr_convert()
   4. add 20 Mhz check in ath11k_mac_get_eirp_power()
   5. remove min_t() in ath11k_mac_fill_reg_tpc_info() for not is_tpe_present
   6. rebased to ath-202309051328

   link of v5:
   [PATCH v5 0/5] fix wrong TX power and frequency in regdomain by dynamic switch 6 GHz reg rules of LPI/SP/VLP for station mode
   https://lore.kernel.org/linux-wireless/20230803071701.15084-1-quic_wgong@quicinc.com/

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

Wen Gong (11):
  wifi: ath11k: add support to select 6 GHz regulatory type
  wifi: ath11k: store cur_regulatory_info for each radio
  wifi: ath11k: update regulatory rules when interface added
  wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band
    for station
  wifi: ath11k: save power spectral density(PSD) of regulatory rule
  wifi: ath11k: add parse of transmit power envelope element
  wifi: ath11k: save max tx power in vdev start response event from
    firmware
  wifi: ath11k: fill parameters for vdev set tpc power WMI command
  wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
  wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
  wifi: ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for
    6 GHz

 drivers/net/wireless/ath/ath11k/core.h |  40 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 516 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   5 +-
 drivers/net/wireless/ath/ath11k/reg.c  |  89 ++++-
 drivers/net/wireless/ath/ath11k/reg.h  |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.c  | 231 ++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h  |  69 ++++
 7 files changed, 882 insertions(+), 74 deletions(-)


base-commit: 9a36440d929d134c56030a8492405708a143f580
-- 
2.25.1

