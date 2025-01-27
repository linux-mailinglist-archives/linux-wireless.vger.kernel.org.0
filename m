Return-Path: <linux-wireless+bounces-18022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3AAA1D684
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 14:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AD6163BFC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F691FE479;
	Mon, 27 Jan 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="XV1YOTid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C01FC7D8
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984124; cv=none; b=Y38JYMKYdsRLwtjuV11dPdZCf291fM3wKtF2lgz+xgBrKIPZ4g35btejPdfeH7fTIrQ7gKT6Qf6PyiEBV5ymXu6fNIEokmGJkWdjgI+CIq6GxPRPPZX3N1QW/eNyvf8v1HqRHkGkY9RVMBxq/mbNGh6oYLA2J4yuycTOOx5eVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984124; c=relaxed/simple;
	bh=wcBUHKcMBU9qvstUTwag2/LbQgRycLUz/odcmZ7/xco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbDU9ytw9po+aMBXY/+235P+UBo4sygy+wUBSa36YAOCHnXxRe0hVxjMFYkbSKBAWt4TlpcxLPgSLBExxV0Ci56yjIipwi0cEQUgAXoCAXSvgbFf4pIKtOfW1/W1OmlwggNU0+zKhjtuC0bN5N5dspJjE5VzY97gHISC7W5gdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=XV1YOTid; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1737984114; bh=wcBUHKcMBU9qvstUTwag2/LbQgRycLUz/odcmZ7/xco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XV1YOTidgLkMKxaAK8Bkwe89rdhIO/pzQukytC5yD7GDaZjvtDPNAkL7ZoWGAQk39
	 bIFDh+g/hegAJ8MjoJ7e0eh/B51z4/w3NvF4S2Y/kl6wmWNkc2OF9JTgBWZyxB82Vg
	 0BHq9qeILX0fZ28RFrAFJPrDUa2Lc7lexTz6tEYWq15s4y4tyXdRg/6T8Y140AkTN2
	 0d+OP8r6LsAWQ6uhf8GlhtebW/EY7oWxYLuMCFgPe6n1KOKJYL2qsJRVU1siBjF2Zc
	 yg1AkzG6iri+/MCB571R8JaeS4VtdkiRxo9RV+iEaxM0Q3ncgDh+Oh0VODItRWsLdn
	 fGJTtJi2Al6Kg==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, Dmitry
 Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: do not submit zero bytes to the entropy pool
In-Reply-To: <20250123141058.1696502-1-dmantipov@yandex.ru>
References: <20250123141058.1696502-1-dmantipov@yandex.ru>
Date: Mon, 27 Jan 2025 14:21:53 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a5bcpf2m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Antipov <dmantipov@yandex.ru> writes:

> In 'ath_cmn_process_fft()', it doesn't make too much sense to
> add zero bytes in attempt to improve randomness. So swap calls
> to 'memset()' and 'add_device_randomness()' to feed the pool
> with actual FFT results rather than zeroes. Compile tested only.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This should probably have a Fixes tag:

Fixes: 2aa56cca3571 ("ath9k: Mix the received FFT bins to the random pool")

With that:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

