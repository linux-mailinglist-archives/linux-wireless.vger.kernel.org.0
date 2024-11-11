Return-Path: <linux-wireless+bounces-15175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091839C3C73
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 11:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B484F1F20F4F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 10:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8715666A;
	Mon, 11 Nov 2024 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="E34aYsid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD081474B9
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322421; cv=none; b=D14DrJc0/Xk581kV4N6VdiUZroj1jXaFcfmiCOzRN3T6ikfbF8rpRxyTtdcbmB1Jn+4Ly89C9ySxit4GJUCzwCd4z7EOUYbq7UAQ7/Owr4sN5QmFSHw/NpZEmPgz39BsxaMzRulXcdHHvSU1CEwmanxCLKYkz+VqSAfiIDhs618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322421; c=relaxed/simple;
	bh=fv/Z01ZyA942nXbWgFy8/Yoafo12re704seWNFBRVfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUvhK+CvZMtgML3LCHZHiofUIvQPYKdJuoQSHZeBphbslAQARfJejz/hcTyfwQURb2FfFZ8bHU8RQg9uBPD3O+VQDWHuOfkj14dBSqZMahVcuLOGV7exoTbiODVfd0/clKuAsOHT2YL6tbjS5Wg5vUpNJ2gO7e4yNWNa59M9iZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=E34aYsid; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1731322415; bh=fv/Z01ZyA942nXbWgFy8/Yoafo12re704seWNFBRVfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E34aYsidTOBpD1S5d3PIE9ifkJ5V7R0YmLvQq4LwAP9IncCitEN23jSHjxJEj9psP
	 WC0W+j+9cFVlizwYXe/8RdW6ctOM7yxoepb/DzUft32jfgpIb8F80TobKTuGK97Cgq
	 z3Ifn+WLZij/8LEOsS5yUnXoERkx41kgBNsGeNlhqyrvYtCaM57movBpUiGdraUOgM
	 /dZ1bk77/ivnSXqfgsgR43jlcASdYXPE5ZXPY4FCqmwR4Wewv9Tf5rJlBqg/BvHKYw
	 E3gR2xhulEQfpM8RyZ6GSUO93S4klD0AQ8R9K0M36XOqC/oTI4j//e4p40DveT65KH
	 WJqIK75iIkHFg==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, Dmitry
 Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH v2] wifi: ath9k: miscellaneous spelling fixes
In-Reply-To: <20241111104724.484586-1-dmantipov@yandex.ru>
References: <87frny5bcl.fsf@toke.dk>
 <20241111104724.484586-1-dmantipov@yandex.ru>
Date: Mon, 11 Nov 2024 11:53:35 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878qtq59e8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Correct spelling here and there as suggested by codespell.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

