Return-Path: <linux-wireless+bounces-37171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNygCEjFGmok8ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:08:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5960C5C5
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F9CD301A1D6
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511EA3A7189;
	Sat, 30 May 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="kgKGRZBi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE339B489
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139332; cv=none; b=GIBwsPxWcLfq9Zmm6uThM3475Z+kXGnTVKuwTSwkf3cZCQNV+GwPWsO1ULKKNBO+/fCyz0kZdK99OWc3N062fmwgVhoiMErCCqpQ7hmcalBOeYb96rx6/Fr/QqM4B2vqlkhLkgqJeEqHe9gLjVw8CR+k2ALFOu0YNHe7VlEmybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139332; c=relaxed/simple;
	bh=GPyYaBIjPJR6VxGYHYgZkTzX7CeNzKdf2h5i4+TkNEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lamhV2JQ1qWi69Xau/7bcboeZtV3W++uLMg3P5b7Gs7AyEUaXVytV6d/Jr97EFXqA55GKx1QyUyPxsrJVDvXxb9+2NMYwhYTTEV8YAo44CJrFO1KSzPHRl3w/KD1DpHo9FNMgEb7ZZJDGt6XqkLgwqVGF4s+WiGATwnGnPidCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=kgKGRZBi; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.0.186] ([109.118.80.246])
	by Aruba SMTP with ESMTPSA
	id THYcwvMjjtpTfTHYdwL3Pi; Sat, 30 May 2026 13:08:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1780139329; bh=GPyYaBIjPJR6VxGYHYgZkTzX7CeNzKdf2h5i4+TkNEg=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=kgKGRZBiSx58E4LAUgStLSQ3R2seSS6CpKU9kJ9hy+keJX+d7/DD3a7K0wTnshwMg
	 ftkEItSrXwRxergIwPMhm0uf84sJTZnmNeWkIhX1DijGgo+xuErv+CK2qdSXQC/osC
	 /G/3+ydAvP1mIjjWj5vl5yEQTfS+xju4EXMJDjVCFfiHhyN1jrIgSKgN0XYD6Hxl/y
	 Fw8mAi/3TMyM8MZ/FLfy36LwEhjcNXeufB0ZTjQ6bABAs5zaKHcZWOn3t4pMrjAf0C
	 6YpR52XYOXB1bHknwZFujGTTocln5fxtFXd2xu9tTXSYEZvErQqLSo7/M9uH5VuSod
	 c1fZ4Qh8+lrVQ==
Message-ID: <912a22e8-878f-4763-958b-71052ee69b36@enneenne.com>
Date: Sat, 30 May 2026 13:08:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 04/25] pps: Convert to ktime_get_snapshot_id()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, thomas.weissschuh@linutronix.de,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Peter Hilber <peter.hilber@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org,
 David Woodhouse <dwmw@amazon.co.uk>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20260529193435.921555544@kernel.org>
 <20260529195557.123410250@kernel.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260529195557.123410250@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDEumLSv+pk/U7kUrE6BL3srB8YYK8RA/hJdPG2uEhTOPvKA9Ae3985zLeyJTGgr/CFNuu2TwP1b19so35CyXgPbwgS/+GS4wpS04rqyC5DXeO2e3lwN
 EgRf+BrmXj/gfc10HcckoI9SRkL6j6Kp57c12/EXsEsLtyt5ERq37z9tJBqN/ef46YKkLaZNVovcBNwdrEdpD5h5eEvWQRaI8tUmoazMGe45OuXe9xOu2MtM
 Vt6sbU5QejS71ZbLguWs0nzAy9KuBGa6s8M3UsVhmuLGLgShRdlYeyRSgO2C69aVdiZ6BnW2+9QpDdnJ9rPsVNysuqBHMfCk/1o0NwxNanFEcT6gDCtMseHT
 NW3Bw1DapD9bEybwmSWu2Zf5330Pv2AcCh+kHbC3zGofYr1aTnRG+gZePb295V3qWiZM8JNDREwGyp8QJaqaA2OdZXW2apEw8yLNGEqQN73GCHLdZZcdRnFM
 HNBil37fEqKWVOa/tQt79gxnrDmlqkeFZBWQxjG/hR3RcEp+rKiuiSPx73hbH+IWRMHmX4mohtFeyEP7Vu+xekgyR5RahrSuNyOxM0ZOxTwWqt2L4AxPgcle
 QjjXBe5kivH8MVmAv5NBuGdg3Y3Bkxt8dQ+JyzQ8Pf2VxNDOxxvVis+8e+2O9JghvhEj9641F6Eh4EC2r4tG8SvxMvA7Kl4uFERt7dzBWG7eIFcqPEffjeGY
 QDPjGReTtDcjFDFYHaKelr95XeShfIlPw2CCCaoG5+x/d0B8832Tg1XTs/INUgofCDHRfrD1w3uYUcVnUsDnUbUjDH6SUGA4cRnPpKlVfVMP3jNldxb23ylZ
 eaWdRoAaq0CNuufl1zHXpjCmbwmC7zZbGqUoeTpw+8wBE6yRimRIXelYPWNsh6PINInGPehIaUaetWGzBIaqE6lfol36A8FcFWp+QdKY7V07UnAjWu2YU9wg
 HRqsu4wdF89Qgoke6D3VWDVMS+L7Q/UUbxfJl7GnrYIK/gcxE1hsAgVH9/rRu/9zrvHyxnMjqXPbioXaT+ya5WPb0jZdIBfk+5HAXyCLI2yk0mspHuf0gx+0
 7npTs+VEZBNH7zP4dydpKWU5LmOAgaM9+JyBec0Dhjm3KmLVPvmtdnKLk2LargZFo9erPppdU5zxSdYZINdZkt5izI3UTdMig+IqgGESyNEiZtfq1FHgEw24
 +4Elt1LutSMUWoDAABdFQQ==
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[enneenne.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37171-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giometti@enneenne.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aruba.it:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,aruba.it:dkim,linutronix.de:email,amazon.co.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,enneenne.com:mid,enneenne.com:email]
X-Rspamd-Queue-Id: 7BB5960C5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29/05/2026 22:00, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> ktime_get_snapshot() resolves to ktime_get_snapshot_id(CLOCK_REALTIME).
> 
> Make it obvious in the code and convert the readout to use the
> snapshot::systime and monoraw fields instead of snapshot::real and raw,
> which aregoing away.
> 
> Similar to the PPS generators, avoid the more expensive snapshot when
> CONFIG_NTP_PPS is disabled.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   include/linux/pps_kernel.h |   10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -99,12 +99,14 @@ static inline void timespec_to_pps_ktime
>   
>   static inline void pps_get_ts(struct pps_event_time *ts)
>   {
> +#ifdef CONFIG_NTP_PPS
>   	struct system_time_snapshot snap;
>   
> -	ktime_get_snapshot(&snap);
> -	ts->ts_real = ktime_to_timespec64(snap.real);
> -#ifdef CONFIG_NTP_PPS
> -	ts->ts_raw = ktime_to_timespec64(snap.raw);
> +	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
> +	ts->ts_real = ktime_to_timespec64(snap.systime);
> +	ts->ts_raw = ktime_to_timespec64(snap.monoraw);
> +#else
> +	ktime_get_real_ts64(&ts->ts_real);

	/*
	 * Prevent kernel stack information disclosure if the
	 * structure is later copied to userspace.
	 */
	ts->ts_raw = (struct timespec64){0, 0};

>   #endif
>   }
>   
> 

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

