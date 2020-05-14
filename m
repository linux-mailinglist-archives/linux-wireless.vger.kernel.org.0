Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97D1D2512
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 04:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgENCUr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 22:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgENCUr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 22:20:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB262C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 19:20:46 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d22so1215683lfm.11
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 19:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXuxlzFJjuFeHFav27DAp6FNwTqeUpdj2tTsQo9HuW8=;
        b=ZSE5hbVUdQ7MD8y3xvZyt4Qu3KCoqfI2XJEbqNq9/B+lhnWaFoqTbu9GjEAVsSFsbo
         Ye5Rf0gAeMBDnTqJxK9+m7qAwZCe+hxIwZuqKhe8BDHFpBYQrTk4LRdA9e0BOrjGVfOD
         Fv6NArbqGNATusnL9yWOhJpATVAm/f//N8+wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXuxlzFJjuFeHFav27DAp6FNwTqeUpdj2tTsQo9HuW8=;
        b=H2IGm8oKe4VAE6yNyoAsULkUnlKJnnu84ZBXcVEdZsqEwqpdMg6xu25CsJE9E/lzST
         Ih1z1yNQJ54sWzxBl4joJ4secolG4y8UlwtSZm7SEPs7SdxEwhr7AxCvuBGbL5+TtBnT
         vn9Fp+TrlKPSY05otxq9RPfIwSo1k7AhZJPbzsFpJlmWY+4pcqEvJV+Opkppt4AyNSeN
         oPsPWNyveEXqVHOsYLbkpifKFNs5kKTe/aWKJU/xR8pwu041DYoonm+rVwn8jiqkMDaq
         a48PVYR36525SF9lRnRC4t/XzQx9bL9Bunceap1AOMprDJl4rP29LqfXNfPMrjKFcSTj
         hBKQ==
X-Gm-Message-State: AOAM531tXRA5CSoSB+O74mw8oRgXeSsAyWQcFSodIRt4o1MFpLO/hPva
        Kh+lDhJL3F9PbjQEzCWMI9LaOiSTXQ8=
X-Google-Smtp-Source: ABdhPJzc9WgTqNbhV5OgOqhd+Xk2/3gOty4dFLU8mTIS/KmI5GEDyEhbHW/NbsPCI1auiH8/PxMeug==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr1548969lfl.55.1589422844679;
        Wed, 13 May 2020 19:20:44 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d19sm776387lfj.8.2020.05.13.19.20.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 19:20:43 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u6so1760960ljl.6
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 19:20:42 -0700 (PDT)
X-Received: by 2002:a2e:9641:: with SMTP id z1mr1176154ljh.201.1589422842224;
 Wed, 13 May 2020 19:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-2-arnd@arndb.de> <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan> <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic> <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
In-Reply-To: <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 19:20:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
Message-ID: <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 5:51 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Are you sure LTO treats empty asm statements differently than full
> memory barriers in regards to preventing tail calls?

It had better.

At link-time, there is nothing left of an empty asm statement. So by
the time the linker runs, it only sees

    call xyz
    ret

in the object code. At that point, it's somewhat reasonable for any
link-time optimizer (or an optimizing assembler, for that matter) to
say "I'll just turn that sequence into a simple 'jmp xyz' instead".

Now, don't get me wrong - I'm not convinced any existing LTO does
that. But I'd also not be shocked by something like that.

In contrast, if it's a real mb(), the linker won't see just a
'call+ret" sequence. It will see something like

    call xyz
    mfence
    ret

(ok, the mfence may actually be something else, and we'll have a label
on it and an alternatives table pointing to it, but the point is,
unlike an empty asm, there's something _there_).

Now, if the linker turns that 'call' into a 'jmp', the linker is just
plain buggy.

See the difference?

> The TL;DR of the very long thread is that
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722 is a proper fix, on
> the GCC side.  Adding arbitrary empty asm statements to work around
> it? Hacks.  Full memory barriers? Hacks.

BS.

A compiler person might call it a "hack". But said compiler person
will be _wrong_.

An intelligent developer knows that it will take years for compilers
to give us all the infrastructure we need, and even then the compiler
won't actually give us everything - and people will be using the old
compilers for years anyway.

That's why inline asm's exist. They are the escape from the excessive
confines of "let's wait for the compiler person to solve this for us"
- which they'll never do completely anyway.

It's a bit like unsafe C type casts and allowing people to write
"non-portable code". Some compiler people will say that it's bad, and
unsafe. Sure, it can be unsafe, but the point is that it allows you to
do things that aren't necessarily _possible_ to do in an overly
restrictive language.

Sometimes you need to break the rules.

There's a reason everybody writes library routines in "unsafe"
languages like C. Because you need those kinds of escapes in order to
actually do something like a memory allocator etc.

And that's also why we have inline asm - because the compiler will
never know everything or be able to generate code for everything
people wants to do.

And anybody that _thinks_ that the compiler will always know better
and should be in complete control shouldn't be working on compilers.
They should probably be repeating kindergarten, sitting in a corner
eating paste with their friends.

So no. Using inline asms to work around the compiler not understanding
what is going on isn't a "hack". It's the _point_ of inline asm.

Is it perfect? No. But it's not like there are many alternatives.

                      Linus
