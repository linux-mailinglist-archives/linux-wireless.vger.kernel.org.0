Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E0396525
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfHTPsp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:48:45 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40016 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHTPsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:48:45 -0400
Received: by mail-ot1-f54.google.com with SMTP id c34so5467118otb.7
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NmcCCioZF16ax1UfyuMOm3tQN/s/GYmwd+A5S/X0rqI=;
        b=PG6eB4aaqhFsVB0bvGiNIKR4dDj5UFrdrjdzAW8MbcIL4I7nxs1ui1LLe7gBZ6qxO8
         slid0fWUmHXEwXafZLtvnKPRMGVJeyS1J61BTdT/D6Q4geCzXBkI+tEmFMW63xjQSOag
         DHTh67hs4AxMYWSzP0wKnt9mKWEemuofVIk0UnQet95LN+OYTttWpfgP7g7/qnHDyBwM
         DS4Lun6LuRlAkf0CPpve52oWL9wZrqFKaA2F0QeE4Ytepfz+rxeSUUWNQHBnv0vqBi2J
         xjLCznLbw/FCQrOszi3TNjjP7hc7lKM3ZptCnKfOjxVlwWqXN137fiP66ojzTlzSMJT5
         GWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmcCCioZF16ax1UfyuMOm3tQN/s/GYmwd+A5S/X0rqI=;
        b=RE4ICfjcs2u83WRnHVY1wlGMYgUywAew0+owfM6Gty/AgVjUMx+p3vQY/R1EOv053P
         IdIPjlPpGMTXEGZ6Y7iEdGlNgQjrbm9FDrgMYHMkMkp7vbvnOFWiX+tsKyn4pnpzdIFc
         xpwRzaf81tf4nNeHaIN6D9KgNr1MFgKQsSQt+zVnERIRsnPU1wlOa+47hhS5jG9/cJ/S
         CgObqKQsTdt6ynPwhMIAxjC4mpxeDC08W4KL9Bh7sGxs7WJqi/OtnMvh85PRKgbHoUVR
         iO0QBLzr6mja86ndBqeoeeOTvIldYwVli/xv8Lo+01gb51JZQW/PAu7Ue5x4lumsLlvg
         Srdg==
X-Gm-Message-State: APjAAAXcH6OjZwhOmIsG17lNAF/NlRE3pGqQYyWBhHHEzB7atqPzJIIb
        crbDTe03mXa7IVdrcfVDTGPlKiIw
X-Google-Smtp-Source: APXvYqwU44tqB4/fCDRmHuQG3U1lmmrV9Q5aW1h9rceWYZFehMlHSTWX+vJylxyVtu3kNJh/iYjHwg==
X-Received: by 2002:a05:6830:16ce:: with SMTP id l14mr22002159otr.169.1566316123844;
        Tue, 20 Aug 2019 08:48:43 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u5sm7209440ote.27.2019.08.20.08.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:48:43 -0700 (PDT)
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
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com>
Date:   Tue, 20 Aug 2019 10:40:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

> Stop.
> 
> Your tone, and in particular the constant snide comments and attacks on
> me are, quite frankly, getting extremely tiring.
> 

Look, I'm sorry I hit a nerve, but from where I am sitting, it had to be 
said...

Regardless.  Peace, I'm not trying to start drama here.  We just want to 
improve things and it feels like you're shutting down every idea without 
truly understanding the issues we're facing.

> It almost seems like you're just trying to bully me into taking your
> patches by constantly trying to make me feel that I cannot know better
> anyway. This is not how you should be treating anyone.
> 

Before lecturing me on my tone, can you go back and re-read your 
responses to many of the contributors here?  I mean really read them? 
Your tone is quite dismissive, whether intentional or not.  When one of 
my guys comes to me and says:
	"Johannes' response was completely useless, it feels like he didn't 
even read my cover letter"

I will come out and call you on it.  So if you don't mean to come off 
that way, great.  We'll just chalk it up to a mis-understanding.

> Look, I did say I don't see a point in this, but you're taking that out
> of context. I also stated that I didn't understand the whole thing about
> "race conditions" and all, because nobody actually explained the
> reasoning behind the changes here.

Fine.  I get that.  But how about asking what the use case is? Or say 
you don't quite understand why something is needed?  We'll happily 
explain.  When the first reaction to an RFC is: "I don't see the point" 
or "You're doing it wrong" from a maintainer who's job (by definition) 
is to encourage new contributors and improve the subsystem he 
maintains...?  Well that's kind of a downer, don't you agree?  You're 
the maintainer and you should be held to a higher standard...

I maintain 3 projects, I know the job isn't great, but you still should 
be (more) civil to people...

> 
> James, unlike you, managed to reply on point and explain why it was
> needed. If all you can do is accuse me of not using the software and
> therefore not knowing how it should be used, even implying that I'm not
> smart enough to understand the use cases, then I don't know why you
> bother replying at all.

Good on James.  I council all my guys to keep cool when dealing with 
upstream.  But that doesn't mean you should be dismissing things out of 
hand on the very first interaction you have with a new contributor.

> 
> I can understand your frustration to some extent, and I want to give you
> the benefit of doubt and want to believe this behaviour was borne out of
> it, since I've been reviewing your changes relatively critically.
> 

Good.  I want you to do that.  The changes are in very tricky areas and 
you know the code best.

> However, I also want to believe that I've been (trying to) keep the
> discussion on a technical level, telling you why I believe some things
> shouldn't be done the way you did them, rather than telling you that
> you're not smart enough to be working on this. If you feel otherwise,
> please do let me know and I'll go back to understand, in order to
> improve my behaviour in the future.

If you interpreted my rants as an assault to your intelligence, then I'm 
sorry.  They really were not meant this way.  But sometimes we really 
had to wonder if you were using the same API we were?  So the question I 
asked above was purely logical consequence of what I was seeing.

You yourself admitted that you have never implemented an event driven 
stack.  So how about listening to the guys that are?

We are using your APIs in different ways.  So instead of questioning why 
or attacking those ways, how about asking whether improvements can be made?

We are facing serious pain points with the API.  So instead of 
dismissing things out of hand, can we work together to improve things?

We are trying to make things fast.  The API is frequently not setup for 
that.  The MAC randomization is just one example.  Bringing down the 
interface (and shutting down the firmware, toggling power state, 
cleaning up resources/state) prior to every connection is just not 
acceptable.  Look at the link I sent.  The Android guys state 3 seconds 
is the typical 'hit'.  This is literally wasting everyone's time.

> 
> Please help keep the discussion technical, without demeaning undertones.

Point taken.  And I apologize again.  But please consider what I said above.

Regards,
-Denis
