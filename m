Return-Path: <linux-wireless+bounces-36979-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAMoO/mWFmq1ngcAu9opvQ
	(envelope-from <linux-wireless+bounces-36979-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:02:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137C5E0216
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B872530117ED
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052973B7757;
	Wed, 27 May 2026 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUTL+mo+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVK06lpp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8D305675;
	Wed, 27 May 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865331; cv=none; b=upCpkRR/CQB/SHzXINC1cTNORPxY2yy5T2xKrF+xwYt+1i5HN9A6A/tAMWqhBZ7KenwsJboFfJsnau0hBr2sGFEU0mrrvaejLxJp3erJHsNESFzlrgjisvB9zsCafNnJF75y5SD6ZqC2yFYcJcEY1gADlu2HM1jFteFVwW9BfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865331; c=relaxed/simple;
	bh=7DQb22xn0lMr49kqE77KSoPc6jPnSbaam1jWywVRR7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHGDl0xxzfVgeaoPtr+HT1nnHOE1JVt1UkrF8hKqsj6C3VDmnVYcrDrot08ohmAMTA70SPO+Tdsje5Z2KCk6+M3AT7EZ7VUJwXesjyB2sc3KK/ZM/kkcN48OG/2xAWGwmnw18WJhcxE/S0ex4u7YFbLwmyqdv8sx+FozzGi9BkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUTL+mo+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVK06lpp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 May 2026 09:02:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779865328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWp5XBKnCiH139vI0Te7wIsksnUnKV2vhQ81+hDWnb0=;
	b=FUTL+mo+87XRstzmUTTC/kj2eAp1UImw0dXsac0mdWdGMIM5hlXXnEPbwqbp7hKlhcbOC0
	geCn8kE9KhnX4p7DVTcBe7rM+wP3a1Bn73w7R6z7UVqUdKUO52P7p6jbKEWNWgwAsD9qPL
	afnpZBbpxJLYLdIE3g8DzU7Xz1cP0fTSIQNk+DBNpqdxRkGiH9WUJ5hmuufcNoJaqOxFDs
	BbKpVxCq8sYKBQMKGccpJn6iZqiVtSN90Hspv5fGpc8h6re32iQyfq7z16otpivz6mhcBe
	xSKftMXUY/dT457r1CiQnigofZuC0yYrVwCBHSSe+TUIPrLSRowPg376OmmZlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779865328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWp5XBKnCiH139vI0Te7wIsksnUnKV2vhQ81+hDWnb0=;
	b=gVK06lppdpuQNlwOEmXVjUFXMrq7ely2j4/76Jqfo1eAYjgs0Cms9WY7nTQEBNAIZ8QDzz
	4nND/hKCitJlnmBg==
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
Subject: Re: [patch 04/24] pps: Convert to ktime_get_snapshot_id()
Message-ID: <20260527090114-359e2553-2c63-4ac2-a15a-776ba08b6eec@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171222.995833811@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526171222.995833811@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36979-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,enneenne.com:email]
X-Rspamd-Queue-Id: 9137C5E0216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:13:48PM +0200, Thomas Gleixner wrote:
> ktime_get_snapshot() resolves to ktime_get_snapshot_id(CLOCK_REALTIME).
> 
> Make it obvious in the code and convert the readout to use the
> snapshot::sys field instead of snapshot::real, which is going away.
> 
> Similar to the PPS generators, avoid the more expensive snapshot when
> CONFIG_NTP_PPS is disabled.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Rodolfo Giometti <giometti@enneenne.com>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  include/linux/pps_kernel.h |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -99,12 +99,14 @@ static inline void timespec_to_pps_ktime
>  
>  static inline void pps_get_ts(struct pps_event_time *ts)
>  {
> +#ifdef CONFIG_NTP_PPS

IS_ENABLED()?

>  	struct system_time_snapshot snap;
>  
> -	ktime_get_snapshot(&snap);
> -	ts->ts_real = ktime_to_timespec64(snap.real);
> -#ifdef CONFIG_NTP_PPS
> +	ktime_get_snapshot_id(&snap, CLOCK_REALTIME);
> +	ts->ts_real = ktime_to_timespec64(snap.sys);
>  	ts->ts_raw = ktime_to_timespec64(snap.raw);
> +#else
> +	ktime_get_real_ts64(&ts->ts_real);
>  #endif
>  }
>  
> 

