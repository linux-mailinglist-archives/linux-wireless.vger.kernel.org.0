Return-Path: <linux-wireless+bounces-37384-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gNBVL8hkIWq8FgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37384-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:43:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91C63F84B
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=mbsU6790;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37384-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37384-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F014305C516
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A850410D24;
	Thu,  4 Jun 2026 11:40:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156073E317D;
	Thu,  4 Jun 2026 11:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573214; cv=none; b=Zp4OM5SzQP0NDGugy49e8SRaEPZJm3Rly8pkPsRg0hvZBsZRe/iqNR+kLMZRSfTZAA31w7hjHKeRigGfVKMVvHuDjcUdIfPspUIfMm1URRLGLMbD8BXJ/XRb05BfovSeKwiDmMhOYC1T4S5PiIDjZcX9ssxtu8gjtwSJxhn3z9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573214; c=relaxed/simple;
	bh=qYD9zc29ySIB0GWG8d4c/qFzc2JqtYicM8oTF3iqo4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEnTeRZ/vazwuud4PDA4kSdZGuzHY5+9XipwDqWLquHQxfg7tELdyZvOWkzxLuoZOx6BSP6EciWOBNUAvUa1Oha0A3ZsHkxmBXqo4cLC3iSsjOXJAG/Y4SKE2lLHPN53qiOdVu+KSzAosMNMSuB6NCfUhsLRPpFULd8MsZTQr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mbsU6790; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Tsvln2rg5iiSuOKrX2oqFDL8qBir5+DUnrcUpIBuYZk=;
	t=1780573213; x=1781782813; b=mbsU6790wazLwZe2cR79m0C7YN9oPxEmcv+aa/Zz7FNICD3
	U94/JW5MSB49BpIsoWfGfI4IftVXYjxPz1wXJJJd+23si4DeWB9Ny8ovtBPWCgBL1aeA5kl+BOLeV
	JTSY4fz10K26p9/oUNAgRlACfjcq8MxJ2fbD1RdLmTUpKJ4P6aNRd4AIiT05504f+TZ2sNa7Pt1MF
	nMXihuTQuMSowdCY46xKkAaDCBKpZTsULUw58TVlaJniPVxmYr+a9NYHbsjYWG383u9av4BykivsG
	w6QJwoSV7TuwdsfDUW/ZxPfaF8ADKRtbXrVXbNA/MTiDGXOyHDBMaTs/z+FZ65Nw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV6Qk-00000000SiQ-2faN;
	Thu, 04 Jun 2026 13:40:10 +0200
Message-ID: <f6dbd068437564e18695b1ef263ebba27ad7fab0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 06/31] wifi: mm81x: add core.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 13:40:09 +0200
In-Reply-To: <20260430045615.334669-7-lachlan.hodges@morsemicro.com> (sfid-20260430_065711_057965_1F72265E)
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
	 <20260430045615.334669-7-lachlan.hodges@morsemicro.com>
	 (sfid-20260430_065711_057965_1F72265E)
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37384-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D91C63F84B

On Thu, 2026-04-30 at 14:55 +1000, Lachlan Hodges wrote:
>=20
> +#define KHZ_TO_HZ(x) ((x) * 1000)
> +#define KHZ100_TO_MHZ(x) ((x) / 10)
> +#define KHZ100_TO_KHZ(freq) ((freq) * 100)
> +#define KHZ100_TO_HZ(freq) ((freq) * 100000)

Maybe not right now, but at least the first one seems fairly generic and
could be elsewhere.

> +static inline u32 mm81x_fle32_to_cpu(u32 v)
> +{
> +	return le32_to_cpu((__force __le32)v);
> +}
> +
> +static inline u16 mm81x_fle16_to_cpu(u16 v)
> +{
> +	return le16_to_cpu((__force __le16)v);
> +}

The whole __force thing here seems odd, why isn't the input 'v' just
__le16?

This goes with all the FW loader thing - but that also has all __force.
I'd argue it'd be better to just have separate FW-endian (little endian)
and host-endian structures, even if that duplicates the structure
definitions, but it'll have sparse actually checking the fields were all
converted correctly rather than casting a little endian structure to
host endian and then doing the conversions:

                mm81x_elf_phdr *p =3D (mm81x_elf_phdr *)(fw->data + ehdr.e_=
phoff +
                                                       i * ehdr.e_phentsize=
);

                phdr.p_type =3D le32_to_cpu((__force __le32)p->p_type);



(sorry about the partial email I think I sent, that was an accident)

johannes

