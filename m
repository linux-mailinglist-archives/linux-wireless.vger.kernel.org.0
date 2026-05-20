Return-Path: <linux-wireless+bounces-36686-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAZZOw1nDWquwgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36686-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 09:47:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B158920B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 09:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7AD2300C91B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15136DA15;
	Wed, 20 May 2026 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qlQKwrEV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A621A453;
	Wed, 20 May 2026 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262969; cv=none; b=AqnDHdJmRUxayDdXWzRZqfqV5/s4FODx0pfLjdlcpW19X24U/3MGiRf8jNuQONhfHb7gN+dpHSjh8d1sA58AJMkITHSElf8mqIc1WoASdrOthyAS/oubJnC5rnDs1T9QQWdcFzvoO4Wn+4BDcfCuXN99YamoGQDh8xjOSIR89+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262969; c=relaxed/simple;
	bh=K178Z+0C5nLDLTbzw9jt49UufgSin1MFtXEHJ1ULaiQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqX1FIrgFD/jmOUBvtXYCCOKtxdDXaiJUe4M2DRWEy2lMJHTRq6HnCObIoQvC2hHXwUbpZDaSGVbyrNyS3hNBqwtaQdNnYpDW8Lh/MVwLic94OqVDjpDTv4EYNtjcQzeNkrM2tgz+vLiQJQQkUqktFZlCr9M6cokHnnA/E7trek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qlQKwrEV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K178Z+0C5nLDLTbzw9jt49UufgSin1MFtXEHJ1ULaiQ=;
	t=1779262966; x=1780472566; b=qlQKwrEVwui7s3XrNavkQRvmbm0ZvgCuQQwov8b9i0+47WT
	TnZ4Hu797wwTYvlxmnvtz+/kJDW5ut+y61+AwOFUpmPv424YoCzLSxofOUs2pRVx5HNymcBSjPJtf
	NyUf07QeBCsGZgXHur/Xiv2CyM4AZcgoxpo4yupkaXTDecAxyn0EsACSNUalI6u1ZUMc/9p9ZQDD5
	zoYrxk5sHzHDJLf23XkHu8rVplHwBlopmZpCP2TT86QSblU+gLpOa31gvzdwpkBtr9QuAkzlg3aHE
	+iy7L9xTQIPBW9ETBg1qzyiv7iUT+WM6gYdJwyYxLbwvNInDyv7IEbJ3qmpgn9Lw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPbZe-00000009mp7-1Pxk;
	Wed, 20 May 2026 09:42:38 +0200
Message-ID: <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?=D3scar?= Alfonso =?ISO-8859-1?Q?D=EDaz?=
	 <oscar.alfonso.diaz@gmail.com>, Devin Wittmayer <lucid_duck@justthetip.ca>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 	fjhhz1997@gmail.com, Brite
 <brite.airgeddon@gmail.com>
Date: Wed, 20 May 2026 09:42:37 +0200
In-Reply-To: <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com> (sfid-20260520_084943_360396_7470D3C8)
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-1-lucid_duck@justthetip.ca>
	 <20260519235713.49109-2-lucid_duck@justthetip.ca>
	 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
	 (sfid-20260520_084943_360396_7470D3C8)
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
	TAGGED_FROM(0.00)[bounces-36686-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[gmail.com,justthetip.ca];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,gmail.com];
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
X-Rspamd-Queue-Id: 547B158920B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-20 at 08:49 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> Let me know if any testing of a concrete patch is needed when you feel
> it is completely fixed.

I guess Devin is saying it's fixed, and I'm saying it's the same as mine
so can't be really fixed unless something else happened in the kernel.

Do you recall which kernel version you tested with? (I don't.) Perhaps
something else in the kernel changed and it's now OK to make this
change, but we know it wasn't working when you tested before, and I'd
rather have it not work than crash.

johannes

