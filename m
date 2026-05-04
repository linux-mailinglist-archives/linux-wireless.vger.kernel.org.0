Return-Path: <linux-wireless+bounces-35865-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBScGKqq+GnXxgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35865-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:18:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E44BF08D
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14BA13021BE4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286E1A6827;
	Mon,  4 May 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DMgA5TCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB273DE43B
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904153; cv=none; b=sziFqndYLzqKQrYCEQAzD4HSwao5U9i6DdhX01EVgsEyc58UiWrMsHeQmlkgTzIVG2DonAWEY/NBBPAVsX9R+4rf4TEOPPvIgh+CXDcPEgSx8T4ZUcl9TWIEKAqqtCm/nNlKMC5+K915djHDfrom7/kLeawoIfM0TWflltsjNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904153; c=relaxed/simple;
	bh=LBbFpVdC92PIqWM4ImtY091cwdBOKpbV8L9WJnl/lKQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oVmo/e9rXxM6HwOm+4c3KibY+uFlWLf5JBKyx/vmF0jR68B0e/Px/BF+BshTSegVLlfCW9keGlTZ1Rj1XZlYQ62TnXiVUKjI5NFh+VDTVTkAzwAbLcc0LiDN6srFBHnAaSGjluKc92LGmEO/+4rwVsTMx5/FKS4th9XiCqfjpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DMgA5TCI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ebJASQugrWOyt+b6x1Tcv+XLaGYvPwo6AgkMpQes6aU=;
	t=1777904152; x=1779113752; b=DMgA5TCIcqZ9J3wI7wo0IN9qifMEgUXOut9BmUo04ww+4mF
	oXUTLi7sLrNdVrHv1/4sJq61i+y9+vqOY9OeSCfZJIlHwxOpFm64I9E5uAlQd1R44nkFgZoTBr6/g
	22ky0wxupfvsxtt1xxGKZxyXFq5t4R3LqYVTqFhvyG7hNKhQEIsg8SpyKBKoTNuwZv2O6MfcYtYVE
	zV+piW0DqfMhOpWCzxlZJbzbYKUxI64DIifacCAaYDw2WVLRRVWHx4O41oHDdbopvVnmvC3r7wFgO
	wDx8eLuV8jnQpKfF0PE2YnDqE+Dv6sY2vK6fZHVnSG1sJOZNZSOn2YNuMPs862GA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wJu5L-0000000F0Cu-3aVt;
	Mon, 04 May 2026 16:15:48 +0200
Message-ID: <0a53312265b6f466f01e169f0b385a0ef4d0b157.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 2/2] wifi: mac80211: set
 assoc_encrypted for EPP associations
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>, 
	ilan.peer@intel.com
Date: Mon, 04 May 2026 16:15:46 +0200
In-Reply-To: <20260504123624.529218-3-kavita.kavita@oss.qualcomm.com>
References: <20260504123624.529218-1-kavita.kavita@oss.qualcomm.com>
	 <20260504123624.529218-3-kavita.kavita@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 236E44BF08D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35865-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

Hi,

> +	/*
> +	 * If epp_peer set, unprotected (Re)Association Request/Response frames
> +	 * are dropped, which ensures that the (re)association exchange is
> +	 * encrypted over the air.
> +	 */
> +	sta =3D sta_info_get_bss(sdata, sdata->vif.cfg.ap_addr);
> +	resp.assoc_encrypted =3D sta && sta->sta.epp_peer;
>=20

Not related to this patch, but something I realised just now looking at
this, coming from your earlier commit 63e7e3b6433f ("wifi: mac80211:
allow key installation before association") ...

The code you added in that commit seems insufficient to me. As far as I
can tell, it's possible to have assoc frame encryption with FT (see
802.11bi D4.0 "12.16.8.2 FT protocol"), but that doesn't explicitly
specify that it can only be FT-over-the-air. If FT-over-the-DS is
possible, then the code in mac80211 cannot support it, because the only
way to get the sta->epp_peer flag set is via authentication (802.1X over
auth frames or EPPKE), and the only way to install the TK before
association is to *have* a station entry in the first place, and have it
have the epp_peer flag already from authentication. It also sort of
breaks down if the station entry is removed for some reason (rather than
not being present in the first place) and from mac80211's POV we go to
assoc immediately without having the station.

One way to fix it would be to add the TK to the ASSOCIATE command, but
that would have to replicate a number of settings there, I'm not sure
that's desirable.

Another way to fix it would be to have an NL80211_AUTHTYPE_FT_EPP or so,
that just does all the processing, adds the AP's station entry and
immediately moves it to authenticated while setting the epp_peer flag.
That way, wpa_s could do this and then proceed to install the key and do
association as it otherwise would.

johannes

