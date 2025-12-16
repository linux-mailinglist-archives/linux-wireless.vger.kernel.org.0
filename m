Return-Path: <linux-wireless+bounces-29795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 060EFCC1D01
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C59E300F309
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB03148BB;
	Tue, 16 Dec 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VdU80iRo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE82F1FDD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877556; cv=none; b=pSwQKi94XbLYfLxI+eBN/LbvnZXr9lm6PIMAhmL2Wxpjw92ZWM0pkOb40Ckr+3MnrsFH/2v4s5bqxYKqvzi2NJUAih40OneRa9T7FsIiDkXOtDe2muWhlOl1YKIa2lEMBHZUzTXdNGUKHkif7guO467EX8rW4tIw4NWKMn0iUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877556; c=relaxed/simple;
	bh=YecxrQ/nonzJG081sHzj5C5Sc+lzmTNjyBqh7z4YCRM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ou8k/sbeaVLvMGMXHJeYa4vitSZuZAF5ARfgcWIXR7/HyL+FjayKdhL2bVH7VjfFGaQoMt+hgMfqj3jQHzZeDafB+LSk8VnkRCWHQzZcKqKUR0EbJr7zNB4iGgFTCHHHUpdr/zxJUhILtwy9NCzP0yzpapfHeSrpju2gCzrpZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VdU80iRo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cRYw3mypmVvhdkMLh1V3Wf51QswQPLV2wGAKbQaHOfE=;
	t=1765877554; x=1767087154; b=VdU80iRoNqSIkwuIkPwrCeTI//NY6b6aZBDfJ4Zca7+9CDC
	urwHUK2ks5wDcJ6C8/KssYMw87nXb9yHa7QOeW9DvAuUDEa9WEBQfK2Qb3im/qjooBPomYLfHNE1T
	JWx61QrNWif9uo9uhIs3nG9va593+PoP5d0NfMsmM8ubKhjXaHuHQ7lZtyQBdLzfD1M/rW09wB/VN
	GZrSUnCevfQlR0TNF76+54SGgeFZ3cGiFxi7BsNGJWLpbg6ODJb9FhetFqyiFzXNiV0P/8a/Xn76p
	nqyivKPLsoWOhg1fbQ4HtZRqlpSTpw7wUnn/cELsrNDUUBPSkfIwZ6/U+pUEetyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVRPz-0000000AFb5-2QSF;
	Tue, 16 Dec 2025 10:32:31 +0100
Message-ID: <da89d1394d19915a389f19f8773a028956562a6c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless 1/1] wifi: mac80211: do not use old MBSSID
 elements
From: Johannes Berg <johannes@sipsolutions.net>
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 16 Dec 2025 10:32:30 +0100
In-Reply-To: <20251215174656.2866319-2-aloka.dixit@oss.qualcomm.com>
References: <20251215174656.2866319-1-aloka.dixit@oss.qualcomm.com>
	 <20251215174656.2866319-2-aloka.dixit@oss.qualcomm.com>
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

On Mon, 2025-12-15 at 09:46 -0800, Aloka Dixit wrote:
>=20
> Fixes: 2b3171c6fe0a ("mac80211: MBSSID beacon handling in AP...")

I'll fix this, but please just literally copy the subject.

I have an alias:

$ git fixes 2b3171c6fe0a
Fixes: 2b3171c6fe0a ("mac80211: MBSSID beacon handling in AP mode")

$ cat ~/.gitconfig
...
[core]
	abbrev =3D 12
[pretty]
	fixes =3D Fixes: %h (\"%s\")
[alias]
	fixes =3D show -q --format=3Dfixes
...


johannes

