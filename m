Return-Path: <linux-wireless+bounces-23138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52BABB635
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 09:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1381752F8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C612676EB;
	Mon, 19 May 2025 07:33:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125A267396;
	Mon, 19 May 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639988; cv=none; b=Yey7BTaMbxWdaqGQkdjYl1GDIBq+s/opVC44OMQdFDuvhLnFsvwgiwLJt5FctswN6FTwGnt3HJs9W+S8SKvDaDSa+ITDSi6HmSISMaDCbdyQY0ao/2fCSW+k00ERrU1/Z5rIhEvtwbvu1XKmee/A24qO4VSh5Rto5TTDZakpBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639988; c=relaxed/simple;
	bh=jz37jXkqFlTdllQA2QcYD917Kx1k3Z4qHcOyFzR/TX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gO14Ke82c7oNxLrikkpKFET53a4NS8w7a8AKLmSbhNz73oQvA/4P1KqFWjXG/da1mTWDuQJdT2TCcPUhQFXasBPqa/7JDcHXB/wB5etfj3B+k82rbpltP3/hU1QRuPVh5X9Abh8VxAhfKIybZ7dgUu0DrAgjNauna5NCqp4vsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5259327a93bso1273815e0c.2;
        Mon, 19 May 2025 00:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747639984; x=1748244784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3qgKwHLt5P4bRuuOKVpHIxKeEfaWTv63kxyj0yKhe8=;
        b=bBUBkcUQdlETh0l8OIG+WQAfIHLDcaMlBoXi9NGfpCJXmFtbNLaOKVuOzRNBYcqQDi
         EfkzT5jN4V0JCyl8GIi1yu/p7rxtYkgEypaN32P519eUbFbV47U1wJJfDeCryef7yduH
         DKvlKR9FnUYGEJijhU5n2LNIcdJjUUSWIF8cSWFjEZnyLwOAaW79p1gYFbftdPgt6Nn9
         ZUnb/rfw/wHz+zpFt/DKfoQeInQnL7fT+UBm50rlJ1c2FIiNuK4qrbhrL98cVid4kHhC
         NMCiL0ai45X+vSiSGvKywiknMH5u8jO37JIkK8vhYlOCmp+h3DrOLBQnd7MbBLAWmd7l
         Y0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUbhUlZyxasuuOxwfaRa6jVEBWmnH65ojIDYkZRWedxacxQIvPtjLU4Dw6VR0EmMHj+QrD1kHqq9c7TxvI=@vger.kernel.org, AJvYcCW/trhayuGYDx5e6nr+wkXiYBPZkGb3wkhhaWrXdDEbUfSnCL9y5xEe5Rh2pNQOMXHOUeySVUUO@vger.kernel.org, AJvYcCWCNhINTkHTr8tUdYVoUY2r5RdKNNFJeNYhiyFJhgnO07hh9NTJgUTiw6dsrlzYlyBLmIhhIhh0LRVnUUES7GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVhegeVenb1zT6s41DmrarwoZqxTDJFMrhLWMrP0k/t16X1Fh
	fsrovhA8gKWeEebVWA7seSGcJhDszuk7+Tjg/OeNrIXL+2ivAORYRxdT/za7pbpJ
X-Gm-Gg: ASbGnctTP7X3E+QiU7JRqTb1sLRHAVItOWuHr0ZTHHv5lUfOh97423wK+j4KQ4YeX4a
	tZVttXLsUl3uAWOhFbcpdoD2Bdta/10/nJJiXmx8rZKqzkUcVCdbGkLycQOXT2O6rlYK+t5HeYp
	Y7qxfpQju9QWzuadLjgrn57wJTbycV2zLbw0eXQQl3n5jaBPtkw5NQpUGkkog47KkcaHne2czbO
	J0l0CzY+LB56CQllVGrf9t+kp2zk73zfhDsoMqJrdw9kRbob27hmO8RrwPl0TlNnKmzNO2IFmEg
	BJzYsSFkpRyLabqEGae/m3vya9up+pPC5T4F/Pco5h0cd2HmTLptdwTA7qdKbGzUU79XNI5S7Yh
	HOi78y/MojgiXXg==
X-Google-Smtp-Source: AGHT+IFpIS/CvTbnNT+e9lasiTIcvTFpICG4kZhikG4xBdDIIJ3TlQOTifqNK3w1H/ZtoYuItfx0JQ==
X-Received: by 2002:a05:6122:4317:b0:520:6773:e5bf with SMTP id 71dfb90a1353d-52dba800001mr9095958e0c.1.1747639984486;
        Mon, 19 May 2025 00:33:04 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab6b275sm6194781e0c.39.2025.05.19.00.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 00:33:04 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e2534c08a5so556245137.1;
        Mon, 19 May 2025 00:33:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWt1AoynpW+6b51yaugVwSaR5ja4ltJjEEIpbt6QT7Vs6BQ3E5Fr3uezcrWe9y5EI30Ag//qCknzW9CsQ8cWMk=@vger.kernel.org, AJvYcCX1V7u4v0aTnqb8FrJsBE5tkFJEBHCyn2BFjoHPZVNhX7m3ZxNgaJKNu2DPEGsrTnZmF7vESJcvs/z8GXg=@vger.kernel.org, AJvYcCXrsK14Xgi9E1j8rBLsGFfgsQz7vqnn0QvZE/mWxWluyzzQPwnj559MqbRe+d7nkRtiP0RgcIdI@vger.kernel.org
X-Received: by 2002:a05:6102:50a4:b0:4c1:7ece:88d9 with SMTP id
 ada2fe7eead31-4dfa6c431c4mr10663276137.21.1747639983678; Mon, 19 May 2025
 00:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516083842.903-1-vulab@iscas.ac.cn>
In-Reply-To: <20250516083842.903-1-vulab@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 May 2025 09:32:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=96tSH77P9Gqr1M3VfiKB9jYCeJDDFCNq_TGdYb0vFQ@mail.gmail.com>
X-Gm-Features: AX0GCFtZWuEUgkZTPTuuMD1TIn0WiwNaXw3_TLGkuFPdIiaP9JAMXSxC6tz5Ais
Message-ID: <CAMuHMdV=96tSH77P9Gqr1M3VfiKB9jYCeJDDFCNq_TGdYb0vFQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev, kvalo@kernel.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wentao,

Thanks for your patch!

On Fri, 16 May 2025 at 10:39, Wentao Liang <vulab@iscas.ac.cn> wrote:
> The wilc_sdio_read_size() calls wilc_sdio_cmd52() but does not check the
> return value. This could lead to execution with potentially invalid data
> if wilc_sdio_cmd52() fails. A proper implementation can be found in
> wilc_sdio_read_reg().
>
> Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
> log an error message via dev_err().

There is no need to print an error message, as wilc_sdio_cmd52()
already does that. Same with the existing wilc_sdio_read_reg(), and
with all of its callers, which leads to multiple error messages for
a single failure.

> Fixes: 0e1af73ddeb9 ("staging/wilc1000: use proper naming for global symbols")

This is not the commit you are looking for...

> Cc: stable@vger.kernel.org # v4.15
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -771,6 +771,8 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
>  {
>         u32 tmp;
>         struct sdio_cmd52 cmd;
> +       struct sdio_func *func = dev_to_sdio_func(wilc->dev);
> +       int ret;
>
>         /**
>          *      Read DMA count in words
> @@ -780,12 +782,20 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
>         cmd.raw = 0;
>         cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
>         cmd.data = 0;
> -       wilc_sdio_cmd52(wilc, &cmd);
> +       ret = wilc_sdio_cmd52(wilc, &cmd);
> +       if (ret) {
> +               dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");

Looks like the AI wasn't trained properly.  Please try to (at least)
test-compile your patches.

> +               return ret;
> +       }
>         tmp = cmd.data;
>
>         cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
>         cmd.data = 0;
> -       wilc_sdio_cmd52(wilc, &cmd);
> +       ret = wilc_sdio_cmd52(wilc, &cmd);
> +       if (ret) {
> +               dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");

Likewise.

> +               return ret;
> +       }
>         tmp |= (cmd.data << 8);
>
>         *size = tmp;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

