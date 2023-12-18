Return-Path: <linux-wireless+bounces-894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0538168F2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 09:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA671F22F70
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3810A09;
	Mon, 18 Dec 2023 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MtsQaFpx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392110976
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI8qPbF006372;
	Mon, 18 Dec 2023 08:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=ZCgSpapPmPGOsg67FChX
	U671PccySgTTlUM9qqlr7I4=; b=MtsQaFpxfGVJ3+O5SiTaYqgfilLG2vCThdqC
	X1aVcQAudDTfE4hwGvpCThOLdivskwQI4Tv+ARybnnBKTHptzVMmyHdKxA2S60Ik
	8Z0i0e8VFG8F/NWRBQvr+AXnygOdXfHo4ZX2WhjlH54AD5oh87ogt8KDDzZcPtpQ
	8BQMLgl9bv3m+EeN/F+v8IaWoH4S+1vwgQT3MTUB818uFu24ABQJFFAhyD1kjXq1
	+ijftpOJW3lJtoY5fCvWBwDFxt+pUE2f8UhlYVFjg7RdcDArgTxZ5nw1BDqrbI3+
	iJ9vzoZWkLDCnKwAr8D28/RtzLLLhSb9m2iyn4akcjyw2+vA+Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0g0hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:58:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI8wuuO011355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:58:56 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 00:58:54 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v10 00/12] wifi: ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
Date: Mon, 18 Dec 2023 16:58:32 +0800
Message-ID: <20231218085844.2658-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a7BrtJkM_QLmTqSq0Kgf4pDrFQI9x5X0
X-Proofpoint-GUID: a7BrtJkM_QLmTqSq0Kgf4pDrFQI9x5X0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=975 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180064

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

v10:
 1. [PATCH 02/12] wifi: ath11k: store cur_regulatory_info for each radio
  a. s/muti/multi/
 2. [PATCH v9 09/12] wifi: ath11k: fill parameters for vdev set tpc power WMI command
  a. add idle_ps check when calculating EIRP.

v9；
 1. [PATCH 02/12] wifi: ath11k: store cur_regulatory_info for each radio:
  a. add check to soc->reg_info_store in case memory allocation fails.
  b. remove irrelevant change w.r.t commit message.

 2. [PATCH 04/12] wifi: ath11k: update regulatory rules when interface added:
  a. remove unnecessary parenthesis.
  b. remove irrelevant change w.r.t commit message.

 3. [PATCH 12/12] wifi: ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 GHz
drop below patch:
  a. do not discard txpower setting for BSS_CHANGED_TXPOWER.
  b. renamed subject as below and update commit log:
  	wifi: ath11k: use WMI_VDEV_SET_TPC_POWER_CMDID when
    		EXT_TPC_REG_SUPPORT for 6 GHz

 4. rebased to ToT.

v8:
    add my own s-o-b tag to each patch if not present. Also rebased to ToT.

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
  wifi: ath11k: use WMI_VDEV_SET_TPC_POWER_CMDID when
    EXT_TPC_REG_SUPPORT for 6 GHz

 drivers/net/wireless/ath/ath11k/core.h |  40 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 515 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   3 +
 drivers/net/wireless/ath/ath11k/reg.c  |  89 ++++-
 drivers/net/wireless/ath/ath11k/reg.h  |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.c  | 234 ++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h  |  69 ++++
 7 files changed, 886 insertions(+), 70 deletions(-)


base-commit: 6c4f0b0146c7c9c7791dc1a55e13e317897e91ac
-- 
2.25.1


