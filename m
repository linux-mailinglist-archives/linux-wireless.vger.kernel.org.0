Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AAA64CFEB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 20:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiLNTMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 14:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNTMD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 14:12:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8313DD2CD
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 11:12:02 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BED0c9d015741;
        Wed, 14 Dec 2022 19:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VmYn0nF98o1hFZDIhGZsX8MSP0m1DzS0uyEiSZyrj0w=;
 b=a4MykyloGwc2qeQQSg4OZdDE4TboTl5FNfDUpKLpTA07Oz+AgLnpzn+SzcL3xMuonUKl
 cL0h35yEAtBks2OA0FUmcXuwEy4eyqQLsedkcVzYbm8tk53oQaysDBgaOmEVc4ZdlmGp
 +FNguYSn3hPTjRHRWjc9SOmgYCsFFHNn0WpSoFXnLjNP9AxnTKCicF1CA734tExr/oJf
 XW6x9kggPkosJf8SwPPnDqDj3UgdFq020IRdMZu5GAsK2mssGxVKuv+kuntpqALNmjEa
 SSRoaa8mImAKTnrttXpNciwf1IBBn51XigP+WJ1CS9DzbuDNcjWoE16vBxOyZLk99Q6u Sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rfa4pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 19:11:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEJBtja012060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 19:11:55 GMT
Received: from [10.110.90.156] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 11:11:54 -0800
Message-ID: <530e48f5-b504-06f6-a09b-e0a36ab637f0@quicinc.com>
Date:   Wed, 14 Dec 2022 11:11:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH] mac80211: mlme: Handle Puncturing information
 received from the AP
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kang Yang <quic_kangyang@quicinc.com>,
        <linux-wireless@vger.kernel.org>
CC:     Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        "Carl Huang (QUIC)" <quic_cjhuang@quicinc.com>,
        Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
References: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
 <e4db49e4-6363-0c8d-10dd-a1a564da2542@quicinc.com>
 <95ad4207e62b4990476d867bd240fef3ede31369.camel@sipsolutions.net>
 <76266a0b-d371-53c1-9ad0-fbff7a506d0c@quicinc.com>
 <5729983cd02a82d36fed42dcd133e7713fe3aa53.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <5729983cd02a82d36fed42dcd133e7713fe3aa53.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X2sCP0fTI-0ot43-9vv6xWNP-PXgYavN
X-Proofpoint-ORIG-GUID: X2sCP0fTI-0ot43-9vv6xWNP-PXgYavN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_10,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=959 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140156
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/23/2022 12:56 AM, Johannes Berg wrote:
>>> Anyway the more fundamental thing we have to figure out here (and thanks
>>> for bringing this back) is how we treat the puncturing - QCOM's AP-side
>>> puncturing patch treated it as part of the chandef, but that's not
>>> working well for client side ...
>>>
>>
>>
>> Yes, to my understanding, I think it's more appropriate to define it
>> like you in "ieee80211_bss_conf".
> 
> Well Aloka is back - Aloka maybe you have some comments?
> 

Added few comments below.
> 
> 
> I can somewhat understand why you might want puncturing to be part of
> the chandef for an AP, especially for configuration, though I'm honestly
> not sure what the use cases are; perhaps some other use for that
> bandwidth (perhaps cellular?), but then does that really mean we should
> refuse configurations that aren't in line with it?
> 
> If we put puncturing into the chandef that might not even mean we
> *refuse* configurations, it would initially just mean we need another
> channel context (if supported, otherwise refused) when we add two.
> 
> 
> But given that the primary use case seems to be different use for the
> part of the spectrum that's being punctured - maybe we should set it up
> in a wholly different way and have some way of "carving out" reserved
> spectrum?
> 

The primary use case from AP side is trying to get maximum bandwidth in 
a noisy environment. Without puncturing AP has to downgrade from 80 MHz 
to to 40/20 Mhz but now it can use 60 Mhz if only 20 Mhz in the given 
channel width has a lot of interference.
As puncturing bitmap is tightly coupled with the channel and bandwidth, 
it made sense to put it in chandef and the channel switch case was 
covered inherently because it uses chandef.

But I see that doesn't work for client wanting to connect to two APs in 
multi-BSS case.

> So you could, say, reserve channel 40, and then to have an 80 MHz AP on
> channels 36-48 you'd have to puncture 40 there. We wouldn't have to
> store it as part of the chandef/chanctx because the validation is now
> done against the reservation; or we could even store it as part of the
> chandef/chanctx but say it only applies to beaconing modes or such, and
> not handle it as part of the chandef equality comparison.
> 

Unless we know for sure that the punctured bandwidth is going to be used 
for some other purpose, the above mentioned approach seems little 
complicated and unnecessary.

> And really that's the thing that matters to the client here, the client
> never has a choice, so if it's part of the equality comparison on the
> client, then the client might not be able to simultaneously connect to
> two BSSes (or need two chanctxs to do it) if both have 80 MHz on channel
> 36, but one has puncturing and the other doesn't. That doesn't really
> make sense IMHO.
>
> If we treat the puncturing as a more global "reserved spectrum" case,
> then we can still put the puncturing into the chandef, say it applies to
> beaconing modes only (I suppose AP is the only relevant one, perhaps
> someone will care about mesh in the future?), not have it as part of the
> == comparison. All APs would have to adhere to that.
> 

I agree that cfg80211_chandef_identical() should return true if the 
bitmap is different but other basic channel parameters are same for AP 
mode too.


> That still leaves a corner case of concurrent client + AP functionality
> which can only be handled if hardware can deal with different puncturing
> settings per interface? Which again argues for *not* storing it as part
> of the chandef, I'd say.
> 

Muna sent a AP mode follow-up based on this current patch - 
https://patchwork.kernel.org/project/linux-wireless/list/?series=701342&state=%2A&archive=both

Please note that we missed to include some compilation error fixes while 
sending, will send a new version soon.

This approach needs little extra NL80211 attribute processing in case of 
channel switch along with start_ap() and SET_INTERFACE but it works.

Thanks.
