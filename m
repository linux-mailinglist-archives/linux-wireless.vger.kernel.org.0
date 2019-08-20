Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D35969D7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfHTTyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 15:54:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37937 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbfHTTyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 15:54:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so6200995ota.5
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9/yC4yLR8WBmE/nahyN6o17ldKIX20B3dXoDiaJY11g=;
        b=iMfb2751WL9pwiW3Bl6QAw+eWn/Ufg4/8HftyDm55L81qhl6PEP6hXU7FMMFoH+u9W
         1+3Ri93px1NiWWo9Vyy0mD9GhLbBdXtgg9BXrOg6Fyc3LIeLp+oaB1U1192PjXUWuAnv
         MPKcvzLdFB29WQZ9tVKygXppvPdki3avww2FcSp+dd7a+6EJqouaXgtJ4hX3V14Z0j71
         vRfvmuPX8tebVKoubQc3Ztjr2NheJ+QKSKCLJms0AoBgQouvuRcG66Ok3xA8jux2xbjI
         ssDvWujVXyxnJrLWVCh6QhKiePIo7vM7nVNY/c0DpWxF9Ce0bLXp3FYQxrprZ6loRRv3
         3i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9/yC4yLR8WBmE/nahyN6o17ldKIX20B3dXoDiaJY11g=;
        b=P8GZ6hWdBnEa4+er6XLtd/i0SW3jUOxef1SN60Tklk6tIBWKh00npr8Q5JVIFUEclL
         aKy8hMhC9E20SKNgK/3LOGt9in1UzIftVVuR4+y1TKiVQ+2hKVvYhYoHaudbY/JSmqkU
         IHx40J5kw4m9xklLxABllXM8rgGt0z5JOCXK5JVXMZw2R9QP46eOFg+FkKLqiyTlWGFQ
         w92S6bSVjD45E+b31Z95yyz9oIE4foPs+fzpSVvvRwYmy5fZyaGETbG4uDdK2umfE8uR
         xWY9nozxUNmn9j0Tb+hRI1Z7OQlFdAJ8EQiLsCoh6M4LehBmAzlvCjddhKG93/iRnnjX
         0m1Q==
X-Gm-Message-State: APjAAAWn+1dvLvhIekYlvLMkXi9wMBAwuJ0egMKb6/U/roSc+vSPPc64
        61lJwg43kdhrpqGF/8TFEFLBzWjd
X-Google-Smtp-Source: APXvYqyH3fDwSyAUjW40ZPHWjsmq1HYB7Zs2DSY2ateFuNeO/h2KlPI4UQz5xqCEnyBX7n/sSubbYQ==
X-Received: by 2002:a9d:458f:: with SMTP id x15mr22908878ote.314.1566330871516;
        Tue, 20 Aug 2019 12:54:31 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u191sm4546555oie.42.2019.08.20.12.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:54:30 -0700 (PDT)
Subject: Re: [RFC 0/1] Allow MAC change on up interface
To:     Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
References: <20190815185702.30937-1-prestwoj@gmail.com>
 <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
 <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
 <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
 <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com>
 <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net>
 <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com>
 <dd58815c934ab52acbd8a21d04dd0d44e9d32913.camel@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <fcfc70bc-78ba-cd06-55ab-d53d80ac2cc8@gmail.com>
Date:   Tue, 20 Aug 2019 14:46:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dd58815c934ab52acbd8a21d04dd0d44e9d32913.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 8/20/19 2:32 PM, Johannes Berg wrote:
> Hi Denis,
> 
> Rather than replying to all the separate items here, just two things:
> 
> 1) I'll reiterate - please keep things civil. You're taking things out
>     of context a *lot* here, in what seems like an attempt to draw a
>     parallel between my and your utterances.
> 
> 2) I'll take your point that I've been somewhat dismissive in tone, and
>     will try to change that.
> 

I'll apologize for the methods I used, but you were not getting to 2) 
above via our earlier discussions.  Anyway, peace.

> 
> I do want to reply to two things specifically though:
> 
>> Fine.  I get that.  But how about asking what the use case is? Or say
>> you don't quite understand why something is needed?
> 
> Really, I should *not* have to ask that. You should consider it your
> obligation to provide enough information for me to review patches
> without having to go back and ask what it is you actually want to
> achieve.

So let me ask you this.  What do you _want_ to see when a contributor 
submits something as an RFC, which that contributor states is not ready 
for 'true' review and is really there to generate feedback?

Do you want to have that contributor use a different prefix? Every 
maintainer is differrent.  I get that.  So if we want to start an actual 
brainstorming session with you, how do we accomplish that?

> 
> Compared to some other subsystems and maintainers I've dealt with, I
> think I've actually been rather patient in trying to extract the purpose
> of your changes, rather than *really* just dismissing them (which I've
> felt like many times.)
> 

I'll admit you're not the worst I've dealt with, but you can always 
improve, right? :)

>> a maintainer who's job (by definition)
>> is to encourage new contributors and improve the subsystem he
>> maintains...?
> 
> This is what maybe you see as the maintainer's role, but I disagree, at
> least to some extent. I see the role more of a supervisor, somebody
> who's ensuring that all the changes coming in will work together. Yes, I
> have my own incentive to improve things, but if you have a particular
> incentive to improve a particular use case, the onus really is on you to
> convince me of that, not on me to try to ferret the reasoning out of you
> and make those improvements my own.
> 

So this goes back to my earlier point.  How do you want us to start a 
discussion with you such that you don't become a 'supervisor' and 
instead try to understand the pain points first?

And really, we are not expecting you to do the improvements on your own. 
  But you know the subsystem best.  So you really should consider giving 
actual guidance on how to accomplish something in the best way.

Also, look at it from the PoV of any new contributor.  So while I can 
definitely relate to what you're saying here, I think you should put 
yourself in your peer's shoes and try to be more understanding of their 
perspective.  At least make the effort to hear people out...

> 
> So please - come with some actual reasoning. This particular thread only
> offered "would elminate a few potential race conditions", in the cover
> letter, not even the patch itself, so it wasn't very useful. I was
> perhaps less than courteous trying to extract the reasoning, but I
> shouldn't have to in the first place.
> 

Okay, so we'll work on that.  But this is a two way street too.  And 
sometimes it seems like you're not actually reading the cover letters ;)

Regards,
-Denis
