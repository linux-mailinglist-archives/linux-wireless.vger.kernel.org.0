Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51112E43E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfE2SMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 14:12:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37172 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfE2SMK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 14:12:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so3805560qtk.4
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2019 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ViODfuhWnYhc2s3Kjea5F7ZIJ8Ml/xHbr11ntjMzkwg=;
        b=hfFSlTtHf223et1zp+zz4Fft/wcc9MB9YlSBND/88dfUQDV8o2hrr8X077o4+DX6ED
         udJQ5BVvWDtu+f6v77bjmSJs3N8kmDv1b8CcUXlmCK5qpnJ6oq3RdjEBuDIy7ASj/h3h
         bQotgD7n8ejIKLbCXzWI+Y0OpPIwp2Q9apDj4WQ9pVWRWzrdQiuWvkX4H6x4VVuzdvXn
         kR1Y5GSMkhLNnC1Nfr9mteFhaFil97va81T/sy/2voPtFc4bvg/5QcHaimDLYorXtqY6
         db08Zg5JLqly5ozBatzETFl0Ec7JdDrI4R8CtxgVM06U/oseASC6mHza1fefFRzXZIuw
         lGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ViODfuhWnYhc2s3Kjea5F7ZIJ8Ml/xHbr11ntjMzkwg=;
        b=uJvcLkrQ494DTFp/mnKovJsIVLeqytehNY09yLQhJ6qbfzd3OnFXMZ6PGmZbBQHmTr
         eLKVZEvUZJ9xsf+TS9b27LqBktwHZa9/LNdTdfsib3ypPKyMqXN+CPhWG+XcGJyblx7W
         c1GNFngnVfTw0y6lV/NRxWVa+qR9cQyl1xiL073xhfmG1F829l1FNA0iNM3vKgs3zdQt
         OpdqFDx1XQmTdnxE2JyciclnNh9LoM0+VxRQTLPt2bq3BTznNVl8gntLWWoDh27aoPkW
         bF8Xv/9shz0sGJUOk2jDnDU6sPAPnZNn9ZQLn+v7LuWfvvqjSAdFD9B3J98kXgvwYk2D
         JzPw==
X-Gm-Message-State: APjAAAUy2CN8L5als1B9GKfH+3OHxnME9czVqwC9ip1McN6Z4U3DhkNv
        wsrf9Ke4g3ciaq6OpFaveF7Hb3UzvpODeUzw1zMfBA==
X-Google-Smtp-Source: APXvYqyxAS6nfNEEguifsrx3x6g5lgGT4VyR8//RpwjqFTV2M0Aw3Jpm9dumVCfx0v/V68hCmEGgrHA6vjJNBAlb+LU=
X-Received: by 2002:ac8:6b06:: with SMTP id w6mr5556447qts.80.1559153529538;
 Wed, 29 May 2019 11:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190529050335.72061-1-chiu@endlessm.com>
In-Reply-To: <20190529050335.72061-1-chiu@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 29 May 2019 12:11:58 -0600
Message-ID: <CAD8Lp46on32VgWtCe7WsGHXp3Jk16qTh6saf0Vj0Y4Ry5z1n7g@mail.gmail.com>
Subject: Re: [RFC PATCH v3] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Chris,

On Tue, May 28, 2019 at 11:03 PM Chris Chiu <chiu@endlessm.com> wrote:
> +       /*
> +        * Single virtual interface permitted since the driver supports STATION
> +        * mode only.

I think you can be a bit more explicit by saying e.g.:

Only one virtual interface permitted because only STA mode is
supported and no iface_combinations are provided.

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 039e5ca9d2e4..2d612c2df5b2 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4345,7 +4345,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
>         h2c.b_macid_cfg.ramask3 = (ramask >> 24) & 0xff;
>
>         h2c.ramask.arg = 0x80;
> -       h2c.b_macid_cfg.data1 = 0;
> +       h2c.b_macid_cfg.data1 = priv->ratr_index;

I think ratr_index can be moved to be a function parameter of the
update_rate_mask function. It looks like all callsites already know
which value they want to set. Then you don't have to store it in the
priv structure.

> @@ -5471,6 +5509,10 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>
>         switch (vif->type) {
>         case NL80211_IFTYPE_STATION:
> +               if (!priv->vif)
> +                       priv->vif = vif;
> +               else
> +                       return -EOPNOTSUPP;
>                 rtl8xxxu_stop_tx_beacon(priv);

rtl8xxxu_remove_interface should also set priv->vif back to NULL.

> @@ -6183,6 +6259,8 @@ static void rtl8xxxu_disconnect(struct usb_interface *interface)
>         mutex_destroy(&priv->usb_buf_mutex);
>         mutex_destroy(&priv->h2c_mutex);
>
> +       cancel_delayed_work_sync(&priv->ra_watchdog);

Given that the work was started in rtl8xxxu_start, I think it should
be cancelled in rtl8xxxu_stop() instead.

Daniel
