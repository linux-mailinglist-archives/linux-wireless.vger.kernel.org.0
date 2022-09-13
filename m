Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45425B672E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 07:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIMFPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 01:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIMFPk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 01:15:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D74BA43
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 22:15:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D57bbV017116;
        Tue, 13 Sep 2022 05:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=QmtkSeBx6LS4X0zBnDmF+2wqNay/GCydyv7WDu3ylbI=;
 b=lFb3VHTG5waO9oAXueC+ZUs+qRfPv/5X6dN3fQsoWiFD49O2PkGViTVuXkuAuaKd7LVE
 wKjHb7kasVvPmtiarF6cd0L8IOLcZhfQwgFrAofz2soH1bCoFC9IkWpBVrxJOz4DurWI
 pzcGQSK5CQ/arhmXTgIh1dkfhz1jkeL3wf0tATaNfIToPZmpa66N3dHMNIFNIqWk1r1E
 5vVtyLXaTajkiu86Z1nj/zWrwi8P7i6MdNpmvxSv1TRi8Ju3gf6Cgre3AME+WkpGh6Kx
 uiXRdISqdQbnD44QqSFfVfa5Jn6OKokVRcEZXjFNzjGMosZJRTNqD6p4Aw2s12QSmoaR lg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk6ke4cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D5FY60004449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:34 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 22:15:32 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 00/15] wifi: ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
Date:   Tue, 13 Sep 2022 01:15:03 -0400
Message-ID: <20220913051518.23051-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zzQ9VgqsrgWsJ6D_CSW7lxKQ7GyB01hY
X-Proofpoint-ORIG-GUID: zzQ9VgqsrgWsJ6D_CSW7lxKQ7GyB01hY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=900 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v3: 
   1. added "ath11k: fix a possible dead lock caused by ab->base_lock".
   3. deleted "ath11k: add support for extended wmi service bit" which is alreay upstream.

v2:
   1. change some minor comments by Kalle.
   2. rebased to ath.git ath-202112220603

Depends on one patch:
[v5] cfg80211: save power spectral density(psd) of regulatory rule
https://patchwork.kernel.org/project/linux-wireless/patch/20210928085211.26186-1-wgong@codeaurora.org/

It introduced some new concept:
power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
power spectral density(psd)

This patchset is to implement the new rules for 6 GHz band in
ath11k.

ath11k parsed the reg rules from new wmi event
WMI_REG_CHAN_LIST_CC_EXT_EVENTID and parse the
transmit power envelope element in beacon of AP
and then set new wmi cmd WMI_VDEV_SET_TPC_POWER_CMDID
to firmware when connect to 6G AP, also support backward
compatibility with firmware which not support new wmi
cmd WMI_VDEV_SET_TPC_POWER_CMDID.

Baochen Qiang (1):
  wifi: ath11k: fix a possible dead lock caused by ab->base_lock

Wen Gong (14):
  wifi: ath11k: Add support to parse new wmi event for 6 GHz regulatory
  wifi: ath11k: add support to select 6 GHz Regulatory type
  wifi: ath11k: allow only one interface up simultaneously for WCN6855
  wifi: ath11k: store cur_regulatory_info for each radio
  wifi: ath11k: update regulatory rules when interface added
  wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band
    for station
  wifi: ath11k: save power spectral density(psd) of regulatory rule
  wifi: ath11k: add parse of transmit power envelope element
  wifi: ath11k: save max tx power in vdev start response event from
    firmware
  wifi: ath11k: fill parameters for vdev_set_tpc_power wmi command
  wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
  wifi: ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for
    6 GHz
  wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
  wifi: ath11k: send TPC power to firmware for 6 GHz station

 drivers/net/wireless/ath/ath11k/core.c |   6 +
 drivers/net/wireless/ath/ath11k/core.h |  40 ++
 drivers/net/wireless/ath/ath11k/hw.c   |  17 +
 drivers/net/wireless/ath/ath11k/hw.h   |   5 +
 drivers/net/wireless/ath/ath11k/mac.c  | 539 +++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   5 +-
 drivers/net/wireless/ath/ath11k/reg.c  | 105 +++-
 drivers/net/wireless/ath/ath11k/reg.h  |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.c  | 728 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.h  | 210 +++++++
 10 files changed, 1608 insertions(+), 53 deletions(-)


base-commit: e5da5e8c54e27d8fa86765cd733c1a05aee53ae9
prerequisite-patch-id: d0941cb1e08f82e9bd5feaf01b160807b4b0faa9
prerequisite-patch-id: 8ed14a45e891683ebc28d3fe1c9405430561b09f
-- 
2.31.1

