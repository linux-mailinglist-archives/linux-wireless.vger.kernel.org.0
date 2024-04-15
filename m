Return-Path: <linux-wireless+bounces-6307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EC8A4AE3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84392B21150
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063093FBA5;
	Mon, 15 Apr 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adfu+EXO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B193FB9B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171196; cv=none; b=WbGkymfTYa+2+nGMwHgT2COfW8wCkHSeOqNUyoTBHqUb+25LG3hJiJbaDdPkzAjRgA8Rf5qsp2q4ByMbxoIgDEMSdZNZ2CDFyaU2bBHGFaSIi/wveiS1uDbULY+kfik4aMzCou2o+7ohMihGU3PuDJyxTNFJouHsXHa1fcJb4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171196; c=relaxed/simple;
	bh=p4YmvXjwUE9Om9gjbYPqzHX5KDm255wNk9QLxHZNL+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnAApx5RshOVsCPnQqj44DYRPOl9KQKBj4hGm7CU1liQHFXFgn+TAWtfOqRZHpnmq+1lKT99aKwFh3iqWcm9ay+slKInORr251sq2HrWwjAwktU8erknf3gwI9TYlI5Q2IC0ITSK0b/FeAr+oUQkNKnU4RepU5dPibIZ9w8mGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adfu+EXO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34782776b19so917910f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713171193; x=1713775993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4YmvXjwUE9Om9gjbYPqzHX5KDm255wNk9QLxHZNL+A=;
        b=adfu+EXOQayz5nh58S1q9jNPSiGxKR8iDZcwtZACmIfRG/hEdzcRgDDGtwh45lb0wP
         DpddGKCYxK0DHszOL6E7cYcvw6andH/WO+T9Rx6cMMhSzTD/0HzKyZo1gtlPCdvwTbRI
         +XJ9/rWdtwmu0rgQ4EbkSyVf+iK9S/L5uyKl1nCxlBrdzWMq5l+XuLnK7oZv5sd3mqeJ
         lA9MounhGpUEBHSa+EAajDmmfIiAZkFwPnWjpWl5d51kTrLQ254lX+ug9lrNkmYX3sA8
         F/JnczVAsyPbSE0gGriH2Ybst7Mkgz33c1AoZ8B2rmtgzTYwft5kZzW6HcMPI25mBOGc
         htAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171193; x=1713775993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4YmvXjwUE9Om9gjbYPqzHX5KDm255wNk9QLxHZNL+A=;
        b=vLOMwlb4k/c8QWbzT6evKxzb6DG81cUxRWSXpjWWz+gczJZu/f9jJnYeB5UmFAK9ZM
         TiFqyJylOjpHnC134Q0Ljq6m/VfUkXakv2K81A7dYSJ7wUK78z1wmmdqbJgLzVoABgPr
         03kTKhNF0xP6MbW6UiGJhD0L+6Bp0Z7/oE59+3591Sa+UUqT7FG7z+OlrLY8rQi42AIQ
         76JlAZCLKKWjRvvmfbzf4lKsRmSfyJ2BZKla52/BsVGxYTULoKTm/uBhLwySpKLjnKXC
         ojiIUAHNTqZpdAG8L3GTF7IpTkKMP58l7882KctRuxZw133evoCFVmU55BgpfPRv6+Ox
         rWYA==
X-Forwarded-Encrypted: i=1; AJvYcCXhF55pkhE70jEiYcbAv8ZoM7oZ429rHYtVQhY6QX//3tWgBQjGFKigoU+B+crqncuiqEFYnemvdWlPzEW6JvNF91CEFLi+NFm98YQm4hQ=
X-Gm-Message-State: AOJu0YwIWRTBpzhMr06Fonnqh/8yWAbo/LNIRhUpNcT3c39tLtdm/ypS
	f3ToCvoTXEpld+2wL/0ZWgUETYCVK9EE/PWSmFnwmCgcuCDgUigV77g4pD9sVzElzdgZ2gL3A0D
	OgQzUMPcrqCeM+jWkxlRiBTOajfQ=
X-Google-Smtp-Source: AGHT+IE14iQ17oDdcnbi8qgRcokDbIU5UkQyK2Hg4ko2LoaZnau9fIQ9TXgsjE4oYzx8NzypFQMiNFwtPxhJ+BxNvI0=
X-Received: by 2002:a5d:5982:0:b0:343:72d3:8bf9 with SMTP id
 n2-20020a5d5982000000b0034372d38bf9mr7553965wri.47.1713171193444; Mon, 15 Apr
 2024 01:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD9ZU8Coc0r3AiWz+rA4eoXuDQBBCAMY0J4w5x-Pa1JEpbmdWA@mail.gmail.com>
 <CAFktD2cp5eXJufdQibxDPGvN2iMfMZKDOunFzxv0TBNLqcMAQg@mail.gmail.com> <c68a406361524b6888d973a1e428118b@realtek.com>
In-Reply-To: <c68a406361524b6888d973a1e428118b@realtek.com>
From: Gabriel Tisan <gabriel.tisan@gmail.com>
Date: Mon, 15 Apr 2024 10:53:02 +0200
Message-ID: <CAD9ZU8A8f-aJuH54e+93cZGTckOSu+rYKcnQr0mkc8eq56zedg@mail.gmail.com>
Subject: Re: rtw88: rtw8822cu (LM842) on Raspi4 -> driver get stucked while
 sending data
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Nick Morrow <morrownr@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am a little bit confused.

My LM842 USB stick uses a RTL8822CU chipset(idVendor=3D0bda, idProduct=3Dc8=
2c)

The repo https://github.com/morrownr/8821cu-20210916
allow to use for idVendor=3D0bda, idProduct=3Dc82c both RTL8821C or RTL8822=
C driver.

Should I use then CONFIG_RTL8822C for my case ?

To be sure, does anyone tested this driver in AP mode for 8822cu ?

On Mon, Apr 15, 2024 at 3:19=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Nick Morrow <morrownr@gmail.com> wrote:
>
> > > I want to use LM842 USB stick on a Raspberry Pi 4 using Raspberry Pi =
OS
> > > (64-bit Debian Bookworm with kernel 6.6.20), but the driver get stuck=
ed.
> > >
> > > The LM842 on Raspi is used as AP.
> >
> > Based on my testing of rtw88: rtw8822cu, it is non-functional in AP mod=
e.
>
> In discussion [1], Viacheslav reported 8821CU works. That might be a refe=
rence
> for digging problem.
>
> [1] https://lore.kernel.org/linux-wireless/e4ccf840-a38c-455e-af75-5f4db8=
a97702@lexina.in/
>

