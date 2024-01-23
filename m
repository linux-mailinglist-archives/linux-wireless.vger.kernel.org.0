Return-Path: <linux-wireless+bounces-2368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B6838A55
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 10:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34C71F2687D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917C5A0EC;
	Tue, 23 Jan 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqLJHHqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434259B55
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002119; cv=none; b=bBRnNUfaHN2cw1l0gY52BBym4ifTbE1aRvWAGKYTlLihyogGEd52NzzIE+4zhsKWDO/i0JkAHFZDrJQlJHPsECXaPmenmlDSamb3WlQNQ+Ev1edNxf8pSitDuvkesVB8nV6n5jMNpn5piCufAxexY9r0/ighjUTLPGtJhKGTNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002119; c=relaxed/simple;
	bh=OLDqQtAVpYKH8FILJaqWEUAuWL+Gqfz7VifCzRQv7NQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=s6VFbriSL61rjbTPCSLtCkYZa6vdt0T8K4y9dXadsHIPWWjqqiMA3BOQ1FFcXu5O4Om3YqnhoMohJ3IwKSeBiUdHOhXDxCneX7t1vMF8YKB4Bv0FLmb+kb9IS8Zz9aDcE3h4ssRpZ+JpOBm2N0v30eOIfrUYO1rq2tfhomTTaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqLJHHqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0854AC433C7;
	Tue, 23 Jan 2024 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706002119;
	bh=OLDqQtAVpYKH8FILJaqWEUAuWL+Gqfz7VifCzRQv7NQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BqLJHHqVl+BBumzvP/IR2GM/pMRDxw89X7nmhkkwb27VI2SaqhQgQJ7XbjBRCTnGE
	 h/B/ExC+lu2Qmrt0cm/dituxehcBK201UEzeYOMNEHGlh5iNP5d7SKKNd71aloud3L
	 DMKMgRhOGtLyP5GByp0+Na0NED3gtKkiOBI2gyjkET7AlmjQThww3Lk6PbsioyJ3MH
	 BXgbXVtMUnt6QhABU8iJ571cThArSS3rl6Phi6S5VAMEym++T3zNCscMTwuyhqPqSu
	 WaTQ+ZArIxjdCQeRO1fF6jJp2Iu+XA2IBjbfMI+nR4M7QLSFUvGbHm2DLRlM7z48fr
	 We5BnEJOXZ/YA==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: David Mosberger-Tang <davidm@egauge.net>,  Ajay.Kathat@microchip.com,
  linux-wireless@vger.kernel.org
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
References: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
	<e17d654a-8bd5-4327-8bf2-ad81c2f7355b@bootlin.com>
	<5ff15ae65ccb7c144ba8e0f07dc2ac25bd8b2b42.camel@egauge.net>
	<7615dcfe-4363-4d00-aac0-510c279f6b96@bootlin.com>
Date: Tue, 23 Jan 2024 11:28:36 +0200
In-Reply-To: <7615dcfe-4363-4d00-aac0-510c279f6b96@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Tue, 23 Jan 2024 10:16:48 +0100")
Message-ID: <877ck02ybf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> Hello David,
> just reacting to your answers, but I will take a look at your updated pat=
ch
>
> On 1/22/24 21:41, David Mosberger-Tang wrote:
>> Alexis,
>>=20
>> Thanks for your feedback!
>>=20
>> On Mon, 2024-01-22 at 15:19 +0100, Alexis Lothor=C3=A9 wrote:
>>> Hello,
>>>
>>> On 1/19/24 22:51, David Mosberger-Tang wrote:
>
> [...]
>
>>>> + if (ret) {
>>>> + ret =3D -ENODEV;
>>>
>>> I would keep wilc_spi_configure_bus_protocol original error instead of
>>> rewriting/forcing it to -ENODEV here. I mean, if something fails in
>>> wilc_spi_configure_bus_protocol but not right at the first attempt to
>>> communicate with the chip, it does not translate automatically to an ab=
sence of
>>> chip, right ?
>>=20
>> Hmmh, I'm happy to change it, but, as it happens, all failure returns in
>> wilc_spi_configure_bus_protocol() basically mean that the device isn't p=
resent
>> or a device is present which the driver doesn't support, so I think -ENO=
DEV is
>> more useful than returning -EINVAL (as would be the case).  Let me know =
if you
>> still think I should change it.
>
> Yeah, but then I would change wilc_spi_configure_bus_protocol() to return
> -ENODEV instead of -EINVAL, if that's really the cause, and just let call=
ing
> functions propagate it. That may just be a personal taste, but I find it =
pretty
> tedious to debug some error code and eventually realize that some interme=
diate
> function just rewrote the real error to another one (and sometime, loosin=
g some
> info while doing so).

Yeah, changing error values is very much discouraged.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

