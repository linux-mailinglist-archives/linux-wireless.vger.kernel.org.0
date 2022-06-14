Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCFF54A88C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jun 2022 07:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiFNFHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jun 2022 01:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFNFHS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jun 2022 01:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77D163A5C5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655183236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGvImExXlnUvkSpclN++7AJoDvqpEU5Yxt0bwUxlgmk=;
        b=KfZdpShVQhaSU/DyfDmhiYRHq0FSE4btUHTVlFedGs3ODoDygF72SBH6I0sD7S5jmpBkb0
        3VAhyoMkPmqEWjFCtDJ3Exui+8chyBFzcDsC4L+D2XNYDmB1OyNxgSqxX+kmerY7NC9Xnp
        P/zwGlQ8EjD3ZKcerPL9wTslmUg4HIs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-ZaIbwpIgMEWGVLQJDToipA-1; Tue, 14 Jun 2022 01:07:13 -0400
X-MC-Unique: ZaIbwpIgMEWGVLQJDToipA-1
Received: by mail-lf1-f70.google.com with SMTP id u5-20020a056512128500b00479784f526cso3987225lfs.13
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 22:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGvImExXlnUvkSpclN++7AJoDvqpEU5Yxt0bwUxlgmk=;
        b=Lq0DtQ70QpyviPULciUr7S3vLDlROX1xb6Bemh8uY8TPLeV0IsCnsJqxgZJYrM1oRY
         En4/eWyUyOouPtevXgehueM0fAdL0EhxSLTAZffl3GP/v32NDwJg59BYLCz6LFakOMBf
         utgKnlKpt7yQNcJNytnkxNYQ0QDxpGIEEeLM0BtynXoEHs3N6j210rStTH8MmkbX3NIX
         thM7tW6xH1iNQPTuxaY5dBhH7TELdhscUq5Czz5jmfPPpHL3ZkOfiNjHD3kb38E1HStf
         kbo9reAcIiA9oia/AGaJnOK+Lf7sRkZQTnCKeUZ/OTor/sIiVtcemsqvRC8yjS90xs7G
         JLGA==
X-Gm-Message-State: AJIora9pZgT5+FMeG5QBUxKIx5tibr/PJrr/Uzu6sZe3wHPlZ3c/xfRw
        ZymuUYfRpy+TVV3OFxHqVfKKGWGg/oi0+1Pibf7G6COE/kgInSGHtzZNCSQl9h7rp1ZvtJUUa8E
        8eQnsZ46x5Bakp5snCIeqZt4rmnUQltNx6R5EOL82KLs=
X-Received: by 2002:a05:651c:88f:b0:253:f747:2fd8 with SMTP id d15-20020a05651c088f00b00253f7472fd8mr1483822ljq.496.1655183231470;
        Mon, 13 Jun 2022 22:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sfdKuwTBBRBTaa7sl2k2KiAuTiEB8/sb1ytEdtUtElSmFjVEiJ++BL1Ov7aEhUWJV44v6OdG4WMjqySXOheJU=
X-Received: by 2002:a05:651c:88f:b0:253:f747:2fd8 with SMTP id
 d15-20020a05651c088f00b00253f7472fd8mr1483811ljq.496.1655183231260; Mon, 13
 Jun 2022 22:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220613210401.327958-1-johannes@sipsolutions.net>
In-Reply-To: <20220613210401.327958-1-johannes@sipsolutions.net>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Jun 2022 13:07:00 +0800
Message-ID: <CACGkMEv-2U7TSkqLEOr=pd9MH8h=CEFzk0CtX1gao2CO2x0PJw@mail.gmail.com>
Subject: Re: [PATCH] mac80211_hwsim: set virtio device ready in probe()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 14, 2022 at 5:04 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Just like a similar commit to arch/um/drivers/virt-pci.c, call
> virtio_device_ready() to make this driver work after commit
> b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses
> the virtqueues in the probe function.  (The virtio core sets
> the device ready when probe returns.)
>
> Change-Id: I617d3b819b5e5345471a8e79db25342981a92424
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Fixes: 5d44fe7c9808 ("mac80211_hwsim: add frame transmission support over virtio")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/net/wireless/mac80211_hwsim.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
> index 02108b94d6b8..d2b31595856d 100644
> --- a/drivers/net/wireless/mac80211_hwsim.c
> +++ b/drivers/net/wireless/mac80211_hwsim.c
> @@ -4951,6 +4951,8 @@ static int hwsim_virtio_probe(struct virtio_device *vdev)
>         if (err)
>                 return err;
>
> +       virtio_device_ready(vdev);
> +
>         err = fill_vq(hwsim_vqs[HWSIM_VQ_RX]);
>         if (err)
>                 goto out_remove;
> --
> 2.36.1
>

