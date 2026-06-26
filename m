Return-Path: <linux-wireless+bounces-38149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id exfyG9c8Pmq2BwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:48:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124436CB791
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:48:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=hQr5S+RC;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=D6m8j1DR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38149-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38149-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E88300A77E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AF83DFC6A;
	Fri, 26 Jun 2026 08:48:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06C286415;
	Fri, 26 Jun 2026 08:48:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463693; cv=none; b=DrRBMjvFQJ7yu7r6z1aW1Noe0/w5ciGkzHe4B/PHMXOk1zZECp0SiSkGIvxJRqxKLGI5ast6juQJWvSwHb1sI74suqmKCwUOT6fzuJK6J7PJLbq/LUhrAo8G9JL5MI5xxcTBusVy3//GIdfFvYU/2BeJ4SHc6HOTijCXq8RnsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463693; c=relaxed/simple;
	bh=97Pgkq6adF67eZdz/+XepyKwUN1XtS5Xtm1EzLtTGRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPI9Ha2zPtW+2gpkEJfUY0IA+ctLwvBtOJL0lclkp+HNgx6OURJIZWwECUYO10tk5jJ0OisC1GM0ocqlv/yG9QN9oCxEYSwrVrvFA/PX2JCwvEsKWW/5qhPK+ZHyvS3H59zpt3sIDMB2F3a8vSMLRFvPGDrdiY/gfCyt1Oso/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQr5S+RC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6m8j1DR; arc=none smtp.client-ip=193.142.43.55
Date: Fri, 26 Jun 2026 10:48:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782463690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbME+aYeChhw+njOkhtdnmfsmFO39c1xH0hF4mprHBM=;
	b=hQr5S+RC2eRu9S7NHE1xnWBkLxwZkglNFbDx5aO6m5GZfiSMwzlDvaLNYkvMGqGzWObkWm
	nJ5Q6UcCzmXM19h3lnPwu/EKVAS9FgM6RrtWQUpG7k4/miKl7gYJVeFLHMxGZxfQ9A0u9G
	JoUlnEIh80X7iKXX0O+1UJ1lgxNNA2G2i7n8UDaxZlZ9Dn/U6zRKFztWMHYRozmLY5Cm5A
	99uacM0NSvo3kIxVhcUnYKfAMADdqM2wn6U31oHVUDI/a/adBoPlDLNJLGiZk3nO6XGqlC
	KeATqSn4FHIP+jBEQCRLH88ET1rtP17IlX7gI9f/X/BT7N61yaKTVUhUdYRupg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782463690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbME+aYeChhw+njOkhtdnmfsmFO39c1xH0hF4mprHBM=;
	b=D6m8j1DRWFTBXmKkTp+cYL8Y9jVp9/66ve3/uCPppAIq2JFT4eWs4ARh8Txa2F8tD2YPCf
	29ptwSplT1ImBsBQ==
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
Message-ID: <20260626103359-66ab2b54-d36f-416b-94a4-3f3708dccced@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.374814973@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526171223.374814973@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38149-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 124436CB791

On Tue, May 26, 2026 at 07:14:13PM +0200, Thomas Gleixner wrote:
(...)

>  static inline void tk_update_aux_offs(struct timekeeper *tk, ktime_t offs)
> @@ -1218,6 +1223,12 @@ bool ktime_get_snapshot_id(struct system
>  		tkd = &tk_core;
>  		offs = &tk_core.timekeeper.offs_boot;
>  		break;
> +	case CLOCK_AUX ... CLOCK_AUX_LAST:
> +		tkd = aux_get_tk_data(clock_id);
> +		if (!tkd)
> +			return false;
> +		offs = &tkd->timekeeper.offs_aux;
> +		break;

'tkd' is also used to compute 'monoraw'. However 'tkr_raw' and 'tkr_mono'
are the same for auxilary clocks, so this will compute a wrong 'monoraw'.
Instead 'monoraw' should be computed based on 'tk_core'.
Which then also requires the sequence locking of 'tk_core'.

As you know I have a series which unifies the locking between the
different timekeepers. Maybe we revert this patch for 7.2 and I send
a fixed variant including the prerequisites for 7.3.

(The same goes for get_device_system_crosststamp())

>  	default:
>  		WARN_ON_ONCE(1);
>  		return false;
> @@ -1228,6 +1239,10 @@ bool ktime_get_snapshot_id(struct system
>  	do {
>  		seq = read_seqcount_begin(&tkd->seq);
>  
> +		/* Aux clocks can be invalid */
> +		if (!tk->clock_valid)
> +			return false;
> +
>  		now = tk_clock_read(&tk->tkr_mono);
>  		systime_snapshot->cs_id = tk->tkr_mono.clock->id;
>  		systime_snapshot->cs_was_changed_seq = tk->cs_was_changed_seq;
> 

