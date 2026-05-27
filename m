Return-Path: <linux-wireless+bounces-36983-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEEOJLmaFmq1ngcAu9opvQ
	(envelope-from <linux-wireless+bounces-36983-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:18:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ABF5E055E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCC063022564
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 07:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A133BE632;
	Wed, 27 May 2026 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iY8vDK4h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HLGc4QqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437C2D5922;
	Wed, 27 May 2026 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866268; cv=none; b=juZe1Z7vNiJWnGXOBbNEGsH8USYN6dcAJHY5OUKjNirE0Ix9Yh07wpLOBkB4Ay9nPWxsn+AJAxRfRRHpI50BCXxRBzzTPcf1AXJ5RNeHQuFlNCP+SCPNSNwsQt3GAgK3AKsS4SOeR0KPuOMqhAGdMUO8HLDesSl0BR6ANMA+FmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866268; c=relaxed/simple;
	bh=AFJMzq35BBn2pDEbMpAVLvuiISX6fYg9yam4Yh1eLxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGbUhUKa+asywedSKrk9gCnFXrP91G1GOPbN/JvdNJzToJCa9kWjSvmAnLA4uQcSMlCdKNC+V0WqOgoB/j9O9o5bUPf74sqyep/dq1/LcHe2Nr38IYH68gjsCtaX8WVavwE635YpTyWUaLECuDVl5T+xs5lHz1I9DkJrALcisi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iY8vDK4h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HLGc4QqC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 May 2026 09:17:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779866265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1BPJhdVONtxEx+G7id6fIP50+kppGwHFjUZqalv13I=;
	b=iY8vDK4hGfgyTSLtF67ODXu/6z3rjO8D/svDCIX/RZ97wpWRowarzbOFqtQkIV10Al08NC
	OYG8lIEc5V4weFsWKoZ+3myW+m6kRGodDsSRydhlHD2GlXMZfmm2nKRzhyJuwfjWN3ssfx
	wW2FLQ8N0Dl/WXiiWRM4CZMg54qmX3MxZY9FhVY+YQkVvIOYCsYcQo+++OzYhFNfXPc2To
	MONPmNqq9VC/S4aDdQhHlPrbxEr+jl3d9NfcbZYpgXdbh4Xg2YwOdDsBRXUJbDp7cxd6HI
	GMZ9Mnj9q1lS0/WgWg0IASeOtx2wmouV75dTHepaCX22/e/3ZQX9FNARTBqrUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779866265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1BPJhdVONtxEx+G7id6fIP50+kppGwHFjUZqalv13I=;
	b=HLGc4QqCviwtA3izBUhv0VBA9kSbQo6x2i5HaIW7skaA4Qoxh/9oCoLIfEHCCbWorfv/Gt
	bL3e+R0CDbmXzhCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Arthur Kiyanovski <akiyano@amazon.com>, Rodolfo Giometti <giometti@enneenne.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Peter Hilber <peter.hilber@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, linux-wireless@vger.kernel.org, 
	linux-sound@vger.kernel.org
Subject: Re: [patch 08/24] timekeeping: Remove system_time_snapshot::real/boot
Message-ID: <20260527091206-40b8750f-92b9-425c-9cb7-516251b7d350@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.300914258@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526171223.300914258@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36983-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05ABF5E055E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:14:08PM +0200, Thomas Gleixner wrote:
> All users are converted over to ktime_get_snapshot_id() and
> system_time_snapshot::sys.
> 
> Remove the leftovers.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  include/linux/timekeeping.h |    4 ----
>  kernel/time/timekeeping.c   |    8 --------
>  2 files changed, 12 deletions(-)
> 
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -280,8 +280,6 @@ static inline bool ktime_get_aux_ts64(cl
>   *				 a selected CLOCK_* and the clocksource counter value
>   * @cycles:		Clocksource counter value to produce the system times
>   * @sys:		The system time of the selected CLOCK ID
> - * @real:		Realtime system time
> - * @boot:		Boot time
>   * @raw:		Monotonic raw system time
>   * @cs_id:		Clocksource ID
>   * @clock_was_set_seq:	The sequence number of clock-was-set events
> @@ -291,8 +289,6 @@ static inline bool ktime_get_aux_ts64(cl
>  struct system_time_snapshot {
>  	u64			cycles;
>  	ktime_t			sys;
> -	ktime_t			real;
> -	ktime_t			boot;
>  	ktime_t			raw;
>  	enum clocksource_ids	cs_id;
>  	unsigned int		clock_was_set_seq;
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1196,8 +1196,6 @@ bool ktime_get_snapshot_id(struct system
>  	struct timekeeper *tk;
>  	struct tk_data *tkd;
>  	unsigned int seq;
> -	ktime_t base_real;
> -	ktime_t base_boot;
>  
>  	/* Invalidate the snapshot for all failure cases */
>  	systime_snapshot->valid = false;
> @@ -1239,18 +1237,12 @@ bool ktime_get_snapshot_id(struct system
>  		offs_sys = *offs;
>  		base_raw = tk->tkr_raw.base;
>  
> -		/* Kept around until the callers are fixed up */
> -		base_real = ktime_add(base_sys, tk_core.timekeeper.offs_real);
> -		base_boot = ktime_add(base_sys, tk_core.timekeeper.offs_boot);
> -

In patch 1 I was confused slightly why only these two lines use tk_core,
while everything else uses tk->, even base_sys.
Functionally it doesn't make a difference, but for clarity this could be more
consistent.

>  		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
>  		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
>  	} while (read_seqcount_retry(&tkd->seq, seq));
>  
>  	systime_snapshot->cycles = now;
>  	systime_snapshot->sys = ktime_add_ns(base_sys, offs_sys + nsec_sys);
> -	systime_snapshot->real = ktime_add_ns(base_real, nsec_sys);
> -	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_sys);
>  	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
>  
>  	/*
> 

