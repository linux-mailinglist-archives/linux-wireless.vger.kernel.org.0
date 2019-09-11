Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C290FAFFFA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfIKP07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 11:26:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39427 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfIKP07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so14462147oia.6
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4IhEDVP11ZXS2jjzRURpwCCZV+Tuo6d7KlEwreqPqP0=;
        b=IeTVR12MmeratP+OST7fE5KHNvRFP9BkCdXSOZBB6wlSjemGNEgStKUtR2JnXgIwN7
         W0mgn7iKxwSYfDpSUuu6dhqaH21k1ZfCksQaGjKK5CX/Sjz9+APC1CA9ajw69QqC4r30
         hG38BYwd7NjK3RfWWl7M71anQr7d3boPt6dH/nQJ700DtJvvdmNIE292phZUMjdItqrW
         HUT1+wWMHm2Mv0Z6CyOftEfZmj0jd44zukKYxD0pFAjy1iZ8O7PRf/2XneO6uWU2bv+B
         iEtTSqpTFN29ORftxUzWJjiIXTRo7xpssp6p8AL0T+GAfFRb/VgAUgZwUVCQYezUIYas
         9nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4IhEDVP11ZXS2jjzRURpwCCZV+Tuo6d7KlEwreqPqP0=;
        b=U7WKu0y6Zf6wEaL+ws5aSCZFVCt/CegYYrrOqMtFQ+Gb9c+cv5gG3C97rxYnfiVOYo
         dzItyomvWsFeGISjXi6OKuy1FDnqlYABQ/RUEc9Lxvv/FVJAypjdxoDqOLMDGhw8QjZe
         OXFGrAEjtzrQUY14w1ewRLC8rKybaOEjVq+EzMeNcKpdzf2pXuEZ2LShpY1+RhdJl+QT
         jWJoO0/96+x/+F+bZjxm002BedHdzNMF6ijlaY7auVIFVAQRKO07CQE9JSmS+sAD5RkR
         UA1HehHKfD8G51Z7nZ/wBv53DxqjFzxzAfMjq4jv7v6jdXrBu9xHBi8FMUs+xpgwqQBc
         cdSQ==
X-Gm-Message-State: APjAAAU6fuP+17FyJggfmFqzS06szuuCkWUDMsmQxUZfnikgI5pM+upj
        6LAYkLZaBaCAfDCEjzHGnWox6+Ap
X-Google-Smtp-Source: APXvYqyEJ+mtL9kGhE1wVWLPcPXQt+uNqOzT0RjOGmI6t5IPoVnend31zqhBnGVUKsWIoKXYgeHl+Q==
X-Received: by 2002:aca:1212:: with SMTP id 18mr4496653ois.146.1568215618382;
        Wed, 11 Sep 2019 08:26:58 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t6sm6149923oij.39.2019.09.11.08.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:26:55 -0700 (PDT)
Subject: Re: [PATCH] nl80211: Support mgmt frame unregistrations
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20190904162239.2075-1-denkenz@gmail.com>
 <7a089d5ec94da92fc0c1255a2afa6ae0d8b8aaa4.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <fcb56c09-d9de-c086-ff27-75e3bd1da6a8@gmail.com>
Date:   Wed, 11 Sep 2019 08:33:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7a089d5ec94da92fc0c1255a2afa6ae0d8b8aaa4.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 9/11/19 3:53 AM, Johannes Berg wrote:
> On Wed, 2019-09-04 at 11:22 -0500, Denis Kenzior wrote:
>> To state another way, it is
>> currently not possible to write a userspace application that utilizes a
>> single nl80211 genl socket, instead it must open multiple genl sockets
>> for multiple wdevs on multiple phys.
> 
> I don't see how this is too onerous for the application, every
> application is basically going to have an event loop anyway.

What does having an event loop have to do with this? :)

> 
> Thus, I don't really see any reason for us to add a bunch of code just
> to make an application track fewer file descriptors - we need to have
> the cleanup on close already anyway, so why not actually exercise those
> code paths?

I just find this super wasteful.  We have instances where we need to 
register to a single management frame temporarily.  So opening and 
closing a socket just for that is just bloat.

> 
> I do note that with the "unregister on iftype change" patch you could
> switch to an unsupported type and reach this, but I don't think you'd
> want to rely on that :-)
> 

Not sure I understand?

> Possibly I could imagine a reason for this if you needed a single socket
> for functional reason, but you're not really giving any such reason. I
> could imagine that there might be races, but I'm having a hard time
> coming up with a scenario where they actually matter ... if you really
> really get a race between e.g. RX-AUTH and INTERFACE-DEL you'll try to
> do some operations that will just fail, but so what?

- Waste on the userspace side.  Typically userspace uses some sort of 
abstraction for tracking genl sockets.  So it has to allocate buffers, 
etc.  Can we get around that? Sure, but you're not winning any arguments 
that the nl80211 is 'nice to use' that way.

- Waste on the kernel side.  Each socket costs something for the kernel, 
makes things harder to audit, etc, etc.  And we now have people trying 
to stuff 15+ cards into a single system.  Each card might have multiple 
netdevs.  Each netdev might need multiple file descriptors open.  So 
we're ending up needing 30-60, or whatever file descriptors when we 
could just as easily use 1.  Extreme case? Sure, but I like to remove 
bloat whenever / wherever I can.

Regards,
-Denis
