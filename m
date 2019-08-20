Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E095096896
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfHTS2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 14:28:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37612 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfHTS2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 14:28:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id f17so5965246otq.4
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BwklA2rk1JZK5oTr7UAKN0NVD9l13aAKJc9e9kaYQgA=;
        b=XpnStAa8uLubbg+A+ejUvbCWMcY4/c0QImKhNVIQZAzPxs634zCuBB8/sWDCZTiS7q
         08kTJjOCThJ/ZUvQ26z2ga17Tnl7oip6W9EO+faiqPuXovHV7DE3hSvTSO9tMePK/xmL
         MS5vI02esyzv6w2HJgss7kKctOYg0bgElZsX9LhijI7+eUJ5wbFItcKdwIAl4oVKxGTx
         ZsQ9MekqDmI6sJ7YLuE9+D4+wUwyzKb75rUeL4rpH0ZT8KEuLQeGEAEKI5ShQD8gq/pg
         3VlGmXQ6GEVMV+FOLvlaU3elo4R3V/E+iAWKA49TqRuSEtlgT3bbHAZKH/E67vtKhLUG
         r+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BwklA2rk1JZK5oTr7UAKN0NVD9l13aAKJc9e9kaYQgA=;
        b=YHjeV72W/PWwYIjpEyM1RhBsDNbVavbSUE89yWhr+NVrmf7iYIwyCXwjkHF+BCsJFL
         VmsTOfs2y+CzieF98a/Coh+5kKk1f5SJODG17n5G3U9rvy9CJsIEL8AzxS0fL5NCct3P
         xOAsTo5wb08Nv0LlZkX0EfzHhEFU1t2cmbMDyizM7JIUBfZzuNEGjV1YGEj2invs1zpZ
         UsnmnSX6CRsUgrLOCgkaQ7tOlA4LB5asfe7zMsj9J45OBtuPOi1OjJHmmpSW/PRmpe5g
         AYKdWWETQvCsvKqN97eNo5nxLFQH8jt82kEplj4Y/5lG6XGC12aKczoiXu2Tv71BHBlm
         +WRg==
X-Gm-Message-State: APjAAAUjUEeS7BXJXy+Pavd/y4gOkckOCTDmyVr+dsJlRdaRtK7q52zl
        1BSrPZSe1R9M2w9bMI9X4xrtfaQ3
X-Google-Smtp-Source: APXvYqzx+kTsAVAovo3nwaZklXFhrGrkDqANrUeGTLL+vcS2qGjp52z+GF8e3ETKuMGIldMkzrR1YA==
X-Received: by 2002:a9d:4685:: with SMTP id z5mr22888039ote.359.1566325731229;
        Tue, 20 Aug 2019 11:28:51 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a16sm5234195oid.26.2019.08.20.11.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:28:50 -0700 (PDT)
Subject: Re: [RFC 0/1] Allow MAC change on up interface
To:     Dan Williams <dcbw@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
References: <20190815185702.30937-1-prestwoj@gmail.com>
 <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
 <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
 <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
 <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com>
 <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net>
 <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com>
 <32547793981b3997f7e0f74137745f38615e5c54.camel@redhat.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <32a1bddd-2472-10a3-4d0d-5634814e635b@gmail.com>
Date:   Tue, 20 Aug 2019 13:21:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <32547793981b3997f7e0f74137745f38615e5c54.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

On 8/20/19 12:53 PM, Dan Williams wrote:
> On Tue, 2019-08-20 at 10:40 -0500, Denis Kenzior wrote:
>> Hi Johannes,
>>
>>> Stop.
>>>
>>> Your tone, and in particular the constant snide comments and
>>> attacks on
>>> me are, quite frankly, getting extremely tiring.
>>>
>>
>> Look, I'm sorry I hit a nerve, but from where I am sitting, it had to
>> be
>> said...
> 
> But did it really? And in that way?  There were certainly better ways
> to go about that response.

The issue is that this isn't the first such occurrence.  There is a 
pattern here and it needs to change.  So +1 on handling this better.

> 
> I don't recall seeing a NAK anywhere his email chain (which you'd get
> with some other kernel maintainers) but instead (a) an explanation of
> why the proposed solution had some problems, (b) some alternative
> possibilities and (c) requests for more information so the discussion
> could continue.

So the cover letter states:
"Set IFF_LIVE_ADDR_CHANGE on net_device. Note: I know setting this
    where I did is likely not the right way to do it, but for this
    proof-of-concept it works. With guidance I can move this around
    to a proper place."

and I'll leave it up to you to read the first response from the maintainer.

> 
> It does the requested changes no good to take that kind of tone. Let's

Neither is:
"don't do that then"

or

"I'm not really sure I see any point in this to start with"

or

"To me, the whole thing seems like more of a problem than a solution."

> move on from here and keep things constructive to solve the problem at
> hand, which is:
> 
> "Changing the MAC address of a WiFi interface takes longer than I'd
> like and clears some state that I'd like it to keep."
> 
> That is a technical problem we can solve, so let's keep it at that
> level.
> 

I'm all for moving on and having the people that know this stuff well 
giving actual guidance, as was requested originally.

Regards,
-Denis
