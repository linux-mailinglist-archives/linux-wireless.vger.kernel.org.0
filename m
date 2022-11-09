Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4943C623608
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 22:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKIVrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 16:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKIVrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 16:47:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B12FFC2
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 13:47:34 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9LkDCs005728;
        Wed, 9 Nov 2022 21:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=VV7ly2Dqm6UweAuAMenqAhQ9oCb0lE2XPWsvbFpB31A=;
 b=OgyArwqweJ/yBnjCKPrCdsJy5pg4gAaZ+Kqv3A4k/D/Fai5jpKsyLAJkL2ant8CJi/FL
 b2fyeMyT/K6XthNVcQxJWHfr8sAnHFrN+fu7SHGT1xerlEsHIAAep9duWkpPvwG9YEEM
 mIwmj0dxl+8Qo5MIAGow6Dh+MyOxRA4rKRuqz3jJLT3N7t5j5DospGGwsjMaOpMs+kDU
 DXA89eBF0wlS+mZ2V0rV6V1DNtVX0XI2VCktdEOyiAmg4n/OZfIOvCYTY4pDK2rszeq4
 LejrZjO46SkCe8J8Pfgf0sTrSNOynDN6DWkf0sU4CycBDlYhruXkV9MPad9Y6MrLKQMC pw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krg1y8skp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 21:47:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A9LlUGT029933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 21:47:30 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 9 Nov 2022 13:47:29 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v7 0/3] Additional processing in NL80211_CMD_SET_BEACON
Date:   Wed, 9 Nov 2022 13:47:17 -0800
Message-ID: <20221109214720.6097-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LPTw_ZKvXiN71tz_mpLT-ARl5wm7F3j1
X-Proofpoint-ORIG-GUID: LPTw_ZKvXiN71tz_mpLT-ARl5wm7F3j1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v7: Resolved conflicts with MLO code changes.

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace uses the NL80211_CMD_SET_BEACON command as these
attributes are not processed as part of this command.

- Modify the local variable in nl80211_set_beacon() and input parameter
to rdev_change_beacon() from type struct cfg80211_beacon_data to
type struct cfg80211_ap_settings to support the new processing.
- Modify ieee80211_change_beacon() to reflect the new input parameter type.
- Modify driver specific functions pointed by change_beacon to reflect
the new input parameter type.
- Add the missing implementation in nl80211 and mac80211 to process
FILS discovery and unsolicited broadcast probe response configurations.

Aloka Dixit (3):
  cfg80211: modify prototype for change_beacon
  nl80211: additional processing in NL80211_CMD_SET_BEACON
  mac80211: additional processing in ieee80211_change_beacon

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  4 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  4 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  6 ++-
 include/net/cfg80211.h                        |  2 +-
 net/mac80211/cfg.c                            | 38 ++++++++++---
 net/wireless/nl80211.c                        | 28 ++++++++--
 net/wireless/rdev-ops.h                       |  2 +-
 net/wireless/trace.h                          | 54 ++++++++++---------
 12 files changed, 102 insertions(+), 50 deletions(-)


base-commit: b8f6efccbb9dc0ff5dee7e20d69a4747298ee603
-- 
2.17.1

