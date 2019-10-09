Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782F3D0615
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 05:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfJIDlF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 23:41:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44053 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfJIDlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 23:41:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so909323qkk.11
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 20:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GB2JHMDYknhXIEFLDvzLbVAnPjI4gpNqH62WS5f+KO0=;
        b=Y3li1p0GvAcuYEMAfII+AXzeP3Dx8hfezlCNCNYgS2sWDa6jIyh66uvJ57+0elcPg9
         2KP6OkXwBFZ/4WxKWGgk9HYvka2SwYDMvbGiEaqJ4D15iaJ02LPyaOd2pE5VmS4Uz9it
         xx14N3M8d+hrlnI6acRKn8V0lHwuv8p2wUsfny2rfRlTc1PO8iRAix0vMY1fmW6x/awK
         vg1wkPKaJX973Rd5h2BdY3ZIbnxSRHikFC1CYoXWxa5YEEdx1lwr67q9Pavx7v0OY8Vs
         cl6NGBtXDtmTMXSJmKameI0SBqPrXCkaJKgaCHUlF7gPIkBmTZQgAy2ngKdCZVw2p/SO
         SnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GB2JHMDYknhXIEFLDvzLbVAnPjI4gpNqH62WS5f+KO0=;
        b=Qy0GzWd6bImLaySy12sU01tagY4Ku5KsT3EzVsk/h8IgP4BnelQq06Ghs6Hvi7IWcJ
         pL0ZmrkH6WuuYtASMaq3lgS/xWxaS5RV623o2XJkg+1s6hFlCDpWLExCYKxtyDSc0uTe
         HA/C09BUi2i0ANB2S37xT5jx8uGkhO1BqHzTHiEcMoQI5S3QrvbFjjCiyy60pBdpRNJN
         SKEP2O1fqU6gHIO/7G95tGd3g5u5XKiqp5Y3Vx3sJ1WyTq6aBr9T6tD7nOCFFWY1JLAk
         5N+cJ9oCWt5pB9s5Wa4T9hUAGWqf/+iYQUxTUWBRjqy/1jNwBUfd8Tkguoz2a/ElWJte
         AxDw==
X-Gm-Message-State: APjAAAXQJgEGz0SRs3JxlZhQhCmbLNQDsEjWZoI+aRpfBklcGEP+ydRr
        ga3bHoJfvnEGbq2j4cAfBEG5WkQnk4R+yGIxevV7SHsX
X-Google-Smtp-Source: APXvYqx2ZXU+O9i2Vvy57W7zl6Wi5IMyt4opmNHluxW45LI5MUotyZgXc8b1ZqQ9neqS1WTVjRXCYY+Jxb1xS0PAkew=
X-Received: by 2002:ae9:e203:: with SMTP id c3mr1549046qkc.366.1570592463516;
 Tue, 08 Oct 2019 20:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191002121808.59376-1-chiu@endlessm.com>
In-Reply-To: <20191002121808.59376-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 9 Oct 2019 11:40:52 +0800
Message-ID: <CAB4CAwdzJT90aKBLoS2XLxM1sqwojXLhP52mNZj7c36jUfJyqw@mail.gmail.com>
Subject: Re: [PATCH v8] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 2, 2019 at 8:18 PM Chris Chiu <chiu@endlessm.com> wrote:

>   v7:
>    - Fix reported bug of watchdog stop
>    - refer to the RxPWDBAll in vendor driver for SNR calculation
>   v8:
>    - Add missing break in switch case
>
> +               case WIRELESS_MODE_N_24G:
> +               case WIRELESS_MODE_N_5G:
> +               case (WIRELESS_MODE_G | WIRELESS_MODE_N_24G):
> +               case (WIRELESS_MODE_A | WIRELESS_MODE_N_5G):
> +                       if (priv->tx_paths == 2 && priv->rx_paths == 2)
> +                               ratr_idx = RATEID_IDX_GN_N2SS;
> +                       else
> +                               ratr_idx = RATEID_IDX_GN_N1SS;
> +                       break;

Hi,
    I have fixed the missing break problem in v7. Please let me know if there is
any problem. Thanks.

Chris
