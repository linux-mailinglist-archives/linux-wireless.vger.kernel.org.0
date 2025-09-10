Return-Path: <linux-wireless+bounces-27206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629C3B511BE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E34018924D4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF12D6410;
	Wed, 10 Sep 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u0Zt6uPY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19930EF70
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493956; cv=none; b=BBWRTE1XLpidgTLcGbvsWwPzbLU0ROBQ36HfhUkBpeKA/jxc+41DpuWHKkR5ZMi3eYWIrhqAoNnOzIvrt3W9XpZ/IbS03NFjV5Tu89eH6RjGxhDhKO0OCVGsrq+b61qIiGmjAXhucjRsfbvAjWSvKG9g0sEw2KbrEsbUd1S9SV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493956; c=relaxed/simple;
	bh=N1Q0rHcHl6zgCdnXKYuGNKWHjp3TObkpumJ9AjaK6CE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhELwUSj2MGcfcZOGw1RvU5dTSAMj8qwVxpu+eWUC2CRML6LCGJb+Il2QdaaiV9vMPOUaLyey13J2LyXl+8Da8Askm1P34D55HLnMsjRHfJ2LLjR4btomNp1FQn8e4mD1e7jyQ+zYFGz1hjaPuVfVOvZJV5c485NcYaMZz1QVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u0Zt6uPY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RH19LUoB5hbGmd7WhzZYoOz64RZW8/BCnaKXOHuO0FM=;
	t=1757493955; x=1758703555; b=u0Zt6uPYzTGcslgGgunBucwwuB2FrgFHoHvUTiWv4I9MDDG
	23FOd79ir3k/Qhj/ZwsKJ6kamhs1hRbQj3QjpVLZ8c8znZuL0Qi0Sl44ZovlereS9IvNIADMFWAYS
	SJ09E3dgKlo5Zg2CWD8+3VlvxcV2AsYNhbz4d8F9qRWbH4pPDlLpqOS1K2QISbq3Zx6oC80H3It64
	AfwQPnbQ0OqAI9rtOjIrgmvGNoT8Cr/AFREOzFn4XhfVtfy9WRB399G0SM5t2EhvgIITOJ14gA5rp
	4Mihbcsl+tJvXC2Vz2yhCPH9zW5KVOIoS7a/WV7SehTrSwit9kJbVkI2+vxXpsiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwGSd-0000000CUJY-0zF0;
	Wed, 10 Sep 2025 10:45:51 +0200
Message-ID: <27456d3bf4d8df3d0f15c8617e2f42777b3a2255.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2] wifi: mac80211: fix reporting of all valid
 links in sta_set_sinfo()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Sep 2025 10:45:50 +0200
In-Reply-To: <d7f5ec2d5ffd5af8ddc45f419494d6abdf0f154f.camel@sipsolutions.net>
References: <20250904104054.790321-1-quic_sarishar@quicinc.com>
	 <d7f5ec2d5ffd5af8ddc45f419494d6abdf0f154f.camel@sipsolutions.net>
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

On Wed, 2025-09-10 at 10:42 +0200, Johannes Berg wrote:
> On Thu, 2025-09-04 at 16:10 +0530, Sarika Sharma wrote:
> >=20
> > +		/* currently assigning all valid links to sinfo in order
> > +		 * to iterate over all possible links
> > +		 */
> > +		sinfo->valid_links =3D sta->sta.valid_links;
> >  		ether_addr_copy(sinfo->mld_addr, sta->addr);
> >  		for_each_valid_link(sinfo, link_id) {
>=20
> To me, "currently" implies this code might change later (as in "the way
> the code is currently"), not "at this place in the code"? Maybe that's
> just my understanding of English, but anyway I've changed it to
>=20
>                 ether_addr_copy(sinfo->mld_addr, sta->addr);
> +
> +               /* assign valid links first for iteration */
> +               sinfo->valid_links =3D sta->sta.valid_links;
> +
>                 for_each_valid_link(sinfo, link_id) {
>=20
>=20
> which seemed clearer.

Actually, wait - I'll still want to reword this, but given the whole
netlink size issues etc. we don't really need this patch on wireless
anyway.

johannes

