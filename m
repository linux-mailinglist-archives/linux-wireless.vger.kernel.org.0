Return-Path: <linux-wireless+bounces-32453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULn6I3Xkp2nqlQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:51:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 160661FBF14
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 514DF30D77F7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78195372686;
	Wed,  4 Mar 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YL4E08do"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80C37418F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610339; cv=none; b=oIBwhqs3BYcgm7iLHrc+z+mcFNZqU9Vs+vJlCrJ5nJm1+BI5OTaxa4Hv85NNdBXQxWSnnXhV5Xlry89r0ycKlitKn3/gsLprLMPAFhHC2y3yuNW/62Udm1+OnT/e7KmcZ+apajR5T1b3Pt/qSa3pFy5UamVWvU7Rwm7xiMOAIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610339; c=relaxed/simple;
	bh=Q30Q3hcaPdoUN3Acnrgz+5WCMha0wvoGGIJgDdtA/F0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSs4EYvbSX1mw9HWok2o9VdoO6DtmawdEmmixIj3crA/YTHcAihPGw5WtnAsezjqBQ6TjTEMOMLzQ6r+weKSWA5wkfJSayfBdfdpXW5gxntQfdFuhh16fdZNFVO5Wnv8o7W5xrBUrpnF/U3Fc255WttVay8P18uawYtfQtCOlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YL4E08do; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G5qlcxlqxMaHuA6iGyWwiI9OGTK8UL1hbfm48FiILl4=;
	t=1772610336; x=1773819936; b=YL4E08do1kNsuLKn8jxtHUms1m5lM42IPSHow/NyASCZhLK
	lJ7WlZk1cwUwGRMaFwz9ZXmFAXX+OoZhp9THvLZbTf5z7aN6ViLgfrdpky7WKNmLmAvs3ZR7PPpwy
	Vp286Bj2KQiSlaYC0xDDXcXBFaWDVqrXZnRHSNlziZcU3Yb55f4aBNC6jpRRFMHU4AAapXXhJG4Lp
	j0ZZmfddjcn3LqyuTNSvu7sCgsE5cQmE4NMuqIRnq17XKYXriDG9NabJ8FwKWPfBxShQqLbFOn82S
	wyZBDJ6ss07SeA1DZbtHs7MndoqGLN34GoJOwl8IZnM3JIiX4N1maFPrYADk2v2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxgvG-00000007x39-09eK;
	Wed, 04 Mar 2026 08:45:34 +0100
Message-ID: <ec522deac16cd21400818749ec9e97ca7e00d908.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 8/8] wifi: mac80211: set AP NPCA parameters
 in bss_conf
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 04 Mar 2026 08:45:33 +0100
In-Reply-To: <h6zaryfx46dg45gmysd4joxecawzkj256pu6uy2g2dbmzwpfxr@apaq4cud4rmg> (sfid-20260304_035704_694782_2141B706)
References: <20260303143434.273141-10-johannes@sipsolutions.net>
	 <20260303153435.75b65c3144b6.I3db62b48d6afefd23b50fd14663f863e6f9974ca@changeid>
	 <h6zaryfx46dg45gmysd4joxecawzkj256pu6uy2g2dbmzwpfxr@apaq4cud4rmg>
	 (sfid-20260304_035704_694782_2141B706)
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
X-Rspamd-Queue-Id: 160661FBF14
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
	TAGGED_FROM(0.00)[bounces-32453-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 13:56 +1100, Lachlan Hodges wrote:
> > +		npca =3D ieee80211_uhr_npca_info(params->uhr_oper);
> > +		if (!npca) {
> > +			chanreq.oper.npca_chan =3D NULL;
> > +			chanreq.oper.npca_punctured =3D 0;
> > +		} else {
> > +			npca_params.min_dur_thresh =3D
> > +				le32_get_bits(npca->params,
> > +					      IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH);
> > +			npca_params.switch_delay =3D
> > +				le32_get_bits(npca->params,
> > +					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY);
> > +			npca_params.switch_back_delay =3D
> > +				le32_get_bits(npca->params,
> > +					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY);
> > +			npca_params.init_qsrc =3D
> > +				le32_get_bits(npca->params,
> > +					      IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC);
> > +			npca_params.moplen =3D
> > +				le32_get_bits(npca->params,
> > +					      IEEE80211_UHR_NPCA_PARAMS_MOPLEN);
> > +			npca_params.enabled =3D true;
> > +		}
>=20
> Minor nit, and I can't really comment on the actual UHR code - but would
> it be nicer to have
>=20
> if (npca) {
> 	npca_params.min_dur_thresh =3D ...
> 	...
> } else {
> 	chanreq.oper.npca_chan =3D NULL;
> 	chanreq.oper.npca_punctured =3D 0;
> }
>=20
> instead? I have no strong feelings of course, I was just perusing and
> felt it was a bit strange to read.

Fair point. I had a few things slightly differently during development
(and the non-NPCA had some goto/return) and just never went back to re-
structure it entirely when I removed that wart.

johannes

