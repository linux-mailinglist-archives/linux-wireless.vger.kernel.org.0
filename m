Return-Path: <linux-wireless+bounces-15571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8984B9D51D8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 18:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459CE2822DF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F8C156F5E;
	Thu, 21 Nov 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y5LSY+9N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hlwrdXf1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y5LSY+9N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hlwrdXf1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09E6CDAF;
	Thu, 21 Nov 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210546; cv=none; b=VSod9OLqR6g+u1SYceQ9lx7hlYD8On5i8rUjPahKDNJNZCzrwR/p5+Zyi10Q0lnxGb7qV1jcyHUOoAXfpB+6/OaSl1c/p9WrC48q1mBlCWICqPRd7gnYcusuAHi8tVe+57JfBEplet7pwzdkDYOWwQDSQVoIM4z/ievTZXXXaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210546; c=relaxed/simple;
	bh=y4lQySYNInlEKBU/YJzQ4HwTXxb8O2GS9DWAsozSIIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLzJemboQ90vq1bBwzGfExTQUlkHxlVEPRDdq71JffrLAS0PyXUrdyvnMRRHvWrlAsQD44+rXFCXR3XHaFHYbZ4xaLPoZUI5cAQA+45UC6olPqOJxKeb88pU0SmycwgnN9adzDyWuV8A1UmanjzhzWX8SWN3oT02g9D2ysxu3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y5LSY+9N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hlwrdXf1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y5LSY+9N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hlwrdXf1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E2C421A26;
	Thu, 21 Nov 2024 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732210542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02BBrTzZI0T8h1hKpz83VoemOYBc5XTVqsBWkr0QTjw=;
	b=y5LSY+9N6FgKotoQGAVzlt/q1sg034a2w757rCrxLhV5kSA4ao+0LZN1CRrfFkMj02g07z
	2ICUGnoPdT25f63Q+t2DS9+sVxE5nNhj+JqKKDO6cCf+IArM4sEhvf9xjn6JA1CJBILq4h
	MuxLTvboEsnuDuKyixJtw0LsTrfo73Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732210542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02BBrTzZI0T8h1hKpz83VoemOYBc5XTVqsBWkr0QTjw=;
	b=hlwrdXf1UOAv8OM1ixVFOcBIiZ8w2PYo2PPBJs+fzxRaQ71TDHTFBC3Fqh3tOzrvV8SKEw
	irCjrGAfncDVQ5Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y5LSY+9N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hlwrdXf1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732210542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02BBrTzZI0T8h1hKpz83VoemOYBc5XTVqsBWkr0QTjw=;
	b=y5LSY+9N6FgKotoQGAVzlt/q1sg034a2w757rCrxLhV5kSA4ao+0LZN1CRrfFkMj02g07z
	2ICUGnoPdT25f63Q+t2DS9+sVxE5nNhj+JqKKDO6cCf+IArM4sEhvf9xjn6JA1CJBILq4h
	MuxLTvboEsnuDuKyixJtw0LsTrfo73Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732210542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02BBrTzZI0T8h1hKpz83VoemOYBc5XTVqsBWkr0QTjw=;
	b=hlwrdXf1UOAv8OM1ixVFOcBIiZ8w2PYo2PPBJs+fzxRaQ71TDHTFBC3Fqh3tOzrvV8SKEw
	irCjrGAfncDVQ5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8435C13927;
	Thu, 21 Nov 2024 17:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1O8nH25vP2fEdAAAD6G6ig
	(envelope-from <pperego@suse.de>); Thu, 21 Nov 2024 17:35:42 +0000
Date: Thu, 21 Nov 2024 18:35:41 +0100
From: Paolo Perego <pperego@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	Shaul Triebitz <shaul.triebitz@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH] drivers:wireless: Fix a dereference before null check
 issue
Message-ID: <q3pul7n2axag5xcxzzjjrhwlu3m3vh64bz4ln6dt7w757z47hk@byhyujhanky4>
X-Responsible-Disclosure: https://en.opensuse.org/openSUSE:Security_disclosure_policy
References: <20241121170257.275607-1-pperego@suse.de>
 <e37392a6a1fcb11db42646da2afe055416ca4cea.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="khbcbgaofu7de5yx"
Content-Disposition: inline
In-Reply-To: <e37392a6a1fcb11db42646da2afe055416ca4cea.camel@sipsolutions.net>
X-Rspamd-Queue-Id: 9E2C421A26
X-Spam-Score: -6.11
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 


--khbcbgaofu7de5yx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 06:28:14PM GMT, Johannes Berg wrote:
> On Thu, 2024-11-21 at 18:02 +0100, Paolo Perego wrote:
> > This patch fixes a dereference before null check issue discovered by=20
> > Coverity (CID 1601547)
> >=20
>=20
> This was reported before by smatch too, and Emmanuel just made a patch
> to simply remove the NULL checks, because the pointers are statically
> known to be not NULL. So it's not really an issue other than
> style/checkers/... anyway :)
Oops, I'm so sorry this was already fixed. In Coverity dashboard the
item seemed to be still open.

Apart from that, did I followed the right steps? Was my submission good
enough? (I'm new to kernel hacking and I'm still in the learning phase)

Thanks
Paolo
--=20
(*_  Paolo Perego                           @thesp0nge
//\  Software security engineer               suse.com
V_/_ 0A1A 2003 9AE0 B09C 51A4 7ACD FC0D CEA6 0806 294B

--khbcbgaofu7de5yx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEad0ki8u8+tnCnxjUEWmTq+eyM3gFAmc/b2sACgkQEWmTq+ey
M3hu5A/9GRY9d0dbdQMKGN175sC6WsJLI2SEF7lOlDMsSe45WcuVl907G13OvY20
RS2ZPd2wu9J1q6KddS/05Hv9toGeYRpIjbyRDZ0LaqGYGNRhb6m07YKh3v7Ixwc3
cKV6rtHlZD0MtZuu4agpjGlJ6vbME5SZoj011mF2kHstd25y9AxWmW064mdmGMrx
SX7sNGCvmbsOI5wLz3cuBUsrhFtPVaS9Q3jeEY95jFxAO1czstSSwV95fBhq01QU
SERrmclJYi05Kgf9ebH4z1tOuPjxg7qHJ+PYWU42xQVFITMtMYzvxZGaB7ilFdjE
tD+GQZc0HNA+x4IdOceTvGzKBEMgypwX5E6Z8sWzQPYhtkbs5zlMPGe17YlpjfNW
ygHmQdu+OLOdnbqRJcePKNEKUdh2VZSvPuVgcTv/h00NhuhGu8Sid2y7szyL1+f9
O7RYq+wP8N4OBedhm7SFgaZJ3XvWQQPPJpEfEfIOTrTUOYypTa5ASbiQDjioIoDg
veOrt2hkqBbqlUTpqwLJt6tlfKuL86kWf48D120hI6hStupsAbBOGn9rmpHiWyIs
LHx34Wmtxulw5bzWeTE8mOklLcJJHDerptC8CD8UZDk66IwaVK3ZJF/0Wm4wGNb9
MKKFR0KDERO9PzsFFIJH3572Jh1PFoRUL9F0ZHbbtb54RCkCPSY=
=MvJw
-----END PGP SIGNATURE-----

--khbcbgaofu7de5yx--

