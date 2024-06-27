Return-Path: <linux-wireless+bounces-9655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E791A505
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080E41C21075
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317411459E9;
	Thu, 27 Jun 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KPDbXbgP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CA13C9CA
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487439; cv=none; b=XLaDHRrRKunIa+oZLYgQCP8dOhFvNeAeFRG7ZbtyKUqMMyCGY9rf+WnhVSSsMelQT61VbOVnB3cjchFGYQbo4EOJyu8WsIydLgG2avz3gq/B0rbFskVSJBoPoysjkkk45XTAJe9MRA0g8woV2WYAcLmFgyAIP1YLcXLpZPSYSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487439; c=relaxed/simple;
	bh=hqmj691aF3toK7LWzvWlvnCTd/lK2jd276atWcg6eOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmZyZ/Gn66lzHh+S4lxjN18ol6Vrb+stGzKarNsn1tsNFi9v3ijh5fGu5KpzFLJCDJGV28Lmgn5ijV01ZpLwXcrsIoyD5k8SpgE3zdzrycxrxD6VItcHHTSXYjGIuzkgoJxOV7ZZ8qNP99QjfFrjynzIIAiNfH7OsZfsUAPPpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KPDbXbgP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FGqOcVnVMZiLcIfYCfw7EUmLYVM8BTfq4Uhdu8APVJg=;
	t=1719487436; x=1720697036; b=KPDbXbgPQUFS6tSNnKBMRHMxnV+ykboBMzXhMRcqvUMVS4s
	Y9bJEV255SbtckguzBvFoqvyQV/wcaswa3BshhiJILrQvO64PITv4sNU4VIFoe78+nm2ggVR84baF
	nKdnlnss84UhXRdjGc8jDx+/nmqUTb8wNrUTY+HYnbkXJeu79cbIO59q19YrJ/WEg+6p0K9q48SQ9
	WffBDOpWf+2J46jIcEhsRtmhZSuNklzdgnx4U2VGqCjH5jVCetBlR8d0OfPxzztID1px3AOHj7INH
	NBJeVfyUlC9PLDZL4PyVlvQXJPSuQ+/DCgQbeu1pjGVvIpKZ2ng0Dnd9o3qLtHEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMnEH-00000006xrT-15B2;
	Thu, 27 Jun 2024 13:23:53 +0200
Message-ID: <465aafdc7bdcc61177f28c83f3c87c2f8560e03c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP
From: Johannes Berg <johannes@sipsolutions.net>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-wireless@vger.kernel.org, Miriam Rachel Korenblit
	 <miriam.rachel.korenblit@intel.com>
Date: Thu, 27 Jun 2024 13:23:52 +0200
In-Reply-To: <CAOiHx=kKuGWhEQrtRXx5HJqR46D8o34ug8iXrc0nBkCFiZzjPw@mail.gmail.com>
References: 
	<20240627103936.4a7cd28f3136.I328a219e45f2e2724cd52e75bb9feee3bf21a463@changeid>
	 <CAOiHx=kKuGWhEQrtRXx5HJqR46D8o34ug8iXrc0nBkCFiZzjPw@mail.gmail.com>
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

On Thu, 2024-06-27 at 12:47 +0200, Jonas Gorski wrote:
>=20
> > +++ b/net/mac80211/mlme.c
> > @@ -3521,6 +3521,10 @@ static void ieee80211_set_disassoc(struct ieee80=
211_sub_if_data *sdata,
> >         u64 changed =3D 0;
> >         struct ieee80211_prep_tx_info info =3D {
> >                 .subtype =3D stype,
> > +               .was_assoc =3D true,
> > +               .link_id =3D sdata->vif.active_links ?
> > +                               __ffs(sdata->vif.active_links) :
> > +                               0,
>=20
> Shouldn't the else be -1?

Hm. We didn't document whether it should be 0 or -1 for non-MLO.

Off-hand, 0 probably makes more sense, then you can use it to index the
link array etc. unconditionally.

We sometimes set it to 0 or -1 though, e.g. -1 for auth because we get
it directly from cfg80211 ...

However, drv_mgd_prepare_tx() has

	info->link_id =3D info->link_id < 0 ? 0 : info->link_id;

so in the end, it doesn't matter!

> Here it would be ffs(0) - 1, which is -1, not 0.

Indeed. I guess with the way it's handled in drv_mgd_prepare_tx() I can
just simplify the other one too.

johannes

