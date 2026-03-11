Return-Path: <linux-wireless+bounces-32984-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHrUE/BNsWlCtAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32984-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:11:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CCF262C8F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 600DD30AF72B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D3365A14;
	Wed, 11 Mar 2026 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D1L9H1UC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3413A383F
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227254; cv=none; b=GXa3qGtgvij/OsRlBAndhyYtSr16pDoE6cIMJJXXqsFfVAhuI/i5xFKsCDHK4KseQq4eX5kZwRlE9DA8dqhv0Kmfjk56BCDMrBDhzd/9doJqiyghyhTJSa9aXoCTnM6UZVGaC7BJWeDu9nccvlCcdnTYfI2iwUSF6ijwpS+b3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227254; c=relaxed/simple;
	bh=OpL5jV6qmI0H0WC/ABezMyK0e/+XzELjgHtE9oiMUzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QM2Iwo03rBKm7clYuE2aJY0r53XnX04VoIj+tQGaxJIMOKbzhHVznD8yvt9Xi9xqaIOyGEIhN39Zb73r8v7ICUG+m93YdwoEHKU4TDhjzKkwwCKHszSf27qoYBujjDV23KsOn5CbJ7zVbpIXvrTUnowf8vyaDJnhbAj3CGqB/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D1L9H1UC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ukPy7U/m+9cq2ag3ojbRe07sacU3APOHoUdAW0kHMIM=;
	t=1773227249; x=1774436849; b=D1L9H1UCistquVTTb1ss3AOEuRMj+NgVgH+KmWTErDbj57u
	06XOmIvCgKDNtQ1DQyULyfAlNiWoWRkXI2vOHWRqVCXU/i8Eqg5UpE19HJT1zIeg7GbWqhapHu20m
	sa2NxT36kbu/JgtoxV/FeW6CJ0xOI1ZXRfDux5EiUSLu1NEkmpeHubdQXzLWtzMOPsuEge5MXtJzu
	P5BRcBeEJ39Puzga2Xy3LnN1wMB5kkg8FYtWdIVXXKuk69olZIzopJMlRB90pwssizJN0VbDJxpp+
	hFi686xCRFKdTHwR8Tw4B/hjLRd8pgyXc0p3a9p60GnI56lYyDwokD4AUbN9jIDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0HPS-0000000Ep32-4BXM;
	Wed, 11 Mar 2026 12:07:27 +0100
Message-ID: <493973048da8c2c0b80a33abb98540acb4e6c200.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: init S1G properly when
 creating chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 11 Mar 2026 12:07:26 +0100
In-Reply-To: <b725c0be05df1a9595c177aada4cc148bf555448.camel@sipsolutions.net>
References: <20260311064339.524758-1-lachlan.hodges@morsemicro.com>
		 <791eaf8ab04dcbe01e2d71612d162f71c61e573a.camel@sipsolutions.net>
		 <4dhrrbuvxdgve2doc7qvabzjancimtqpounngyrxspk4d4rbls@xnad5bwciz7c>
		 (sfid-20260311_112148_368557_B2317140) <b725c0be05df1a9595c177aada4cc148bf555448.camel@sipsolutions.net>
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
X-Rspamd-Queue-Id: B6CCF262C8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32984-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-03-11 at 11:56 +0100, Johannes Berg wrote:
>=20
> +++ b/net/wireless/chan.c
> @@ -29,9 +29,10 @@ void cfg80211_chandef_create(struct cfg80211_chan_def =
*chandef,
> =20
>  	*chandef =3D (struct cfg80211_chan_def) {
>  		.chan =3D chan,
> -		.freq1_offset =3D chan->freq_offset,
>  	};
> =20
> +	WARN_ON(chan->band =3D=3D NL80211_BAND_S1GHZ);
>=20

Hm, no, I guess that really should only allow 2.4, 5 and 6 GHz.

johannes

