Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8E9159F35
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 03:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBLCxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 21:53:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42634 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbgBLCxW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 21:53:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so438087otd.9
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2020 18:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JVHyMRshJXOKEjCgmkdQivIrJqGf+AawLdHBhC7AJw=;
        b=T9HPV29XEidbB8MdWjbXFEiTqDJTv/vAiDb7QVPAP4HAULyM3argQ6Acc0VnMva2xH
         JOYY/IB1glXlBe9S3BQL45QnlZwJTktuim6Kqou52+wPWojIbEadnxmVhsAdaXl1Mka4
         OPINu5IuFV3E1KKCv6W39fGYqnsP9EV2MdKETggIblSgGPmWJKKKcEXFOJn+5hg5pIbI
         m9lppal0hdHUSHMkcdIMMddD1V5ZYr5RSg89zRfbg6+qW4/XhDr+HEhGjF506gpW09o3
         V2TeIRJigR54xCbGKQU/5si5nUbfVwunTME+WAW2GZ/BsjEILWTibBuRF7iq8hvucFR4
         EPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JVHyMRshJXOKEjCgmkdQivIrJqGf+AawLdHBhC7AJw=;
        b=hBYeuVGo/77kWEHy7NmdV2pUZbLr4SSmQNXGgabkKogGOKWe1flqwRLfn0lo3kJp8k
         FHb76tf9k3d05LQ0bctg0hgoH6TkheWbIVrqA0ZsX1wAxsvu73/3nHrvocVrIXI14ewe
         DAa+vqYx9h3uXP7TzY5CyqOvFN3MG2WfQrVMJ11YtIMuhJezHzuxjS8nK1+MoPRyLIKM
         isEQqX2obwaduB4bs2fYGaNp6EClmfLk4CjdmW/4sknfLqPK5sL/7vfI5f7XkI3FnER4
         knFRGJa8nJ3OcFE0/Qv4eiIir59bBobKB7lYeIR3TXekpjgZK7OfBkCdhKZUxlW9cP2h
         tPJA==
X-Gm-Message-State: APjAAAWW8YjMMjBdSiAkZrzEsr77NDOsJ/cScJluQAZYqIxHGewa5yyg
        dMRKrMpLGcR+4hwNfjKueR8fWKOscLVOe3+WzzdNUQ==
X-Google-Smtp-Source: APXvYqzMSEdApsyStboWvYJN9PDbepQ/B8z1oZa9bKiHzf3j6URnONDRJfCVJ9V80y2KK93CxAb9u43ZCy5+kMw3OIM=
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr7670904otb.33.1581476000364;
 Tue, 11 Feb 2020 18:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20200205070858.15386-1-yhchuang@realtek.com> <20200205070858.15386-2-yhchuang@realtek.com>
In-Reply-To: <20200205070858.15386-2-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 12 Feb 2020 10:53:09 +0800
Message-ID: <CAB4CAwcGBszyKVqhnyFOOZXUVe27f-YPorqV1G8ifKQUPj_MHw@mail.gmail.com>
Subject: Re: [PATCH 1/7] rtw88: remove unused parameter vif in rtw_lps_pg_info_get()
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 5, 2020 at 3:09 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> vif is not used, remove it
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>

>  drivers/net/wireless/realtek/rtw88/fw.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> index 243441453ead..b765b26b6926 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -819,8 +819,7 @@ static struct sk_buff *rtw_lps_pg_dpk_get(struct ieee80211_hw *hw)
>         return skb;
>  }
>
> -static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw,
> -                                          struct ieee80211_vif *vif)
> +static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw)
>  {
>         struct rtw_dev *rtwdev = hw->priv;
>         struct rtw_chip_info *chip = rtwdev->chip;
> @@ -876,7 +875,7 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
>                 skb_new = rtw_lps_pg_dpk_get(hw);
>                 break;
>         case RSVD_LPS_PG_INFO:
> -               skb_new = rtw_lps_pg_info_get(hw, vif);
> +               skb_new = rtw_lps_pg_info_get(hw);
>                 break;
>         case RSVD_PROBE_REQ:
>                 ssid = (struct cfg80211_ssid *)rsvd_pkt->ssid;
> --
> 2.17.1
>
