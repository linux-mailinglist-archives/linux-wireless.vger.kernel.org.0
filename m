Return-Path: <linux-wireless+bounces-38749-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qQIDJSDpTGrSrwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38749-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 13:55:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C1971B222
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 13:55:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=dN0PGSmL;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38749-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38749-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E01D3002D3D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2663F8247;
	Tue,  7 Jul 2026 11:54:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8D36492C;
	Tue,  7 Jul 2026 11:54:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425242; cv=none; b=vF88udABtafqOeoGgc8gaKXe9PAUdi/FTdDZNfQlXfX8tVi5JwnEXFoNhBJBpAr7PgrlO9ws/Um+/6P/7CRII0flo9j+foZvMZZFUl8hivK0hFrosaxh8C7zrpWYeAiOyVeM4KOCV2TA4ggdIWoj/5ieccz4nkGLvd/dJL8PLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425242; c=relaxed/simple;
	bh=UQG5tqqR/SxCXiYIVw9rXYRTneBRCFBjtBbXNLE8DK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PggNL9yQLTapTV5b/jl3Cx/gYqAUUjmBG2QY5ppnkSATfSrNIxBqAzV3cc8eAG6xXss+TzrAD3VFnt8ilekmOWu+f3bKurniVzptT0dT/UcnQ4Ehn+eCrBUysri3YYWd+CCuaar2pL31Q/S8PT2FZlpKl2YD/1XpYOJd+tBzr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dN0PGSmL; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UQG5tqqR/SxCXiYIVw9rXYRTneBRCFBjtBbXNLE8DK0=;
	t=1783425240; x=1784634840; b=dN0PGSmL5G46yM5LsPZuje4S1giu1x+yoq6Ikty3eAXYgSf
	5PW3j057lJfJ7VgFlAEym1eDHCZtDJvoEbjkt3flIc6FaQpW/ULfjs5B0dY+74QOPriZfX/gmXO1q
	0pxEtnaijyZf7u+Gp06w9lUZftvnN+iRNEcYtTHvXBSZviaafKKhhVvoHjlM5k4KKR4pmFqSlqloN
	nqfp1/4ftjDRM8in9LIEzwk4dzMFgkKWOIDr+d76EAERjg3XghDjkOFrTgq00HnrXCmhmRX9pKjPX
	sCRa2QpWM7J2ol/vSbJBUq+fOemobPXpqUBYuP3iD3qv77tmvYvsiWsw/w/1jDMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wh4N5-0000000HZMV-3sN0;
	Tue, 07 Jul 2026 13:53:52 +0200
Message-ID: <6fbaefdeba935d0adaed1992037d0f746b9821fb.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: brcmfmac: cyw: fix heap overflow on a short
 auth frame
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Maoyi Xie
	 <maoyixie.tju@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Date: Tue, 07 Jul 2026 13:53:51 +0200
In-Reply-To: <996adbdb-9531-49e1-8cae-5fcb7b914d19@broadcom.com>
References: <20260707063155.3099999-1-maoyixie.tju@gmail.com>
	 <77dfa2f3-296f-470b-8d21-0f10a56a2a4a@broadcom.com>
	 <996adbdb-9531-49e1-8cae-5fcb7b914d19@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:maoyixie.tju@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38749-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0C1971B222

On Tue, 2026-07-07 at 13:40 +0200, Arend van Spriel wrote:
>=20
> Actually v1 was already applied to the wireless tree.

Yeah, I thought the Link: was fine - I (only) add links to the patch
submission itself for tracking (Linus isn't super happy about accepts it
now), but the link given was to a report/further discussion, so that
seemed OK.

johannes

