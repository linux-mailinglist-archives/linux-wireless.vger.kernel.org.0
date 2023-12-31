Return-Path: <linux-wireless+bounces-1368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47500820F40
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Dec 2023 22:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5A2B217FB
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Dec 2023 21:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DACBE4A;
	Sun, 31 Dec 2023 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rxb2vF7d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EBBE48
	for <linux-wireless@vger.kernel.org>; Sun, 31 Dec 2023 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=++BMyKKF3C8qfc7IrsUNPQRSdNbXkOij3kD+cUpCbJY=;
	t=1704059967; x=1705269567; b=rxb2vF7dzhGK+Yj0K/R9u1RkMKGT1DjPoxSJBWwERG+7rw5
	Saw64OUkfxamLasIXPzc3+kP8PpuNIltP4xyzURUGyycG3eL9++vRAS6P/lTJ3QVrSuCvnsvXQNTr
	BFmGejxy6F7cfWQFeEul8oxFyEOVoMOapUyRIVOSjCMhoMNuoH4aNg3fj1FTJsoOBYhh+l0R4mTMO
	VXpEc7ctY7z3tCRkheKMddCkjX9pQBnRiGG8IyV9MQbf4uUy0E/iHJIA4+v1sXVlODHv4S3orogpY
	Am3x9WpbSA2mGi9vxPasnFJX9Fbtevj/CbTyWn17khjzOMXMfeA9MiTQ/EY+b3ig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rK3q1-0000000Gkc8-1riU;
	Sun, 31 Dec 2023 22:59:17 +0100
Message-ID: <6a54a2afd9e2b1b67822e3ca9b86654e3886feef.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: strip NLA_FLAGS from printed bands
From: Johannes Berg <johannes@sipsolutions.net>
To: Matthias May <Matthias.May@westermo.com>, 
	"linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Zefir Kurtisi <Zefir.Kurtisi@westermo.com>
Date: Sun, 31 Dec 2023 22:59:16 +0100
In-Reply-To: <20231221222842.1310957-1-matthias.may@westermo.com>
References: <20231221222842.1310957-1-matthias.may@westermo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-12-21 at 22:29 +0000, Matthias May wrote:
> nl_band->nla_type might have NLA_F_NESTED (0x8000) set,

I'm curious - how does that happen?

Not that the change looks wrong per se, but ... I don't think this can
happen?

johannes


