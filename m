Return-Path: <linux-wireless+bounces-36134-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAC0C6f7/mlW0wAAu9opvQ
	(envelope-from <linux-wireless+bounces-36134-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 11:17:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74AB4FEF70
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 11:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F41B6300679A
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71E1FECAB;
	Sat,  9 May 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FSvBxDMj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86318EFD1
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318243; cv=none; b=f3LehMfmqMQiWcfY4rsnjOECJcf/jbaRRj3iL0qTwu+ZRFOKUCEG7VArgcnioIi94ERero13u7QTzMZgTSmzqBws6lLRf8M5kzFvJ5bkc548qu3VxV+pwmdsk4Nrd9fZYKaVyUG3vBuDBvjBcc5GCVAMGKwDBAHxE85xzB+HqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318243; c=relaxed/simple;
	bh=T6MVhYtFeOr3eNNZasT58f6aaudbyenuiHAAJM1InBA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRXZMNZJTM4NQ5mU4i5d5SNVeEs8aV8xAgj2Op8p0I85RotMb554wiz862/qPqSOfyfeP7oxOIsvGJvOOy6cwJ9gzwMpRKfmp28DQagITZbLFM/Kr/2G+7GRuzBk2tRF4Jgfx0RxCxshEpm9gAuB0mAYTR4gxIUi/dzCgaUpv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FSvBxDMj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mxOD7ZYzvGXJIa7M6XOxZ9jj1YNFwwtB8UwJWUbmNUg=;
	t=1778318240; x=1779527840; b=FSvBxDMjXn4ZS8LSJry0DGtky2pb0H/TT3jqYuDewqeoe6R
	am8L03nh6NGSB7Fn7oVRdKpbKX76Em5VMPiIkcy1eeTXcD4WNyrkcuQ0IxDH91ZzK9tpB/ZwnScjG
	N0g9tXLy76BSk2B7XamQiEHPDCSyJ480BaPBwloomUy+SvjfAc9rR+SGF1s8ED6sh5+mnF457CPS2
	/u1nrNVK40GEqHboa2Gl2csolQKrp0vL8VxaziBvN8Xd4e/9p4Xcs2HeoOT1l2CzkV3rc3kHwV+yn
	s301ioUD51yefH0ATAmvpsOzY6nHNO5aRjXznlqhKAPxlkXPmkVtZLDrWN+a4ijA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wLdo7-000000096yg-0K84;
	Sat, 09 May 2026 11:17:11 +0200
Message-ID: <db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] Fix overread in PREQ frame processing
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Date: Sat, 09 May 2026 11:17:10 +0200
In-Reply-To: <20260508225905.29998-1-masashi.honma@gmail.com>
References: 
	<8f0a2488540f4a65ea4d837a06225a27a10cc305.camel@sipsolutions.net>
	 <20260508225905.29998-1-masashi.honma@gmail.com>
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
X-Rspamd-Queue-Id: C74AB4FEF70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36134-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Action: no action

On Sat, 2026-05-09 at 07:59 +0900, Masashi Honma wrote:
> =20
> +/* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
> +u8 mesh_path_parse_request_frame(const u8 *pos, u8 elen)
> +{
> +	u8 target_count;
> +	u8 expected_len;
> +
> +	target_count =3D PREQ_IE_TARGET_COUNT(pos);
> +	if (unlikely(target_count < 1 || target_count > 20))
> +		return IEEE80211_PARSE_ERR_UNEXPECTED_ELEM;

not sure the likely/unlikely really is worth anything there - we don't
process *that* many frames.

> +
> +	expected_len =3D 1 /* Flags */ + 1 /* Hop Count */ + 1 /* Element TTL *=
/ +
> +		       4 /* Path Discovery ID */ +
> +		       6 /* Originator Mesh STA Address */ +
> +		       4 /* Originator HWMP Sequence Number */ +
> +		       (AE_F_SET(pos) ? 6 : 0) /* Originator External Address */ +
> +		       4 /* Lifetime */ + 4 /* Metric */ + 1 + /* Target Count */ +
> +		       target_count * (1 /* Per Target Flags */ +
> +		       6 /* Target Address */ + 4 /* Target HWMP Sequence Number */);
> +	if (unlikely(elen !=3D expected_len))
> +		return IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;

I think there's a case to be made for doing this like many others, in an
inline in ieee80211-mesh.h, and calling it ..._size_ok() with a bool
return.

> +++ b/net/mac80211/parse.c
> @@ -547,8 +547,11 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_=
parse_params *params,
>  				elems->awake_window =3D (void *)pos;
>  			break;
>  		case WLAN_EID_PREQ:
> -			elems->preq =3D pos;
> -			elems->preq_len =3D elen;
> +			elem_parse_failed =3D mesh_path_parse_request_frame(pos, elen);
> +			if (likely(!elem_parse_failed)) {

that would also fix the build issue here if mesh isn't compiled in.

(and also here, not sure about likely/unlikely, doesn't really seem
worth it, and under attack maybe the failure becomes likely?)

johannes

