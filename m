Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA51D258F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 05:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgENDuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgENDuR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 23:50:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAEAC061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 20:50:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l17so2036145wrr.4
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XMTc98UIvyXvpMeARxQhAw8UFvYP9zjRrMHTZktrDvE=;
        b=wgk2rSnuCu0b50yyTPjkGCFFlEiDvjPrYOiDulK1EirNq9VluSpFZUDuQeDaldkJJk
         HSUQagu4QMLAURFsWgchUoFXBpIuwem+UgnroBxJHloT4izDBfjUE4gf/gP2GdsPbxbY
         +pxAl1i2QF5M8EtwjBt59q0Fik7kx1jxkt/8sRTelmVY6CmtLpT5jfySJ9iJwyeB0iHh
         lqT1versBBzbyiGx0jRalDYFGHV419ly9WOSW/fEhEH+cLGdsQPrnk9gc/9jqb+DiI2u
         u3kr5+6JFji8rZPfnTnkQsPpVz+ueum+D5aIjP6/4YctO3iBn+DIeoY38AsrYo/AEG1+
         lEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XMTc98UIvyXvpMeARxQhAw8UFvYP9zjRrMHTZktrDvE=;
        b=dt42g9zjM0VDFKMdfeLlf6KSobBAnz3TBXnpdJP0fgFRINz/aGAiEov4tYp+HFAqH7
         LY8qBu4XhMIVvm+42rYn8uRztP5UC4MFqAvd3jsm4gh1F9CD554204L5dGhQ73OUmVjB
         weYAIyfJtRJ+rvR2BvA+i7eohw35llNMHDJPM9wDVbeWpRtUtAIp+gDtSPyH/L903cqP
         D1zETYvlMOhoArwKDf6JErSA8BzeV2rpBsddyWdPzUtjJg9+IEOR5M1sZr4k4Afy3WHG
         DltEkzkC8OgwzsNDqePGLolQ7D49ywavE3wBGRMJERV5nMZRL4TZnFAVa/Ww/RzEj3zH
         p2Nw==
X-Gm-Message-State: AOAM531vcBz8LR/b5Jsb0Q4EReERmc4txY5ta+NT/wX0c2kUZfBJT28E
        gcCnkChKg8rYbLfeahO+PpZbPIBaUZnd6W7YglaFJcSS
X-Google-Smtp-Source: ABdhPJxGuvDaiuvG6Ya4B15DrM/wXwUhKcfyYOzGzij3FdeitgnfmiRUayKqkaOmX8vReE8neotGEf7u+un7HzcBoCM=
X-Received: by 2002:adf:a389:: with SMTP id l9mr2958751wrb.18.1589428214741;
 Wed, 13 May 2020 20:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-2-arnd@arndb.de> <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan> <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic> <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com> <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
In-Reply-To: <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 13 May 2020 20:50:03 -0700
Message-ID: <CALCETrUYA60fWu+=MviKx0NmW+_ppsOcv-ShUXdbyM4EjyfzHQ@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On May 13, 2020, at 7:20 PM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>
> =EF=BB=BFOn Wed, May 13, 2020 at 5:51 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> Are you sure LTO treats empty asm statements differently than full
>> memory barriers in regards to preventing tail calls?
>
> It had better.
>
> At link-time, there is nothing left of an empty asm statement. So by
> the time the linker runs, it only sees
>
>    call xyz
>    ret
>
> in the object code. At that point, it's somewhat reasonable for any
> link-time optimizer (or an optimizing assembler, for that matter) to
> say "I'll just turn that sequence into a simple 'jmp xyz' instead".
>

What, what?

LTO isn=E2=80=99t a linker taking regular .o files full of regular machine
code and optimizing it. That=E2=80=99s nuts.  LTO takes an intermediate
representation and optimizes *that*. This will contain actual
indications that something is inline asm.  If LTO starts rewriting
inline asm, then I bet all kinds of things will go wrong and this is
the least of our worries.  Also, trying to do the kinds of stuff LTO
does by looking at just machine code isn't going to work.

So the difference between:

asm volatile ("nop");

and

asm volatile ("");

will be, literally, the absence of the nop.  (And alignment changes, etc.)
