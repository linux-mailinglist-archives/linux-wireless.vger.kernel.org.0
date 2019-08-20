Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A69296BDB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 00:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfHTWAh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 18:00:37 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37558 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTWAg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 18:00:36 -0400
Received: by mail-oi1-f181.google.com with SMTP id b25so67792oib.4
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Th0Wwi5W3mxObi7CcFu+DqwvURX69t0W5hLqCx/fX54=;
        b=LfI9zGLO2+3WUNhgVXWAlBz63qQmxo8/63OZ9XGtrPsr3Pu25zKbjoflPtE9gSQHwb
         ZAS3FbfXi7RePEURQoOwEPEwMnWxmAIbdnEoE6BeXuFcNZSo9DSfT+A9jvqj/5pevMps
         uG3iV7K4Af+nnhmLnGFwFem5rsDGd0MBQBV7+NzvHttuDTC4C609OZdX6REnXg9oIzU3
         7U5s49O7l4SqqslU4Aj9V1PXrxesbM/9D4mxnnuA8OHlSaWRfb3y/0ArDKe+WbaJqKpG
         1GpwNYqtSWtgRg9n7pBRS1jNY3V8gaeCOZt3kwCr/k2i1YXg4UY8aaKVsUB9Ccuy7GOj
         0uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Th0Wwi5W3mxObi7CcFu+DqwvURX69t0W5hLqCx/fX54=;
        b=oLk6Bqi8qB0tVhDNzj008poCKyuiyaIdwUJh1g/156uFvDpBCewZLjvX6EWcEeR6Vo
         UT6KZ4lhYOWFWOdOffsjYF316ZCkl1bcgca38zoTSFTEczeC7jBvLEZMv00RtWna9lRr
         Kf0NfU6kI/FHo1r84zFFk1RiEjLJoqzxd698d8P+wU11LPhAqZwHwzSVcjYPLHyqvsV7
         0fNs2I61538meIdfELcQU5052U/40F74WNQ1SFrmTL//NCG5QK3JL3I3y0Ai4DA8VIYZ
         emoHDATHHtc64CxP6tTdfO81Hsc3W36VXQi4AQWuLL09e47H4u4/hzK8kTjsXU34jSA5
         InPA==
X-Gm-Message-State: APjAAAWMz0kyo5fRnBJ5Xax1ZJs1jdh4xI0w+4k1gohn3O5gqfsLAmy6
        j2GUydsmAe1m18YMxUr4LKZedY6G
X-Google-Smtp-Source: APXvYqy2L8DF4XPha3H8vVZRiaNsqLCeywnarXFLNK/Q3eyH41A/t5Xn4aEMbrQO98fKunx7DaTr+w==
X-Received: by 2002:aca:4cd0:: with SMTP id z199mr1540769oia.112.1566338435263;
        Tue, 20 Aug 2019 15:00:35 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n13sm7428353otf.51.2019.08.20.15.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 15:00:34 -0700 (PDT)
Subject: Re: [RFC 0/1] Allow MAC change on up interface
To:     Dan Williams <dcbw@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20190815185702.30937-1-prestwoj@gmail.com>
 <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
 <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
 <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
 <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
 <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
 <b115e933-a357-9904-e831-dea7df1b46b9@gmail.com>
 <3576ad937c0b40b971a1b9c1a7c7396731a94bad.camel@sipsolutions.net>
 <8c04da29-7515-1196-8431-67a6390bc00d@gmail.com>
 <3fd41591acd55535863f11a0cc4f0f5f2afd5bdf.camel@sipsolutions.net>
 <3313f0a7-2b38-9941-46bf-4c1a3e06a267@gmail.com>
 <3beb3208443d39201272e822d26c1389aa4940db.camel@redhat.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <86a8b422-87e3-5ab7-40fe-604969ec8ec1@gmail.com>
Date:   Tue, 20 Aug 2019 16:52:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3beb3208443d39201272e822d26c1389aa4940db.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

On 8/20/19 4:18 PM, Dan Williams wrote:

<snip>

> 
> Code will be written, but I'd rather it be written once rather than 3+
> times for STA/AP/Mesh/etc.
> 

I'm not sure you can state that definitively just yet?  So the real 
question is whether saving the extra round-trip to the kernel is worth 
the in-kernel complexity.  Given that interleaved system calls are 
_always_ a problem, I argue that it is worth it for at least the Station 
case (and it will keep connection times even faster to boot).  Isn't 
minimizing the latency of connections the end goal here?  I get that 
there are trade offs and people have other opinions on what a good trade 
off is.

But don't misunderstand, either solution is better than what we have 
today.  My argument is: "why close the door on a particular solution 
until the costs are known?"

>> The rest, I'm not sure why you are worried about them now?  For
>> station
>> there's a very clear & present use case.  If such a clear and
>> present
>> use case is presented for AP or Mesh, then deal with it then.
> 
> Why would you not want to pass a random MAC for AP or Mesh modes? The
> same reasons for MAC randomization apply for all those too, I'd think.

Umm, I was not arguing against doing that at all?  All I said was that 
no such use case was yet presented.  For AP it isn't typically needed to 
rapidly switch between MAC addresses while keeping the device UP.  If 
you think there's such a need, I'm happy to learn something new? Same 
goes for Mesh really?

> 
>>> I don't see how this will not keep proliferating, and each new
>>> thing
>>> will come with its own dozen lines of code, a new feature flag,
>>> etc.
>>
>> Such is life? :)
> 
> Not really. It's the job of maintainers to balance all these things, to
> step back and think of the bigger picture and the future rather than
> just solving one particular use-case today.
>  > Your tone leaves the impression you want a particular solution pushed
> through without the normal planning/architecture discussions that
> accompany API changes. And that's not how the process typically works.
> 

So who's attacking who now?  We're trying to solve a long standing issue 
that nobody has bothered to fix for years in a clean way.  Something 
that one of your projects would benefit from, btw.

I have a technical opinion about how it should look like.  Johannes 
might have a different opinion.  In the end it is up to him and I can go 
pound sand.  So yes, I know how the process works ;)

Regards,
-Denis
