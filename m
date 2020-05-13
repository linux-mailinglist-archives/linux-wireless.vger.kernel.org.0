Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B991D1A1C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgEMQAs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 12:00:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbgEMQAr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 12:00:47 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mz9lL-1jDuow2pff-00wETk; Wed, 13 May 2020 18:00:45 +0200
Received: by mail-qk1-f177.google.com with SMTP id y22so5235973qki.3;
        Wed, 13 May 2020 09:00:45 -0700 (PDT)
X-Gm-Message-State: AOAM530TWWgtQd3MWuR/mWzg/tWNLb2ym9vJ15jV23+wkGRtcbLyKf+P
        BIjZwKh9b/Q9L4lhQ6Er8xmM8gyU06CCoDkqI0Q=
X-Google-Smtp-Source: ABdhPJyKpZv03jMaYhNeTLejY16uvPcQQJcVwZSNjzCLBox/lZ1uZ2BacyGU3669//YQxo34VT7WHEyTtCXmXt0P9SQ=
X-Received: by 2002:a37:aa82:: with SMTP id t124mr336651qke.3.1589385644498;
 Wed, 13 May 2020 09:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com> <CAK8P3a1dxJAHCZ19=sPUkDi5wLWeJ6KKtD09Wmjqkz27TQN6Xw@mail.gmail.com>
 <87zhacrokl.fsf@kamboji.qca.qualcomm.com> <CAK8P3a1mMcpVE5kLv-krjL_ZjqfRXDK4e3fChzuom_QFRtTJqw@mail.gmail.com>
 <87v9kzsvg8.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87v9kzsvg8.fsf@kamboji.qca.qualcomm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 May 2020 18:00:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2eKoOL0KF4CmyEtk-3309f2_D+daQbe=Bj5vCkvD_khA@mail.gmail.com>
Message-ID: <CAK8P3a2eKoOL0KF4CmyEtk-3309f2_D+daQbe=Bj5vCkvD_khA@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+VE9yS/pAW+yc+VzMjlxwbU4QPNhvwBr7uzsjKiP4jHozKXQQ8e
 vosSuGKW2rXE97XSAORxJoimUmj9iqGNWFhUqeKb5H4cBs9A7yx+giq4ln1Vc7YAYnewQFh
 DwCFBMomOPZcDFamRC6mL8Vm+aBmya3+6MtcnFCWnmfinWN2sqcog7rK8vXAZ2MRrh/D8jn
 bTQ6B8cQ5/S4lf0aCeviQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMJX7kXZ+GU=:bgMye9IGk2BuNpgPRc9KfH
 K0FITDaUwXfW2GvURva76cgqIUvnc6VC5YzT3cotryl4iPUzS4HVmv24caKQUHolDTmwsnwdu
 tAieTtIRV31nwvcABvUZHogcASu2yif6m8sUB3h2LsIf0uvnHrYe2aYyt959UpnsfdqsxNbBf
 4lBPed+CjqjhWHisgPZC2EkRDDNRkDXA4znqUtd6rBmXFJj7TLuwp1/M6VwNkqsx6knOmSwwu
 Bq0VvctT7Uom/ZLls76W+ATCYvV3AYgzRc7bec2M+MILFRUi1Tm8JbVd/QvRNzgLSfctXmIIL
 zWzYtI43BclOSR1coIuKkJKGKuGfgCXIZza3tr1UEjkY6j1Jc06Y8c3UbggPkcHQxQXa8Xy/L
 wI0Cl4cRRVnsX9AhHjaC8n3m7lS6I4gj/+o8KCUURJ/Mgs/4ViQyV9jYjLLWynJlm1DsLFzjI
 QE+lg/2zUMAeutoYARP8/G4PAeRCKFLCDTEaexWiYO7arQJXcLa0y3n0uut7+iWsu6CzwkFiQ
 HyWBBgrRt5kPWApA69oq93L4pm8s4JexyaC8CMhEDD4F4JjAExncau5N6cXue7i1GDVnWv4EC
 GUIl7rsvtmpXX4BU4ESXpilQ0qkXXRRfqoWvhBfJU/dvUD7KNF5ff+yPpnraYR4MRvSUQRf/Z
 wt2/uI8xikt3u0biJcwqYDzwHZAwhdMXZuzmM2sIpPR4FUskOJqcuTYmkZgW8TsYP++JsPlVk
 Ek7XS3DUhhLPTBSHOtO2z5uAOdWMpZGjCWYZl/YgApqzbyyS8VX7jBzWQZWQ2wk4mdxb1UVwS
 5p09Hm36l0neidSNpVi9H6yKTSL63drBaZv+beswf9X2fcRs7o=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 5:31 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wed, May 13, 2020 at 2:57 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >>
> >> Arnd Bergmann <arnd@arndb.de> writes:
> >>
> >> > If you share your .config, I can try reproducing with that as well.
> >> > Once there is a reproducer in qemu, it should be trivial to step
> >> > through it using gdb.
> >>
> >> I have attached the .config I used with GCC 10.1. If you are able to
> >> test it please do let me know how it went.
> >
> > Yes, I see the same problem now, but have not investigated
> > any further.
>
> Great, so it's not a problem due to my setup.

I investigated a little more: This does happen with 'defconfig'
after all, in my first try I must have missed the '-smp 2' argument
to qemu, and it ended up working correctly with just one CPU
but fails now.

Stepping through the boot process, I see where it crashes
in start_secondary:

|        /* to prevent fake stack check failure in clock setup */
|        boot_init_stack_canary();
|
|        x86_cpuinit.setup_percpu_clockev();
|
|        wmb();
|        cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);

The call to cpu_startup_entry() does not succeed, instead
it jumps to __stack_chk_fail() from there.

      Arnd
