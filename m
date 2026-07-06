Return-Path: <linux-wireless+bounces-38678-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /0/YAkqvS2r8YQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38678-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:36:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA41711584
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:36:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=G14XW8Sg;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38678-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38678-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2349A30247E7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A32F83A2;
	Mon,  6 Jul 2026 11:45:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BEB27EFE9
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 11:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338358; cv=none; b=XVIWcudIEaJYiZHNP03EXmQgwgLtk56OCGw5Rwt6QDty+08CeGBbwUvWbsCT2ygrMmD/Pfv4cIeCXuis6k8iMUbGpHTGdE/MPniHZrLr5DXfNCnf0uS9+81lgfMmNYehECZNBHZzFBiDJmubnrRGohZ9LCk526NCuWVv2vrr5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338358; c=relaxed/simple;
	bh=vKfEcO7AqTf31f5HWzZI5dsNdrrcDTP1akoBKWid5mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iTt1mvFcuVUMJjrtIlGTK6r6LWLlY6FpXUK3ZxIteDqIBbV5PakbFkCWsHr/wh7J+h44bE/5tbb2nK6r8YnrieIi754U4vwdGc4LELyskDXbq8xHaTdwmWMcXCLyKAiaJ62CjlhUC7R9oVkbfiQ4e+O6dN25n2GgwzSlWPHRYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G14XW8Sg; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vKfEcO7AqTf31f5HWzZI5dsNdrrcDTP1akoBKWid5mk=;
	t=1783338357; x=1784547957; b=G14XW8SgI24q945G/E+MxlcZdqP/qvyNjhym4r/Cm4po9mS
	IRWDaJyvopE+U40THtDwI1gl4Qxb1Fz2nIR2hCDBo36Vnmb4ZyYfprNcz6a9Z/MEWAk0ZxV7f7oQO
	X55aOMnPVuh8eW/jxClK3Lazw5SVNQjwASf7D8mTyMBaGRAJyXZ93vcNUzBqdM/s+pOek2RccwJEV
	3LD9QE1chU7ck3nCLsUDGNTlWhFgGgmy8vGfJTClUvM0NkjjocajH3dGFFQ4zVMZ+awATSW6P0RGj
	5XMJqinQELjnvBK+bz3nVMYoQE6LSc6FSlaQF9E1KD/8WFDf9wTduSmBq4MgeYOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wghlq-0000000DNb4-273m;
	Mon, 06 Jul 2026 13:45:54 +0200
Message-ID: <c48d02d04101e50ece0feab60fb04f63aef37140.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 00/33] wifi: mm81x: add mm81x driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: arien.judge@morsemicro.com, dan.callaghan@morsemicro.com, 
	ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, Andrew Pope	
 <andrew.pope@morsemicro.com>, Bassem Dawood <bassem@morsemicro.com>, Chetan
 Mistry <chetan.mistry@morsemicro.com>, James Herbert
 <james.herbert@morsemicro.com>, Sahand Maleki
 <sahand.maleki@morsemicro.com>, Simon Wadsworth <simon@morsemicro.com>
Date: Mon, 06 Jul 2026 13:45:49 +0200
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com> (sfid-20260626_083032_515938_B5135BBF)
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
	 (sfid-20260626_083032_515938_B5135BBF)
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
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:andrew.pope@morsemicro.com,m:bassem@morsemicro.com,m:chetan.mistry@morsemicro.com,m:james.herbert@morsemicro.com,m:sahand.maleki@morsemicro.com,m:simon@morsemicro.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38678-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CA41711584

On Fri, 2026-06-26 at 16:28 +1000, Lachlan Hodges wrote:
> This series adds the first Wi-Fi HaLow driver to support the Morse
> Micro mm81x chip family via USB and SDIO.

I've applied the cfg80211 patches in this set, please send a pull
request for the actual driver.

johannes

