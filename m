Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9151774CA19
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 04:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGJCxz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 22:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGJCxy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 22:53:54 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jul 2023 19:53:53 PDT
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A9126
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jul 2023 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688957634; x=1720493634;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=81s/g0szo3YqoqeNAsHyknwaB3cC/IHDl8+zCGik79U=;
  b=hBc7HlBBok/TEJW6d98mXFtZHspwT7LBLZCgPDGlEESTrbvPWJNugRcb
   9PgHWcUHbQ781VI4pvQeFjXOw4ILsB4gzmD1y9QcBKNBdPA3Yd/SMPVnm
   pVgYYoqqdfEl9Q5svEqJIUqX1qR1m+R8rXvHJvyxBZ0VQ2NNfhxqhkHEm
   B/HWXViXdgErsaPZiE3kKIngN8RiPikEsKcThXNRAhX2u0/2eKjuL1ER7
   EOhL8EJonQ5gZekISRBcCRPnAoG+Md+EkdDI23M2ZKNalAl92X8PrOTTd
   LNNDQJ/TgyG4cpmX8JiKmN4batK/XFGnXjOFxpHqryl6BlibpnemYqO6R
   A==;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2023 19:52:50 -0700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-314394a798dso1830236f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jul 2023 19:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688957567; x=1691549567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k9sNy74+QzQoMmro40H1gRC7AOP1wY8QwqFhYNQlm8=;
        b=wVFHQ7R+R6aQ9RStN/XTqOK9UecFL/n/YyciGqdtjR3SjjkewQaUJpAfE2HVKh7CL4
         DYLMrymgHk/1JmL2kWA107TXaoPmuiEyIg6EvFsdraMVt+x4KXpUTGg1zbmnQWQpP1uc
         0EUsbXovZyDqU7P+7tpnBz8lFSrQz+GKqduvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688957567; x=1691549567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k9sNy74+QzQoMmro40H1gRC7AOP1wY8QwqFhYNQlm8=;
        b=ciNZ6Sha3zvAg+qhs9dp2qSienGuaY7MJT+SdhVC3MHYlVYttA7aelm/dbjLG3u0KU
         s3TaeFIHq6rHwdWMghiYwikEib3PC+CpcdKAfFibPzMilrXFEsOHb61xXGKi1Izb2P4K
         GsOF6NKqWvjn3M2b4XE3RFhunsicCefHOk+gEVw/kxKvPJNrSqlyEqblw21cF7ELXdLF
         kvwMDvpQDzqr+fFh/ozK6IFdd2z6fnW558p8eDJwsDk3Z+yW0QaWxBS95CHmIDt32vVn
         MB6T8UbMGlPcUa1SBwx6BcGLnCepd+8Q8pUf0lt7RXgk/T9PIS/RrAOHz5nvG/2PWWKe
         zOBQ==
X-Gm-Message-State: ABy/qLbsaWSold5/3QFVsTmcybMPUSuXIhkhed9aexJRZy7H8LMa3mwN
        p1sQZJ97uxp+t3hYXU+wOu1r3jc7hhTmnoul9JZfOKL+KA2HqDj8ZAzYSB4oaBxRlHtKq8qcfb8
        gm708hcBhOqkHN9xrXuqs7HEII32F8sR19HwXxy0LY50N
X-Received: by 2002:a5d:4ec6:0:b0:313:e391:e492 with SMTP id s6-20020a5d4ec6000000b00313e391e492mr10012798wrv.17.1688957567439;
        Sun, 09 Jul 2023 19:52:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHam+aDebvhumMMgkhgf6P6bFx86kMlMA6n+IUwkhnAapTFQYABBfRdkN4liHbnkyQANIDiKlxS14QAThsHSu8=
X-Received: by 2002:a5d:4ec6:0:b0:313:e391:e492 with SMTP id
 s6-20020a5d4ec6000000b00313e391e492mr10012792wrv.17.1688957567124; Sun, 09
 Jul 2023 19:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
 <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
In-Reply-To: <a8c6e741a9c704dad9b63e1e85136a8e6da09b44.camel@redhat.com>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Sun, 9 Jul 2023 19:52:36 -0700
Message-ID: <CA+UBctANALC+FdNf+0v+hFZS5RPry=44LF3HQWKMYCxibgb_vw@mail.gmail.com>
Subject: Re: [PATCH] net: wireless: cisco: Fix possible uninit bug
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     kvalo@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
        Jason@zx2c4.com, linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sure.

I found that the related code is from Linux-2.6.12-rc2.
In this situation, the 'Fixes' tag should be 'Fixes: 1da177e4c3f4
("Linux-2.6.12-rc2")'?

Yu Hao

On Thu, Jul 6, 2023 at 12:54=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2023-07-04 at 16:50 -0700, Yu Hao wrote:
> > The struct cap_rid should be initialized by function readCapabilityRid.
> > However, there is not return value check. Iit is possible that
> > the function readCapabilityRid returns error code and cap_rid.softCap
> > is not initialized. But there is a read later for this field.
> >
> > Signed-off-by: Yu Hao <yhao016@ucr.edu>
> > ---
> >  drivers/net/wireless/cisco/airo.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/cisco/airo.c
> > b/drivers/net/wireless/cisco/airo.c
> > index 7c4cc5f5e1eb..b3736d76a5d5 100644
> > --- a/drivers/net/wireless/cisco/airo.c
> > +++ b/drivers/net/wireless/cisco/airo.c
> > @@ -6950,8 +6950,11 @@ static int airo_get_range(struct net_device *dev=
,
> >     CapabilityRid cap_rid;      /* Card capability info */
> >     int     i;
> >     int     k;
> > +   int     status;
> >
> > -   readCapabilityRid(local, &cap_rid, 1);
> > +   status =3D readCapabilityRid(local, &cap_rid, 1);
> > +   if (status !=3D SUCCESS)
> > +       return ERROR;
>
> This value is returned directly to the network stack, you must use a
> standard error code instead (e.g. -EINVAL).
>
> Also, please add a suitable 'Fixes' tag, thanks!
>
> Paolo
>
