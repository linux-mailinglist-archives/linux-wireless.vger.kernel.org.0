Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6881915903B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 14:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgBKNre (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 08:47:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38840 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgBKNre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 08:47:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so11663203ljh.5
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2020 05:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZfNH6ANolZKnDhKv27VDyVWZJo5+0w3vd5xrrKIEEw=;
        b=RAx9kjyYZTKvZKO7aHhSMqL1ePGIRzx8cd3NcZNn6hUs/oOk7O8swnYn7qRjJnb2sO
         Uyl3Rqd+8buzEns7c+ShlagBk1icyMYJuIAv5wf4FrhbhGhzE1DOGgVoJBg0fvtuw54V
         Feww94VFsLfwWsUtCZaLrY8uKz9HmYy3cuk754LXtDxNlbie8rIXLXt18vQfRoXQ5+x/
         z7VHxphOQqcS/Vu0xvJJgQdjeGfuYjIlO7AVPXBpQAcW/MfpHp5K5jEgKI9G5GlPd4SW
         CXDpXC96FD17DrDDiqb+0NPEGj9OnKqfLv7Y4Y15fO9lzzyBF+qkd3ZYRnA7y1jviJD0
         zl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZfNH6ANolZKnDhKv27VDyVWZJo5+0w3vd5xrrKIEEw=;
        b=lZEk/CGbeBuqj+HzJxZszsqxSegwybYBV6bLlOqsZ/SrDsEFihfbJvujFFdnK6fr8c
         0NySYOr/Lc3NhZfvKnIHjnf9SNY6lm/A7rjL9eHh9LImlNbY14gDKLl4LTNj5+V1266e
         OKQojr08rkx9CEKS13zsm0JYXlWuXxts4+M74RAzbC+zPGhxPNPD81rVeRIv0Ea57xKh
         7G79mnEH8m0k+IPJAIv9X0UnjDHlym/MmncfiCS2FFq0qQW8xYiLrvCg1JYo7Jv06ToZ
         lBGjN5+4nNFQslXjDSV+iJnukq1ocUlYos6tbqpI5mSXuVMiJ5823Nc7Kk1H8nKopKP8
         jMkQ==
X-Gm-Message-State: APjAAAW4GDlPY0NT0PRTZMY/iDP4aeyCbCrxWvaMP8+W38rBiJfjffId
        hMRVksggAyFVkZnFIJwfGav1KLi5gbudvgXhUMU=
X-Google-Smtp-Source: APXvYqy5/R8ZV50qNQJCg8/764Ua3uzTlcItYiizvKUJjTJzzWxCb75QoNSxxyCLOuRmmgVCTiw0n3q2oswR98VQzgY=
X-Received: by 2002:a2e:8916:: with SMTP id d22mr4607570lji.19.1581428851840;
 Tue, 11 Feb 2020 05:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20200211114502.4250-1-markus.theil@tu-ilmenau.de>
In-Reply-To: <20200211114502.4250-1-markus.theil@tu-ilmenau.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Wed, 12 Feb 2020 00:47:20 +1100
Message-ID: <CAGRGNgXVpqsv8YTG5=5ifGZ-duZNoUdsXXx7DjNZcekVJX94+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] iw: add clang-based fuzzer for scan IEs
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Markus,

On Tue, Feb 11, 2020 at 11:42 PM Markus Theil
<markus.theil@tu-ilmenau.de> wrote:
>
> This patch is not ready for inclusion into the repo, but only useful for
> testing purposes.
>
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>

A couple of minor comments:

> ---
>  Makefile    | 24 ++++++++++++++++++++----
>  fuzz.sh     |  5 +++++
>  fuzz_scan.c |  6 ++++++
>  iw.c        |  4 ++++
>  4 files changed, 35 insertions(+), 4 deletions(-)
>  create mode 100755 fuzz.sh
>  create mode 100644 fuzz_scan.c
>
> diff --git a/Makefile b/Makefile
> index 90f2251..4ba2daf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -16,9 +16,9 @@ CFLAGS_EVAL := $(call cc-option,-Wstringop-overflow=4)
>  CFLAGS ?= -O2 -g
>  CFLAGS += -Wall -Wextra -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common \
>           -Werror-implicit-function-declaration -Wsign-compare -Wno-unused-parameter \
> -         $(CFLAGS_EVAL)
> +         $(CFLAGS_EVAL) $(EXTRA_CFLAGS)
>
> -_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c)))
> +_OBJS := $(filter-out iw.o fuzz_scan.o, $(sort $(patsubst %.c,%.o,$(wildcard *.c))))
>  VERSION_OBJS := $(filter-out version.o, $(_OBJS))
>  OBJS := $(VERSION_OBJS) version.o
>
> @@ -102,12 +102,28 @@ nl80211-commands.inc: nl80211.h
>         @$(NQ) ' CC  ' $@
>         $(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
>
> +iw_main.o: iw.c iw.h nl80211.h nl80211-commands.inc
> +       @$(NQ) ' CC  ' $@
> +       $(Q)$(CC) $(CFLAGS) -DIW_MAIN=1 $(CPPFLAGS) -c -o $@ $<
> +
> +iw_no_main.o: iw.c iw.h nl80211.h nl80211-commands.inc
> +       @$(NQ) ' CC  ' $@
> +       $(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
> +
>  ifeq ($(IW_ANDROID_BUILD),)
> -iw:    $(OBJS)
> +iw:    $(OBJS) iw_main.o
>         @$(NQ) ' CC  ' iw
> -       $(Q)$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o iw
> +       $(Q)$(CC) $(LDFLAGS) $(OBJS) iw_main.o $(LIBS) -o iw

You can use "$^" to get the full list of prerequisites instead of
spelling it out in both the rule definition and command.

I.e.

$(Q)$(CC) $(LDFLAGS) $^ $(LIBS) -o iw


There's a tool I'm aware of: https://github.com/google/AFL

Which does fuzzing by instrumenting the code under test and iterating
on input data. I'm not sure if it'll get you anything that LLVM's
built-in one won't, but it might be worth a try.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
