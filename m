Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADEF558BCB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 01:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiFWXgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFWXgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 19:36:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0C609E6;
        Thu, 23 Jun 2022 16:36:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l11so1656393ybu.13;
        Thu, 23 Jun 2022 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8mi6O0ZCTeU79Z8kRQFrjrcmgiGj1KF7rtlkbpkwLs=;
        b=nd5wGjuyLxXcCYDjRPwA2fr6Yi1Yb8ep7tbf1x+g5JF/lO9ndlz0K/WFHWxgu1J4ij
         J16BQt7hZOVcMzwltdD+BjECVl8KcE2k10hAJ5qN4V3g8+E0bdrEHKAY624TWJP2mc/P
         d3L5Da5KSW7q4Tbg93ahTRTyj7pwuVyT7i2oYQ3cBOYt7RUBhep9UILZO2FehtBhGrtx
         jpP/NtfOBS1+klO/D0fjeVzcolab9EYxSXjeC0btYFYllwyoIUWTRVpiM1JTMi8+UasC
         M0SWQP40WLFMGzkZZ2kZHnYgzGZW1IOeulz59XKuthNGPt+5PDbQAr/a+9Cs1+HpSK3f
         xJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8mi6O0ZCTeU79Z8kRQFrjrcmgiGj1KF7rtlkbpkwLs=;
        b=6arJleHPZaIofy4j4vEoAL490WpZvNmPxip2ZhduCFTMZcqKSqLO2VxNO0hadcMfVr
         YDjkNDBOeVE2Cc6l+daTKaWU1X155+gqzGusCPFeO7xY8n1qppczAOH3KOnv5/EATpy2
         ZBrRnaRufrZLwEPx02ZWM835OYgaomPwIBbRA9mFowPIHEUpAPlXoah5ngw9AF0Hff/b
         uxG8tBimASEvOHzlAokR8KxBod5z3ZAGxkABm+5Jm33nqRVfV23qM+m/RyHFXI4J0EA1
         46SWyslYbWYXFlEwfvJ8Z2VnAI2cEXiYxJRCWVdb4PlMGdGw30aAjhJS2jJLebDCYjhX
         X+tg==
X-Gm-Message-State: AJIora/98W6xvjXcXVzqjel+LK790cF3X53Slke8mjmdLrXYIotPuE6h
        c2Ayz4k5a0HfKO8EwyhrneMpdHqPisomo4Rgm/4=
X-Google-Smtp-Source: AGRyM1vLC2G8rDSxCAvx8NMZ2bGWJgeUig8nvDkPvwa+wBommbmxFoOuJQn05F5KfIfOoNf8zZ5XW8jgy3raj5GKmcU=
X-Received: by 2002:a05:6902:1149:b0:669:16d0:b4c7 with SMTP id
 p9-20020a056902114900b0066916d0b4c7mr12648378ybu.269.1656027405716; Thu, 23
 Jun 2022 16:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com>
 <YrRZLPQHK0QbLTjr@zx2c4.com> <YrRZoGBMBa3lFkwx@zx2c4.com>
In-Reply-To: <YrRZoGBMBa3lFkwx@zx2c4.com>
From:   Gregory Erwin <gregerwin256@gmail.com>
Date:   Thu, 23 Jun 2022 16:36:34 -0700
Message-ID: <CAO+Okf5JbZ7vUeXWMOZU9Fz=igoVBOZZAiWn7w7SxW5t+dO0Ag@mail.gmail.com>
Subject: Re: ath9k: hwrng blocks for several minutes when phy is un-associated
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No luck.

The first patch caused a warning and oops with ath9k_rng_read() at the
top of the call stack when reading from /dev/hwrng:
  WARNING: CPU: 1 PID: 454 at kernel/kthread.c:75 kthread_should_stop+0x2a/0x30
  BUG: kernel NULL pointer dereference, address: 0000000000000000

The second didn't have a noticeable effect, for better or worse.


On Thu, Jun 23, 2022 at 5:16 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Or perhaps more simply:
>
> diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
> index cb5414265a9b..5b44cd918c2b 100644
> --- a/drivers/net/wireless/ath/ath9k/rng.c
> +++ b/drivers/net/wireless/ath/ath9k/rng.c
> @@ -83,7 +83,8 @@ static int ath9k_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
>                 if (!wait || !max || likely(bytes_read) || fail_stats > 110)
>                         break;
>
> -               msleep_interruptible(ath9k_rng_delay_get(++fail_stats));
> +               if (msleep_interruptible(ath9k_rng_delay_get(++fail_stats)))
> +                       break;
>         }
>
>         if (wait && !bytes_read && max)
>
