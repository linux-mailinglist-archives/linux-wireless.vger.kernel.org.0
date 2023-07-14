Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2307753E2E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjGNOzn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jul 2023 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjGNOzh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jul 2023 10:55:37 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F63AB9
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jul 2023 07:55:27 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-47e1c7c1148so1352670e0c.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jul 2023 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689346527; x=1691938527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvhGhwK3hQYyA21peYmIOow9+J4vgG6yjc5ZbzkLWoM=;
        b=isA2RXNjdhF7BOs33nOBn3lihMCe3kNYZD3BN3FIEdKzVqlcWyzk8XpFLn258zHyEx
         HZOASVCBXuVm91A+F7BWUEYVD4jZGITprf9R/xww+VODmQp3M1QPjuTOsPlKg0PGqS6t
         9vac0rtvOFw92FOBg/eEOJ68XftLNynN/g7COuISgMOGRfLAoHin6HKDhyVfm3W2rVs/
         J381i1bCkLsUZp2vPLZ+dLZmgojIu1+dqrbD7g9LEp69nM30B6nNSSDxB7CDUYyAfUpg
         P9z/I7nISrbUKQ2sJfi4DNan84G5015UYVOFe72As/l7uxSrGtCM7gZYuBxQIYgasUbh
         nnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689346527; x=1691938527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvhGhwK3hQYyA21peYmIOow9+J4vgG6yjc5ZbzkLWoM=;
        b=hHQCqo1Pegu201WCXtAP6WGU3hkDhpI9ACILYuHM1sMoh3E+Q3HZZ6EXBaptPtLVTM
         6TkxEzcntY6sfYe22IAvPtqt5+keCFv4hLTdN7W3U0MVuHUaNHyBBqncUxTQrZyzk0AU
         Pb02Djp6JUgoF/LUyv1w/w1GObsxklZMsxsa3crjcvkMrOF0ciczE6Mb3SFD4r5VR15L
         8RC2tJS/BtcJqezdqi2Uh/WW1kONAxFeNK6FRVJ2U8Fzijhi8GbuAiRXmUMRyXo7rgQ3
         ZmO1BZq4NuwjpTBvcTFHisMKG2NVPBpallv+2ipCVMvdcbJ4eNfx+vcfDJE47xirRx3j
         SVlg==
X-Gm-Message-State: ABy/qLb464D30A0WVBVjkGfyViA+mA9PhHYZ1vT/ngVuyMXPzp+sZUYh
        PaDyUxs92f343/rzr2M2+fzufwJpN6slfXBTCP1y2Q==
X-Google-Smtp-Source: APBJJlFBpLWkkLl2CX8PmjOhecvGDRkTotYcCL9xT6rQwbez+/O2UZuGeqOlALIkH5NJmj0CD30GBsPbAGECLf0e6Os=
X-Received: by 2002:a1f:a289:0:b0:481:2ff9:fc3f with SMTP id
 l131-20020a1fa289000000b004812ff9fc3fmr1025156vke.5.1689346526764; Fri, 14
 Jul 2023 07:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230710215906.49514550@kernel.org> <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca> <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org> <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org> <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca> <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
In-Reply-To: <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 14 Jul 2023 07:55:15 -0700
Message-ID: <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 13, 2023 at 12:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 12.07.23 um 22:16 schrieb Mina Almasry:
> > On Wed, Jul 12, 2023 at 6:01=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> >> On Tue, Jul 11, 2023 at 08:42:24PM -0700, Mina Almasry wrote:
> >>
> >>> 1. The device memory driver would be the p2pdma provider. It would
> >>> expose a user API which allocates a device memory region, calls
> >>> pci_p2pdma_add_resource() and pci_p2pmem_publish() on it, and returns
> >>> a reference to it to the userspace.
> >> This is not quite right, if you convert any of the GPU drivers to use
> >> P2PDMA you are going to need to restructure the p2pmem stuff to
> >> seperate the genalloc. The GPU driver must continue to be the owner
> >> and allocator of the MMIO memory it already controls, we can't have
> >> two allocators working in parallel.
> >>
> >> The genalloc stuff supports the special NVMe use case, I don't know of
> >> anything else that would like to work that way.
> >>
> > I think maybe you misunderstood the proposal. AFAICT the genalloc
> > stuff works for us, although there are other issues with p2pdma that I
> > need to solve.
> >
> > The proposal was that the uapi in step #1 allocates a region of GPU
> > memory, and sets up a p2pdma provider for this region of memory. From
> > the perspective of the GPU, the memory is allocated, and in use by the
> > user. The p2pdma provider uses genalloc to give out 4K regions with
> > struct pages to in-kernel allocators from this memory region. Why
> > would that not work?
>
> Oh well, where should I start.
>
> struct page is used in the various I/O  subsystems instead of DMA
> addresses because it allows for a wider range of operations.
>
> For example when a page is acquired using get_user_pages() somebody can
> use the rmap to figure out where a page is mapped and eventually unmap
> it, map it read only or change the caching attributes etc...
>
> Then you have the ability to grab a reference to a page, this for
> example allows I/O operations to complete and not access freed memory
> even when the application has already long died.
>
> Then a very common use case is that you need to fallback to a CPU copy
> because the data inside the page isn't aligned or outside the physical
> reach of a device.
>
> The are just numerous issues with what I listed above, for example some
> of those use cases only work with pagecache pages.
>
> Approaching it from the user side, with GPUs there is usually no
> guarantee that stuff is coherent. E.g. a network card wouldn't
> automatically see the results of a calculation.
>
> Then GPUs usually have tons of memory which isn't CPU accessible or even
> PCIe bus accessible. So a bounce buffer done with a CPU copy won't work,
> you need to bounce this with a hw assisted copy. Or you have inter
> device connections. For example ethernet over HDMI links would be able
> to access all of the internal GPU resources.
>
> Then GPUs often need to shuffle memory around, e.g. similar
> functionality to ___GFP_MOVABLE. Just with stuff not CPU accessible nor
> mapped into CPU page tables.
>
> ...
>
> I mean I can go with this list for quite some time :)
>
> > Looking at the code, that seems to be how p2pdma
> > works today. The p2pdma provider does p2pdma_add_resource() on a chunk
> > of its memory, and the genalloc allocates memory from that chunk?
>
> Well this is how it works for NVMe, that doesn't mean this way works for
> GPUs or acceleration devices.
>

Thanks Christian, yes, I misunderstood how this works and I apologize
for that. From reading the p2pdma interface it looked to me like it
takes a buffer as input and goes ahead and allocates the struct pages
for it and exports them as a provider. As you and Jason have
repeatedly tried to explain to me this bit is NVMe specific and as
Jason puts it it is a "big ask to P2P enable any of the DRM drivers".

I am facing some logistical issues as well. My use case requires NIC
with special features, and even getting access to the appropriate
hardware may be an issue for me.

I guess the remaining option not fully explored is the idea of getting
the networking stack to consume the scatterlist that
dma_buf_map_attachment() provides for the device memory. The very
rough approach I have in mind (for the RX path) is:

1. Some uapi that binds a dmabuf to an RX queue. It will do a
dma_buf_map_attachment() and get the sg table.

2. We need to feed the scratterlist entries to some allocator that
will chunk it up into pieces that can be allocated by the NIC for
incoming traffic. I'm thinking genalloc may work for this as-is, but I
may need to add one or use something else if I run into some issue.

3. We can implement a memory_provider that allocates these chunks and
wraps them in a struct new_abstraction (as David called it) and feeds
those into the page pool.

4. The page pool would need to be able to process these struct
new_abstraction alongside the struct pages it normally gets from
providers. This is maybe the most complicated part, but looking at the
page pool code it doesn't seem that big of a hurdle (but I have not
tried a POC yet).

5. The drivers (I looked at mlx5) seem to avoid making any mm calls on
the struct pages returned by the pool; the pool abstracts everything
already. The changes to the drivers may be minimal..?

6. We would need to add a new helper, skb_add_rx_new_abstraction_frag
that creates a frag out of new_abstraction rather than a struct page.

Once the skb frags with struct new_abstraction are in the TCP stack,
they will need some special handling in code accessing the frags. But
my RFC already addressed that somewhat because the frags were
inaccessible in that case. In this case the frags will be both
inaccessible and will not be struct pages at all (things like
get_page() will not work), so more special handling will be required,
maybe.

I imagine the TX path would be considerably less complicated because
the allocator and page pool are not involved (I think).

Anyone see any glaring issues with this approach?

> Regards,
> Christian.
>
> >
> > The actual issues I see with this approach are:
> >
> > 1. There is no way for the p2pdma provider to relinquish back the
> > memory it has provided via pci_p2pdma_add_resource(), in the case that
> > the user crashed or would like to free the GPU buffer. I would need to
> > add a pci_p2pdma_remove_resource(). Would that be  acceptable?
> >
> > 2. The p2pdma semantics seem to be global to the pci device. I.e., 1
> > GPU can export 1 p2pdma resource at a time (the way I'm reading the
> > API). This is not usable for my use case. I would need multiple users
> > to be able to use the uapi in step #1 simultaneously. I would need the
> > same pci device to export different p2pdma resources simultaneously
> > and the p2pdma clients would need to be able to import some of the
> > resources. I would likely need to add an api like this:
> >
> > diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> > index 8318a97c9c61..c9d754713fdc 100644
> > --- a/include/linux/pci-p2pdma.h
> > +++ b/include/linux/pci-p2pdma.h
> > @@ -19,6 +19,33 @@ struct scatterlist;
> >   #ifdef CONFIG_PCI_P2PDMA
> >   int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t siz=
e,
> >                  u64 offset);
> > +
> > +/* Adds a resource similar to pci_p2pdma_add_resource, and returns a f=
ile
> > + * handle referring to this resource. Multiple such resources can be e=
xported
> > + * by the same pci device.
> > + */
> > +struct file *pci_p2pdma_add_resource_with_handle(struct pci_dev *pdev,
> > +               int bar,
> > +               size_t size,
> > +               u64 offset);
> > +
> > +/* Remove a resource added via pci_p2pdma_add_resource_with_handle() *=
/
> > +struct file *pci_p2pdma_remove_resource_with_handle(
> > +               struct file *p2pdma_resource_file);
> > +
> > +/* Allocates memory from a resource created using
> > + * pci_p2pdma_add_resource_with_handle()
> > + */
> > +void *pci_alloc_p2pmem_from_handle(struct file *p2pdma_resource_file,
> > +               size_t size);
> > +
> > +/* Frees p2pmem to a resource created using
> > + * pci_p2pdma_add_resource_with_handle()
> > + */
> > +void pci_free_p2pmem_to_handle(struct pci_dev *p2pdma_resource_file,
> > +               void *addr,
> > +               size_t size);
> > +
> >
> > Looking for feedback from anyone knowledgeable, but the p2pdma
> > maintainers as well if possibl.
> >
> >>> 2. The NIC driver would be the p2pdma client and orchestrator. It
> >>> would expose a user API which binds an rxq to a pci device. Prior to
> >>> the bind the user API would check that the pci device has published
> >>> p2p memory (pci_has_p2pmem()), and check the the p2p mem is accessibl=
e
> >>> to the driver (pci_p2pdma_distance() I think), etc.
> >> This doesn't fit the programming model for GPUs at all. You don't want
> >> to get packets landing in random GPU memory that a kernel side
> >> allocator selects, you want packets landing in GPU memory owned by a
> >> specific process that owns the TCP connection.
> >>
> > I think this comment is maybe a side effect of the misunderstanding.
> > In the proposal, the user allocates a GPU buffer using the API in step
> > #1, and then binds the memory to the NIC rx queue using the API
> > specified in step #2. We use flow steering & RSS to steer this user's
> > TCP traffic to the buffer owned by them.
> >
> >> This is why DMABUF is used here as it gives a handle to the GPU
> >> memory. What you want is to get the P2P pages either directly from the
> >> DMABUF or via pin_user_pages() on the DMABUF's mmap.
> >>
> >>> AFAICT, all the concerns brought up in this thread are sidestepped by
> >>> using p2pdma. I need not allocate struct pages in the core dma-buf
> >>> code anymore (or anywhere), and I need not allocate pgmaps. I would
> >>> just re-use the p2pdma support.
> >> Well, as I said it is going to be a big ask to P2P enable any of the
> >> DRM drivers.
> >>
> >> And you still have the netmem vs zone_device struct page conflict to
> >> figure out
> >>
> >> But it is alot closer to reasonable than this RFC.
> >>
> >> Jason
>


--=20
Thanks,
Mina
