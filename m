Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B657CCA29
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjJQRwE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRwD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 13:52:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310B883
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 10:52:01 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHRu3O014973;
        Tue, 17 Oct 2023 17:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7xzR2KoKpm4oyS8v9mpiKZeCoINo/gmqcAyrct+suW4=;
 b=bYQVGgXuiel3nqOS+O06afWBD/56LC+hL95Uf4LcTvqQmJIOdlF2ljCfuA0VLNT4ho7n
 rq+BLOc9CWN2+JWEC1GI3oW1MKPJVFd6eW+5q4ziHpN1nCN2ufQ1oM0kp93gdp7gcQWW
 lA4V9UrON1w+zdem205Cd4g31zermSUXXr36teuzvjkukZ/32B782nQBK18XfNHmO0ve
 xgILB72aymcRmPC5y31UNu5XPqruGByI4ZZ+fu8W7HDmWF+KXU1bbfl+ZYfhy5k5/yDU
 uAkygj2tUQN4yHPdLJYTW3OizeLXz0iNpi4wQOqDg20FewIAH/44zI1QZo+76RDZEpqm VA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsv0v0ky1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:51:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HHpue6009445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:51:56 GMT
Received: from [10.227.89.240] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 10:51:56 -0700
Message-ID: <460cb443-868c-ec05-7aec-5b1eee381ae2@quicinc.com>
Date:   Tue, 17 Oct 2023 10:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
 <20220214223051.3610-3-quic_alokad@quicinc.com>
 <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
 <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
 <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
 <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XS1KOf5zFHXkwyenZq4u0BOSAEKI04a6
X-Proofpoint-GUID: XS1KOf5zFHXkwyenZq4u0BOSAEKI04a6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170151
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/12/2023 4:53 AM, Johannes Berg wrote:
> Hi Aloka, all,
> 
> Reviving an ancient thread, but this is where we discussed these things
> last I think ...
> 
> So I said, back at the beginning of 2022:
> 
>>>> Conceptually, I'm wondering if it really belongs into the chandef? Can
>>>> you explain why it's part of the channel configuration? If you've got
>>>> two chandefs with the same control channel, CCFS and bandwidth, but
>>>> different puncturing, does it really make sense to treat them as two
>>>> separate channel contexts, e.g. in mac80211? It seems strange to do
>>>> that.
> 
> 
> And you replied two things:
> 
>>> Added it here so that any command working with chandef will be updated
>>> without any other change.
>>> Example: During channel switch, user can provide a puncturing bitmap
>>> with a new option I added in userspace, and because it is part of
>>> chandef, the same code path validates it for that command automatically.
>>
>> Yeah but is it really a CSA/chanswitch if the puncturing changes? I
>> don't think so?
> 
> Which, well, I think I was confused about - it could we CSA/chanswitch
> depending on what you actually want to do, i.e. it's up to the AP to do
> this as just a puncturing bitmap update in the beacon, or with CSA. It
> might do one way or the other depending on what it wants...
> 
> 
> But also, I read this as being a bit more about the software POV, which
> I didn't really think was the most important part.
> >
> And also, you said:
> 
>>> Regarding if different puncturing pattern should be considered as a new
>>> context - yes, depending on if it is HE or non-HE mode, the new bitmap
>>> may be invalid and the operation should fail.
> 
> Which I'm not sure I understood then, and certainly not sure I
> understand now, but I said:
> 

802.11be allows only few patterns when AP is operating in non-OFDMA mode 
but if OFDMA is used then each 80 MHz sub-block can have a different 
puncturing pattern when BW > 80MHz.
I know *_HE was not the best terminology, originally it was *_OFDMA but 
later changed because we decided to base the puncturing bitmap 
validation based on HE vs older modes.
Function "cfg80211_ru_punct_bitmap_valid" added in this version first 
checks for non-OFDMA patterns, and only if "ru_punct_bitmap_supp_he" 
attribute is set by the userspace then it goes further to also check 
against patterns allowed for OFDMA.
I could not find any other way to decide OFDMA vs non-OFDMA than letting 
userspace explicitly indicate latter.
It would be great if you can provide your inputs on this.

>> That wasn't really the question though. Consider this:
>>
>> Say you have STA + STA, if the first STA is connected to an AP with no
>> puncturing, and the second STA is connected to an AP where the channel
>> and bandwidth are the same, but some puncturing is done, should that
>> really be two channel contexts as far as mac80211 is concerned, and thus
>> require channels=2 in the interface combinations etc.? It doesn't seem
>> right to me.
>>
>> Or consider AP + STA, where the AP is set up for some channel but the
>> STA is connecting to an AP on the exact same channel, but with
>> puncturing... Again, same thing, I don't think it should consume two
>> channel resources.
> 
> Which, actually, I've learned since that I was completely wrong about!
> It should, and likely must, in fact be two separate channel contexts,
> with all the limitations that implies.
> 
> The thing is - back then I was making not just one, but in fact *two*
> wrong assumptions:
> 
>     1. The DSP/radio can receive punctured PPDUs if listening on the non
>        punctured channel.
>        
>        At least for our device that's not true, not sure about ath12k? It
>        seems you have a per-peer puncturing configuration even, but that
>        seems odd, and it's always just set to the vif puncturing
>        configuration.
>        

Yes, same vif puncturing pattern is assigned for all the peers 
associated on that vif, but firmware requires it to be sent separately 
for each peer.

>     2. You can simply transmit punctured PPDUs when on a non-punctured
>        channel, i.e. it's just a rate control decision.
>        
>        This is perhaps less important, but it's also not really true.
>        While you can clearly _transmit_ this way, that's not the only
>        thing - you also need to do the CCA before transmitting, and if
>        there's noise/interference on the punctured channel, you'd much
>        more rarely find the channel to be clear and be able to transmit
>        if this doesn't consider the puncturing, but that's something to
>        do sort of generally in the background for the transmit.
> 
> It might be possible to work around #2, but I'm not sure it's possible
> to work around #1?
> 
> 
> So I think I have two questions:
>     A. Would you object if I moved the puncturing into the chandef after
>        all?
>        

This is where I'm getting confused.
The main reason to put in chandef was that I thought of the bitmap as a 
radio characteristic (not vif). But after you brought up that AP+STA 
mode can have different bitmaps, even though all other channel 
characteristics (width, cf etc) are same, I realized my original 
assumption wrong incorrect.
Moving the bitmap to cfg80211_ap_settings() meant that each AP vif can 
have different bitmap, and I'm guessing you similarly added for each STA 
vif context.
Now if you move it back into chandef, how exactly will this work if you 
need different bitmaps?

>     B. How does ath12k cope #1/#2 above? Would we need to have a callback
>        to the driver to compare if two channel contexts are compatible or
>        not (e.g. if they have different puncturing), or does ath12k also
>        have limitations on RX/TX that mean it would actually prefer two
>        channel contexts for the cases I had outlined in the quoted text
>        above (STA+STA/AP+STA)?
> 

If we do end up moving the bitmap back to chandef, we may need some 
changes, because as I said above, when I originally added it I hadn't 
thought of different bitmaps for each vif.
But can you give an example of what you would consider as compatible 
channel contexts and what would be incompatible? I'm not clear on that part.

Thanks,
Aloka.
