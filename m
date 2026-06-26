Return-Path: <linux-wireless+bounces-38160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bt0bE0xZPmpXEQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 12:49:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC816CC2D6
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 12:49:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="S/5AXIbd";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38160-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38160-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F6EC300CC32
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C293ED122;
	Fri, 26 Jun 2026 10:49:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D63A873D;
	Fri, 26 Jun 2026 10:49:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470985; cv=none; b=uUKvjO7bHiE2BUNatBnrTC4NlCE5qU6GQNaWS+pUFZpLIXzdpOdCbK8K4lvnA6f5QLqzv8M4isBIHkje6Y3bp84EycVno3CXAhv+zOT2nq8AYoJwgYZsu2xrvU/3/7aEPpz8hGqdHaNZI77TpNpioXzQNvGhiTew6L4yMf4c/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470985; c=relaxed/simple;
	bh=TKcaVW7HVikmiiDGuBeis2gKg/FfUDfyELepoLCpCK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UGGpYR9vKIFI2sPjL5gjmPDk0mYo6QcFF/Swj51EeQYYDtzpCBvV1AvTrBM280/pKfbZ/J/lbrpFmJS7MDQ5nFx4f5Y0qQay1rDqum01HDO99/RWyHfIaaLmFPRaQSC9fdzBtXqaPXbL6FCRgOpkZgdr2BeE2dHiMCJQg81pHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/5AXIbd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1151F000E9;
	Fri, 26 Jun 2026 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782470984;
	bh=tnerpNhOrBLh7vhCHDu/AZ606iUJiugWohBIxX532Qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=S/5AXIbdXtITWNkQPORvCiw4nseJOJtxhQBffsgTYXrnNrXQot4NqaZnEidHnYNd8
	 jSr0fAmPPtspqyXLi/XeAb3l+yTF6DTc9w2DGHmPOJgYxldJkDuFQvJBx5N3G+u/C9
	 7rSuDJYFBjclqydxHAfAYlbx7D1s17+03dXk4rtLGEcULg0GaQIX0WJBDganqI0Ujp
	 r4Nk4fuBeVmRItg41bBL2nwjFWJc867+lzTnbTwexIguKmAUUyyf4w3yamxTZwBuyd
	 mW4hzNVP+BO+ImKm0S1YRC+jYeVE3o2BLpnVuqmMpDHZSy12fCOpdOVrPwhkym65I7
	 l0h0PrS7XzFyw==
From: Thomas Gleixner <tglx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Miroslav Lichvar <mlichvar@redhat.com>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Arthur Kiyanovski <akiyano@amazon.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Vincent Donnefort <vdonnefort@google.com>, Marc
 Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org, Takashi Iwai
 <tiwai@suse.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Peter Hilber
 <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, linux-wireless@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [patch 09/24] timekeeping: Add CLOCK_AUX support for
 ktime_get_snapshot_id()
In-Reply-To: <20260626103359-66ab2b54-d36f-416b-94a4-3f3708dccced@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.374814973@kernel.org>
 <20260626103359-66ab2b54-d36f-416b-94a4-3f3708dccced@linutronix.de>
Date: Fri, 26 Jun 2026 12:49:41 +0200
Message-ID: <87echtk24a.ffs@fw13>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:mlichvar@redhat.com,m:jstultz@google.com,m:sboyd@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:akiyano@amazon.com,m:giometti@enneenne.com,m:vdonnefort@google.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:tiwai@suse.com,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:saeedm@nvidia.com,m:peter.hilber@oss.qualcomm.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-sound@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38160-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CC816CC2D6

On Fri, Jun 26 2026 at 10:48, Thomas Wei=C3=9Fschuh wrote:
> On Tue, May 26, 2026 at 07:14:13PM +0200, Thomas Gleixner wrote:
> (...)
>
>>  static inline void tk_update_aux_offs(struct timekeeper *tk, ktime_t of=
fs)
>> @@ -1218,6 +1223,12 @@ bool ktime_get_snapshot_id(struct system
>>  		tkd =3D &tk_core;
>>  		offs =3D &tk_core.timekeeper.offs_boot;
>>  		break;
>> +	case CLOCK_AUX ... CLOCK_AUX_LAST:
>> +		tkd =3D aux_get_tk_data(clock_id);
>> +		if (!tkd)
>> +			return false;
>> +		offs =3D &tkd->timekeeper.offs_aux;
>> +		break;
>
> 'tkd' is also used to compute 'monoraw'. However 'tkr_raw' and 'tkr_mono'
> are the same for auxilary clocks, so this will compute a wrong 'monoraw'.

AUX clocks are independent in the first place and the MONORAW part is
the "MONORAW" related to the AUX clock itself.=20

> Instead 'monoraw' should be computed based on 'tk_core'.
> Which then also requires the sequence locking of 'tk_core'.

No. From a PTP and steering point of view you want the "raw" value which
is related to the AUX clock itself and not the global one.

The global MONORAW and the AUX clock MONORAW are related obviously as
they share the same conversion factors.

     MONORAW(AUX$N) =3D MONORAW(GLOBAL) + OFFSET(AUX$N)

We don't have that information anywhere right now and we might want to
expose it to allow user space a proper correlation, but that's an
orthogonal problem.

From a PTP/steering point of view the code is correct as is.

Thanks,

        tglx



