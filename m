Return-Path: <linux-wireless+bounces-16395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603229F201C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 18:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DFF1882576
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE628F1;
	Sat, 14 Dec 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="InC4bCL5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877A2033A
	for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197399; cv=none; b=k7mAuqc6IvH63N6rbv0tPwT/KZGxkBrPl+UEe2gzdqEDN9qI4da1hOvp13BQt0+plSeWyntndPvypRg7Vdsg07MmOcEGA619/V0Rn64hNDu5sNC/hE7Q2lBRDo3aAhmWJbBAU8kMA0ufarx+ru4MmLUq5hwauJyqHMK0ehTooUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197399; c=relaxed/simple;
	bh=ThZOXefZ9yd9IumeyOHYVNYaRxbozUxo8zPvhTXCZw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4AX+WHvqr+Ym5D72vBZf2ABtSlUxt44Mt/BHcBs6PTt/sSx1XAFO4p8KbCkIVX0X0Evyx8EmoCVLFoYcEa1hwPfsyPqFB6no6nolrjzxnwrQWK6C2wXdkS0QgECJ5yeiN6QF5JNiq9stlwYTtAlPkEwJ5uv5EJyKXBWHdgdiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=InC4bCL5; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1734197386; bh=ThZOXefZ9yd9IumeyOHYVNYaRxbozUxo8zPvhTXCZw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=InC4bCL5RGrmGJYMF9vMx3gbeuSK3r+J4nPdE0c0qYAR1CkqRGXQzTFJVg/2t3gVa
	 x2pFbaHYRdpqwj76VRQAvzsAGhwZejZuPsweFOFwEyYpTOFUBVCJinfV2E3qMwycax
	 V/xf1BqSIBYnQL42dg2yaJ8TzsiGFxPlWH6bY9sRwhyTwM7oSTB3kzVkxFX624dFtn
	 tLrZvgS9VwGi3EQw0l7sjtUsucQYgiufYeeZ6gL43yGmB9f8RUsQUqELTfuupvnsRE
	 tMedKFMjQUvL3foMJn8JxCeDRyXehK9rajFhDX9HMez7+6ouelO5fTg0i7CLTVe55+
	 LSSAJWftb+Ezg==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 3/3] wifi: ath9k: simplify internal time management
In-Reply-To: <877c877tbf.fsf@toke.dk>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
 <20241209155027.636400-3-dmantipov@yandex.ru> <877c877tbf.fsf@toke.dk>
Date: Sat, 14 Dec 2024 18:29:45 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <8734iqkwae.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Dmitry Antipov <dmantipov@yandex.ru> writes:
>
>> Prefer 'ktime_t' over 'struct timespec64' for 'struct ath_chanctx' and
>> 'struct ath_softc' timestamps, choose standard kernel time API over an
>> ad-hoc math in 'chanctx_event_delta()' and 'ath9k_hw_get_tsf_offset()',
>> adjust related users. Compile tested only.
>>
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> Nice cleanup! Just one formatting nit:
>
> [...]
>> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireles=
s/ath/ath9k/main.c
>> index 2f137856a823..cf664a0dedaa 100644
>> --- a/drivers/net/wireless/ath/ath9k/main.c
>> +++ b/drivers/net/wireless/ath/ath9k/main.c
>> @@ -247,10 +247,8 @@ static bool ath_complete_reset(struct ath_softc *sc=
, bool start)
>>  	if (!sc->cur_chan->offchannel && start) {
>>  		/* restore per chanctx TSF timer */
>>  		if (sc->cur_chan->tsf_val) {
>> -			u32 offset;
>> -
>> -			offset =3D ath9k_hw_get_tsf_offset(&sc->cur_chan->tsf_ts,
>> -							 NULL);
>> +			u32 offset =3D ath9k_hw_get_tsf_offset
>> +				(sc->cur_chan->tsf_ts, 0);
>
> This turned into a really odd line break. Let's just keep the variable
> definition on its own line like it was before, so we can keep the
> function call the way it is as well...

And since Jeff has agreed to fix the line break when applying, with that
fixed:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

