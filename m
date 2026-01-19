Return-Path: <linux-wireless+bounces-30956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD0D3AA3E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB7830206B2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B6368297;
	Mon, 19 Jan 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ptCNLG6J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D336827A;
	Mon, 19 Jan 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828823; cv=none; b=Sg/2eLLJS9BUbbRZ2NXoFm3yPa6HDvGWRdpg29srqrPAMEN0g3KUWc+WoLX68BdvYt9ckglroJyQXRmacLTumZJUEkFgm1f8bgmsyOkEA6541sXML551dNyNMYIlTxwfY8WtNbyMavHibADV01osKb4OPkJRqyQXlgxacp6NceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828823; c=relaxed/simple;
	bh=s5e0p4nCv/nBDLJ9B7SVKecgQoAyL1I7YQZxUfjK+5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mdXH5kRehdZl/HNcJR4956j2p321jhj3RBqahHm8cLNj0u1bo9+bxkHzqyFPCJr8WP8MoXi9dNbggD/EDfwRoPWsBT9vb/oV13n6Z3DgL7AEz49ZEF7iYmJgjGrkgo2Q4QnLXATpJrxXQ9OR/j6GxSI9jWW3LdpCK3dZS7YdGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ptCNLG6J; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SYvCzErYi5dY3mg5fNIvIMcAZARSpOQ9PGhUCQ3fGbU=;
	t=1768828822; x=1770038422; b=ptCNLG6JqcHrOEVX8lMrb3VqMP67+dhKRI+GHERjmD5KzHv
	llDTT4cOSG8ZYvSe9l0sfJfGfnvDHmjhqgUPlivYU8wXVzfGSMGrpxK4+nHQhxl6P5+OxICHVEUFQ
	MH8xR/RHDoTkVn/hcfDmPHwGraYqi8RdbWzQhHfh4APpW67d00S/ZgvvjX5lsUqFicBj9pfelx7hj
	wsp8AelVXkk5luqLtj102qjPmtpBkSNRBbLRhS0nIh9SfBSQ76RTKwI2hsXCi2pACJwI/gy44ly/T
	+XRv38XL9SrzbjegAK1wtnOF81ofQXrxCdIecesYIBpFyBValb80GO+zybcqQBTQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vhpB5-0000000Fwds-1x8g;
	Mon, 19 Jan 2026 14:20:19 +0100
Message-ID: <7d2a4fa708a6681fb5c17ae8420ccf762b3e83bb.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Fix WARNING in drv_get_tsf debugfs access
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+15f88dfa580000@syzkaller.appspotmail.com, Arnav Rawat
	 <arnavrawat2000@gmail.com>
Date: Mon, 19 Jan 2026 14:20:18 +0100
In-Reply-To: <20260118213328.74309-1-kapoorarnav43@gmail.com> (sfid-20260118_223538_198382_44DD933E)
References: <20260118213328.74309-1-kapoorarnav43@gmail.com>
	 (sfid-20260118_223538_198382_44DD933E)
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

On Mon, 2026-01-19 at 03:03 +0530, Arnav Kapoor wrote:
> The debugfs tsf read function was calling drv_get_tsf() even when the
> interface was not registered with the driver, causing a WARN_ON to be
> triggered. This is inappropriate for debugfs access.
>=20
> Fix this by checking the IEEE80211_SDATA_IN_DRIVER flag in the debugfs
> read function and returning -1ULL directly when the interface is not
> in the driver, avoiding the warning.
>=20
> Reported-by: syzbot+15f88dfa580000@syzkaller.appspotmail.com
> Signed-off-by: Arnav Rawat <arnavrawat2000@gmail.com>
> ---
>  net/mac80211/debugfs_netdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.=
c
> index 30a5a978a..669e7c519 100644
> --- a/net/mac80211/debugfs_netdev.c
> +++ b/net/mac80211/debugfs_netdev.c
> @@ -656,7 +656,10 @@ static ssize_t ieee80211_if_fmt_tsf(
>  	struct ieee80211_local *local =3D sdata->local;
>  	u64 tsf;
> =20
> -	tsf =3D drv_get_tsf(local, (struct ieee80211_sub_if_data *)sdata);
> +	if (!(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
> +		tsf =3D -1ULL;
> +	else
> +		tsf =3D drv_get_tsf(local, (struct ieee80211_sub_if_data *)sdata);


Seems like we could get rid of the pointless cast, while changing it
anyway.

Also seems we should do it for all the debugfs files?

johannes

