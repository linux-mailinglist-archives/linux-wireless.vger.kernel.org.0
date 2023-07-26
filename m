Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965A57635D0
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjGZMFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZMFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 08:05:16 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7CAA
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 05:05:14 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56c4457c82eso7376eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690373114; x=1690977914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwkCSdirw2IHkC+w6GYdEQWZEAClewkm8At3wmS+W1M=;
        b=AopCL3oQ866esZyBs6p4uv23opPQfDzNkOa6HxKA4UC/ThnZ/NaQwTn9ku8Ea8octz
         UUxG0TJnST9ML4OIHMvooLWAPfs2VtgFKLHBV+41I4T8FRxvuPlaoyE4a54K6+R0zFah
         s2gBUgJoWrKAQYgNAJVUNLI43o4truJB3GctI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373114; x=1690977914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwkCSdirw2IHkC+w6GYdEQWZEAClewkm8At3wmS+W1M=;
        b=QaY7lu86T6tviVr2VKaqGrGZl6CPbLWaw3cYBmXWhUtECGfzbjVdYQXV2QE6dTtDrg
         d3pY3i+fEG4gRG1wl9NF6mQBPR+rFUzVHgcRTGXPYzGqspxtTtAZhE7V4O3MV+Y/Q8pn
         Qmb/QebdDOg0wwSoBIt4BKYbuu0NEVOCeKif+n55pfFn9ddnobdwsPR+PHshLYKfKmrE
         FjDI+JyuwoDjy5IQ2ldkM30ze3q96SWzzoAk2GirzQhO+huDOS6V2nwId7z464bALJ9C
         azZPkfBUTnJjFWmIZ+W44QD+hkqYT06wIcLRtCoZZSlhJj0shOlnyuUKIlMW5gJxuPvh
         82vA==
X-Gm-Message-State: ABy/qLbglZK7vP9JJ/JkLwWkoUbSWslU7cUgkNiVPJWo5qo1nwzImika
        XQTN6ChZv96exGcYjR0f2G/Gzs2b1bZQS+78jXNWlYEIoze7GihyfKU=
X-Google-Smtp-Source: APBJJlE4i1Bb26bq49VLVBd2PbN3jzcPbvq/w2dvCqr5SdtK0LygVRxfxmG6G5jl4F7plvz4MqGIWoXG3fx9FedgAhE=
X-Received: by 2002:a4a:385d:0:b0:569:ac56:ca98 with SMTP id
 o29-20020a4a385d000000b00569ac56ca98mr1340440oof.3.1690373114111; Wed, 26 Jul
 2023 05:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
In-Reply-To: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Wed, 26 Jul 2023 14:05:02 +0200
Message-ID: <CABRiz0pPnnKWH7s5HdmFu55-pHPhXWtytZPFe-NW0RUdv78wpw@mail.gmail.com>
Subject: Re: [PATCH v7] wifi: mwifiex: Fix OOB and integer underflow when rx packets
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     briannorris@chromium.org, kuba@kernel.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reviewed-by: Matthew Wang <matthewmwang@chromium.org>

On Sun, Jul 23, 2023 at 9:07=E2=80=AFAM Polaris Pi <pinkperfect2021@gmail.c=
om> wrote:
>
> Make sure mwifiex_process_mgmt_packet,
> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
> mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
> not out-of-bounds access the skb->data buffer.
>
> Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80=
211")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> ---
> V5: Follow chromeos comments: preserve the original flow of mwifiex_proce=
ss_uap_rx_packet
> V6: Simplify check in mwifiex_process_uap_rx_packet
> V7: Fix drop packets issue when auotest V6, now pass manual and auto test=
s
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_rx.c | 11 ++++++++++-
>  .../net/wireless/marvell/mwifiex/uap_txrx.c   | 19 +++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c   | 10 +++++++---
>  3 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/=
wireless/marvell/mwifiex/sta_rx.c
> index 13659b02ba88..f2899d53a43f 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> @@ -86,6 +86,14 @@ int mwifiex_process_rx_packet(struct mwifiex_private *=
priv,
>         rx_pkt_len =3D le16_to_cpu(local_rx_pd->rx_pkt_length);
>         rx_pkt_hdr =3D (void *)local_rx_pd + rx_pkt_off;
>
> +       if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
> +               mwifiex_dbg(priv->adapter, ERROR,
> +                           "wrong rx packet offset: len=3D%d, rx_pkt_off=
=3D%d\n",
> +                           skb->len, rx_pkt_off);
> +               priv->stats.rx_dropped++;
> +               dev_kfree_skb_any(skb);
> +       }
> +
>         if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
>                      sizeof(bridge_tunnel_header))) ||
>             (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> @@ -194,7 +202,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_priv=
ate *priv,
>
>         rx_pkt_hdr =3D (void *)local_rx_pd + rx_pkt_offset;
>
> -       if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
> +       if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
> +           sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
>                 mwifiex_dbg(adapter, ERROR,
>                             "wrong rx packet: len=3D%d, rx_pkt_offset=3D%=
d, rx_pkt_length=3D%d\n",
>                             skb->len, rx_pkt_offset, rx_pkt_length);
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/ne=
t/wireless/marvell/mwifiex/uap_txrx.c
> index e495f7eaea03..04ff051f5d18 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> @@ -103,6 +103,15 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwi=
fiex_private *priv,
>                 return;
>         }
>
> +       if (sizeof(*rx_pkt_hdr) +
> +           le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
> +               mwifiex_dbg(adapter, ERROR,
> +                           "wrong rx packet offset: len=3D%d,rx_pkt_offs=
et=3D%d\n",
> +                           skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offse=
t));
> +               priv->stats.rx_dropped++;
> +               dev_kfree_skb_any(skb);
> +       }
> +
>         if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
>                      sizeof(bridge_tunnel_header))) ||
>             (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> @@ -367,6 +376,16 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_pri=
vate *priv,
>         rx_pkt_type =3D le16_to_cpu(uap_rx_pd->rx_pkt_type);
>         rx_pkt_hdr =3D (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_=
offset);
>
> +       if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
> +           sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
> +               mwifiex_dbg(adapter, ERROR,
> +                           "wrong rx packet for struct ethhdr: len=3D%d,=
 offset=3D%d\n",
> +                           skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offse=
t));
> +               priv->stats.rx_dropped++;
> +               dev_kfree_skb_any(skb);
> +               return 0;
> +       }
> +
>         ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
>
>         if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wi=
reless/marvell/mwifiex/util.c
> index 94c2d219835d..745b1d925b21 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -393,11 +393,15 @@ mwifiex_process_mgmt_packet(struct mwifiex_private =
*priv,
>         }
>
>         rx_pd =3D (struct rxpd *)skb->data;
> +       pkt_len =3D le16_to_cpu(rx_pd->rx_pkt_length);
> +       if (pkt_len < sizeof(struct ieee80211_hdr) + sizeof(pkt_len)) {
> +               mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length"=
);
> +               return -1;
> +       }
>
>         skb_pull(skb, le16_to_cpu(rx_pd->rx_pkt_offset));
>         skb_pull(skb, sizeof(pkt_len));
> -
> -       pkt_len =3D le16_to_cpu(rx_pd->rx_pkt_length);
> +       pkt_len -=3D sizeof(pkt_len);
>
>         ieee_hdr =3D (void *)skb->data;
>         if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
> @@ -410,7 +414,7 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *p=
riv,
>                 skb->data + sizeof(struct ieee80211_hdr),
>                 pkt_len - sizeof(struct ieee80211_hdr));
>
> -       pkt_len -=3D ETH_ALEN + sizeof(pkt_len);
> +       pkt_len -=3D ETH_ALEN;
>         rx_pd->rx_pkt_length =3D cpu_to_le16(pkt_len);
>
>         cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
> --
> 2.25.1
>
