Return-Path: <linux-wireless+bounces-24439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E3AE6BD7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DBE1895089
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEB30749B;
	Tue, 24 Jun 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w+FgScXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67C28BAA6
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780167; cv=none; b=jL0FGdBLb3wD181o7TPa94vDPDWZeDP3CcrZleJ6KFDLRTPxfsYOA9dKmzZ318BnQq3KoX+e39e9AwbtcInqnu47O7ZHDwC0ZWZyg/IJf/woi3yE4D3jfLO4lVdiLvETzrKMHv/ibL2LyXTaY0H+gTiuQmlmSdCikaH28q6DurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780167; c=relaxed/simple;
	bh=UxuAt+76i5ZkHQhywi0A/lhu0z8ECBO9tPle4T9UA0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvFZDcjiYspO7OcDwCKAxVXr+xoSQlPp29awvRkoLRlvPp7kKPKDcatbCSxDi4xrjObX1+DkpcuGeechzc/cEs51HrGWqsUUovYDMSPPyVDB9Gb0YcGXjpPSxYqewnbu0InzA8Kre2InB6KPv5M/YYqEftgerYsDbSSRweuFioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w+FgScXV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MDp6BvrLh1iYAbtCD969iSh5fQS/CJIVchHgSOIdlDo=;
	t=1750780166; x=1751989766; b=w+FgScXV5NgVUnCiWxVAHq2uLG0lwcARRS20jQfG4QI9icx
	0cjKQKE9V5UVF5qzNH8L27g6k+TsT8rVKS/0GPUJW6PKMborQWRpGLEmnPNDncM93rhtFzYV7jVyQ
	gIo+AlqfpPtGArtQnqQXoUp+vHzSHr3+DHyEMzYNn7ROaytzR/cg/g3a56MP9C7mv9m86D2td4+JZ
	e5ePoHo+pfs8gifMNpBdqpsG0N7074I0xrKXJ4Bj0OheocNRtMqT6JPic84+laFrGAZ7XLrCJmVkO
	Rm/TR42obMXh1DtkfvzfkutSoiPc6ZiI9zL3D1hBm6EIiV40qLbsYJE/a1hQ22SQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU5tj-00000008wws-0Vgq;
	Tue, 24 Jun 2025 17:49:23 +0200
Message-ID: <45e4d1feb87dc75dbc634c811e5553567f3aa6e8.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 2/2] wifi: mac80211: extend connection
 monitoring for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 24 Jun 2025 17:49:22 +0200
In-Reply-To: <20250609070319.1033874-3-maharaja.kennadyrajan@oss.qualcomm.com> (sfid-20250609_090419_217737_9C7B8877)
References: 
	<20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
	 <20250609070319.1033874-3-maharaja.kennadyrajan@oss.qualcomm.com>
	 (sfid-20250609_090419_217737_9C7B8877)
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

On Mon, 2025-06-09 at 12:33 +0530, Maharaja Kennadyrajan wrote:
>=20
> +static bool
> +ieee80211_is_all_links_timed_out(struct ieee80211_sub_if_data *sdata,
> +				 unsigned long *latest_timeout)

That really could use a better name - "are all links timed out", at
least, but what does it even mean that "a link timed out"? You mean
something more specific, surely?

Also maybe we can encode the bool return value in a special timeout
value, say 0, and just make sure 0 is never otherwise returned by
adjusting by a jiffy or so? Not sure, just seems a bit annoying to have
both, but maybe it's worth it.

> -	if (sdata->vif.bss_conf.csa_active &&
> -	    !sdata->deflink.u.mgd.csa.waiting_bcn)
> -		return;
> +	unsigned long latest_timeout =3D 0;
> +	bool all_links_timed_out =3D true;

You don't need to initialise something

> -	/* If timeout is after now, then update timer to fire at
> +	all_links_timed_out =3D ieee80211_is_all_links_timed_out(sdata,
> +							       &latest_timeout);

that you're going to unconditionally initialise anyway

johannes

