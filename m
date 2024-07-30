Return-Path: <linux-wireless+bounces-10674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB809940E53
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 11:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1454B2812E7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DCF1946DA;
	Tue, 30 Jul 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="Ki0s/PL7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633EF194158
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333227; cv=none; b=c44pzDPiJ5jH1YY6YmUKLtUt7x9SDMw35u/HRLH4us6LG75+v7FmdlajeBJknQ6ezHGNMFHKp4uVP17h5BVvCK7HH7T16a/rGkPfBxU/xtrrlb8vbRJ/PwKrhi/cdH5N2wet4lytiM3ayrTFN7oI0rQaRcDVOG8lJpzPD91aXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333227; c=relaxed/simple;
	bh=g44PRQ+GiKaYvQqIYkuTnZR4CkxLCG7/hMhE+CH4x9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G79VtTGhNmye7yMFf1c4o2cazIcqkO7YhnEohZJBiejGlKwUCnB90i8WKDuspKiZdjjjvQ9nN9QQHVqWIFJfhl8oYy9NhC+wwJZAB/XmAwrz09RhyiTtR0BXIAju/bxFFYfn8ZQZLSNZy3cXoghwt8Txisf6ULCMZ+xuVy2DZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=Ki0s/PL7; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722332790; bh=g44PRQ+GiKaYvQqIYkuTnZR4CkxLCG7/hMhE+CH4x9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ki0s/PL79r1W8I5nnecNAySGMYQ08xuW/4hDxzPYVB3Q9sVymInWa93co6lX740+G
	 74WEndnavmX7uohcP8K85dhnxdXLiFsuxetX5Hqq4uIuCsvRnuPbYfz1aOGWfhi67x
	 NWl0l9w+m0F1Y2tM7jgFcnQUl4P/4ZF022By+6lcNCpjTorQaGB0XrAFRfvg+rdZ+N
	 G3oqQQYiNa+r9RcKgl1YZHD/oGF10I8xSNgzFFn38fvHr2gXZr308r0DhVKgIckrVA
	 hMtHPgT9htTf/eMz6TK4A8oMbi6F4QX0Vc0EpWNjSuITaOEiFBMYDOT0IfGOCjGo+X
	 xkdjfrl6eY6pQ==
To: Dmitry Kandybka <d.kandybka@gmail.com>
Cc: linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: fix possible integer overflow in
 ath9k_get_et_stats()
In-Reply-To: <20240725111743.14422-1-d.kandybka@gmail.com>
References: <20240725111743.14422-1-d.kandybka@gmail.com>
Date: Tue, 30 Jul 2024 11:46:30 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878qxjp5zd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Kandybka <d.kandybka@gmail.com> writes:

> In 'ath9k_get_et_stats()', promote TX stats counters to 'u64'
> to avoid possible integer overflow. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

