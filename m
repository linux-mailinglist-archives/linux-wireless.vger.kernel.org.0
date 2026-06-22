Return-Path: <linux-wireless+bounces-37971-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eKMBBZkXOWrUmgcAu9opvQ
	(envelope-from <linux-wireless+bounces-37971-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 13:08:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 738736AEF35
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 13:08:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P+fhj6gv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37971-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37971-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CFF3301D4FE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534737A4BC;
	Mon, 22 Jun 2026 11:07:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C3379EC1;
	Mon, 22 Jun 2026 11:07:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126470; cv=none; b=R2vXo4oQJRHtrdnmmT27gSh/ofPI/bcUMfHqX1Rkz7MCfJwYp7CUuwTn3+vXw83B4lJxKdAeJa6Av1FYR8JGkMy/Xxre8C7K6kDbf4qCpwUmoWF8maq4vqfcODRFoM+C+srCRHBmE7PkCranq/+TOrzBcQVzeNmT06YiSLqOyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126470; c=relaxed/simple;
	bh=+sUs033RCzPqgG4D0WKAQvJtW9ijh/ekE1r3w+eHkus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YyMKDVowgKx2w04a9V1/puIZyCy2rTeg4AmjZdG3syj2BDUi/NpFYNnVoLQafFdJKlZl+rr8k8IToQPAM/BOAE9g4st4mXXHJ5fj1vDCrk6ghSUZ+ADhfkgpnIA7GvsEVQBkeQm4ZMUk7qYwQsGPGy/k/5jN5YstnSHoCb35LNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+fhj6gv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324221F000E9;
	Mon, 22 Jun 2026 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782126468;
	bh=wgVMVHa2k0yY+2/n/waYjplt/Z+GwM/2A/ABlT/a+Gk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P+fhj6gv5NDqwQfr40nDoCFoUhpzVIJ9PXgrDr0Orq1OXGvPaifaOJqMs8rMqIv8j
	 4QV0TvJWYvdBGBf/IPIs5ZlLfOpILEiCJSHUSLqYTUeP2EzWffaNTy5jwhT6tUtNym
	 8o9fPL4/1oNiFX/7dcFihCb9TT4I+Odqq/LjLd+AbgXPQcEF4ssL5iOIB9DiQQuW+8
	 34YGR/nHma7q+4yCl1DuYdkr8uRJiLfu0jWeqS0gmB+fQazKMwWsdJeDvxPLn3MmzS
	 CL+/b1kKuTbKR+r38RJ+y6CjShiijqNcnhwcmz5ZCDLZvu2jZmyZqI8LN7wzXQ23Wc
	 iLlcyx1t4IfnA==
From: Thomas Gleixner <tglx@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 thomas.weissschuh@linutronix.de, Arthur Kiyanovski <akiyano@amazon.com>,
 Rodolfo Giometti <giometti@enneenne.com>, Vincent Donnefort
 <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Oliver Upton
 <oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Johannes Berg
 <johannes.berg@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [patch V2 18/25] timekeeping: Prepare for cross timestamps on
 arbitrary clock IDs
In-Reply-To: <b296182e2e2c1ed2fe1c4879fd6f12d67a7ad22f.camel@infradead.org>
References: <20260529193435.921555544@kernel.org>
 <20260529195557.846634842@kernel.org>
 <b296182e2e2c1ed2fe1c4879fd6f12d67a7ad22f.camel@infradead.org>
Date: Mon, 22 Jun 2026 13:07:46 +0200
Message-ID: <87se6eltod.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dwmw2@infradead.org,m:linux-kernel@vger.kernel.org,m:mlichvar@redhat.com,m:jstultz@google.com,m:sboyd@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:thomas.weissschuh@linutronix.de,m:akiyano@amazon.com,m:giometti@enneenne.com,m:vdonnefort@google.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:tiwai@suse.com,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:saeedm@nvidia.com,m:peter.hilber@oss.qualcomm.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-sound@vger.kernel.org,m:vadim.fedorenko@linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37971-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 738736AEF35

On Mon, Jun 22 2026 at 09:55, David Woodhouse wrote:
> On Fri, 2026-05-29 at 22:01 +0200, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@kernel.org>
>>=20
>> PTP device system crosstime stamps support only CLOCK_REALTIME, which is
>> meaningless for AUX clocks. The PTP core hands in the clock ID already, =
so
>> prepare the core code to honor it.
>>=20
>> =C2=A0- Add a new sys_systime field to struct system_device_crosststamp =
which
>> =C2=A0=C2=A0 aliases the sys_realtime field. Once all users are converted
>> =C2=A0=C2=A0 sys_realtime can be removed.
>>=20
>> =C2=A0- Prepare get_device_system_crosststamp() and the related code for=
 it by
>> =C2=A0=C2=A0 switching to sys_systime and providing the initial changes =
to utilize
>> =C2=A0=C2=A0 different time keepers.
>>=20
>> No functional change intended.
>
> We ended up with ktime_get_snapshot_id() also supporting CLOCK_BOOTTIME
> and CLOCK_MONOTONIC_RAW, but not get_device_system_crosststamp().
> Should we make that consistent?

Maybe. The BOOTTIME support is only there for that ARM64 hyper trace muck,
but has no other relevance.

MONORAW is there for the PTP EXTENDED IOCTL, but with PRECISE the
snapshot already contains the raw value and you'd have to prevent the
historical adjustment part for RAW. So I don't see the actual value, but
I don't have a strong opinion either.

Thanks,

        tglx




