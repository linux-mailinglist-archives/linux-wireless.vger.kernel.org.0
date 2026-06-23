Return-Path: <linux-wireless+bounces-38010-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZJzmFRmDOmrU+gcAu9opvQ
	(envelope-from <linux-wireless+bounces-38010-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:59:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE556B744B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:59:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38010-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38010-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E88130A0C62
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048FE23A9BD;
	Tue, 23 Jun 2026 12:58:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CE2475CF;
	Tue, 23 Jun 2026 12:58:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219501; cv=none; b=aZQlQbrKdP3oIK9W8b263ZeASnsvN4nIy/qsNmPgFCJqDWk9/LVImFA1VlHIrTZQuqN6uY0BJUBfajE2q7fPETn+ZrY0NIwq4F0bq6C7uvnklOjY8McVj4fjdaZLpxcHvKAddjdGiZY/rxv/wMvJY4rzjzJQHYdWQhtrTa+n1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219501; c=relaxed/simple;
	bh=pK4Q9YJv3ZwX9pxCMd8QUz9TNHTZr/RDJ40f11iJ9XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KetyC6TBPqk3sOKFNveQFCObQFRlGkhL4xSIAvrS8+lldkS2sCqVCAcUP/ECoaFsknOoV2maRb87+fLA3dvWCvVfAnSuNm8+ymVE+SsInAHqLNNGBhrzsufYsrXBCrMMqzovOMYc+EBbWFZjUP88X7+WrmZEiQT4fbljUPuizCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 ath-next] wifi: ath9k: mark static arrays as const
In-Reply-To: <CAKxU2N-bku8uZJ2nqtXb5nMhaPpxYnHqefNBj=WWe6HeKRaBXA@mail.gmail.com>
References: <20260619175210.5348-1-rosenp@gmail.com>
 <87se6eeqwn.fsf@toke.dk>
 <CAKxU2N-bku8uZJ2nqtXb5nMhaPpxYnHqefNBj=WWe6HeKRaBXA@mail.gmail.com>
Date: Tue, 23 Jun 2026 14:58:10 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871pdxe7ml.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.69 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38010-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,toke.dk:email,toke.dk:mid,toke.dk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAE556B744B

Rosen Penev <rosenp@gmail.com> writes:

> On Mon, Jun 22, 2026 at 4:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@toke.dk> wrote:
>>
>> Rosen Penev <rosenp@gmail.com> writes:
>>
>> > PN9Data is a read-only lookup table and is never modified.  Adding con=
st
>> > lets the compiler place it in .rodata and prevents accidental writes.
>> >
>> > Use the same treatment for bits_per_symbol. It's not modified either.
>> >
>> > Assisted-by: opencode:big-pickle
>> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> Again, which actual bug are you fixing here?
> Patches are required to be bugfixes?

Well, or at least have some concrete benefit? You're changing working
code here, we've had to revert patches of this kind before because it
broke things.

For this patch specifically, there's one of two cases:

- The array is never written to, in which case the patch has no
  practical effect

or

- The array *is* actually written to somewhere, in which case the kernel
  will now crash as soon as someone tries to run the code.

Either way, I don't see how the risk/benefit tradeoff comes off positive
for this patch?

-Toke

