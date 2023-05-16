Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD5705979
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 23:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEPV3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 17:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEPV3k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 17:29:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CF6A54
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 14:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C371619A5
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 21:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CECC433D2
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684272578;
        bh=KdrFBmwsH2DCr1kLBx/EFi0WhyIjHl597QOTRQ1PrTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rao2UlWFPds4/Z0048aaBGooRiC4gvttA4YpnyJFEY1yvfbzWTLmPXJk1tBApBzRy
         /xnh/LacUL+8mk5znjEdaVV63OWtzzUy90lfz0Iif05FLm6WdJB6BmRJzi8hk0tF/h
         f4WrOrLPQYkpZLOQoJFGc0k0hknp+hmjEtLFM1undVkCAb2AsPyUh0bzjXw1Kx0J3e
         H44E37epF3h8BSxubnUHjDe41reByXsoO+H8IMNEugx+kmv71b3fSqwkqsb9Vdbh6m
         dXMrLaT3HBbP6IYNXI4YKChHNvejO0HMa5uKJjZ1uJEb0QrlUwU4oLffM5vB0/Ghfw
         MUOvV9P/KM3vw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2aeea823a5eso4612191fa.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 14:29:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDypSZ4a3gsSaChgaDip9zET6H+CIxnB+rWe6PTdlFVhyCIdlg0I
        XpqGLiDVKe3QvH7R6SQOCVsc92S6rk07/kNQW3Q=
X-Google-Smtp-Source: ACHHUZ5NrB1cmR2MJRhwC+C1kpZnsCi31ICmNP0Zc/w6YmKerMw32y0W+2AhKAwShOxZrq7MGEeORmlzDG1w99IWTwU=
X-Received: by 2002:ac2:521b:0:b0:4e8:586c:f13 with SMTP id
 a27-20020ac2521b000000b004e8586c0f13mr154590lfl.6.1684272576666; Tue, 16 May
 2023 14:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <a22524899498365b0d136f399438306568e77064.1684163657.git.deren.wu@mediatek.com>
In-Reply-To: <a22524899498365b0d136f399438306568e77064.1684163657.git.deren.wu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 16 May 2023 14:29:24 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrN0Hz2J0QzYCpq1sHN4CANNHPrhtGj326b9wC6YO+15A@mail.gmail.com>
Message-ID: <CAGp9LzrN0Hz2J0QzYCpq1sHN4CANNHPrhtGj326b9wC6YO+15A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7921e: report tx retries/failed counts in
 tx free event
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Deren,

On Mon, May 15, 2023 at 8:20=E2=80=AFAM Deren Wu <deren.wu@mediatek.com> wr=
ote:
>
> Get missing tx retries/failed counts from txfree done events and report
> them via mt7921_sta_statistics().
>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Reviewed-by: Sean Wang <sean.wang@mediatek.com>

> ---
> v1: based on "[v3,1/6] wifi: mt76: mt7915: report tx retries/failed count=
s for non-WED path"
> https://patchwork.kernel.org/project/linux-wireless/patch/e3cddf1cff5f060=
478c2de9e4e4021541549e750.1683670255.git.ryder.lee@mediatek.com/
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c       | 8 +++++++-
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 6 ++++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/driv=
ers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
> index a5ec0f631385..cb612d7c7616 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
> @@ -34,7 +34,7 @@ enum {
>
>  #define MT_TX_FREE_MSDU_CNT            GENMASK(9, 0)
>  #define MT_TX_FREE_WLAN_ID             GENMASK(23, 14)
> -#define MT_TX_FREE_LATENCY             GENMASK(12, 0)
> +#define MT_TX_FREE_COUNT               GENMASK(12, 0)
>  /* 0: success, others: dropped */
>  #define MT_TX_FREE_STATUS              GENMASK(14, 13)
>  #define MT_TX_FREE_MSDU_ID             GENMASK(30, 16)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 1675bf520481..a3d31b69217b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -614,6 +614,7 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev=
, void *data, int len)
>         struct mt76_dev *mdev =3D &dev->mt76;
>         struct mt76_txwi_cache *txwi;
>         struct ieee80211_sta *sta =3D NULL;
> +       struct mt76_wcid *wcid =3D NULL;
>         struct sk_buff *skb, *tmp;
>         void *end =3D data + len;
>         LIST_HEAD(free_list);
> @@ -637,7 +638,6 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev=
, void *data, int len)
>                  */
>                 if (info & MT_TX_FREE_PAIR) {
>                         struct mt7921_sta *msta;
> -                       struct mt76_wcid *wcid;
>                         u16 idx;
>
>                         count++;
> @@ -658,6 +658,12 @@ static void mt7921_mac_tx_free(struct mt7921_dev *de=
v, void *data, int len)
>                 msdu =3D FIELD_GET(MT_TX_FREE_MSDU_ID, info);
>                 stat =3D FIELD_GET(MT_TX_FREE_STATUS, info);
>
> +               if (wcid) {
> +                       wcid->stats.tx_retries +=3D
> +                               FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
> +                       wcid->stats.tx_failed +=3D !!stat;
> +               }
> +
>                 txwi =3D mt76_token_release(mdev, msdu, &wake);
>                 if (!txwi)
>                         continue;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 0c9a472bc81a..418a1fa67477 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1400,6 +1400,12 @@ static void mt7921_sta_statistics(struct ieee80211=
_hw *hw,
>                 sinfo->txrate.he_dcm =3D txrate->he_dcm;
>                 sinfo->txrate.he_ru_alloc =3D txrate->he_ru_alloc;
>         }
> +       sinfo->tx_failed =3D msta->wcid.stats.tx_failed;
> +       sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_TX_FAILED);
> +
> +       sinfo->tx_retries =3D msta->wcid.stats.tx_retries;
> +       sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
> +
>         sinfo->txrate.flags =3D txrate->flags;
>         sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
>
> --
> 2.18.0
>
