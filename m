Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A8794247
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbjIFRwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbjIFRwn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 13:52:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FC1A8
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 10:52:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386BUw7o000548;
        Wed, 6 Sep 2023 17:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KN9iTYEbBLX2S0v9txUzQZVvZ1iQCIiduH7Ej8HtqW0=;
 b=jW+Hcj3cNxZXIDiHofEIrtN9O3nE6tr6tSYg4q7HAVYxeXl2rt7Gn3evaX/HZnJTP+vJ
 CxWD95GP6WvRrkyFQWdkrJaxrubHsDOmK74vmBYuxn5AL0dLAljp5O1yxvYkGVxkrnOT
 /PKCnFQPfpPa6SwY2ezPSyIu0KOsNAawPeENu/fx3TiIHglJVYPT5SgmZ1FfscVGqryN
 He6j8uPuf3clFPGGPVlF/5kL8B4vJ1v5IFtQoGeQu35zJX1dHC3rUd6kiTW89NJlHKra
 2iJJSEBXTBx2zamEH9MOU7BfyWxrJJsMK3BOIIYAxIQgtCg+S1WsH0CPZHNXIhjNj690 RQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxha3287v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 17:52:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386HqYHp008455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 17:52:34 GMT
Received: from [10.110.60.81] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 10:52:34 -0700
Message-ID: <6e680b33-55f5-2c49-3458-6baa4d8cff52@quicinc.com>
Date:   Wed, 6 Sep 2023 10:52:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Additional processing in beacon updates (v8)
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
 <46340c48-285e-4e2a-b6e9-802f922f0c2c@quicinc.com>
 <759fb125-7bfc-7d85-5c71-0a134030a9b9@quicinc.com>
Content-Language: en-US
In-Reply-To: <759fb125-7bfc-7d85-5c71-0a134030a9b9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NMNwOC2LClmiW2jNT73v8ELw1keXMfT4
X-Proofpoint-GUID: NMNwOC2LClmiW2jNT73v8ELw1keXMfT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/17/2023 11:04 AM, Aloka Dixit wrote:
> On 8/16/2023 11:38 AM, Jeff Johnson wrote:
>> On 7/27/2023 10:40 AM, Aloka Dixit wrote:
>>> v8: Patches #1, #2 are new in this version which allow resetting
>>> the interval to 0 once set to non-zero which was not possible earlier.
>>> No functional changes to the remaining three patches from v7 here:
>>> https://patchwork.kernel.org/project/linux-wireless/list/?series=693804&state=%2A&archive=both
>>>
>>> v7: Resolved conflicts with MLO code changes.
>>>
>>> FILS discovery and unsolicited broadcast probe response transmissions
>>> are configured as part of NL80211_CMD_START_AP. The configurations
>>> may get changed whenever there is a change in beacon, e. g. when
>>> a channel switch operation completes the new templates will be sent
>>> by the userspace which reflects the new channel bandwidth. Process the
>>> attributes for these features in NL80211_CMD_SET_BEACON as well.
>>>
>>> - Replace the check for interval (for both features) with a new flag
>>> 'update' which is set only when the userspace requests an update to
>>> the configuration. This allows the interval to be set to 0 and
>>> templates deleted which wasn't allowed earlier as the attributes got
>>> processed only if the interval was non-zero.
>>> - Modify the local variable in nl80211_set_beacon() and input parameter
>>> to rdev_change_beacon() from type struct cfg80211_beacon_data to
>>> type struct cfg80211_ap_settings to support the new processing.
>>> - Modify ieee80211_change_beacon() to reflect the new input parameter 
>>> type.
>>> - Modify driver specific functions pointed by change_beacon to reflect
>>> the new input parameter type.
>>> - Add the missing implementation in nl80211 and mac80211 to process
>>> FILS discovery and unsolicited broadcast probe response configurations.
>>>
>>> base-commit: b2090d93d4b6f1c72a9793d5a171806b8468b7cb
>> for the series:
>>
>> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
> 
> Thanks for the review!


Hello Johannes,

Please review this series.

I know this version is too late to recollect the context of earlier 
patches but hopefully following is helpful.

Versions 1 to 7 tried to fix this issue - FILS discovery transmission 
stops after CSA. I had tried to fix it in mac80211 which did not set 
BSS_CHANGED_FILS_DISCOVERY unless new parameters were sent by user-space.

For v7, you mentioned that while the flag=0 indicates that FILS 
configurations did not change, it does not indicate that it got deleted 
so the driver should decide depending on the existing configuration and
not depend only on the flag. I have already validated this ath12k patch 
which fixes the above issue, without cfg80211 and mac80211 patches in 
this series: 
https://patchwork.kernel.org/project/linux-wireless/patch/20230905174324.25296-1-quic_alokad@quicinc.com/

And I have changed this series to let the user-space give 'interval=0' 
as the parameter which was basically a no-op earlier. This way the 
transmission can be stopped explicitly and include the additional 
processing in the change_beacon from the previous versions which was 
anyway required.

Thanks.
