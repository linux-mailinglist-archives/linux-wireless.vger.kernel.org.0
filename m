Return-Path: <linux-wireless+bounces-28663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA7C39BC2
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 10:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0578C4F512E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DC309F0E;
	Thu,  6 Nov 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iDJCLF5F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E1239E9E;
	Thu,  6 Nov 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419809; cv=none; b=S42LaxHKzs+Zwdtn8vGXnjtA9P1PabiHKtHYttWVHRvfBwd1fTxmuaeuKcFDlOkpK+wSqZjWsgxVY0qiVL0xhMUNxdOsmAclfQMmrg0tq7c8ijMn3ExiuhsTo9DDsiiixQeFc2ZUmP7EHpsFvKcfw20lCwkV4QAoSz3uD7ULuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419809; c=relaxed/simple;
	bh=8TG/Zo5Z+qZp4ZgF0qkXzoQPze43Wf34iuohBMVelJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5SI1mxc8X6hpfRuXjGQMJ2tCuSHZjDeio2la/7ysnnOkI1hWA98OvCyZ+JfSHdDH3w1JK6s5G8lmCzDgPVBGOG8tyVLblJxT2bQxLy4iBc9/JxWM6aNuBVUTZbw7Legk2uHk3jNlk6kW9pVAzfdi+f5CE1vb1XFUWCZPj3DViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iDJCLF5F; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AioJFUM6XWYCvmrd35iZSAYZcb4ghjnJcsep60eCEAo=;
	t=1762419807; x=1763629407; b=iDJCLF5FuP8qKTujp8CrtI2dCCMGbhVtAKbwktAi8vot4Py
	unrS5DqG8Rr1VyrTkIDAqnUvqoN0LJPsGrsyZYF8vZlzOkoXO0teZeMJsobQ/piCvE2G+BDj27ZZg
	MeDZlTOktCQQGh3efukXJan882xhi6nhYC6ljS/+4kFawdbvCaMpEHuhXUZU7qqC8KEtiGCem6EHV
	eQTOIJ4n7vXcxhvV2Z+MhA7gKSN+IoGIhzOYmT/Lm468Bqf37/Bvu/SlLYcdQkXKsf3Y7SU1HlR54
	E1a/Ly5ag4m3JURikb4tkQpo614A0soA1O7TKl+U2/Og0a8tk1ooEhQiwFCGA+Gw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGvts-0000000HJ9V-3qxl;
	Thu, 06 Nov 2025 10:03:25 +0100
Message-ID: <11cece9f7e36c12efd732baa5718239b1bf8c950.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-2025-11-05
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Thu, 06 Nov 2025 10:03:24 +0100
In-Reply-To: <20251105180852.420d2691@kernel.org>
References: <20251105152827.53254-3-johannes@sipsolutions.net>
	 <20251105180852.420d2691@kernel.org>
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

On Wed, 2025-11-05 at 18:08 -0800, Jakub Kicinski wrote:
> On Wed,  5 Nov 2025 16:27:39 +0100 Johannes Berg wrote:
> > We also have that netlink socket matching
> > issue more generally, so will have to fix that in
> > other places as well.
>=20
> FWIW we added genl_sk_priv_get() to avoid having to jump thru all=20
> the hoops when socket is destroyed.

Oh cool, I'll take a look how/if we can use it. Thanks.

Unrelated to that: I forgot to mention that there's a conflict now
between net and net-next, which had been reported before between ath and
ath-next and then wireless and wireless-next, but it's just a simple
variable addition overlap:

https://lore.kernel.org/all/20251030113037.1932c6d2@canb.auug.org.au/

johannes

