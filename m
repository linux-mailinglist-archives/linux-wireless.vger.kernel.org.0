Return-Path: <linux-wireless+bounces-38289-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xiwCMuVBQmp62wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38289-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:59:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA56D88B5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:59:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38289-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38289-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2007A303BDD6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0D3FDBE0;
	Mon, 29 Jun 2026 09:49:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9983FD956;
	Mon, 29 Jun 2026 09:49:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726587; cv=none; b=TW/2XAWTu2ibcQ9OK3tvdSo+EXAdiEuDHTUXM1he4xCGP8ZQSQfPe2KRPm+KeufsRePc3wrd5l8xziqPtCeYrfqMJtcwefB0GRAPsrxy1dhRRPmiBWDbYkMvDVfY7V/BQbjwTnUKCL82u3s8XMRnRqoqm0eWUvQvwHvK60OAANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726587; c=relaxed/simple;
	bh=GDTUeQYrdE/sl9WnmXD3+R0/rR1NPFXxllgOKcI8bJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcaEqZsus3+CMCXTTvpYd0IhzsBJUCnNYkuj6En3EXBY6v4yoQyDSH3P/l9gy0sx8v+HlR7hnNOWYKRWDZcY1s3T8b7DAnL+tHLEEKXrvpVt1IOB0gumTp1G9EyVLBvXMFipnIl1F2TgSxFTQelK09lk2x7jMy2j8oCB6IE1iLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com, Yousef Alhouseen
 <alhouseenyousef@gmail.com>
Subject: Re: [PATCH] wifi: ath9k: avoid device access after async firmware
 request
In-Reply-To: <20260628001350.20997-1-alhouseenyousef@gmail.com>
References: <20260628001350.20997-1-alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 11:49:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87jyrhd6c1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.31 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38289-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,cb7ed9d85261445a0201];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55BA56D88B5

Yousef Alhouseen <alhouseenyousef@gmail.com> writes:

> request_firmware_nowait() may invoke the callback before the requesting
> context resumes. When a firmware lookup fails, the callback starts the
> next fallback request. That nested request can exhaust the fallback list,
> complete fw_done, and let disconnect free hif_dev before the parent request
> returns.
>
> The parent then dereferences hif_dev only to print a successful-request
> message. Remove that post-request access so completion cannot leave an
> older callback using the freed device state.
>
> Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw versions")
> Reported-by: syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cb7ed9d85261445a0201
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

An identical patch was already submitted and is currently pending:
https://patchwork.kernel.org/project/linux-wireless/patch/20260605153210.20471-1-1020691186@qq.com/

-Toke

