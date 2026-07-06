Return-Path: <linux-wireless+bounces-38675-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d7TkBrKTS2pYVwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38675-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:38:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A640370FF40
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=n2W8N7GC;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38675-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38675-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DF23300B1EB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D303F9A0E;
	Mon,  6 Jul 2026 11:38:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8241D4F9;
	Mon,  6 Jul 2026 11:38:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337901; cv=none; b=U2gNMcP2xFI3CkVO2OJI2e2zwAB4Wa/nz9lkAfK42hXzNWhyCVOHsRnxRxu9pyvWDbL+qk05IEwcpqh+O56J6nfo8PGxg5rp9SYkzuc341gIuU72XB4xa4Tuz381U8z23t5A3XLPMtHBXDVB/6GvCPQyVsanWz2WERfQ7oJB+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337901; c=relaxed/simple;
	bh=YD/PfIkg7d1y75W7QSsj27iMVEP16aYBeUafAwZZ0zM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAZLT5Y21hjwTCa/oKLhdx8yilPyDdbezGPpLCaQbB+IYRbyLVcENdSIZlgABFl6puw2UvwTUvIhBeoVewQpZZnqiFWIbinHLiwWISbKCfpsdshszxXNAGOpdRaAWLwmdyQAMkwwBsKmPo3wtIjGBwR//e0NGIU7VApQwMm+vAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n2W8N7GC; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YD/PfIkg7d1y75W7QSsj27iMVEP16aYBeUafAwZZ0zM=;
	t=1783337899; x=1784547499; b=n2W8N7GCts3txWbThQjf2I7tVH8w6ukR+j7Fa5614BuNJYN
	NFMZdihc+B8b2ELBr0wPV9dzNrwxnUFCIkcjNs0vjOQox+tsRZp77hCtbOpWkqZXaax8jZ3fCTisP
	3bjU8PiRk2wVHHx3S0KcM49T9Bo76bvJ49+WtVm9vs/6XohKs9/XDQOZS497BeLHTgGZO38/LuOTq
	uOCv0gmfmJM2kPkmId/bEm3A0PVKZF68bh6P1m7QyBN2tYJ2RokvU4S3hvGf/OaL4NMDYg+8W3NfC
	kCOngqc1DppO1xn9MF/18UxzSZjkhLYVe7HUs/oNHBC0t//mv8hvPYwi53XswoAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wgheS-0000000DLoP-1u4d;
	Mon, 06 Jul 2026 13:38:16 +0200
Message-ID: <ab97c01b73b96bf36527007e19743d3bb5a07634.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: remove radios from rhashtable
 before freeing
From: Johannes Berg <johannes@sipsolutions.net>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Date: Mon, 06 Jul 2026 13:38:15 +0200
In-Reply-To: <20260619162419.3874564-1-zzzccc427@gmail.com> (sfid-20260619_182429_647709_7678E401)
References: <20260619162419.3874564-1-zzzccc427@gmail.com>
	 (sfid-20260619_182429_647709_7678E401)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zzzccc427@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38675-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A640370FF40

On Sat, 2026-06-20 at 00:24 +0800, Cen Zhang wrote:
> mac80211_hwsim_new_radio() publishes each registered radio on the
> hwsim_radios list and in hwsim_radios_rht. The generic-netlink and
> virtio command paths use the rhashtable to find radios by address.
>=20
> Most radio removal paths remove the hash entry while holding
> hwsim_radio_lock before unregistering and freeing the radio. However,
> mac80211_hwsim_free() only removes the list entry. During init error
> unwinding after hwsim netlink and virtio registration, this can leave a
> freed radio reachable from hwsim_radios_rht until the callback surfaces
> are unpublished and the rhashtable is destroyed.

How does the init even fail? I think this is fairly contrived,
especially in a test tool. The whole thing is maybe worth a cleanup, but
the whole scary commit message is nonsense.

johannes

