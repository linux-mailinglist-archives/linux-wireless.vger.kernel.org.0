Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F36A6954
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCAJDE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCAJDD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:03:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9507DA5
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:03:01 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3214iOxp005324;
        Wed, 1 Mar 2023 09:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=W2dhDSAPHsdK4oAXnEzmr3LYzH6uiSCV0YSz2jr0tE0=;
 b=Adq9CA3byVoymRsn/SK+y9b3b2Uh3q5fmKCudXEGRzndji2II3tA2cr8/B6YgXh1tuII
 egQ2v/G/dJrO6muVjks8/0GI4cH/yJeeVn+ANnNjQBNLPJtXX/vtKOHv0bTFcvEhFXzh
 uXzql9a/jTk6bogah51iHixc/97M0xr/sY9QyFa7CfGEqX6FpbFs/NxfgHpCYL6EOrRD
 ux8kxN2zq5Yk+qJb7EQKm98u8/oplOPo2ZXkvmwvVBujEgy8GMbAf47vo2pg25x03NSU
 9U8RxNAIZFvOWTvPXyiUXVEjsCzfQWXGbYFIearHDENIbJ5R5jtjhhI1tQz8n1Qrwkke fQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1ccxm2yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 09:02:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32192vGB014833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 09:02:57 GMT
Received: from xinyling-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 01:02:56 -0800
From:   Xinyue Ling <quic_xinyling@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: nl80211: Add support to specify channel width for scan
Date:   Wed, 1 Mar 2023 17:02:38 +0800
Message-ID: <20230301090242.1613672-1-quic_xinyling@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sQaN6I27JY5XCL2_7wpFKADFqYKLd5SN
X-Proofpoint-ORIG-GUID: sQaN6I27JY5XCL2_7wpFKADFqYKLd5SN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1011 mlxlogscore=943 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

nl80211_trigger_scan() processes scan request netlink attributes,
defined in enum nl80211_attrs, and fills struct
cfg80211_scan_request *request.

Currently there is no logic to fill this member:
	enum nl80211_bss_scan_width scan_width;

We have a requirement to fill this member for drone use cases, in
which drone controller needs to scan and connect to drone in 5 MHz
or 10 MHz channel width (may support other channel widths lower
than 20 MHz later).

Unfortunately there is not an existing attribute in enum
nl80211_attrs that has enum nl80211_bss_scan_width semantics. The
only attribute which has those semantics is NL80211_BSS_CHAN_WIDTH
in enum nl80211_bss, and of course we can't mix attributes from
different enums in a netlink command, at least not at the same
nesting level.

enum nl80211_attrs does define another attribute,
NL80211_ATTR_CHANNEL_WIDTH, but it has enum nl80211_chan_width
semantics.

In order to support the requirement to fill the scan_width with
an enum nl80211_bss_scan_width value we seem to have two options:
1) Use NL80211_ATTR_CHANNEL_WIDTH and convert from enum
nl80211_chan_width semantics to enum nl80211_bss_scan_width semantics
when filling struct cfg80211_scan_request *request.
2) Introduce a new NL80211_ATTR_SCAN_CHANNEL_WIDTH attribute to
enum nl80211_attrs that has enum nl80211_bss_scan_width semantics.

The following series of patches is the implementations of above two
options. In order to make them a series, a revert patch is included,
which can be ignored. Please review and decide which option is more
reasonable and acceptable.

Xinyue Ling (4):
  nl80211: Add 4/8/16 MHz BSS control channel width definitions
  wifi: nl80211: Add support to specify channel width for scan (option
    1)
  Revert "wifi: nl80211: Add support to specify channel width for scan
    (option 1)"
  wifi: nl80211: Add support to specify channel width for scan (option
    2)

 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 34 ++++++++++++++++++++++++++++++++--
 net/wireless/nl80211.c       | 14 ++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.25.1

