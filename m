Return-Path: <linux-wireless+bounces-21855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D04A978B8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 23:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B2E1B6176E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 21:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8731C2D028D;
	Tue, 22 Apr 2025 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiIpQjcu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186C72C375F;
	Tue, 22 Apr 2025 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357655; cv=none; b=Bqa6KIsPmr5AIwHlvzXOuv0OcEFCD4LzQlJ8AQkqTMfFvkWCZjgAWlM3qi9qoZkDepGFiZkb09s6CiayL94B1oR5ZvEeXPz55w6dEjdsQkmEqEsXn5ShuN9eJ5xg6lC+x5J1M3tG29Wjixu5GawYd+Anp4HbpjnrsBlG2WF+qZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357655; c=relaxed/simple;
	bh=jzoeHJ9FVvRsDMLGjGjuYfISbaEIiA0srGKxxKNCibU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmCeebr/Fjmh32BxksgkEME0t6HUW09OBHDISpo0vLeNxhQR/6Zv5GuC1nIAy2xp8LUH08W8dOLzQAbfIfZ8DEholvlifwjLFwSZUG6kiIwX2MAjaP3pAehIhWAV2/q+csabcE2XdIL8acK704Y4g29Jq0aZdDytu1SqoBedPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiIpQjcu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7270e0edf5so5221908276.2;
        Tue, 22 Apr 2025 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745357652; x=1745962452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HiyJagRpv7rkDBgAFearXvQuPs3vB2yHec2EHcgxLI=;
        b=EiIpQjcuW7+u3NgKQk6gUo3l8CMOgP5EuK2sF/vf196do4P1nZ+tfGObJw83/cA35g
         1rSYzqYP6m1/rpg4zOpgXZo75o+nnVBBBFMe2ydCU2raZQFWKMIUWrI8DkdTn5DATSYn
         6hoxVmjtKn4iLucwkJ28Jd5JjBAnBNSNluRlHHj9uipHBUfUcLKsNaZwjbRpdOh36RG7
         YFZ5/f10dW4La/eNzquQ5UkWOLcDo3nFLlSkJt0otKAUWdftfI7A6RLFma48AGY5hpiH
         4ODraSLqXPhfEsz0HpMlCdY6Hz1DmKiJJFtmOCSMPXwleHJ26VEXsGltL4ShxmgewvF7
         Aa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357652; x=1745962452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HiyJagRpv7rkDBgAFearXvQuPs3vB2yHec2EHcgxLI=;
        b=mdqKAlXmASJARL7mGu37U9V9D91sbFjg7ZGmtjtgJJy741NUlnQY07j3NDPMe4FJKL
         fLKXOjeC9JKhnN61RZhxfSgS24dX+p3OREGFahkWnZQb+FAM7/y82803CvILLrqVRozn
         ZCU1D9oEjkmUhs1cVXKu9rBhDPl25VfnORNxSmiM+TP8bHup1xS1ox7TS5PsKv0I7cP1
         qxN2D5+YYMxPru1BaduVq6krLyiyExUuMs7qV6Z58ZE8EILPIm5Xe+gDni3Kho5Pu8oa
         AQpSM9e7RUEIpCXCiQfmQpXv9/B4xsYVZ+p+tmz406GapjYCUN5sVNE0ZqKbT+ufrt62
         W8qA==
X-Forwarded-Encrypted: i=1; AJvYcCVxEJtRtqD4rnLbmpH+2PN2pHsNrTbIEGwcJYoeNKk7SBBQFGk4iF+dr6GN4j6e+7z8RQVkLAEMQe/VdIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2sBTfRoH14jmGo/qlLnZYVkeJfuOUnyNAnAlMBy4vY8AliMm
	ddS3bjUHm4ekRQtv4yGN25YSzqX3QIL7s5O8/XdSizU0OagX9eQo9v7Re7y3EsQ10PjIjntjy3q
	pgKH8sX/0IhlLolzNpLwTv7dtzRq0gA==
X-Gm-Gg: ASbGncsscsglc8D54nu9EOsABWF/FdI2aKsVYSOySqIFXnoanPnXeoxWQVi+pltCjMF
	Fsng6cc8ZqclpDF4nf4h0u+4qYfMJmFDWhemqN+/oLCt5/ZCzbN0dabDuoXPHhHbi/QpX9YiqR2
	SlxEEjbzZfXoLuQjd4/djoql5/3kObk90YpP8=
X-Google-Smtp-Source: AGHT+IHU5Mn5USXaef0BijWjn6/jTRvhHUWpRdRSi8Cx7eocNGEyOf1eCE7Y0UIdEtHPUsU+8Q/SrGB9UAjT+NRm+wA=
X-Received: by 2002:a05:6902:a87:b0:e6e:47:2f9a with SMTP id
 3f1490d57ef6-e7297e9a8dfmr21941600276.37.1745357651893; Tue, 22 Apr 2025
 14:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421040044.44887-1-rosenp@gmail.com> <87ldrsjrvp.fsf@toke.dk>
In-Reply-To: <87ldrsjrvp.fsf@toke.dk>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 22 Apr 2025 14:34:00 -0700
X-Gm-Features: ATxdqUHZp1L6DWILXwtwVqezi_PEfSVOLbt9wTNg5-uagVKjF3xkQUXH-UQUdEg
Message-ID: <CAKxU2N_3mcv7e2i8Z_b0+oQUXxMmpKH1eGvEZiwcRxx8HKYDwg@mail.gmail.com>
Subject: Re: [PATCHv2] wifi: ath9k: ahb: do ioremap resource in one step
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 5:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > Simplifies probe slightly and adds extra error codes.
> >
> > Switching from devm_ioremap to the platform variant ends up calling
> > devm_request_mem_region, which reserves the memory region for the
> > various wmacs. Per board, there is only one wmac and after some fairly
> > thorough analysis, there are no overlapping memory regions between wmac=
s
> > and other devices on the ahb.
> >
> > Tested on a TP-Link Archer C7v2.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: remove wrong devm irq conversion.
> >  drivers/net/wireless/ath/ath9k/ahb.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
>
> Is there any benefit from this other than code simplification? Because,
> TBH, I'm not sure saving 7 lines of code is worth the risk of changing
> something we know works already...
It's the same API calls fundamentally. This change has already been
done treewide across various drivers.
>
> -Toke

