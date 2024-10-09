Return-Path: <linux-wireless+bounces-13761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9999605C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CB6283B34
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F617B505;
	Wed,  9 Oct 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L1bVGDwN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12591362;
	Wed,  9 Oct 2024 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457984; cv=none; b=pGYYL5KjxvnvSmbPq88ZwmfZ5s/nGHB4FTn9J79/ke0SnyH4exDlYxB3K5brVrp3KyqQ+JxbjxAWSylISPQz1MdpsR8HtFm3LwwOxkCEpm5f6mKg95NWXEJeBNnU+iMoo+2uc8FCaih2IuWxwA3rvsXcL7dI+gpvJlvXLkA2M2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457984; c=relaxed/simple;
	bh=2nyKGzQF4mYaia0WS7Km+i4Jd3onZa4pVNPu4rVadA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppg6SXVNFGWdZvjSYfYv/QeYE6lvLhIIanDbg4sWtJTZN0HehHU1nt4XUyHnvOyxg7ILc6etDl2pYIfF7Y2RmaoXEyFMFrAJEeirN8vta+86TrwVcBEXQ3ZPPMvb5/8bk/IhOKUdHePdIgSHZyNMPUHP8lWdJ53dBaA6JKQ1wgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L1bVGDwN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Dg9+MLRLpJ49M70uTdE3TkTe0Jhz9wgrn0Mgmp3zuUo=;
	t=1728457983; x=1729667583; b=L1bVGDwNlz/m8mQD3Xa5cK6zlVNV+xuM+Gflf4E+HgzOusE
	3eM4EgTogYgzjjnMUSHQLJt9ee7OPVUuYkVdkSYFz6m3jXZZaJhl02uf5G7mHT5mYUmWI6GsxC4AT
	ajJE4qMALTIUXtW3qJNzjW7KTrLs7GdQutQArp7JfG0HyGSgDnTXiYY6EHWHAQ131EVAsJekcx2qh
	y3yeeNcG6lCThqVGMRxIukw33tPAaVqXN+GyLPy8Hj5TGutqdHcjt+u9z1uLc5iAEiFjDazYoZrx9
	CGraeswOxIyBsBMCSynZsgVGk+8B7YmHo26kglAmKifGvyXY8vrHqOnDWyX70b7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syQsU-0000000513j-44uU;
	Wed, 09 Oct 2024 09:12:59 +0200
Message-ID: <f4884810ce29b945674fe90d708f44fdd9717d85.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 origin tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Wireless
	 <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	 <linux-next@vger.kernel.org>
Date: Wed, 09 Oct 2024 09:12:58 +0200
In-Reply-To: <20241009113537.4676291f@canb.auug.org.au>
References: <20241009113537.4676291f@canb.auug.org.au>
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

On Wed, 2024-10-09 at 11:35 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c

This one's weird. These can't conflict:

> between commit:
>=20
>   1842442007cd ("wifi: lib80211: Constify struct lib80211_crypto_ops")
>=20
> from the origin tree and commit:
>=20
>   02f220b52670 ("wifi: ipw2x00/lib80211: move remaining lib80211 into lib=
ipw")

because 1842442007cd is an ancestor of 02f220b52670:

$ git merge-base 1842442007cd 02f220b52670
1842442007cd...


When I tried to redo the merge I did get a conflict in this area, but
git was showed it between comments in a deleted staging file and the now
moved lib80211/libipw code.

So I think that git just got confused because I moved a file around in
the tree, and deleted another copy of the same file in staging.

Anyway ... I need to sync with Kalle, but I think I'll pull net-next
into wireless-next and that should resolve this and the other two
conflicts.

johannes


