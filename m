Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB582E196
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE2PuD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 11:50:03 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33307 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2PuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 11:50:02 -0400
Received: by mail-ot1-f48.google.com with SMTP id n18so2538958otq.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2019 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AE3u8p38OYa2894QCjiHnYyGPJNgzazR5JdhW5+2bj8=;
        b=a1kdBW8X+ZgT8pJCJfiDbjq0PcMiH7ET9DWZpfgUk8ivwv7V7uojuY/6uUdNcPjnQF
         oPZT66PpMfq7YB2oEBsv9yKmgEemwEP2ZNegjY6bTW+GzWf4UqzemHIrutcIaw427un6
         k6BKO/uvyUOWUNKDt04//QpjjWZOVl6mK3t2AWf301rUbBpSVlMv4vcrj6v5HdLK5zPt
         i81KP+dGM/IIcYBWT1a/X1yCnv8AhMmmIuN3tHZZqgUfmP+as1wjE475/Y5dtFAsP7mG
         u8KdCdS/6n5ZEesrtz0/n/bqMw9Aj6v7q/Mtk9ogNrZ19nfbMvOlMmAXsCwUYyqLgT3K
         jf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AE3u8p38OYa2894QCjiHnYyGPJNgzazR5JdhW5+2bj8=;
        b=EdaTMmOA5k2pgN+aT66EQgEXG0qGrG7QhFK62t+oWQhkjcdRQpJK4CPwhE/wNdgyBq
         0piPssGOFKiNQVn9kATKhFk4xCVarxTj1Xg4SfQFNRVZuehjm6Q5VkEAQGzfIYqaduQ3
         agOLrxqhQOTS6wI87UvJ4lJBz9mTWWuMxqEwXqCiFv6v+ylfp297RuN3mtOkY3QHlNEo
         CAM8dhIAG+0LWMzksP/GbWcsyCSF6lbvaK3pxhNVI9olHZRaDLQdTT3xErKb/UZp14fk
         3NwMXIK40LKuyVNqMwddsUneOxxL1tgDtlM/n5iMftyFu8EyN8xWmj87Wlr80+MisWs/
         tNbQ==
X-Gm-Message-State: APjAAAXjyBKVA5jJyyMwSeNISubaxIiWZsa7+KEWBvldraI27a9xj9x4
        LQqyd+BlOm1oNZTrqvXjV8/Acvfx
X-Google-Smtp-Source: APXvYqxaJPDmvLzMZGHNnE6xx4eOJkx83v9pK7iyb0GMIa2exux57QVLK+h0azG6obxIYANkps0PBg==
X-Received: by 2002:a9d:3da5:: with SMTP id l34mr37229444otc.252.1559145000966;
        Wed, 29 May 2019 08:50:00 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q14sm6233985otl.79.2019.05.29.08.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:50:00 -0700 (PDT)
Subject: Re: FYI: vendor specific nl80211 API upstream
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <c138fac51c7f49bbcd8617ae0a2c750d78abb35d.camel@sipsolutions.net>
 <c7912523-ef79-9ac2-c465-80de189551a6@gmail.com>
 <f3847d4efe6822bba3948993ddc4cde31615436f.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <ea5ea854-612e-9f9d-5e4a-f3161bb3f109@gmail.com>
Date:   Wed, 29 May 2019 10:49:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <f3847d4efe6822bba3948993ddc4cde31615436f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 05/29/2019 04:09 AM, Johannes Berg wrote:
> On Tue, 2019-05-28 at 12:36 -0500, Denis Kenzior wrote:
>>
>> I'm guessing that you guys considered and rejected the idea of pushing
>> these out to a separate, vendor specific genl family instead?
> 
> We do actually use that internally (though mostly for cases where we
> don't have a cfg80211 connection like manufacturing support), but vendor
> commands are there and people do like to use them :-)

And herein lies the danger.  If you make it too easy to add vendor APIs, 
there's no incentive for the vendors to do anything else.  In the end 
this all becomes a mess for userspace to deal with.

One idea off the top of my head is to introduce a concept of 
'experimental' APIs in NL80211, ones that are not guaranteed to be ABI 
stable going forward.  Specifically for dealing with such 'vendor' APIs. 
  The semantic difference might be subtle, but I think the effect will 
be drastically different.  E.g. people will approach this more seriously 
and you will get more people reviewing the API.

> 
> The idea with formalizing this is that they actually get more
> visibility, and I hope that this will lead to more forming of real
> nl80211 API too.

What about ABI guarantees (to tie it in with the discussion above) ?
If the vendor wants to change their API, can they?  Are NL80211 APIs 
stable unless they are vendor APIs?

Anyhow, speaking from experience with oFono, which has to deal with a 
bazillion of wwan modem vendors, I suspect that the opposite will 
actually happen.  Any time we let through a vendor API, the vendor lost 
any interest in generalizing it further.  And it becomes a huge pain to 
implement a proper generic one later.  I get that there are cases where 
something just cannot be generalized.  In that case it belongs on a 
separate genl family (or whatever) altogether.

So I would highly encourage you to reconsider this decision and 
deprecate vendor APIs altogether.  If someone really cares, they can 
implement their own genl family.  It is really not that hard.  And then 
they control the API, API stability policy, etc.

Regards,
-Denis
