Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF775B9AE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 23:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGTVjn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 17:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGTVjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 17:39:42 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA8F273A
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 14:39:28 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-56669eb7565so1475227eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689889168; x=1690493968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7fEj8f3W+0zKKKZeSbOJgToSjoj+ga6x/5Kbt4XGjY=;
        b=KMwT4e0J8xMFbhx8aTNy7+VZG1U+ReI1nErq63bDOo/4k7qUwf9Nozi2g+yueHWZwl
         P9xdN5h8ABPw+byF5RDaH9INieAqc6Xm4wL6egv4i3VxEfS+1apdQD2nufWtX4AXOgUh
         r+OTwIgHB5yStvkjqE+2186Qid402GAHITdM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889168; x=1690493968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7fEj8f3W+0zKKKZeSbOJgToSjoj+ga6x/5Kbt4XGjY=;
        b=G9at8NKvyWv6i3r2TRboD6HBfrVwRRQXPUCfWz4MB3p9bVr43/hKHzz7jLc30sfKbT
         GnThbvedm7wBfu+m2Mp4v5dffQe68DFWhRnoO5TztvElFHJk9XGLG3Z4QohAkcfBUtOq
         7UabPKK9xCtJuFUM+wHNRSMEYu2nbRJMxCzZ8eb3bXaK/CkGAlVxbGiUksK7QvHu8iFD
         AQ5W8/GJgpZYaP+w2cq74as0jnYDPf+ETUlLcduqwS/egeP3gfrMDEt9wb0qEK0O3qGc
         r6uisSHZLNjrAznCcLUjK4mjz7EOCJX34/ArYho5IPV6d3XjTut+x6x2y0+T7wZy4LN9
         UIPw==
X-Gm-Message-State: ABy/qLb82zVVHkO+LFoi/g9I/cD9MdAHXADxHUtYIO3kQIGQkGK0xY8z
        BaLJ4d6nY+hNqux5Y4lT/HDQGP6c1f1E7BNf1KZQJw==
X-Google-Smtp-Source: APBJJlGMnkopIQ5B2+ns6LySvpBshVe+83I9kYlqOvdhEGDKs90JSBZ5fEm7/DcLpSUik5z2sGuYyFNusMwjtJvxXLU=
X-Received: by 2002:a4a:ea24:0:b0:562:ff8a:75b7 with SMTP id
 y4-20020a4aea24000000b00562ff8a75b7mr105840ood.3.1689889168237; Thu, 20 Jul
 2023 14:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230714224809.3929539-1-pinkperfect2021@gmail.com>
 <20230717140232.3978004-1-pinkperfect2021@gmail.com> <20230717143957.24415029@kernel.org>
In-Reply-To: <20230717143957.24415029@kernel.org>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Thu, 20 Jul 2023 23:39:17 +0200
Message-ID: <CABRiz0p5uh6wEYkP8Q0Boz0C_NZKDQyKkUZiP+8i4DxXeJcVKg@mail.gmail.com>
Subject: Re: [PATCH v6] wifi: mwifiex: Fix OOB and integer underflow when rx packets
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Polaris Pi <pinkperfect2021@gmail.com>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 94c2d219835d..31e1a82883e4 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
>
>         pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
>
> +       if (pkt_len < sizeof(struct ieee80211_hdr) || skb->len < pkt_len) {

I've tested this patch a bit on a ChromeOS device and I've noticed
empirically that skb->len is often (always?) two less than pkt_len,
implying that pkt_len actually includes the rx_pkt_length field as
well (note that pkt_len gets adjusted by ETH_ALEN + sizeof(pkt_len)
below), so we end up hitting this condition reliably in certain
situations. This probably means the memmove below is not entirely
correct, but either way I don't think this patch is correct on its
own.

Consider my Reviewed-by tag removed until this gets resolved.

> +               mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
> +               return -1;
> +       }
> +
>         ieee_hdr = (void *)skb->data;
>         if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
>                 if (mwifiex_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
> --
