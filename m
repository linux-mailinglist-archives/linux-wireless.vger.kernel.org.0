Return-Path: <linux-wireless+bounces-10976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B709482B5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCB5B20D1C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B979166F3B;
	Mon,  5 Aug 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="nNA/rZyD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB6143C69
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887788; cv=none; b=UjNOaYTaCLBrjk4EsxW3OrHmCB0NgxQneGngVNKzVrH1jnBuro3MAycNBDxmShmjStVfooauDd4HAPEfxNNUhN2OUxF5bslzaKN9XJg2yECz7M3mK1d1MjldRlKkZuIptkSzmblwOQlmcr7ze2xh0x+7d8DNJe9rlk4UCZX4hCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887788; c=relaxed/simple;
	bh=wkT44esGhnlM8ZVgMEgvE4JBV1VTYimATy+v8T/mPF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0w5gjE6Pp6WOOGpgGL5MGxVyEkhXslJGLOqly9SvJ5d6oUItoCUr1wgzWeFK/S17mpuKKlZ2/pwpAAyQhs1qalf9EpzYTOr8azjYw3ieJ2ZvPWfFB7mRITl84d9ggk5UhuIE7GY8fiuWC3bzeLp7E8thcxv+w4ZvHKO4N8NgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=nNA/rZyD; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722887779; bh=wkT44esGhnlM8ZVgMEgvE4JBV1VTYimATy+v8T/mPF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nNA/rZyDGlq2d72sx6J5rMH2iSsDKynZ6EDxfCT/p13eeJt5Px8nbrAddGLO9kJc5
	 DClfhJkBhi6tub9HEOzPPsXOQaoEVn+CkzXIouK+q5oPpxXKYByK9xzqVzVDBWebqq
	 8v/EQkcAghrafnsB9NCcHrxHv0eDbBLxs1ZwJ05z7A+a/6yK6Gmth6ir5JTuldRrVs
	 2vX7YIMym5ciad9NJHjSuDAdsLlE8Bn/5pn+9Ypn3lyIH128HGFTIk46ioLhE8Kbw9
	 1TSRh9OG6+KeOBCygpEXr0A687LhbkYg/tr3HIt2FmhoNcYLenM5O6bqN7Aeg4IcVc
	 QY9JNodYcyjwQ==
To: Wang Ming <machel@vivo.com>, Kalle Valo <quic_kvalo@quicinc.com>, Minjie
 Du <duminjie@vivo.com>
Cc: linux-wireless@vger.kernel.org, dan.g.tob@gmail.com
Subject: Re: [PATCH] wifi: ath9k: Remove error checks when creating debugfs
 entries
In-Reply-To: <20240805110225.19690-1-toke@toke.dk>
References: <20240805110225.19690-1-toke@toke.dk>
Date: Mon, 05 Aug 2024 21:56:18 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ikwepwv1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> We should not be checking the return values from debugfs creation at all:=
 the
> debugfs functions are designed to handle errors of previously called func=
tions
> and just transparently abort the creation of debugfs entries when debugfs=
 is
> disabled. If we check the return value and abort driver initialisation, w=
e break
> the driver if debugfs is disabled (such as when booting with debugfs=3Dof=
f).
>
> Earlier versions of ath9k accidentally did the right thing by checking the
> return value, but only for NULL, not for IS_ERR(). This was "fixed" by th=
e two
> commits referenced below, breaking ath9k with debugfs=3Doff starting from=
 the 6.6
> kernel (as reported in the Bugzilla linked below).
>
> Restore functionality by just getting rid of the return value check entir=
ely.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219122
> Fixes: 1e4134610d93 ("wifi: ath9k: use IS_ERR() with debugfs_create_dir()=
")
> Fixes: 6edb4ba6fb5b ("wifi: ath9k: fix parameter check in ath9k_init_debu=
g()")
> Reported-by: dan.g.tob@gmail.com
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

From the bugzilla entry above:

Tested-by: Daniel Tobias <dan.g.tob@gmail.com>


Kalle, if you could also update the reported-by to include Daniel's full
name when applying, that would be awesome :)

-Toke

