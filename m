Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA261E1769
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 12:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbfJWKLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 06:11:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36211 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390933AbfJWKLD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 06:11:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so16821374qto.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45UH3jeZS+STm/wq23wqrF1WBf2AHal/DsaqIpXgXro=;
        b=uiwfWWz51TgMN4zK/OjfTR6icjwXobD6pklhiTYCecLtyiyMH64zINMBzMGs8se07f
         s/NWmmEgqDhLILPwUYEJm14ygukTrij6NnqSc7lxWcfZnwjw4Yt+RHfm7oDEF9SgXtJw
         t3afas224I1h2Vvlf/LgEQa0nUSCjO2geDICQlC07VitCmdd3akY+8in+4vqt6p7Vg+P
         uOiHLlC5mmFQKY+QxXTnMcTEfJ8lzs3/lwtrBOI09M2uJID61VaRVFoCcCKCJqfpYYFE
         3bV7R96sQ6vaUgsI19Wvaxkd77fUWgWa5Hl4ewMyE6rc1W8UZCDNdSnRZJisbeb9uT+V
         j3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45UH3jeZS+STm/wq23wqrF1WBf2AHal/DsaqIpXgXro=;
        b=jsXgNLsqhqj5OVtvCVIGi0/lUbl65phzwzaV8jw/klhjVOQVyZsVzDQqIa5A+AaPJS
         PbzXgQsvFd8qS5LWoCNYDdfbnoWjRPl9cu0e2UYK/gtTyvV9vVTenwo00pn+ATBtaZSM
         hhWhiETjIu2YsDoxz/q/N+cjWeJ2Fo5dXQ4TgzWW+4jPMlya7QmYWcbg4JhFH/RTADci
         5Xk9kLqL26h5G8k2rITO2iVx2RZt6rIcYYcZ49fAfbb4YSW5x86/Uwl7UZBwanE8QzPV
         H6MXow3NT3I2l7/ZB/350XKTQ5yzZdU1+BFCUxNNZYxfe7bx4AhJdFZVtdSvkhk4VYwo
         0bhg==
X-Gm-Message-State: APjAAAUkhvmEgt8wIww/gRfC2cy4PJ5RgCtMmj2xToKQOmDpe5tGWByc
        sHIHcc/1QpTZA6NLARUZaJ2WLHDqp/3hLw0thYTqOw==
X-Google-Smtp-Source: APXvYqy6glbhg/aUJCYFMAN9SuvCYntlkCtO/zF6EuEITpgQ95c+mqQohRDXiHboJuAhK6cSgRMv0Oioo1QNX6Cfcw0=
X-Received: by 2002:aed:3c49:: with SMTP id u9mr8054139qte.37.1571825461426;
 Wed, 23 Oct 2019 03:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191023075342.26656-1-yuehaibing@huawei.com>
In-Reply-To: <20191023075342.26656-1-yuehaibing@huawei.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 23 Oct 2019 18:10:50 +0800
Message-ID: <CAB4CAwek7u3_U9T_314P7qK2o7ReKQ0EVvYTkyzrORZjhdSRnA@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: remove set but not used variable 'rate_mask'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 23, 2019 at 3:54 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:4484:6:
>  warning: variable rate_mask set but not used [-Wunused-but-set-variable]
>
> It is never used since commit a9bb0b515778 ("rtl8xxxu: Improve
> TX performance of RTL8723BU on rtl8xxxu driver")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
Singed-off-by: Chris Chiu <chiu@endlessm.com>

>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 1e3b716..3843d7a 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4481,11 +4481,6 @@ static u16
>  rtl8xxxu_wireless_mode(struct ieee80211_hw *hw, struct ieee80211_sta *sta)
>  {
>         u16 network_type = WIRELESS_MODE_UNKNOWN;
> -       u32 rate_mask;
> -
> -       rate_mask = (sta->supp_rates[0] & 0xfff) |
> -                   (sta->ht_cap.mcs.rx_mask[0] << 12) |
> -                   (sta->ht_cap.mcs.rx_mask[0] << 20);
>
>         if (hw->conf.chandef.chan->band == NL80211_BAND_5GHZ) {
>                 if (sta->vht_cap.vht_supported)
> --
> 2.7.4

Thanks for pointing that out.

Chris
