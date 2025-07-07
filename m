Return-Path: <linux-wireless+bounces-24882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9DAFBA0C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 19:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7A43BBAF4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B22E88A5;
	Mon,  7 Jul 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABDOEf3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD12E2644;
	Mon,  7 Jul 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910131; cv=none; b=kOFiWdhLWgCE08fam31HJtXKcpWO4ydVs0lxcRv+mWvPXudrvR76bGnciiIjD0o3BfQyBh272VikDVZrwKkGT7azMAK/mBsT+D8KkAb64tcZfe6xwut8lw0FnPSUsnDYZQZTDkTFH5iiltt5zL9mLz39GuZNqLV6PqmmBtAoEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910131; c=relaxed/simple;
	bh=BcRJsM9iy/XMPZrWki3/WFSDgpuo7Zx4XQLpPLhix74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWK3lZtcOGna4iSGMKjcc293U6JLup7ESrBW0i4L591tVvQZ67NyuSJbWXAUvYF+sKvEPcQ++X/zd+sQrvij78fPaIxWY/4ki7aKGOH2EFBo8oy1puqk/JezTZ3h4Lqt4DkgMQm6KJYJUL9JdCRW89/gMWCdHFMj3rMjWyf+Cck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABDOEf3I; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e812fc35985so2804107276.0;
        Mon, 07 Jul 2025 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751910129; x=1752514929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42jtsUDXPCPmNytXrx59THHUxajHEyTomBc5xpmWMc0=;
        b=ABDOEf3IUGHC/HErXGiIfHLXtMFA7tCrzNJYIrgndc0vaD4XQjvev/SQvK8XeJMNWv
         lBxr2qIp/7Pk6Mm1n2Hu80ctuvG6NQ+j5bnGj1kWwhdRtU3GhGESwiHx4N8oiR6PuTFu
         4wUFvqEAYm8ed3d+fpDjJ2gHvvV/3dja/nga7ZR8/gBJShIInqq1wUhJS8L1Kuawq48l
         4SEcZBs65yoYR8TlAvuGKOkDDlfHGYhNqXGoSl3WN9hY7eFvOhT7b52G+DzgmQiCoPmN
         aB9NG5jJ1zsFfZFflvITH+oAGX1keso5eiFo3ujLQ23NHkyn7Q/WlqFToyh5fMuUZYNh
         1A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751910129; x=1752514929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42jtsUDXPCPmNytXrx59THHUxajHEyTomBc5xpmWMc0=;
        b=NsNX7z/f5KT1nfZYA6gr71aVFi12avEa6rvdP+0H4PdBcSoZ9/O6MYv7Q9u3ELsSf1
         vWaRVpbQjHx9YhY7IpCHk5MNPhZyJdqoEF8xqZLzRCEE6Ek0bHEKZ8luNuukrbnypAQZ
         ygwBcNuZO5Frn8qfujvaIY+LShg4Mm2NpTRLzdcsPCrASc9JLDbmDoBU5J3zKGgTAWOT
         dJbsudyEFkRH5FvBNSEtuT+VMVkSbB62tjK99s7SuxJPBlyXDRYrgrTlJQ2rdpv4AaGP
         O58rQz9ZDp9/5g9kWCEiElA0RFw8Kh51yByWQGN+Yt0MFBgGXgvxXyJDvIwvieEsfKJr
         8+7w==
X-Forwarded-Encrypted: i=1; AJvYcCUSvMGpqiqkSia3JGfWIne7djbpD6eaC10YBf98rSy8F7fTQgmwN+k6HsRfhAh9NKsVd7HNsh41B4gjQw==@vger.kernel.org, AJvYcCWA2cY35jjYB0PruZQlPnPm0X4s1CyZfcEFFFHnPjCdtJq9OEykuPPKa+I+2zFV00yLqSKrzEomRiRI1FDc@vger.kernel.org, AJvYcCXYeqgnD1XFHu8WhDqFQTfSlYR68+MmRsF0E2wgJIUkH9SsKeHBUe9CAv3fTHrvTwW/+jcvirn3EQ6U@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NTpwnL3hKqfk5CxUJLDzK7vorcsAx8kqxc8fhj65Dbfr/8vE
	uo1Vkq5fiUmG9XwP48+RYHvgxMwsgn5sBm0GWMoC2ari/fuUqXXr53xjXjbIYGEOH4/uenmFQ9b
	47zG3P8gigWvBBAJT5Zq2J/4eSiyXiCI=
X-Gm-Gg: ASbGncuDO2dbvog8JVczWaffa3ATbVHlwBnTnkybDt8Yg9cpVM85hUoS060lJiUHcF8
	c0zRzeZxuRuDWdhqTTUhsf9DzAVKRZFa2JCldcRvgDdFMNpsl4mVUTnnT4eW8mQojf4P7wtRU2X
	/tbZYpXefI0xZHfcCnUJGsLTJsQy3hLUncZfLvgKQuuj4kJ6ZDKclRMeSA
X-Google-Smtp-Source: AGHT+IGdu+lUB6aYqtWH4AiO6Py1SgyDO+jxiLBNa4PCqXrusbUeunWL1E2NWxsWS+1ctn1q5K5//624lv0vLW+ua3Q=
X-Received: by 2002:a05:690c:f8e:b0:70c:c013:f2f with SMTP id
 00721157ae682-7179e44d3e9mr7404627b3.35.1751910128762; Mon, 07 Jul 2025
 10:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <8c6f18ca47bf0dd78b6675d8b94000679b6c75cd.camel@sipsolutions.net>
In-Reply-To: <8c6f18ca47bf0dd78b6675d8b94000679b6c75cd.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 7 Jul 2025 10:41:58 -0700
X-Gm-Features: Ac12FXwpmQW7d4a2Au2Yz5auZhjQPGBnlW83MkM8UJ0V9bkuM1yY9_y20XPBBjc
Message-ID: <CAKxU2N9vs5o4tj-9KxCHKevWU+J9wv+ZCOeD8o602y1GY8FzNw@mail.gmail.com>
Subject: Re: [PATCH 0/6] wifi: rt2x00: add OF bindings + cleanup
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, yangshiji66@qq.com, ansuelsmth@gmail.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 2:01=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Sun, 2025-07-06 at 14:41 -0700, Rosen Penev wrote:
> > It doesn't even compile. Added OF bindings, documentation, and other
> > stuff to hopefully this doesn't happen again.
> >
> > Rosen Penev (6):
> >   wifi: rt2x00: fix compilation
> >
>
> That was half covered by Felix already, and really shouldn't do two
> things at the same time anyway.
Just saw what you're talking about. That's gonna be annoying though.
The COMPILE_TEST commit will cause compilation to fail and the bot to
complain before Felix' patch gets merged.
>
> Also please add [PATCH wireless] or [PATCH wireless-next] prefix when
> you submit patches, to make it clear where the series is targeted. In
> this case, you probably should've split it up, but Felix already covered
> the immediate bug.
Will do.
>
> johannes

