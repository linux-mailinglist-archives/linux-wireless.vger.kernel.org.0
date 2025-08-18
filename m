Return-Path: <linux-wireless+bounces-26437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD717B2B1C4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 21:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A1F520C6D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB797259C93;
	Mon, 18 Aug 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1rQdexb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD51253356;
	Mon, 18 Aug 2025 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545868; cv=none; b=QX2roxZ7aJxsXonCeCwRIw1iPLFSEHclnyVHTV1AvkMEqfIr7zURjqIegOdrjw/iS5+PAs4EcVc3mWmok2DUPnM4s8K+nylmQmeR1EicdMM7C86zpfFD+6zwxXTZqVh0/Zsxs9828sFOmfneFuaeOoSlvVJdP523yLXSI7a9ZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545868; c=relaxed/simple;
	bh=ktOu78aHsWSo59gN17VXEbxyhPJvlM+QPeofMZU+xyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhTs6hmseEWo0+2IBYs3FWSO0xgtOCC9RKRq/EK+Mg+R4r2/OZhCYXFgZLJ1NBiYH1MEatFc8mRg5/+NzZAv8QL4rKpR71fUKWDPS7Ird7Vbcc0ZJu/RilVQsVZJmMZV6KQQhqwnRM9bZMTIGScfhBQyFfiNCUI0o4XvjZiCAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1rQdexb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e9455cfb9d1so1382149276.0;
        Mon, 18 Aug 2025 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755545866; x=1756150666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRxQ1/CDtECtJO0YvGSZjNXb6lpF9CLCjzuN6DRYqKM=;
        b=a1rQdexb7bCHk5DQXuKbZUEDkHrPtR4FDGORwRFOpE2mluR2JCWSsD8ZNEcMhs+G6/
         k86NC3VH10ki4Xq6dvaH4IIlZaG8rfVu1tfJL926F7S5uwwj48tYYRxY3wFH3I2rgXG2
         c6EOkI9tDBeT33JzGWzfVc139Dj4nGF8N1I1vWUNWRxOP1ivUFsGKZiPTVX7xYfCkAYO
         1frhXEgKgnVivEk13t8TJfTAm2JGRuMiszSnbJhbqYqUZh4M0J5PBsgqH9/YDcPDXHqU
         Bptc8KNX44lgcIo97n0mpyzqs8SS1GUUtMyu5CssrssOnHIiZucYAFRzldLDQcziD8SH
         VMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545866; x=1756150666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRxQ1/CDtECtJO0YvGSZjNXb6lpF9CLCjzuN6DRYqKM=;
        b=iF3yhIEOV7NouVIz090PapVtL0HVg4NO+r36GMsQdiYw4vcU9gMPKPPjwrDqZ4yrk8
         4W1rRW2TxXIUK6hfEfRX8fKrjAi1FHbv1Chdz+aIwegGbhgh6lui6+HVN8QAL66V3khQ
         gEv18A0Vi+jE7I+p6r0dDhYhhn7VMbBxcVmeGcjfB8iUL9eN+qdsETTeZkXu9JXsRygm
         O1JsNAV2NYwc5IMEaTEW/DUV8qM+0DTUfJyr76ojYk9nyRaoEF9C536tvRzuVzGF7l1l
         YvjRmLmgRp//h3mY3wo4O1fFASjRk9Vk+0eJi37I5Su0W943ZlLsEz0SgoDf474coJal
         L9HA==
X-Forwarded-Encrypted: i=1; AJvYcCVwNASbNb5PkavnIEq9oL+7QoRDUjlXBH7uQDgX+GvwUo5sORAJ1P3KxJqIgHNgNHoRodKKzxgS2/81T+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZKw6Ur/PKTt4gmZsI2stC2ImQuT0kkANePKGTHDVZo86lk6w
	OEW2R60l8ahVJbBBWJ5OweQmSrTawK6gZXCF3SdhRgQDoXVm2JjL0iJMv8NW0FZu2gvphXakdyA
	VsJ0cZiRJbUzof16kiVe7rcv2L7kgscg=
X-Gm-Gg: ASbGncu9HuGXpiKjQia13zZ+xQ0gzPMXfr39DCEf+1QGNmVWWIQWEJvUXdC+2xj/mJA
	i+8K/VcJB8hKvvSwmNYY5pqUX8rwYRKjd6Ch+o34JxE6SSy1pCf5/1WSDZYXWw6oiUM7dRB1o/5
	IkCE6Sy2hB3yVTk+1nFfHm4lGdp6DeHCOt44hRgvJYOyyLffaM9c1OKaHi7rJtMCK0bBka3rwXZ
	ZYZi0HYyFmlpUEvZYdu
X-Google-Smtp-Source: AGHT+IFNd7VbHgSP40jC4g66ujH/qNSd8MS2y9wOHpdY850RLVLYxKsxREchSBRe+HKck66t1xqpLic7wRbyMZr5HpY=
X-Received: by 2002:a25:d38c:0:b0:e90:69d8:ca5d with SMTP id
 3f1490d57ef6-e94e3b4949amr753135276.19.1755545865965; Mon, 18 Aug 2025
 12:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811203451.3763-1-rosenp@gmail.com> <87tt2512nn.fsf@bootlin.com>
In-Reply-To: <87tt2512nn.fsf@bootlin.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 18 Aug 2025 12:37:35 -0700
X-Gm-Features: Ac12FXwZZyyUDn8oKNNWYN6q0laLklRESzEvvBU_ig6gkBOpa6H22KVKeJSdOXY
Message-ID: <CAKxU2N-5gFSHsyO-1UJ-6TPbn1YZ-zPU3yry9ZNcwYeOrEvZHg@mail.gmail.com>
Subject: Re: [PATCHv2 ath-next] wifi: ath10k: add nvmem support for mac address
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	"open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:59=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Rosen,
>
> On 11/08/2025 at 13:34:51 -07, Rosen Penev <rosenp@gmail.com> wrote:
>
> > device_get_mac_address is a generic way to get the MAC address which
> > lacks NVMEM support, which tends to be used on embedded platforms.
> >
> > In case device_get_mac_address fails, try of_get_mac_address_nvmem and
> > handle EPROBE_DEFER to wait for the nvmem driver to initialize.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: keep device_get_mac_address and use of_get_mac_address_nvmem
> >  added Miquel to CC. Maybe he has insight.
>
> LGTM. I guess it is not possible to make this fallback "the default" in
> device_get_mac_address()? In this case doing it in your driver seems
> fine if it's used on embedded systems with NVMEM cells described to
> store MAC addresses.
In retrospect, it probably makes sense to just switch to of_get_mac_address=
.

The prior assertion that this could break ACPI embedded systems seems
false. ath10k is too new for that.
>
> Cheers,
> Miqu=C3=A8l

