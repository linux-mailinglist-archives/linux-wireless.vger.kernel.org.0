Return-Path: <linux-wireless+bounces-37146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJVkAZ3xGWoX0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:05:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C47BC60834B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C41DB309419D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1B427A05;
	Fri, 29 May 2026 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMJQfrOy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8842668B;
	Fri, 29 May 2026 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084864; cv=none; b=aXoPFstBHeduiQ1ilmbHpDiNM4f6NDjm494vyiviMk1ECYedA5t5aFQ0wK7fN1FXoYDq7b8cd56G7VDXgKbqvVscB0izQlu5v/Je3F7vSQBp1A2UxK2udQp2PdZ1YNl1OZmcfAd3NF5BhttQLEdJMdpVItnI9M6A7H6RowpeGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084864; c=relaxed/simple;
	bh=RWeQVX7jvXLz0btzPE+rQHUYicg01u0RKva8pFfur2k=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b4wLgTm9ub33q/mDGyhhlgq2MGbL/0RmGxoK629Mg/l1oSF9PdriAR8PRdsQ4X44IWu4/BkFlGfll/wjzfHNaDbRx85rD6Dq8sILXFfXtQU2+tibESD73VllptfP1Ten5WmcZh095AtaGldCPD82jVsOJPfuY+Sr9KUIOfujCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMJQfrOy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED581F00893;
	Fri, 29 May 2026 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084863;
	bh=w9cjsthHjdg5S9yLOT6GDhr6nr5/abstT1mU1tQu92g=;
	h=Date:From:To:Cc:Subject:References;
	b=jMJQfrOyfNzRGM4d11LS9CqD1u4Gq4iggqTyqr+nTnI8w/obLWDB6YdLrTNDqcpWc
	 yDexb7RrRS/byCwHtDN3Yq0qYDu33lyXrU6G1Ni+qRmZCJh4GiwysyMWsjnP3vX6x5
	 PYt+gkktZJyzd44dPQF6IWgLqwsF3HH6Q+OId5NECpn/fSq2+YIAN5Jzc3ZrCmRmQr
	 g6hwelzyva4U/ZKQYM7BuNuYBjhBu2rQE2m/m7Y87N4vZOfIJDoBy0bx6KCcNCnOMy
	 OesS7vXi7Lyaw8UMOkfLa2xIFzUnzbEUnFk5RTjgbwQHtR4ebMWrMQsfrD69XQwQJU
	 HzmwQj8E4kilA==
Date: Fri, 29 May 2026 22:01:00 +0200
Message-ID: <20260529195557.846634842@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 thomas.weissschuh@linutronix.de,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 linux-sound@vger.kernel.org,
 David Woodhouse <dwmw@amazon.co.uk>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [patch V2 18/25] timekeeping: Prepare for cross timestamps on
 arbitrary clock IDs
References: <20260529193435.921555544@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-1.11 / 15.00];
	R_BAD_CTE_7BIT(1.05)[unknown,utf8];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37146-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:email,amazon.co.uk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C47BC60834B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

PTP device system crosstime stamps support only CLOCK_REALTIME, which is
meaningless for AUX clocks. The PTP core hands in the clock ID already, so
prepare the core code to honor it.

 - Add a new sys_systime field to struct system_device_crosststamp which
   aliases the sys_realtime field. Once all users are converted
   sys_realtime can be removed.

 - Prepare get_device_system_crosststamp() and the related code for it by
   switching to sys_systime and providing the initial changes to utilize
   different time keepers.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/linux/timekeeping.h |    7 ++++-
 kernel/time/timekeeping.c   |   60 +++++++++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 26 deletions(-)
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -319,13 +319,18 @@ struct system_counterval_t {
  * @device:		Device time
  * @sys_counter:	Clocksource counter value simultaneous with device time
  * @sys_realtime:	Realtime simultaneous with device time
+ * @sys_systime:	System time for @clock_id
  * @sys_monoraw:	Monotonic raw simultaneous with device time
  */
 struct system_device_crosststamp {
 	clockid_t			clock_id;
 	ktime_t				device;
 	struct system_counterval_t	sys_counter;
-	ktime_t				sys_realtime;
+	union {
+		/* realtime goes away once all users are converted */
+		ktime_t			sys_realtime;
+		ktime_t			sys_systime;
+	};
 	ktime_t				sys_monoraw;
 };
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1312,7 +1312,7 @@ static int adjust_historical_crosststamp
 					 struct system_device_crosststamp *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	u64 corr_raw, corr_real;
+	u64 corr_raw, corr_sys;
 	bool interp_forward;
 	int ret;
 
@@ -1329,8 +1329,7 @@ static int adjust_historical_crosststamp
 	 * Scale the monotonic raw time delta by:
 	 *	partial_history_cycles / total_history_cycles
 	 */
-	corr_raw = (u64)ktime_to_ns(
-		ktime_sub(ts->sys_monoraw, history->monoraw));
+	corr_raw = (u64)ktime_to_ns(ktime_sub(ts->sys_monoraw, history->monoraw));
 	ret = scale64_check_overflow(partial_history_cycles,
 				     total_history_cycles, &corr_raw);
 	if (ret)
@@ -1338,30 +1337,29 @@ static int adjust_historical_crosststamp
 
 	/*
 	 * If there is a discontinuity in the history, scale monotonic raw
-	 *	correction by:
-	 *	mult(real)/mult(raw) yielding the realtime correction
-	 * Otherwise, calculate the realtime correction similar to monotonic
-	 *	raw calculation
+	 * correction by:
+	 *	mult(sys)/mult(raw) yielding the system time correction
+	 *
+	 * Otherwise, calculate the system time correction similar to monotonic
+	 * raw calculation
 	 */
 	if (discontinuity) {
-		corr_real = mul_u64_u32_div
-			(corr_raw, tk->tkr_mono.mult, tk->tkr_raw.mult);
+		corr_sys = mul_u64_u32_div(corr_raw, tk->tkr_mono.mult, tk->tkr_raw.mult);
 	} else {
-		corr_real = (u64)ktime_to_ns(
-			ktime_sub(ts->sys_realtime, history->systime));
-		ret = scale64_check_overflow(partial_history_cycles,
-					     total_history_cycles, &corr_real);
+		corr_sys = (u64)ktime_to_ns(ktime_sub(ts->sys_systime, history->systime));
+		ret = scale64_check_overflow(partial_history_cycles, total_history_cycles,
+					     &corr_sys);
 		if (ret)
 			return ret;
 	}
 
-	/* Fixup monotonic raw and real time time values */
+	/* Fixup monotonic raw and system time time values */
 	if (interp_forward) {
 		ts->sys_monoraw = ktime_add_ns(history->monoraw, corr_raw);
-		ts->sys_realtime = ktime_add_ns(history->systime, corr_real);
+		ts->sys_systime = ktime_add_ns(history->systime, corr_sys);
 	} else {
 		ts->sys_monoraw = ktime_sub_ns(ts->sys_monoraw, corr_raw);
-		ts->sys_realtime = ktime_sub_ns(ts->sys_realtime, corr_real);
+		ts->sys_systime = ktime_sub_ns(ts->sys_systime, corr_sys);
 	}
 
 	return 0;
@@ -1505,16 +1503,29 @@ int get_device_system_crosststamp(int (*
 				  struct system_device_crosststamp *xtstamp)
 {
 	u64 syscnt_cycles, cycles, now, interval_start;
-	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq, clock_was_set_seq = 0;
-	ktime_t base_real, base_raw;
-	u64 nsec_real, nsec_raw;
+	ktime_t base_sys, base_raw, *offs;
+	u64 nsec_sys, nsec_raw;
 	u8 cs_was_changed_seq;
 	bool do_interp;
+	struct timekeeper *tk;
+	struct tk_data *tkd;
 	int ret;
 
+	switch (xtstamp->clock_id) {
+	case CLOCK_REALTIME:
+		tkd = &tk_core;
+		offs = &tk_core.timekeeper.offs_real;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -ENODEV;
+	}
+
+	tk = &tkd->timekeeper;
+
 	do {
-		seq = read_seqcount_begin(&tk_core.seq);
+		seq = read_seqcount_begin(&tkd->seq);
 		/*
 		 * Try to synchronously capture device time and a system
 		 * counter value calling back into the device driver
@@ -1549,15 +1560,14 @@ int get_device_system_crosststamp(int (*
 			do_interp = false;
 		}
 
-		base_real = ktime_add(tk->tkr_mono.base,
-				      tk_core.timekeeper.offs_real);
+		base_sys = ktime_add(tk->tkr_mono.base, *offs);
 		base_raw = tk->tkr_raw.base;
 
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
+		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
 		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
-	} while (read_seqcount_retry(&tk_core.seq, seq));
+	} while (read_seqcount_retry(&tkd->seq, seq));
 
-	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);
+	xtstamp->sys_systime = ktime_add_ns(base_sys, nsec_sys);
 	xtstamp->sys_monoraw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*


