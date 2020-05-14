Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A76A1D241A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 02:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgENAvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 20:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730617AbgENAvM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 20:51:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED42C061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 17:51:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g11so511131plp.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbWGZjtybDfcEI3YIw2tpOyVCftS9qbkOqtHtAr39Dw=;
        b=osLbuie/2ncAMEeXy93/D+AgzeoiKpAc38GwDoktN1YDNYry3qpjzCvcGIXEyxDd4I
         zoMIYuuAXowXZNIrhAKRbI7IYWJBvByyxeOh0PwWtnN+0FTyndVCAcyp+SZ+84HhAwpu
         5biP7eOGGtXb6DlTkqv5SJXlPCzC2I3Wny8HMqjD274TQgaL2NJF+EWyGVz6xr28ZN1j
         mXhq5vGsIRbiK6Gvfe944+PiHDoXLQbKv1rk4EYkCdm9pyONyoA4LyG+BBk40lQWzVTi
         4aJONNZFjJkFmZ8DDGH/U4fyssQqINUIZXs3MXspQxAI1mvc+Frmp1AKj2iH9pOf4BKc
         tGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbWGZjtybDfcEI3YIw2tpOyVCftS9qbkOqtHtAr39Dw=;
        b=mNzs/UBjvsNomSDF5J9Old8mRgna+YXwxukJrXmVoOHMdaGe8LPJMePkrT/5HkOh4a
         zbq9muUC8kaklS8wfI9w/NKlkrgwcrUdDQqcFIASlSEDUlzD+sGs0+mfOW7uCdiMcqoW
         zDDQZG0a1g5FR5muMx3gP6FWPW6+pqETM15LjYST6pJ9egZJOXVHcyvZ6YYLuFQm0Vya
         H2TJwypgwol8B6Ps3i0H/kjKkVsGlaGBgNAhmOAHGkbD2thM1QCslE4aaoZGs7YwHBz6
         1NxGQU6AdEX+W8eaCPs7fTTVMPhaKL9W1TgAlnAv1n8npidSBL/V3PaU9e5hAkpppEQt
         B4Ew==
X-Gm-Message-State: AOAM530ZKQy9Ak8eY7c66NvuxsalvHAwW6XB8JljZN4TZjzFbkldRthT
        NZ2aw7boPhJadLH3pKwnhPr1kPIuOuts0dLkGCH97A==
X-Google-Smtp-Source: ABdhPJxjlEbKRxEvhhabZXB1Qqxy18qboWidG9h/nWiHChhpsrWu+W/q6pNtkqJMweyMUa5XhkhHgz0efk86iWYITao=
X-Received: by 2002:a17:902:a401:: with SMTP id p1mr1684088plq.223.1589417471261;
 Wed, 13 May 2020 17:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-2-arnd@arndb.de> <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan> <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic> <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
In-Reply-To: <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 May 2020 17:51:00 -0700
Message-ID: <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

On Wed, May 13, 2020 at 5:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 13, 2020 at 4:36 PM Borislav Petkov <bp@suse.de> wrote:
> >
> >
> > Looking at them, they do have an mb() too so how about this then
> > instead?
> >
> > #define prevent_tail_call_optimization()        mb()
>
> Yeah, I think a full mb() is likely safe, because that's pretty much
> always going to be a real instruction with real semantics, and no
> amount of link-time optimizations can move it around a call
> instruction.

Are you sure LTO treats empty asm statements differently than full
memory barriers in regards to preventing tail calls?  (I'll take your
word for it, I don't actually know, but seeing an example of real code
run through a production compiler is much much more convincing).

The TL;DR of the very long thread is that
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722 is a proper fix, on
the GCC side.  Adding arbitrary empty asm statements to work around
it? Hacks.  Full memory barriers? Hacks.

I'm happy that GCC does an optimization that Clang does not.  At the
same time, it sucks to pay a penalty for a bug we don't trigger.  This
is the same reason why `asm_volatile_goto` expands differently between
GCC and Clang (and why I tried to undo that like a year ago).

If Clang realizes the same optimization GCC is doing here (related to
tailcalls) tomorrow, well we already support
__attribute__((no_stack_protector)) which can be added to the callees
we don't want tail called in this case (i.e. allowing tail calls).  I
should send a patch adding that to include/linux/compiler_attributes.h
and annotate the callees in question, before we forget about this
issue.

Sprinkling empty asm statements or full memory barriers should be
treated with the same hesitancy as adding sleep()s to "work around"
concurrency bugs.  Red flag.

And LTO is fun; we've been shipping it in Android for years (and need
to attempt upstreaming again).  Just today we found an ODR violation
in one of the most important symbols in the kernel.  Will be sending a
patch for that tomorrow.

>
> I could imagine some completely UP in-order CPU that doesn't need to
> serialize with anything at all, and even "mb()" might be empty.  I
> think you can compile old ARM kernels for that. But realistically I
> think we can ignore them at least for now - I'm not sure the link-time
> optimization will even do things like that tailcall conversion, and
> I'm not convinced that old pre-ARMv7 systems will be relevant by the
> time (if) it ever does.
>
>                    Linus



-- 
Thanks,
~Nick Desaulniers
