Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90666973FA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 02:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBOB5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 20:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjBOB5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 20:57:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C0CC08
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 17:57:05 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F0G79I026992;
        Wed, 15 Feb 2023 01:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IVxBmMXcZVXc0XwoF69Je4I7cIGhCAzg5IdYHqojbSY=;
 b=HE6lFM1+ohHkRC4Pc4rwhJzIXluLqCYZDwNuUFlZbcrhlxYoSkN45xMWtPK4dp33Jnht
 4FLLMi0tT9GYqcij3HdcBQg42kGGs59+dh8WQkTTHAg7Cl8IOWbjAHS0lMnzSPqANZgu
 QSJMeB5tRCP1h8KOMlUDNNxuZbmxDglsFrJlwgijYZUduFmuVhasiqzhd6Gtt8vpTXth
 KupJqZG4XDFn1XqEoH2fXQM55Im0Y9H6vwg7FnKmxZz/x2ztBfuSlwNcA7fBgbvZpS4Z
 xw5OAYmHBDWUNrgJG8sDanTIRWQnwLwH/8bQZvI08M+yMH17twxtoqhzK4UGnDPZrMAM HA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrhx3rk29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 01:56:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F1umg1005431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 01:56:48 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 17:56:45 -0800
Message-ID: <175755ef-e9b3-b039-0874-4a0bfb6eac2b@quicinc.com>
Date:   Wed, 15 Feb 2023 09:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v10 3/5] cfg80211/mac80211: move interface counting for
 combination check to mac80211
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Luciano Coelho <luciano.coelho@intel.com>,
        <linux-wireless@vger.kernel.org>
CC:     <michal.kazior@tieto.com>, <sw@simonwunderlich.de>,
        <andrei.otcheretianski@intel.com>, <eliad@wizery.com>,
        <ath11k@lists.infradead.org>
References: <1394547394-3910-1-git-send-email-luciano.coelho@intel.com>
 <1394547394-3910-4-git-send-email-luciano.coelho@intel.com>
 <4de1f964-b623-2b31-c044-60cc188fc134@quicinc.com>
 <6187b1566674ba2e0d7d5413af5475688d8421b3.camel@sipsolutions.net>
 <6c2b5e49-2cdc-b506-e3c8-0a51fccc294d@quicinc.com>
 <f5ffcc0b186cf9285e1dedebc8cf47c06d46bbd9.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <f5ffcc0b186cf9285e1dedebc8cf47c06d46bbd9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Fk_WXUaHJRlXnBdD-JDE2WlJf4A3vJa
X-Proofpoint-GUID: 1Fk_WXUaHJRlXnBdD-JDE2WlJf4A3vJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=766 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150016
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/14/2023 10:41 PM, Johannes Berg wrote:
> On Tue, 2023-01-10 at 15:23 +0800, Wen Gong wrote:
>> On 1/9/2023 6:05 PM, Johannes Berg wrote:
>>> On Mon, 2023-01-09 at 17:39 +0800, Wen Gong wrote:
>>>> On 3/11/2014 10:16 PM, Luciano Coelho wrote:
>>>>> ...
>>>>> +int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>>>>> +				 const struct cfg80211_chan_def *chandef,
>>>>> +				 enum ieee80211_chanctx_mode chanmode,
>>>>> +				 u8 radar_detect)
>> ...
>>>>> +
>>>>> +	if (total == 1 && !radar_detect)
>>>>> +		return 0;
>>>>> +
>>>> should also check with cfg80211_check_combinations() when total == 1 and
>>>> num_different_channels > 1 ?
>>>>
>>>> When MLO is enabled, it could have 2 channels for one ieee80211_sub_if_data.
>>>>
>>> Heh. You're commenting on a patch from 2014, well before MLO :-)
>>>
>>> Not sure what happens in the code now?
>>>
>>> johannes
>> Yes, it is 2014. Each interface only has one channel at 2014.
>> I did not hit issue for the code.
>>
>> the story is like this:
>> When station interface and p2p device interface both running.
>> the station connect to MLO AP which has 2 links.
>> The ieee80211_link_use_channel()/ieee80211_check_combinations() call
>> cfg80211_check_combinations()
>> for the channel1 and channel2 because total==2.
>> When only station interface is running, not called for channel1/channel2
>> because total==1.
>> That is the little thing I hit.
>>
> So ... I guess you found a bug? Not sure what I'm supposed to say here.
> Send a fix?
I consider it NOT a bug. It is only the check is not strict here.
>
> johannes
