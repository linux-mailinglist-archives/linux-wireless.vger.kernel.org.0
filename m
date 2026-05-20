Return-Path: <linux-wireless+bounces-36693-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK1JJ+eFDWo8ygUAu9opvQ
	(envelope-from <linux-wireless+bounces-36693-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:59:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7158B385
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E19C300874C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CACD3D171F;
	Wed, 20 May 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="be7gcUPw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA483D1717;
	Wed, 20 May 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270826; cv=none; b=qJ2kJQnaT9hSxcfi4AUwoWRatknQoW5FDlzFHSh809why0bW1YA2UarYDHKGcrRjAwOugSDkQIzITj+CLmEcsPzMDuzrkNx3ZeWD0RaAONil0ya4zKtIHqzGq8tiTDQ/pEVP7IQU3W6HJL8s8ajiQT7/7K0PbUJpCOhTUYqkF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270826; c=relaxed/simple;
	bh=sZXNpFdt+miCOLrn5k4RQMB+WiN2cICO9fZ10VRa/y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbXuuwPj3qpFcpBiexGFeekBLqyXZv/5WH0OBsx4FLPfNSFiLAoJslu6tTN0RV+fAdTSPhcznlK+Gdk+WD0PDpxPymu7ePOt/SgYmT2j6sFfCTBvnR1nNeNxrwqu6J0VB9gNh9zVjFpdKWR091VwHqLC11xEeFxehksLMHYBHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=be7gcUPw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sZXNpFdt+miCOLrn5k4RQMB+WiN2cICO9fZ10VRa/y4=;
	t=1779270824; x=1780480424; b=be7gcUPwvbElmV6ckvGLZCdNmeFK52TmFwQknwJmdNOv3AN
	8fW8FWb3s3WQ3p00C4uunvyySUMFm4ZNfzz8W2OKnxjcLiA0Raky3LUVZVjYZYDGNQiMifFyJ6nUz
	dQ0uBDzepUCMOTM1KTW+0T1YSmwmWw6jPspVQe3gYLrvMm402L7NXe9to62D3in3w24jIrLbYCm+a
	lPtmJvnPddfc7qOtjrtljDhTuieLQA1WKOW+wMrnwt4xClPIFItSuRVXFqVVB89kfEeUxb7bQr1eQ
	RrKjzcEaBbGtowfTVBNnyEPC6tFVybBeDurX4Lb+p7kbagR7inUaDYAti+cdVxSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPdcS-0000000AA3U-2Zqc;
	Wed, 20 May 2026 11:53:41 +0200
Message-ID: <e73634b3b52d9ebe6c4e339ea5f6c35cb6d433a7.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?=D3scar?= Alfonso =?ISO-8859-1?Q?D=EDaz?=
	 <oscar.alfonso.diaz@gmail.com>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi	 <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 	fjhhz1997@gmail.com, Brite
 <brite.airgeddon@gmail.com>
Date: Wed, 20 May 2026 11:53:39 +0200
In-Reply-To: <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com> (sfid-20260520_115117_436034_41AED6CB)
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-2-lucid_duck@justthetip.ca>
	 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
	 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
	 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
	 <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
	 <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com>
	 (sfid-20260520_115117_436034_41AED6CB)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36693-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 4CB7158B385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-20 at 11:51 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> Ok, let me do one final test using Johannes=E2=80=99 v2 patch. The expect=
ed
> behavior is as follows:
>=20
> 6.18 or lower: no need to test, it will not work. It=E2=80=99s clear now =
that
> this does not matter, since the goal is only to fix newer kernel
> versions.
>=20
> 6.19: some versions of the 6.19 will crash and others will not. The
> crash was fixed at some point between 6.18.12 and 6.19.12. No need to
> test.
>=20
> 7.0, or 7.1: the expected result is that there will be no crash, and
> VIF + deauth will work only on 2.4 GHz. It will not work on 5 GHz
> (I'll test both, normal DoS and VIF+DoS). There should be no crash,
> but it will not work.
>=20
> So I'll focus my testing on 7.0 and 7.1 and I'll get back to you with
> the results. I'll be testing this patch (v2):
> https://patchwork.kernel.org/project/linux-wireless/patch/20251216111909.=
25076-2-johannes@sipsolutions.net/
>=20

Thanks. For testing that one you'd have to revert the other first, I
think, you could also just test this one:

https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.49=
109-2-lucid_duck@justthetip.ca/

But I think they're basically all equivalent.

Since we eventually need a patch to apply w/o reverting, Devin's is
probably better than my old one.

johannes

