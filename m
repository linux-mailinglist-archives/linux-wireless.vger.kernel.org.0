Return-Path: <linux-wireless+bounces-30168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE23CE86EF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 01:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 534FF300E148
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6E2868A7;
	Tue, 30 Dec 2025 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PoTTNCS/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF6288C27
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055285; cv=none; b=LNZc9Z13My09eAN/lIJt1/HwGueI2Typ/UCOhXfEFfwt23BTjr9zqfwt9ho2CgfevnrBKxfn0toY7w1MUIf9dkm+G3NZrEhCjsMe8EcoJ8OcBLok4BBh71CMKNpVV+La7Hwz4wc2tQlA77fg+C1SUTbyg8YK+1n+XJoNHICDvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055285; c=relaxed/simple;
	bh=7AxI1j3SJ8077HLlun9ywYkOuO5o2t4Vz+NKIsUQTdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2q+AI17FGprS8Vw3NtWhHNQzEANmM5MMT2lDzJ1Ky+vbyKPQmGlY0ut2oxaSVAxDM9Ms4AMd/wOfIYHBiCEMZIcgjdcKXRV2sjclcqwAwr8BasDWqCS59A3wgj95NebgVp2UJFRw//ltmDev+iYHElCwdXLpv+LtA767cWU01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PoTTNCS/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7ffa421f1bso1814760166b.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 16:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1767055281; x=1767660081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OOpbynk6cMUYk6IoIP11teU4BYuiO0Neyv7rdgKSCc=;
        b=PoTTNCS/EIIASCKxF2wfQNGKZBEC8QQHuCvKt8It8r92W3umAnDymKuNQUNogGUeBT
         HLeeUPE9JvikCUPeVpr0g5ryk4Ri0W7lyEhGcOqyL2MscCV63D2+YoubUQ6K2TQD2uaA
         WQsdUoajetQ9O8arihmTKnDURmc1dsHxYxV8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767055281; x=1767660081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/OOpbynk6cMUYk6IoIP11teU4BYuiO0Neyv7rdgKSCc=;
        b=vVlGL19p8Fi39gobZN3pPktmkpnBx5vvRkMvm9o5zaYOV3V0Kmkxqnsvzb03qNC44U
         rQb1Vi+aRn4xR3bSC+hapvUSIOVEaROZKGRz7lWegvwUhjwWFCTIIlTZHaTTkLjqDcNy
         7gi15Fv2jbArz3kXj71GbgTAbdF2PHZZ1f51OK/RH7b0SIhsHtsind0VsOBmYYcSz7F6
         zG0tjik6q+ih7wTwxdoGzt/+VwL7JZDkAk00Gh+a8cmWAP/DkcMmjOoBUqubUO5Fz2z3
         J0UTDa0RjmHY/+gbnnZCB+u/eFtYB8h0/NURHsDWb5OJXo1pijP0L4mJiU0+YP7lC94v
         1z+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJwx/1zMf8Gq8OjW0KeOQjGqgFGCOG4ebEmC+baWihWs40D1zuJwnwPiLxzVPzwpGlXZKXCtUwPco3ZbYgwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxiqogqlNSgGejd+dxjpyQzV7tZ/fDqb9Cxi0pAKnLSs03txa
	7Uxu7U12I2Ejdi1vyN4UcsPx2P/6Z8vlQEZaBhpNgqfPIVA74+YVLPaFNhEgl3lngexU+qVZnmU
	CpEINkwQ=
X-Gm-Gg: AY/fxX7RmNqw5uEONE4K4ir5ug8kK9bODl9yG/k5+G058C0nRHYVmGeVKPm/6PnrRjm
	OY0sfK+rmM2bdG4COwp6yV2NZeLCgHEuiNWFyX3pGMgbTwNfl1fI8VZ3OAN353Qv2tW8O1P702I
	E92wbT1xCd0UFbyXk3iWkk3GCWD6JOiROz8g1AzlNMv4W7ilCwG1S10diJXdBugG2s2UY0VOmaG
	m9YwiApsjfO321Om14UMx80rguwoOPrNYUc7VWpTv6fI0ce6634SdydBeGt+4JXH332XmW/nKkb
	enEKo+lMDGQhphHcpjgkgDvnxWOEyLeQ8yFeJQucB7T4oU7a2OgUSf/1TUnJ1bpgyQ4zNlUemOK
	jByfYkoZc9Rryuv5RcpmoJ2oU2QaxglctlCz0kjacBoY08Zc19uPmeNQPURKndcBUViN1IxBgWJ
	QAorpXvwywE5q3qLNVNypW+wCnKTCCfUrvBFVca2QRQcb9De8O+Ry7LJN53BWa
X-Google-Smtp-Source: AGHT+IGzq0gb/sAU9JXXgzNCDrUFnhR057H/Ufz1wYmyzne2OyRsczt0k16d2pmuTR1fEsQnXuZhgA==
X-Received: by 2002:a17:907:1b26:b0:b7c:e6fe:bc53 with SMTP id a640c23a62f3a-b80203fd4d3mr3640432566b.7.1767055281172;
        Mon, 29 Dec 2025 16:41:21 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b7bcsm3597971166b.49.2025.12.29.16.41.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 16:41:20 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64d80a47491so12913502a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 16:41:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlLIjATQ/3GFAdNWuWWuvxHtT1zFqbrcjMQSw54GHXGzI8mtDQeMBT4j5MqC/TMjbtSy5B+KGG5IvjO5hpUg==@vger.kernel.org
X-Received: by 2002:a17:907:7708:b0:b72:671:b2a5 with SMTP id
 a640c23a62f3a-b8020400974mr2870792466b.3.1767055279778; Mon, 29 Dec 2025
 16:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org> <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
In-Reply-To: <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Dec 2025 16:41:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
X-Gm-Features: AQt7F2oRj4wh9ZDjWvoh2Rob4-m_u3jMhQym1nFoxdYfh4pzw2gAPmxOpJxWfUs
Message-ID: <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Eric Biggers <ebiggers@kernel.org>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Mario Limonciello <superm1@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, quan.zhou@mediatek.com, 
	Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	linux-wireless@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, 
	shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Dec 2025 at 04:25, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> =
wrote:
>
> Hi Shuah,
>
> On 2025-12-27 02:07:24-0700, Shuah Khan wrote:
> > mt7921e doesn't load on my primary laptopn on Linux 6.19-rc1 and proble=
m
> > still there on 6.19-rc2.
>
> This should be a duplicate of
> https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R=
0YPGnQ@mail.gmail.com/

Hmm. I wonder if we could instead do this:

  --- a/lib/string.c
  +++ b/lib/string.c
  @@ -113,7 +113,7 @@ EXPORT_SYMBOL(strncpy);
   ssize_t sized_strscpy(char *dest, const char *src, size_t count)
   {
          const struct word_at_a_time constants =3D WORD_AT_A_TIME_CONSTANT=
S;
  -       size_t max =3D count;
  +       size_t max =3D count - 1;
          long res =3D 0;

          if (count =3D=3D 0 || WARN_ON_ONCE(count > INT_MAX))

(intentionally whitespace-damaged patch, because I want people to
think about it).

It basically says that if the size of the 'strscpy()' buffer is N,
then we do the "word-at-a-time" only up to 'N-1' bytes, because we
don't even need to read the last byte of the source, because we will
always NUL-terminate the destination...

That would basically make it ok to use a destination that is one byte
larger than the source (in order to fit NUL termination that doesn't
exist in the source).

The downside, of course, is that it means that we possibly miss out of
doing the last word of the copy a word-at-a-time. But possibly not a
big downside, and it would make strscpy() able to deal with this case
natively.

The *real* issue is that we don't have a "source is this big,
destination is that big" version of string copy.

Normally that is a non-issue - just pick the smaller size of the two.
Except for this particular case, where the destination is exactly one
byte larger, and wants to be NUL-terminated while the source might not
be.

I haven't really thought this through fully, which is why that patch
is very much whitespace-damaged. Somebody else should verify my
thinking.

                   Linus

