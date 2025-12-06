Return-Path: <linux-wireless+bounces-29557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B4CAA8B6
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6168630575A8
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D370261B6D;
	Sat,  6 Dec 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AuFF85v/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC822A7E4;
	Sat,  6 Dec 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765032948; cv=none; b=ZXYbZ/RztKXjRrsPP7UiPJwfRdQeVIx41v9piq51bEnnem180juBbUC6vz/+58Zp4CinbkSEGsUzicYFZcK8vq0ej2nTZKva3cs3sqK+nHoUyvsXr6ALRL8hXXNdtBpktqh1BRTulIs/ZBIMvLx73PlQDl50tHoEmDITaosS02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765032948; c=relaxed/simple;
	bh=lnrI9FwDsoG6g+BjjUPB5AIspT3lty4yaQxZYRaEsBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M/s+3bA6jHY/laBhGfLa/MGdS86DTczCvJI2AXrjrJM8pm2xbVeYEhv8QXTWXpVzT7xkRAM0zDcnT1ntVpJcVFGc82KjoNYI+o5XHQNcCfJy6zpmEWoZhaApo5jpTV7dpwfVGGNBkEgPVlBX6/06uLzjbgWSf08Xbw75lD8lyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AuFF85v/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0kAXJZEewlerPHknWg4+2tgbiuI3s3sxNcCervQa4AE=;
	t=1765032946; x=1766242546; b=AuFF85v/yGTlkZPqM8vlZchHVVit2YwOfT/dFvqm8kavH6e
	8LHfUsuUa6sc2D0YXZGVnymn70s44ESzuqIO4i8nbryEMzNyhdxJHC3J44UlXujN7SHSTm7mvVMf7
	ro39jO7kw05UoWYs3EHQZ9QgnwE7jy2bYlYj9M76PnkkbQM8V2dSWiva0fCIKi2nyHqtPV83vFLCR
	s9jmZaGu4bmXYt44m5GgTgysPlP/NnL7/pCHVwAfidlMujw1z9B4s1cgKZxu8o9rT8JHT9bgNnwn3
	/7Jt5q3yaz3b2wDLx1XfXztGDy2xT6TogZ4vDw/VKjP6yT3q1D2+l21oG4Bor9Fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vRthC-0000000B0V3-1s7p;
	Sat, 06 Dec 2025 15:55:38 +0100
Message-ID: <e883efe1f9e4bccb144400b82a35110c79451b37.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 6.18-6.12] wifi: cfg80211: stop radar detection
 in cfg80211_leave()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, 
	stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Sat, 06 Dec 2025 15:55:37 +0100
In-Reply-To: <20251206140252.645973-26-sashal@kernel.org>
References: <20251206140252.645973-1-sashal@kernel.org>
	 <20251206140252.645973-26-sashal@kernel.org>
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

On Sat, 2025-12-06 at 09:02 -0500, Sasha Levin wrote:
>=20
> ### Conclusion
>=20
> This commit fixes a legitimate bug but does **not** meet stable kernel
> criteria:
> - The maintainer did not request stable backporting
> - The affected code only exists in kernel 6.12+, making it only relevant
>   to the most recent stable branch if any
> - The bug severity (warnings, not crashes/corruption/security) does not
>   warrant the backporting effort
> - It cannot be cleanly applied to most stable trees due to structural
>   code differences
>=20
> **NO**

:)

To be fair, it's kind of a corner case that happened mostly during tests
as far as I know, when two mesh peers getting radar detection happen to
pick two incompatible channels and then give up, causing wpa_s to bring
down the interface.

The thing that makes this interesting is that they both detect radar at
*precisely* the same time because they're actually simulated on a single
Linux system, and our regulatory code tells each and every radio if any
of them detects radar.

Anyway, either way is reasonable, it's probably a much older issue than
6.12 (then we just shuffled things around due to MLO), but the issue
would've been around before that, and nobody really seems to have
noticed outside this specific test.

johannes

