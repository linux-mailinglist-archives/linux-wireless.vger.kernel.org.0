Return-Path: <linux-wireless+bounces-14468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC819AE6E8
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F0A1C20E83
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199131D89F4;
	Thu, 24 Oct 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EEDjQdqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E61714B0;
	Thu, 24 Oct 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777325; cv=none; b=G/PGYt2pRuAlA5231kSAUUaixASFwkAK9uTAL6ovGmiyTP3Q9uBO1rRhQprHV77S+luoVyO9BysRK0BZRMOv4M1uIDnywaLA2Sjpfu6KZ5rz+cvUDlPkMYo2MPWCiQMlkKA1yujLCHs6Dttz7jrejFKdCj8rsqO697x6DIM6dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777325; c=relaxed/simple;
	bh=wRoXTE0Ee98MvWqMpxGj3AKyVSEVYk4dG+62Xn1HLfY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=scersAimyDck+ZDViRJPtaR0XaEF2+72yITUMB5KFz+FBFt4+fW2neCqzeoP7dy/o67F1dch+PC0hIAub4Ek4HsWx7EBA+aREc+adGoRMH04AA8Lo0D9Qj5cCJgZeaxfti/makP22mj7omX/srJglYXGIAF28M5Tv5dXEwgBSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EEDjQdqg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Chs2jCdSLxNz+q7C8Mx0XFJaKGJds4jtSZ547rcpD48=;
	t=1729777323; x=1730986923; b=EEDjQdqgcVdHJXLJ0+c2UdJYOCpoiWuVhA98IPorkVaW8jz
	xh2MfZcZvJg253xj4RmPf2t6WHOf9ZysfdvMh9nl3NFR0U4XmlCZE9e/g5yzz93No8SToyFiSxMBy
	gAU6ZLsW84R55BOJzMNOo45AR5CEFtNKqm509q1wN9LCt97rbKHz+6sXePrxeGmbi+C8Jdvp7tZrX
	s2rodQdUa7lrYQVylromXPCZooFvazM9BPEkjzvr5y3arEcTBmc3iXTtr+p10yeLye3q5qdscWfH5
	Xrr7zrIsdxfXK9wFtG6pYcslDoPzKE0Mpp47z43evQbvLoeLQpj0i33mtjF1LqbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3y6C-00000003fKe-0gkd;
	Thu, 24 Oct 2024 15:42:00 +0200
Message-ID: <8fabb6e5a2eda8c3bd7ca0bccc3e7804ad27bbad.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 24 Oct 2024 15:41:59 +0200
In-Reply-To: <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
References: 
	<20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
	 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
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


Also just realized that some of the conversions are wrong, e.g.

> @@ -7378,17 +7375,11 @@ static int nl80211_set_station(struct sk_buff *sk=
b, struct genl_info *info)
>  	if (info->attrs[NL80211_ATTR_VLAN_ID])
>  		params.vlan_id =3D nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
> =20
> -	if (info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
> -		params.listen_interval =3D
> -		     nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
> -	else
> -		params.listen_interval =3D -1;
> +	params.listen_interval =3D nla_get_u16_default(info->attrs[NL80211_ATTR=
_STA_LISTEN_INTERVAL],
> +						     -1);


this one clearly is.

So need to be more careful with that :)

But at least the spatch gives some candidates.

johannes

