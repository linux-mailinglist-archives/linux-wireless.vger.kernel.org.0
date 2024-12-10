Return-Path: <linux-wireless+bounces-16153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DEF9EAD6D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 11:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B34D16B31F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFEE23DE80;
	Tue, 10 Dec 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="eEbJJJSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185623DE92
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824738; cv=none; b=XpZ9jgWD5o0iZz2ihMNrI6h012X4ErTccgk27YyTf/LpmOG3CMZ+HFvOpZi+JsO9AejVVAjdW3a57pNNtDax3xJEAsx24EfopIwpKCZsev58OhBytXwmP0luZU+2dz/BJE31KkrHg+vyphRyjWe6kJXL/9JbRALXeIPccoq1538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824738; c=relaxed/simple;
	bh=lo0j2H2dZfXOjbJTv4vtXGi8iUWP3x8twvv/cqXlGbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BlzdDyWN1cnRewi1jDVF+MTpploYdeJF4Y6zqkpyIc9wNgxyqLSj6Wij/sOCqf8orjWl4DoXzsr2siAy2J9puaKGGdBRcmj1AUc3+B7N9AVOQlAwK591ufA2ab/5l2CSeddIRBzHJmQ7cJNXVx6QTf+Wgw9J88Pvmcl9Oaf3KuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=eEbJJJSk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1733824724; bh=lo0j2H2dZfXOjbJTv4vtXGi8iUWP3x8twvv/cqXlGbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eEbJJJSkBanWk0J+0FWLQkx7KxFfBQrKxxtmPaOa43ovtXaIPMh9iYkIOli/XmXHq
	 Rxy3gUxm780EFx+sI6Uhv0Np4uzyfFzzFhEjCFRZ4BADbe0+Q4bHG8tYr3G1kwFLg4
	 QaiO41RgiJ5YtlXCM7LnAY1MxWOY1OYR+sag8o0CbBcd5A+WygLLdW0bsZ/7vvGTWr
	 IRcpGd4pu4aScC4jp41SWcaOMIxvQ3Sq2nbH2QC+5NqpMdWKvaCXS/XHIzY4dQGZo9
	 vL7HKRhMHaRDbFTmevG1Dfwsn5FIuY/Yx4aoyelrKDAmCtwneXIeTeAwEge/lGyowh
	 7PBhXjLQCqMww==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 3/3] wifi: ath9k: simplify internal time management
In-Reply-To: <20241209155027.636400-3-dmantipov@yandex.ru>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
 <20241209155027.636400-3-dmantipov@yandex.ru>
Date: Tue, 10 Dec 2024 10:58:44 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877c877tbf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Prefer 'ktime_t' over 'struct timespec64' for 'struct ath_chanctx' and
> 'struct ath_softc' timestamps, choose standard kernel time API over an
> ad-hoc math in 'chanctx_event_delta()' and 'ath9k_hw_get_tsf_offset()',
> adjust related users. Compile tested only.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Nice cleanup! Just one formatting nit:

[...]
> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
> index 2f137856a823..cf664a0dedaa 100644
> --- a/drivers/net/wireless/ath/ath9k/main.c
> +++ b/drivers/net/wireless/ath/ath9k/main.c
> @@ -247,10 +247,8 @@ static bool ath_complete_reset(struct ath_softc *sc, bool start)
>  	if (!sc->cur_chan->offchannel && start) {
>  		/* restore per chanctx TSF timer */
>  		if (sc->cur_chan->tsf_val) {
> -			u32 offset;
> -
> -			offset = ath9k_hw_get_tsf_offset(&sc->cur_chan->tsf_ts,
> -							 NULL);
> +			u32 offset = ath9k_hw_get_tsf_offset
> +				(sc->cur_chan->tsf_ts, 0);

This turned into a really odd line break. Let's just keep the variable
definition on its own line like it was before, so we can keep the
function call the way it is as well...

-Toke

