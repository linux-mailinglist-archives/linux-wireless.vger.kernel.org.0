Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDA96A3FBD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 11:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjB0K5b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 05:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjB0K53 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 05:57:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0038920066
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 02:57:24 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R4RDK1000851;
        Mon, 27 Feb 2023 10:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T2UBKH35Km+ksvs1n2JoUYmoK7+UYuEiucdXD1PUSG4=;
 b=k+QYkFcN9+9VT9tL7L9eC3oCEpJDCYHkV1FqejNjjygO/sCZqiRy+o+B2jSbUMovBpnz
 537j9LVJZBWBH+BFMtoAzXqhJ1WybdAhCLDREbcV1ORZrDKEp/q02Ve5duGRfceSYK0Z
 9zIZdzsid3SoYYgk8dUPlzltwc6y/IF0CvmUd/mubnZ5CauDWiqkzDRaVUR9/UNoqc45
 sDLmAl89Z8OgHw1K5bjUmGkE36ySRzf+hljEUcGVt7d4V4YdsnHZizp6m1ZpIRfNKcWc
 tmeQZGtYFjMdtfetoX8zlWY2QVme+ayIgzakhJ3PzdbuPmAe1HJu4TAD/DKbkJB51mSC jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nyajavpw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:57:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RAvEUx027238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:57:14 GMT
Received: from [10.206.66.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 02:57:12 -0800
Message-ID: <dd607593-2353-3c85-bc4c-1230c1419f8c@quicinc.com>
Date:   Mon, 27 Feb 2023 16:27:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
Content-Language: en-US
To:     "Peer, Ilan" <ilan.peer@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
 <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
 <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
 <378a1d63b3752ace7384c44d6f5184753fa7795d.camel@gmail.com>
 <0b06dea9-d5be-1edc-62ca-576398d1bcd8@quicinc.com>
 <0e7644cbfa9e4ba0d534681166ca467ea1684719.camel@gmail.com>
 <10e4b6bf-f375-e50f-063a-b44471359d25@quicinc.com>
 <56a3651e48ae621afa4c50f1ba0d9fedeefb2c31.camel@sipsolutions.net>
 <7ddf99b1-4aef-c950-f61b-ba79ed086095@quicinc.com>
 <DM4PR11MB6043976576E564D19D122B66E9AF9@DM4PR11MB6043.namprd11.prod.outlook.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <DM4PR11MB6043976576E564D19D122B66E9AF9@DM4PR11MB6043.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JYuZpLAIVguUb-Q6IUgKaZEIRkqbNf4U
X-Proofpoint-ORIG-GUID: JYuZpLAIVguUb-Q6IUgKaZEIRkqbNf4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=735
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270084
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/27/2023 1:55 PM, Peer, Ilan wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>> Sent: Monday, February 27, 2023 06:24
>> To: Johannes Berg <johannes@sipsolutions.net>; James Prestwood
>> <prestwoj@gmail.com>; Marcel Holtmann <marcel@holtmann.org>
>> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org; Peer, Ilan
>> <ilan.peer@intel.com>
>> Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
>>
>> On 2/24/2023 3:45 PM, Johannes Berg wrote:
>>> On Fri, 2023-02-24 at 15:38 +0530, Manikanta Pubbisetty wrote:
>>>> On 1/10/2023 10:35 PM, James Prestwood wrote:
>>>>> On Tue, 2023-01-10 at 10:49 +0530, Manikanta Pubbisetty wrote:
>>>>>> On 12/29/2022 2:52 AM, James Prestwood wrote:
>>>>>>> Hi Manikanta,
>>>>>>>> By the way, userspace itself selects the frequencies to scan, not
>>>>>>>> the driver.
>>>>>>>>
>>>>>>>> If we see the split scan implementation in cfg80211, this is the
>>>>>>>> how it is implemented. If NL80211_SCAN_FLAG_COLOCATED_6GHZ
>> is
>>>>>>>> set, it selects all PSC channels and those non-PSC channels where
>>>>>>>> RNR IE information is found in the legacy scan results. If this
>>>>>>>> flag is not set, all channels in 6 GHz are included in the scan
>>>>>>>> freq list. It is upto userspace to decide what it wants.
>>>>>>>
>>>>>>>
>>>>>>> This isn't your problem, but it needs to be said:
>>>>>>>
>>>>>>> The nl80211 docs need and update to reflect this behavior (or
>>>>>>> remove the PSC logic). IMO this is really weird that the kernel
>>>>>>> selects PSC's based on the co-located flag. The docs don't
>>>>>>> describe this behavior and the flag's name is misleading (its not
>>>>>>> SCAN_FLAG_COLOCATED_AND_PSC_6GHZ) :)
>>>>>>>
>>>>>>
>>>>>> Sorry for the late reply, I was on vacation.
>>>>>>
>>>>>> What you said make sense. The existing flag should not add PSC
>>>>>> channels according to the flag description.
>>>>>>
>>>>>> We can add another flag something like you pointed out
>>>>>> SCAN_FLAG_COLOCATED_AND_PSC_6GHZ and include PSC channels if
>> this
>>>>>> flag is set. What do you say?
>>>>>
>>>>> I'm no authority here, just wanted to point this out. This is
>>>>> something that would need to be in mac80211 though, not just a specific
>> driver.
>>>>> It would be up to the maintainers and would require changing the
>>>>> behavior of the existing flag, which then changes behavior in
>>>>> wpa_supplicant/hostapd. So its somewhat intrusive.
>>>>>
>>>>> But personally I'd be for it. And just require userspace include
>>>>> PSC's like any other channels if they need those.
>>>>>
>>>>
>>>> Hi Johannes,
>>>>
>>>> What is your opinion on the changes being proposed to the 6 GHz scan
>>>> in
>>>> cfg80211 that is being discussed in this thread?
>>>>
>>>
>>> I don't think we can/should change the semantics of an existing flag
>>> now, but we can certainly update the documentation to match the
>>> implementation, and add more flags to make it more flexible.
>>>
>>> johannes
>>
>> Sure, makes sense. I'll make the changes and send them out for review.
>>
> 
> Sorry for joining this thread late. I agree that the documentation of the NL80211_SCAN_FLAG_COLOCATED_6GHZ
> flag can be updated, but FWIW, I want to clarify the intention behind this flag:
> 
> First, the logic would always scan only the channels requested by user space, so if the PSC channels are
> not included they would not be scanned.
> 

Agreed.

> Second, the intention of the NL80211_SCAN_FLAG_COLOCATED_6GHZ flag was to indicate to the kernel that
> before going to scan the 6GHz channels it should first scan the 2GHz/5GHz bands such that it would retrieve information
> about the collocated APs, so eventually it would only scan the given PSC channels and the channels on which collocated APs
> are found (in which case direct probing of these APs is expected).
> 

Understood, currently the documentation of the 
NL80211_SCAN_FLAG_COLOCATED_6GHZ flag doesn't state this. It simply 
scans all the PSC channels the user space has asked for whether they are 
co-located or not. As you mentioned earlier, we need to fix the 
documentation part.

> While the PSC channels could have been scanned together with the 2GHz/5GHz channels, since collocated APs might also reside
> on PSC channels, we wanted to avoid scanning PSC channels twice, so this is why they are scanned only after the scan on legacy
> bands.
> 
> Hope this helps,
> 

Understood, thanks a lot for the clarification.

Manikanta
