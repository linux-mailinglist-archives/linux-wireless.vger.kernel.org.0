Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1D76A19A7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 11:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjBXKKv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 05:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjBXKKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 05:10:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA665B4
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 02:09:30 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O4LbiZ016756;
        Fri, 24 Feb 2023 10:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NObgMQoBcXpCo1Ze11rufi67mVaLJfn4suB7qxRc9Hg=;
 b=jnhNkHO0mCrN0JE3LAnLOv6MkDlosPtwteVggShyh7PGL/6HOvKEkAFqH8lRxn3MetfM
 IGaB4MpPhRYz5DHw8xBa7PJTbsOET2HtbAvRZazC/98s25LbU5VJ24Z/iT7TZQhhr1gB
 XnOdSN4qpXCfwpRPGCRguckEAYACuL969/GfTWAC0HihExLHPW/p8jOirgkh5+w25QCw
 XgZ/jQDI0WlCF9DZAaA9ceZKE4bpYTHNFuFYuyDI73Kl82ZoHmzTuf93QtcmwA3MVM/V
 RL68YqpI91aGTVBjsYUf41DDYfFPmWPHUj/nPHra8w1qwkrOdfBVfXe0V41rmUAmJQzF ng== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwycnm5ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:08:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OA8Tux026683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:08:29 GMT
Received: from [10.216.30.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 02:08:27 -0800
Message-ID: <10e4b6bf-f375-e50f-063a-b44471359d25@quicinc.com>
Date:   Fri, 24 Feb 2023 15:38:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
To:     James Prestwood <prestwoj@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        <johannes@sipsolutions.net>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
 <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
 <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
 <378a1d63b3752ace7384c44d6f5184753fa7795d.camel@gmail.com>
 <0b06dea9-d5be-1edc-62ca-576398d1bcd8@quicinc.com>
 <0e7644cbfa9e4ba0d534681166ca467ea1684719.camel@gmail.com>
Content-Language: en-US
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <0e7644cbfa9e4ba0d534681166ca467ea1684719.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e9-ptvrkJa4zdNpVpb5OalxbSzu1ixaY
X-Proofpoint-GUID: e9-ptvrkJa4zdNpVpb5OalxbSzu1ixaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_06,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1011 mlxlogscore=958 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240084
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/10/2023 10:35 PM, James Prestwood wrote:
> On Tue, 2023-01-10 at 10:49 +0530, Manikanta Pubbisetty wrote:
>> On 12/29/2022 2:52 AM, James Prestwood wrote:
>>> Hi Manikanta,
>>>> By the way, userspace itself selects the frequencies to scan, not
>>>> the
>>>> driver.
>>>>
>>>> If we see the split scan implementation in cfg80211, this is the
>>>> how
>>>> it
>>>> is implemented. If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set, it
>>>> selects
>>>> all PSC channels and those non-PSC channels where RNR IE
>>>> information
>>>> is
>>>> found in the legacy scan results. If this flag is not set, all
>>>> channels
>>>> in 6 GHz are included in the scan freq list. It is upto userspace
>>>> to
>>>> decide what it wants.
>>>
>>>
>>> This isn't your problem, but it needs to be said:
>>>
>>> The nl80211 docs need and update to reflect this behavior (or
>>> remove
>>> the PSC logic). IMO this is really weird that the kernel selects
>>> PSC's
>>> based on the co-located flag. The docs don't describe this behavior
>>> and
>>> the flag's name is misleading (its not
>>> SCAN_FLAG_COLOCATED_AND_PSC_6GHZ) :)
>>>
>>
>> Sorry for the late reply, I was on vacation.
>>
>> What you said make sense. The existing flag should not add PSC
>> channels
>> according to the flag description.
>>
>> We can add another flag something like you pointed out
>> SCAN_FLAG_COLOCATED_AND_PSC_6GHZ and include PSC channels if this
>> flag
>> is set. What do you say?
> 
> I'm no authority here, just wanted to point this out. This is something
> that would need to be in mac80211 though, not just a specific driver.
> It would be up to the maintainers and would require changing the
> behavior of the existing flag, which then changes behavior in
> wpa_supplicant/hostapd. So its somewhat intrusive.
> 
> But personally I'd be for it. And just require userspace include PSC's
> like any other channels if they need those.
> 

Hi Johannes,

What is your opinion on the changes being proposed to the 6 GHz scan in 
cfg80211 that is being discussed in this thread?

Thanks,
Manikanta

