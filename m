Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E259129E5C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 08:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLXHRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 02:17:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35913 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXHRX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 02:17:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so12794048otz.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2019 23:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pHzHYXUZgtzZHcL7StekrTgcsrng/H/oFj4ngI4sio=;
        b=Sat7hJC49t1PrRH61Vl4TgkMQmB40DMJgQhstW5vgo7THnW8AauY7psTW26Cg40HJO
         7M+wC6xtVGRKDMBsobRwzVAbI4+yacvGbklQJ4YbV/+ZgVsUffYLIAZips9wumHQQaUa
         5YpJeIVdRAwq7FO8y3Vt2BvhYiDkwt4VNv6022MjHAyNiMY7KEyv/ai2Wg/xPesEg79V
         BiifILEQlALEJtvpd/TqIoT+HDIHVx8wKrIfAz+h01Du0kaXomWRy56lW7DZkQfZa/BV
         aVS158AGaCByPjQhPqSjjcLwdzNokjpc0UgPjgHbwFcF9qtvzutGCOdTME2Awirho2jM
         wf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pHzHYXUZgtzZHcL7StekrTgcsrng/H/oFj4ngI4sio=;
        b=YCKECjppwDb0SPiYeYHvFYv5WfLVwYT2NV1wKeXYKRaOBfubKmfHzCihDNc71MWIEV
         j9KvAdddDM4IroLw8o/NGTLyFWIXj4ecp8hsuasLuKkm+dcBYyTgOlN67XTMzHTxFtKc
         iidxtzh1enaDXeJBOxPjmHlHHzTU+rrpsRSj2qHlPwHl3K4GnUWPG/KgGeCm2Na6egua
         XmydxT+VFHA1bWqdmEuMJMUgEDunu1v+Cj81HGTCZu+dFzOkoDNoVx1Qxot69n9d7Yhu
         fGjkTAxVn+adXMFQMy82jMl7GC36aJuBfN9i+aMvBkq/qmIphQs+ZZ2swH4Mta65FA4l
         edMg==
X-Gm-Message-State: APjAAAX9gPxrkg6Br6zc3AkB0x8nQ5YBaSOiAT/QkjTczbiGL2NKDmOk
        haiimut2EmGk4YzAuXacl3HXRiBxvuTA7EiBglQOz344vhk=
X-Google-Smtp-Source: APXvYqwIdwVB2sh1SAYkIAgavWYv5Xxv2tO0U2OScGAdWY994ujQ75Q9nyDm7+CyxFAuEEvmxU6EnpbK7YOVIxL0Ge8=
X-Received: by 2002:a9d:2c68:: with SMTP id f95mr37620859otb.33.1577171842267;
 Mon, 23 Dec 2019 23:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20191220092156.13443-1-yhchuang@realtek.com> <20191220092156.13443-4-yhchuang@realtek.com>
In-Reply-To: <20191220092156.13443-4-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 24 Dec 2019 15:18:54 +0800
Message-ID: <CAB4CAwcM+4toAfawgM40YZCNbHcHVOKJd0VWVJNSWki8n2PN1A@mail.gmail.com>
Subject: Re: [PATCH 03/11] rtw88: Use secondary channel offset enumeration
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 20, 2019 at 5:22 PM <yhchuang@realtek.com> wrote:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> The hardware value of secondary channel offset isn't very intuitive. This
> commit adds enumeration, so we can easier to check the logic with the
> suffix of enumeration name, likes _UPPER or _LOWER.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/mac.c      |  6 +++---
>  drivers/net/wireless/realtek/rtw88/main.c     | 14 +++++++-------
>  drivers/net/wireless/realtek/rtw88/main.h     | 10 ++++++++++
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 +-
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 +-
>  5 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
> index ed9bb427ba60..94d1b179e2e1 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> @@ -17,10 +17,10 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
>
>         txsc20 = primary_ch_idx;
>         if (bw == RTW_CHANNEL_WIDTH_80) {
> -               if (txsc20 == 1 || txsc20 == 3)
> -                       txsc40 = 9;
> +               if (txsc20 == RTW_SC_20_UPPER || txsc20 == RTW_SC_20_UPPERST)
> +                       txsc40 = RTW_SC_40_UPPER;
>                 else
> -                       txsc40 = 10;
> +                       txsc40 = RTW_SC_40_LOWER;
>         }
>         rtw_write8(rtwdev, REG_DATA_SC,
>                    BIT_TXSC_20M(txsc20) | BIT_TXSC_40M(txsc40));
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index f369ddca953a..cc61c390226c 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -333,10 +333,10 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
>                 bandwidth = RTW_CHANNEL_WIDTH_80;
>                 if (primary_freq > center_freq) {
>                         if (primary_freq - center_freq == 10) {
> -                               primary_chan_idx = 1;
> +                               primary_chan_idx = RTW_SC_20_UPPER;
>                                 center_chan -= 2;
>                         } else {
> -                               primary_chan_idx = 3;
> +                               primary_chan_idx = RTW_SC_20_UPPERST;
>                                 center_chan -= 6;
>                         }
>                         /* assign the center channel used
> @@ -345,10 +345,10 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
>                         cch_by_bw[RTW_CHANNEL_WIDTH_40] = center_chan + 4;
>                 } else {
>                         if (center_freq - primary_freq == 10) {
> -                               primary_chan_idx = 2;
> +                               primary_chan_idx = RTW_SC_20_LOWER;
>                                 center_chan += 2;
>                         } else {
> -                               primary_chan_idx = 4;
> +                               primary_chan_idx = RTW_SC_20_LOWEST;
>                                 center_chan += 6;
>                         }
>                         /* assign the center channel used
> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
> index d012eefcd0da..144fbab38fd5 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> @@ -95,6 +95,16 @@ enum rtw_bandwidth {
>         RTW_CHANNEL_WIDTH_10    = 6,
>  };
>
> +enum rtw_sc_offset {
> +       RTW_SC_DONT_CARE        = 0,
> +       RTW_SC_20_UPPER         = 1,
> +       RTW_SC_20_LOWER         = 2,
> +       RTW_SC_20_UPPERST       = 3,

I'll suppgest RTW_SC_20_UPMOST instead or simply RTW_SC_20_UPPEREST.

> +       RTW_SC_20_LOWEST        = 4,
> +       RTW_SC_40_UPPER         = 9,
> +       RTW_SC_40_LOWER         = 10,
> +};
> +
>  enum rtw_net_type {
>         RTW_NET_NO_LINK         = 0,
>         RTW_NET_AD_HOC          = 1,
> --
> 2.17.1
>
