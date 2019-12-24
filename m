Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB1129E76
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 08:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfLXHiK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Dec 2019 02:38:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46300 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXHiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Dec 2019 02:38:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id k8so8158636otl.13
        for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2019 23:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APLhGG6lHxG3WrLwd3GLeSKzLK84+kkbSD7Igp8t98s=;
        b=axmHJGAjn3h23TdD0vt6See++rplYz+7dOL2OefpX9gG7QfLnkWoZSdYR9AORisjZP
         Rx/HG9CoeEF/T+8ae8zH46zqPWVipgTvNwAoxwYDVKfrfwqJBsaieDv2Y/r4iwn5V4ia
         Qqx8EzIroVmB8/NYejQkiAhrlAEFOaaAEXb8LS7nOWg7yeeHNFAN/8wPffLpK99UMpjA
         7xOX8mKC9hO3kIRBeF9U/RLSfye8KWQsKU4TH+cv/pPgjR2wzbVk79XbqA1l4Re/oSFo
         8j9mgDA5N+objNbzal610Bv7ds+JyO6RjlRWUIxS78MOeroLpG1hiP4jjVw9fq5tjC3/
         sHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APLhGG6lHxG3WrLwd3GLeSKzLK84+kkbSD7Igp8t98s=;
        b=QFzMqeLPsuAv0y+2q4ndOOb3xJR6gFWsLEu4m9hpEb1WdSbC5KOfqPJfreXhA4fQay
         LdTZ/T58HlZZLCShD/lc9egAu/jDJIRFdburyNWzm7vwlrbSDuXg/qWYWg22nJz2LNN0
         rDnQygIMbnfba1eXy8zgxKrinJCtERIMzPgyrJfHgAugnXHMt3VMtGOJ8vOmea+Zwsyl
         NQoCZ7wmooNi12xioxR0bVgeIYOJW6qjobuz5ApD4sU5dI8vMTH7buiBaLZ/rIicxdJ7
         jkvPf/GFDSGq1vwX7Md97FTyH9rqmxCpVujgAlqTBBVBWsxNPW0TYGJJXERBBVQde47j
         wNMw==
X-Gm-Message-State: APjAAAXa/TCpL2EVk2jktys64ot/fYXJzPcQ6Txqn1G56mpF1kHmh/mH
        mu/3+dPgNwLphQpgtzrHVeZo3V3GOItziQb1wDxrng==
X-Google-Smtp-Source: APXvYqwSfpzLy7G0QH4QpTIKpGvRi3WvFE6wXQa3hITBzVrnWdVKaBQox0MKIsVkjqr3L3SrIohkbAc13v7jnhbMnwQ=
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr36972980otp.202.1577173089209;
 Mon, 23 Dec 2019 23:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20191220092156.13443-1-yhchuang@realtek.com> <20191220092156.13443-6-yhchuang@realtek.com>
In-Reply-To: <20191220092156.13443-6-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 24 Dec 2019 15:39:40 +0800
Message-ID: <CAB4CAwfhn10dWO8Fr5Bk1PMOAYTC-RVK2fVsh92kUDxdsr3+ZA@mail.gmail.com>
Subject: Re: [PATCH 05/11] rtw88: 8822c: modify rf protection setting
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
> From: Chien-Hsun Liao <ben.liao@realtek.com>
>
> According to some experiments, the original rf protection
> setting can not perfectly make sure that there is no hardware
> pi write during the direct write. So, modify the setting so
> that the hardware block of pi would be turned off during the
> direct write.
>

Sorry, I don't really understand this part. Does it mean rtw8822c_rstb_3wire()
is to disable/enable the hardware block of PI? In this patch, I can only
see the code block of ENABLE_PI/DISABLE_PI been removed and some
rtw_write_rf()s been protected by new rtw8822c_rstb_3wire(). If the new
function is to replace the ENABLE_PI/DISABLE_PI, maybe they should be
removed in the reg.h. And It seems rtw8822c_rstb_3wire() is only for 8822c,
means there's no such problem for 8822b?

Chris

> Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/phy.c      | 10 ----------
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 15 +++++++++++++++
>  drivers/net/wireless/realtek/rtw88/rtw8822c.h |  5 +++++
>  3 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
> index a3e1e9578b65..4b2f11be60cf 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -749,20 +749,10 @@ bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
>         direct_addr = base_addr[rf_path] + (addr << 2);
>         mask &= RFREG_MASK;
>
> -       if (addr == RF_CFGCH) {
> -               rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, DISABLE_PI);
> -               rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, DISABLE_PI);
> -       }
> -
>         rtw_write32_mask(rtwdev, direct_addr, mask, data);
>
>         udelay(1);
>
> -       if (addr == RF_CFGCH) {
> -               rtw_write32_mask(rtwdev, REG_RSV_CTRL, BITS_RFC_DIRECT, ENABLE_PI);
> -               rtw_write32_mask(rtwdev, REG_WLRF1, BITS_RFC_DIRECT, ENABLE_PI);
> -       }
> -
>         return true;
>  }
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> index 7c8db951a5bc..4231f94d515e 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -1289,6 +1289,17 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
>         return 0;
>  }
>
> +static void rtw8822c_rstb_3wire(struct rtw_dev *rtwdev, bool enable)
> +{
> +       if (enable) {
> +               rtw_write32_mask(rtwdev, REG_RSTB, BIT_RSTB_3WIRE, 0x1);
> +               rtw_write32_mask(rtwdev, REG_ANAPAR_A, BIT_ANAPAR_UPDATE, 0x1);
> +               rtw_write32_mask(rtwdev, REG_ANAPAR_B, BIT_ANAPAR_UPDATE, 0x1);
> +       } else {
> +               rtw_write32_mask(rtwdev, REG_RSTB, BIT_RSTB_3WIRE, 0x0);
> +       }
> +}
> +
>  static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
>  {
>  #define RF18_BAND_MASK         (BIT(16) | BIT(9) | BIT(8))
> @@ -1337,6 +1348,8 @@ static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
>                 break;
>         }
>
> +       rtw8822c_rstb_3wire(rtwdev, false);
> +
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWE2, 0x04, 0x01);
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWA, 0x1f, 0x12);
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTWD0, 0xfffff, rf_rxbb);
> @@ -1349,6 +1362,8 @@ static void rtw8822c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
>
>         rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, rf_reg18);
>         rtw_write_rf(rtwdev, RF_PATH_B, RF_CFGCH, RFREG_MASK, rf_reg18);
> +
> +       rtw8822c_rstb_3wire(rtwdev, true);
>  }
>
>  static void rtw8822c_toggle_igi(struct rtw_dev *rtwdev)
> --
> 2.17.1
>
