Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C22422102
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhJEIo1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 04:44:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEIo1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 04:44:27 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MsYzD-1mo5uy2ePj-00u5Zh for <linux-wireless@vger.kernel.org>; Tue, 05 Oct
 2021 10:42:35 +0200
Received: by mail-wr1-f50.google.com with SMTP id v25so25206639wra.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 Oct 2021 01:42:35 -0700 (PDT)
X-Gm-Message-State: AOAM530zR4a2X++16S1HJE2+IOLq2LFLkdX53KWcBmYPuhIkb85T48OU
        z2d3eJiuZJz6cC0oadPxxbfB9ILN97sqr7vUEKc=
X-Google-Smtp-Source: ABdhPJxA2YxE9wNpf2P0ZdMFpbRH1PNe+VsDTr87nrbZ9Jzp9u5x0qLgDO38/YHANwTD2qsovSP4/IvugU5PHDZ9DCA=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr19766988wrs.71.1633423355280;
 Tue, 05 Oct 2021 01:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210820043538.12424-1-pkshih@realtek.com> <20210820043538.12424-4-pkshih@realtek.com>
 <877dewiudp.fsf@codeaurora.org> <4b2f1c6b06e040d19b64d07500e0447b@realtek.com>
 <87pmsjgbhp.fsf@codeaurora.org>
In-Reply-To: <87pmsjgbhp.fsf@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Oct 2021 10:42:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0T4iqtF0wj5+VUT6z3S2yGC4uaOr806NCiQTpYoPawUg@mail.gmail.com>
Message-ID: <CAK8P3a0T4iqtF0wj5+VUT6z3S2yGC4uaOr806NCiQTpYoPawUg@mail.gmail.com>
Subject: Re: [PATCH v6 03/24] rtw89: add core and trx files
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Pkshih <pkshih@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KZG5RoiLvKJaRv4md4QP6uJ95zTcVyaLSpB7hN+3vl9M91H7708
 XO+i91ZjFJD96FHFLL7BawaaJQFRwb3JUzvsdQ9Gsf3ZMoS9RAqdGtYAL5Ejleoo/sTd9M/
 Dq3VSFejn+uoDPG5P/9Kyu+nlWa5B+oOjgNNM58Xa4qUq3EhNf7UP1ZLkfboYc23g5UCLyD
 Qw6GqZC6ekga2KYLAKzOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/mC2JJGYmO8=:NrSQY5c3+1kXNUxWNI8pq2
 m7bWyJenvuwYYkDF/gKKw3PeuL4vku3hwtxaznVd0nK7ip56b2lMqymWrqHwFy7e+Dn6DPPFS
 pEoyVsbHXs1mEsLRl3Fv9W2qDKvXbvYFxk2afiTGrRqDR+1OFgUshuGWMZbKWjn5y/0qX1w38
 a/oKdCrDP+XnB19eKux8cANDOgyTL5DyAJPt/k33Rn2rtlizqfyclEvZs4HM4YKG5WXNY9pUd
 Hvn2/mPP0RCHkPVGLUWaqHxQiTHtjtYR4m3IIDFsuIKwtf992XXfe9WL8ENFyqvfKXjNL5FbH
 OZhQZQoFTMmKaXo5rZLLBvUPCSqcNBy1YWLMr3yNBxssAJRgo+vkLiLoDa4aLXp0vvzOZG9Mo
 JPKUIm0/QrKdqQkM12NwYNwtJrfCj9XZ18YXhrtnI5kDjgpKqNKniwP34dB+NfhA26DrVT8/L
 hdPPIYX2fPyyA75lS2HhuzzlFiIVNsLMa+no3W4WUHMoza1UDHgav2+Ks2Gfo2rdFsZ4HohnQ
 VK+9xHjsSRZ2+JMAy7aYCB5V/XL95ePVplMc1XiDAYxXswpOFIM1wd+jffw+RBNkm841u9Mir
 Q6FBZ0PD9enKylEtgyk7eEpQhHnmEyjZSK+ulVi0rzMhRbRvLAusiOP25GOG7vMwdjxHW9VXJ
 cg9KHrgcDmqbcNCrNIYLqwWdNYkZ+i47h8HG1klFmxXki6mu+TVzS/2Dp4QBWPYtnyzvMwG9u
 gpApR3RBs2g1l8Zyk3eFwu4MpNJYNzvCMFB9jA==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 5, 2021 at 9:46 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Pkshih <pkshih@realtek.com> writes:
> >> From: kvalo=codeaurora.org@mg.codeaurora.org
> >>
> >> > +static __always_inline void RTW89_SET_TXWD(u8 *txdesc, u32 val,
> >> > u8 offset, u32 mask)
> >> > +{
> >> > +  u32 *txd32 = (u32 *)txdesc;
> >> > +
> >> > +  le32p_replace_bits((__le32 *)(txd32 + offset), val, mask);
> >> > +}
> >>
> >> I'm not convinced about this either, please just use inline.
> >
> > This is because 'mask' argument of le32p_replace_bits() must be constant
> > only. If I use inline and build this driver with ccflags-y += -Os,
> > compiler reports errors:
> >
> > In function 'field_multiplier',
> >     inlined from 'le32_encode_bits' at ./include/linux/bitfield.h:154:1,
> >     inlined from 'le32p_replace_bits' at ./include/linux/bitfield.h:154:1,
> >     inlined from 'RTW89_SET_FWCMD_UA32.constprop' at /work/git-root/rtwlan/rtw89/fw.h:1397:2:
> > ./include/linux/bitfield.h:119:3: error: call to '__bad_mask' declared with attribute error: bad bitfield mask
> >   119 |   __bad_mask();
> >       |   ^~~~~~~~~~~~
> >
> > I check the implement of le32p_replace_bits(), it looks like
> >
> > static __always_inline void type##p_replace_bits(__##type *p,           \
> >                                         base val, base field)           \
> > {                                                                       \
> >         *p = (*p & ~to(field)) | type##_encode_bits(val, field);        \
> > }
> >
> > So, I imitate the function to use __always_inline, and then it works.
> >
> > Do you think I don't need to consider the case of Os?
> > But, -Os seems a standard option of Linux kernel.
> >
> > ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> > KBUILD_CFLAGS += -O2
> > else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
> > KBUILD_CFLAGS += -O3
> > else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> > KBUILD_CFLAGS += -Os
> > endif
>
> Yeah, we need to support -Os.
>
> Arnd, what do you suggest? Is __always_inline good solution for this? I
> think we should at least add a comment explaining why it's needed.

__always_inline can make sense to force the compiler to behave
sanely if it doesn't work it out by itself, and I think that is how this
function was meant to be used: the __compiletime_error in bitfield.h
is intended to find any callers that have a non-constant argument,
because that would result in horrible code.

I would suggest looking at the object code that you get with -Os after
the added __always_inline, just to make sure that this isn't also
horrible.

Looking at the driver code, as in

+#define RTW89_SET_TXWD_BODY_WP_OFFSET(txdesc, val) \
+ RTW89_SET_TXWD(txdesc, val, 0x00, GENMASK(31, 24))
+#define RTW89_SET_TXWD_BODY_MORE_DATA(txdesc, val) \
+ RTW89_SET_TXWD(txdesc, val, 0x00, BIT(23))
+#define RTW89_SET_TXWD_BODY_WD_INFO_EN(txdesc, val) \
+ RTW89_SET_TXWD(txdesc, val, 0x00, BIT(22))
+#define RTW89_SET_TXWD_BODY_FW_DL(txdesc, val) \
+ RTW89_SET_TXWD(txdesc, val, 0x00, BIT(20))

I would personally write this without the wrappers, instead defining the
bitmask macros as the masks and then open-coding the
le32p_replace_bits() calls instead, which I would find more
intuitive while it avoids the problem with the bitmasks.

Going back one more step, I see that that rtw89_core_fill_txdesc()
manipulates the descriptor fields in-memory, which also seems
like a bad idea: The descriptor is mapped as cache-coherent,
so on machines with no coherent DMA (i.e. most ARM or MIPS
machines), that is uncached memory, and writing the descriptor
using a series of read-modify-write cycles on uncached memory
will be awfully slow. Maybe the answer is to just completely
replace the descriptor access.

       Arnd
