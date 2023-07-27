Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14CD764486
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 05:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjG0Do4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 23:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG0Doz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 23:44:55 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC81990
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 20:44:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a412653352so494336b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 20:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690429493; x=1691034293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl5lGVY7BMmdw8t6AmZWyI2tAs0TkZaYFmG/Yn+zkOE=;
        b=g38GMFfkuVeYzUqDw9WgNE6W5BCkKI3qxe7fQRGplWYRyiGFSdpQjAE3AeBUDZ+omJ
         4TF3wbGu9ZZBg53CdKixBgkrp/p7/oaniL7QGpP07BxW5qg/kvhTwKlD6QpY1dhhzd85
         5lBu4HdGYy1Gbq9q1uRf/os6aDc6vo7vtvqmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690429493; x=1691034293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl5lGVY7BMmdw8t6AmZWyI2tAs0TkZaYFmG/Yn+zkOE=;
        b=GocaNP2afa19rL2Ns51uFr+jU91hK3YMC8ZXo2KqqosbhIintsw3dc0WXHjnsy5uCv
         7yEoascWm28b8LnVYhykP9+Un5XS3j4M/rrvNRzIAnkJVdMmRG1TH0tUuA4db6urlqpX
         0qq6MqROjOlvhKCCy91Re5HPPaJN4hH5rlvd4y5GHvA29fzRQ8yjXOJRr9BTb4eEnqAL
         VoF86VNIAbsdRrFKGm3hOFI1NeVpLWutjtACDQEg4kkD5rjXxG2RHYHunyUZN++/+MG7
         6azRebl15NbBkZ0BZY1T9+u3RQCOcQwkbW6iLrC7l7Cn9aP8cRC+SpFajKQi2avYK2fU
         8u8g==
X-Gm-Message-State: ABy/qLb+LOO5z6oe3RqYBrAbsZh4ONKSEECuDQJ6ZXsFub7Z4i0jVinh
        SmQOif6cDx3AkrTBqtLyWovZN+PHjLWlWTKHo3AeNGUO
X-Google-Smtp-Source: APBJJlEz7De9NmG9aPL5b+iJgiCSjISdfZ+1fOnH0OfyN4ausKtNbmrk92wxK5/BPEZ+MkiXfHs2KQ==
X-Received: by 2002:a05:6808:13c9:b0:3a0:3495:c8d4 with SMTP id d9-20020a05680813c900b003a03495c8d4mr2100728oiw.28.1690429493337;
        Wed, 26 Jul 2023 20:44:53 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id p64-20020acaf143000000b003a414415693sm290164oih.44.2023.07.26.20.44.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 20:44:53 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b9c57c4d12so425538a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 20:44:53 -0700 (PDT)
X-Received: by 2002:a1f:3d57:0:b0:486:5719:f4e0 with SMTP id
 k84-20020a1f3d57000000b004865719f4e0mr651152vka.7.1690429472201; Wed, 26 Jul
 2023 20:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <8fd42ac8e1c97246f6e65225a14fc8a029ac3aaa.1690232804.git.objelf@gmail.com>
 <7c7c2c1f0584e8dd016bc2bf8de88684fcc7679c.1690232804.git.objelf@gmail.com>
In-Reply-To: <7c7c2c1f0584e8dd016bc2bf8de88684fcc7679c.1690232804.git.objelf@gmail.com>
From:   David Ruth <druth@chromium.org>
Date:   Wed, 26 Jul 2023 23:43:55 -0400
X-Gmail-Original-Message-ID: <CAKHmtrQVp9yV1uFagENxW1ra3sVCf-9WP4thpQ97runk3PaXKA@mail.gmail.com>
Message-ID: <CAKHmtrQVp9yV1uFagENxW1ra3sVCf-9WP4thpQ97runk3PaXKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt7921: fix the wrong rate pickup for the
 chanctx driver
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        ted.huang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, jsiuda@google.com, arowa@google.org,
        frankgor@google.com, kuabhs@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reviewed-by: David Ruth <druth@chromium.org>
Tested-by: David Ruth <druth@chromium.org>

On Mon, Jul 24, 2023 at 5:20=E2=80=AFPM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> The variable band should be determined by the ieee80211_chanctx_conf when
> the driver is a kind of chanctx one e.g mt7921 and mt7922 driver so we
> added the extension to mt76_connac2_mac_tx_rate_val by distinguishing if
> it can support chanctx to fix the incorrect rate pickup.
>
> Fixes: 41ac53c899bd ("wifi: mt76: mt7921: introduce chanctx support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c        | 9 +++++++--
>  drivers/net/wireless/mediatek/mt76/mt76.h            | 3 ++-
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 7 +++++--
>  3 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index c0ff36a98bed..d622a2916c0e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -1698,11 +1698,16 @@ mt76_init_queue(struct mt76_dev *dev, int qid, in=
t idx, int n_desc,
>  }
>  EXPORT_SYMBOL_GPL(mt76_init_queue);
>
> -u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
> +u16 mt76_calculate_default_rate(struct mt76_phy *phy,
> +                               struct ieee80211_vif *vif, int rateidx)
>  {
> +       struct mt76_vif *mvif =3D (struct mt76_vif *)vif->drv_priv;
> +       struct cfg80211_chan_def *chandef =3D mvif->ctx ?
> +                                           &mvif->ctx->def :
> +                                           &phy->chandef;
>         int offset =3D 0;
>
> -       if (phy->chandef.chan->band !=3D NL80211_BAND_2GHZ)
> +       if (chandef->chan->band !=3D NL80211_BAND_2GHZ)
>                 offset =3D 4;
>
>         /* pick the lowest rate for hidden nodes */
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index bf9c781ff48c..a292e15224e1 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -1100,7 +1100,8 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *=
data, int offset, int len);
>  struct mt76_queue *
>  mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
>                 int ring_base, u32 flags);
> -u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx);
> +u16 mt76_calculate_default_rate(struct mt76_phy *phy,
> +                               struct ieee80211_vif *vif, int rateidx);
>  static inline int mt76_init_tx_queue(struct mt76_phy *phy, int qid, int =
idx,
>                                      int n_desc, int ring_base, u32 flags=
)
>  {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mac.c
> index ee5177fd6dde..d91f5548dc02 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
> @@ -310,7 +310,10 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mp=
hy,
>                                  struct ieee80211_vif *vif,
>                                  bool beacon, bool mcast)
>  {
> -       u8 nss =3D 0, mode =3D 0, band =3D mphy->chandef.chan->band;
> +       struct mt76_vif *mvif =3D (struct mt76_vif *)vif->drv_priv;
> +       struct cfg80211_chan_def *chandef =3D mvif->ctx ?
> +                                           &mvif->ctx->def : &mphy->chan=
def;
> +       u8 nss =3D 0, mode =3D 0, band =3D chandef->chan->band;
>         int rateidx =3D 0, mcast_rate;
>
>         if (!vif)
> @@ -343,7 +346,7 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mph=
y,
>                 rateidx =3D ffs(vif->bss_conf.basic_rates) - 1;
>
>  legacy:
> -       rateidx =3D mt76_calculate_default_rate(mphy, rateidx);
> +       rateidx =3D mt76_calculate_default_rate(mphy, vif, rateidx);
>         mode =3D rateidx >> 8;
>         rateidx &=3D GENMASK(7, 0);
>  out:
> --
> 2.25.1
>
