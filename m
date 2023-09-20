Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB77A8CB4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjITTXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 15:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjITTXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 15:23:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABFC9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 12:23:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIEjWv018573;
        Wed, 20 Sep 2023 19:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Pk+KEQFjHV4BqQ2URnmag5iYzc9V2KEPgoqBl6y0JGg=;
 b=d/B1OCv+W1sbf7PydqkTjYx98kL5/eiOyIYRwjnZQM2d0cjb7iLSQ6qoY4u5OWbxQBEI
 J2taCGp2ZVeQDkRUZ5X6vHplB5DGYd8gf0sctET05hPr3kB6KCYMK0D3Cr9H9gHGWQ8L
 Kgg/xWQux9rQlGZZKVNuuYPqT+b5JYw3UZK8w8hIWbZuGgDMWHBN50oveu2VPOhew5lo
 OmX/9BKgzvheZCGFzy3CcXC4A4E+OwCCHIG24YLTpEmL2PEnU5schYXhoeFkZeiDqekL
 Nv2DMX5ySAS4hhIdvqfTy0YogkAKLNRpBk08wuGH5bSEgJjqbf7uxLYsFvaEbshw07nI pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7qj9293c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:23:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KJNIrN018118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:23:18 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 20 Sep
 2023 12:23:17 -0700
Message-ID: <859fac21-9b1a-452e-91bb-c6d097d451b6@quicinc.com>
Date:   Wed, 20 Sep 2023 12:23:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ath10k: reduce invalid ht params rate message noise
Content-Language: en-US
To:     James Prestwood <jprestwood@locusrobotics.com>,
        <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <skhan@linuxfoundation.org>,
        Wen Gong <quic_wgong@quicinc.com>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
 <76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org>
 <5c31f6dadbcc3dcb19239ad2b6106773@codeaurora.org>
 <87h7mktjgi.fsf@codeaurora.org>
 <db4cd172-6121-a0b7-6c3f-f95baae1c1ed@linuxfoundation.org>
 <87wnvesv8t.fsf@codeaurora.org>
 <82e3e0a2-d95b-cffb-4fa7-2eaa4513dd48@linuxfoundation.org>
 <4a02dd43-c629-4c7c-83fe-256e6d444d60@locusrobotics.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <4a02dd43-c629-4c7c-83fe-256e6d444d60@locusrobotics.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gkuQb1ZVBFQVQYzmSzzsQuBlXzIuc-45
X-Proofpoint-ORIG-GUID: gkuQb1ZVBFQVQYzmSzzsQuBlXzIuc-45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_09,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(just a resend with Wen's current e-mail address, no further comments)
On 9/20/2023 11:27 AM, James Prestwood wrote:
> On 2/26/21 10:01 AM, Shuah Khan wrote:
>> On 2/11/21 4:24 AM, Kalle Valo wrote:
>>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>>
>>>> On 2/10/21 1:28 AM, Kalle Valo wrote:
>>>>> Wen Gong <wgong@codeaurora.org> writes:
>>>>>
>>>>>> On 2021-02-10 08:42, Shuah Khan wrote:
>>>>>>> ath10k_mac_get_rate_flags_ht() floods dmesg with the following
>>>>>>> messages,
>>>>>>> when it fails to find a match for mcs=7 and rate=1440.
>>>>>>>
>>>>>>> supported_ht_mcs_rate_nss2:
>>>>>>> {7,  {1300, 2700, 1444, 3000} }
>>>>>>>
>>>>>>> ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2
>>>>>>> mcs 7
>>>>>>>
>>>>>>> dev_warn_ratelimited() isn't helping the noise. Use dev_warn_once()
>>>>>>> instead.
>>>>>>>
>>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>>> ---
>>>>>>>    drivers/net/wireless/ath/ath10k/mac.c | 5 +++--
>>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>> b/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>> index 3545ce7dce0a..276321f0cfdd 100644
>>>>>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>>>>>> @@ -8970,8 +8970,9 @@ static void 
>>>>>>> ath10k_mac_get_rate_flags_ht(struct
>>>>>>> ath10k *ar, u32 rate, u8 nss, u8
>>>>>>>            *bw |= RATE_INFO_BW_40;
>>>>>>>            *flags |= RATE_INFO_FLAGS_SHORT_GI;
>>>>>>>        } else {
>>>>>>> -        ath10k_warn(ar, "invalid ht params rate %d 100kbps nss 
>>>>>>> %d mcs %d",
>>>>>>> -                rate, nss, mcs);
>>>>>>> +        dev_warn_once(ar->dev,
>>>>>>> +                  "invalid ht params rate %d 100kbps nss %d mcs 
>>>>>>> %d",
>>>>>>> +                  rate, nss, mcs);
>>>>>>>        }
>>>>>>>    }
>>>>>>
>>>>>> The {7,  {1300, 2700, 1444, 3000} } is a correct value.
>>>>>> The 1440 is report from firmware, its a wrong value, it has fixed in
>>>>>> firmware.
>>>>>
>>>>> In what version?
>>>>>
>>>>
>>>> Here is the info:
>>>>
>>>> ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id
>>>> 0x00340aff sub 17aa:0827
>>>>
>>>> ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00140-QCARMSWPZ-1
>>>> api 6 features wowlan,ignore-otp,mfp crc32 29eb8ca1
>>>>
>>>> ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 4ac0889b
>>>>
>>>> ath10k_pci 0000:02:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal otp
>>>> max-sta 32 raw 0 hwcrypto 1
>>>>
>>>>>> If change it to dev_warn_once, then it will have no chance to find 
>>>>>> the
>>>>>> other wrong values which report by firmware, and it indicate
>>>>>> a wrong value to mac80211/cfg80211 and lead "iw wlan0 station dump"
>>>>>> get a wrong bitrate.
>>>>>
>>>>
>>>> Agreed.
>>>>
>>>>> I agree, we should keep this warning. If the firmware still keeps
>>>>> sending invalid rates we should add a specific check to ignore the 
>>>>> known
>>>>> invalid values, but not all of them.
>>>>>
>>>>
>>>> Would it be helpful to adjust the default rate limits and set the to
>>>> a higher value instead. It might be difficult to account all possible
>>>> invalid values?
>>>>
>>>> Something like, ath10k_warn_ratelimited() to adjust the
>>>>
>>>> DEFAULT_RATELIMIT_INTERVAL and DEFAULT_RATELIMIT_BURST using
>>>> DEFINE_RATELIMIT_STATE
>>>>
>>>> Let me know if you like this idea. I can send a patch in to do this.
>>>> I will hang on to this firmware version for a little but longer, so
>>>> we have a test case. :)
>>>
>>> I would rather first try to fix the root cause, which is the firmware
>>> sending invalid rates. Wen, you mentioned there's a fix in firmware. Do
>>> you know which firmware version (and branch) has the fix?
>>>
>>
>> Picking this back up. Wen, which firmware version has this fix? I can
>> test this on my system and get rid of the noisy messages. :)
>>
>> thanks,
>> -- Shuah
> 
> I know its been years, but reading through this Wen mentioned there is a 
> fix in the firmware? I haven't tried all of the firmware binaries in 
> Kalle's tree but the most recent definitely still spam the logs with 
> this message. Is there a specific version I can use to get rid of these?
> 
> One thing to note is the older "firmware-4.bin" did not have this 
> problem, but was met with worse problems like driver/firmware crashes.

