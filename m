Return-Path: <linux-wireless+bounces-37617-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2wj/M1QEKWqWOwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37617-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 08:29:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C51D666418
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 08:29:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=GHHyWC5M;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37617-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37617-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C055231D3E5A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 06:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00D2DF3DA;
	Wed, 10 Jun 2026 06:22:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D93624D3;
	Wed, 10 Jun 2026 06:22:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072555; cv=none; b=q/0/uEHeeyAS3HIVv10vRwkkthsZA5cNGH3WHxxtCk8FFGUZFZPTeHuRFVKJ8xKJgr0mG9vRufZ0vvn/8a89NiEVEe5rTcTe/Pf26w/L8bOFAg7KoDlMJZMDywaVj9xnUgKJvrm25denkO283PsaU1Ng1Zj2FAoGUECuaQraYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072555; c=relaxed/simple;
	bh=e7DgnFkuCemQkdgtV0DCIDQ3abFomOAG/76upryUfmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3j09YJN9TSHCA24/clwwWigeR6r7IrH3ZnPelCc6b93ZepQt2WtShkjtZ+90dlaFJN9j4g6q9+/gU1QnnV+i+4AqsulzaPlQ6NGYDg0MIEJ3b8G6JnHcvG76/pNxL8htQRpAzX4R2LdR8n5TMuzSv6LcQY35dB+NSjcyaGD1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GHHyWC5M; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0gZjnmgwnXDwWNWYc+26iVqR/rxadZ7Rrpu51JuJut8=;
	t=1781072552; x=1782282152; b=GHHyWC5MD0WVrWiKofqSnbM2ejDdYqNFV0S2HkL2t89+0YW
	V9Bg9yOVMTdrEqP/wF3UqimOSbw9I0q5fTgDWiOk6R1clQg4IPO4zHllhBORlMaMGAaRzQ+d6fyGp
	55bW0GlbbJ/pZfPjO+khu8kfA39t1O93p89Fsl97SUkpFVmGqk000UoRhS/t8VpFL195G7mQbjN8a
	E/6eCu/mchjn6z2Pi3RoNO9W/LmghghvxFbU/Qqrp1SNNR+6Ygw8fXKQ5SQkTh4tp8d3f4Pl/Ybn/
	epUvGylOjZQhbSzsyqHESglbLA2Um8NKqV+E5BRCPtZIHntOLoZ0Z5xiePj6zylw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wXCKb-00000007lxp-2LLK;
	Wed, 10 Jun 2026 08:22:29 +0200
Message-ID: <a0193a0795f63d10a52797574f408cb70c23d6b6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 06/31] wifi: mm81x: add core.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge
	 <arien.judge@morsemicro.com>, ayman.grais@morsemicro.com, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2026 08:22:28 +0200
In-Reply-To: <iqcuzdgftpv2zymapftokqycuvqoelef6zbhm2eufki3345mqw@rut3iurehpet> (sfid-20260610_070621_101494_9681DE38)
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
	 <20260430045615.334669-7-lachlan.hodges@morsemicro.com>
	 <f6dbd068437564e18695b1ef263ebba27ad7fab0.camel@sipsolutions.net>
	 <iqcuzdgftpv2zymapftokqycuvqoelef6zbhm2eufki3345mqw@rut3iurehpet>
	 (sfid-20260610_070621_101494_9681DE38)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37617-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C51D666418

On Wed, 2026-06-10 at 15:06 +1000, Lachlan Hodges wrote:
> On Thu, Jun 04, 2026 at 01:40:09PM +0200, Johannes Berg wrote:
> > On Thu, 2026-04-30 at 14:55 +1000, Lachlan Hodges wrote:
> > >=20
> > > +#define KHZ_TO_HZ(x) ((x) * 1000)
> > > +#define KHZ100_TO_MHZ(x) ((x) / 10)
> > > +#define KHZ100_TO_KHZ(freq) ((freq) * 100)
> > > +#define KHZ100_TO_HZ(freq) ((freq) * 100000)
> >=20
> > Maybe not right now, but at least the first one seems fairly generic an=
d
> > could be elsewhere.
>=20
> There is a function:
>=20
> static int mm81x_tx_h_get_prim_bw(struct cfg80211_chan_def *chandef)
> {
> 	return chandef->s1g_primary_2mhz ? 2 : 1;
> }
>=20
> which should definitely be in the cfg80211 since its a generic chandef
> helper and will probably be needed at somepoint in mac/cfg in the future.
> I can probably just have it as a patch prior similar to the SDIO id
> as part of v3. Then I guess I can also do the same for the helpers above
> and place them alongside:
>=20
> /* convert frequencies */
> #define MHZ_TO_KHZ(freq) ((freq) * 1000)
> #define KHZ_TO_MHZ(freq) ((freq) / 1000)
> #define PR_KHZ(f) KHZ_TO_MHZ(f), f % 1000
> #define KHZ_F "%d.%03d"
>=20
> Unless you have some other preference :)
>=20

That seems reasonable.

I guess eventually a case could be made for moving a bunch of things to
units.h, but it seems to just define the numbers not macros to convert.

Or maybe that means we should open-code, instead of MHZ_TO_KHZ(v) we
could have "v * KHZ_PER_MHZ", which is really just one character longer
anyway (though might need extra parentheses)?

Anyway no strong feelings about any of that, not really even in the
driver though that seems a bit odd (hence my comment.)

johannes

