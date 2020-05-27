Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81D11E4CD7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 20:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391876AbgE0SIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 14:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391703AbgE0SIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 14:08:14 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ABFC03E97D
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 11:08:14 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id g39so6256102ybe.7
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=az36+VEEhMF1p2T3V/nE9Cjv2UZTzI3VDCbfw5ZKcrs=;
        b=Ph9JeVX/lmymsfJ+4K+9KGQT5Hsvp38tXB5poOgNqo+LUqsXHEOuIHDu+gIe39L0Nw
         3KgoCKEOpDYjNUpc0XpbkYPVopBAWSjr/ha7biuQjMTGuzJIwC9z5xwqbs44SLFpRL8Q
         E/vEE5VCahSbPx1dmU2PmT3Sq5z+vq+0nVRZfa0AV1I5ojYk/DxEiU/uA1XgNUM3GhTh
         MvHtW6UfNt4DRqwVRHmCyD8PtVD+1XEOMbyxR5W6AGhIyVcMkEAkOdHRWscpd1asY9r3
         GApMzsEebogxDMSaBaMQtfjg8b1hyCX2UVQbF+Ew1J87v50XB+mtw1mt/dfTSzRqkPKp
         PrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=az36+VEEhMF1p2T3V/nE9Cjv2UZTzI3VDCbfw5ZKcrs=;
        b=s1kfXXS/38rBhRkv6htx0le72xylGUlswusXh0egI8+32gHc+WpCXNI2coUmq4Zbj3
         iLD7ew1Uw94c9TfTFrVl7Mpedd1pBUrQqc6RZccb3QBwZuc7him3W2YBXgWkl+hX4g2C
         9BFN1p2SuA/GhyyeCoR7x34NHsLuhIJ6cd2EAD64TLV2qV62frkAxCuLY21uiYgb04V/
         r1V66uF/I+JjWjTaonohINWupxDSgexY++VHJ5WipnHa54HKjq0DH8rEYdG0cn6XKm7X
         TTXBHDYdS3UUwWCXvCekkvnDCmViMYq3VU0VWsnezfBiViQZeEz8V+g5vPSs5ZKQzCo2
         mL4Q==
X-Gm-Message-State: AOAM530IF3Hkej0MYKXfc0QX4TUVCDsrwQatF2Y267GN+1tzF+cNUeMq
        MNTXzWaKewd9xeFBM/jgXoI+XT+i2ctbBFsVf4tzWA==
X-Google-Smtp-Source: ABdhPJyyLDPIM2dDHHdeQAkyW76kdq3a56XkIwI2yvc306DcUkhgpSuLD+LPwea4492FvcdUTW2vjV1ODB+hY93WKVQ=
X-Received: by 2002:a25:2504:: with SMTP id l4mr13133395ybl.408.1590602893213;
 Wed, 27 May 2020 11:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89i+Pv6ANBWx-wy-aRXsPgDs=ERzumBvB2g3xiC7OfXXGwA@mail.gmail.com>
 <20200527175808.peynuk7a6webysv3@kili.mountain>
In-Reply-To: <20200527175808.peynuk7a6webysv3@kili.mountain>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 27 May 2020 11:08:01 -0700
Message-ID: <CANn89iKWzfAeK96iL_snfJ1jGnaWq0B5odZtC5o1_ccB8ECV9w@mail.gmail.com>
Subject: Re: [PATCH v2] airo: Fix read overflows sending packets
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Hu Jiahui <kirin.say@gmail.com>,
        Security Officers <security@kernel.org>,
        linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 27, 2020 at 10:58 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The problem is that we always copy a minimum of ETH_ZLEN (60) bytes from
> skb->data even when skb->len is less than ETH_ZLEN so it leads to a read
> overflow.
>
> The fix is to pad skb->data with zeroes so that it's never less than
> ETH_ZLEN bytes.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Hu Jiahui <kirin.say@gmail.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: remove an unnecessary if statement
>     increment the ->tx_dropped count on failure
>     fix found two more instances of the same bug.
>     fix typo in the "Cc: <stable@vger.kernel.org>" tag
>
>  drivers/net/wireless/cisco/airo.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> index 8363f91df7ea..c80712e61ccf 100644
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -1925,6 +1925,11 @@ static netdev_tx_t mpi_start_xmit(struct sk_buff *skb,
>                 airo_print_err(dev->name, "%s: skb == NULL!",__func__);
>                 return NETDEV_TX_OK;
>         }
> +       if (skb_padto(skb, ETH_ZLEN)) {
> +               dev->stats.tx_dropped++;
> +               return NETDEV_TX_OK;
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

Note that skb_padto() does not change skb->len

So this patch could trigger a hardware bug.

> +       len = skb->len;
>         buffer = skb->data;
>
>         ai->txfids[0].tx_desc.offset = 0;
> @@ -2118,7 +2122,6 @@ static void airo_end_xmit(struct net_device *dev) {
>  static netdev_tx_t airo_start_xmit(struct sk_buff *skb,
>                                          struct net_device *dev)
>  {
> -       s16 len;
>         int i, j;
>         struct airo_info *priv = dev->ml_priv;
>         u32 *fids = priv->fids;
> @@ -2127,6 +2130,10 @@ static netdev_tx_t airo_start_xmit(struct sk_buff *skb,
>                 airo_print_err(dev->name, "%s: skb == NULL!", __func__);
>                 return NETDEV_TX_OK;
>         }
> +       if (skb_padto(skb, ETH_ZLEN)) {
> +               dev->stats.tx_dropped++;
> +               return NETDEV_TX_OK;
> +       }
>
>         /* Find a vacant FID */
>         for( i = 0; i < MAX_FIDS / 2 && (fids[i] & 0xffff0000); i++ );
> @@ -2140,10 +2147,8 @@ static netdev_tx_t airo_start_xmit(struct sk_buff *skb,
>                         return NETDEV_TX_BUSY;
>                 }
>         }
> -       /* check min length*/
> -       len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
>          /* Mark fid as used & save length for later */
> -       fids[i] |= (len << 16);
> +       fids[i] |= (skb->len << 16);
>         priv->xmit.skb = skb;
>         priv->xmit.fid = i;
>         if (down_trylock(&priv->sem) != 0) {
> @@ -2185,7 +2190,6 @@ static void airo_end_xmit11(struct net_device *dev) {
>  static netdev_tx_t airo_start_xmit11(struct sk_buff *skb,
>                                            struct net_device *dev)
>  {
> -       s16 len;
>         int i, j;
>         struct airo_info *priv = dev->ml_priv;
>         u32 *fids = priv->fids;
> @@ -2201,6 +2205,10 @@ static netdev_tx_t airo_start_xmit11(struct sk_buff *skb,
>                 airo_print_err(dev->name, "%s: skb == NULL!", __func__);
>                 return NETDEV_TX_OK;
>         }
> +       if (skb_padto(skb, ETH_ZLEN)) {
> +               dev->stats.tx_dropped++;
> +               return NETDEV_TX_OK;
> +       }
>
>         /* Find a vacant FID */
>         for( i = MAX_FIDS / 2; i < MAX_FIDS && (fids[i] & 0xffff0000); i++ );
> @@ -2214,10 +2222,8 @@ static netdev_tx_t airo_start_xmit11(struct sk_buff *skb,
>                         return NETDEV_TX_BUSY;
>                 }
>         }
> -       /* check min length*/
> -       len = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
>          /* Mark fid as used & save length for later */
> -       fids[i] |= (len << 16);
> +       fids[i] |= (skb->len << 16);
>         priv->xmit11.skb = skb;
>         priv->xmit11.fid = i;
>         if (down_trylock(&priv->sem) != 0) {
> --
> 2.11.0
>
