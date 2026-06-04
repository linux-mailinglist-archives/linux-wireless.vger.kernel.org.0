Return-Path: <linux-wireless+bounces-37382-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8GKjAihkIWqWFgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37382-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:40:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46863F806
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 13:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="Nw1A/aRp";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37382-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37382-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD5833147131
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7903B19B4;
	Thu,  4 Jun 2026 11:32:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8CE403E96;
	Thu,  4 Jun 2026 11:32:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572754; cv=none; b=usCDSjOPle0L8hfTg5RoZ+75y0VJlansI6FTNDyP9x6tOWwHCgKgO5NX8epiX74nXutgqO3sBQP1lLAt1Iz0VJ38BdjNtXgF9kj46Fcjwa5SyaZhCnEdo7eXcBounulnPM45O3LTEMIX0pn6jf6HHxt1JLHtDgbT3MfEmlGPkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572754; c=relaxed/simple;
	bh=xgYhSIRkRCyGHcQ00YeIGdZi+nwkSmB8ruuyjumdStg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AgB5egjH0o4JWiu99jh2O+tsWLDoZAtG18usVZq18ymx+TgkcfsGPTXhZQ8L9ZhTDqBNo8jSY7lUfl6wUQ1GCqy5+cuzHQpsokMqrbyTJ7nKWDl9zWPysGRiAVMHCcpjL+KMtISKV25oHAlKxdhANNJTPAzIGMaAcdyehlsiEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nw1A/aRp; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iwSQI2qEXuEwf5G/fvDUmnFuMZLEfDqOI0sQhCWIuV0=;
	t=1780572752; x=1781782352; b=Nw1A/aRpzvrGf4NAvyKc7HURcurB9bai8fiYy6hhiTtQCgA
	UxVDq1Sndea3eqF/S4+S4KfCOaXW6GNV0jodHQl8swlqWAqgm9YDmlIgtouWAvSbm+Tk6PemWOpqE
	NtND3ZznGs5blzzPIPq/Zla1gnBV+iLdY43YXbXswYWtl2M5xwzfPQ+bnM+LVGJUyIcgWUFpF1TEL
	O4G0HxoX9qLQUHdfgM6uTrrLSAMW5LPiWrirk32je4YF8eaM3hIxJoZgog7+WFIicap1folotoEhH
	zUwO6WR5CrPeKH96pTgbY90fQsb5k50HUbDyhVLw0+XuxTPK/fUbUrl0SijAeiww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV6JJ-00000000SVz-3cDW;
	Thu, 04 Jun 2026 13:32:30 +0200
Message-ID: <d9721676a4f1f251202f7caa18e6e6cadd2420dd.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 02/31] wifi: mm81x: add command.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 13:32:29 +0200
In-Reply-To: <20260430045615.334669-3-lachlan.hodges@morsemicro.com> (sfid-20260430_065648_587462_38077D88)
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
	 <20260430045615.334669-3-lachlan.hodges@morsemicro.com>
	 (sfid-20260430_065648_587462_38077D88)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-37382-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E46863F806

On Thu, 2026-04-30 at 14:55 +1000, Lachlan Hodges wrote:
>=20
> +#define INIT_CMD_HDR(_req, _cmd, _vif_id)                              \
> +	((struct host_cmd_header){                                     \
> +		.flags =3D cpu_to_le16(0),                               \

nit: you probably don't need the zeroes
nit2: maybe you want to use tabs instead of spaces

> +	if (!cmd_q)
> +		/* No control pageset, not supported by FW */
> +		return -ENODEV;

have to say I'm not a huge fan of this style, it always flares up a
warning in my head at first "are there missing braces?" ;-)


johannes

