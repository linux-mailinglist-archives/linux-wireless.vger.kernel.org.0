Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560B61D164A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbgEMNqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 09:46:08 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 09:46:07 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N8GAQ-1j3oIm3jYO-014G5Z; Wed, 13 May 2020 15:46:05 +0200
Received: by mail-qk1-f169.google.com with SMTP id n14so17317952qke.8;
        Wed, 13 May 2020 06:46:04 -0700 (PDT)
X-Gm-Message-State: AOAM533fbFwAByBdxRZg1ARKoTtC1LGXbI1RZxIN0G7sHIlODdGSp1zh
        6r28vLK9pS2e/OVxGyJ7XBcLDEkvN8KHBJpb5ho=
X-Google-Smtp-Source: ABdhPJwV91IBwNmPmRLkNeboSCJNcz5s3Tolvz8yI1eZ8eZHOlcvYhMDbjAr0vZgYFAb2+QyjdxYgnJOjnB1B+c/FrI=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr5986610qkl.286.1589377563683;
 Wed, 13 May 2020 06:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com> <CAK8P3a1dxJAHCZ19=sPUkDi5wLWeJ6KKtD09Wmjqkz27TQN6Xw@mail.gmail.com>
 <87zhacrokl.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87zhacrokl.fsf@kamboji.qca.qualcomm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 May 2020 15:45:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mMcpVE5kLv-krjL_ZjqfRXDK4e3fChzuom_QFRtTJqw@mail.gmail.com>
Message-ID: <CAK8P3a1mMcpVE5kLv-krjL_ZjqfRXDK4e3fChzuom_QFRtTJqw@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UYMLIYN4+W8N6GV2myvxxS9Hoo2q8yX4hZE0qyPjTt6vqPRnIxi
 NTPYD3iWXf1i3f3bd5KRqXyrjaf0CZhcfiV3n3x9jIekCuDZA/CRP0Eic691sOqCJcLSrJK
 5Cy9p0LigfsSbvWA+wH0AkZx7zf/qB2fEbNF9+cxuYMLKCt1TcOW5dWx8+UICFB487jMMWP
 eOnTjp+9gG9t+zVWW84Wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A1ICg6Vm0cI=:mweJpMklc8rssnZU08dXcA
 fG6WjqYJuPdd5pXEOEXUPPQlqEpUhiICtGlPR4Xl2Tk7IESMzDFEgBZt+c4+BNE1sB0Zqz4O6
 tV5CBXPApmD/q6M+Kb+kVa+brfN/oPdHTUhkdyGA+v0BnsiY84O27K903d+5mH+YCJkbK8kVr
 DgEzAw4+24J2ruYwep2Fj7Hr10JLSNkxAUP24Mx6CxcuJPrsqJJiJoUYNSJ3RE7YtamwNeLFp
 o9kOBL4NQ7f0/y3zIxKmM9+5MVhtu3f3x3eIZcSJxQpKi2fBzgD/odwuC6zNIoOvyCqxCs8Fp
 wvtiP48X6gcsBGQ6JgBTPMcGCSEy8ibU6Q9A6+Em0SZJLvs3OKQmNe66qCaXHgQojS+AvbRB9
 KixMoTkjUCYjBQoj+1MtLon/UJPB0u7qFhyh0tVNMcW94ixBLWoUpdwB18Q0T558lXnFkk2hj
 HMdV6GFwMC99bhvG4YldLYnoMQLQ9CV/MWyqn3WT5riHCF4tuiamV6sGP8lrRCWwe86JBZp0R
 RJ8yR681AjpR3Rjol1G4BpTC+g1SJWCxi1uXb9ow22JgwpwWVP1Hkjnj2znqSQJYcZDIit1S8
 vn9bnjprtXmkhvIT1O1UXEpcy7C9CBGKssoPTRnevg5pjMCroqI7TPXL82Nq+J92y6XctiHn8
 o3MZInvAF5Z0F8mDbK9qbKPjaiflJ4XICu/uqsBXQdsG238+HiStBjrgBm4nrrj+Th5S35Cwb
 7MErjs/TvHy0z6Tl9WGh24oomfy7zeWXekN8m5PwOsPpS5XDdttKiUh2svH5ZbDyrBgek34bh
 9wAQKM4dsIY3C9uVvzhJ5sOhS/Zw8mrvG3HOB+lpCPrXeBYuoo=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 2:57 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Arnd Bergmann <arnd@arndb.de> writes:
>
> > On Wed, May 13, 2020 at 8:50 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >>
> >> Kalle Valo <kvalo@codeaurora.org> writes:
> >
> > At least if it fails reproducibly, it's probably not too hard to drill
> > down further. Some ideas:
> >
> > * I'd first try to reproduce it in qemu. Since you don't even need
> >   any user space or modules, I would simply try
> >   $ qemu-system-x86_64 -nographic -monitor none -append
> > "console=ttyS0" -serial stdio -smp 4 -kernel arch/x86/boot/bzImage
> >   I tried it here with an x86 defconfig linux-next kernel but did not
> >   run into the problem you described.
>
> Thanks, I'll try that but I expect it will take few days before I can do
> it.
>
> > If you share your .config, I can try reproducing with that as well.
> > Once there is a reproducer in qemu, it should be trivial to step
> > through it using gdb.
>
> I have attached the .config I used with GCC 10.1. If you are able to
> test it please do let me know how it went.

Yes, I see the same problem now, but have not investigated
any further.

> > * There are still two prerelease compiler versions on kernel.org,
> >   from February and from April. You can try each one to see
> >   if this was a recent regression. It's also possible that there is
> >   a problem with my specific builds of gcc-10.1, and that the
> >   compiler is actually fine for others.The gcc-10 packages in
> >   Fedora/Debian/Ubuntu are probably better tested.
>
> I'm still using Ubuntu 16.04 so not sure how easy it is to find a
> package for that, but maybe this is a good reason to finally my upgrade
> my laptop :)

I checked with the gcc-10 package from Ubuntu 20.04, same
result as with my version, at least that indicates it's not my fault ;-)

      Arnd
