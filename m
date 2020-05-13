Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204821D0B3B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgEMItv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 04:49:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgEMItu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 04:49:50 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mf3yk-1isIb847q6-00gapj; Wed, 13 May 2020 10:49:49 +0200
Received: by mail-qt1-f176.google.com with SMTP id v4so12611970qte.3;
        Wed, 13 May 2020 01:49:48 -0700 (PDT)
X-Gm-Message-State: AGi0PuZZjMlN5xkIYcIaxdIlLzEhcSdL9WjPMH+i+gyzPVDjn3TYJTq/
        tdDEk68tTH7Yi+V207U5LNoxtkIif6BvQmmdSlQ=
X-Google-Smtp-Source: APiQypK6RUzPiElv+0LgA+6SydZJEi9vK6ik3U1AQWnKjKYzEXjlb1LdHL6niV9xcSMp8+HKBSU6JwsHgY+K4sDw6LY=
X-Received: by 2002:aed:2441:: with SMTP id s1mr19473552qtc.304.1589359787721;
 Wed, 13 May 2020 01:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
In-Reply-To: <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 May 2020 10:49:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1dxJAHCZ19=sPUkDi5wLWeJ6KKtD09Wmjqkz27TQN6Xw@mail.gmail.com>
Message-ID: <CAK8P3a1dxJAHCZ19=sPUkDi5wLWeJ6KKtD09Wmjqkz27TQN6Xw@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JJN1tmrdOdKjQ3HrZDQA1NwEQzGoEDIMifl3gugwcCK/5A9NvPU
 Z6afJTIDF7hHiBwR5E/92B1Zq+p4oA9EDm0fajQhaP8vz2CpV/oCrYnv77QYN08zMCHHPrd
 4C5Y7mf0FtszIIHTcEy5zH85sM79TrZBgdOfaFppJdcyNErZg/XPqipmlhmTHa+aRx8JTeu
 dbYLmXNpeJa3FbYk5bxDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xB2cQ7s5EkM=:CSwT9l9HTeEag2TifN23jU
 a9Mk3QM9Y95IwL2nffX7VzcejIdnze2zGM2cz6L19jVufModHEAhQdlKp+bHI7IXpwdwflDon
 rEKabKvAVW0rnoftejcRQ0OqEVvEfLXFZVeUzuaLtYvkKEKJpmIkha+Tq9WaWoJ650dbDa5jK
 XZbjThAe5TKm/WrW6aIyMSE76j/VeaQxhZPJL7OBsD2PRU+cZRoxmYm1MlG3fjILHFqXzU1HS
 UFR4mKurcI34ADv/ZMrJznEqazP5oSaE+Y8mornSZFjcf3h+atun30JrkAvgxrrcUUCAddyTh
 MeMWm/hcwUX3JCYEyXWPzb7XBuY9U4PTy/XFcWNfNryehRbzRgbsJOqQQ+viZI58k2fubMMn3
 DZNYlLr6YYR92zS7ZdS3vtcQc9WvuFqHN4x2ikXLhFsXOAJi8Hnh1C4iZEJAxE8ltcesGkJ22
 MaYQjAIg51pkG9OHcubMFfKB3+pbhwEpnJUgyKuXEli+NgAGHs4KhPYbFW2Lvcl2QgKtEI/Dc
 zNGK/j+8mdJrZTx15REgBWoMdSzzb1CvInpNktYq6Q1kqg7lp5CmcvmOG2OSZy+6rfXHyX07z
 lW7rTYzK8JJcgAYg18hBwDVwonpAUeijHFTdkuGwdMuLorv+hok2kthcqIwcKeQq4fPHlY4M/
 1nw9+c2XuUCdZukHdESBGqOEJCQ+ca0S/wLs6bxX4y4yd18fRspNUJNLyY+NVRlTV4JDByzo+
 rwhMXhY6UWkTtTPGbUxEVnhIj3xa7gfxXaoAtsaW6BxCivmUSUvO5MQAoAf2pNyppOpiUnY+K
 4E2LLAt9wbfjjtPbHh5JnOf6YXg5tsDJuOatOx3jgjcplzON4k=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 8:50 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Kalle Valo <kvalo@codeaurora.org> writes:
>
> > This motivated me to switch to using GCC 10.x and I noticed that you had
> > already upgraded crosstool so it was a trivial thing to do, awesome :)
> >
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/
>
> And now I have a problem :) I first noticed that my x86 testbox is not
> booting when I compile the kernel with GCC 10.1.0 from crosstool. I
> didn't get any error messages so I just downgraded the compiler and the
> kernel was booting fine again. Next I decided to try GCC 10.1 with my
> x86 laptop and it also failed to boot, but this time I got kernel logs
> and saw this:
>
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: start_secodary+0x178/0x180
>
> Call Trace:
> dump_stack
> panic
> ? _raw_spin_unlock_irqrestore
> ? start_secondary
> __stack_chk_fail
> start_secondary
> secondary_startup
>
> (I wrote the above messages manually from a picture so expect typos)
>
> Then also on my x86 laptop I downgraded the compiler to GCC 8.1.0 (from
> crosstool), rebuilt the exactly same kernel version and the kernel
> booted without issues.
>
> I'm using 5.7.0-rc4-wt-ath+ which is basically v5.7-rc4 plus latest
> wireless patches, and I doubt the wireless patches are making any
> difference this early in the boot. All compilers I use are prebuilt
> binaries from kernel.org crosstool repo[1] with addition of ccache
> v3.4.1 to speed up my builds.
>
> Any ideas? How should I debug this further?

At least if it fails reproducibly, it's probably not too hard to drill
down further. Some ideas:

* I'd first try to reproduce it in qemu. Since you don't even need
  any user space or modules, I would simply try
  $ qemu-system-x86_64 -nographic -monitor none -append
"console=ttyS0" -serial stdio -smp 4 -kernel arch/x86/boot/bzImage
  I tried it here with an x86 defconfig linux-next kernel but did not
  run into the problem you described. If you share your .config,
  I can try reproducing with that as well. Once there is a reproducer
  in qemu, it should be trivial to step through it using gdb.

* There are still two prerelease compiler versions on kernel.org,
  from February and from April. You can try each one to see
  if this was a recent regression. It's also possible that there is
  a problem with my specific builds of gcc-10.1, and that the
  compiler is actually fine for others.The gcc-10 packages in
  Fedora/Debian/Ubuntu are probably better tested.

       Arnd
