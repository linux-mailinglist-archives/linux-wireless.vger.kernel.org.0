Return-Path: <linux-wireless+bounces-31518-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDo5NWEGg2lLgwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31518-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 09:42:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA849E3469
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 09:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DB01304E83C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCE393DF2;
	Wed,  4 Feb 2026 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ob9A4Mov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFA1D63F0;
	Wed,  4 Feb 2026 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194200; cv=none; b=ZSu9ba/UrJR7/uxszku6wc+uSaj//YbNJe7tSotpvTMitlTuomn8+K2SzsH9m15quGXtad//Qf3O2eu7f0i3W8L/HM9IL1PJiM3pVDGmwBZfv8vpWhpOJ1E8YdGcI5KwRYI5qiLuQHxAWN1aHVz+0IVR4XHa34mCCU4RO23RvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194200; c=relaxed/simple;
	bh=bO4tIM5TTvyUWbeV4PrVZX6fnl3M+hk0K0pfu1y11OM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbuqEAvsU5g0uyeS2ZBqHp/t5KAGHf50GvD1PWMxAuJe8cvSc6OmCtT4ol/OQQltJJ59izHYJFQ/M9ckJ46zkjeP02Nns/3WMsFPCl7dPlrdtXounK6qW1qXs62lfYHgQ0yK4JGN+VWxEz6Zax6vfJ2uoXVFmIbqpdM09QqCt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ob9A4Mov; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zFc4t2YP9piAbEtpMrzMAQaYd6CbnAPfpaHLU9/xw3M=;
	t=1770194200; x=1771403800; b=Ob9A4MovSDiJf9YCH5AOBUmCd9mRp6RkMi6Qk/zMxens8YY
	xqeohhpCRT0/KKYbp5FDIcTL+duCMKnAQsF9z9/JQ3S2h8/H8TOVXEdTiDDqGW6RjynZB4lmmqsoT
	s/s/0a/ZRL3pdusIcI/YU58eEn0xt31gggSNeCVZ+NM4EpvorMMSgfyYWfnz74rngY9YKMZZpUr8D
	2WKOWePdIaS69/BGi4PojbjKHabfL8X26p3NiOLGG1aXIfVScMX98mwjvfyo3dbHGlBqq2k6VMRPJ
	pe2QZclbhiFodAR+wk9hQ9s/4Q/a9a+ZQMCm1qjplSs51AsH2+aAsY0OuRFLUAUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnYND-0000000EBiF-47P4;
	Wed, 04 Feb 2026 09:36:32 +0100
Message-ID: <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
From: Johannes Berg <johannes@sipsolutions.net>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2026 09:36:29 +0100
In-Reply-To: <20260204081821.730673-1-sun.jian.kdev@gmail.com> (sfid-20260204_091842_124304_F2AC914A)
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
	 (sfid-20260204_091842_124304_F2AC914A)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31518-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA849E3469
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 16:18 +0800, Sun Jian wrote:
> band is derived from nla_type() of a nested netlink attribute, which is
> a masked u16 value and therefore cannot be negative. Drop the dead
> "band < 0" checks and keep the upper bound validation.

I've seen this before, but I'm not really convinced it is entirely
correct. C says:

   All enumerations have an underlying type. The underlying type can be
   explicitly specified using an enum type specifier and is its fixed
   underlying type. If it is not explicitly specified, the underlying
   type is the enumeration=E2=80=99s compatible type, which is either char =
or a
   standard or extended signed or unsigned integer type.

It would thus _seem_ to be possible for an enum to generally be a signed
type, and therefore a 'signed short', and therefore an nla_type() that's
a u16 could end up with a negative value...

Am I wrong?

johannes

