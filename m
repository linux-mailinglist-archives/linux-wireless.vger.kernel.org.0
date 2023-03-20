Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496E76C1CDD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 17:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjCTQxF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 12:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjCTQwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 12:52:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE8DBF4
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 09:44:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KESDoX011008;
        Mon, 20 Mar 2023 16:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=AfPDVaPT7DknOKvR9smlTFb/9+GtHKjYr+BwH3vGftQ=;
 b=fSxmX0dZkandrdqX82Ee3UP2qR1dcqdJYBRLxuDmthWNb4OnpLjwAH9V5N46JXrRtund
 9/oALW3KmpvKC6rNLjUDBhPrlBowtzvQMc4W8GcAoCetpxyCNEZnn6qIfxdq0l6gVy+v
 7RPWW/RBTZj4X0hiv6wQktFmD27NMFHDE3U3Jnjav2EF8v6NNWgcAiqkmbj0bJY9K8k1
 Jbg4A0iZvAPERYpKfk6MgixcHP22wxzjxbrPh5zEhfiYMCZcyhOgUvTUMScJZypjRuDN
 IgK1cDMbczo0PE3plmTnTMrkEROrJCrfvn3bLJA8nTfaM5Q7wHsJgoiBgFUTB1heDMGr +Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pes8p0dce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KGi1QG019151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:01 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 09:43:59 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v2 0/4] Add AP power save support
Date:   Mon, 20 Mar 2023 22:13:30 +0530
Message-ID: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DyIdbfmgtdrxsHDgleQgYHmhTYRW79IC
X-Proofpoint-ORIG-GUID: DyIdbfmgtdrxsHDgleQgYHmhTYRW79IC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AP power save feature is enabled when the driver and hardware
supports. If the driver suppots this feature then driver will
advertise this flag SUPPORTS_AP_PS to enable the AP power save
in mac80211.

AP goes into the power save mode, if no stations are connected
and it will come out of power save as and when any of the station
associate to it. Also, during the power save tx chain mask is
reduced to 1x1 until the any station connects with more than
1x1 chain mask.

Rename NL80211_CMD_SET_BEACON to  NL80211_UPDATE_AP to make use
of this command to configure more AP parameters which can vary
at the run time of the BSS like AP power save config.

A new nl80211 attribute NL80211_ATTR_AP_PS is introduced for
this AP power save configuration from user space which is used
along with the NL80211_CMD_UPDATE_AP.

Venkateswara Naralasetty (4):
  wifi: nl80211: rename NL80211_CMD_SET_BEACON to NL80211_CMD_UDPATE_AP
  wifi: nl80211: add configuration support for ap power save
  wifi: mac80211: notify BSS change upon AP power save change
  wifi: ath11k: add AP power save support

v2: Updated the commit log in patch 4.

 drivers/net/wireless/ath/ath11k/core.c        |  8 +++
 drivers/net/wireless/ath/ath11k/core.h        |  8 +++
 drivers/net/wireless/ath/ath11k/hw.h          |  1 +
 drivers/net/wireless/ath/ath11k/mac.c         | 58 +++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c         | 32 +++++++++
 drivers/net/wireless/ath/ath11k/wmi.h         |  8 +++
 drivers/net/wireless/ath/ath6kl/cfg80211.c    | 11 +--
 drivers/net/wireless/ath/wil6210/cfg80211.c   | 14 ++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 11 +--
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 15 ++--
 .../wireless/microchip/wilc1000/cfg80211.c    | 11 +--
 .../net/wireless/quantenna/qtnfmac/cfg80211.c | 11 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 12 +++-
 include/net/cfg80211.h                        | 42 +++++++++--
 include/net/mac80211.h                        |  7 +-
 include/uapi/linux/nl80211.h                  | 28 +++++---
 net/mac80211/cfg.c                            | 39 +++++++----
 net/mac80211/debugfs.c                        |  1 +
 net/wireless/nl80211.c                        | 32 ++++++---
 net/wireless/rdev-ops.h                       | 10 +--
 net/wireless/trace.h                          | 70 ++++++++++---------
 21 files changed, 327 insertions(+), 102 deletions(-)

-- 
2.25.1

