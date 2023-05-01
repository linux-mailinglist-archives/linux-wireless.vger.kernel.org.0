Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BE96F38FB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 May 2023 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjEAUDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 16:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjEAUDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 16:03:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347CB271B
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 13:03:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341JOGKH013521;
        Mon, 1 May 2023 20:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dj4ZNfJrGnnCsbFQf84DBq/aPN6uxeD/RE9rYaTlyCk=;
 b=BQPCjRi+4ngCMcXjJCAYgYf8o0iyT9UNwVTyeANRH1/qA0r7eaNerwswACj44jUDAMGj
 2XLaUY7+dJRliHbBoeMN7npnGC8+OP5TyD18WCTKY9/2FLL2dA5s8bHMYRAQOEJngmPL
 2uM/TIw0gGymQh8WYcKwNnaupDgYYjrGGgDOXjlQEAhfJXO/3hKBxj+iKoQ3l2Oenaph
 01M6dEYzo/sTw3kTiw5UFhkmJL922px47YamtXuRqYfY4C6SQNTGwx6szmjsAFPYJM5U
 45P/b7Fe2MnZisvtovfAs+FZbp/Mr17y9qOiuoFb3pMIZz9PNhPjkWT+cZtOrXQBzf55 Qw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qajdp06p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 20:03:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341K3YSm023869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 20:03:34 GMT
Received: from [10.110.95.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 1 May 2023
 13:03:34 -0700
Message-ID: <76540463-9e4e-3dc7-bdcd-35c6b709169a@quicinc.com>
Date:   Mon, 1 May 2023 13:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] wifi: cfg80211: beacon EHT rate support
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230329000902.17992-1-quic_alokad@quicinc.com>
 <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
 <312f1476-b78b-b7f0-26f9-512a7dc2b6b7@quicinc.com>
 <3abb2d127eaa3b76a8f4f34c795ddd6d502ce470.camel@sipsolutions.net>
 <1aa6178f-2041-797e-fcb8-78fe2c08de24@quicinc.com>
Content-Language: en-US
In-Reply-To: <1aa6178f-2041-797e-fcb8-78fe2c08de24@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wxtfuL-HSnmF4l6ON0tSyVj3TLK7yuf2
X-Proofpoint-ORIG-GUID: wxtfuL-HSnmF4l6ON0tSyVj3TLK7yuf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010161
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/31/2023 10:55 AM, Aloka Dixit wrote:
> On 3/31/2023 2:23 AM, Johannes Berg wrote:
>> On Thu, 2023-03-30 at 15:40 -0700, Aloka Dixit wrote:
>>> On 3/30/2023 3:44 AM, Johannes Berg wrote:
>>>> On Tue, 2023-03-28 at 17:09 -0700, Aloka Dixit wrote:
>>>>
>>>>> +        switch (wdev->iftype) {
>>>>> +        case NL80211_IFTYPE_AP:
>>>>> +            width = wdev->u.ap.preset_chandef.width;
>>>>
>>>> This seems a bit awkward and annoying, it means that we have to keep
>>>> using the API that sets the preset_chandef first, and it also means it
>>>> won't work for multi-link.
>>>>
>>>
>>> Okay, I can do it the same with it is done in he_get_txmcsmap():
>>>     chandef = wdev_chandef(wdev, link_id);
>>
>> Right, that should be better.
>>
>> Though not sure that works already when you're doing START_AP, I'd think
>> we don't set the chandef before parsing the rate attribute?
>>
>> Which would mean userspace would have to separately set the beacon rate,
>> which means even having the whole thing inside start_ap() is pointless?
>>
>>
>>>> Couldn't you link it with the config in start_ap/join_mesh? And 
>>>> per-link
>>>> config in set_tx_bitrate_mask()?
>>>>
>>>
>>> Please correct me if I'm wrong but ieee80211_set_bitrate_mask() need not
>>> be changed for setting the beacon rate in non-MLO case, right?
>>> Because it does not have anything related to he_mcs currently too.
>>
>> How is ieee80211_set_bitrate_mask() related, it's in mac80211?
>>
>> Oh you mean it doesn't need to be changed to support EHT? Looks like to
>> me that it would have to be changed, and even HE today only works in
>> non-mac80211 drivers that implement it correctly?
>>
>> But again set_bitrate_mask() isn't even related to beacon rate?
>>
>>
>> Regarding beacon rate, it looks like mac80211 _only_ accepts legacy
>> rates, and then also _only_ in start_ap(), so I'm not sure how the whole
>> thing even works ...??
>>
> 
> I agree with all of your points and as said above, I mainly tested by 
> checking the final mask generated in nl80211.c.
> 
> Do you remember a similar discussion when HE code was added (I wasn't 
> the submitter). May be that will have some pointers regarding how it was 
> tested.
> 
> Do you think we can continue with this EHT support for non-mac80211 
> drivers similar to HE for now?
> Or should we just skip this patch?
> 
> Thanks.

Hi Joannes,
Thoughts on this one?
Thanks.
