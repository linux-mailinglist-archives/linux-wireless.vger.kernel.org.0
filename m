Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3970A658919
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 04:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiL2DSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 22:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL2DSo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 22:18:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C712AA3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 19:18:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c17so25107436edj.13
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 19:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AR5wI9VY+5BGe3w/epomFWgBMRz4Pt8+CJ5GyspjEQ=;
        b=u+qDMyZ3S6BCRuKs4249QFFcEjer3/PpYQ5+D2k/VIDNPSMe/Sm72tMn8ZeXz8FZLB
         U6/xprTkCpytA1KuzX5+DT9m4Gq/mypwJIgp+Y3LHEv49O1c8NO2SBJu4N23V0OOpbAs
         AThC6+vOz8wx3UDdx0KImLjuBR9SP9j6llmJyW8UjQkCcWysIB7S9RjYCwkJM4bhAw7M
         nMfo+Be8ZjoirvuO6gPLpD+0f0bwGRkwecO0uBycggQRmHCy3PgjzCsbeUbFZFVOII5I
         xNihQ4BMb/sZy67+xXGKJBUia9nEULsQFZofyjHu2RhT9lcE6Py8S9zQUXVJve1T9jMN
         QjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AR5wI9VY+5BGe3w/epomFWgBMRz4Pt8+CJ5GyspjEQ=;
        b=k8sOfPN2qNzHUN19bcwLQP90nbto8v5KstpzZp8hXIsGgG/7N3gvPMa5aN54lTr+sh
         n7WLTZIaXGwTX1WvTeGmrgRmQhCxyPfUzxHLAD26frc5zOcFTLOn25q+GShgg2O846z2
         OvG8ipd+Gn0GUuvoH7+iBzP/4sgY/tfN9CUHYPeKYucuPwZlOmhD/ptVcWPnIup2smT9
         xzvFNYUl1CjlDuk9sFxoPhAkU9QQ0eyJV8o/wfxZbEGE0ueFzzxIqQ/nCIiOrbHvQb8c
         7nIBpD8jhEmAtfH9RdlY3VnDNRNoJEV20H8A+z3iIkh+oEyfFbi12SSISV68xnTq0XEN
         /ijw==
X-Gm-Message-State: AFqh2koXo/VF2XvFDdAzRrsY+wyKEXRYlNQVS+mT4Xuwp3l6GpZLL63C
        wwXdsvARNYCfdqBFHEuIkFoo51ns58E0a4+zhlgvTA==
X-Google-Smtp-Source: AMrXdXsLM+qz0dmbeVb2Inu2zZSPSsolDeqpW1NCkR+Ao/4lRHuOb4I/jX6xb/iSzcNTAoEeMSXUPVjccI+8U4vmdNU=
X-Received: by 2002:a05:6402:516b:b0:47e:1b4a:5489 with SMTP id
 d11-20020a056402516b00b0047e1b4a5489mr3237150ede.262.1672283922633; Wed, 28
 Dec 2022 19:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20221206114609.2006175-1-yangyingliang@huawei.com> <20221206114609.2006175-4-yangyingliang@huawei.com>
In-Reply-To: <20221206114609.2006175-4-yangyingliang@huawei.com>
From:   Info Skymem <info@skymem.com>
Date:   Thu, 29 Dec 2022 04:18:31 +0100
Message-ID: <CAKvd=_iVE6nocALPEw8hzTZMm6rAv5PmnBkFiVZ_D-AjRNQeNA@mail.gmail.com>
Subject: Re: [PATCH 3/4] libertas: don't call kfree_skb() under
 spin_lock_irqsave() in lbs_stop_iface()
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
> Fixes: d2e7b3425c47 ("libertas: disable functionality when interface is d=
own")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/wireless/marvell/libertas/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/w=
ireless/marvell/libertas/main.c
> index 8f5220cee112..f42d28d99763 100644
> --- a/drivers/net/wireless/marvell/libertas/main.c
> +++ b/drivers/net/wireless/marvell/libertas/main.c
> @@ -216,7 +216,7 @@ int lbs_stop_iface(struct lbs_private *priv)
>
>         spin_lock_irqsave(&priv->driver_lock, flags);
>         priv->iface_running =3D false;
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
