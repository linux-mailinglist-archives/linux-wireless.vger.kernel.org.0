Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F87C986D
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Oct 2023 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjJOJCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Oct 2023 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjJOJCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Oct 2023 05:02:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9356A3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 02:02:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so6018451a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697360557; x=1697965357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NbX+/Cf6clmZjnaWGu/k7gLoOuS98SUZXuSsZExkvcs=;
        b=ZgHoVpMLjZJTv4CZhDUky2eAdMlXwL0bYpqANvNjKLrhAlB5S+QhuEsA1Zul5WZ9ck
         Q6nqaQimtpUpc3Km95iKQhM3S4G06mvtqS2yCJfHkzIufi9D1eZSGqQHU8/OXuuScmeM
         FG4HcC2uMHaOjOaAbiHFVdG3oXptHzolxr64KhYDub9FMY5g3TLujHI0YQbK50acJIt/
         9SP3+Dz03VW3j1vHHXAoUhIk0f01syAsGFr5CAML5lN+lBWPXnl+MYFiMiiSpKIB/diJ
         rHAVCkv5RlwSEptqcm+/Iv9+YUKYbWulibpWA030/bV7IKjmXiC8wimL9ioFgQrhCc7Z
         wTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697360557; x=1697965357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbX+/Cf6clmZjnaWGu/k7gLoOuS98SUZXuSsZExkvcs=;
        b=tHpfpMQVDURKaMz972Wn94APyNAHOkXuQbPcG5G6vsVj6U8SAwdm1ISODDm1wvK9lw
         dL6mLVwTx4pjbA6laUCS7N5K+k3CvSiHslwWbUjM/JaXLCatq1v1ypyfmgfEQ/BjwFlt
         PubLLH5KHtok/5lmnu46IKeGIyjF7VOUEtIJHxSAuo9/ZQ1QrBJBUc8EitSCyEjHAhEu
         F+F3XMNoKGx6uDKm5i8mjBLe0IvtmfKaoK9ngqLpmf0eMKWRYVKM/YeXlklDoCeT5H9A
         qnUmQjB04VMp2tAA5VgfF7cCSeN/etiUz9BrV1i8rHMMq/juD1GiANG7xVCbQcHG4nys
         hx1Q==
X-Gm-Message-State: AOJu0YykVDex8Zf3ghROYBYBQ5m4Kgpm63roPekkxK1FMmMONrbED/MD
        aP16+vU/RuTOmOIAXRbISq0iJI5RNy90peX9mCEfTXf+KGCSgA==
X-Google-Smtp-Source: AGHT+IGm1PoghK5cLlBg2XIDvYSQ1u03kMNZ7L4YQ71HrWXSEbLM1fho0WhWvYETB5TJq3XErctZ1v2hbIwAL0mddu0=
X-Received: by 2002:a17:906:55:b0:99b:dd1d:bc58 with SMTP id
 21-20020a170906005500b0099bdd1dbc58mr30972815ejg.41.1697360556773; Sun, 15
 Oct 2023 02:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <e6c9a6fdeeaa57d73560c895046da4a58983297d.1697146767.git.yi-chia.hsieh@mediatek.com>
In-Reply-To: <e6c9a6fdeeaa57d73560c895046da4a58983297d.1697146767.git.yi-chia.hsieh@mediatek.com>
From:   James Dutton <james.dutton@gmail.com>
Date:   Sun, 15 Oct 2023 10:02:00 +0100
Message-ID: <CAAMvbhF=2kt0Ya_Oq7MkJ4fGCvbhCLn9_wTPOfdi38Vax5tO5g@mail.gmail.com>
Subject: Re: [RESEND PATCH] wifi: mt76: mt7996: fix uninitialized variable in
 parsing txfree
To:     Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 12 Oct 2023 at 23:09, Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com> wrote:
>
> Fix the uninitialized variable warning in mt7996_mac_tx_free.
>
> Fixes: 2461599f835e ("wifi: mt76: mt7996: get tx_retries and tx_failed from txfree")
> Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> index 04540833485f..59ab07b89087 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1074,7 +1074,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
>         struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
>         struct mt76_txwi_cache *txwi;
>         struct ieee80211_sta *sta = NULL;
> -       struct mt76_wcid *wcid;
> +       struct mt76_wcid *wcid = NULL;
>         LIST_HEAD(free_list);
>         struct sk_buff *skb, *tmp;
>         void *end = data + len;
> --
> 2.39.0
>

I am curious. Setting "struct mt76_wcid *wcid=NULL;" at the top of the
function will remove this warning, but is this really the intended
behaviour?
I am thinking about what situations will wcid now be non zero at this
(HERE below) position in the code.
It will be non-zero as a result of a previous round of the loop,
instead of given a value on this round of the loop.
There are no comments in the code, so I don't know if the intention is
to use the wcid from previous rounds of the loop or not.
My guess is we should raise the initialisation of wcid =
rcu_dereference(dev->mt76.wcid
[idx]);   to somewhere higher up, before the previous if...else scope.

  1127                 } else if (info & MT_TXFREE_INFO_HEADER) {
    1128                         u32 tx_retries = 0, tx_failed = 0;
    1129
--> 1130                         if (!wcid)        <--- HERE

Uninitialized on first iteration

    1131                                 continue;
    1132
    1133                         tx_retries =
    1134                                 FIELD_GET(MT_TXFREE_INFO_COUN
T, info) - 1;
    1135                         tx_failed = tx_retries +
    1136                                 !!FIELD_GET(MT_TXFREE_INFO_STAT, info);
    1137
    1138                         wcid->stats.tx_retries += tx_retries;
    1139                         wcid->stats.tx_failed += tx_failed;
    1140                         continue;
    1141                 }
