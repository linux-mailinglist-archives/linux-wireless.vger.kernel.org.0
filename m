Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33425F09FB
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 00:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfKEXDJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 18:03:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35516 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEXDI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 18:03:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id i19so13755710qki.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 15:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KgdBjWRotGUdFa6yEZp/8RYHVGh/XZzlG3qRL1BDB+0=;
        b=Qs2EtrHizWLTWaWhJiIlygypuriMhdHV3pOjybG64NWI0E8aI69P4VRw6rVcYZoUhF
         EWPMKwHicfO1FRF8mYAGzucQXKjiRG4YnprrB4fXz0lCphmgrYm0SoTQEPrEADsQQgzG
         wTy0RhpKL5GlhKsISHuii5KIOX5zmkBCPZ5ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KgdBjWRotGUdFa6yEZp/8RYHVGh/XZzlG3qRL1BDB+0=;
        b=MIPCL9pp3gYR8epLz3rLpyK7mZ6pVFNtuBf1JQflRS+kmMqyVT02Kqeh1P+iUBcrUX
         UBkO6CVGHLLe1IH6hhSz9RSlvgeyrn1EoXgMPmBmolalGMDRvxf1SNJi5wJHDQEBlcdB
         bVKEp1eq0x77nnbSqT3bp476h2QMSuDekplvzCX7I/yTufWjQMw383CEO9cU6uGkYOhH
         V2tHFJ1RYgPR1kac9zdrvTPOc6adpXWBCllOc36/eJiel/ijYnVSxwSxytsk/vu38lpx
         JYEoByeUYb+T0A8wLUA2JpiYy7ArnufKKWCBtX7DfAOsoYqPtzsWezANcoeI1H7MHxqw
         gJmg==
X-Gm-Message-State: APjAAAUpm/PD0T6Uww8Ueyf13RvwqI9qI5Ezp5W29ZEbgf2nlRD4vLri
        p2llf0pPUTXHW3/P4faUSAPPmVM7jAM=
X-Google-Smtp-Source: APXvYqypJCXIqeYxR/KMa+ukGKXGw3y9Va+4GFq0vX66t1n80K98YcSkkgFqwP2B1aXmC4BmWD1/mg==
X-Received: by 2002:ae9:ef0b:: with SMTP id d11mr7012357qkg.68.1572994987530;
        Tue, 05 Nov 2019 15:03:07 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id x39sm14019345qth.92.2019.11.05.15.03.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:03:06 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id a194so22831480qkg.10
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 15:03:06 -0800 (PST)
X-Received: by 2002:a05:620a:208a:: with SMTP id e10mr4054113qka.221.1572994985742;
 Tue, 05 Nov 2019 15:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20191105225751.1233-1-briannorris@chromium.org>
In-Reply-To: <20191105225751.1233-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 5 Nov 2019 15:02:54 -0800
X-Gmail-Original-Message-ID: <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com>
Message-ID: <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com>
Subject: Re: [PATCH] crda: Makefile: fix .so compilation line with some compilers
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 5, 2019 at 2:57 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Write the CC rule such that it only tries to produce a single output
> file (the .so). When including the .h files in the compiler invocation,
> this suggests we should be producing pre-compiled headers too, which
> doesn't make sense in this context, and Clang happens not to like.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Apparently wireless-regdb@ is subscribers only. I have since joined,
but I guess my patch bounced from that list... if I don't hear back in
a while, I may resend.

Brian

> Yes, I know CRDA is deprecated.
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 6169b1f307da..6ca26f341dfa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -114,9 +114,9 @@ keys-%.c: utils/key2pub.py $(wildcard $(PUBKEY_DIR)/*.pem)
>         $(NQ) '  Trusted pubkeys:' $(wildcard $(PUBKEY_DIR)/*.pem)
>         $(Q)./utils/key2pub.py --$* $(wildcard $(PUBKEY_DIR)/*.pem) $@
>
> -$(LIBREG): regdb.h reglib.h reglib.c
> +$(LIBREG): reglib.c regdb.h reglib.h
>         $(NQ) '  CC  ' $@
> -       $(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -shared -Wl,-soname,$(LIBREG) $^
> +       $(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -shared -Wl,-soname,$(LIBREG) $<
>
>  install-libreg-headers:
>         $(NQ) '  INSTALL  libreg-headers'
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
