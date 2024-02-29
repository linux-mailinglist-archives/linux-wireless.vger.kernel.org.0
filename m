Return-Path: <linux-wireless+bounces-4257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59586CC62
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4A01C20D07
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B0A13776F;
	Thu, 29 Feb 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aFbJz4bz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE3137762
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219307; cv=none; b=UMRY62Z/sgFDx7Z44VK4xSMuci+mePQjJjGRLKAu988kYq8G0MjrBXWJYmBDBRoOmyVoGxLzYNuM7JcyOvKO2UzLF5qLMEgCsUzIzkMFuIhk3m8hnXR+m/KKBm4CnpCSzhw7OdSlQVrZpZ4hmlIq8rr5SuBlUBwv97aT/CA5/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219307; c=relaxed/simple;
	bh=Dn8Y2E1Kimci8BsMyH73MKQB0vEtWFq6zwqrC7rvVRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acpHfkE3Zfbt9K2FTUxbZbXV2YXDChm1bfsS6ZkwuBvF+Mdgk+MceR0hCIifBBNkShP5Zc0f4lwWxb4PzZMDJ/LEEZqK6Qg2938rx58+mJWJmbr/SITKMlgAwS6rw/Qs8RVOY6Jyg94Dep3ORJGwTY7De7oFiG27Y8dfCeWN7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aFbJz4bz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8AwHBpIhsbCVDBv4ZXb4xrIi8IWIlMVmsji29a4pTG8=;
	t=1709219305; x=1710428905; b=aFbJz4bzMjBk98HXPjNGS3F5PrhCCStzpR2J4lMjnD9Jac4
	5Ad2Ps539pBqaYWJFLWpTlMDcrweXC5MMpcml/zi47opT3gJWcq+mQlHzR/c0SkgG1G+y/f+B/ucK
	1ZKsZ+jncmoG7UNinT8cyuhjkDFC4MZrt4YCfLPO8gP0yllFSceC0B7nZoVdqyNUJPWUCyusuQde1
	kV0wjI01b2CA99DhzMWjqkIEvFNT6rMopskTY05elyLwEUcbxIOgU7DQj1gxAOqzm2Jb3TrFhoTj9
	6ciNbvil7pLgqyRpEqRgwp6NS/EfEg/4U77fhf6LJNuDuwDxj75Sjy5D/Q4jCDYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfi1H-0000000Dejt-07Cu;
	Thu, 29 Feb 2024 16:08:23 +0100
Message-ID: <7e38b0496e8f2b8ef18d69e4e07db8fdc29f303b.camel@sipsolutions.net>
Subject: Re: [bug report] wifi: mac80211: clean up connection process
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 29 Feb 2024 16:08:22 +0100
In-Reply-To: <3151f5d0-c18f-413d-b34b-b94f095b947c@moroto.mountain>
References: <3151f5d0-c18f-413d-b34b-b94f095b947c@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Dan,

> net/mac80211/mlme.c:8176 ieee80211_mgd_assoc() error: uninitialized symbo=
l 'match_auth'.
> net/mac80211/mlme.c:8220 ieee80211_mgd_assoc() error: uninitialized symbo=
l 'match_auth'.

Huh, that's interesting, how did we not notice this ... I'll fix it, but
I think I'll just make the assignment unconditional and add the part of
"ifmgd->auth_data &&" to the statement, rather than having the if.

> net/mac80211/mlme.c:8177 ieee80211_mgd_assoc() error: we previously assum=
ed 'link' could be null (see line 8169)

>     8168                         link =3D sdata_dereference(sdata->link[i=
], sdata);
>     8169                         if (link)
>                                      ^^^^
> link checked for NULL

Right.


> --> 8176                         if (match_auth && i =3D=3D assoc_link_id=
)
>                                      ^^^^^^^^^^
> Potentially uninitialized
>=20
>     8177                                 assoc_data->link[i].conn =3D lin=
k->u.mgd.conn;
>                                                                     ^^^^^=
^
> Unchecked dereference.  This one is probably a false positive, but I
> just thought I would report it for completeness.

Yeah, hm. It's a bit tricky. I was going to say the link must be there,
but actually, that's not even entirely guaranteed; we could have been
doing FT-OTA without previous auth, and then the link might only be
assigned later in this code, in

        if (req->ap_mld_addr) {
                /* if there was no authentication, set up the link */
                err =3D ieee80211_vif_set_links(sdata, BIT(assoc_link_id), =
0);



So I'll add a && link there, otherwise we anyway don't have data yet and
need to use the unlimited thing.

Thanks!

johannes

