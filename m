Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9C6D2720
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCaRzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCaRzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 13:55:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA43C26
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 10:55:19 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VAnkLc020472;
        Fri, 31 Mar 2023 17:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BEoL9kcI4V15N/3VbedlLfI4kWnbT2lK/5MwOFZ9LWM=;
 b=m3gtLKyX8e0E6myY7/kfZ3PYUXCiIf9o/pPNpmLx62Uqn0mB3xaOoKqw0JX0AxPYG1xh
 vkciSjGWjKiZisru2oce5++fhVKPckCOSiGWoxfTKsCz6aozDPxfMUbuN17aKJ/5V+76
 kDclygp4OrotzJecD8MxhzWHVDlzmjhfzeiRddBP84kItKqpsOggvbCTE9k5+vUVJrd+
 tghmPflC0G9xk1nnlEnWd7lBpNZ/5UCPFWTRaTEmcuJcIXwE/oegl3UzbMc6PLXjgtAr
 FrzopEgybZjr//C+zbPnQbBnm0LJ7SEt6jkG5EzCjgSyeHsF5KNDHifb+u/DxuNP5nbp Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pntxfa4bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 17:55:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32VHtF2b000515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 17:55:15 GMT
Received: from [10.110.89.180] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 31 Mar
 2023 10:55:15 -0700
Message-ID: <1aa6178f-2041-797e-fcb8-78fe2c08de24@quicinc.com>
Date:   Fri, 31 Mar 2023 10:55:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] wifi: cfg80211: beacon EHT rate support
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230329000902.17992-1-quic_alokad@quicinc.com>
 <d54800ae88be1eb232df7794e741dfc304c3ee9a.camel@sipsolutions.net>
 <312f1476-b78b-b7f0-26f9-512a7dc2b6b7@quicinc.com>
 <3abb2d127eaa3b76a8f4f34c795ddd6d502ce470.camel@sipsolutions.net>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <3abb2d127eaa3b76a8f4f34c795ddd6d502ce470.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g5vkhrriEykR56zrIuL9Lt8f9TK-9YXr
X-Proofpoint-ORIG-GUID: g5vkhrriEykR56zrIuL9Lt8f9TK-9YXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310143
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/31/2023 2:23 AM, Johannes Berg wrote:
> On Thu, 2023-03-30 at 15:40 -0700, Aloka Dixit wrote:
>> On 3/30/2023 3:44 AM, Johannes Berg wrote:
>>> On Tue, 2023-03-28 at 17:09 -0700, Aloka Dixit wrote:
>>>
>>>> +		switch (wdev->iftype) {
>>>> +		case NL80211_IFTYPE_AP:
>>>> +			width = wdev->u.ap.preset_chandef.width;
>>>
>>> This seems a bit awkward and annoying, it means that we have to keep
>>> using the API that sets the preset_chandef first, and it also means it
>>> won't work for multi-link.
>>>
>>
>> Okay, I can do it the same with it is done in he_get_txmcsmap():
>> 	chandef = wdev_chandef(wdev, link_id);
> 
> Right, that should be better.
> 
> Though not sure that works already when you're doing START_AP, I'd think
> we don't set the chandef before parsing the rate attribute?
> 
> Which would mean userspace would have to separately set the beacon rate,
> which means even having the whole thing inside start_ap() is pointless?
> 
> 
>>> Couldn't you link it with the config in start_ap/join_mesh? And per-link
>>> config in set_tx_bitrate_mask()?
>>>
>>
>> Please correct me if I'm wrong but ieee80211_set_bitrate_mask() need not
>> be changed for setting the beacon rate in non-MLO case, right?
>> Because it does not have anything related to he_mcs currently too.
> 
> How is ieee80211_set_bitrate_mask() related, it's in mac80211?
> 
> Oh you mean it doesn't need to be changed to support EHT? Looks like to
> me that it would have to be changed, and even HE today only works in
> non-mac80211 drivers that implement it correctly?
> 
> But again set_bitrate_mask() isn't even related to beacon rate?
> 
> 
> Regarding beacon rate, it looks like mac80211 _only_ accepts legacy
> rates, and then also _only_ in start_ap(), so I'm not sure how the whole
> thing even works ...??
> 

I agree with all of your points and as said above, I mainly tested by 
checking the final mask generated in nl80211.c.

Do you remember a similar discussion when HE code was added (I wasn't 
the submitter). May be that will have some pointers regarding how it was 
tested.

Do you think we can continue with this EHT support for non-mac80211 
drivers similar to HE for now?
Or should we just skip this patch?

Thanks.
