Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B5481645
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Dec 2021 20:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhL2T0W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Dec 2021 14:26:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230305AbhL2T0W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Dec 2021 14:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640805981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7X92anWu7YA4HMgaOFRPoEtvjubDlUwqFYaCnsFgT4Q=;
        b=I5D7QiesfISaCKVfCO1RzK3X2j0llU4QPSbSFsUjy0vqqGfB8vpmMatznyznZyQDLjJuzj
        Fddw6W0zS4XPwJTqOLY9d+I17gx2aQe9GiMBLMJPQp4nSnt0GGi8sBYH/lqWB/sck8xu6B
        ch2cTzgkHcQMzaG+Gw1s2KmW5PD2kB4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-b9M_l2w1M6aQaXG1kj3QUg-1; Wed, 29 Dec 2021 14:26:11 -0500
X-MC-Unique: b9M_l2w1M6aQaXG1kj3QUg-1
Received: by mail-qt1-f200.google.com with SMTP id o12-20020a05622a008c00b002aff5552c89so16073334qtw.23
        for <linux-wireless@vger.kernel.org>; Wed, 29 Dec 2021 11:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7X92anWu7YA4HMgaOFRPoEtvjubDlUwqFYaCnsFgT4Q=;
        b=YRGYoBTcOZ6+iPaTGLhm3TnSqFlx+fZhbhrV6nLf0mhJyju9WSLQwIeQvgGnTHKHIE
         KDO5OupVleZUInlyZLvPGcdmTQ1rj1SdVB86rS1onT7y/iWLudlbfz9MZ2Gm/mjQjenf
         4AYq/bKObvepFGeasAE8zUhgYeBx84Oe3JOJuKRrGs8NPSTb2LbH4wedj2cvfaCAO9X5
         EYtqJYPUkvyVcdZoNDXYYWXHW5yhJHabT533Xi6h53FvG+UnWuLxYZYn4dygAw+zBPpt
         tQ6QNIeE0QCi0GNEqm0Qv7YMA6dErjXKWfr8+q+7fUkk7pEVm5BlCofsGu5VrpMi6JuM
         GhAQ==
X-Gm-Message-State: AOAM532nZU0eJoJ/rJl7jkHgBZuGGRDOYQIlRR5wAViY3cccTHHcl6Os
        J9xzb5EDxq9KrFhXTeTlT0yS40V4MZ2Dy3oqYq9v7wxfHpo+4TlzcOwJcW5VOMq4sBru7yXdz1C
        M2WFsmFHUTAYSu1r03Q9L3dE2VHA=
X-Received: by 2002:a05:622a:180c:: with SMTP id t12mr24151801qtc.507.1640805963405;
        Wed, 29 Dec 2021 11:26:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCMkCBBIEHoU7TQXcXidUDS5rm91MbIisjUvsPSiogTt212anKiDlDRNSIU+0yzvg7HIrUDQ==
X-Received: by 2002:a05:622a:180c:: with SMTP id t12mr24151786qtc.507.1640805963173;
        Wed, 29 Dec 2021 11:26:03 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p16sm15294493qtx.19.2021.12.29.11.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 11:26:02 -0800 (PST)
Subject: Re: [PATCH] mac80211: initialize variable have_higher_than_11mbit
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, linville@tuxdriver.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211223162848.3243702-1-trix@redhat.com>
 <CAKwvOd=dLjMAim_FRNyWegzEjy0_1vF2xVW1hNPQ55=32qO4Wg@mail.gmail.com>
 <b3ef8d23-7c77-7c83-0bc8-2054b7ac1d8b@redhat.com>
 <CAKwvOdkUQARWd7qG_hkUJYuVcvObMYTif_HDSEmJ5mSXP6y1=A@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3db47d49-68fb-c286-b237-bfce1cb0ff08@redhat.com>
Date:   Wed, 29 Dec 2021 11:26:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkUQARWd7qG_hkUJYuVcvObMYTif_HDSEmJ5mSXP6y1=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 12/28/21 10:55 AM, Nick Desaulniers wrote:
> On Fri, Dec 24, 2021 at 6:01 AM Tom Rix <trix@redhat.com> wrote:
>>
>> On 12/23/21 12:30 PM, Nick Desaulniers wrote:
>>> On Thu, Dec 23, 2021 at 8:29 AM <trix@redhat.com> wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> Clang static analysis reports this warnings
>>>>
>>>> mlme.c:5332:7: warning: Branch condition evaluates to a
>>>>     garbage value
>>>>       have_higher_than_11mbit)
>>>>       ^~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> have_higher_than_11mbit is only set to true some of the time in
>>>> ieee80211_get_rates() but is checked all of the time.  So
>>>> have_higher_than_11mbit needs to be initialized to false.
>>> LGTM. There's only one caller of ieee80211_get_rates() today; if there
>>> were others, they could make a similar mistake in the future. An
>>> alternate approach: ieee80211_get_rates() could unconditionally write
>>> false before the loop that could later write true. Then call sites
>>> don't need to worry about this conditional assignment. Perhaps that
>>> would be preferable? If not:
>> The have_higher_than_11mbit variable had previously be initialized to false.
>>
>> The commit 5d6a1b069b7f moved the variable without initializing.
> I'm not disagreeing with that.
>
> My point is that these sometimes uninitialized warnings you're
> finding+fixing with clang static analyzer are demonstrating a
> recurring pattern with code.
>
> When _not_ using the static analyzer, -Wuninitialized and
> -Wsometimes-uninitialized work in Clang by building a control flow
> graph, but they only analyze a function locally.
>
> For example, consider the following code:
> ```
> _Bool is_thursday(void);
> void hello(int);
>
> void init (int* x) {
>    if (is_thursday())
>      *x = 1;
> }
>
> void foo (void) {
>    int x;
>    init(&x);
>    hello(x);
> }
> ```
> (Clang+GCC today will warn on the above; x is considered to "escape"
> the scope of foo as init could write the address of x to a global.
> Instead clang's static analyzer will take the additional time to
> analyze the callee.  But here's a spooky question: what happens when
> init is in another translation unit? IIRC, the static analyzer doesn't
> do cross TU analysis; I could be wrong though, I haven't run it in a
> while.)
>
> My point is that you're sending patches initializing x, when I think
> it might be nicer to instead have functions like init always write a
> value (unconditionally, rather than conditionally).  That way other
> callers of init don't have to worry about sometimes initialized
> variables.

The variable is passed to only to the static function ieee80211_get_rates().

Tom

>
>> Tom
>>
>>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>>
>>>> Fixes: 5d6a1b069b7f ("mac80211: set basic rates earlier")
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>    net/mac80211/mlme.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
>>>> index 51f55c4ee3c6e..766cbbc9c3a72 100644
>>>> --- a/net/mac80211/mlme.c
>>>> +++ b/net/mac80211/mlme.c
>>>> @@ -5279,7 +5279,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
>>>>            */
>>>>           if (new_sta) {
>>>>                   u32 rates = 0, basic_rates = 0;
>>>> -               bool have_higher_than_11mbit;
>>>> +               bool have_higher_than_11mbit = false;
>>>>                   int min_rate = INT_MAX, min_rate_index = -1;
>>>>                   const struct cfg80211_bss_ies *ies;
>>>>                   int shift = ieee80211_vif_get_shift(&sdata->vif);
>>>> --
>>>> 2.26.3
>>>>
>

