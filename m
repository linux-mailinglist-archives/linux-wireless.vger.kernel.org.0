Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195F148CE56
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 23:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiALWZT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 17:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiALWZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 17:25:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B886AC06173F;
        Wed, 12 Jan 2022 14:25:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k30so6760036wrd.9;
        Wed, 12 Jan 2022 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFfo0SP0eYuiEoDo0F07MxHnumYuJPJyQNP8v/MaqJg=;
        b=lywxs9slhut3KF4qmDOVf2RmCTGCFRnHA8dK0EN/kiRpTDeOh49TPN5ZWnSTEXmlGy
         FXU9v02rvQRmcrqsCsMxrvDu5UmKtxVM0ENptyfgMR2j2iGKtaPVp11wUdPNMEtpohb8
         ge3vh/0iwWTf/i1wZd1S5UEiT5cDUSc066MnahHvEZQUpvOqJSbjl7a2fiWUtB86ni6M
         JivM6mFO5I69ykaX1QrA+2S0fsFbEbfvmFMgxjn1ybJI24CQcJD4zuQafLWTnwyoKGlb
         tYB2mP4+tFN3d0vAir914X1LVuetLLafg2Z9TN5ceGW4r5rHaMrqtIUxmsHTHKB6l8Ej
         mHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFfo0SP0eYuiEoDo0F07MxHnumYuJPJyQNP8v/MaqJg=;
        b=FxYWdBHJLZSs2/jvPXP4CUBPd3/QBkkd9vLeIdo4bBWZQdf9JUdIoaWV/Vg92RJISI
         QFc8FEyp0ucAjJU3uJ3VZxudeHhWwQmesCpsCy9isEA0OUR3PL+Y0lGIBeS1HyH6lYPX
         9S5IE7cB+doHoQt4mwYWamMB2aTp+umNx8zWMV0QXQU8NHcBUXyjQYUZWf6jHCGN8/X3
         Ay/G7SUatc1OcU+egNl53L5ea2Nlv1PdTAIScdA3d2hS9xRTLImzzRHyMh0lQx4WP0Mh
         Zm0rf2SySN9SdMuqw7c+Mqx5WHu+uFWk55KhWXrq5l87B2tPp5KRHct2QfpGMu7pP5sa
         gMdw==
X-Gm-Message-State: AOAM530K8wieXXlxGryffOWCTx0zMoIxDHN/IMnMlMvKQ4yxPvqxSCF2
        e97apSog+eE61XrJeoKOZwrMeomaxk/jjxPGEgI=
X-Google-Smtp-Source: ABdhPJyDon5z/3defDEYdf9XudXjSoUZ6JgkMTKg7cnrtgyNHI5U2DO7YfKH70Y0h/5pzxVNRKYk4xBpI2cIr3rVpCk=
X-Received: by 2002:adf:e190:: with SMTP id az16mr1517104wrb.207.1642026313038;
 Wed, 12 Jan 2022 14:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20220112173312.764660-1-miquel.raynal@bootlin.com> <20220112173312.764660-7-miquel.raynal@bootlin.com>
In-Reply-To: <20220112173312.764660-7-miquel.raynal@bootlin.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Wed, 12 Jan 2022 17:25:01 -0500
Message-ID: <CAB_54W68GQmsV70w0uUWvz8-V_Yf+FHfc23k2es53REqWMBY8Q@mail.gmail.com>
Subject: Re: [wpan-next v2 06/27] net: mac802154: Set the symbol duration automatically
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Harry Morris <h.morris@cascoda.com>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Xue Liu <liuxuenetmail@gmail.com>, Alan Ott <alan@signal11.us>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-wireless@vger.kernel.org Wireless" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Wed, 12 Jan 2022 at 12:33, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Now that we have access to all the basic information to know which
> symbol duration should be applied, let's set the symbol duration
> automatically. The two locations that must call for the symbol duration
> to be set are:
> - when manually requesting a channel change though the netlink interface
> - at PHY creation, ieee802154_alloc_hw() already calls
>   ieee802154_change_channel() which will now update the symbol duration
>   accordingly.
>
> If an information is missing, the symbol duration is not touched, a
> debug message is eventually printed. This keeps the compatibility with
> the unconverted drivers for which it was too complicated for me to find
> their precise information. If they initially provided a symbol duration,
> it would be kept. If they don't, the symbol duration value is left
> untouched.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/cfg802154.h |  2 +
>  net/mac802154/cfg.c     |  1 +
>  net/mac802154/main.c    | 93 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 286709a9dd0b..52eefc4b5b4d 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -455,4 +455,6 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
>         return dev_name(&phy->dev);
>  }
>
> +void ieee802154_set_symbol_duration(struct wpan_phy *phy);
> +
>  #endif /* __NET_CFG802154_H */
> diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> index 6969f1330ccd..ba57da07c08e 100644
> --- a/net/mac802154/cfg.c
> +++ b/net/mac802154/cfg.c
> @@ -113,6 +113,7 @@ int ieee802154_change_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
>         if (!ret) {
>                 wpan_phy->current_page = page;
>                 wpan_phy->current_channel = channel;
> +               ieee802154_set_symbol_duration(wpan_phy);
>         }
>
>         return ret;

We also need to do it in ieee802154_register_hw()?

> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index 77a4943f345f..88826c5aa4ba 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -113,6 +113,99 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>  }
>  EXPORT_SYMBOL(ieee802154_alloc_hw);
>
> +void ieee802154_set_symbol_duration(struct wpan_phy *phy)
> +{
> +       struct phy_page *page = &phy->supported.page[phy->current_page];
> +       struct phy_channels *chan;
> +       unsigned int chunk;
> +       u32 duration = 0;
> +
> +       for (chunk = 0; chunk < page->nchunks; chunk++) {
> +               if (page->chunk[chunk].channels & phy->current_channel)
> +                       break;
> +       }
> +
> +       if (chunk == page->nchunks)
> +               goto set_duration;
> +
> +       chan = &page->chunk[chunk];
> +       switch (chan->protocol) {
> +       case IEEE802154_BPSK_PHY:
> +               switch (chan->band) {
> +               case IEEE802154_868_MHZ_BAND:
> +                       /* 868 MHz BPSK 802.15.4-2003: 20 ksym/s */
> +                       duration = 50 * 1000;

* NSEC_PER_USEC?

- Alex
