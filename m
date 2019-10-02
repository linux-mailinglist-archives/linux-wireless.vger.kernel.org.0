Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8DCC8835
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 14:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJBMUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 08:20:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40630 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfJBMUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 08:20:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so14679747qkb.7
        for <linux-wireless@vger.kernel.org>; Wed, 02 Oct 2019 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1s9Qnx4QYX1Pe4YvbI9Mrmen/6O6spmAXKtAR6a1ZE=;
        b=An5AsPzQ4GR89OtegxJb25YpLgigqWoWCZiR6bHJ3Oy8G7LBFQ9lHWHv97ZAOvUMRf
         qBFoIIkJBF+lGTGRADqXCQnQv0dJaQ2Tb3simsA0gp/q7XK87lnc/I6Wb4hCrsL9cr2U
         tnWFx1OSik5XrzVuMTGjNbGDd9gVKtHxu5iQ5kgXr9zINb3tz18A91zKydbJEYyeX1jg
         j6CPcHp/e6Gs6xMaXa0S87DG++j5DyklgYFQNdvOm57ylruD9P2xJlnRk+wMLEqlCy4L
         mJX2IcfNwDDViWo4vKL+Rv3ig7gfVLQE5+QqKxAV6w2qdCg4/8JIaWw4fTGT2tF0GkL/
         cHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1s9Qnx4QYX1Pe4YvbI9Mrmen/6O6spmAXKtAR6a1ZE=;
        b=hnZCl2bhMJs9sG1R/HbwOm7B0lEF/m3TE+UlpIkDjjc1mIKrHhUXLg9AA49lsztZpW
         xOPxciuyLjZx2U58ooFrBFUEtOoaTKUjIbJRID43pwx5hQkBRNQ97tABWdWMg1Ij2QGk
         TMNAQ0FYwOLpw8+T+Iw8HREBlvf4nRjyD6Q0w8/3rAgXHluwuie3eZyL1MUieAk0TWHl
         ctmsT4SP94GTWF+A65et1YON9BL2HzhXgT8s629Ibpz2GRpX8TmGr89XTX8o9PYH+nmr
         2N3bPaGo6wtT3bzL3Bh18Nr4f+kUnTkk6UcJWg+zRchwSwbxjPjNYCgs6/MJTSHWwGN1
         JHSw==
X-Gm-Message-State: APjAAAVyQJPVxO5RxoHpjBl4AyPAVSiH8b/U8ZSRZSNc8tULFC8YYJX6
        MdStA6I7zpS3i/SzfcNo4BHtRg8W/qazz/rOSjziog==
X-Google-Smtp-Source: APXvYqySws1GAC2DEPn4qcev8riMOaMww0CmrYHzV/wKuehgOE3MUUOakPXd6Z5eg0QtzaNjHsPHjYFRsekMDu+WfOc=
X-Received: by 2002:ae9:e30a:: with SMTP id v10mr3437798qkf.369.1570018821860;
 Wed, 02 Oct 2019 05:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190917074007.92259-1-chiu@endlessm.com> <20191002043018.65FD86118F@smtp.codeaurora.org>
In-Reply-To: <20191002043018.65FD86118F@smtp.codeaurora.org>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 2 Oct 2019 20:20:11 +0800
Message-ID: <CAB4CAwfQB5V59xdO_70-tVMWLKTZ3_4x_atkBD+i16GSFjQjRw@mail.gmail.com>
Subject: Re: [PATCH v7] rtl8xxxu: Improve TX performance of RTL8723BU on
 rtl8xxxu driver
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 2, 2019 at 12:30 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> New warning:
>
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: In function 'rtl8xxxu_refresh_rate_mask':
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5907:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (priv->tx_paths == 2 && priv->rx_paths == 2)
>        ^
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5911:3: note: here
>    case (WIRELESS_MODE_B | WIRELESS_MODE_G | WIRELESS_MODE_N_24G):
>    ^~~~
>
> Patch set to Changes Requested.
>
> --
> https://patchwork.kernel.org/patch/11148163/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

Thanks for pointing this out, I've sent a v8 version to fix it.

Chris
