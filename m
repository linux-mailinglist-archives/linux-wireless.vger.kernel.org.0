Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FD196AD6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfHTUpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:45:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41460 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:45:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so6344274ota.8
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sa3H5Q4bbbpw7z7YnmbEoozTdvTU0v37RixAiRp6ido=;
        b=B5tyOhWIhcC6wkreZm3WifM3drkVKdG69iZc0r+7Lirx4UrNYbNe9pxH0UkM4QutG1
         4VW0/TxgQNq/tR5+vmhUkSyhnQNcK7En3YXJabk5ox0aBRbMzTa2iPd/eza5sOa31sLq
         NAKPGtSWmpyI9JXleZ9AzwqnlRh87rd3nFtfbGZwzsJlWEMGz9R3gU1Rwp4G5dVjzttx
         Ph35LGtJMzw0Gk6xfmdoWkIoJZxZyaBdOiv/4QqRFBO9Gn16PCorY67O/4qj3YgcM4fD
         /LZgXLkByYuw8Zad1XjzxXE946heC2fpcDMFBU0JDsbUUL+W/AdcodF4FOpLkwkJKgeR
         T3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sa3H5Q4bbbpw7z7YnmbEoozTdvTU0v37RixAiRp6ido=;
        b=b5A04P6Zq/dvY4s7b+c9UNeruOuxTJKRVjfKWUpxhEZY95PgdCp+QEGqCQOyqcs1ND
         j5qiLutCQ7sNCNATNIBbo5rqaWn1VKN3m+1X+iKKhDYRlII/0WN6h4AT1VKP6JqYVPBF
         5SyIU1OfLOs/psARFxWMNK5ATamD4trBHSKIHpz7QkFXhTpKYHc3dGyTynSRgle+c66w
         j+/dSMIiitjqnUzmzDPQOfL1E5BOjaYP6Tgd8GuMzRghu4EgQgUJ4AhtTFnL3Ywl835s
         2FFvXjqvBc9CS4eefYbMRgDWtlJnmypq/HF9+ixJTXXlBj9AyD8gzw4go3+mDq2CJ+h/
         jYqQ==
X-Gm-Message-State: APjAAAXDYkeoSRaS8uQaLSA+kTglZ5Il6it6pJN5Z7yB+SO3GDucpPF3
        uD9QVcOAmM2XYZmD1nNNGg0=
X-Google-Smtp-Source: APXvYqyonFoSbXUnfkhpxESqUA16coIWxVBX0T4nugQf9EkM82EwkAWpDzI5eUVW/Otyz54qy1Q5NA==
X-Received: by 2002:a9d:7cc9:: with SMTP id r9mr25120558otn.188.1566333929507;
        Tue, 20 Aug 2019 13:45:29 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k12sm5233764oij.21.2019.08.20.13.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 13:45:28 -0700 (PDT)
Subject: Re: [RFC 0/1] Allow MAC change on up interface
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Dan Williams <dcbw@redhat.com>
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <3313f0a7-2b38-9941-46bf-4c1a3e06a267@gmail.com>
Date:   Tue, 20 Aug 2019 15:37:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3fd41591acd55535863f11a0cc4f0f5f2afd5bdf.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 8/20/19 3:15 PM, Johannes Berg wrote:
> On Tue, 2019-08-20 at 14:58 -0500, Denis Kenzior wrote:
>>
>> But what actual complexity are we talking about here? If the kernel can
>> do this while the CONNECT is pending, why not?  It makes things simpler
>> and faster for userspace.  I don't see the downside unless you can
>> somehow objectively explain 'complexity'.
> 
> It's just extra code that we have to worry about. Right now you want it
> for CMD_CONNECT and CMD_AUTH. Somebody will come up with a reason to do
> it in CMD_ASSOC next, perhaps, who knows. Somebody else will say "oh,
> this is how it's done, so let's add it to CMD_JOIN_IBSS", because of
> course that's what they care about. OCB? Mesh? AP mode for tethering?
> Etc.

I don't buy the extra code argument.  If you want to do something useful 
you need to write 'extra code'.

The rest, I'm not sure why you are worried about them now?  For station 
there's a very clear & present use case.  If such a clear and present 
use case is presented for AP or Mesh, then deal with it then.

> 
> I don't see how this will not keep proliferating, and each new thing
> will come with its own dozen lines of code, a new feature flag, etc.

Such is life? :)

> 
> Relaxing and defining once and for all in which situations while the
> interface is up you can actually allow changing the address, and then
> having userspace do it that way is IMHO a better way to design the
> system, since it forgoes entirely all those questions of when and how
> and which new use cases will come up etc.
> 

That would be great in theory, but practically never works at least in 
my experience.  So maybe keep and open mind?  There is a clear need to 
make this path as fast as possible for STA.  There is no such need (yet) 
for the other cases you mentioned.

>> This was an RFC.  There isn't much point for us to cross all the 't's
>> and dot all the 'i's if you hate the idea in the first place.
> 
> Sure, but I cannot distinguish between "we only want it on CMD_CONNECT"
> and "we'll extend this once we agree" unless you actually say so. It'd
> help to communicate which t's and i's you didn't cross or dot.

Okay, I'll admit the RFC description could have been better.  But in the 
end you're human last I checked (at least I recall meeting you several 
times? ;)  How about a simple "Why do you think you need this?" first?

Regards,
-Denis
