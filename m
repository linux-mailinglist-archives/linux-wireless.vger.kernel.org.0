Return-Path: <linux-wireless+bounces-10133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FA92C3E4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15FF283C3A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E217B056;
	Tue,  9 Jul 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALpxp2Tc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65B17B027
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553286; cv=none; b=JAtq1zzkfRwQ4mqGwU9EtqtwCDoZO3gSbi5RwCiKsXI/fB0nPSY7kwnlJvQa+MN/VwTDdDkGgWjWFwoOsj+KPXJJb5vnWAm8aaq2DnYKvHwvsZdXcc27Gk/dIVdD7uK2PdM+/X8FbTA3+LXqxa9Y/1rxQ1I3O+E3CXo7y2/fVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553286; c=relaxed/simple;
	bh=7KjDQ6T6YrLC2fAHCdXWe5nbUWinoqBLa9KTDbGYMyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmQefqRVDKsBT+SwP/4N31raeA4qaIXzL1DNcK+yLsK7tdDmJa3qt/Flgz7BmGhRMMSwSEWGZsmkhmtZ23TpD9Ff6enO7iAYHSBIkjoPWkR5UhHAHblqfTcHowhIWwYx/tPviesQOTU3ZQKaQ9yTlSukqX26Pnx3sQNoQK6H6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALpxp2Tc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6561850a7bcso29395177b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2024 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720553284; x=1721158084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KjDQ6T6YrLC2fAHCdXWe5nbUWinoqBLa9KTDbGYMyk=;
        b=ALpxp2TcY8omfDzBu07P6k6luDJ4GGUJ4wh29S61QY9vPxgQeAkvKWWr2eS71Ljr+m
         LbC9iCToTcxOgrpxQPdc7Cw2LNqPsL4WmFPxRNRBcGei7jylpn0cTDKUMZzzKYDUMZpz
         oNHSDx0qQupj6n7dDY7j3Gnda/50RhtsAqysTgN8DwR0TB+Z0pKeWH515RzP+/l2nOgC
         uL9XwOaa6F8KVp/S71QJfaiK167bbenMaoLd0597H8ujW7KkZgKFgeOd37bqUwWGNRd7
         TMsBUfAgPUIlCceE/winIPBUpB+Vs/M+lINuVLnsJ5LTDGAgdk/HrilkdXQUz//y6Y7h
         o+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720553284; x=1721158084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KjDQ6T6YrLC2fAHCdXWe5nbUWinoqBLa9KTDbGYMyk=;
        b=nkxEZmsEr8wp7VVP9aipqOk+UXGj8akBW4ww0jrkFFZvr7724ZmDlu4mzcCX05Vqgp
         fhIBFpOLU6Q4wxnp+gzL3+pCGvSOJ9tKkHyHF9E60KdiBDztDqWRv6eokZ1Ix8WRC4yw
         MwADxTB02Djhjm0MojdQqvlgZQGqgb9Jn0sqq0kiu03K85obVM9uSE/OlC7QkZG7y5cw
         ScIlqLUHibfTRWeaJsCSw/VtsQkX5I9euHU2I9clkSVXdP5t3nZz7MgJY15dcMbXiQeK
         +O559lOjNlyHSbMqn3JDdrVooTu2WwzBdbBwb9UjIT3/h3oRRtLjdV/fVkrQ/uvBg3YJ
         r57Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgFsdAQ6j578InzXwwyzuKB1YEMGDNT9tlAKK0J9mfV5/taEmyBcrj7IZhlXmqwkPLsU3AA4KBhTbi/hugnA2hoM0dsvt422GU0lWgrCo=
X-Gm-Message-State: AOJu0YyejSQgeLUr1QaVTYeII5F/1nHNppH0iolOFlmvsEioFV5e5Ku1
	Sx37VrYFsWaosUlhjgnmDCNL0585VOelIXm+HM7ItvsPTsiFqq13drlv6TEZxjup3L+wwVKzNEt
	OcspF752GtpbOO0SncXra1VCFqknK7MDDV3W+1Q==
X-Google-Smtp-Source: AGHT+IHI+0VczXk6VPG5r72QrvOSCSGn6Tj5Lbq5qTw8sEJU8N6kWRxiYI63gz2mmMwM2P73sqe7iEJ9yp8HBfXnes8=
X-Received: by 2002:a05:690c:6e11:b0:649:b0ca:2c9b with SMTP id
 00721157ae682-658f09c9167mr49405417b3.40.1720553283775; Tue, 09 Jul 2024
 12:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c6684f6-d3a8-4eaa-842d-c21fa2dd81c1@gmail.com>
 <1908d5acac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAHP5HDP_4NrZtQwcLRhj5efbnZiV=PNZcaeye3Gxx6pqFufyAg@mail.gmail.com> <87ed82naaq.fsf@kernel.org>
In-Reply-To: <87ed82naaq.fsf@kernel.org>
From: Nikolay Nikolov <dobrev666@gmail.com>
Date: Tue, 9 Jul 2024 21:27:52 +0200
Message-ID: <CAHP5HDOP+2kbqrQqyWauECSuY2SWvGzL+6k5D2zmRMPTdnFeMg@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi: brcm80211: brcmfmac: Prevent sdio bus going to
 sleep while transfering data
To: Kalle Valo <kvalo@kernel.org>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nikolay.nikolov@bench.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 12:12=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Nikolay Nikolov <dobrev666@gmail.com> writes:
>
> > I am really sorry for the spamming !
> > I have not sent a patch to the Linux kernel mailing list for more than
> > 20 years and mail clients do not behave as I expect. My first email
> > was rejected from the mailing lists as it contained HTML. Indentation
> > is not correct in the second one. I hope third one is correct.
>
> BTW I recommend reading the documentation from our wiki, link below.
> That should save both your and our time.
>

I was reading for several days this and the kernel mailing list wiki
before sending the patch.
The problem was the email clients.
Anyway I want to mention something which is not present here.
There are some memory barriers around this dpc_running which I think
are supposed
to prevent such an issue. But looks like this do not help much. With
the usage of mutex those
memory barriers could be removed as well. I am already using such a
patch in our embedded system.
Please, let me know if I should submit this patch. I promise I will do
my best not to spam anymore.

Regards,
Nikolay Nikolov

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

