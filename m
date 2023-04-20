Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C555D6E942C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjDTMWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjDTMWq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:22:46 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906A5585
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tgHA/8gOBSUcTwpGPB+hd0rYPhTkORPdUX5P40XrpVk=; b=d3W7dB0QfUaQLXOHlSc13jSYLc
        pO43edO1VL14XgP9+PHYubdaQbG7gij66lQhbx3TO8Sd58GEaA4oSSDvnTb3Thol5zxxoX7G0rRoD
        AsISbZGa7ErB+8ieP2wZB8Y/GpSCv4xJsWm/Qg7eT2ljHnb9R2bpMqKrxnj14gZ6nVI0=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ppTJ6-00GeRX-Qf; Thu, 20 Apr 2023 14:22:36 +0200
Message-ID: <6d97d1f3-9f77-a1c3-68b5-83065c87b4ba@nbd.name>
Date:   Thu, 20 Apr 2023 14:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>,
        Karthik M <quic_karm@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <20230417100258.22965-1-quic_karm@quicinc.com>
 <bc1903aa09391667262aeadf1859600579f0a9f1.camel@sipsolutions.net>
 <50a76761-5be3-8ea7-c2f3-a14c158aa039@uni-rostock.de>
 <e4dd26fa53ad2535f5a20be63a4b294d99306ffb.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <e4dd26fa53ad2535f5a20be63a4b294d99306ffb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20.04.23 12:27, Johannes Berg wrote:
> On Thu, 2023-04-20 at 11:30 +0200, Benjamin Beichler wrote:
>> > To me, basically, I see two ways to solve this:
>> > 
>> > 1) we have DECLARE_EWMA_ZERO_VALID() or something like that which
>> >     *doesn't* treat 0 as an uninitialized value, and either has a
>> >     separate "not initialized yet" bit (but that's iffy storage wise),
>> >     or simply has another argument to _init() for the initial value or
>> >     so.
>> > 
>> > 2) you don't just don't use 0 and 100 but say 1 and 100, that results in
>> >     basically the same behaviour, but avoids the special 0.
>> > 
>> > johannes
>> 
>> I also ran into that problem in the past, and reviewing it again with a 
>> college, I think, this is a real bug in the EWMA implementation. I try 
>> to provide a proper patch in the next days, but actually the EWMA 
>> handles the internal value zero, always like in the initialization, 
>> which is wrong, e.g., for positive/negative averaged values.
> 
> Yes, it's always wrong as long as you feed it something zero, or values
> with different sign.
> 
> For a lot of use cases, however, that doesn't matter. Originally, it was
> used e.g. for signal strength averaging, average packet lengths, etc.
> where it really doesn't matter since you can never use 0 or values that
> have different sign.
> 
>> A quick research shows, this bug is since the first implementation of 
>> the ewma in the code ...
>> 
> 
> Yeah, I'm aware of that, I was around for it ;-)
> 
> But see above, I'm not sure I'd even call it a bug, at least not
> originally with the users that we had intended.
> 
> Hence I don't know if it's really good to fix this in general - for many
> of these cases zero can still be treated specially (and like I mentioned
> in my previous email, we can even here avoid 0), and then we don't spend
> an extra byte (or likely 4) to hold a "first time" flag.
> 
> Dunno. Maybe it's not worth thinking about the extra memory space vs.
> the extra maintenance cost. But maybe at least on 64-bit we could steal
> a bit from the unsigned long? Not sure what all the users are..
We don't actually need a full bit. We can just add 1 to the internal 
value for initialized values. How about this (completely untested):
https://nbd.name/p/69b00c5b

- Felix
