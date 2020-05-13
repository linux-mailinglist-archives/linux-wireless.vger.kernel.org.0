Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2A1D2105
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgEMV2c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 17:28:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgEMV2c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 17:28:32 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MMWgb-1jqEOX29sV-00JWx3; Wed, 13 May 2020 23:28:30 +0200
Received: by mail-qv1-f54.google.com with SMTP id 59so656025qva.13;
        Wed, 13 May 2020 14:28:30 -0700 (PDT)
X-Gm-Message-State: AOAM5321b145Phh9puDFsBznN+7pvPBxOMVh5XNoamWvqvWqunj0h+ko
        e5haRB20ai1ygPXcBA+1DbJZ1QBfZUR6CX1dhOw=
X-Google-Smtp-Source: ABdhPJw7Fuac+m5sULJtNIM3p5+cE34HdS8OeJClx/EYM0gmCRJdMFhQEEraDemX8yXHOSVi36C8UGZrQu6eSzpx+A0=
X-Received: by 2002:a05:6214:1392:: with SMTP id g18mr1590361qvz.210.1589405305824;
 Wed, 13 May 2020 14:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com> <20200513154847.GA158356@rani.riverdale.lan>
In-Reply-To: <20200513154847.GA158356@rani.riverdale.lan>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 May 2020 23:28:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
Message-ID: <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pkOP+/jQ/sNrzZEtohi05sbnFfLH2DPLUwNFPATJkbEXqE2G5l8
 F95mM/bwaHv2MdggK0o/efvEabe+h7yVeaOQGwgLxtzZxIDK1wICTDKFX2qIDmvCuBC2EbZ
 +/fucECA3N9MIs7uajeskFytmKi2yzWtnGbqO/ybhO3RdT9dF5eWOECmBUsYJTGE/7x5Wze
 G8uVPKOG7XA+wSbcT2LRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UpZ1x5f9cYE=:8WsnjyT0kgPzQ7tz/iEYWL
 tfETaL9rjy/vLoqEYHIUqfbFVorzRQ2f+smRnu1WBRXItleYfuXMxhrGNASgv+ZpeQwQgTu+e
 HE4s2x3OkanORZOLuapZoZavPUxCoxhhwJ02K55c56fw3qhZ9wLCu3hxv1KJ3iEyOk3sFvx/x
 mTvQSnQjmBw0xpwaELZ1vl8fiUyg4H/1CSxwF8Im1x050nFalU6j6dqFWp2wfy54Xdtom8CV5
 bA8mXHWNNk7wCYsXyNXy8kqf/c1FLGx3pPXgelpI7UmXIBARxw7CE15urxJ79ZI3mBSlbjidf
 F8iWTHMTCx6d2FJNql4SA2ofbbeczaHZ3bAEAmveHHoTHs8T7bAqkegML6YYcMdyRobtjdqBW
 WDi36Ch2/TFo/wudRJlPqZnVcVXTZn08IPZF6l9uDDQ4/k1G+Cy6WOkgHcGahHmgxoYN8hGOP
 TXhQ1HF5ivpBzAFRZLt+oiB3Bxs6WBerAiMPQDijKj9b/ld71kv+4O7F5cIKf1UYrDYxW9JLz
 xZFoqhlrXzOaoUDr5dM1MUm8aNfX5d10xX4rvFAxNeKoG7PKy2dkHoTOYM6ZuuQVth0k3eXKn
 +L+ADA98AukjCltKZdNo/khQPvVWdZcscSKaUsZBdsL3tIBtqyefTnH1m8kQHvZJIYVU/mON4
 KxkciFv30wxKXjO0xVRTHlAcLI5XKX42i9LkNr8jTq032iRYsOo8mtAlifFVgB+E5sNnqZfUK
 DlzaBwwgKsSlOxuGfkoxvvUipbUaOvdRGJHf9Jb3soC9MhM9cpenU7tu1jeAzMZVmj8v/Qf3M
 Vm2s2ZNBY2+f8XF/Rs5+zCjLSIW79nT1fOpkBpP7gdZnqC8igE=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 5:48 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, May 13, 2020 at 09:50:03AM +0300, Kalle Valo wrote:

> > And now I have a problem :) I first noticed that my x86 testbox is not
> > booting when I compile the kernel with GCC 10.1.0 from crosstool. I
> > didn't get any error messages so I just downgraded the compiler and the
> > kernel was booting fine again. Next I decided to try GCC 10.1 with my
> > x86 laptop and it also failed to boot, but this time I got kernel logs
> > and saw this:
> >
> > Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_secodary+0x178/0x180
> >
>
> See https://lore.kernel.org/lkml/20200423161126.GD26021@zn.tnic/

Thanks!

I see the patch in linux-next but not in mainline. I suppose we want it in v5.7
and backported to stable kernels so they can boot when built with gcc-10?

I suppose the only reason that the other architectures don't run into the
problem is that they don't call boot_init_stack_canary() in start_secondary()
though they probably should?

      Arnd
