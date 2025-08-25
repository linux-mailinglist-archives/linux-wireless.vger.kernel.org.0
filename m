Return-Path: <linux-wireless+bounces-26579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1FB33890
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 10:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF433ACD4B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5533985;
	Mon, 25 Aug 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VfqVeWxe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5931FB3;
	Mon, 25 Aug 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109855; cv=none; b=f81ckliawl1FheoevfsoUWopI1zmfQVz7lEkS4eaKQIUK67qdYqsSiTDbEf+G4CXai8fS54YuHmZk6ZcDbzUBH4Muc6Ynx1HgawswqXYmuD9DG8nmU3YPyqjQV6u47NdjK6DjlobZzIlrSX+AGbukGZ/1Ghxy2JUKUv5Zo/5vfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109855; c=relaxed/simple;
	bh=hIW8XQU7RMPPW8XOZu7gtjXi/XwCLs4jNR5j1dUryRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LN60A5qfJiGPbJzAmawI+GK3Hkg4+s27kNhkZ3wRqfQAXcqYXahhJXW54Ut+P1QFvAZVJKHLiee3sj7NwBoGaKE5aiWt+sE8gc9N5NSW+Q0lgaNWX+FD5y7say5ybyrdcXMmhqIeVSCMx/qwdlLffYKqzhhZDAk8E80p3KTeq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VfqVeWxe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hIW8XQU7RMPPW8XOZu7gtjXi/XwCLs4jNR5j1dUryRA=;
	t=1756109854; x=1757319454; b=VfqVeWxe2hOrzSUriVrsNFJ6YVz74LrorjzHUmbkT3HpC4i
	+jnjX4jSqzeSRDWGPCVjIlrxDmgmZGCIm5+j8t3QKIFLzJWIiHCsyEwvLp4GzsaEdl19wKOlTmesX
	+LYrmRZbXpDlqv2UVo5/+S9Bl0ptsekY7H7vYEaKtp/LHZV47bNLVbmZdtsN1pwy0V9k64ejUuwA9
	pTK6ciDkhzrIyGxOQTFKm72fPU1ZiIo43kG0OzNr7wm4107Mm3EWlNjHdsOcRiTnExRcyzBUYxltR
	/QHdnDZs1Ww0KRIBCSz23UMJ1H2h6Qk4cAX5ULFq5Us0wl9tpvuxSHWfJvpjCvqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqRhk-00000001ZI0-2TX8;
	Mon, 25 Aug 2025 09:33:25 +0200
Message-ID: <da586793e06d68e51af8f691e9aac82441d3808b.camel@sipsolutions.net>
Subject: Re: [PATCH v1] wifi: wext: propagate metadata on -E2BIG for GET
 ioctls
From: Johannes Berg <johannes@sipsolutions.net>
To: Callan Huang <luvings@qq.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2025 09:33:22 +0200
In-Reply-To: <tencent_FE21EA217C7FF6B3CEAB5749F98F0267EC0A@qq.com>
References: <tencent_FE21EA217C7FF6B3CEAB5749F98F0267EC0A@qq.com>
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

On Thu, 2025-08-07 at 21:10 +0800, Callan Huang wrote:
> When GET ioctls encounter insufficient buffer (-E2BIG),
> preserve u.data.length metadata in iwreq structure for size detection
>=20
> Typical usage in userspace tools like 'iwlist wlan0 scanning':
> - Detect required buffer size via u.data.length
> - Implement retry logic with proper allocation

If you'd sent this patch 15 years ago I probably would've taken it, but
honestly, at this point ... no. Just use nl80211, or large buffers in
the userspace to start with. There's a very small buffer limit _anyway_,
so that getting the full scan list in busy environments is actually
impossible with wext.

johannes

