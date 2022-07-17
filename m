Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D3457748F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jul 2022 07:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiGQFCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jul 2022 01:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQFCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jul 2022 01:02:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8718B08
        for <linux-wireless@vger.kernel.org>; Sat, 16 Jul 2022 22:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aWTbuxp0XqzR/gtZRxud+pVhtJFvYyOGKoUz+O1CWOE=; b=XRlfEcWur/xUMVFwZ3WQHRi3PC
        mJW2MGanmO/OvgyFA5pd2E+DvCJI+uue+AmphszIMkZYxieJ77daPudrEMJ0/dHuOAix/Juszt+Vc
        FFVmDbd0wRtsaO2oL0bSW1Vi1INdMeU2wJP6MBiEaYsZT4SOP8QZg17XEq/OT9Yk7ioY=;
Received: from p200300daa73eb000310d56162519caa6.dip0.t-ipconnect.de ([2003:da:a73e:b000:310d:5616:2519:caa6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1oCwQO-0003w9-IY; Sun, 17 Jul 2022 07:02:36 +0200
Message-ID: <a438e076-7fa1-1b1c-0e39-597b57c39367@nbd.name>
Date:   Sun, 17 Jul 2022 07:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Mesh Fast xmit support
Content-Language: en-US
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
 <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
 <SN6PR02MB4334670B5FD85EB6940A64F8F7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <9bce16843dcc698740d90d8963a1a55516fb1d39.camel@sipsolutions.net>
 <SN6PR02MB4334F77368A1AC3F1202117CF7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <940aa2fe0f2497e9fab9a5118001034b5de18d64.camel@sipsolutions.net>
 <19477e0584f7031b37fcdfcc5ef10e7b00842f07.camel@sipsolutions.net>
 <SN6PR02MB433432544D1F5FF9672579C3F78B9@SN6PR02MB4334.namprd02.prod.outlook.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <SN6PR02MB433432544D1F5FF9672579C3F78B9@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 15.07.22 04:16, Sriram R (QUIC) wrote:
>>-----Original Message-----
>>From: Johannes Berg <johannes@sipsolutions.net>
>>Sent: Friday, July 1, 2022 3:30 PM
>>To: Sriram R (QUIC) <quic_srirrama@quicinc.com>; nbd@nbd.name
>>Cc: linux-wireless@vger.kernel.org
>>Subject: Re: [PATCH 0/3] Mesh Fast xmit support
>>
>>WARNING: This email originated from outside of Qualcomm. Please be wary of
>>any links or attachments, and do not enable macros.
>>
>>On Fri, 2022-07-01 at 11:59 +0200, Johannes Berg wrote:
>>>
>>> >   So was skeptical on having a higher cache size(like 250 or 500 max).
>>> > Hence had a value of 50 and left the configuration part for devices
>>> > which needed higher cache.
>>> > But as you mentioned, this is only runtime max memory and not default.
>>> >  So we should be fine to set some high limit, If above is not a
>>> > concern could we stick to an upper limit of ~150-200 ?
>>>
>>> Right, I'm fine with that. I was just throwing out 500 as a random
>>> number to show that it's not really a huge memory requirement.
>>>
>>
>>But maybe Felix wants to comment? Felix?
> Hi Felix,
> 
>    Could you kindly share your comments on this.
I agree with making it big enough so that almost nobody has to tune it. 
I think 512 would be a reasonable default.
By the way, if I'm counting correctly, you might be able to reduce the 
size of the cache entries a bit by moving the 'key' field below the 
'band' field, getting rid of some padding.

- Felix
