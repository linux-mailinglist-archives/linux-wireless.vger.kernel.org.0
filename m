Return-Path: <linux-wireless+bounces-37898-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +7i7IN+/M2r4FgYAu9opvQ
	(envelope-from <linux-wireless+bounces-37898-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:52:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CAA69F017
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37898-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37898-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BEAC305507D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF73DF009;
	Thu, 18 Jun 2026 09:51:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9983BCD27;
	Thu, 18 Jun 2026 09:51:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776302; cv=none; b=GroSw/FSRtULfYLCfNjNCPoniqhe6P4LFr0AuWsbPhsBH78a84faaLqxbxOtxCqb9R1+jrc++bSUxJXCTXR2vQS3j7VbjqiWBsn3EOaJY/4+ATEbhHgi6Kz1mdmqyO8eRH2Bsjb8VmZ1WvOhw7v9B1MvlGKOFdmFWuGAxACgYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776302; c=relaxed/simple;
	bh=RDq7N8/SPPSk1xsmOlIg7ku3pN4vpAp3BT7KAysxT8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LX41dZCKuC2OzQiib2gLIHjXVenRXGV7iDBiXKX8KzE+CJ1leR9omJuipdExL5tPBK67kxY1gMbA0DowJnohiwVniTPMZxtgVWPC8/Qpj2DCkcqAIlGZjtrWs5nt2oHjep9L+GsG+ErxGdKrDB7KNGO0wXtni2yRDeghE64GTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH ath-next] ath9k: eeprom: alias vpdTableI onto vpdTableL
 to shrink stack frame
In-Reply-To: <20260617234105.284358-1-rosenp@gmail.com>
References: <20260617234105.284358-1-rosenp@gmail.com>
Date: Thu, 18 Jun 2026 11:51:38 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pl1ofa6t.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37898-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,toke.dk:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27CAA69F017

Rosen Penev <rosenp@gmail.com> writes:

> vpdTableL, vpdTableR, and vpdTableI are never live simultaneously.
> vpdTableL and vpdTableR are consumed during the frequency-interpolation
> step that writes vpdTableI; after the if/else they are never read
> again.  Reuse vpdTableL for the interpolated result (what was
> vpdTableI), reducing the stack frame by one 256-byte array.
>
> The read-via-write in the else branch is safe: ath9k_hw_interpolate()
> receives vpdTableL[i][j] by value as a function argument before the
> return value is written back to vpdTableL[i][j].
>
> Stack frame size change (x86_64, clang):
>   before: 0x440 (1088 B)
>   after:  0x330 (816 B)

Huh? These are static variables, how is this affecting stack usage?
I assume this is against your previous (broken) patch?

Anyway, adding this kind of aliasing to fix a problem that you
introduced by changing working code with no real benefit is not an
improvement. I'm OK with fixing actual bugs, but this is just mindless
churn...

-Toke

