Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B6C159FDC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 05:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBLEQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 23:16:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36159 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBLEQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 23:16:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so782409oic.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2020 20:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29Uh+kMpMAjpJIWcFLeIZR24KwnCsHLITYC7GDjpcIw=;
        b=hzr7KIScne9CXB1YxC0sofe2FfFAt3PQZZz4VQncX4cxCjSrfK4j/tGNByz33fu+t3
         Y/lfALjhdRcM6sj3bwknBhmH+p0wQDd1CXZPrkyQtmozARkEmD6u3tj1TMmES4ws7XBG
         uInYbYN2na0VTTRSfZtd0XxZrsvK2pAu9DbCFeRL6uRFYVihpOk7csnp2XB5fS2Rx0RV
         pnKTk0+c12rL5zuYF6Q/zkDiGFzkt04iaTRJ+Rw9FTQLJ6WrxVdW92aHcoqXTkdBAQ7g
         ydtqUVAE0eQWF4dVpYhm+evnAntWveUKwERHKcdor/PSeqW0VWFJK5b5Jg76gPXR7Tkn
         rf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29Uh+kMpMAjpJIWcFLeIZR24KwnCsHLITYC7GDjpcIw=;
        b=fmfe/8I7NCJI2tlii7hhB8IX5ZXL/sbZPtSLD8IHpF8b94ZwISNePr/c20s8AnSsnK
         TWZGXE8HL+bUchr1W+g5wgHRaWmdiRaD1WcC/0J+E83XN228VbuUg478YnCxtEMJgz5O
         9RI1eovi87hUeLLVmzP+pH+L+rCrHPnPoqbBN4x1tfdZnX8pLxZYKwETLb79Za3kGSsW
         na3LVV+ldHbAbzPgVj8sxtjrlYAeXKI/3WInqE53sz3Y64Zrjv7z9WRC0dPBDl2PcJ9Y
         gp9hqRpQWJIUO50S8Rcb/d9QsMU7xBfRhScZMKwvw5K2ELXEq6w2dSSdjLH1LPJvQ/li
         9zlw==
X-Gm-Message-State: APjAAAW6BzKhSh3iQ3//hid05HS9iB8b3XZlDRrWcc1Ih2NskQE659A2
        mJbF7LIHAgqE1lc+GszM4pAF2OzMcommbEdg/bUBiA==
X-Google-Smtp-Source: APXvYqx9TTQc7/6ZuCOTHktbhb3vSrrjvSLCeHOVXbuBIgCnyfBr6X77nUV46Xajx1BzjQVmp00Fc4X1uVskozd5vjU=
X-Received: by 2002:aca:ab53:: with SMTP id u80mr4890311oie.94.1581480990050;
 Tue, 11 Feb 2020 20:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20200205070858.15386-1-yhchuang@realtek.com> <20200205070858.15386-5-yhchuang@realtek.com>
In-Reply-To: <20200205070858.15386-5-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 12 Feb 2020 12:16:19 +0800
Message-ID: <CAB4CAweOc=BWhE3eUaVh3t4QZeAMF7nPxJWzv5j0tFd2nVphZA@mail.gmail.com>
Subject: Re: [PATCH 4/7] rtw88: move rtw_enter_ips() to the last when config
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
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> When driver is coming up, mac80211 will set changed as ~0 (0xffffffff),
> and driver could enter IDLE state (power off) before switching channel or
> other config event. So move rtw_enter_ips() to the last, to make sure the
> driver completed the config events before going to IDLE state.
>
> So, moves leave/enter IPS config to be first/last one according to flag
> IEEE80211_CONF_IDLE. If there're more configureations we want to add in
> the future, they must locate between leave/enter IPS.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>
>  drivers/net/wireless/realtek/rtw88/mac80211.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
> index 6fc33e11d08c..8742b3f2b5c1 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -75,15 +75,12 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
>
>         rtw_leave_lps_deep(rtwdev);
>
> -       if (changed & IEEE80211_CONF_CHANGE_IDLE) {
> -               if (hw->conf.flags & IEEE80211_CONF_IDLE) {
> -                       rtw_enter_ips(rtwdev);
> -               } else {
> -                       ret = rtw_leave_ips(rtwdev);
> -                       if (ret) {
> -                               rtw_err(rtwdev, "failed to leave idle state\n");
> -                               goto out;
> -                       }
> +       if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
> +           !(hw->conf.flags & IEEE80211_CONF_IDLE)) {
> +               ret = rtw_leave_ips(rtwdev);
> +               if (ret) {
> +                       rtw_err(rtwdev, "failed to leave idle state\n");
> +                       goto out;
>                 }
>         }
>
> @@ -99,6 +96,10 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
>         if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
>                 rtw_set_channel(rtwdev);
>
> +       if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
> +           (hw->conf.flags & IEEE80211_CONF_IDLE))
> +               rtw_enter_ips(rtwdev);
> +
>  out:
>         mutex_unlock(&rtwdev->mutex);
>         return ret;
> --
> 2.17.1
>
