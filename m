Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB77D396FAF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhFAI7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 04:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233381AbhFAI7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 04:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622537876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCLKp5QbeTeSoMKJu2XZdwfGKFAJA6gZeT6GS9HfPdI=;
        b=MleYQOm8JkdCwY5zIIhpSYP+wHI3z0IbgRbFIKWEIRhoJh9XD8Vo6JGSShk3fhANu4M5Re
        ogBgtwDQAUYz1PaYa9kSVeoV4TV3wXhFUSZ/ppAvfHSgwsnIDBsghXU+e/DlC2pLVc6JJv
        Dc4cqZ1PEohEvwh5+pTEmCreOKo0W10=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-CYIC21gQOpSIstKE8N6ZyA-1; Tue, 01 Jun 2021 04:57:53 -0400
X-MC-Unique: CYIC21gQOpSIstKE8N6ZyA-1
Received: by mail-il1-f200.google.com with SMTP id p11-20020a056e02104bb02901c6927c3934so9599950ilj.20
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 01:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tCLKp5QbeTeSoMKJu2XZdwfGKFAJA6gZeT6GS9HfPdI=;
        b=FUPlXbv483rtILgPMnfckpd9udpBx0XzcdIyzjS14nU31psqqpjB22CohnGfWc3NW0
         KLgnu1t9YXOzrnvYcb9jLCwyMgzlGeC8tyFj3xPV/uBFhaeU7QpPLeNVWyLhovLBbfEF
         QJl3wUaUumoPUCG/eyYeWmH4zY+XyFOM7mTww0OELOfiG8dsumyX02Hy+2b0KBTJBz4f
         dzZK7LYALY/tkwQv2ky6bk7IFtsjwuOMX4aYTw2uJEcJx0cS0CvBdRrFaoKb7g9jv8Qm
         6XHUXTgjaY9GuBLCPfEReBmRDk3ITNnt36V851V8a/rZcQRBabBiyFOO96DMtdqNNRbv
         1OXQ==
X-Gm-Message-State: AOAM532IMZQeafVHKTwkldLxfMqng/y0KpQL4HR2UShgNzXwo6a5OrFG
        CLOznD/vCSZzNS93vQ8vM4lbis1o4BM1mUlIiQDrq00ILT0C+gavXEW/vKjIBw0lBL+OD9k0i2K
        IBrizmKnm3EgqaxDcely7t6IGLliqIRWmUAqGeoLPHo4=
X-Received: by 2002:a92:bf06:: with SMTP id z6mr22085877ilh.57.1622537872738;
        Tue, 01 Jun 2021 01:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkITRswOcTQRqMoxvzVNiux7fQBKfBVvRCPHzPaz9xFXkfLTqF5VT/UjBcaJODDrwLHC883DU0M6lX1cQ8q+4=
X-Received: by 2002:a92:bf06:: with SMTP id z6mr22085871ilh.57.1622537872609;
 Tue, 01 Jun 2021 01:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210511071926.8951-1-ihuguet@redhat.com>
In-Reply-To: <20210511071926.8951-1-ihuguet@redhat.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Tue, 1 Jun 2021 10:57:41 +0200
Message-ID: <CACT4oufLD3Fa5J=y5dz1LjdCVa2pZ=N1SB141DOcebeMYj8-Yw@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: avoid parsing short RX packet
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 11, 2021 at 9:19 AM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>=
 wrote:
>
> One USB data buffer can contain multiple received network
> packets. If that's the case, they're processed this way:
> 1. Original buffer is cloned
> 2. Original buffer is trimmed to contain only the first
>    network packet
> 3. This first network packet is passed to network stack
> 4. Cloned buffer is trimmed to eliminate the first network
>    packet
> 5. Repeat with the cloned buffer until there are no more
>    network packets inside
>
> However, if the space remaining in original buffer after
> the first network packet is not enough to contain at least
> another network packet descriptor, it is not cloned.
>
> The loop parsing this packets ended if remaining space =3D=3D 0.
> But if the remaining space was > 0 but < packet descriptor
> size, another iteration of the loop was done, processing again
> the previous packet because cloning didn't happen. Moreover,
> the ownership of this packet had been passed to network
> stack in the previous iteration.
>
> This patch ensures that no extra iteration is done if the
> remaining size is not enough for one packet, and also avoid
> the first iteration for the same reason.
>
> Probably this doesn't happen in practice, but can happen
> theoretically.
>
> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/driv=
ers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 9ff09cf7eb62..673961a82c40 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5554,6 +5554,11 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *=
priv, struct sk_buff *skb)
>         urb_len =3D skb->len;
>         pkt_cnt =3D 0;
>
> +       if (urb_len < sizeof(struct rtl8xxxu_rxdesc16)) {
> +               kfree_skb(skb);
> +               return RX_TYPE_ERROR;
> +       }
> +
>         do {
>                 rx_desc =3D (struct rtl8xxxu_rxdesc16 *)skb->data;
>                 _rx_desc_le =3D (__le32 *)skb->data;
> @@ -5581,7 +5586,7 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *p=
riv, struct sk_buff *skb)
>                  * at least cover the rx descriptor
>                  */
>                 if (pkt_cnt > 1 &&
> -                   urb_len > (pkt_offset + sizeof(struct rtl8xxxu_rxdesc=
16)))
> +                   urb_len >=3D (pkt_offset + sizeof(struct rtl8xxxu_rxd=
esc16)))
>                         next_skb =3D skb_clone(skb, GFP_ATOMIC);
>
>                 rx_status =3D IEEE80211_SKB_RXCB(skb);
> @@ -5627,7 +5632,9 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *p=
riv, struct sk_buff *skb)
>
>                 pkt_cnt--;
>                 urb_len -=3D pkt_offset;
> -       } while (skb && urb_len > 0 && pkt_cnt > 0);
> +               next_skb =3D NULL;
> +       } while (skb && pkt_cnt > 0 &&
> +                urb_len >=3D sizeof(struct rtl8xxxu_rxdesc16));
>
>         return RX_TYPE_DATA_PKT;
>  }
> --
> 2.31.1
>

Hello,

About 3 weeks ago I sent this patch, but received no response. Any
feedback would be appreciated.

Thanks!
--=20
=C3=8D=C3=B1igo Huguet

