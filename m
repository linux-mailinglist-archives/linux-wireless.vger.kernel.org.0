Return-Path: <linux-wireless+bounces-22312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1CAA6166
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A344B16C6B8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845C20D51A;
	Thu,  1 May 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="li1W4gmN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E420D516;
	Thu,  1 May 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117006; cv=none; b=H4rXIA7DcSPOTw8ysKzPz5w4Ri/jUADDDutqRwq219pyYkNJS5CNJm8nCPAvniA7pvm+2l04lc+ld/DmOkty1h2ft1uruY+I0pgZtWdv8akB4JkeOVsZIVx6k442jpf4Kp7yffXBVIZJC2aeyZy9daFfrEw5DK2VvNejP9kzueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117006; c=relaxed/simple;
	bh=hNZfYFFtAr2xHt90ZdfXgjZK8UcYhDMKV8t3YTODBWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RwrrpE9Uyic7QzEGpBLGqfHgwBULSBM+99G7d1jqHYS52Zjv9nfMWZd7yFK/ay9+J55c+5pmKiGRbhbbzjPxbIjz09PZEwW/P12D6dGWjY0CHatiXHhms5KCEmoF1Of4UB9815+DCNKmSReHg9mgmDwg4x5tv9L77VUzYYXrf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=li1W4gmN; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1746116442; bh=hNZfYFFtAr2xHt90ZdfXgjZK8UcYhDMKV8t3YTODBWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=li1W4gmNEOZXw7qZPbl2GyNKGbS7Qt01EHKXqgUDAT0g1m6WiRfIzmzbwQnNRUgnO
	 t6tN8jHiS7NQ00RkQ6XLGB/JOtWjEjxcCVvtBPFqaUvnCemFSxepf/irq7jcRThJs9
	 Ng6kVmubrp0bDAA83PkBWjXpF6hl7+zHtTgw7hqFvgE1zqXF05DX5/UuPExNUs6rXh
	 T9bSHtXSGDCsaNYfdD5YjHdG0uvRkExq/VmKB1M5bLsLYmxJIJBAAH0bknRkq0kwIm
	 tv34LbQrRoYJC7LRbAlekYfx6RXKcH3ls+boB65JrNVkK0KegLESdL/tvEVHwNEw/9
	 xP+B9YzpY6y/A==
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] wifi: ath9k: ahb: do ioremap resource in one step
In-Reply-To: <CAKxU2N_3mcv7e2i8Z_b0+oQUXxMmpKH1eGvEZiwcRxx8HKYDwg@mail.gmail.com>
References: <20250421040044.44887-1-rosenp@gmail.com>
 <87ldrsjrvp.fsf@toke.dk>
 <CAKxU2N_3mcv7e2i8Z_b0+oQUXxMmpKH1eGvEZiwcRxx8HKYDwg@mail.gmail.com>
Date: Thu, 01 May 2025 18:20:42 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o6wc5mlh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> On Tue, Apr 22, 2025 at 5:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@toke.dk> wrote:
>>
>> Rosen Penev <rosenp@gmail.com> writes:
>>
>> > Simplifies probe slightly and adds extra error codes.
>> >
>> > Switching from devm_ioremap to the platform variant ends up calling
>> > devm_request_mem_region, which reserves the memory region for the
>> > various wmacs. Per board, there is only one wmac and after some fairly
>> > thorough analysis, there are no overlapping memory regions between wma=
cs
>> > and other devices on the ahb.
>> >
>> > Tested on a TP-Link Archer C7v2.
>> >
>> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> > ---
>> >  v2: remove wrong devm irq conversion.
>> >  drivers/net/wireless/ath/ath9k/ahb.c | 13 +++----------
>> >  1 file changed, 3 insertions(+), 10 deletions(-)
>>
>> Is there any benefit from this other than code simplification? Because,
>> TBH, I'm not sure saving 7 lines of code is worth the risk of changing
>> something we know works already...
> It's the same API calls fundamentally. This change has already been
> done treewide across various drivers.

Hmm, alright, let's give it a shot...

-Toke

