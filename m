Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DC97496D6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jul 2023 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGFHyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jul 2023 03:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGFHyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jul 2023 03:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F61BD2
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jul 2023 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688630038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKBmnBKEUa4kIHIIVbn3CB8RgCuJtdcen85aZwjfZ9A=;
        b=cgO3Ao/QwYvJ2gp93evs9d4JOUhKcAp3PjrDd4AOOxKnH163FMYi51np9OMZTsf/jKeR4K
        j1YW0KBcRdfqqkbN0I2p19aR2HXFcItM0jI69gnx/mgizMqMhWFCAu/Nn91PkcHhmccooh
        V5URG8tOXga6GG3ql/3TnnHXDfc5H5w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-X65RF8fSN-6__n_3H2n0uw-1; Thu, 06 Jul 2023 03:53:57 -0400
X-MC-Unique: X65RF8fSN-6__n_3H2n0uw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635eb5b04e1so1466396d6.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jul 2023 00:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630036; x=1691222036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKBmnBKEUa4kIHIIVbn3CB8RgCuJtdcen85aZwjfZ9A=;
        b=iyoo3l7tz7m7hDpvrzFzpmiBL2jYJf/0qTfNm3rL54+xgaZk0aYZ3yoUQl3WE925nb
         fKpHecxafR8emyf4zormMWA1ayo/TbvKcqOLHqyI2C04ofLKDUmchdCOSkWD/Yd9rW9v
         Erdco5/YVeMDDbJpKLVPAPFp7tSD9keABR0mUhBNggRhix2NP7LS2c/QeSBTebuqSIoC
         oMlWLvnLefrArebtZ2KMpkz4X5+sbnqD0cxaQ1jslY0I/8Gv4bU7rHCqVdq6t9Xa8IwY
         ySiCdmEmDgnb7QHvm45Ff6DXNBWXivvxvKZb3mwC5FeLR9TQO/YWfG3QX4egJ958cvSu
         F97g==
X-Gm-Message-State: ABy/qLZKqYC+fbgLVJhKhzQIDdv+8VyYdoRLF7IjtaGPeQSEGcFH1gcV
        FsMrQEjXLGa6ysi6nOm1YiJc8iobIdIV8zQJBLzs0q9d9TjeuZWtAhnwXRftGxO5aXbpNppn3NA
        rh8bd2kagQZ9zzy1ytA6YF1R28Efjuuym5WE=
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr1165915qvb.6.1688630036748;
        Thu, 06 Jul 2023 00:53:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7pglwfQF4xq5TglIJ6uR2vClIsuu/IvhrP/6YsBkTnQXWu6b64dYBkJzMsfFw8ae0u5QZwA==
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr1165900qvb.6.1688630036501;
        Thu, 06 Jul 2023 00:53:56 -0700 (PDT)
Received: from gerbillo.redhat.com (host-95-248-55-118.retail.telecomitalia.it. [95.248.55.118])
        by smtp.gmail.com with ESMTPSA id g30-20020a0caade000000b00637615a1f33sm579065qvb.20.2023.07.06.00.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 00:53:56 -0700 (PDT)
Message-ID: <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
Subject: Re: [PATCH] net: wireless: cisco: Fix possible uninit bug
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yu Hao <yhao016@ucr.edu>, kvalo@kernel.org, keescook@chromium.org,
        gustavoars@kernel.org, Jason@zx2c4.com,
        linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Jul 2023 09:53:53 +0200
In-Reply-To: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
References: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-07-04 at 16:50 -0700, Yu Hao wrote:
> The struct cap_rid should be initialized by function readCapabilityRid.
> However, there is not return value check. Iit is possible that
> the function readCapabilityRid returns error code and cap_rid.softCap
> is not initialized. But there is a read later for this field.
>=20
> Signed-off-by: Yu Hao <yhao016@ucr.edu>
> ---
>  drivers/net/wireless/cisco/airo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/cisco/airo.c
> b/drivers/net/wireless/cisco/airo.c
> index 7c4cc5f5e1eb..b3736d76a5d5 100644
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -6950,8 +6950,11 @@ static int airo_get_range(struct net_device *dev,
>     CapabilityRid cap_rid;      /* Card capability info */
>     int     i;
>     int     k;
> +   int     status;
>=20
> -   readCapabilityRid(local, &cap_rid, 1);
> +   status =3D readCapabilityRid(local, &cap_rid, 1);
> +   if (status !=3D SUCCESS)
> +       return ERROR;

This value is returned directly to the network stack, you must use a
standard error code instead (e.g. -EINVAL).

Also, please add a suitable 'Fixes' tag, thanks!

Paolo

