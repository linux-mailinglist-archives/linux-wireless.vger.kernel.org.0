Return-Path: <linux-wireless+bounces-20217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E43A5D7EA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A133A4709
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27A230D35;
	Wed, 12 Mar 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i5GYvv1B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B1230995;
	Wed, 12 Mar 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767101; cv=none; b=hlCoOid3ZyXq9NlZxXQEWf94XJ6en7R0Hi+rQ0Xr9JCkEBoCIicKvbBcfEv8e3XhfKm/hU+mUOqAoaS7gQqgsbSgRY52asxd4jsFK+UMwDnWh+oIMxT1nUtpIKQn0jxwW5FboSxhDZ0YCZUnb5OANX4k98iZTRzPrTg/tj5IUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767101; c=relaxed/simple;
	bh=Ma0k7ZmdEMrTDqQdTG7PSeR2KBUsNvwgPMNhn7Pwc5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/Flx6/NROJpyL23K96l341so/1mLrNCkzzL79d347CpBeuPKcfP/8XhdIPpSH8v+xe3f/wWAMIoU8Srqz+ttVVoG0ULHfXT7zuugZQ71mmKX9GpibL5tKPTDIp9GjnbiGQo/R81376GrjNZ/F5paWBG0NrVUlzU9SYN1B1izGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=i5GYvv1B; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Jnxup9TPbn5GZcpkwndZe8+eqL9QgHHpAMinkWSYk+4=;
	t=1741767099; x=1742976699; b=i5GYvv1B/RX1HKzZ225ZKKo4EeIyXYoNfb4dWF/QQCAQCWj
	qxZUhvXr+g6VU/wII4wp/aJxKJJaedswH26A+RJia4TIVvxtBpMKKIRtAWU2YJVelbm82hURIY0jo
	xrh8bq+95PNvxK8r33DyKjFUDm1LlJpn5AcZsQTPOuYXxrEYFmwhxwqXEgghQPvyOBGEAxr6v2gdh
	4APaNEg3rEfY8+r89yynXsMk01/zJtGu1s0uOjXg1GbcdwfgPlqOnPo3rI8zKSZffoxXw64zT0+vu
	pPKfeFmNZn3O0pTj3WgJ5JtoCgAZMWVRDYNMTHhpWHbPAe1yfUq2egIonciJTVkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tsHBf-00000008nK8-1FoJ;
	Wed, 12 Mar 2025 09:11:35 +0100
Message-ID: <529ce0c963118af305287c6c28bf146f62af5366.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 and the wireless trees
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List	
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List	
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Date: Wed, 12 Mar 2025 09:11:33 +0100
In-Reply-To: <20250312135306.2cd270b3@canb.auug.org.au>
References: <20250312135306.2cd270b3@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   net/wireless/nl80211.c
>=20
> between commits:
>=20
>   1f860eb4cdda ("wifi: nl80211: disable multi-link reconfiguration")
>=20
> from Linus' tree and
>=20
>   2e85829ac7fb ("wifi: nl80211: fix assoc link handling")
>=20
> from the wireless tree and commits:
>=20
>   a096a8602f4f ("wifi: cfg80211: move link reconfig parameters into a str=
uct")
>   969241371f06 ("wifi: cfg80211: allow setting extended MLD capa/ops")
>=20
> from the wireless-next tree.

Thanks for the heads-up, I'll see how we can deal with it best.

> I fixed it up (see below and I used the latter for the later hunk)

That looks good, thanks.


Unrelated to this, but I see you've CC'ed Kalle. He no longer maintains
wireless, so if you have some list of people for trees or so you should
probably remove him.

Thanks,
johannes

