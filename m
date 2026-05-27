Return-Path: <linux-wireless+bounces-36976-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJGvN8OVFmq1ngcAu9opvQ
	(envelope-from <linux-wireless+bounces-36976-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 08:57:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 886CC5E016C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 08:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81E26300B1C8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351FB3B584A;
	Wed, 27 May 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lE1rhQh/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGHkPw9A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E83264E2;
	Wed, 27 May 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865023; cv=none; b=X1mXPl1uPOEPsbGFFgnZiIrT506SPdH4mkO8kTaK1GZLglnXxNwScyo8PXYnnRFD44Ofa9IebN5jiKPOxGbepg1hLLds0UNKeM9iUwor/EdSGVLLd4GWi8jF7MRpr7fyRhnLNyBU65Y0pAp1e3wl5R5fhdYqSU71uKx/bR3Nz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865023; c=relaxed/simple;
	bh=GuvkfOYCTbWmHNH8ZBHAB4UnypmwvtDfvJ0B++iOZYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd6iDhyGnhqtjuuwEIh7akGAxAT5me2Uay4pykwGHoKEPBcZ45DcHTb6faSn+v6hmq7vg57DSwpS8v/9FUi4U39GSqi/273iWhWnMtKfPT12m0igcTfkLZMnvGS1gKfzoQdn86Esaj3mYn0HcQIThXJ5hK8NCY95o1zd7ujQQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lE1rhQh/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGHkPw9A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 May 2026 08:56:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779865012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9FXDcb0Q7eou62l15Nuzus+5lVF3MVPgo++0GaKpdc=;
	b=lE1rhQh/uaWLzN42yd5Qk3V7oxOew+cPqxGKv/gxL//uPKB1YLUhO/rkykArhaJXm7z7yv
	5F5rrXsh8stGMDqTW86FgMFK2t4cpJ/RDmRDPqQeLOYN9p0ij9Mp6Zzirz1d8dkut4JMJz
	/1V0Uh28k+ncnN3bGJoFJ+wQoW095R0pWGzzKekr8uhikN33PoWk2a8spRcsVusy3i/yV1
	ouFVbQ0FqwO6kALiKaqRRs1YVnznR3kGkKgHsWwVQ/jHyynfDUy4lp2wofyD7njOe/sjju
	MKEXd/AhZNxV9/SAxM9eq/rLyky00QssP5ml0cEq/Y+FDUQd6s9CYWWVsdaZ9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779865012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9FXDcb0Q7eou62l15Nuzus+5lVF3MVPgo++0GaKpdc=;
	b=pGHkPw9Amrivyf0TpJ7sdBijxHCxDlACxyrq08+vBD6DQlvGo2m8y96wT9REkophizw+LN
	UPsKX2UhL8QpL9DQ==
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
Subject: Re: [patch 01/24] timekeeping: Provide ktime_get_snapshot_id()
Message-ID: <20260527081122-0d6e9d38-478f-4aea-b8b1-c93655877d5f@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171222.769770418@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526171222.769770418@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36976-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 886CC5E016C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:13:33PM +0200, Thomas Gleixner wrote:
> ktime_get_snapshot() provides a snapshot of the underlying clocksource
> counter value and the corresponding CLOCK_MONOTONIC_RAW, CLOCK_REALTIME and
> CLOCK_BOOTTIME timestamps.
> 
> There is no usage of CLOCK_REALTIME and CLOCK_BOOTTIME at the same time and
> CLOCK_BOOTTIME support was just added for the ARM64 KVM tracing mechanism,
> which needs CLOCK_BOOTTIME and the underlying clocksource counter value.
> 
> ktime_get_snapshot() is also not suitable for usage with CLOCK_AUX, but
> that's a prerequisite to support PTP hardware timestamping for CLOCK_AUX
> steering.
> 
> As a first step, rename ktime_get_snapshot() to ktime_get_snapshot_id(),
> which now takes a clockid argument to select the clock which needs to be
> captured. The result is stored in system_time_snapshot::sys, which will
> replace the system_time_snapshot::real/boot members once all usage sites
> have been converted.
> 
> ktime_get_snapshot() is a simple wrapper which hands in CLOCK_REALTIME as
> clockid argument for the conversion period. That means CLOCK_REALTIME is
> now captured twice, but that redunancy is only temporary.
> 
> No functional change vs. current users of ktime_get_snapshot()
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Plus some subjective nitpicks below.

> ---
>  include/linux/timekeeping.h |   29 ++++++++++-----
>  kernel/time/timekeeping.c   |   84 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 84 insertions(+), 29 deletions(-)
> 
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -276,24 +276,28 @@ static inline bool ktime_get_aux_ts64(cl
>  #endif
>  
>  /**
> - * struct system_time_snapshot - simultaneous raw/real time capture with
> - *				 counter value
> - * @cycles:	Clocksource counter value to produce the system times
> - * @real:	Realtime system time
> - * @boot:	Boot time
> - * @raw:	Monotonic raw system time
> - * @cs_id:	Clocksource ID
> + * struct system_time_snapshot - Simultaneous time capture of CLOCK_MONOTONIC_RAW,
> + *				 a selected CLOCK_* and the clocksource counter value
> + * @cycles:		Clocksource counter value to produce the system times
> + * @sys:		The system time of the selected CLOCK ID
> + * @real:		Realtime system time
> + * @boot:		Boot time
> + * @raw:		Monotonic raw system time
> + * @cs_id:		Clocksource ID
>   * @clock_was_set_seq:	The sequence number of clock-was-set events
>   * @cs_was_changed_seq:	The sequence number of clocksource change events
> + * @valid:		True if the snapshot is valid
>   */
>  struct system_time_snapshot {
>  	u64			cycles;
> +	ktime_t			sys;
>  	ktime_t			real;
>  	ktime_t			boot;
>  	ktime_t			raw;
>  	enum clocksource_ids	cs_id;
>  	unsigned int		clock_was_set_seq;
>  	u8			cs_was_changed_seq;
> +	u8			valid;
>  };
>  
>  /**
> @@ -341,9 +345,16 @@ extern int get_device_system_crosststamp
>  			struct system_device_crosststamp *xtstamp);
>  
>  /*
> - * Simultaneously snapshot realtime and monotonic raw clocks
> + * Simultaneously snapshot a given clock with MONOTONIC_RAW and the underlying
> + * clocksource counter value.
>   */
> -extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
> +extern bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot,
> +				  clockid_t clock_id);

None of the callers (except the wrapper below, which gets removed later) is
checking the return value. Having both the return value and the valid member
looks a bit weird, too.

Clockid parameter first for consistency?

> +
> +static inline void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
> +{
> +	WARN_ON_ONCE(!ktime_get_snapshot_id(systime_snapshot, CLOCK_REALTIME));
> +}
>  
>  /*
>   * Persistent clock related interfaces
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1183,43 +1183,87 @@ noinstr time64_t __ktime_get_real_second
>  }
>  
>  /**
> - * ktime_get_snapshot - snapshots the realtime/monotonic raw clocks with counter
> - * @systime_snapshot:	pointer to struct receiving the system time snapshot
> + * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
> + *			    CLOCK_MONOTONIC_RAW and the underlying
> + *			    clocksource counter value.
> + * @systime_snapshot:	Pointer to struct receiving the system time snapshot
> + * @clock_id:		The clock ID to snapshot
>   */
> -void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
> +bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clockid_t clock_id)
>  {
> -	struct timekeeper *tk = &tk_core.timekeeper;
> +	ktime_t base_raw, base_sys, offs_sys, *offs, offs_zero = 0;
> +	u64 nsec_raw, nsec_sys, now;
> +	struct timekeeper *tk;
> +	struct tk_data *tkd;

This indirection only makes sense with the support for AUX clocks added later.

>  	unsigned int seq;
> -	ktime_t base_raw;
>  	ktime_t base_real;
>  	ktime_t base_boot;

The ktime_t variable declarations are weird now.

> -	u64 nsec_raw;
> -	u64 nsec_real;
> -	u64 now;
>  
> -	WARN_ON_ONCE(timekeeping_suspended);
> +	/* Invalidate the snapshot for all failure cases */
> +	systime_snapshot->valid = false;
> +
> +	if (WARN_ON_ONCE(timekeeping_suspended))
> +		return false;
> +
> +	switch (clock_id) {
> +	case CLOCK_REALTIME:
> +		tkd = &tk_core;
> +		offs = &tk_core.timekeeper.offs_real;
> +		break;
> +	/* Map RAW to MONOTONIC so the loop below is trivial */
> +	case CLOCK_MONOTONIC_RAW:
> +	case CLOCK_MONOTONIC:
> +		tkd = &tk_core;
> +		offs = &offs_zero;
> +		break;
> +	case CLOCK_BOOTTIME:
> +		tkd = &tk_core;
> +		offs = &tk_core.timekeeper.offs_boot;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	tk = &tkd->timekeeper;
>  
>  	do {
> -		seq = read_seqcount_begin(&tk_core.seq);
> +		seq = read_seqcount_begin(&tkd->seq);
> +
>  		now = tk_clock_read(&tk->tkr_mono);
>  		systime_snapshot->cs_id = tk->tkr_mono.clock->id;
>  		systime_snapshot->cs_was_changed_seq = tk->cs_was_changed_seq;
>  		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
> -		base_real = ktime_add(tk->tkr_mono.base,
> -				      tk_core.timekeeper.offs_real);
> -		base_boot = ktime_add(tk->tkr_mono.base,
> -				      tk_core.timekeeper.offs_boot);
> +
> +		base_sys = tk->tkr_mono.base;
> +		offs_sys = *offs;
>  		base_raw = tk->tkr_raw.base;
> -		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
> -		nsec_raw  = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
> -	} while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +		/* Kept around until the callers are fixed up */
> +		base_real = ktime_add(base_sys, tk_core.timekeeper.offs_real);
> +		base_boot = ktime_add(base_sys, tk_core.timekeeper.offs_boot);
> +
> +		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
> +		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
> +	} while (read_seqcount_retry(&tkd->seq, seq));
>  
>  	systime_snapshot->cycles = now;
> -	systime_snapshot->real = ktime_add_ns(base_real, nsec_real);
> -	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_real);
> +	systime_snapshot->sys = ktime_add_ns(base_sys, offs_sys + nsec_sys);

Technically offs_sys is ktime_t and not u64, so would need ktime_add().
(Not that it makes a difference)

> +	systime_snapshot->real = ktime_add_ns(base_real, nsec_sys);
> +	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_sys);
>  	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
> +
> +	/*
> +	 * Special case for PTP. Just transfer the raw time into sys,
> +	 * so the call sites can consistently use snap::sys.
> +	 */
> +	if (clock_id == CLOCK_MONOTONIC_RAW)
> +		systime_snapshot->sys = systime_snapshot->raw;
> +	/* Tell the consumer that this snapshot is valid */
> +	systime_snapshot->valid = true;
> +	return true;
>  }
> -EXPORT_SYMBOL_GPL(ktime_get_snapshot);
> +EXPORT_SYMBOL_GPL(ktime_get_snapshot_id);
>  
>  /* Scale base by mult/div checking for overflow */
>  static int scale64_check_overflow(u64 mult, u64 div, u64 *base)
> 

