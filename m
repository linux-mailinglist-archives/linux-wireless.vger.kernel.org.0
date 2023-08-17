Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5F77FD7F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354248AbjHQSFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354221AbjHQSEq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 14:04:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0D19A1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 11:04:45 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HHTHCR018523;
        Thu, 17 Aug 2023 18:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ui0Rcuv/xMSl6UEzkDQH7cjTRXzscC0FaNeZHjJvw6M=;
 b=AczAI5e50b/+E9MndujLlhT4kQBGymJEyeyTM0T0WFu240whPsqYrIudE76vljR0SWp6
 DjOvvOUyHdSvLjCyNTElcMTVCcYTzRu5tROFZQIgOZPiiK61TObxwAoGwP6RDpNXRv0l
 xt8ZnoYNQ3fsNnmQ18QebEZIPnWI+6Tyd2eJWKgXmv/gOBEkEf6ID8S0kZAaHke+wAux
 Mmp0BrW4S5+5FqdN3E9hbvsteKeBBEULDZ2AiGQ4cEJSFDUjmke/xF+54rnqd6sFxl5b
 zUmBXWiiuutxzc0Yj2ES4E9fmZ066IbtC2AbrU1/qTuPn5yTXEq5lqGp8JrWO/t/Tzpl Ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sh3xxapup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 18:04:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37HI4eh9017715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 18:04:40 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 17 Aug
 2023 11:04:39 -0700
Message-ID: <759fb125-7bfc-7d85-5c71-0a134030a9b9@quicinc.com>
Date:   Thu, 17 Aug 2023 11:04:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Additional processing in beacon updates (v8)
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
 <46340c48-285e-4e2a-b6e9-802f922f0c2c@quicinc.com>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <46340c48-285e-4e2a-b6e9-802f922f0c2c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sn1BdX5Ww-3XdyiCbsURBJzNu9XnL6Vg
X-Proofpoint-ORIG-GUID: sn1BdX5Ww-3XdyiCbsURBJzNu9XnL6Vg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_12,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/16/2023 11:38 AM, Jeff Johnson wrote:
> On 7/27/2023 10:40 AM, Aloka Dixit wrote:
>> v8: Patches #1, #2 are new in this version which allow resetting
>> the interval to 0 once set to non-zero which was not possible earlier.
>> No functional changes to the remaining three patches from v7 here:
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=693804&state=%2A&archive=both
>>
>> v7: Resolved conflicts with MLO code changes.
>>
>> FILS discovery and unsolicited broadcast probe response transmissions
>> are configured as part of NL80211_CMD_START_AP. The configurations
>> may get changed whenever there is a change in beacon, e. g. when
>> a channel switch operation completes the new templates will be sent
>> by the userspace which reflects the new channel bandwidth. Process the
>> attributes for these features in NL80211_CMD_SET_BEACON as well.
>>
>> - Replace the check for interval (for both features) with a new flag
>> 'update' which is set only when the userspace requests an update to
>> the configuration. This allows the interval to be set to 0 and
>> templates deleted which wasn't allowed earlier as the attributes got
>> processed only if the interval was non-zero.
>> - Modify the local variable in nl80211_set_beacon() and input parameter
>> to rdev_change_beacon() from type struct cfg80211_beacon_data to
>> type struct cfg80211_ap_settings to support the new processing.
>> - Modify ieee80211_change_beacon() to reflect the new input parameter 
>> type.
>> - Modify driver specific functions pointed by change_beacon to reflect
>> the new input parameter type.
>> - Add the missing implementation in nl80211 and mac80211 to process
>> FILS discovery and unsolicited broadcast probe response configurations.
>>
>>
>> Aloka Dixit (5):
>>    wifi: nl80211: fixes to FILS discovery updates
>>    wifi: mac80211: fixes in FILS discovery updates
>>    wifi: cfg80211: modify prototype for change_beacon
>>    wifi: nl80211: additions to NL80211_CMD_SET_BEACON
>>    wifi: mac80211: additions to change_beacon()
>>
>>   drivers/net/wireless/ath/ath6kl/cfg80211.c    |   4 +-
>>   drivers/net/wireless/ath/wil6210/cfg80211.c   |   3 +-
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   4 +-
>>   .../net/wireless/marvell/mwifiex/cfg80211.c   |   3 +-
>>   .../wireless/microchip/wilc1000/cfg80211.c    |   4 +-
>>   .../net/wireless/quantenna/qtnfmac/cfg80211.c |   4 +-
>>   .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   6 +-
>>   include/net/cfg80211.h                        |   6 +-
>>   include/uapi/linux/nl80211.h                  |  11 +-
>>   net/mac80211/cfg.c                            | 102 ++++++++++--------
>>   net/wireless/nl80211.c                        |  47 ++++++--
>>   net/wireless/rdev-ops.h                       |   2 +-
>>   net/wireless/trace.h                          |  54 +++++-----
>>   13 files changed, 159 insertions(+), 91 deletions(-)
>>
>>
>> base-commit: b2090d93d4b6f1c72a9793d5a171806b8468b7cb
> for the series:
> 
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 

Thanks for the review!
