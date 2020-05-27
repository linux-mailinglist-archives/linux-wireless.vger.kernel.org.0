Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6771E4B05
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgE0Qw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbgE0Qw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 12:52:28 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EEC05BD1E
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 09:52:27 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id r128so11921775ybc.6
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzdKuie1lpAUIhxu1Qk563DrbvZaYEipoAeRUCadSIo=;
        b=aLO8DPF/uZ9AIERRZelAHA13aIEgAL0i2E2SXMl6EnV86Ft+hjwVugEU1U9x8UAT3A
         VlnWEnUdZF4J2qaVLg52z6WXfDyqJ00kTVUNXkJFSqEvulMIAJYl1C6PeKcNT8gJBw7p
         3rxSdEnaJeS3BcUDB1HyGlYKDWsvZxzxoKLRdufl981ZyalvBRGb8o0ccm6f3ZBpx0AN
         QHyTtjBnBq7t6EO6U0oCixGg1Xn/stWIrOEs7xElSScW0ul0w98c0k9MMUYPFwgYYyDR
         zXPpF9lKoUvYWzVFoGufLOqtXygC6+fxXxDIfeXP5kPVpqg6rB1Q0oS8Jep+rA4Gu7LS
         XrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzdKuie1lpAUIhxu1Qk563DrbvZaYEipoAeRUCadSIo=;
        b=OrlGxplqsDYp5L57gtZGWO1RWt9Y/oEat2J84/xSX/2W+bgqAyiHzjNwpVT+4h77c5
         TRWTFzsekUHXMts8z//N0PD7f+HPnzJUzZtMDYxmibESNafstWppClkJ9ygr18xHB0lE
         8FzQQMU2RqFjl4z1K2a5nI5APOfRjogW0KNpYsgYzNP6MR3bTqSCpYnX5/+gCH2qw1Bq
         zFtBGHTMzChqTRelpSaStdhCx2WxrVQXdBQYU005W9Dn59fpdVQnd15Ea5HdDbZO8Ief
         d54Dxaoc2DCTHlJ8VvakjrnWuvz3PoCY1prl3YH8hga/Jn4fY8jLReqHdl3AxjcM8ECl
         raqw==
X-Gm-Message-State: AOAM532+zkGfBJsPfUxcYfGgav+MwR0cwe/+u2l1iTcv9TtQ+oJn9ypp
        Xn5ZcJpwfO05pkNLihb/NpQEGqgHKqiXgfB/+94fUg==
X-Google-Smtp-Source: ABdhPJwtq2/krYXdh//Crzg4CimpxPvdfn9fcCuqY9UWVmiObMO00zyQCqnOvAZJV3hd0xA61T8akvcqOk1p89ZWHA4=
X-Received: by 2002:a25:1484:: with SMTP id 126mr11002536ybu.380.1590598346000;
 Wed, 27 May 2020 09:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <EED43E20-9B88-42EC-80B0-0245F0FAF980@gmail.com> <20200527133301.GL22511@kadam>
In-Reply-To: <20200527133301.GL22511@kadam>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 27 May 2020 09:52:14 -0700
Message-ID: <CANn89i+Pv6ANBWx-wy-aRXsPgDs=ERzumBvB2g3xiC7OfXXGwA@mail.gmail.com>
Subject: Re: [PATCH resend] airo: Fix read overflow in mpi_send_packet()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Hu Jiahui <kirin.say@gmail.com>,
        Security Officers <security@kernel.org>,
        linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 27, 2020 at 6:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The problem is that we always copy a minimum of ETH_ZLEN (60) bytes from
> skb->data even when skb->len is less than ETH_ZLEN so it leads to a read
> overflow.
>
> The fix for is to pad skb->data with zeroes so that it's never less than
> ETH_ZLEN bytes.
>
> c: <stable@vger.kernel.org>
> Reported-by: Hu Jiahui <kirin.say@gmail.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Resending to the public lists so that it can go through the normal
> review process.
>
> My other concern with this driver is why is the ->max_mtu 2400 when it
> looks like we are allocating PKTSIZE (1840) byte buffers to hold it in
> mpi_map_card()?  I don't fully understand the code but that seems like
> it could be a buffer overflow as well.  I'm not sure what the
> appropriate fix is for that.
>
>  drivers/net/wireless/cisco/airo.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> index 8363f91df7ea7..7c5634f72cc72 100644
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -1925,6 +1925,11 @@ static netdev_tx_t mpi_start_xmit(struct sk_buff *skb,
>                 airo_print_err(dev->name, "%s: skb == NULL!",__func__);
>                 return NETDEV_TX_OK;
>         }
> +       if (skb->len < ETH_ZLEN) {

No need to duplicate the test.

Just use

       if (skb_padto(skb, ETH_ZLEN)) {
              dev->stats.tx_dropped++;
              return NETDEV_TX_OK;
       }

> +               if (skb_padto(skb, ETH_ZLEN))
> +                       return NETDEV_TX_OK;
> +       }
> +
>         npacks = skb_queue_len (&ai->txq);
>
>         if (npacks >= MAXTXQ - 1) {
> @@ -1975,8 +1980,7 @@ static int mpi_send_packet (struct net_device *dev)
>                 return 0;
>         }
>
> -       /* check min length*/
> -       len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
> +       len = skb->len;
>         buffer = skb->data;
>
>         ai->txfids[0].tx_desc.offset = 0;
> --
> 2.26.2
