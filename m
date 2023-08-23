Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB578637E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 00:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbjHWWjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 18:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjHWWjL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 18:39:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB0A8
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 15:39:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso2919203a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692830348; x=1693435148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBCD3Z9gv9j7fQceMji1iomuK1C4+DWVfwEAFkYH9Dk=;
        b=J0aBawUtLOC9tkSRByqUtPVkV2ap5zYJZCO+SNBI30zCR8m+dkbs9/PIEBNQRdxeEy
         r65sZ7UbVDX9tBvre/+pQHgL9troneSmiH1CM5mwCEa9Y6eDHyFwhIHrT9t5t7XcR7Bu
         hnklXLqx3WQU/seEP3W1DnveKuK3qF/AkS/nJ/AEHd3YnRa8osbNoz2LVrwXvNHDaWCh
         xlDxx7kdhFPrV7dYphOlh1hMUNUFmgE+b8wf8JIIWiVKxPqqXYLguOjwLHGjoELujv6j
         OFjzVI53bsGPOq60i3m4Eld6fnF/9PLdxYWfdbebbA9rPq0cmnyHj6n7YS9osD44e8gs
         9A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830348; x=1693435148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBCD3Z9gv9j7fQceMji1iomuK1C4+DWVfwEAFkYH9Dk=;
        b=Uq0dY+/H8cwdLxAywApsZ7hsW8MFoxRX1BxU08Dh1mUGsEanDzhYlanOij8T45K7NB
         4bNccjVC2X0SI6IvJL8ETwprt+QFrHqjaopL4vyzqP6pbZtkIXLm75UhFRmHlymXSobI
         L3w4iGaxQl3XNf9K6wRQUisj6Wiy7NZCt1P483p7l1sajedLdDGdbS29LdJMnrzdJ90w
         o7BmnElqbIIHZysK+5qaZIymSp9+LoJqX1wxQaH+y+Y+O2OAt8ZHyTGq9Hv85mwd+Aaf
         ThyHLRhXZ93+7rQi3TKiH1NqA0LkDOc8BHk888XdqTfRi7Lflqq2zGuqJAl8selx3W5A
         hbRg==
X-Gm-Message-State: AOJu0YxCWuo8jFeyJ/jfJ7zwE578ZQKl4tVCnRW358/KUczbgeGk/MM0
        nyUqpPViAtT2rrCPMOmBlQbA3GUogtwisg3o9FhhzA==
X-Google-Smtp-Source: AGHT+IGhIdM7DxxTPWUcpTjfC7HxpBU8P5A6TVZnr7L1ACD7ax9SJgXA3JCRYnyvaxhl5hGpsOpEGebPzbj1p6bel9o=
X-Received: by 2002:aa7:d5ce:0:b0:523:69bf:2bd3 with SMTP id
 d14-20020aa7d5ce000000b0052369bf2bd3mr10915442eds.13.1692830348222; Wed, 23
 Aug 2023 15:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692829410.git.gustavoars@kernel.org> <587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org>
In-Reply-To: <587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 23 Aug 2023 15:38:57 -0700
Message-ID: <CAFhGd8rcOPk3RHGhhvFu7=qRTY-hRrdWriwY3h_tiAyL+YnvGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 23, 2023 at 3:33=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Add sanity checks for both `tlv_len` and `tlv_bitmap_len` before
> decoding data from `event_buf`.
>
> This prevents any malicious or buggy firmware from overflowing
> `event_buf` through large values for `tlv_len` or `tlv_bitmap_len`.
>
> Suggested-by: Dan Williams <dcbw@redhat.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  .../net/wireless/marvell/mwifiex/11n_rxreorder.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drive=
rs/net/wireless/marvell/mwifiex/11n_rxreorder.c
> index 735aac52bdc4..9ee3b9f1e9ce 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> @@ -921,6 +921,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_priv=
ate *priv,
>         while (tlv_buf_left > sizeof(*tlv_rxba)) {
>                 tlv_type =3D le16_to_cpu(tlv_rxba->header.type);
>                 tlv_len  =3D le16_to_cpu(tlv_rxba->header.len);
> +               if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf=
_left) {
> +                       mwifiex_dbg(priv->adapter, WARN,
> +                                   "TLV size (%ld) overflows event_buf (=
%d)\n",
> +                                   size_add(sizeof(tlv_rxba->header), tl=
v_len),
> +                                   tlv_buf_left);
> +                       return;
> +               }
> +
>                 if (tlv_type !=3D TLV_TYPE_RXBA_SYNC) {
>                         mwifiex_dbg(priv->adapter, ERROR,
>                                     "Wrong TLV id=3D0x%x\n", tlv_type);
> @@ -929,6 +937,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_priv=
ate *priv,
>
>                 tlv_seq_num =3D le16_to_cpu(tlv_rxba->seq_num);
>                 tlv_bitmap_len =3D le16_to_cpu(tlv_rxba->bitmap_len);
> +               if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf=
_left) {
> +                       mwifiex_dbg(priv->adapter, WARN,
> +                                   "TLV size (%ld) overflows event_buf (=
%d)\n",
> +                                   size_add(sizeof(*tlv_rxba), tlv_bitma=
p_len),
> +                                   tlv_buf_left);
> +                       return;
> +               }
> +
>                 mwifiex_dbg(priv->adapter, INFO,
>                             "%pM tid=3D%d seq_num=3D%d bitmap_len=3D%d\n"=
,
>                             tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
> --
> 2.34.1
>
