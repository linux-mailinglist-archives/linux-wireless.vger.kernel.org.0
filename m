Return-Path: <linux-wireless+bounces-16154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4DE9EAD61
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 11:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631EC28697C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415123DEA1;
	Tue, 10 Dec 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="kgKf6di/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37F78F40
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824782; cv=none; b=T4tTYoXY6Y1b8plw3MMCerSibCaE1ZolKC3s2x0Wl+JbqYGEZrLGPXi27WWPKm0rB3OK3noefrkEtcipPQwpw5+H/Nt/HblrU0I4cir1GhJyYuzs5nr3bRGYZ9KtMjBQKL5n6Yut5UNiH1WlTKtBTn8V4hst+eHpECObjA+aZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824782; c=relaxed/simple;
	bh=pVgy5ggPlRIlN5EjVNEKJD9UrQm4GiMoqtJCPk9Ae+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjMii/SWxyhb8DgM5y8WcXGsDYXM96Alqn6UgcVHQ/0pnpuNSUdcZcGB8jhi9emboBtLoQzoIBRV1NxQYYtd6ZECXLBSyGYQqqjGMuv3KyKbNThKjhO3Sdz1lxwyWmfyJ4//wukAfKOIEr1VpVsEhG6EBZiBjDT0BZyYrv9IeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=kgKf6di/; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1733824777; bh=pVgy5ggPlRIlN5EjVNEKJD9UrQm4GiMoqtJCPk9Ae+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kgKf6di/ua8geNwtPlAXxkJvpYiCJGSemCD7k2jmjoDSPxaN4fXphRmYqIojlbgTq
	 hz0FzdE0UbPB/2YHvSEw7PDLw0i5jE60pB8JHpP2EzM5f5z/wbVM6X67TXMrBbWa/H
	 65hYt5AUD5An/z0xewa9PaP1mn//6sz3bNlFQHikyipvfHP7egVb0dhvynlwD1pPav
	 ucpr9i/BVEWIhdT0s5dD3s1kvGB/OJ+lm49ExndRhtEGG9o4afyzemrT7bu4V3DSNx
	 +3bqmFNPpbwX0stO1gS2v2IgEsbXmQGiLP2X5/gHAX+nm/7IuiyeNmX5Tg8yRG/BfW
	 rmKbB0IGKKxCA==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 1/3] wifi: ath9k: cleanup ath_txq_skb_done()
In-Reply-To: <20241209155027.636400-1-dmantipov@yandex.ru>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
Date: Tue, 10 Dec 2024 10:59:37 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874j3b7t9y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Since 'txq' argument of 'ath_txq_skb_done()' is actually
> (mis|un)used, convert the former to local variable and
> adjust all related users. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

