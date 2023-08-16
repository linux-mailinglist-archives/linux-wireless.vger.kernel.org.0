Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87D77E8D7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345590AbjHPSjE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345326AbjHPSie (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 14:38:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A6C1B2
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 11:38:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GGV5Hg010516;
        Wed, 16 Aug 2023 18:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=j5FiUViInJUpu7hy3JmtCjMLBxZiBDIv7zgJG4pcp20=;
 b=omZ6hlnibyzAAvkt8RyK28N4OWBHSbwNsxYJMfw2I8EJAa1PvV3PaBQUFsHxgY3y/g0h
 H2WyyCSFtSX45iqsNAo0XbcbyPMDBSK8oLtlRaDBj5GFQHMQ/3ngdI75pzuPMYEEZVgg
 Kv7l2eBmoJVAtqrhD2eYZbK+MfZvkN3m9lbuWFJVz3RP/kPOmKz2yOGwXE7eJgHD+fDO
 0LPCtyAQ8stswsRJ43gZrWg1FlfBPueLJJcGjM71lNqN5UJrWI7GVzhQXjND6cqOdyDP
 lrDdvRsWZkkFB9hVnMM+VEoMfoYqODsRzmknXCHgNv44naCuPRCyKWO3CWEsOmLWLdR9 7Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgmkkt2jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 18:38:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GIcTJR020221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 18:38:29 GMT
Received: from [10.48.240.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 11:38:28 -0700
Message-ID: <46340c48-285e-4e2a-b6e9-802f922f0c2c@quicinc.com>
Date:   Wed, 16 Aug 2023 11:38:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Additional processing in beacon updates (v8)
Content-Language: en-US
To:     Aloka Dixit <quic_alokad@quicinc.com>, <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230727174100.11721-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 158xFHACvWhBOZPlQDfLR3i1FtIQ_e8r
X-Proofpoint-GUID: 158xFHACvWhBOZPlQDfLR3i1FtIQ_e8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/27/2023 10:40 AM, Aloka Dixit wrote:
> v8: Patches #1, #2 are new in this version which allow resetting
> the interval to 0 once set to non-zero which was not possible earlier.
> No functional changes to the remaining three patches from v7 here:
> https://patchwork.kernel.org/project/linux-wireless/list/?series=693804&state=%2A&archive=both
> 
> v7: Resolved conflicts with MLO code changes.
> 
> FILS discovery and unsolicited broadcast probe response transmissions
> are configured as part of NL80211_CMD_START_AP. The configurations
> may get changed whenever there is a change in beacon, e. g. when
> a channel switch operation completes the new templates will be sent
> by the userspace which reflects the new channel bandwidth. Process the
> attributes for these features in NL80211_CMD_SET_BEACON as well.
> 
> - Replace the check for interval (for both features) with a new flag
> 'update' which is set only when the userspace requests an update to
> the configuration. This allows the interval to be set to 0 and
> templates deleted which wasn't allowed earlier as the attributes got
> processed only if the interval was non-zero.
> - Modify the local variable in nl80211_set_beacon() and input parameter
> to rdev_change_beacon() from type struct cfg80211_beacon_data to
> type struct cfg80211_ap_settings to support the new processing.
> - Modify ieee80211_change_beacon() to reflect the new input parameter type.
> - Modify driver specific functions pointed by change_beacon to reflect
> the new input parameter type.
> - Add the missing implementation in nl80211 and mac80211 to process
> FILS discovery and unsolicited broadcast probe response configurations.
> 
> 
> Aloka Dixit (5):
>    wifi: nl80211: fixes to FILS discovery updates
>    wifi: mac80211: fixes in FILS discovery updates
>    wifi: cfg80211: modify prototype for change_beacon
>    wifi: nl80211: additions to NL80211_CMD_SET_BEACON
>    wifi: mac80211: additions to change_beacon()
> 
>   drivers/net/wireless/ath/ath6kl/cfg80211.c    |   4 +-
>   drivers/net/wireless/ath/wil6210/cfg80211.c   |   3 +-
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   4 +-
>   .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
>   .../wireless/microchip/wilc1000/cfg80211.c    |   4 +-
>   .../net/wireless/quantenna/qtnfmac/cfg80211.c |   4 +-
>   .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   6 +-
>   include/net/cfg80211.h                        |   6 +-
>   include/uapi/linux/nl80211.h                  |  11 +-
>   net/mac80211/cfg.c                            | 102 ++++++++++--------
>   net/wireless/nl80211.c                        |  47 ++++++--
>   net/wireless/rdev-ops.h                       |   2 +-
>   net/wireless/trace.h                          |  54 +++++-----
>   13 files changed, 159 insertions(+), 91 deletions(-)
> 
> 
> base-commit: b2090d93d4b6f1c72a9793d5a171806b8468b7cb
for the series:

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

