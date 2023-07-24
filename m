Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88A75FC13
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGXQ3O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGXQ3N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 12:29:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8919A5
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 09:29:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-403aa5d07caso33056791cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690216142; x=1690820942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvqRTgPMkZyyUJ/eYLri/dywvbqF1gq/yURWmZL7/6A=;
        b=JTxlLwpY4B+RxCOA0IT7t0KJtuxqOdUcLBueZqYEwWOGw9vBGNalO2vfSLeha3sDww
         n23Q2fVF4XLsfCIJ7N2XehDqaKBLbFDRIYGVwcF+/T7FO8WCJIaZAFVHoCu1+ADDppdF
         J9P/yTyeIu5AmCy7TmwinJWEhwXoPIvY6iS4xyJbx11IBdrOHgxK1FhlslIywkd4rYkp
         okaSM9B557rsg+oZkzb0HeYzVvEpn2XAqbqS5qz2+aMG/7oTJ1rGBYMonxeaOuyrzZNF
         ondYg2tvzr8bwYJY2FCAZSKUQnd5qWVtvwL/Mlli9wvr3A4647ZiN6lPyW1GLHxw+hpU
         9CGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216142; x=1690820942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvqRTgPMkZyyUJ/eYLri/dywvbqF1gq/yURWmZL7/6A=;
        b=PsBMMsPALS5VwO0Uv+EvCImz/XLNyOxIaNaxz9v6shnJbCVyCwZpDleTcH1bWxE3+r
         2Ou2B8jtAFSGu4a0gyYXBgFfnWHh+7G1e2yH2e3AlYZJVNHaQZ7XWfbQKlBryYjmeFOh
         +CE1qtTErw90AdLpIF8obLIMrOr4dcjwvNXI+YCp3Y+ZDvCHlY34pv7wQV46G5q6Tgkh
         cOT2PQ+uRRDqbqR8SkXrdEzU2gAXlG5Z5LL99flJMNs4sA8s6KR1a+WR5grzFyZnVc9H
         pfhaK7jq3xhCSnCmIyNhzirPcnShBnLxw5T1d3YjShH6aeVeToxV3NX7dTG4YpmK0phv
         N36Q==
X-Gm-Message-State: ABy/qLY66nBoPEcriSHTJONCVD9Wumz6WyTGH77SY3AEp6P1806hHuIB
        WH2WIqK/bBuvsF1wk/6ZCU+pFA==
X-Google-Smtp-Source: APBJJlEqioDGur2hWJN/oBxGPx39JbASLwLrWEnz70ekshKDJ87a6G6epx0cyhvpPQhxk2uV+XsBHg==
X-Received: by 2002:a0c:de0a:0:b0:63c:ee13:5adb with SMTP id t10-20020a0cde0a000000b0063cee135adbmr268559qvk.47.1690216141736;
        Mon, 24 Jul 2023 09:29:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id r12-20020a0ccc0c000000b0063003786840sm3659258qvk.99.2023.07.24.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:29:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qNyQd-000K2X-UT;
        Mon, 24 Jul 2023 13:28:59 -0300
Date:   Mon, 24 Jul 2023 13:28:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Mina Almasry <almasrymina@google.com>, brouer@redhat.com,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>,
        David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
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
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <ZL6my550xedf/L0Z@ziepe.ca>
References: <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca>
 <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
 <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
 <ZLFv2PIgdeH8gKmh@ziepe.ca>
 <CAHS8izNMB-H3w0CE9kj6hT5q_F6_XJy_X_HtZwmisOEDhp31yg@mail.gmail.com>
 <a2569132-393e-0149-f76c-f6de282e1c96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2569132-393e-0149-f76c-f6de282e1c96@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 24, 2023 at 04:56:27PM +0200, Jesper Dangaard Brouer wrote:

> These massive throughput numbers are important, because they *exceed*
> the physical host RAM/DIMM memory speeds.

That's right, this HW is all designed to use the high memory bandwidth
of the parallel GPUs. The CPU must not be involved in the data
movement.

If you look at the reference block diagrams for a DGX-H100 you can see
that the each GPU is directly wired to a 400Gb/s NIC, and there is
even software that allows the GPU to directly operate its attached
NIC interface.

Each of the 8 GPUs in the block diagram has 800 Gb/s full duplex RDMA,
and 7200 Gb/sec full duplex on the nvlink interconnect directly
connected to it.

The GPU is the center of all the interconnect in these systems.

Jason
