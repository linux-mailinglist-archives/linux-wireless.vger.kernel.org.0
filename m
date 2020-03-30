Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A27197779
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgC3JIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 05:08:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40486 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgC3JIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 05:08:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so8368151pgj.7;
        Mon, 30 Mar 2020 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMX02ejGG73Qrwzg7wLP5FGjGf2UMP3ZHrJU73GoEFg=;
        b=OvwA3qjnZ8JpaCHc48i9hHVqMpv4k76cePP7uKYsYWADygIH00TsQBdnUC6FHStmoH
         FJrzeN7FfzwS12G80vou7QlnTA8It7zIEmciEE7LdYj3reJrufh0N5O/DbDRM1ytDBzn
         5ux+kT0MVui9dYTweceDvlTkBJX74mHDj3es/vqEwCUH9xnkGZNyKOzz8ZLP780C68O9
         AXIK/z6YpYDACXEeFz+gvEvO3PoXMhldJPFrF8T0rSS7ugbqS3Ko1oWnaLh9LOw/2JCq
         dKMr4pc9z740BTbb3RB7f3+1Z37Ol9yjQ7xeE9x+qu1Ry3q+3Xlyb9kl9t8XZJlp5BMM
         W8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMX02ejGG73Qrwzg7wLP5FGjGf2UMP3ZHrJU73GoEFg=;
        b=Nk2xsQVsMqIJ7U32MGKZuhFDoe2PQrsPofwwJgNS6Ng6dZDsK9FV6WbIM4vgY7AV8Y
         RIV7WJkDuT1mUENbfQVUXAvCjZ68NGcsFMN+aRXFZo9Id5owkon1aHpQpcYKx4bdzxSK
         j7OLKIGRkAf+EH2wdXVurw6sBxaahnT1JK6S+iKZHH02j+j/V3IS779fzP3KiruuG9xh
         2kH2ayj/O1nQSJcF2qEfnu8yxdzWWcqaA182VjfVSAQiAMsaT0pwj2mQlGgNTkugIQRK
         mx7UeZrpw9pK83QdliCbgrchzAWXCxhNiZuBbu+zEV9K7IM5oVyKzsnhEylNwt+qTCXQ
         WmCg==
X-Gm-Message-State: ANhLgQ1tqjRSjN/tOj/sq8BwfJtaxnW60mwHlJaVlHtKBUCKETZAgFqB
        pk4+m4RHNjA+7FFvjaSoNmub6y+EEXm4QoEL/K8=
X-Google-Smtp-Source: ADFU+vsaY5JxUFEh14uKO4Mm5p07AHhGBlvU0+GaYjp39oDTmuhfZScp8S+ks6F23CtWfQ9GH/aWgoZFn7GC8x9DM08=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr11778522pfa.170.1585559314296;
 Mon, 30 Mar 2020 02:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433@epcas1p1.samsung.com>
 <20200330052528.10503-1-jh80.chung@samsung.com>
In-Reply-To: <20200330052528.10503-1-jh80.chung@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 12:08:27 +0300
Message-ID: <CAHp75Vey9VUSAT6j6NTSXqNUK1vwSqY=aSx3-WPoXgxCK33SDg@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: fix wrong location to get firmware feature
To:     Jaehoon Chung <jh80.chung@samsung.com>
Cc:     "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list@cypress.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 30, 2020 at 8:26 AM Jaehoon Chung <jh80.chung@samsung.com> wrote:
>
> sup_wpa feature is getting after setting feature_disable flag.
> If firmware is supported sup_wpa feature,  it's always enabled
> regardless of feature_disable flag.
>

> Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

No blank line in between. (Dunno if you need to resend, just wait what
maintainer says)

-- 
With Best Regards,
Andy Shevchenko
