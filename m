Return-Path: <linux-wireless+bounces-15416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A106D9CFF2B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 14:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19821B22FB0
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 13:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426CE4C96;
	Sat, 16 Nov 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jLzMx8WM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A3184
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731763965; cv=none; b=ZP5uZTGTG2nJceyf2/bFQLxMzLB5D7KbzVtlXLH61a6tU56t4qEVx3xPkmbpZHlNP2JoQz7Egmh86wrc5sBDFOM/HhvM42pu3abXwcY5yi/MnKfxrU6pIhbpt0R8soROEvLgeGr5GRCqheevE/a2Lhp/5K+uBKX4bUjFKA4b4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731763965; c=relaxed/simple;
	bh=8ALgkoi9RcsRjDVsEeYKTYijptA6CODeZfsNXrOco70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjHkoazRC0rkVYiNoGFlP/qDgJmNh3KavDLyPTVZwKAL3YfRZ0zkatLb/MAAhgbmwsZwIw0GT5mwbcqHiXYPBKMvMiC+SaaZOAai2QV8WDm6pbpo1wr4fOC0ZYD1ISohtLdcBslu2pK7ylu49JF+TsKNr9AE8u6fzPI6qCRcG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jLzMx8WM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8ALgkoi9RcsRjDVsEeYKTYijptA6CODeZfsNXrOco70=;
	t=1731763963; x=1732973563; b=jLzMx8WMjXGNwJVTuqvkotP4b9d9M23CCCdE5ed6IYOuYAv
	39JU0HbSD+ROK+CMT6qtDzF6iDCyL3rSkZLkF9eE4etfEPG2ecsYji2y1Qeh5XvI6CUp/Gr+p2iSH
	wWTZB0qnf1sG10nPx947eCBUPMCJRyHowFyfPc80YdhkhhADSzY70W8Rv6/j7PNYLMsiSwBKgBnUL
	0qlEkAV3K5krODCIDe4dSS1caLcSSrjvG7AMRP5V4PxaUoe+ey9KylLGUjWQ1oC4a8ZlJ+bEXMfug
	ej5P7vwiEnrgkkn47bJNo3Inr4wYxIL3l4oV37I//uyDRlPtkl2p2ViJitlHmfMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tCIun-00000006OV0-0dg1;
	Sat, 16 Nov 2024 14:32:41 +0100
Message-ID: <dc669d8b27bd3073070b4121388d6487d5e111db.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless-regdb: assert and correct maximum bandwidth
 within frequency difference
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: wens@kernel.org, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org, combuster@gmail.com
Date: Sat, 16 Nov 2024 14:32:40 +0100
In-Reply-To: <CAHrRpukU-6MOoDsX+HRQ1XbdvoDMpUDuR4s=J-_9ODm3jreU9g@mail.gmail.com>
References: <20241116082417.8720-1-pkshih@gmail.com>
	 <ca8e16a2dbc9c38e5bf2f3e426a2132393b381be.camel@sipsolutions.net>
	 <d783a6d6a429feec6763077126e76445b6f186e2.camel@sipsolutions.net>
	 <CAHrRpukU-6MOoDsX+HRQ1XbdvoDMpUDuR4s=J-_9ODm3jreU9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-11-16 at 16:58 +0800, Ping-Ke Shih wrote:
>=20
> > Anyway this probably doesn't fix the user's problem, it just makes it
> > rejected when compiling already ;-)
>=20
> Honestly these mistakes were made by me. I should fix them.
> Since rtw89 still use wireless-regdb, I will keep updating the
> regulatory especially lack of 6GHz frequencies.
>=20

It's nice that 6 GHz is reaching more users :)

Sorry about my earlier comment, I somehow managed to misread the patch.
Of course this fixes it, and I see they already tested :)

johannes

