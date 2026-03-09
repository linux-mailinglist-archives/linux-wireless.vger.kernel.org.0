Return-Path: <linux-wireless+bounces-32756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOYnIXCDrmlwFgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:23:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47070235765
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38942301460A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE84B36D4EA;
	Mon,  9 Mar 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MjzRNFMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2236D4F9
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044580; cv=none; b=QU54sXDRijjgYHxUL1bO96HsRhObgHwbrJoYrZRCIpTMvGof3oIG8cOw7fv15XCC4KAyDF/P3kcsc3VSkhJViVbFzBitdbTUy11arYrurtHytClb8FKoIIFPNSumXb/YJTdEDkq/QI4u9Y4Q39L9cOrD86RL2sZWEGIVFhutlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044580; c=relaxed/simple;
	bh=wc4KpAHHCOAr867bDpCKNjFxjoSaCDLT9gycb6oDdoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oknt+fMvMQgFQwfOFO7Uzb2DPPXgZ1yrS+pnyhZJY1rM/qCEAd5Nc+56FnwyGVwU214aNAJ70jR9BEp4k6IbcwdYSVleMW7E2t5cz6V76IeUegr+IPvoCmdsZbwy6wLG4oGWg6iIbgkOrnEC6Gj2ROv4KW5nFbjlWXa42W/rmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MjzRNFMp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wc4KpAHHCOAr867bDpCKNjFxjoSaCDLT9gycb6oDdoc=;
	t=1773044579; x=1774254179; b=MjzRNFMpWvPvIKviqEw+8HwQwZmHc7EDfLeJITMJMpdverM
	tq2qwrv0FocCGE3Kr6BtQG2JN28cB2y0Cum7pjj/uNnRoRw4AjmShXt3TspBm08eKTjHfFJznZg7l
	JcBFd2JdpOpTPdW/JFUgRxSEyxAFVHgCNInOKwzHTlInns6T8kcFqlYafRFQ6ldNNHZX5dp3upufH
	V7GaJahUQtNW2mGlYIaqjUDMrwMZM+QloNzsSGevd2z0U2UFJMeaTssmjfOwGh/O036rXhLiag6xk
	MvUbhXBvVPjalo1/uivSepR7G5+vVnv/t1nbUQWJQkjXvFBAr2aOpJ7S9oKq+row==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vzVtA-0000000Co3i-3iBD;
	Mon, 09 Mar 2026 09:22:57 +0100
Message-ID: <e62a7a4fcdbb71c76d9e96d058610c0ca57bfc0d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Remove deleted sta links
 in ieee80211_ml_reconf_work()
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 09 Mar 2026 09:22:55 +0100
In-Reply-To: <aa6CuVi3BZxLBcPA@lore-desk>
References: 
	<20260307-mac80211-reconf-remove-sta-link-v1-1-efe58070cd36@kernel.org>
	 <jv2kdsru66rktkm6bwq3ww5wshubjtv36le5xk4ziedocc72gp@psssohaoamus>
	 <aa15YDx5G7WN-nsH@lore-desk>
	 <be1c90f6be71f6118590b0add4d657cd79d2ea2b.camel@sipsolutions.net>
	 <aa6CuVi3BZxLBcPA@lore-desk>
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
X-Rspamd-Queue-Id: 47070235765
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32756-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 09:20 +0100, Lorenzo Bianconi wrote:
> > Also, I think you need ieee80211_sta_remove_link() to tell the driver?
>=20
> I think we already inform the driver running ieee80211_set_active_links()=
 so
> ieee80211_sta_remove_link() seems redundant, right?
>=20
> ieee80211_set_active_links() -> _ieee80211_set_active_links() -> drv_chan=
ge_sta_links()

Oh, hmm, yeah, good point!

> > And I realized another thing - this needs to destroy TDLS stations that
> > were on the link being removed, but maybe that's a separate commit.
>=20
> Do you mean ieee80211_teardown_tdls_peers()? Is it done in
> _ieee80211_set_active_links() too?

So ... it was all already consistent all along, at least towards the
driver? I totally missed that, sorry. Thanks for checking!

johannes

