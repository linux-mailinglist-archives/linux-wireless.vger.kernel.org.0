Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CBD765AA2
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjG0Rla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjG0Rl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:41:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6A9D9
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:41:22 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDemYk028271;
        Thu, 27 Jul 2023 17:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=p3M7We7saGxCgCIStPCFhyXFZCIQfKaQ7y9lyi6lH5Y=;
 b=YylRf4aP1tfXLXFRH1eIEtmjK+/gdFfMXMxrf02MXosLDPUsYCdMfutBrCQUFqW0kuBF
 keJxX1/CysPP2ehk8HyPxvk+M1KRhoM29M/8O8Ddw7esF1kzE67GFXFrzjrchBHXvT2U
 sIyA7IeZZrpCRaE2ov//BS02if5R2o5KvBx6N2JCfzZYEjpHB3KKISMBd07vGBsMsRY+
 fJB810SKjTxp/MbFw78HPk9xaYsvv1DXDhGUGlBU6VwxW/YcE7U4tL4Yos0R+6EX1ztr
 Udx3voI6+XizUY6qQ644lX6c29yxi+SOPx1fw9PuSOUbDzj4L9EE89PXIN+o2O5/LSyh Gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s34x6k90r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RHfFGp020195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:15 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 10:41:14 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v8 0/5] Additional processing in beacon updates (v8)
Date:   Thu, 27 Jul 2023 10:40:55 -0700
Message-ID: <20230727174100.11721-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7T6ozzwtFJ3Ty0skTnt6tnXpDwxw2aCZ
X-Proofpoint-ORIG-GUID: 7T6ozzwtFJ3Ty0skTnt6tnXpDwxw2aCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270160
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v8: Patches #1, #2 are new in this version which allow resetting
the interval to 0 once set to non-zero which was not possible earlier.
No functional changes to the remaining three patches from v7 here:
https://patchwork.kernel.org/project/linux-wireless/list/?series=693804&state=%2A&archive=both

v7: Resolved conflicts with MLO code changes.

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP. The configurations
may get changed whenever there is a change in beacon, e. g. when
a channel switch operation completes the new templates will be sent
by the userspace which reflects the new channel bandwidth. Process the
attributes for these features in NL80211_CMD_SET_BEACON as well.

- Replace the check for interval (for both features) with a new flag
'update' which is set only when the userspace requests an update to
the configuration. This allows the interval to be set to 0 and
templates deleted which wasn't allowed earlier as the attributes got
processed only if the interval was non-zero.
- Modify the local variable in nl80211_set_beacon() and input parameter
to rdev_change_beacon() from type struct cfg80211_beacon_data to
type struct cfg80211_ap_settings to support the new processing.
- Modify ieee80211_change_beacon() to reflect the new input parameter type.
- Modify driver specific functions pointed by change_beacon to reflect
the new input parameter type.
- Add the missing implementation in nl80211 and mac80211 to process
FILS discovery and unsolicited broadcast probe response configurations.


Aloka Dixit (5):
  wifi: nl80211: fixes to FILS discovery updates
  wifi: mac80211: fixes in FILS discovery updates
  wifi: cfg80211: modify prototype for change_beacon
  wifi: nl80211: additions to NL80211_CMD_SET_BEACON
  wifi: mac80211: additions to change_beacon()

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   4 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |   4 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   6 +-
 include/net/cfg80211.h                        |   6 +-
 include/uapi/linux/nl80211.h                  |  11 +-
 net/mac80211/cfg.c                            | 102 ++++++++++--------
 net/wireless/nl80211.c                        |  47 ++++++--
 net/wireless/rdev-ops.h                       |   2 +-
 net/wireless/trace.h                          |  54 +++++-----
 13 files changed, 159 insertions(+), 91 deletions(-)


base-commit: b2090d93d4b6f1c72a9793d5a171806b8468b7cb
-- 
2.39.0

