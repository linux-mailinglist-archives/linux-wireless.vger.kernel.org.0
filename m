Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2057544D9
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jul 2023 00:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGNWMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jul 2023 18:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGNWMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jul 2023 18:12:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8030E35AE
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jul 2023 15:12:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-786f25bcb40so102539639f.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jul 2023 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689372759; x=1691964759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikwQGi9IXlkGeo4HUQH8f09/gzobjMF0voFNfM49Sww=;
        b=S1MpqZ1ZMss8lTp6KfBes4FPGzsNj63QZ+hQqRV8N87fyQklTURbZdp1/yOGEFl+If
         zLl21Al+xQmIF0gHbgA8FXkQ0Lp1mKdjXLL4EEhwTqk97NK6V/UpJqUe0abC2cUfX2zS
         Cj0n3BpTpDww5r+V5O+B9m42vK6gM11/YDSOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689372759; x=1691964759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikwQGi9IXlkGeo4HUQH8f09/gzobjMF0voFNfM49Sww=;
        b=SCZMlCY7XmHtntJ20tA64vSvT7nitKe/Z5cW+C1IQ/h7TEyPt5/4oNU3v27UJ+stnc
         l4LuHM8NG1cdsHNdG4PlauPHLiBAvPaZid6WYkP09cTdtL4GUYUYvGmVqUjEfJgx899p
         eggLhgXz0dQXK3XoW+keGEcWlizScQzZwTXSmmr0xRxsQbUAMl+7mCXtjKv4+AOZ9Hmt
         9Nhh74HeI9qS8y2JMnK/EDyRksMWFOA1XBJqe8AQtq9I9AoncXA1TYMZ48jQb0cUc53k
         hThbphidfZSa2sicRARXSBTtWjL3zj/K5m/aXLxbHhbUVTe2aejqz6232VaehgAAwO6H
         Nl9w==
X-Gm-Message-State: ABy/qLa+VNrjBcu+KRZR/wL41NxAJ9wRY66WLGGx8q1jEsff5shq+S+O
        QD27nZAAQKdr6J0dMMkjCpKtWzMmI8u+qFmj7b2z7Q==
X-Google-Smtp-Source: APBJJlHxYBsV/ay/4NzodEfY8v/wpwnSIpg4olIWppigc5a7E+NF93pSrJVs2yqxzwlLO5FbdFH/R9vqQ06SWPA/iX4=
X-Received: by 2002:a5e:dc06:0:b0:786:cd9b:1cd7 with SMTP id
 b6-20020a5edc06000000b00786cd9b1cd7mr6383634iok.9.1689372758902; Fri, 14 Jul
 2023 15:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230714120222.3920248-1-pinkperfect2021@gmail.com>
In-Reply-To: <20230714120222.3920248-1-pinkperfect2021@gmail.com>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Fri, 14 Jul 2023 15:12:27 -0700
Message-ID: <CACTWRwuhkz60t8TSy6xvPjeS5BGp9f5H_o=rf42yUUcrY5m5eA@mail.gmail.com>
Subject: Re: [PATCH v5] wifi: mwifiex: Fix OOB and integer underflow when rx packets
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     kuba@kernel.org, amitkarwar@gmail.com, kvalo@kernel.org,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Left some comments around the formatting. Did you run checkpatch.pl
before pushing the change , if not please run.
On Fri, Jul 14, 2023 at 5:02=E2=80=AFAM Polaris Pi <pinkperfect2021@gmail.c=
om> wrote:
>
> Make sure mwifiex_process_mgmt_packet and its callers
> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet
> not out-of-bounds access the skb->data buffer.
>
> Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80=
211")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> ---
> V5: Follow chromeos comments: preserve the original flow of mwifiex_proce=
ss_uap_rx_packet
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_rx.c   |  3 ++-
>  drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 11 +++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.c     |  5 +++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/=
wireless/marvell/mwifiex/sta_rx.c
> index 13659b02ba88..88aaec645291 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> @@ -194,7 +194,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_priv=
ate *priv,
>
>         rx_pkt_hdr =3D (void *)local_rx_pd + rx_pkt_offset;
>
> -       if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
> +       if ((rx_pkt_offset + rx_pkt_length) > (u16)skb->len ||
formatting issue, space after (u16)
> +           skb->len - rx_pkt_offset < sizeof(*rx_pkt_hdr)) {
>                 mwifiex_dbg(adapter, ERROR,
>                             "wrong rx packet: len=3D%d, rx_pkt_offset=3D%=
d, rx_pkt_length=3D%d\n",
>                             skb->len, rx_pkt_offset, rx_pkt_length);
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/ne=
t/wireless/marvell/mwifiex/uap_txrx.c
> index e495f7eaea03..32f4626a4d76 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> @@ -367,6 +367,17 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_pri=
vate *priv,
>         rx_pkt_type =3D le16_to_cpu(uap_rx_pd->rx_pkt_type);
>         rx_pkt_hdr =3D (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_=
offset);
>
> +       if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len ||
> +           skb->len - le16_to_cpu(uap_rx_pd->rx_pkt_offset) < sizeof(*rx=
_pkt_hdr)) {
> +               mwifiex_dbg(adapter, ERROR,
> +                           "wrong rx packet offset: len=3D%d, offset=3D%=
d\n",
> +                           skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offse=
t));
> +               priv->stats.rx_dropped++;
> +
> +               dev_kfree_skb_any(skb);
> +               return 0;
> +       }
> +
>         ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
>
>         if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wi=
reless/marvell/mwifiex/util.c
> index 94c2d219835d..31e1a82883e4 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *=
priv,
>
>         pkt_len =3D le16_to_cpu(rx_pd->rx_pkt_length);
>
> +       if (pkt_len < sizeof(struct ieee80211_hdr) || skb->len < pkt_len)=
 {
> +               mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length"=
);
> +               return -1;
why return -1 instead of returning appropriate error code , may be EMSGSIZE

Thanks
Abhishek

> +       }
> +
>         ieee_hdr =3D (void *)skb->data;
>         if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
>                 if (mwifiex_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
> --
> 2.25.1
>
