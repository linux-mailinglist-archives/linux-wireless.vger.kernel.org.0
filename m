Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6534222F5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 11:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhJEKBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 06:01:34 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhJEKBe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 06:01:34 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M2OIy-1mUxPM3DSg-003s3Y for <linux-wireless@vger.kernel.org>; Tue, 05 Oct
 2021 11:59:42 +0200
Received: by mail-wm1-f44.google.com with SMTP id t16-20020a1c7710000000b003049690d882so2440377wmi.5
        for <linux-wireless@vger.kernel.org>; Tue, 05 Oct 2021 02:59:42 -0700 (PDT)
X-Gm-Message-State: AOAM5334GT2WemFetXgjKlp/LBRRbaEJS6P+yNOL69q2eEQ5RUXdR4FN
        VjIQBNt/VE3iY5OC95Ub8z+hxV9UzT+1hE3jf78=
X-Google-Smtp-Source: ABdhPJza/87wpHJ4zuW8kRa8EVdLNmMDe/QOT1yoE54of4e71VTAuN/jykjE9D1bxO8rCwaGsRLIN35TxxdJja3a258=
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr2432328wmi.98.1633427982402;
 Tue, 05 Oct 2021 02:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210820043538.12424-1-pkshih@realtek.com> <20210820043538.12424-4-pkshih@realtek.com>
 <877dewiudp.fsf@codeaurora.org> <4b2f1c6b06e040d19b64d07500e0447b@realtek.com>
 <87pmsjgbhp.fsf@codeaurora.org> <CAK8P3a0T4iqtF0wj5+VUT6z3S2yGC4uaOr806NCiQTpYoPawUg@mail.gmail.com>
 <a8dd5e59fb8f491fb34e52d495cf4c85@realtek.com>
In-Reply-To: <a8dd5e59fb8f491fb34e52d495cf4c85@realtek.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Oct 2021 11:59:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Zk4AgQ4Cyv3RmLH8Zuaj2uamFQ3hDZktrOVduZ90r6w@mail.gmail.com>
Message-ID: <CAK8P3a1Zk4AgQ4Cyv3RmLH8Zuaj2uamFQ3hDZktrOVduZ90r6w@mail.gmail.com>
Subject: Re: [PATCH v6 03/24] rtw89: add core and trx files
To:     Pkshih <pkshih@realtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oZ89fi/Rpp0FgpZYdCy+iZzQSw5ZNZI3Q6ulOHaMMen6oGAUyFn
 qyWVpLa8NQR7l83XefRoaVmGmTOZacCe02pCG79FbL1UKu4VKyJ9aQVtOwow2b6AECnC0Oy
 7br3aoa+x9t6XLo3zvdpg0byhmFAFQJPy8d7KQGe8dqJ9bv0CXqVUnLluobXhgxhMssIWPS
 8TeqFRRNm482lwn1TLqbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3S6HqAQjk4c=:qpqeB4xcb54dY7YrQ3iwfX
 c2eOaViW3qixWBuT+qQsTgt9NJCNC+EMeEgwkTcrbAhibkpr/EJLDHzBpPi3iTGQ5rvWAPs0A
 2g1wsRovuN3cYhFsu4xv5dzEjXG8PEnrNLY4WubQHzylWUP0abJs2EAa4ed8qPnPkjJptCLyU
 1xySRgyK1TdcCB8bu57XX7R/q5lYq4ioWsZRIe9R0xi2kOKdpxqK5StSE2VOtDFZ06SQvsbgs
 uLlRq2kMa5aJBd48BvDaYwuLECcIPFKUVwPhzYrGLLah/I9FWtLO3jqyAGTi6+5YnNOhuUhf9
 7IkTBdOz3nGVjYE9gqahI5NNgy32AzdPBqXz8nXAXDgC2V6qG7N5DgNmg0L6+Z9P+bcOsoZbV
 ohZ5dDeG3yzqtCsEFzGVqs4S+kAaQEFPN7D4JmZlOSjAUllhLcqveoR+NcrLQjCS8nCWjm1xv
 bhzKUl4wm5rrqOb0iKTH6uhSVg3Uj6lEsGqG2gNXJc/b2RPLJWioXsJG8KZO+o7Qtoc3fz/A9
 Dz0K3zIyaj/LfHz7LqMbSNhJWkCE9enKxbmVYB1HBtbEXqZ2OAfIC1fdOoGdHx7K4FCcSo7+l
 uEt/ierZXWS0qmA2psAOSYLJjx95qmh2ed7Z0B3A7bLoWk/cMPkbpNI6EtSGGrI9/Qy6jBpw0
 TEOTAKnO2xUA7RckcditYVWtolaWFyUPbPuSPt45c/fjNjSg1XIWI5nbrA0lfHDObJxxag3T8
 7kiTXh18je+tfSeie1DU4rzx7FKMTejuqoQ0Vw==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 5, 2021 at 11:32 AM Pkshih <pkshih@realtek.com> wrote:
> > Cc: Pkshih <pkshih@realtek.com>; Arnd Bergmann <arnd@arndb.de>; linux-wireless@vger.kernel.org
> > >
> > > Arnd, what do you suggest? Is __always_inline good solution for this? I
> > > think we should at least add a comment explaining why it's needed.
> >
> > __always_inline can make sense to force the compiler to behave
> > sanely if it doesn't work it out by itself, and I think that is how this
> > function was meant to be used: the __compiletime_error in bitfield.h
> > is intended to find any callers that have a non-constant argument,
> > because that would result in horrible code.
> >
> > I would suggest looking at the object code that you get with -Os after
> > the added __always_inline, just to make sure that this isn't also
> > horrible.
>
> I check the function rtw89_core_fill_txdesc() which uses these macros.
> With inline, the object code size is 0x1AF. With __always_inline and
> -Os, the size is 0x1A4. (x86-64 platform)
>
> Compare the object codes side-by-side, they are almost the same except
> to some instructions. I think this is because the inline function
> I apply __always_inline contains only a simple statement.

Ok. Did you check the output for the configuration that showed the
problem as well, after adding __always_inline? There are certain
compile-time options that could cause the code to become unoptimized,
e.g. KASAN, in addition to the OPTIMIZE_FOR_SIZE.

> > +#define RTW89_SET_TXWD_BODY_WP_OFFSET(txdesc, val) \
> > + RTW89_SET_TXWD(txdesc, val, 0x00, GENMASK(31, 24))
> > +#define RTW89_SET_TXWD_BODY_MORE_DATA(txdesc, val) \
> > + RTW89_SET_TXWD(txdesc, val, 0x00, BIT(23))
> > +#define RTW89_SET_TXWD_BODY_WD_INFO_EN(txdesc, val) \
> > + RTW89_SET_TXWD(txdesc, val, 0x00, BIT(22))
> > +#define RTW89_SET_TXWD_BODY_FW_DL(txdesc, val) \
> > + RTW89_SET_TXWD(txdesc, val, 0x00, BIT(20))
> >
> > I would personally write this without the wrappers, instead defining the
> > bitmask macros as the masks and then open-coding the
> > le32p_replace_bits() calls instead, which I would find more
> > intuitive while it avoids the problem with the bitmasks.
>
> Use these macros can address offset and bit fields quickly.
> How about I use macro instead of inline function? Like,
>
> #define RTW89_SET_TXWD (txdesc, val, offset, mask) \
> do { \
>         u32 *txd32 = (u32 *)txdesc; \
>         le32p_replace_bits((__le32 *)(txd32 + offset), val, mask); \
> } while (0)

That would obviously address the immediate bug, but I think
using le32p_replace_bits() directly here would actually be
more readable, after you define the descriptor layout using
a structure with named __le32 members to replace the offset.

> > Going back one more step, I see that that rtw89_core_fill_txdesc()
> > manipulates the descriptor fields in-memory, which also seems
> > like a bad idea: The descriptor is mapped as cache-coherent,
> > so on machines with no coherent DMA (i.e. most ARM or MIPS
> > machines), that is uncached memory, and writing the descriptor
> > using a series of read-modify-write cycles on uncached memory
> > will be awfully slow. Maybe the answer is to just completely
> > replace the descriptor access.
>
> I'll think if we can use chached memory with single_map/unmap for
> descriptor. That would improve the performance.

Using dma_unmap_single() with its cache flush may not work
correctly if the descriptor fields have to be written in a particular
order. Usually the last field in a descriptor contains a 'valid'
bit that must not be observed by the hardware before the rest
is visible. The cache flush however would not guarantee the
order of the update.

It would also likely be slower than dma_alloc_coherent() on
machines that have cache-coherent PCI, such as most x86.

The best way is usually to construct the descriptor one word
at a time in registers, and write that word using WRITE_ONCE(),
with an explict dma_wmb() before the final write that makes
the descriptor valid.

         Arnd
