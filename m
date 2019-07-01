Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1F5B3CC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 07:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGAFJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 01:09:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40615 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfGAFJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 01:09:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so10013752qkg.7
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2019 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0+3rkTOxrBQnGgZwbRK/n9QcJ7Vj4bYLlp4CkN2fVs=;
        b=TVF/0x0ySR+gK3cDJBD7zack+c+4yrlXDC6HXULmlnKE0AUu9lB5G/+Zm48nzlSf9f
         SO/QedbVeeX4tDOiuPuO8Pcnjk5f3ne8M27we0Q9YpcHhzO9xJqQfR+RxLkTSxQtrkGc
         GO3hV64lu8bv1jWmbpGrMJeUjiOJbcqbm5ymh5lAR2zDYQ6oT29V9xhCrFyLmAaWQNUy
         VzmmgkRrgTMTlIS1ENbH/rSTU5Tww/nI5QxACSrMnYCPuAgAkDnCsnmgVlF+hljggEcy
         qzS6ycwoCaVLdU2kCz5krIaIyB/L1VfpvXEboUANpye+MJD40uzzB5ta6F/A40ZrFrkq
         kKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0+3rkTOxrBQnGgZwbRK/n9QcJ7Vj4bYLlp4CkN2fVs=;
        b=DsUNbs6TJSQCdkE1eIOMCKDHy43QM0xC9QWPhx2xZcjy1kipHutiopLgjLvLlirKe6
         k8ni8AYwDTOvH1waEYe9WzpLCcF05PnyDeRwOMv4z9gO83r9qh8SLwP+E0gVTAqrRBji
         81yA88XY4n8tyEMpTUpyUpNhmwtbonc/k6oYVDdu984J4Cvx3NJZtejE1gBhQDrsOouw
         bX2aktLChP7dOfPZqU+P7avWdIjqEHHA1/aMWB+pwsHNrglzQwKHayncaFBN74F3SkW8
         tIOhlpwMRxhVTQ85Mk/JiVy05XHu558FtqxZhLaXMn9280sjv41bgTW3ZcPDx7ttY1e0
         2mRQ==
X-Gm-Message-State: APjAAAXs5Su11XJ3gzKODjGHSnHn5dfxVl9VEvJJyDHJEZ0uDDoYSEvX
        8StylHZ/cn/TgRMhicZzIicYcrox6opHwy4+oPIX3w==
X-Google-Smtp-Source: APXvYqxPXXMq+e6c2PMdwsMsZqvK6M7xzZTMcrRA5OHdGdm9CcEfDbc4yuhWL3bNvMjKuXVRF0G9orXxlMe58EWt/SY=
X-Received: by 2002:a37:a484:: with SMTP id n126mr17603801qke.366.1561957759898;
 Sun, 30 Jun 2019 22:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190627095247.8792-1-chiu@endlessm.com>
In-Reply-To: <20190627095247.8792-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 1 Jul 2019 13:09:09 +0800
Message-ID: <CAB4CAwcAfApWuwr_GDqSwN5w3tDOzR9p9ddck6JYrB+OAvWK8g@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Fix wifi low signal strength issue of RTL8723BU
To:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 27, 2019 at 5:52 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> The WiFi tx power of RTL8723BU is extremely low after booting. So
> the WiFi scan gives very limited AP list and it always fails to
> connect to the selected AP. This module only supports 1x1 antenna
> and the antenna is switched to bluetooth due to some incorrect
> register settings.
>
> This commit hand over the antenna control to PTA, the wifi signal
> will be back to normal and the bluetooth scan can also work at the
> same time. However, the btcoexist still needs to be handled under
> different circumstances. If there's a BT connection established,
> the wifi still fails to connect until disconneting the BT.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 9 ++++++---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 3 ++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
> index 3adb1d3d47ac..6c3c70d93ac1 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
> @@ -1525,7 +1525,7 @@ static void rtl8723b_enable_rf(struct rtl8xxxu_priv *priv)
>         /*
>          * WLAN action by PTA
>          */
> -       rtl8xxxu_write8(priv, REG_WLAN_ACT_CONTROL_8723B, 0x04);
> +       rtl8xxxu_write8(priv, REG_WLAN_ACT_CONTROL_8723B, 0x0c);
>
>         /*
>          * BT select S0/S1 controlled by WiFi
> @@ -1568,9 +1568,12 @@ static void rtl8723b_enable_rf(struct rtl8xxxu_priv *priv)
>         rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.ant_sel_rsv));
>
>         /*
> -        * 0x280, 0x00, 0x200, 0x80 - not clear
> +        * Different settings per different antenna position.
> +        * Antenna switch to BT: 0x280, 0x00 (inverse)
> +        * Antenna switch to WiFi: 0x0, 0x280 (inverse)
> +        * Antenna controlled by PTA: 0x200, 0x80 (inverse)
>          */
> -       rtl8xxxu_write32(priv, REG_S0S1_PATH_SWITCH, 0x00);
> +       rtl8xxxu_write32(priv, REG_S0S1_PATH_SWITCH, 0x80);
>
>         /*
>          * Software control, antenna at WiFi side
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 8136e268b4e6..87b2179a769e 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -3891,12 +3891,13 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
>
>         /* Check if MAC is already powered on */
>         val8 = rtl8xxxu_read8(priv, REG_CR);
> +       val16 = rtl8xxxu_read16(priv, REG_SYS_CLKR);
>
>         /*
>          * Fix 92DU-VC S3 hang with the reason is that secondary mac is not
>          * initialized. First MAC returns 0xea, second MAC returns 0x00
>          */
> -       if (val8 == 0xea)
> +       if (val8 == 0xea || !(val16 & BIT(11)))
>                 macpower = false;
>         else
>                 macpower = true;
> --
> 2.11.0
>

Gentle ping. Cheers.

Chris
