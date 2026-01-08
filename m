Return-Path: <linux-wireless+bounces-30566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0966D03CBE
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B240306C542
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4C4DE213;
	Thu,  8 Jan 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nYk1dtS+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739CB4DE215
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877055; cv=none; b=O/qMP+LFkXzWsY2d+FMhYKbzbCgS68vbi25QpBsYqb8AlkbVTZTGqo7mqDjFLWAHs0xNaHbKE5JzcqoplXP8Aqq8ZfyRLmHgBuOAADifi/HkUNRynoIGRTdPO5/v2KasqOjxOLSkXrcsJHpwT0ZMBOlcF7qizaXJjY1cJFiRu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877055; c=relaxed/simple;
	bh=x0lgLA6A19D+Oebk0WCbYIqHU4trjlPkwAzhAsc3Cr8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l7fOFU+2L24Tfgkf5wqNKwEPWkpplej9kYY0B5/0HiqB3K9ZFbPiVIMnwFfn1Hpvqvd63Lc9ailpKiKoyy/07/iThvCjlC7qP2cLIL0Z6V70+YTHQAU3gjWHGI/ANugrt9hCUXvs4wVO2XJswgr3ScP0FglH3x1htdcGwMD0d28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nYk1dtS+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yE1tVfCipwMIdxQLWtqbex4vaMdnsHrwMZOheMGRClw=;
	t=1767877054; x=1769086654; b=nYk1dtS+m2Cy5/dSHMLsjZZMCaBqlfXyjZLOdLO8CooBPqN
	R70MOmj5meYPgHYWFjxlf3mbEE1UMfP7Vqz+kmusGkaa/zL3nIsUXcpiMaWN+ghOb89JYCpnhWIsf
	SwoNOcZAtaYNRXwGsVzXKiVbnZjEm7hJCzKf8cqFySYQm9Wablg/H/+PyfLXiPmRHcNUVzGSArTKS
	LhofCoxrpNhWpcjN4DoVa2Go9Q6/wc9NkjaKFBvntd+jCxN9cO9ZMC+hj+2vsRphHgrAwEMRc3J5T
	FtKh2TiPTVT52BKhpVutHhr0ICqin7WjsIYD9XWNlbzC9HuyPWFHBbKSBxrcTHJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdpZz-00000006VcW-3OVK;
	Thu, 08 Jan 2026 13:57:32 +0100
Message-ID: <838a14637a5c134761ae75b600008396333ae95a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: wlcore: allocated packets tracking mechanism
 may get broken
From: Johannes Berg <johannes@sipsolutions.net>
To: Peter =?ISO-8859-1?Q?=C5strand?= <astrand@lysator.liu.se>, 
	linux-wireless@vger.kernel.org
Date: Thu, 08 Jan 2026 13:57:31 +0100
In-Reply-To: <476e02ce-4592-b08a-fcc9-c1b151500bb9@lysator.liu.se> (sfid-20251228_170449_364924_53B203D7)
References: <476e02ce-4592-b08a-fcc9-c1b151500bb9@lysator.liu.se>
	 (sfid-20251228_170449_364924_53B203D7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-12-28 at 16:54 +0100, Peter =C3=85strand wrote:
> According to=20
> https://git.ti.com/cgit/wilink8-wlan/build-utilites/commit/?h=3Dr8.9&id=
=3Da2ee50aa5190ed3b334373d6cd09b1bff56ffcf7=20
> the patch below should be used with firmware 8.9.1.0.2 . Does it make=20
> sense to include this in upstream kernel? I cannot really say if it=20
> improves stability or not: I don't have the possibility to run WFA test=
=20
> 5.2.27, and I am still seing issues with firmware 8.9.1.0.2 and 6.6 kerne=
l=20
> (with all 80211 fixes). Testing of this patch with older wl18xx firmware=
=20
> is ongoing.=20
>=20
>=20
> From ac0695f9bf6810ae91cd0e441199102f0c16e507 Mon Sep 17 00:00:00 2001
> From: Itzhak <shlomii@ti.com>
> Date: Thu, 28 Dec 2023 08:47:58 +0200
> Subject: [PATCH 25/27] allocated packets tracking mechanism may get broke=
n
>=20
>  It is observed that at some scenarios, the best effort queue
>  that should always show positive or 0 count, may show negative. This cau=
se
>  the best effort queue to look full to the network stack and thus causing=
 the
>  network stack to push less packets than to other QoS queues. It would ca=
use
>  specific WFA tests like 5.2.27 to fail.

[snip]

It seems to me that we probably wouldn't _intentionally_ transmit frames
with a mismatched AC/TID mapping, so is the patch just being lazy to
overwrite it rather than figure out why it happened?

Maybe it can happen in some AP forwarding scenarios? But 5.x are
generally STAUT tests ... not that I know what specific test plan this
even was referring to.

johannes

