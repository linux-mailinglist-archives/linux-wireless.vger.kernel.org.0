Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F927121CB
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfEBSSO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 14:18:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46461 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEBSSO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 14:18:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1409314pgg.13
        for <linux-wireless@vger.kernel.org>; Thu, 02 May 2019 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5E3RSE8lQiSqCimg0Jp86ttgCCec2oGoZPCpZScr5E=;
        b=ZrJ2qK2x6e2tQD/KrenlD7nA9vWWuqna7yfhiZinM8ZcBfkNkimmxMOpECoVPitUCd
         5jN/aErSVoNujlZPhBvusaVinK3xQs5FjR/WOwBKcpOZUuhflXXDO8QPjOb8JomTWyng
         9VQwAc1oNcwde0b84L/5+7A28zMNGAqaZ02Dgi1qPueMQKA+Qoz9TebxZ3SYwAJRw/ch
         CUbZ0H1OLS5xWQq+FTfvwOB0/daVUcbj/7BqhJVN5b89udMs6DSKAnPnAUtNipR7mSgl
         BWf8BAjrpLiUj2GI+8Mj0agUYDoNOJI3m++ArVGXyngbBexIChDs6fTCQ9ZvyQr+QKcB
         Nnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5E3RSE8lQiSqCimg0Jp86ttgCCec2oGoZPCpZScr5E=;
        b=hscYl+AZlMh5P6XJjaGhk7YaxnZj1ZDk0/4oF3aC7OKg9aAI86eQKfZJKgvAhfMEki
         ZhbGosqUEn7G0oK6shyL75rUhRfT/7FdmKrL7DC87SayzCNqZzQgC6OKZEGakd1CjucI
         CtVkhu2WlyNEatfpDTByNL7npdWAhfP3iJ6AhO8Id7SW2kLmzl2U48invBXAl6nSg/t0
         fO9xBeo5QGb3STIll/M+bRI6HtY76fHKFWnTBIY/jQWQymMbxsUJohgmTGTVin7aPakl
         oF7X05y1KKW2GnOVBQ0084RrEx/BsN/LJ3Xk+/wvDKuO+eZ6zHrXluDNBvl8g8sJaBRd
         OdLw==
X-Gm-Message-State: APjAAAVL6aSSvR4E2gPLx7XgMDrSpMttgwHS//ZMyE+eVmxAZY0c24AB
        DJxww7SJhCnul01eXZl6+ZZR8s9PqRWS2VmGjQpGxw==
X-Google-Smtp-Source: APXvYqyum+u6TX+AnvXMQhK0hPsMGunXOwrUrgK8auFMJ/68iASPoxxQrweBV/uzyUaDhVMRGKLMVQum8VJ0vnhhgEE=
X-Received: by 2002:aa7:8096:: with SMTP id v22mr5731088pff.94.1556821092860;
 Thu, 02 May 2019 11:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190502151548.11143-1-natechancellor@gmail.com>
In-Reply-To: <20190502151548.11143-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 May 2019 11:18:01 -0700
Message-ID: <CAKwvOd=nvKGGW5jvN+WFUXzOm9xeiNNUD0F9--9YcpuRmnWWhA@mail.gmail.com>
Subject: Re: [PATCH] rsi: Properly initialize data in rsi_sdio_ta_reset
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 2, 2019 at 8:16 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wuninitialized, Clang warns:
>
> drivers/net/wireless/rsi/rsi_91x_sdio.c:940:43: warning: variable 'data'
> is uninitialized when used here [-Wuninitialized]
>         put_unaligned_le32(TA_HOLD_THREAD_VALUE, data);
>                                                  ^~~~
> drivers/net/wireless/rsi/rsi_91x_sdio.c:930:10: note: initialize the
> variable 'data' to silence this warning
>         u8 *data;
>                 ^
>                  = NULL
> 1 warning generated.
>
> Using Clang's suggestion of initializing data to NULL wouldn't work out
> because data will be dereferenced by put_unaligned_le32. Use kzalloc to
> properly initialize data, which matches a couple of other places in this
> driver.
>
> Fixes: e5a1ecc97e5f ("rsi: add firmware loading for 9116 device")
> Link: https://github.com/ClangBuiltLinux/linux/issues/464
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/wireless/rsi/rsi_91x_sdio.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> index f9c67ed473d1..b35728564c7b 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
> @@ -929,11 +929,15 @@ static int rsi_sdio_ta_reset(struct rsi_hw *adapter)
>         u32 addr;
>         u8 *data;
>
> +       data = kzalloc(sizeof(u32), GFP_KERNEL);

Something fishy is going on here.  We allocate 4 B but declare data as
a u8* (pointer to individual bytes)?  In general, dynamically
allocating that few bytes is a code smell; either you meant to just
use the stack, or this memory's lifetime extends past the lifetime of
this stackframe, at which point you probably just meant to stack
allocate space in a higher parent frame and pass this preallocated
memory down to the child frame to get filled in.

Reading through this code, I don't think that the memory is meant to
outlive the stack frame.  Is there a reason why we can't just declare
data as:

u8 data [4];

then use ARRAY_SIZE(data) or RSI_9116_REG_SIZE in rsi_reset_chip(),
getting rid of the kzalloc/kfree?

(Sorry, I hate when a simple fixup becomes a "hey let's rewrite all
this code" thus becoming "that guy.")
-- 
Thanks,
~Nick Desaulniers
