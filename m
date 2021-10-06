Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6527A4238F7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhJFHfN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 03:35:13 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhJFHfG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 03:35:06 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7yz7-1muNoo2Nm7-0154Sh for <linux-wireless@vger.kernel.org>; Wed, 06 Oct
 2021 09:33:13 +0200
Received: by mail-wr1-f45.google.com with SMTP id v25so5839284wra.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Oct 2021 00:33:13 -0700 (PDT)
X-Gm-Message-State: AOAM531/a3DZsxifTbeZb2ZYtl3tXNzVi7oTKrzQBw6OwlawEo287Ym/
        TFmYMZn3XLmVsjymrpgLf035jDuBhUw7wNUJnTo=
X-Google-Smtp-Source: ABdhPJx9eyi0bMWIbhw8jkuNfzLulRPPryCl4uaLO6jGQTH+h6tLt/rjJZONdO/2NVNqpPsb05Doz/j6mk/SjQLgaH8=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr26386607wrz.369.1633505592991;
 Wed, 06 Oct 2021 00:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210820043538.12424-1-pkshih@realtek.com> <20210820043538.12424-4-pkshih@realtek.com>
 <877dewiudp.fsf@codeaurora.org> <4b2f1c6b06e040d19b64d07500e0447b@realtek.com>
 <87pmsjgbhp.fsf@codeaurora.org> <CAK8P3a0T4iqtF0wj5+VUT6z3S2yGC4uaOr806NCiQTpYoPawUg@mail.gmail.com>
 <a8dd5e59fb8f491fb34e52d495cf4c85@realtek.com> <CAK8P3a1Zk4AgQ4Cyv3RmLH8Zuaj2uamFQ3hDZktrOVduZ90r6w@mail.gmail.com>
 <5d0cb19ab70348f88ab0924dad5c3e7e@realtek.com>
In-Reply-To: <5d0cb19ab70348f88ab0924dad5c3e7e@realtek.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Oct 2021 09:32:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1rsKZZKMKFTDWgE3usX9gYKJqUvTMxSdEuZrp8BaKdaA@mail.gmail.com>
Message-ID: <CAK8P3a1rsKZZKMKFTDWgE3usX9gYKJqUvTMxSdEuZrp8BaKdaA@mail.gmail.com>
Subject: Re: [PATCH v6 03/24] rtw89: add core and trx files
To:     Pkshih <pkshih@realtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:66xp+C6F7PW1m7cjNgYGqBLA5xR7uHZFomops3uTLpXYXsWTshH
 tPk3vqCLC6mnvg45A0H4rAv//KO1XIjYzy1abtvnuQdPYX9ubb1flZClzhd4ozogClS62JB
 mMZBRT+Es/djj1twPoroH5nJi/hHzd6O1jod0UjOrqUSf09QcqtMD9Rf+Ctg2Fred2dW5Ma
 gd+AxX5UEI9QuMCUwemYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZrlrgfHXcsQ=:2/JBiWXJXrxLH+1X2hOu8t
 gntKfESmH9oWBsdTJpaJwR7hC+v05FvOFnc+sO0qywfRc+SSmMTMaPsWgvHI6zAiRb/raLrtJ
 sHQxFaznYh15QkPNg4H6hIoVPbUfg6/NIMNEsYNdpZEC41BxiH2cjhCi/u5flmLZB1gBiIh2h
 W1qKU3ERXtp4w0aOq7yRkaHdIYvppih8jX920a8CYphHs4VQKX2Jc/evyfoi6CxAiX06GUnoW
 a3a5KT6W1zoYossMmROIVOs2zzMME5LoNXpCluThBkDDDLelme3jJorHWdP//Z/lLlCurZMDQ
 4NdpFJvAwPX79ULMsE/AN5I+H4fonR5JEGnbkCLmdJDTfe1FgGZLWwA+oUNDufoprmxoYELZF
 /X0hbM4U90xCpQlsvBQ9CqQIAq1XWHXAXmTyV/MS4cOz7wrCAcFzQ8QdwtHx+d/sP5g69Dd+G
 gvcnRd5v57OKMxh9+VYpOAudVt+tYh3CUAtNSL5bQIzlXiyxD5qh41CdrPRplQOINjpdHERhx
 Q3CZUTZuFOygd/c92YYEgqZEyMpWGR5IOWwKIhsU8RCwmeTmPLhiGcUbSPWsfVho1jnozZ44U
 0/rcNlR2VNXY4MJ69KI//AWg/8mdfydpb5cj5/n0MBncMPJlWVfN7V4beKGFaZ/rGHsL4rAHK
 OeI+ZjNRvBWFAVOBjtDvM3xdzRH0RLL19qdFs9ctVK3M4nZQRFent40JvUNxahAtsBCWQvva2
 faV3jyAK6xbRtmZD95RWCy9+Q0JYJ0aZ+mMLGA==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 6, 2021 at 3:35 AM Pkshih <pkshih@realtek.com> wrote:
> > >
> > > Compare the object codes side-by-side, they are almost the same except
> > > to some instructions. I think this is because the inline function
> > > I apply __always_inline contains only a simple statement.
> >
> > Ok. Did you check the output for the configuration that showed the
> > problem as well, after adding __always_inline? There are certain
> > compile-time options that could cause the code to become unoptimized,
> > e.g. KASAN, in addition to the OPTIMIZE_FOR_SIZE.
>
> Summarize object code size of the combinations:
>
> ccflag              default           -Os
> ======              =======           =============
> inline              0x1AF             X
> always_inline      0x1AA             0x1A4
>
> With default ccflag, the difference of inline and always_inline is a
> je/jne instruction for 'if (!desc_info->en_wd_info)'. The always_inline
> doesn't affect the part that use RTW89_SET_TXWD().
>
> Compare always_inline row, the case of default ccflag uses movzbl (4 bytes),
> but -Os case uses mov (3 bytes).
>
> By the results, -Os affect the object code size. always_inline doesn't
> affect the code, but affect the instruction (je/jne) nearby.

Those are the known-good cases, yes.

> I use Ubuntun kernel that doesn't enable KASAN.
> # CONFIG_KASAN is not set

Ah, so you test using the driver backports package on a distro
kernel? While this may be a good option for your development
needs, I think it is generally a good idea to also be able to test
your patches against the latest mainline or linux-next kernel
directly, if only to ensure that there are no obvious regressions.

> > > > +#define RTW89_SET_TXWD_BODY_WP_OFFSET(txdesc, val) \
> > > > + RTW89_SET_TXWD(txdesc, val, 0x00, GENMASK(31, 24))
> > > > +#define RTW89_SET_TXWD_BODY_MORE_DATA(txdesc, val) \
> > > > + RTW89_SET_TXWD(txdesc, val, 0x00, BIT(23))
> > > > +#define RTW89_SET_TXWD_BODY_WD_INFO_EN(txdesc, val) \
> > > > + RTW89_SET_TXWD(txdesc, val, 0x00, BIT(22))
> > > > +#define RTW89_SET_TXWD_BODY_FW_DL(txdesc, val) \
> > > > + RTW89_SET_TXWD(txdesc, val, 0x00, BIT(20))
> > > >
> > > > I would personally write this without the wrappers, instead defining the
> > > > bitmask macros as the masks and then open-coding the
> > > > le32p_replace_bits() calls instead, which I would find more
> > > > intuitive while it avoids the problem with the bitmasks.
> > >
> > > Use these macros can address offset and bit fields quickly.
> > > How about I use macro instead of inline function? Like,
> > >
> > > #define RTW89_SET_TXWD (txdesc, val, offset, mask) \
> > > do { \
> > >         u32 *txd32 = (u32 *)txdesc; \
> > >         le32p_replace_bits((__le32 *)(txd32 + offset), val, mask); \
> > > } while (0)
> >
> > That would obviously address the immediate bug, but I think
> > using le32p_replace_bits() directly here would actually be
> > more readable, after you define the descriptor layout using
> > a structure with named __le32 members to replace the offset.
>
> I will remove the wrapper and use le32p_replace_bits() directly.
>
> I don't plan to use structure, because these data contain bit-fields.
> Then, I need to maintain little-/big-endian formats, like
>
> struct foo {
> #if BIG_ENDINA
>         __le32 msb:1;
>         __le32 rsvd:30;
>         __le32 lsb:1;
> #else
>         __le32 lsb:1;
>         __le32 rsvd:30;
>         __le32 msb:1;
> #endif
> };

Right, bitfields would not work well here, as they are generally not
portable. Using an "#ifdef __BIG_ENDIAN_BITFIELD" check can
work, but as you say this is really ugly.

What I was trying to suggest instead is a structure like

struct descriptor {
     __le32 word0;
     __le32 word1;
     __le32 word2;
     __le32 word3;
};

And then build the descriptor like (with proper naming of the fields of course)

void fill_descriptor(struct my_device *dev, struct sk_buff *skb,
volatile struct descriptor *d)
{
          d->word0 = build_desc_word0(fieldA, fieldB, fieldC, fieldD);
          d->word1 = build_desc_word1(fieldE, fieldF);
          ...
}

where the build_desc_word0() functions are the ones that encode the
actual layout, e.g. using the linux/bitfield.h helpers like

static inline __le32 build_desc_word0(u32 fieldA, u32 fieldB, u32
fieldC, u32 fieldD)
{
        u32 word = FIELD_PREP(REG_FIELD_A, fieldA) |
                           FIELD_PREP(REG_FIELD_B, fieldB) |
                           FIELD_PREP(REG_FIELD_C, fieldC) |
                           FIELD_PREP(REG_FIELD_D, fieldD);

       return cpu_to_le32(word);
}

Doing it this way has the advantage of keeping the assignment
separate, which makes sure you don't accidentally introduce
a read-modify-write cycle on the descriptor. This should work
well on all architectures using dma_alloc_coherent() buffers.

> > > > Going back one more step, I see that that rtw89_core_fill_txdesc()
> > > > manipulates the descriptor fields in-memory, which also seems
> > > > like a bad idea: The descriptor is mapped as cache-coherent,
> > > > so on machines with no coherent DMA (i.e. most ARM or MIPS
> > > > machines), that is uncached memory, and writing the descriptor
> > > > using a series of read-modify-write cycles on uncached memory
> > > > will be awfully slow. Maybe the answer is to just completely
> > > > replace the descriptor access.
> > >
> > > I'll think if we can use chached memory with single_map/unmap for
> > > descriptor. That would improve the performance.
> >
> > Using dma_unmap_single() with its cache flush may not work
> > correctly if the descriptor fields have to be written in a particular
> > order. Usually the last field in a descriptor contains a 'valid'
> > bit that must not be observed by the hardware before the rest
> > is visible. The cache flush however would not guarantee the
> > order of the update.
>
> Is it possible to flush cache twice? Writing the fields other
> than 'valid' bit, and do wmb() and first flush. Then, set 'valid' bit,
> and do second flush.

This could work, but it would be really expensive, since the
dma-mapping API is based on ownership state transitions, so
you'd have to got through dma_sync_single_for_device(),
dma_sync_single_for_cpu(), and another
dma_sync_single_for_device(). On machines using swiotlb(),
those would in turn translate into copy operations.

> > It would also likely be slower than dma_alloc_coherent() on
> > machines that have cache-coherent PCI, such as most x86.
> >
> > The best way is usually to construct the descriptor one word
> > at a time in registers, and write that word using WRITE_ONCE(),
> > with an explict dma_wmb() before the final write that makes
> > the descriptor valid.
> >
>
> Thanks for the guideline.
>
> Fortunately, descriptor of this hardware uses circular ring buffer with
> read/write index instead of 'valid' bit. To issue a packet with descriptor
> to hardware, we fill descriptor and fill address of skb as well, and then
> update write index (a register) to trigger hardware to start DMA this
> packet. So, I think it is possible to use dma_map_single().
>
> Anyway, I will try both methods later.

If you end up with the streaming mapping, I would suggest using a
single dma_alloc_noncoherent(), followed by dma_sync_single_*
later on, rather than multiple map/unmap calls that would need to
reprogram the IOMMU. The coherent API as I explained above
should be more efficient though, unless you need to do a lot of
reads from the descriptors.

        Arnd
