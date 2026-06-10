Return-Path: <linux-wireless+bounces-37625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id caG/NTZAKWoaTAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 12:45:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F32E668688
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 12:45:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=HYz7wt4v;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37625-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37625-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26BC0322F36F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D63E2765;
	Wed, 10 Jun 2026 10:40:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699B3EFFAD
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 10:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088048; cv=none; b=i55dDU/Q1SG4yRKrKJYIyfn1WQmGfWq/c5eHyOFlbfENmWsB/MW+dDVt7solDxB7V771jis8mAqM/04bQADJ8AjqSEtvhuWz1Oj1GfOkC9sTFbnucr4EXTs51IhttLOj/pI4vpZ6nl5y0en29qog/ZPSVC6katC9LpYOa/RInTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088048; c=relaxed/simple;
	bh=5e7bW+Y0CjTqz+g7aKHz9HlVkCcWS3YMxS1rTmtWzS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ulb1uSnA//sZjeDZHP2WkQunRQQ4sJ3uLPqClEjTdq229RO7Texm6VbcNxlHBHqhO2NlskcfxmAxUudwXuG1pQHJwFw0vR9bzoo9InnfblAWXGpIBqJTt90eVFQKVnsG6PBU7pi948jSqvZVnldSO27UyIrE/0noxq5kiADfQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HYz7wt4v; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hGxZJjqUSM+cCMiYJPCLks95WMObgDOYKtdcr0R5aaI=;
	t=1781088047; x=1782297647; b=HYz7wt4vCCI+aNVKt93Mx2MqO5O1VgzCJv0P/Lbf6vrAyZ8
	64SdmrQKKa/mAYu14xT4btn0sW1wLrNx62lwbVbzoBVCKGZtpNpRkVig42Dr5NlbPGmGKT0VbweF7
	GbapwYT+b4g5mF5g7SifJ58hQqj28n6Oy/HYD7S73W2KM28zgMYorOlmNUkQxhxv/HPKkS1S0j9eh
	kF7SSH1Kt1t/HAt33EpdnKf29jDCbTwEI2DxTqVkZ83Pn3qPZpEJLf0LQ2gJcbIKcIgEyLS+bBZ/i
	5kxbm9PcWXJDh6S26PuRSUlnf3AdhcoGgnXHX/Ux+OUbcvxLkDXXsB4En8ldcW5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wXGMT-00000007tKz-47kZ;
	Wed, 10 Jun 2026 12:40:42 +0200
Message-ID: <9ad7cb4143a5d73b69eb98849921cf1c72f392e4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 4/5] wifi: cfg80211: Fragment per-link
 station stats in nl80211_dump_station()
From: Johannes Berg <johannes@sipsolutions.net>
To: Praneesh P <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Wed, 10 Jun 2026 12:40:40 +0200
In-Reply-To: <19098782-24e9-4707-8207-6244371a904f@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
	 <20260607175912.2266215-5-praneesh.p@oss.qualcomm.com>
	 <88c183f827eb184e6d471964662b7ee89caf63ad.camel@sipsolutions.net>
	 <19098782-24e9-4707-8207-6244371a904f@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praneesh.p@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37625-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F32E668688

On Tue, 2026-06-09 at 00:31 +0530, Praneesh P wrote:
>=20
> > That seems really odd? why even bother going into the whole thing if
> > it's invalid? Also, doesn't that ENOENT get propagated all the way and
> > it aborts? I guess it does but it should never happen because of
> > valid_links? Still seems a bit odd.
> Both the link_sinfo null check and is_valid_ether_addr() check
> will be moved to the top of the function, before any header or
> nest construction. The null check for sinfo->links[link_idx] is
> already guarded upstream by the valid_links bitmask so it should
> never be NULL in practice, I'll add a WARN_ON_ONCE and skip rather
> than returning -ENOENT, which would otherwise abort the entire dump.
> Will it be okay ?

I guess? Anyway the structure will change based on our other discussion
below.

> ok, I will try to align with this suggested model. I'll refactor so the=
=20
> outer loop
> produces exactly one netlink message per iteration, with header
> construction in one place:
>=20
> while (true) {
>  =C2=A0 =C2=A0 if (ctx->phase =3D=3D PHASE_AGGREGATED) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fetch sinfo from driver once per station =
*/
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&ctx->sinfo, ...);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* allocate links[], call rdev_dump_station(=
) */
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* apply cfg80211_sta_set_mld_sinfo() if nee=
ded */
>  =C2=A0 =C2=A0 }
>=20
>  =C2=A0 =C2=A0 hdr =3D nl80211hdr_put(msg, ...);
>  =C2=A0 =C2=A0 /* common attrs: ifindex, wdev, mac, generation */
>  =C2=A0 =C2=A0 nla_put_u32(msg, NL80211_ATTR_IFINDEX, ...);
>  =C2=A0 =C2=A0 nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, ...);
>  =C2=A0 =C2=A0 nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, ctx->mac_addr);
>  =C2=A0 =C2=A0 nla_put_u32(msg, NL80211_ATTR_GENERATION, ...);
>=20
>  =C2=A0 =C2=A0 switch (ctx->phase) {
>  =C2=A0 =C2=A0 case PHASE_AGGREGATED:
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 nl80211_put_sta_info_common(msg, rdev, &ctx-=
>sinfo);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx->phase =3D PHASE_PER_LINK;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx->link_idx =3D first_valid_link();
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>  =C2=A0 =C2=A0 case PHASE_PER_LINK:
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 nl80211_put_link_station(msg, rdev, &ctx->si=
nfo, ctx->link_idx);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 advance ctx->link_idx to next valid link;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (no more links) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg80211_sinfo_release_content=
(&ctx->sinfo);
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx->sta_idx++;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx->phase =3D PHASE_AGGREGATE=
D;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>  =C2=A0 =C2=A0 }
>=20
>  =C2=A0 =C2=A0 genlmsg_end(msg, hdr);=C2=A0 =C2=A0/* or genlmsg_cancel() =
on EMSGSIZE=20
> break-out */
> }
>=20
>=20
> This eliminates the duplicated nla_put_u32/u64/MAC header blocks
> that currently exist in both nl80211_send_accumulated_station()
> and nl80211_send_link_station(), and makes the EMSGSIZE bail-out
> uniform since we return before committing the message.

Sounds good!

> should the rdev_dump_station() / sinfo fill stay outside the
> per-message loop (as a separate if (phase =3D=3D AGGREGATED) guard
> at the top), or is it preferable to fold it into the switch
> case? I've sketched the former above since fetching sinfo is
> logically per-station, not per-message. I'm also ok to adjust
> if you'd prefer it inside the switch ?

I think it has to stay above otherwise you can't unify pushing the MAC
address to the message? And then perhaps you could even unify the nest
push (i.e. NL80211_ATTR_STA_INFO nest start), but I'm not sure how that
interacts with other code and it's not really important. The header is
more important since it could change in the future.

johannes

