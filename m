Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDB13377
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfECSB0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 14:01:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45331 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfECSB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 14:01:26 -0400
Received: by mail-io1-f66.google.com with SMTP id b3so210843iob.12
        for <linux-wireless@vger.kernel.org>; Fri, 03 May 2019 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zv9JCTHuA/ieeqwCt9ck9JDHpFDwCPi7mkzJ1bgK9rE=;
        b=g6VSBOMfRstBRXhWLGho9f79ivN87N8N+FaSn5O+bRoMEaBIb9GdpL+/HwfNBDkWRv
         6TLXtXy/A8CwJ0u2w8W5tVqt+a1xLiKJJ+k7gjwqpzFSKUNPh6vmR47Nt27dxufnrhz/
         Ki817y+WYBz/HQ2geou4H/4BT0KLEY3luCWgf4ZStmbhEGZ9dtEQJqp9kd7iV+F9/Jva
         g2PxiX+dquGLWzzE0HZ3ZVWIKqBPecBsFipwsN0nyJ2k7qdabAzrdQOo6QBUiQQ1rmA4
         +1OUs2xIBtY2bHkhw/cKvVB9onJZkZMYV2Tr3hK84uNTfQOHrSFpmm+DbGK3RbgtmfDO
         +A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zv9JCTHuA/ieeqwCt9ck9JDHpFDwCPi7mkzJ1bgK9rE=;
        b=eZBAbCC4tWceb75mZVEG3a5dbNYfG2We+HKDjqUXs3eC4ava5jIi2oiRBs4x8SO94U
         VzB9AZlbAY/puvUpeLRRWDdABRVT61Ux38/1Ri7lvQh0mSXXWHVhOjI8xTRqAFnPwmn4
         FxNwfNYh10wSD9IICTjPK/Egw7y7p86ezFBoOlILpqua8ePDcxwGBAkpoe4hzDrN/yD2
         gZ4qYMKIfXvOYep3HynEXjcEEYQbtCUSt8nyOvLucHMBw1IOpOOQQoOt8icSxIDTtNLK
         w3E5LwZsS8uDq0kWTjwwf2SoOORxaDVMfR/ckxQBKNgUD7kwWK+Ia6HgPezcjdY9wUhh
         JNNQ==
X-Gm-Message-State: APjAAAVDLwjEWGKFfDWe3TmMC9X0Dximmh/HEfbIrQQblQ9ILf67Ytb+
        LVVQngkbC5p+J+ARrktOhY9E5LALc6TytYQUabaYzjeruRU=
X-Google-Smtp-Source: APXvYqy72ztBEaWcSQIJS831AMS3FKoAxr7WAYTH5HkAPSKGn7G4hP28qwLijK/1iQm6IlQfYMAPE0SW4Y3nHC9P6Qo=
X-Received: by 2002:a5d:914e:: with SMTP id y14mr296244ioq.77.1556906485088;
 Fri, 03 May 2019 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <1556417825-13713-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1556417825-13713-1-git-send-email-wgong@codeaurora.org>
From:   Grant Grundler <grundler@google.com>
Date:   Fri, 3 May 2019 11:01:14 -0700
Message-ID: <CANEJEGug_YregN5vZq_R=ppUV5ptb4WUq_TB+JApzQ4DEO_AfQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: remove mmc_hw_reset while hif power down
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[repeating comments I made in the gerrit review for Chrome OS :
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1585667
]

On Sat, Apr 27, 2019 at 7:17 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> For sdio 3.0 chip, the clock will drop from 200M Hz to 50M Hz after load
> ath10k driver, it is because mmc_hw_reset will reset the sdio's power,
> then mmc will consider it as sdio 2.0 and drop the clock.

Wen,
5468e784c0600551ca03263f5255a375c05f88e7 commit message gives reasons
for adding the mmc_hw_reset() call. The commit message for removing
gives different reason for removal. Both are good but second one is
incomplete.

The commit message for removal should ALSO explain why adding this
call wasn't necessary in the first place OR move the call to a
different code path.

> Remove mmc_hw_reset will avoid the drop of clock.

This commit message makes it clear the original patch introduced a new
problem. But the original patch fixed a different problem and that
this proposed change seems likely to re-introduce and the commit
message should explain why that isn't true (or how the original was
fixed differently)

cheers,
grant

>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/sdio.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index fae56c6..f1d2af8 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -1433,10 +1433,6 @@ static void ath10k_sdio_hif_power_down(struct ath10k *ar)
>                 return;
>         }
>
> -       ret = mmc_hw_reset(ar_sdio->func->card->host);
> -       if (ret)
> -               ath10k_warn(ar, "unable to reset sdio: %d\n", ret);
> -
>         sdio_release_host(ar_sdio->func);
>
>         ar_sdio->is_disabled = true;
> --
> 1.9.1
>
