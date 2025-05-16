Return-Path: <linux-wireless+bounces-23079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A38AB9E09
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA744E297B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E32132111;
	Fri, 16 May 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="prNvNtn8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB978F5E;
	Fri, 16 May 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403775; cv=none; b=Ldjhg9i8nv/iAXR80yz5057yA0q4LKHPQu94e/ki6FD2IjDpgwc6KmYBCMjcf1Rdn2U5vqgTL0kOyKU7+ojUDupJw6Zmp7JdbPBojmHn2FP6YOMplwsgdvjNxMht+/n9p9+gzEOP54y81Kka2cYfrRuDnd/rbipb1v1C/9Nl9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403775; c=relaxed/simple;
	bh=RcvThd/w/vxl6XWWU8Y+ukSVSVXtWFY8ae5nUArXFOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXUaeoYQPKDZ8eUCLZttg6QIpN1KmLO5TjkYbbopM9Hsd+p8PeGw8qwQ3rohmLNitXfrwE2SRHZDc3cJOVZvXZuAbv7cyVKxpuR4n7l/BBgd6iHXzj8+t5C8Q1TzwgoyqGK2EHzBNo3s2KZmj5Tzfxs9BfRIf2t2fuKuzdpvroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=prNvNtn8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qU1qVMNi0qMy5Blos1rCviLL0yU0/cw8rCcjhi3fPbg=;
	t=1747403773; x=1748613373; b=prNvNtn8nGnOwHRtCAzVlfQF/cgv98PiAMlwP3WK5meqjge
	SuavXx/e8VXTkdA7tGiuxPtCj6pK8hX1BGosx5r4wGn/iek7yxjcY78eisu3PXv2379DDtXbjR+hS
	pdpdOZHjoxAieaatPRrSc4NCGY3F8DRq4TkMhScoc9CtWowihnB/muGR7s0Si4pTaG08GshVzZ8HJ
	f5QPJ1MqGS8BiIMY/FiSVTG+Wl5JRJ+q8gn56RculpXnxmKRz+8n/RT2+hb+X1U5Bj+HqlDCXn+NQ
	rPRg4TgEtOKFV9OMUmcyVzdbXR5mrZ/jCGVPrSRA5v6X/wUs8qEs8vmDviOg9UTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFvXj-0000000EqOS-3pVe;
	Fri, 16 May 2025 15:56:08 +0200
Message-ID: <ab918cc3d5e26a6c38b3331172b60b6676bc32c5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, vulab@iscas.ac.cn, 
	linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date: Fri, 16 May 2025 15:56:07 +0200
In-Reply-To: <22ba7622-a838-47a8-b0f8-29a90d6df34c@web.de>
References: <20250516083842.903-1-vulab@iscas.ac.cn>
	 <22ba7622-a838-47a8-b0f8-29a90d6df34c@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-16 at 15:50 +0200, Markus Elfring wrote:
> =E2=80=A6
> > Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
> > log an error message via dev_err().
>=20
> Please avoid duplicate exception handling code.
> Can another jump target become nicer for this purpose?
>=20

<form letter>
(stolen from Greg)

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.


