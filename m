Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EE874F692
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGKRGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjGKRGn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 13:06:43 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C02A1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 10:06:41 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79492b8f4bbso1984257241.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689095200; x=1691687200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shCkNkuISpAjo0wvso+e9CaqC7Tu4suQbB4adf5Gg28=;
        b=YbbA06X7m0lTKmRD/qrCSPe46OZZXtyoWwxn94R62ChwLlyI4NVTjYPGfo3UBlMajj
         k6fH+Dkqu85y17natO+NnHXFOP3k1pkffPwP4MSk9drst1XGd/0ospwiBvP1V2Cjsp4w
         kqT2TO4HE+d7uUCguJ2ovnNME5Ya6Nu2B2evKvl7BcEp1EWaRJzM466r1a7+Ac3BeOwj
         E0omfNfD0agGLMLbLYeHEb+3aukvUGiEi+9dtdNeOxvp9oOSGBCChkpDj4aW9pT8bT/k
         Sw2KCbmOc1yGOSVjG88PEgzwwiXTrz+H1cyxyuHyDsyfTWNm1JTQjWbMvuxQVExeMj+M
         gipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689095200; x=1691687200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shCkNkuISpAjo0wvso+e9CaqC7Tu4suQbB4adf5Gg28=;
        b=PFKfn8fANcc8OKLLyQKAgLxqojoTJfClrsT9ihWh46d8RqF1bdsBLEW+B0y9Wj/w/m
         F4tHEQiPogQl/9RMElOz4uJoMJDrRAXVi0cNlwD6dxSoAOAhzL80hCMr0tvtZXfITm5F
         /Wu6UOCmEE/owf4zNF/NKoUO+6C/knH2GQzkk38DFAujV8+gQBAzbrw1wvFMoGiff4c2
         OL77EjaZXUlXgQuzHW9E4QBktvT+rmgt9znMOuWXKVfktEk7NiEWA4/eLHDhogV9mYKR
         EgYtWTkCMPbVMBLtVSaOEiuPQOsFnG1OoQieOyrO6rk8eFhT/dX7h1rmqIMNAsfQx7xg
         UPGA==
X-Gm-Message-State: ABy/qLaJ7OTonkxmxIF3ecbOKk7vzm3s9/UtYJXhqmVoDU+ka4pqEtti
        oDMm1RIJvJIubd0vzu0nNSEygIckPIx9iG3RkovuKQ==
X-Google-Smtp-Source: APBJJlHXFNHBs4KDviEzXlES6rfgeVe8nKhN83Gxg+u3ccdWyDygmItRYbBA45O5bC+ajfLgRYLuiJDC4r1zWGlkDaw=
X-Received: by 2002:a67:e34b:0:b0:444:c49c:a95d with SMTP id
 s11-20020a67e34b000000b00444c49ca95dmr7222548vsm.7.1689095200160; Tue, 11 Jul
 2023 10:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca> <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca> <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca> <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org> <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca> <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org> <20230711093224.1bf30ed5@kernel.org>
In-Reply-To: <20230711093224.1bf30ed5@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 11 Jul 2023 10:06:28 -0700
Message-ID: <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
        Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 11, 2023 at 9:32=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Jul 2023 10:20:58 -0600 David Ahern wrote:
> > On 7/11/23 10:00 AM, Jakub Kicinski wrote:
> > >> RDMA works with the AMD and Intel intree drivers using DMABUF withou=
t
> > >> requiring struct pages using the DRM hacky scatterlist approach.
> > > I see, thanks. We need pages primarily for refcounting. Avoiding all
> > > the infamous problems with memory pins. Oh well.
> >
> > io_uring for example already manages the page pinning. An skb flag was
> > added for ZC Tx API to avoid refcounting in the core networking layer.
>
> Right, we can refcount in similar fashion. Still tracking explicitly
> when buffers are handed over to the NIC.
>
> > Any reason not to allow an alternative representation for skb frags tha=
n
> > struct page?
>
> I don't think there's a hard technical reason. We can make it work.

I also think we can switch the representation for skb frags to
something else. However - please do correct me if I'm wrong - I don't
think that is sufficient for device memory TCP. My understanding is
that we also need to modify any NIC drivers that want to use device
memory TCP to understand a new memory type, and the page pool as well
if that's involved. I think in particular modifying the memory type in
all the NIC drivers that want to do device memory TCP is difficult. Do
you think this is feasible?

--
Thanks,
Mina
