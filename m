Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315FF7CEC96
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJSAKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 20:10:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14255FA
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 17:10:06 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39INwdeF014116;
        Thu, 19 Oct 2023 00:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uEQ1DigX90yviPUZfcfiwxQnoke0yWibWMPW4nd9qMQ=;
 b=bFlWVS+4ybPNOKbdk8W0csJ6S3lCdQgnv1zysGtoD5A9y0n9rZvA6pxcXRKbbH1uM8Da
 3nokblgeyaGgszUQzHUnZyhZoyn66G+s5otdw9anKtDTLnTAEr0FFIb1Ut5//KwllpuI
 QdYwMwMerFs/8tdLarxWqCkFV5N48lJSs9SGJrJhSuNYBe+O8pZjXzpyztHDajxER6Pp
 NzasmnisyuS+blc4kO1uV8ZIm8J+zm2gpXqdjUiU/XzJn9BO6wkhXu3vQBXovmWmi7D4
 x5zQkJFEQmbjdCcymryGtifCdZZb49zj/zA7F8Jyl1wD8ML2HjkA/qhDNkAg90IVYQ8Q 4Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttb7aj30h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 00:10:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J0A2QP024332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 00:10:02 GMT
Received: from [10.227.109.178] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 17:10:01 -0700
Message-ID: <587c4a25-4977-b2d7-a587-f2a742105a43@quicinc.com>
Date:   Wed, 18 Oct 2023 17:09:58 -0700
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
 <460cb443-868c-ec05-7aec-5b1eee381ae2@quicinc.com>
 <28b099e7a37824f0b59ab824e67b3437485e45d5.camel@sipsolutions.net>
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <28b099e7a37824f0b59ab824e67b3437485e45d5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xg-dCcXHvQgYEJfbgq73NnKgDcd7fuDe
X-Proofpoint-GUID: xg-dCcXHvQgYEJfbgq73NnKgDcd7fuDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/18/2023 5:58 AM, Johannes Berg wrote:
> 
> Are you thinking about (separately?) configuring the OFDMA puncturing?
> Which spec-wise you do per PPDU, controlled by the AP (trigger frame), I
> think?
> 

Need to study the spec again so not any time soon.
Will send a new series if it is needed.

> 
>>>      1. The DSP/radio can receive punctured PPDUs if listening on the non
>>>         punctured channel.
>>>         
>>>         At least for our device that's not true, not sure about ath12k? It
>>>         seems you have a per-peer puncturing configuration even, but that
>>>         seems odd, and it's always just set to the vif puncturing
>>>         configuration.
>>>         
>>
>> Yes, same vif puncturing pattern is assigned for all the peers
>> associated on that vif, but firmware requires it to be sent separately
>> for each peer.
> 
> OK, thanks.
> 
> What if it differs for different vifs?
> 

So far that use-case hasn't come up but I'm confirming if we really need 
that support or not. Will get back you.

> 
>> The main reason to put in chandef was that I thought of the bitmap as a
>> radio characteristic (not vif).
> 
> Right.
> 
>> But after you brought up that AP+STA
>> mode can have different bitmaps, even though all other channel
>> characteristics (width, cf etc) are same, I realized my original
>> assumption wrong incorrect.
> 
> So I convinced you, I guess, but what I'm saying is that - at least as
> far as our hardware is concerned - I was wrong!
> 
> Thing is: you're not just transmitting with this bitmap, you're also
> listening - for both CCA and RX - in a specific way. And at least the
> way our hardware works, we apparently can't do puncturing just based on
> the preamble, and can't do CCA depending on the next frame.
> 
> So that means the (non-OFDMA) puncturing bitmap *does* in fact become a
> radio characteristic.
> 

Got it.

> 
>> Now if you move it back into chandef, how exactly will this work if you
>> need different bitmaps?
> 
> You'd get two chanctx since it's not compatible, unless we define some
> extra callback or hw flags to determine what's treated as compatible and
> what isn't. But see above - I actually want that, now that I know how
> the HW works :)
> 
>>>      B. How does ath12k cope #1/#2 above? Would we need to have a callback
>>>         to the driver to compare if two channel contexts are compatible or
>>>         not (e.g. if they have different puncturing), or does ath12k also
>>>         have limitations on RX/TX that mean it would actually prefer two
>>>         channel contexts for the cases I had outlined in the quoted text
>>>         above (STA+STA/AP+STA)?
>>>
>>
>> If we do end up moving the bitmap back to chandef, we may need some
>> changes, because as I said above, when I originally added it I hadn't
>> thought of different bitmaps for each vif.
>> But can you give an example of what you would consider as compatible
>> channel contexts and what would be incompatible? I'm not clear on that part.
> 
> Easy example:
> 
>   * control channel 36, 80 MHz, puncturing bitmap 0x2
>   * control channel 36, 80 MHz, puncturing bitmap 0
> 
> Contrary to what I thought and said before, I want to treat these as
> *not* compatible now, and allocate two channel contexts if I end up
> having to do this.
> 
> johannes

I'm okay if you want to move it back to chandef, in fact I myself can 
send a series for it.
As far as two contexts are concerned, sounds like you don't need that 
for your use-case. And I will confirm if we need it or not.

Thanks.
