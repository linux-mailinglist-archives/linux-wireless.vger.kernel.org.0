Return-Path: <linux-wireless+bounces-37897-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1FPzCEDBM2oxFwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37897-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:58:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA269F0AA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:58:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37897-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37897-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 437FF30F350A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2CC3DE43B;
	Thu, 18 Jun 2026 09:50:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174F3C1F4B;
	Thu, 18 Jun 2026 09:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776220; cv=none; b=Po3fGtjKVcfQqoAfXlHNop0jIXcbMfzOJ9Rxbzsq59fAJ2/RHv9Dh6wSVVdLuLGOmc0SXAE4cAlDu1G7Mlv6iHOL/PovApOOGeUFop2/95AE+U0+hQfNTRNf6m3jLWqF8Pfu2AUyO/vTqpojGIfTGOTfQK7cnWVi24zhIBK4LRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776220; c=relaxed/simple;
	bh=iK8VcMnc28NDB0ZD2a/gWBNfGEAvYuqYOjQNVyQ/k6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KG/I0KL3R9GW/lE8WeW5VNeVpPA+rjJhQDvnnZ4AqTWT505YA2kbuDtmikF9yX3CnT2vj4upbFu7CdquVeuDjoxRjgX5xb0b81ZbcBKwGsscFlgXfHf+oqUXbbhxKSh3C7wpHSaCZ8vbI6MVNW90ddplW8ABLGue/cPBPadjR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath9k: drop static from local pdadc and
 vpdTable arrays
In-Reply-To: <20260616030828.655310-1-rosenp@gmail.com>
References: <20260616030828.655310-1-rosenp@gmail.com>
Date: Thu, 18 Jun 2026 11:50:08 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87se6kfa9b.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.30 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37897-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,toke.dk:mid,toke.dk:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95BA269F0AA

Rosen Penev <rosenp@gmail.com> writes:

> Remove the static qualifier from mutable local arrays in three EEPROM
> power-calibration functions.  These arrays are written to during normal
> operation, so static storage is both unnecessary and misleading: it
> implies sharing across calls when no such sharing is intended, and it
> makes the code subtly non-reentrant.  The sibling function in
> eeprom_9287.c already uses an automatic (stack-local) pdadcValues,
> confirming this is the correct pattern.
>
> This keeps ~1 KB of data off the static data section at the cost of
> stack usage, consistent with the rest of the driver's coding style.

As pointed out by the test robot, putting this much data on the stack is
a bad idea. Pretty sure it's static for exactly this reason in the first
place.

-Toke

