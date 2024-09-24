Return-Path: <linux-wireless+bounces-13105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335459841CF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4F22844CA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571C59B71;
	Tue, 24 Sep 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n6dtp80q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CE839F4
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169332; cv=none; b=KJJfIxpCcSDSgOHUSyAvDZEE+Ajv+ZUS6raYq9PCyvV4lGROCknVmMgpeP/aqPrfdg2FtKsINMbzuCNZV0ERG98I8tZYpyNWdwDH6BpeqIP+1hN6MDkrh70y58yKQkzmoTTK30Weeci+jmo20AMUh0z2OuCdrXy1N6ovOZJZm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169332; c=relaxed/simple;
	bh=dLSN6aKvWEAWG/OaCv6nHLEInGFls1mSq25bVQJTH6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOuZIaZ8eO6PkxW9tVlJ7mu9uHKFowM1EodtMx5QoWIHmCiV+maidzfpLr2fhDPACYj+ddrT+9XuTRhTERi2SI/PKP+Lpgbn/ubLOQ92SOEnnFEU3M+SADRdhpJWEKa79eXkjrgm+lvfhZ0nIrVd41mWAbdH7SR0QmReottqxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n6dtp80q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dLSN6aKvWEAWG/OaCv6nHLEInGFls1mSq25bVQJTH6M=;
	t=1727169330; x=1728378930; b=n6dtp80qZTavgc/9zK9NW8fkXvZLiEwTJ+1qsM+0vO9P2xc
	zDYrk6JQ64h4No+W7GbZ93O8j/J2ioiH3bw4s5wtGxi91wVb7qqbt5bbxXOijuAvKuHFzAtXbjOVo
	vyty6rjhm4lw11ry6cf3RwdwRaOThg0U5eBcmss902iNWtxkZk8HyRQ9D7NWe4ErXBgYLTPWcHh8v
	LFiVOGUuWMc46m3n2UGRLecw3UXLwcN8r5bHk4bLRaTqKydG4nrGvckMoVZJPDiDvzTK5I7jnxohi
	2RXUHDEcDO8NCWs4Xorykpo6P68vjunLIuefuqQHDmumLclL+QQnQ0hZ2AneWj+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1st1di-0000000FyHH-2n3D;
	Tue, 24 Sep 2024 11:15:23 +0200
Message-ID: <9ba6cee6834966401f125a697308cf9faed0d078.camel@sipsolutions.net>
Subject: Re: [PATCH RFC v2 1/4] wifi: ath12k: switch to using wiphy_lock()
 and remove ar->conf_mutex
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Tue, 24 Sep 2024 11:15:21 +0200
In-Reply-To: <87o74da025.fsf@kernel.org>
References: <20240918181042.91891-1-kvalo@kernel.org>
	 <20240918181042.91891-2-kvalo@kernel.org>
	 <33ea3a62b4257b6ef789c30fa8f7bf7e9f1865b5.camel@sipsolutions.net>
	 <87o74da025.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-09-24 at 12:11 +0300, Kalle Valo wrote:
> > I don't think this is an issue here, but I'm not sure if you're aware
> > that in general, locking the wiphy mutex in some debugfs file handlers
> > can lead to deadlocks, specifically if those files are later _removed_
> > while holding the wiphy lock, as is e.g. the case for station, netdev
> > and link debugfs files. For this, we have wiphy_locked_debugfs_read()
> > and wiphy_locked_debugfs_write() [1].
> >=20
> > [1] you are not required to understand how they are implemented ;-)
>=20
> Thanks, this is good to know. I'm not that worried about that, at least
> it's not showing up in my tests, so my plan is to fix that in a separate
> patchset.

I don't think you'd ever even find that in tests, as far as I know
lockdep cannot track these dependencies, and to actually deadlock you'd
have to have the debugfs file(s) kept open by userspace while they're
removed.

In any case, just wanted to give a heads-up that this might be required
in some (future) cases, I didn't see any here where it was needed.

johannes

