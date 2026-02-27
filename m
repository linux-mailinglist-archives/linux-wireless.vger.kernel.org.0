Return-Path: <linux-wireless+bounces-32297-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FSuAMmMoWnouAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32297-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 13:23:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 579861B7092
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 13:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B248303740C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF21A01C6;
	Fri, 27 Feb 2026 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wcpdGEFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EF1A9FB0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194964; cv=none; b=V1hphsXrb/VPAo4XLOQYoDo1b95wo3dszJdyA0k6ESIfiYBRb2x0CM6IaykTWpU7k5fkisEY8sbQ6AHHI++U/q7QacRaxFjKQe3FSD1QZs8hbZMxwamohiu/6oKnwP2XhKPviR7qdldjmEtoea/fp7jN/xzXqOd0mudpLQt1CIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194964; c=relaxed/simple;
	bh=ZfnkZt25iR57xlnBAZkaJVnSm2yYo5Mh9dB9pwAGyGw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ee11fX2c5Mbe3k8/5A2MUtw/YppeJsFAlexmMwaGYOSE7ds6BXu5cnqeegr0xRh5PEKKRCl9EixOiEuxkWgp13Kv6oiR0OjHfibmdnn5kMnO5u7hn+285YWqCEimhtvIS1KLgGkbBxwWqjsRE2SSzlRFtvWj+PZcO8/TsI9hQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wcpdGEFP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g0Je4Qt4ejSum+S9Oz9z7jDsBfVTorMAgpDpVQ4Cj3o=;
	t=1772194963; x=1773404563; b=wcpdGEFP6yLCZG3qibLJSWaaKQrhKMYdrPe+8pOcv6qgLpT
	zRUaqCi+hSaYZ7ZjinMy3md7ce2O477ARdeRLrodf+7mxJgeroLPR10L/ZMkDQriAr0JwAbelEJF8
	vQsEcLEPfqphk20ZmZc9x+M//xf0hb3oHB2iY9BdWpdB2nEugC1FH4Zw8/PXt0kkRDoB9sgtzroD0
	82IXWLT3vCErbUWXe9nQVxbBOMkB0FnBPuHdOtbZYpbkPToJY2nDEnT3G2oU7P9L1eWUZLMSzwwkE
	UaDkRrudKoYmJJoggFFMZjvmvtxlLw2g/GkNZM7fgHPEUvhIg8L51i81H37D7Xhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvwI9-00000003LrS-4Ahp;
	Fri, 27 Feb 2026 12:45:58 +0100
Message-ID: <7f71b9df99e286c695b9c159792e68b36a1dd54f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: move action code from per-type frame structs
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Date: Fri, 27 Feb 2026 12:45:57 +0100
In-Reply-To: <418d3666-6bd2-4ea7-8e1b-4d49dda255a2@freebox.fr> (sfid-20260227_122228_548126_45EA6153)
References: 
	<20260226183607.67e71846b59e.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
	 <418d3666-6bd2-4ea7-8e1b-4d49dda255a2@freebox.fr>
	 (sfid-20260227_122228_548126_45EA6153)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32297-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 579861B7092
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 12:22 +0100, Pablo MARTIN-GOMEZ wrote:
>=20
> > +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> > @@ -755,16 +755,12 @@ mwifiex_construct_tdls_action_frame(struct mwifie=
x_private *priv,
> >  	switch (action_code) {
> >  	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
> >  		/* See the layout of 'struct ieee80211_mgmt'. */
> > -		extra =3D sizeof(mgmt->u.action.u.tdls_discover_resp) +
> > -			sizeof(mgmt->u.action.category);
> > +		extra =3D IEEE80211_MIN_ACTION_SIZE(tdls_discover_resp) - 24;
> Not sure that is clearer than:
> ```
> extra =3D sizeof(mgmt->u.action.u.tdls_discover_resp) +
>         sizeof(mgmt->u.action.category) +
>         sizeof(mgmt->u.action.action_code);
> ```

That's a bit of a corner case, but given the above code that uses 24
explicitly, I tend to think it _is_ clearer, and it's definitely "safer
to understand" - you know that you didn't miss anything...

If someone wrote here

	extra =3D sizeof(mgmt->u.action.u.tdls_discover_resp);

would you really see that it's wrong? I think it's very easy to miss.
It's correct now, but the "- 24" definitely flags this as something
special to check the context.

> >  	addba_ext_data =3D
> >  		ieee80211_retrieve_addba_ext_data(sta,
> > -						  mgmt->u.action.u.addba_req.variable,
> > +						  mgmt->u.action.addba_req.variable,
> >  						  len -
> >  						  offsetof(typeof(*mgmt),
> > -							   u.action.u.addba_req.variable),
> > +							   u.action.addba_req.variable),
> `offsetof(typeof(*mgmt), u.action.u.type.variable` is equivalent to
> `IEEE80211_MIN_ACTION_SIZE(type)`, isn't clearer to use it?

I guess we could. I was mostly getting it to compile at some point :)

> > @@ -949,8 +945,8 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if=
_data *sdata,
> >  	}
> >  	rcu_read_unlock();
> > =20
> > -	baselen =3D (u8 *) mgmt->u.action.u.mesh_action.variable - (u8 *) mgm=
t;
> > -	elems =3D ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variabl=
e,
> > +	baselen =3D mgmt->u.action.mesh_action.variable - (u8 *)mgmt;
> Another equivalent to `IEEE80211_MIN_ACTION_SIZE(type)`

type?

> > +	elems =3D ieee802_11_parse_elems(mgmt->u.action.mesh_action.variable,
> >  				       len - baselen,

> > -	dialog_token =3D mgmt->u.action.u.ttlm_req.dialog_token;
> > -	ies_len  =3D len - offsetof(struct ieee80211_mgmt,
> > -				  u.action.u.ttlm_req.variable);
> > -	elems =3D ieee802_11_parse_elems(mgmt->u.action.u.ttlm_req.variable,
> > +	dialog_token =3D mgmt->u.action.ttlm_req.dialog_token;
> > +	ies_len  =3D len - IEEE80211_MIN_ACTION_SIZE(ttlm_req);
> Here you did it :)

Guess it didn't really matter that much. Or I stumbled over this one at
a different time, or something :)

I don't think any of this is worth changing right now. Feel free to send
extra patches.

johannes

