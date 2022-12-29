Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F16658918
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 04:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiL2DSo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 22:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL2DSk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 22:18:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6030B12AA3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 19:18:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vm8so35464070ejc.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 19:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQjOB5B01aZSP+KDmUzckGQ1EdxHEUJXPsuvKdxAAhc=;
        b=PdjoZsXrAbOS1/xa6TCteBTwDzABnbmV0lgQCWUepOu1u7YAgUf2rP67OmAhJw0S8b
         gtN81faWTC+JSVcCwIwnjbmKOnk7uEFWFMY/4Q7TjFb43/XY83KTvTmEiQ1YmjEK0u/x
         qXo+j+86eXYlKTJDb8rKJlMLcj0DCyvvsHaR6B3z3cdb03vKejM66qaRrlWLoLJkAczd
         O+kW47zD0f3H62acrwMVyiVh1zwvQe3cRsVR6/1adlzOIT5y2u2JPDw/NoA8XfnknCOb
         pNRsXze2NqQot+ScjCr1nTWU1wSMA1gI6X45HYOMB4xCcdU3iau09WEIBGU6VTLq+FlL
         DIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQjOB5B01aZSP+KDmUzckGQ1EdxHEUJXPsuvKdxAAhc=;
        b=zR4iRpCuwhnkBAerih0zVAW2oAc5gs/SrKTTyY3waHrihWAude5Lz+PzEZK9OtXgmS
         0oIJzJ+b/8jRB1ZNhZyIjlJ9J8ZfjlWCrAXHIuAqUnO3NL/wri/9aMX+0eaW4I45Lh2B
         ni1m7gljcUnUvVHllD0oLYp/rXf4Dp9wzD5vuIJ5IMraV+rRuIddXgJwn4v60MpNuV+f
         JzUcSpDAYptMXPYxxS1ub52zMJ5qvqmX23AbWdKe0SMHDrBH5VukhnfdVKXWY7yvd8mZ
         cOaCMHLDsT9DNsBVKazaMIikQ2ksYjGeyBjqEHBwOZQjT3EqR0HrPQRvc2i1phyoKhsO
         nlsw==
X-Gm-Message-State: AFqh2kpecX8JIqmR/kkHU7atlpdmIATIXBCj0PZ2h+DEsMP11a3icmzG
        8TGPSSBsQHYb0rjTgECpLzkes38od5dmDm2bUYOhg7PlmEOqZ/CE
X-Google-Smtp-Source: AMrXdXsGR0Gkta0M+rcBCtwKP3TQYRjYgwljonBWbXrh3h5kDPl7eiToT46pHbkoXVpg+NrpT1TVFZYImRwoqx8LSsM=
X-Received: by 2002:a17:907:80c6:b0:78d:4cdf:b40a with SMTP id
 io6-20020a17090780c600b0078d4cdfb40amr2057099ejc.102.1672283916982; Wed, 28
 Dec 2022 19:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20221206114609.2006175-1-yangyingliang@huawei.com> <20221206114609.2006175-5-yangyingliang@huawei.com>
In-Reply-To: <20221206114609.2006175-5-yangyingliang@huawei.com>
From:   Info Skymem <info@skymem.com>
Date:   Thu, 29 Dec 2022 04:18:25 +0100
Message-ID: <CAKvd=_ikEBFk080XoegEzH-JNM6ZuCLMzGL2ZqRzxyVLJCX9-Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] libertas: don't call kfree_skb() under
 spin_lock_irqsave() in lbs_mac_event_disconnected()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     kvalo@kernel.org, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
thank you for your information.

On our website you can find email addresses of companies and people.
https://www.skymem.info

In short, it=E2=80=99s like Google for emails.

Best regards,
Robert,
Skymem team

On Tue, Dec 6, 2022 at 12:49 PM Yang Yingliang <yangyingliang@huawei.com> w=
rote:
>
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. So replace kfree_skb()
> with dev_kfree_skb_irq() under spin_lock_irqsave().
>
> Fixes: f52b041aed77 ("libertas: Add spinlock to avoid race condition")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/wireless/marvell/libertas/cmdresp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/libertas/cmdresp.c b/drivers/ne=
t/wireless/marvell/libertas/cmdresp.c
> index cb515c5584c1..74cb7551f427 100644
> --- a/drivers/net/wireless/marvell/libertas/cmdresp.c
> +++ b/drivers/net/wireless/marvell/libertas/cmdresp.c
> @@ -48,7 +48,7 @@ void lbs_mac_event_disconnected(struct lbs_private *pri=
v,
>
>         /* Free Tx and Rx packets */
>         spin_lock_irqsave(&priv->driver_lock, flags);
> -       kfree_skb(priv->currenttxskb);
> +       dev_kfree_skb_irq(priv->currenttxskb);
>         priv->currenttxskb =3D NULL;
>         priv->tx_pending_len =3D 0;
>         spin_unlock_irqrestore(&priv->driver_lock, flags);
> --
> 2.25.1
>
>
> _______________________________________________
> libertas-dev mailing list
> libertas-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/libertas-dev
