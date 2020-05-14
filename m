Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A331D2A78
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgENIlF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 04:41:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENIlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 04:41:04 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MBjA4-1jN5ft3hN6-00C8pc; Thu, 14 May 2020 10:41:02 +0200
Received: by mail-qt1-f175.google.com with SMTP id c24so2187935qtw.7;
        Thu, 14 May 2020 01:41:01 -0700 (PDT)
X-Gm-Message-State: AOAM530fr7v+iKSyffKHRPC7yZsfG/Plt00n5G2TARXFsJBj5OIR20nJ
        KifMz6ePIxY74VG7iujxrYqwQMEsIe3skax+k+s=
X-Google-Smtp-Source: ABdhPJwB7vmKaUp0FKDv8huqQRaoInxKmxgkm5ozO0puX8Rje5ZD18zAJ70BVQAgyVCL/R9BA8Zev1+sEBFBUwscWtc=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr3166722qtn.18.1589445660699;
 Thu, 14 May 2020 01:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic> <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
 <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
 <CALCETrUYA60fWu+=MviKx0NmW+_ppsOcv-ShUXdbyM4EjyfzHQ@mail.gmail.com>
 <CAHk-=wgiGxRgJGS-zyer1C_x2MQUVo6iZn0=aJyuFTqJWk-mpA@mail.gmail.com> <20200514052234.GA1894416@rani.riverdale.lan>
In-Reply-To: <20200514052234.GA1894416@rani.riverdale.lan>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 May 2020 10:40:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Cfzu7L30bFP-Sf2_GbkN_10CCJsbefTXyfnGF16uHMA@mail.gmail.com>
Message-ID: <CAK8P3a1Cfzu7L30bFP-Sf2_GbkN_10CCJsbefTXyfnGF16uHMA@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:jnIzLBrM0jEQrCHlkxywVLSVaOZWWYcJv/R42h3em7OZYlF+nHl
 UAJzPzfI33NKpGKTgAd6YhVqLcAOdNE12Ord7Jy+2OYgl20Pn3NSknwpZdQxyUXSMQRcEtV
 hygOKa7mISMC4u0gk59ZnN20QwZJWglOQgw7G6QlOHIbZz5WN1SWZG/GIL6CM0eD1YWpJOk
 q5M9sM6xW/6o1X18ns3EA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k/Fz5z3nB+E=:DGTbgR0BxrGmcoN73g2Jet
 LFczIlbQyDBbbQHNdj40gCjZWegupJBxqQnr9r3+C89LuXjOKMEoBilRq7BPsKDAE4RbZEroa
 uwGIY/lNIbs9sI2tD1aFbZVHmtWVq6c4WAq9Vnwem0SHNjlP2QVh00Y15mlvW860lBdIIwL7d
 Xgzez/yVwUYWdbHI6duW8YFt5lMVQH1AyPH9BHnStMQF5Bl1NCw7apjlm4xRQvzFZArXIW9w9
 xuCw0RyZHQ5BBZVB36WiOh4T4R46fQ7T0IEzdnXsAKN1hdbfDFhzkfsxOcDAhmA4mQVgMxmdi
 XcTClGOgnT+I06HjxBGh+BMkPQOJPUZb4yKVdq93lPRv+RdlHLT7uLvs6miXn/yv3xHjJufek
 JxRT/IaDZ9+uacz//ER80VTXWoEgykIsMAHGhCip45mgWwui49vfr3hTbbNBby1M+aEE67S/X
 havj63hH6fTSbtkKZcqexRqUkqH9a0MYgVA0CmQLBQ3Ev/+8M81ZdPU0Ysj24ST12mvklJYyT
 PhZBapOQlh0TlHMNMLMucw/dlYACBzmaUXV7QYM52cuZOI0GQzPip9GJqWJLsPlmy/JZakbtn
 7Aj9x2tNgPo8bWSiud0fDi2RNRXVt+GMSdnnJ9B2XCxtyqh2CeR3TaVUBC4sbJwMeejx+e4Vz
 u9nDHTaqKWjqSWWfp7kv8bKjhhdTm4NqzmYB1mdZyAbOI2Al/5B277gFICLvOlKUPVlmaN7yo
 gAIgdOLaWSpjq/n4RuyQakJYkcm46OSptnjfUT1nJnFtLQY8sLjckFO1yqvDQaHqaRQ/lgbg7
 eW1J6pd+xijWbjB/S+d7pKrWPTeGVJUvybd4tlaWVDp0pglf5I=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 14, 2020 at 7:22 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> On Wed, May 13, 2020 at 09:52:07PM -0700, Linus Torvalds wrote:
> > On Wed, May 13, 2020, 20:50 Andy Lutomirski <luto@amacapital.net> wrote:
> The gcc docs [1,2] at least don't inspire much confidence that this will
> continue working with plain asm("") though:
>
> "Note that GCC’s optimizers can move asm statements relative to other
> code, including across jumps."
> ...
> "Note that the compiler can move even volatile asm instructions relative
> to other code, including across jump instructions."
>
> Even if we don't include an instruction in it I think it should at least
> have a memory clobber, to stop the compiler from deciding that it can be
> moved before the call so it can do the tail-call optimization.

I think LTO would still be able to notice that cpu_startup_entry() can
be annotated __attribute__((noreturn)) and optimize the callers
accordingly, which in turn would allow a tail call again after dead code
elimination.

     Arnd
