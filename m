Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEAA6749F8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 04:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjATDTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 22:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATDTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 22:19:04 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A697C0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 19:19:03 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g2-20020a9d6b02000000b006864bf5e658so2406309otp.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 19:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxJtcfmjg8bDlWo77QXfqDNdo8CBClhx9W/RQtlqbwY=;
        b=195AXt9odDu2myrtF32+GBb0qMFgjNikCrpxsa+WbA8hIOrugiKzMmRa6ck9jEEnh+
         BAiMUjeACSwa7DIsy0nd31WMLgqeemkaP54UGh/z5/4/iE4OKfk/JF3Mfjc9Slk04hNo
         yl5Eob9OFP8rjo94KXNck41rTFVGwR12Dn+yA5SLoZAqZ3VzofVm+vx+0BgQAYSmr785
         93R2tgLtdgq0ZrmMjpy2ltpjwYB3CfaG5BeK8n4rbY9oAJxrmKWOuImd3ZYcTj/FPdb2
         jJLXFRha+Q7ERnsBZifTFijpda8XPNDI9gPItiLsvkjmbQtAsn8L1qQF4XOocbXXc8zc
         lOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxJtcfmjg8bDlWo77QXfqDNdo8CBClhx9W/RQtlqbwY=;
        b=HkyZ2f7ggvKZMGrRYxzwZNRSPSQqnTvdXPH1MJHnAnRbXnjE1iaM/E3enC9OMOXEQK
         XSMDICqB82/b44XrojS8nsk0OzH+58zJzd3FZcK4FwQgbTfc2cf8w67YskY/v/vsjMId
         ncJXnYHwEmC35T+4ptOe0FrIDAThNhFzvo2pdPfu9rqq01iCdNX2Ffx2cnjluMwxLaBK
         8YAJ1893mqN0llOea+zhT2mrAjwtRpAHI4dcFg/RklFCq3zuPW+9s0pEthK2Yp1RcEMa
         BpK+/JW35c3WStoz1JUfMZJ8c1HC+wXwVE9ku3kS5HMa8yvVfQlrvHhZ4XO0n8eKEXqq
         qF1A==
X-Gm-Message-State: AFqh2kr86NC2zAFf+t3cGP4eDolrS+vvFvK8OEUy7KUt1atNhNYJIOKk
        lTAM80QkrFDa+OVXCfFshthfdQ==
X-Google-Smtp-Source: AMrXdXsEe/2+E0aFpK50BI2W31LvjkQnB05BvrClqgL71HBhXQ2hq9P1I+orXsNyKBoEZPHv4iTJdA==
X-Received: by 2002:a9d:704f:0:b0:685:579f:918e with SMTP id x15-20020a9d704f000000b00685579f918emr6930248otj.0.1674184742349;
        Thu, 19 Jan 2023 19:19:02 -0800 (PST)
Received: from ?IPV6:2607:fb90:f20b:1885:28a8:1eff:fe1b:3320? ([2607:fb90:f20b:1885:28a8:1eff:fe1b:3320])
        by smtp.gmail.com with ESMTPSA id m6-20020a9d73c6000000b006860be3a43fsm7631822otk.14.2023.01.19.19.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 19:19:01 -0800 (PST)
Message-ID: <0f51dac4-836b-0ff2-38c6-5521745c1c88@landley.net>
Date:   Thu, 19 Jan 2023 21:31:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Calculating array sizes in C - was: Re: Build
 regressions/improvements in v6.2-rc1
Content-Language: en-US
To:     "Michael.Karcher" <Michael.Karcher@fu-berlin.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        linux-xtensa@linux-xtensa.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
 <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
 <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
 <429140e0-72fe-c91c-53bc-124d33ab5ffa@physik.fu-berlin.de>
 <CAMuHMdWpHSsAB3WosyCVgS6+t4pU35Xfj3tjmdCDoyS2QkS7iw@mail.gmail.com>
 <0d238f02-4d78-6f14-1b1b-f53f0317a910@physik.fu-berlin.de>
 <1732342f-49fe-c20e-b877-bc0a340e1a50@fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <1732342f-49fe-c20e-b877-bc0a340e1a50@fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/19/23 16:11, Michael.Karcher wrote:
> Isn't this supposed to be caught by this check:
>>>>
>>>>          a, __same_type(a, NULL)
>>>>
>>>> ?
>>>
>>> Yeah, but gcc thinks it is smarter than us...
>>> Probably it drops the test, assuming UB cannot happen.
>> Hmm, sounds like a GGC bug to me then. Not sure how to fix this then.
> 
> 
> I don't see a clear bug at this point. We are talking about the C expression
> 
>    __same_type((void*)0, (void*)0)? 0 : sizeof((void*)0)/sizeof(*((void*0))

*(void*) is type "void" which does not have a size.

The problem is gcc "optimizing out" an earlier type check, the same way it
"optimizes out" checks for signed integer math overflowing, or "optimizes out" a
comparison to pointers from two different local variables from different
function calls trying to calculate the amount of stack used, or "optimizes out"
using char *x = (char *)1; as a flag value and then doing "if (!(x-1)) because
it can "never happen"...
> I suggest to file a bug against gcc complaining about a "spurious 
> warning", and using "-Werror -Wno-error-sizeof-pointer-div" until gcc is 
> adapted to not emit the warning about the pointer division if the result 
> is not used.

Remember when gcc got rewritten in c++ starting in 2007?

Historically the main marketing push of C++ was that it contains the whole of C
and therefore MUST be just as good a language, the same way a mud pie contains
an entire glass of water and therefore MUST be just as good a beverage. Anything
C can do that C++ _can't_ do is seen as an existential threat by C++ developers.
They've worked dilligently to "fix" C not being a giant pile of "undefined
behavior" the way C++ is for 15 years now.

I have... opinions on this.

> Regards,
>    Michael Karcher

Rob
