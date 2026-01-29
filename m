Return-Path: <linux-wireless+bounces-31297-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCbRBQ0Re2lQBAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31297-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:49:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9753BACFD5
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 899D2300C0C4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D33837C10E;
	Thu, 29 Jan 2026 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="svswFa/W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2637BE60
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672938; cv=none; b=TReXAgFj2j3Nif851Y/KlqULSJ4EVbdOwXihBDWMjZcoLWHvDy7hFoWojYderQRgxcyxX/7fiwFLAMwBZSDkF0nqTQmBCJK7cGaFXhUSPOXRO1Tcg6KOsTwm4UwKHTux7/68/CdZQjXgQoNNAahzelf7wj/RjL11gjuuqxlr7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672938; c=relaxed/simple;
	bh=sGApVwaRf6izpxJNSwlazs2LcTBGB0okjob2qOeCnMg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQYVix1GBuNZZp3829+NJLcSkzqsFbafDpB6pc+X2LXQJAbHRGUc98NhwQVXhN9zacX1TJ0+ZXNooOpjfqTVQ9pQllMBLE0l4q3IGUNuoGwwgCjlxcyHK5NSAMoCVsQt4lTqkKvpcQndYnIEhl0CUH0B7hOBf0NWFSLmvW+HYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=svswFa/W; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=95JoLVTCzD0miSR8Pg6ZLweCrXFRbOYixRVFCwrdUSk=;
	t=1769672937; x=1770882537; b=svswFa/WVv6LIHxTdppraFz6ci42Pq0le5sOqesOCN3/BhC
	y4w5kuzV9o5763ck5dm9rTzT9DqiaA5p69CAdS95MjP+TEofwe+N7TdeY3KKpow567UYaHGBM7YP0
	DOPX5GBLS23fVW1mwPE6nqiLi+rf3+7s281adJDuTYmvvw6v8Fld22VncX6URvNuGyaGMWTa6aJ6c
	lEbIFRa1h21FN9S43rxHIuMueUSYqHvCrlV7lOCo8/Tyzbculj9SMjadDLuP3SlcISe0BgyGr8eLW
	mxbLqQJERoZ0wpFsGOhZERNeF6qi9GiP86iYIpymToSQTOaE1XcIJL+sSYkRY+Rw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlMlp-00000006hj3-3UoP;
	Thu, 29 Jan 2026 08:48:54 +0100
Message-ID: <498500d94c3fb3e4117f9941983311058232e64a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 1/3] wifi: ieee80211: add some initial
 UHR definitions
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 08:48:53 +0100
In-Reply-To: <ec69981d-aa4d-4ce2-ad7f-71e68784029e@oss.qualcomm.com> (sfid-20260129_083339_950328_E308D269)
References: 
	<20260128133033.aa4a43982df0.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
	 <ec69981d-aa4d-4ce2-ad7f-71e68784029e@oss.qualcomm.com>
	 (sfid-20260129_083339_950328_E308D269)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31297-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 9753BACFD5
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 13:03 +0530, Karthikeyan Kathirvel wrote:
>=20
> > +	if (cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
> > +		u8 dbe;
> > +
> > +		needed +=3D 1;
> > +		if (len < needed)
> > +			return false;
> > +
> > +		dbe =3D cap->variable[0];
> > +
> > +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
> cpu_to_le32 ?

It's only a u8.

> > +			needed +=3D 24;
> It should be in bytes right offs +=3D 3 ?
> > +
> > +		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
> > +			needed +=3D 24;
> Same here

And I _was_ wondering how this was so big ... oops.

Thanks!

(would be nice if you could trim the quotes further)

johannes

