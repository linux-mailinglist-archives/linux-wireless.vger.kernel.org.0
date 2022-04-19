Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA74D5078A4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356916AbiDSSVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356769AbiDSSVl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 14:21:41 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B997B40A0A
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 11:14:03 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t15so11346479oie.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLgvkVFktspG4POWXbLWJoZn8wGWL29OC2iWyu0Y1rQ=;
        b=Ky0BBBe3gs8XkiIKG/GvoOu/FqWIUpBJdR49KyL/5REDKGHbqcN4SlVlI6ZznICqMl
         Ls8d/PWocl/sU7/ihkB4YyTvqd8OMO+tU50FQwLtfymMvEMu28q8oW3ndyXdzZVBv5aq
         tXS7wjk5OAdp414BMer4HkO+K8UgawjUswzmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLgvkVFktspG4POWXbLWJoZn8wGWL29OC2iWyu0Y1rQ=;
        b=fCmeAQgn62xncGX0OfI0Y/OONIK2ezJ7Q/11u8fyQJD6Jm0Mx/j2kafCOR73QbsesJ
         EkZF9021CzL9rGs8PAsWN5Gn2H5t5NawdS+TckD6ZHNh4m/uvUN7mQpli6iRkhn3Igtg
         q48a0CkFmyUhCbKme+7cpG56UM2xSejQXXAMXxob9TViX8seSpHb+km49uRzqXhFM1T4
         CmyRoIhMyyeBZ4OJ7z6pGuRh2UlAUVsUIWktfLOE6omc1CTXM8XgNzcJOoq9qNzRdgLt
         lHvyee62G4zc4XgErG+wxDCR/93cFa9u9SWtIoD8CoBwjsJ+cg1whjSW9Qq82sz++egD
         7R2A==
X-Gm-Message-State: AOAM532pIejGZ4nWS7IJDgnNul97PK/sviSsVa1b/Cxhk5igs3R58Jgp
        2y1xffb05AtPjjnY7uhXdoIwLlSiWUCz6w==
X-Google-Smtp-Source: ABdhPJz+6SP0WK9yovvVJbjiUFeNywK9eC1M+SQ1PNShyDXJCfTLbsuiEN3bm5z/Fl2C2zZ0i+aKFg==
X-Received: by 2002:a05:6808:114e:b0:2ec:eb48:23d3 with SMTP id u14-20020a056808114e00b002eceb4823d3mr10035794oiu.262.1650392042581;
        Tue, 19 Apr 2022 11:14:02 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id s65-20020acac244000000b002ef4ee8c800sm5323396oif.13.2022.04.19.11.14.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 11:14:01 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id a10so1551550oif.9
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 11:14:01 -0700 (PDT)
X-Received: by 2002:a05:6808:1143:b0:2fa:624e:a213 with SMTP id
 u3-20020a056808114300b002fa624ea213mr10206686oiu.257.1650392041373; Tue, 19
 Apr 2022 11:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAA=hcWQFNOeycXFPhrtHcQG3V8fWSShNRuAi49jtv8h1fPVUuQ@mail.gmail.com>
 <8ef5d73a-6293-a6c5-6bbb-b130266a8f0b@broadcom.com> <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
 <CA+ASDXPXCLjSL+mKKn-vh0fx0jdGBN-HOSDh4Dvy+93HSdRfBg@mail.gmail.com> <CAA=hcWS7w+EGZUnTJhLFEoOa78abBXLbGRHDz+BFYvR0n9c+sA@mail.gmail.com>
In-Reply-To: <CAA=hcWS7w+EGZUnTJhLFEoOa78abBXLbGRHDz+BFYvR0n9c+sA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 19 Apr 2022 11:13:50 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMXoubRcc-R7NBfJ25x07+3um3TNcGg6VCzxYgC=zHCkA@mail.gmail.com>
Message-ID: <CA+ASDXMXoubRcc-R7NBfJ25x07+3um3TNcGg6VCzxYgC=zHCkA@mail.gmail.com>
Subject: Re: Support for bcm43364 wireless chipset in brcm80211/brcmfmac
To:     Jupiter <jupiter.hce@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sean Lanigan <sean@lano.id.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jupiter,

On Thu, Apr 7, 2022 at 12:08 AM Jupiter <jupiter.hce@gmail.com> wrote:
> Another issue, it is not just kernel 5.10 mwifiex driver has been
> changed, the version of sd8801_uapsta.bin was also updated to
> W14.68.36.p204 [...]

I wouldn't be surprised if Marvell/NXP provided "updated" firmware (to
fix some CVE) but didn't actually test it with mainline Linux, or at
least not very well. If you're interested in bisecting, I'd stick to
the old firmware if I were you. But it sounds like maybe you aren't
well-equipped to do useful bisecting, so maybe that won't go anywhere.

> We did spend a large amount of resources and time debugging and we
> raised mwifiex issues many times to this list, unfortunately we did
> not get any response until now. If anyone is interested in debugging
> it, I'll devote myself to working it out, we are in downunder in
> different time zones.

I see several conversations where you did eventually get *some* responses:

Re: mwifiex reset buggy
https://lore.kernel.org/linux-wireless/20200206131455.knx2nsitunrfo4nu@beryllium.lan/

Re: Failed to can wifi Invalid Sched_scan parameters
https://lore.kernel.org/linux-wireless/CAD=FV=XMR33LONcyuvfLzJNd7vKB7vmiE1VSC_QArXA+Hy4Nsw@mail.gmail.com/

It seems like in those cases, people (rightfully, for this forum)
expected you to be able to do a bit more heavy lifting on
understanding what precisely is going on (e.g., what kind of
supplicant configuration is involved? did this particular environment
(AP, etc.) work previously?).

Unfortunately, it's not easy to remotely debug for you, and in some
cases, we really can't answer your questions for you. For instance,
some questions probably can't be answered without either:
(a) bisection or
(b) source code or documentation for firmware (most of us don't have this).

If you're looking for a higher level support than the limited free
support you get from random people on linux-wireless, then mwifiex
might not be right for you, and you should indeed look for different
hardware.

All I was saying is that if it previously worked well (with a given
firmware, mainline kernel, hardware, and RF environment), then it
should be _possible_ to get it working again. I didn't say it would be
easy.

Regards,
Brian
