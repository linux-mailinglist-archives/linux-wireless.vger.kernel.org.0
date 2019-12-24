Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C154129E56
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 08:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfLXHIi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 02:08:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46073 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXHIi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 02:08:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so25226428otp.12
        for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2019 23:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlC/KEoNnXFvGX6vluIhRXbfrY2pnhWjj5XiiMACW5k=;
        b=Q2grH3YjqWsK5VQSayzmT+drPMwExC0qKUjSCwdOGHLYh33OQmVQ8eKgwYPSyGkR6L
         RViuyjJQ35Kle44JcsNj5+9ZjCxOkVXnpTiv49EwdVjg8WTtXg0TvarwBDyPzDEH4QSI
         hep0+dmQjAe5RCzP5rFsAEKu1WB4zX+rM+eyuXhTxYsziVRNF32G2maJ2BLo4GgIlGet
         SS6BcBySFXhsCmSkh2mdreHCfhrhVvL1sA66/JGlz/QO1fQXaITt6NqA7/X+XQEXuwdt
         GNBDSXJGHhk2xXRFGnMksyTuHwW4WIgItzzEKvdBE/lXpkJAETGQ++0jNBTGQ9QHyMek
         oGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlC/KEoNnXFvGX6vluIhRXbfrY2pnhWjj5XiiMACW5k=;
        b=Cq8gd5K5h2nXoblTH9SDJYwqkMCO8H5I9FSH0XBL94HuwthAGOJZ9y9uVWNVqptCxu
         pZYsN280rugFhkbYlcZgDdQacyiDhbyUGED4bb8PNvFUrznflsXn0tUh4qqjLXn3Wa8f
         AI+Xvm1IdtTLZLdqbGssXQDDuf6pSZegDFWHEj4fWWAukLuXvk/KvI91LQxdCAt/BwiN
         cnD5bzrBbMdODntHIXSPfmg5gysdzosnhTBBAJIzbROgPTUDOPHZr5/j+eXxXMQfdi9g
         VYpNvsBfZuUuHT0E/ijgkW7cdd5uPT4lMHhqe6CLWL8bgGIR9LkfeWrlRa1uUfjpIssg
         +0Kg==
X-Gm-Message-State: APjAAAXkr0rvOcV05XPAG9ApFV/XMvtH6kPfPcRihZ++RdkSyJkTcL7w
        WR9w1kGXYjDJgQF5ab4g1JmF/9+RgkwWD+tXB93hKg==
X-Google-Smtp-Source: APXvYqzhGtSfhUcf5+fL/RdMo9R85YcW3PnpZt67bSHnHKFyEMRh+lUk1ZCqxHpQJUPFR+1ayPBLHJ5DyldqT7GbwVk=
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr36862369otp.202.1577171316846;
 Mon, 23 Dec 2019 23:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20191220092156.13443-1-yhchuang@realtek.com> <20191220092156.13443-2-yhchuang@realtek.com>
In-Reply-To: <20191220092156.13443-2-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 24 Dec 2019 15:10:09 +0800
Message-ID: <CAB4CAwdW=KYwHJwWmZwzeHVf5aQfvwtXBS+CNaotA7j-0Vx6FQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] rtw88: fix rate mask for 1SS chip
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
> The rate mask is used to tell firmware the supported rate depends on
> negotiation. We loop 2 times for all VHT/HT 2SS rate mask first, and then
> only keep the part according to chip's NSS.
>
> This commit fixes the logic error of '&' operations for VHT/HT rate, and
> we should run this logic before adding legacy rate.
>
> To access HT MCS map, index 0/1 represent MCS 0-7/8-15 respectively. Use
> NL80211_BAND_xxx is incorrect, so fix it as well.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>

>  drivers/net/wireless/realtek/rtw88/main.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index ae61415e1665..f369ddca953a 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -706,8 +706,8 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
>                 if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
>                         is_support_sgi = true;
>         } else if (sta->ht_cap.ht_supported) {
> -               ra_mask |= (sta->ht_cap.mcs.rx_mask[NL80211_BAND_5GHZ] << 20) |
> -                          (sta->ht_cap.mcs.rx_mask[NL80211_BAND_2GHZ] << 12);
> +               ra_mask |= (sta->ht_cap.mcs.rx_mask[1] << 20) |
> +                          (sta->ht_cap.mcs.rx_mask[0] << 12);
>                 if (sta->ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
>                         stbc_en = HT_STBC_EN;
>                 if (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
> @@ -717,6 +717,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
>                         is_support_sgi = true;
>         }
>
> +       if (efuse->hw_cap.nss == 1)
> +               ra_mask &= RA_MASK_VHT_RATES_1SS | RA_MASK_HT_RATES_1SS;
> +
>         if (hal->current_band_type == RTW_BAND_5G) {
>                 ra_mask |= (u64)sta->supp_rates[NL80211_BAND_5GHZ] << 4;
>                 if (sta->vht_cap.vht_supported) {
> @@ -750,11 +753,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
>                 wireless_set = 0;
>         }
>
> -       if (efuse->hw_cap.nss == 1) {
> -               ra_mask &= RA_MASK_VHT_RATES_1SS;
> -               ra_mask &= RA_MASK_HT_RATES_1SS;
> -       }
> -
>         switch (sta->bandwidth) {
>         case IEEE80211_STA_RX_BW_80:
>                 bw_mode = RTW_CHANNEL_WIDTH_80;
> --
> 2.17.1
>
