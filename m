Return-Path: <linux-wireless+bounces-24434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0798AE69C4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 16:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F53B7092
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3F2E1728;
	Tue, 24 Jun 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QCu9oZNH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F72E1727;
	Tue, 24 Jun 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776175; cv=none; b=cHymALBwFFVPWahvvtQMnezgG7FN2CkzU7AWOJHc6JHFwO8K8Zwc4mnDC0qrAcwsCF84fOIDZOO2syUzFLqJUW3ACFoZ/Ehi7u9rhYzgrAN/eJhFP5uxFJ2x2KQBiNbO/pNo0yo3Qcok91jWLqbE6gyQnrlme0ILPdKroqMZo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776175; c=relaxed/simple;
	bh=+zL4QC+9cHA0s9cjJlJPly78N3xttvgurNiByN0DCFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjtJVEXeAeDZt/8Ee45jRZbfhz8w4A3bZXUvevuHEcL4n8ZESuzPdAK9Qpl4ELXL9BqBeAHLU8K2hLUPmAf4tePz66Dzd7DeAKnQpDPUBkndviZqlbPpNkXc5ucAPUd+KdIZgT8Tfg1D7kIsP7f4VEun//d8UiHSlNHjSewNI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QCu9oZNH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ap+T4uXmGhGheaBLvwseZjUACeA/69c61bTMLd1PY1E=;
	t=1750776173; x=1751985773; b=QCu9oZNHf/2Lem8o55nsFPcr0JzHPiVJ7AhOovTWvuyMS1k
	/6n6HNkQM5cwNRhW9DBk00n75jDUPk0IMFXAulHUhYJQyvGhd1RaAud5bxyhUgol6qjCt5opW5cBP
	QfCHERC6ajqE3+gOVy0I1snkWntvVde0uafErDEodquK8UBBjt2ji5CGAdxtjlw95O2wY6riOS6tf
	VZxTKs8cIKf/gaT0ijxIUPwrMVImz7svcC62eUGrYrTJHlSlHQ8avlSrWCb55WDE1DD7FEd3tIBNA
	g1oSC9RJaE8pmQNyyanyjmKihdA8N1i/vqjikz2UHumnfdtljSP1PfLHXhAVsoIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU4rK-00000008uQv-0voQ;
	Tue, 24 Jun 2025 16:42:50 +0200
Message-ID: <a0eefe910c3216594ea145465bb8a68a4b0d9990.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Add limit to ignore NSS change warning
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Jun 2025 16:42:49 +0200
In-Reply-To: <20250529070922.3467-1-pmenzel@molgen.mpg.de>
References: <20250529070922.3467-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-29 at 09:09 +0200, Paul Menzel wrote:
> Currently, Linux warns as below:
>=20
>     Ignoring NSS change in VHT Operating Mode Notification from cc:d4:2e:=
bb:59:f4 with invalid nss 4
>=20

I think we should make it a debug message as well, that's a really
pointless thing to bother users with.

Want to make that change too?

johannes

