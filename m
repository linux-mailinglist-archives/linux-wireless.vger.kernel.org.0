Return-Path: <linux-wireless+bounces-38242-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vWwgN6fsQWp3wAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38242-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:55:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0406D5BE7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:55:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=Pft78SEo;
	dkim=pass header.d=linutronix.de header.s=2020e header.b="mhU/07WU";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38242-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38242-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 353A0300F55B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 03:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003B379ED6;
	Mon, 29 Jun 2026 03:55:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAED2D3A7C;
	Mon, 29 Jun 2026 03:55:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782705317; cv=none; b=HLMR2ij9j8Ar7RWTaCKWGOZC9dYjuuDKz2IUknAbgYe8YTepwXVvF7QxmEdQdQbHF0oEpECtpYKFjQ5ElieMe2I4W/jnrNsCH+xBgQvmbDwE9G+derFrK2V7DAv0MJnX64jt30ySs0VyAw4/9eQKL7bgWkLP7FSVIA3SDwCiNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782705317; c=relaxed/simple;
	bh=+9Gt5xbV0f6uwKj3h75aKeru0YfHJBPFQCGeKZXf2cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eufzna1K0BcqIFLBEf679ZSQk/90bZBehL6iPcQPF1aSP7ho8RkhHOw1yje50f1EuLDpUS/g013HDoQPYEgm1l0KA4mTOVnbXvYJ/zTOlBtlEdglI3dEwJvdC4S+SbIyuB8zITK0EOOfMTa863xRjkEVGalCLDmLB/0QmW0FirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pft78SEo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mhU/07WU; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 29 Jun 2026 05:55:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782705313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fphPRIfC3c7/rVG8Mt/TDc8McgZz28sFey5ZU2tWKdc=;
	b=Pft78SEoAU9N4qr3lmpoTg0M92qy3Nft6vgej121eR9dSbMe0f8peTU3UQ5ZdZp4xb32eB
	b7WgzU76UpqfIi0KH7Nok5zMxvDv0BWBBliu/F8F1xalkGFAYdD3oGsQzbc0O5OjAwtWCF
	mXycnLD/Wd7oQtN0SElsTscfGpUIJ3xYAESLabeu0rfoa+vtgLN19lNYJ3atZNfWAGOetu
	XZifQFpTfhxnNu61bjULxpRwl9PAqqmE3eXNeppbBRnouZ1TD+2oTzJkKTam5Hq6Pq/Lz1
	Zl42CcwgABCE3nJlNBy1i0YxdmOXGkBpyzioiyLcnR307F4EAjjODdDMzVT1mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782705313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fphPRIfC3c7/rVG8Mt/TDc8McgZz28sFey5ZU2tWKdc=;
	b=mhU/07WU2k0PFYZQUZgClVivDlMZa7FcCpph6HWnRTGAFP5kbPcuuzB14gmyxBBGCv5W+f
	6CGdzH8OyJeCbxDw==
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
Subject: Re: [patch 09/24] timekeeping: Add CLOCK_AUX support for
 ktime_get_snapshot_id()
Message-ID: <20260629055344-b74c43de-2a2b-4608-ae4e-ed0ac8e12fd1@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.374814973@kernel.org>
 <20260626103359-66ab2b54-d36f-416b-94a4-3f3708dccced@linutronix.de>
 <87echtk24a.ffs@fw13>
 <20260626125819-d8b197fc-7671-4d12-a578-9025affc52d9@linutronix.de>
 <87fr29ib4v.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fr29ib4v.ffs@fw13>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38242-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:mlichvar@redhat.com,m:jstultz@google.com,m:sboyd@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:akiyano@amazon.com,m:giometti@enneenne.com,m:vdonnefort@google.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:tiwai@suse.com,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:saeedm@nvidia.com,m:peter.hilber@oss.qualcomm.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-sound@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F0406D5BE7

On Fri, Jun 26, 2026 at 05:17:52PM +0200, Thomas Gleixner wrote:
> On Fri, Jun 26 2026 at 13:03, Thomas Weißschuh wrote:
> > On Fri, Jun 26, 2026 at 12:49:41PM +0200, Thomas Gleixner wrote:
> >> On Fri, Jun 26 2026 at 10:48, Thomas Weißschuh wrote:
> >> > On Tue, May 26, 2026 at 07:14:13PM +0200, Thomas Gleixner wrote:
> >> > (...)
> >> >
> >> >>  static inline void tk_update_aux_offs(struct timekeeper *tk, ktime_t offs)
> >> >> @@ -1218,6 +1223,12 @@ bool ktime_get_snapshot_id(struct system
> >> >>  		tkd = &tk_core;
> >> >>  		offs = &tk_core.timekeeper.offs_boot;
> >> >>  		break;
> >> >> +	case CLOCK_AUX ... CLOCK_AUX_LAST:
> >> >> +		tkd = aux_get_tk_data(clock_id);
> >> >> +		if (!tkd)
> >> >> +			return false;
> >> >> +		offs = &tkd->timekeeper.offs_aux;
> >> >> +		break;
> >> >
> >> > 'tkd' is also used to compute 'monoraw'. However 'tkr_raw' and 'tkr_mono'
> >> > are the same for auxilary clocks, so this will compute a wrong 'monoraw'.
> >> 
> >> AUX clocks are independent in the first place and the MONORAW part is
> >> the "MONORAW" related to the AUX clock itself. 
> >> 
> >> > Instead 'monoraw' should be computed based on 'tk_core'.
> >> > Which then also requires the sequence locking of 'tk_core'.
> >> 
> >> No. From a PTP and steering point of view you want the "raw" value which
> >> is related to the AUX clock itself and not the global one.
> >
> > Ack.
> >
> > However the kdocs call it 'CLOCK_MONOTONIC_RAW'. Can we clean this up?
> 
> Yes. Something like the below?

Looks good, thanks.
The corresponding structure definitions are a also affected, though.

> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1202,10 +1202,21 @@ static inline u64 tk_clock_read_snapshot
>  
>  /**
>   * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
> - *			    CLOCK_MONOTONIC_RAW and the underlying
> + *			    the corresponding monotonic raw the underlying
>   *			    clocksource counter value.
>   * @clock_id:		The clock ID to snapshot
>   * @systime_snapshot:	Pointer to struct receiving the system time snapshot
> + *
> + * For the system time keeping clocks (REALTIME, MONOTONIC and BOOTTIME) the
> + * monotonic raw clock is CLOCK_MONOTONIC_RAW. For AUX clocks this is the
> + * monotonic raw clock related to the AUX clock. These AUX clock related
> + * monotonic raw clocks have a strict linear offset to the system time
> + * CLOCK_MONOTONIC_RAW:
> + *
> + *	MONOTONIC_RAW(AUX$N) = CLOCK_MONOTONIC_RAW(system) + offset(AUX$N)
> + *
> + * The offset is established when a AUX clock is initialized, but it is
> + * currently not accessible.
>   */
>  void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *systime_snapshot)
>  {
> @@ -1512,6 +1523,9 @@ EXPORT_SYMBOL_GPL(ktime_real_to_base_clo
>   * @xtstamp:		Receives simultaneously captured system and device time
>   *
>   * Reads a timestamp from a device and correlates it to system time
> + *
> + * See documentation for ktime_get_snapshot_id() for information about the raw
> + * monotonic time stamp which is used here.
>   */
>  int get_device_system_crosststamp(int (*get_time_fn)
>  				  (ktime_t *device_time,
> 

