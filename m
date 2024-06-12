Return-Path: <linux-wireless+bounces-8843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CAD904E63
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B20C1F2865E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3E16D33D;
	Wed, 12 Jun 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pGm7crk7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EF757F8;
	Wed, 12 Jun 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181929; cv=none; b=gX/WJ9GoG3eZYmAp2jNnMEvet0XE+QUzOq8IJbhiE19k1wspK+YC0ql2aBf++aqA6nujbpSihng8RXOFH0Wvo5KV2mbBuVl2qngZDxBLj2LfZ/M5h6mNr6erndiX2g6qO5XExW4s+ko36k3n8A+34/f90O1ZLMX+4aIw0AMcMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181929; c=relaxed/simple;
	bh=zl/ifixRjyD/Fx7yDjvmD6o75IDXwzZ1or3F9T4utao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bi9eWpP2sle+hCo7mLBRWpC/YN2SWQv3+MFznsRWoR638eLWmixK0ghfo0dOOxNeEQDSoduvu9i5GDha7JzO2+V6cJEuGp4sPf7KJ5o5Mis23/y8Xgg7iyMm7pZEqj7gOdC4bB0ogPBs7BNvGjsKfJFUs/9MSdOmlqLj7pJZYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pGm7crk7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zl/ifixRjyD/Fx7yDjvmD6o75IDXwzZ1or3F9T4utao=;
	t=1718181927; x=1719391527; b=pGm7crk73nzbGQWGeHPjhSXGLdyKHeMYZ9S4+VbRMXlpzf3
	Rbk4TuNUXFloF6aNqrlxWvxbDe1mW1Qjtxiv5RIZnuCCjzvI+jVblzR4FIAorRRlPyu9F7WhZuTUa
	z8VxHl3yr8MoMI6oFMcBBCtCgilziaHQpZBGIFgRKZYmjEFwacBObuQ6gjv2qtsbaLauv6LpSuYFi
	vwWiyBFW0tXxJyr50Tlo0YJwoDDnUVQW8hqmwh5ePZNJTsgH0BPiaHQueduIDsnEqgN3xGyTcRQzx
	jv0u3FbHozc981Tzlc0OW7qu6GDBsRQk0KE+rs55pYiQDqDP+8iO/+SjRN8EGpWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHJbg-0000000A4aZ-0wVb;
	Wed, 12 Jun 2024 10:45:24 +0200
Message-ID: <9e0a886ea6830f5fa230a8377952335b1fd2da56.camel@sipsolutions.net>
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Thorsten Leemhuis
	 <regressions@leemhuis.info>, Savyasaachi Vanga <savyasaachiv@gmail.com>, 
 Christian Heusel <christian@heusel.eu>
Cc: Kalle Valo <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>
Date: Wed, 12 Jun 2024 10:45:23 +0200
In-Reply-To: <3dd46abad6f8485fa74d36278dda46ac@realtek.com>
References: 
	<chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
	 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
	 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
	 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
	 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
	 <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
	 <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
	 <7869b9b29b6796c95fd5af649e4bd6696e56dcaf.camel@sipsolutions.net>
	 <3dd46abad6f8485fa74d36278dda46ac@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-12 at 08:43 +0000, Ping-Ke Shih wrote:
>=20
> Tested on 6.9.2 with RTL8822CE.
>=20
> Before this patch, it can capture packets but always stays on channel 1.
> With this patch, I switch channel 1 --> 36 --> 149 --> 11.
> All are expected.=20
>=20

OK cool, no warnings?

johannes

