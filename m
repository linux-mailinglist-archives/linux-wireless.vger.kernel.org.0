Return-Path: <linux-wireless+bounces-31135-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5ZbIH/jVc2kOzAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31135-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:11:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E29357A816
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C65AE3013857
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2108260592;
	Fri, 23 Jan 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EDuXqO+M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C03EBF06
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199093; cv=none; b=i7AoQQdInKm0+Hcce31Ht3GeHkWdY8A0N+ugin04gBAbgwIBM1kKcNEGevQIaWXyX9SOZrAIRpePQLWEQi0rzdRAZWP740qMSPO/Oi+uOZQxmSuDVFoSRWFJAmxlWyqOpJD59sqm74qlgiZmNyIsglKOZMOtBkNjAEoCkeBr56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199093; c=relaxed/simple;
	bh=rzEqp5TLKPX5rgpKEtysxMoipGGg0xe5AdxiJREdC6A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTy5u04Gdu6T+GVf0HzD05+eIlRY1YJlWB9gdmJMhWRz7f5Hnt9XFpecd1MJLXXdMimq/gk1vCfrG4JvoAl0NymjF+bcJt/UKR8XoVPy8/CXaLleHLDvxDul6ILL64QKPBMwc4EmiLy9kplV0TDIXAb5LZw3VBQS4pnrt8RhhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EDuXqO+M; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cBDERq4qvf+REaYnCHMVDt+pGlfCXAvAylDTTAHYV9w=;
	t=1769199092; x=1770408692; b=EDuXqO+M3hZ9KWgkITwt5wLhSGzkvd+ohiXKhyHxj90k3xT
	a6HTE1WGekvx9SzgYPN+bvTVicvindn1+6fd5wad9fflhPSHwFWFmrBQrv97pkkpjBAr0FdHGAWNY
	DyFq5v50RTzb5Rh1hR4xY8nD4SCIiR+jJiNAz1QbO4i+LiLv16is+swkvHuigM/kNA/1EravZ6x8t
	GusxbC7UlS/JFhVgDtoXJY16+k8eH8HUNTixW7jGMJ2DAkGzzQGMnNDZ1bHZhoDqII25KBvcnmENb
	pRrNkllluM8LQiQi8r/pdfhaGeFKxEr7VHSKfhzYJCXsDfYZWPIDBWx50A2lGEGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vjNVA-00000001r1T-2JCs;
	Fri, 23 Jan 2026 21:11:28 +0100
Message-ID: <802579416827936058d24a5e1ad24084e2d1e8ec.camel@sipsolutions.net>
Subject: Re: [RFC v2 wireless-next 2/3] wifi: cfg80211: add initial UHR
 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Fri, 23 Jan 2026 21:11:27 +0100
In-Reply-To: <460791be-6a4e-4098-bc74-effd31c8c593@oss.qualcomm.com> (sfid-20260123_210041_723653_B72564D7)
References: <20251216162421.40066-5-johannes@sipsolutions.net>
	 <20251216172421.5f35a099e950.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
	 <460791be-6a4e-4098-bc74-effd31c8c593@oss.qualcomm.com>
	 (sfid-20260123_210041_723653_B72564D7)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31135-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E29357A816
X-Rspamd-Action: no action

On Fri, 2026-01-23 at 12:00 -0800, Jeff Johnson wrote:
> On 12/16/2025 8:23 AM, Johannes Berg wrote:
> > +	static const u32 mcs_divisors[] =3D {
> > +		[ 0] =3D 102399, /* 16.666666... */
> > +		[ 1] =3D  51201, /*  8.333333... */
> > +		[ 2] =3D  34134, /*  5.555555... */
> > +		[ 3] =3D  25599, /*  4.166666... */
> > +		[ 4] =3D  17067, /*  2.777777... */
> > +		[ 5] =3D  12801, /*  2.083333... */
> > +		[ 6] =3D  11377, /*  1.851725... */
> > +		[ 7] =3D  10239, /*  1.666666... */
> > +		[ 8] =3D   8532, /*  1.388888... */
> > +		[ 9] =3D   7680, /*  1.250000... */
>=20
> you probably already know this, but checkpatch doesn't like the first 10:
> ERROR:SPACING: space prohibited after that open square bracket '['

It probably also doesn't like the leading spaces after the =3D sign, but
... I don't _really_ care. It's way more readable this way IMHO.

> (yes, I'm running your series through my automation since we are vetting =
our
> additional UHR changes on top of yours)

Do you want to post it all together (and maybe fix the uhr_oper thing
from your other mail too), or do you prefer I repost this?

(I'm confused our kernel-doc automation didn't pick up on the uhr_oper
thing. I guess I need to check that.)

johannes

