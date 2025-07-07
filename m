Return-Path: <linux-wireless+bounces-24876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B0AFAF02
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 10:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7831C17BEBE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF7288C29;
	Mon,  7 Jul 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YKbeevqy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF325B1CB
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878542; cv=none; b=CIC7e53Ss3T//L+bIYU06CrFN0S8I2AfPXEtynzBKkQMTiyK/3ZGSeaMf6pMlLGodVEn05GsFrYgYrzXfTDNhh38UtUAAicMHLb2aXRBxXYXpXHm0aCXYwqK+eDsPtSbGD074qm2Za8gu7OXpXOBFpxoc6ZHdDpYX0mKy9SQGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878542; c=relaxed/simple;
	bh=Wyj5c/8L3QzEHmpgPbSY3u4+ebvDtsufBd+vln9tRz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKH0RS3J4pblSVhhBfu0rza69IPIsmBmQXXlkMVEoOcv3wqlrDctouUydXEUeo1CTAppH8ylECYjWpih7+l5ZE+jvbu6kJK9lLFSvudiCbJIP0ybIitSzJeg6Ste7meTkI0KogS4ebv/YgErJ9zWbttWVUrMzQh4GfkW4rKdzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YKbeevqy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wyj5c/8L3QzEHmpgPbSY3u4+ebvDtsufBd+vln9tRz0=;
	t=1751878541; x=1753088141; b=YKbeevqyORd86q6SGX66CXulO52j3xBxtqFFHXXoN1B/T4Q
	RgCE9wrpYhXSOuvWcWTx1hW6bEkXQ+FvJB7o1GhARgmoiusMI3JJwlyzf/Jci47AdKfCjlpr8Y3lY
	kRwZqJmTWuC4eST86ZbOvlUZalZMM6GJTJPxmI1M8jihtw6NzTDDCxN7qfrkA/kiV+Up9am9xfAHq
	eK28q3W6d9GQmNUa0c/pkzDzNQe2C4f3D+EqYEi6gBCHS3pvFgvCfUjhMAPYJ1XSxPi2d2AC20k5t
	10RsdEgoihSJKvOuDu83VekQ3FM2RaxzPCoSZUppDb+Yc2s+J6mSb4/bRnq/tqgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uYhd7-0000000AUMO-1HfX;
	Mon, 07 Jul 2025 10:55:17 +0200
Message-ID: <bb929464a1b4f54e00f34a2319ea383aabcdd16f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: prevent A-MSDU attacks in mesh networks
From: Johannes Berg <johannes@sipsolutions.net>
To: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date: Mon, 07 Jul 2025 10:55:08 +0200
In-Reply-To: <ae8b089d-5963-4d49-92e6-458a368dcac7@kuleuven.be>
References: <20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be>
	 <b62bf1d140eaebe6dbc75e83541fe45347c8e6bf.camel@sipsolutions.net>
	 <f7729305-1345-405b-a5f9-671213057a16@kuleuven.be>
	 <fec2006bf674b7be32e98acfccea295c581e079e.camel@sipsolutions.net>
	 <ae8b089d-5963-4d49-92e6-458a368dcac7@kuleuven.be>
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

Hi,

> Looking back at this, the added function could have indeed used extra=20
> documentation, since this is a special case. Others trying to understand=
=20
> this function will likely have the same questions otherwise. A first=20
> suggestion as a comment to add is the following:

[snip]

Thanks for that!
>=20
> It's a longer comment, but has the most important info, you can see what=
=20
> makes sense to add/remove. Let me know if you want me to resubmit a=20
> patch or whether you can include this directly.

I'll include it.

johannes

