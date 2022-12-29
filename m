Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB5F65891B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 04:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiL2DT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 22:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiL2DT4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 22:19:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837512ABF
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 19:19:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r26so19942593edc.5
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 19:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d38/b2KTwDAwbScek7qgp9klFDsIPElRWHJr1fH5CaA=;
        b=cREynCZYh0eCGLSUV6WaSc2VXWktfl+04WGsBPv3yB+nFfdpVncl1wijPH3gxryavX
         8p1ypg4STZgvP4gt1HHJt3bkEJZGXAsJLKi3QCRwC/mmaTNgwAd3eKjqy4/xAjDwno6Q
         ysme6jWJDnPn1R5xXGf8Y3OY/kUhLHDR4XndHDxj6NtEJjiy6EPovTggpYFTIckcs1gv
         VuJ/92he1rF0FveIOjrDgfEBiU1sVrTpag0Szb018HHN5xJ4SJTlaTY5MYQMw8BhKqgW
         SrY7H7711hoz/q4w536tdPp91txB8bOJExwzpXRzpd8hXzJPay/W9ki7GULUCvV18hb1
         joqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d38/b2KTwDAwbScek7qgp9klFDsIPElRWHJr1fH5CaA=;
        b=UqB4d5TYJ60ig7JE2ATH9VN8zV3qv0lEzcVzzT4AkW9gQAkO/9tQfexitbCW/+y9Ph
         uw91nZgNx7bCedlFva4Z2sFdZvLCZj0XBSb1hUsNta7fIcM3k1uAVxB739cK2E4h7Ql+
         0HEjy5NpP8G0bl3H17czK1QszKBpSXwb4tKQB0usQwJw79jrL0hAwrFV+Hth4PgB8vSl
         jGx0D83HKkmth3kQL0I3RhowaDf2OSt+l2yFM9bvR6puxAAkXkqsQmJT6WHHmAGSb6Gd
         sDh1hpFAczQGs3hLQq3CjeIRRKNYXIkZ+YOLI7S3eQsbXLzN5ZYihGwnDEiubktwcKj4
         UMmg==
X-Gm-Message-State: AFqh2kqOQrtmxdoAArl19Cum8t+Ng3YuqtNtw4FFXSBYnySYvYSBL/py
        sZ7HaHyKoDw6EPjb43N1SSNbvFKb9J8LCrPCAQ5JzA==
X-Google-Smtp-Source: AMrXdXuSaQB57NI+Muqiqrli3CsYdKvFpvvRKjlfWdHzmxdgaQJb8ftl6kJTP10iGzEKQ5nqGG4ylYtwVFApVUNrCiw=
X-Received: by 2002:a05:6402:2996:b0:461:c563:defa with SMTP id
 eq22-20020a056402299600b00461c563defamr2261931edb.72.1672283994347; Wed, 28
 Dec 2022 19:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20221207150008.111743-1-yangyingliang@huawei.com> <20221207150008.111743-3-yangyingliang@huawei.com>
In-Reply-To: <20221207150008.111743-3-yangyingliang@huawei.com>
From:   Info Skymem <info@skymem.com>
Date:   Thu, 29 Dec 2022 04:19:43 +0100
Message-ID: <CAKvd=_hycVYc-dh=wWwOh1XrpdmT82TrvYd_bxXu6ou2H6TGDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] libertas/if_usb: don't call kfree_skb() under spin_lock_irqsave()
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

On Wed, Dec 7, 2022 at 4:04 PM Yang Yingliang <yangyingliang@huawei.com> wr=
ote:
>
> It is not allowed to call kfree_skb() from hardware interrupt
> context or with interrupts being disabled. So replace kfree_skb()
> with dev_kfree_skb_irq() under spin_lock_irqsave(). Compile
> tested only.
>
> Fixes: a3128feef6d5 ("libertas: use irqsave() in USB's complete callback"=
)
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/wireless/marvell/libertas/if_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net=
/wireless/marvell/libertas/if_usb.c
> index 32fdc4150b60..2240b4db8c03 100644
> --- a/drivers/net/wireless/marvell/libertas/if_usb.c
> +++ b/drivers/net/wireless/marvell/libertas/if_usb.c
> @@ -637,7 +637,7 @@ static inline void process_cmdrequest(int recvlength,=
 uint8_t *recvbuff,
>         priv->resp_len[i] =3D (recvlength - MESSAGE_HEADER_LEN);
>         memcpy(priv->resp_buf[i], recvbuff + MESSAGE_HEADER_LEN,
>                 priv->resp_len[i]);
> -       kfree_skb(skb);
> +       dev_kfree_skb_irq(skb);
>         lbs_notify_command_response(priv, i);
>
>         spin_unlock_irqrestore(&priv->driver_lock, flags);
> --
> 2.25.1
>
>
> _______________________________________________
> libertas-dev mailing list
> libertas-dev@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/libertas-dev
