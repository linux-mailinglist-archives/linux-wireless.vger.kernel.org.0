Return-Path: <linux-wireless+bounces-16425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537259F3A11
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0390188F43C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04772080FD;
	Mon, 16 Dec 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="bFCJIW/E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED3126C08
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378187; cv=none; b=XJ7wCixa/0ce3BRfI1nla92xIrtgOPEJD1c3NYivhMqsnSfplabDOR7n4fP0X44TDmci3cle9aEgT++ROFgeF/8oo40tWBpcPTZoO4ej8ICTTSUNOfkaqvPGIBaayc9SwMjXW7P4jAo6hGu+dW+fck/xFEXFLli6hzsw80guJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378187; c=relaxed/simple;
	bh=GqEfKI55SQ/uZ/xpR88S7MmWtn0LhFI+ityQ7UPUkKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eefMiawpDJTELzW34r3j5a38V5bEkZ1LaUFX89ehhee0ezYqHqlAfkQCv6iE0NRnBDgfIfVIT0TgTgpnYGh3mWShdhESgxh2Bykr0fkEnEjT4s1qN/6Iz1XRifI8ZRGRXb0cMAP+sSjjOVKUY3nSOjZoCg0hDEa+dWrzIyn6zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=bFCJIW/E; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1734378172; bh=GqEfKI55SQ/uZ/xpR88S7MmWtn0LhFI+ityQ7UPUkKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bFCJIW/EAvyugx+Gk+qdgZLnUtbCeQ6prQZ4GDs3Q/z7vkts9xNNLzVus1jnZL0hf
	 r8uzeYzMFmWBcKJH1iSv4VTGHLwzKzPpX9TTIwrletZSBTG2SY4IuoNRuZGWZdgv9J
	 bdxM6X3b9P6rluir5zzlSGqr3ymfNleLxjs+xIzicQsfPgdqGNkwLuRSpJ8cKwiVJ9
	 +Mrqxu1p4C3xI32iUnqlpQyyQeI2Qd4El8EyHaVLqRcUuetVejp0/S3u4bmEYSfWYb
	 nY7SImuPXcDYpk75QCgw5jXowAvg5oqLCOwQXNjP6Mimt1DZajJ4xU4btJZWpJVD1o
	 GoRVN/04Yge0A==
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Dmitry Antipov
 <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH 3/3] wifi: ath9k: simplify internal time management
In-Reply-To: <20eb00d1-5d92-4a88-baca-cc0ccb78bd03@oss.qualcomm.com>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
 <20241209155027.636400-3-dmantipov@yandex.ru> <877c877tbf.fsf@toke.dk>
 <8734iqkwae.fsf@toke.dk>
 <20eb00d1-5d92-4a88-baca-cc0ccb78bd03@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 20:42:51 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cyhrjtxg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> On 12/14/2024 9:29 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>=20
>>> Dmitry Antipov <dmantipov@yandex.ru> writes:
>>>
>>>> Prefer 'ktime_t' over 'struct timespec64' for 'struct ath_chanctx' and
>>>> 'struct ath_softc' timestamps, choose standard kernel time API over an
>>>> ad-hoc math in 'chanctx_event_delta()' and 'ath9k_hw_get_tsf_offset()',
>>>> adjust related users. Compile tested only.
>>>>
>>>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>>>
>>> Nice cleanup! Just one formatting nit:
>>>
>>> [...]
>>>> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wirel=
ess/ath/ath9k/main.c
>>>> index 2f137856a823..cf664a0dedaa 100644
>>>> --- a/drivers/net/wireless/ath/ath9k/main.c
>>>> +++ b/drivers/net/wireless/ath/ath9k/main.c
>>>> @@ -247,10 +247,8 @@ static bool ath_complete_reset(struct ath_softc *=
sc, bool start)
>>>>  	if (!sc->cur_chan->offchannel && start) {
>>>>  		/* restore per chanctx TSF timer */
>>>>  		if (sc->cur_chan->tsf_val) {
>>>> -			u32 offset;
>>>> -
>>>> -			offset =3D ath9k_hw_get_tsf_offset(&sc->cur_chan->tsf_ts,
>>>> -							 NULL);
>>>> +			u32 offset =3D ath9k_hw_get_tsf_offset
>>>> +				(sc->cur_chan->tsf_ts, 0);
>>>
>>> This turned into a really odd line break. Let's just keep the variable
>>> definition on its own line like it was before, so we can keep the
>>> function call the way it is as well...
>>=20
>> And since Jeff has agreed to fix the line break when applying, with that
>> fixed:
>>=20
>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>=20
>
> Please check:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3Dd953ce0fcc7ce69edb5a3a39ea3a98ba2347976d

LGTM - thanks!

-Toke

