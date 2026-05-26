Return-Path: <linux-wireless+bounces-36914-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJgSC17ZFWpYdAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36914-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:33:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B05DAB94
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B71C131C68FF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEDE40B6C3;
	Tue, 26 May 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNQ8Fpi9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F54014AA;
	Tue, 26 May 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815662; cv=none; b=jYIhfFlyR9akjz5CH3ersmvAUsUo0Ut+TjU/VOSAbLTQaxGtmE0naIS+aIDH8tI6Opamn/VkfeILHe/7bkddjqfdJbjnQUkA+DqonRmCvTSSBZ6Pwof2D8k6aFttM/UGxtmgXZvn8h9NP1BT9FoLzW9QqpKuxTQ7RQQrJvj0/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815662; c=relaxed/simple;
	bh=dWNNq8fiVdN+WDn5GaHOJN6Ksagnh/2Qvk/I2pZv9Mo=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jl1ZPB8C4esoYtlgcqvffbkfeFzZANg6zSBSxp2nZ19a1Q64pGsgwtXxIxE8fu7WzDolNO966DiOwhLKVfKO/ZJoEWK6e8rInd+0+EwAAyTedeEtO8kOlKQUUN8uRDzyH4W45HGWn3M9iHaiT9PsTqekYC7TW/FOvppRioD0mMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNQ8Fpi9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6C7D81F000E9;
	Tue, 26 May 2026 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815661;
	bh=2Gq19z55uKjR3IXd+Mf/0eopO8jyNxR32nvzywhnfzI=;
	h=Date:From:To:Cc:Subject:References;
	b=KNQ8Fpi9iZlj3+1Cud0AjFzYzrb4qE+FuB+PtNH7FF1OlfYdHD+MTKwjSnqwDpfiG
	 1aP66+EKqeHTWGg3aBmH6GGysrfHyMbErmvGGpOHjeThjx+1GmwArVVMtH94mh3Fv6
	 DMckC587PN3NKElqHVViXVXVSzeFFCmBABt2//r2GeEaA+jWnvntM34t+FvLYgpT0+
	 G3XsPvZ/OmX7ebup8xGR7ONWQS2ha94Z20gNU4bbE9kV9vz7EBudIzebz8Dw8+/wDa
	 xJe6NpVHvzzc4mmjSEhF/qXwzt0Q1/E5iLSItZI6ghRpt3V3nwlH+iGNA7wcR3mUxE
	 8D/Iag8nJH8Wg==
Date: Tue, 26 May 2026 19:14:18 +0200
Message-ID: <20260526171223.448889379@kernel.org>
User-Agent: quilt/0.68
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
 linux-sound@vger.kernel.org
Subject: [patch 10/24] timekeeping: Add system_counterval_t to struct
 system_device_crosststamp
References: <20260526165826.392227559@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36914-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C33B05DAB94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

An upcoming extension to the PTP IOCTL requires to return the system counter
value and the clocksource ID to user space. get_device_system_crosststamp() has
this information already.

Extend struct system_device_crosststamp with a system_counterval_t member
and fill in the data.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/timekeeping.h |   28 ++++++++++++++------------
 kernel/time/timekeeping.c   |   46 ++++++++++++++++++++------------------------
 2 files changed, 36 insertions(+), 38 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -297,19 +297,6 @@ struct system_time_snapshot {
 };
 
 /**
- * struct system_device_crosststamp - system/device cross-timestamp
- *				      (synchronized capture)
- * @device:		Device time
- * @sys_realtime:	Realtime simultaneous with device time
- * @sys_monoraw:	Monotonic raw simultaneous with device time
- */
-struct system_device_crosststamp {
-	ktime_t device;
-	ktime_t sys_realtime;
-	ktime_t sys_monoraw;
-};
-
-/**
  * struct system_counterval_t - system counter value with the ID of the
  *				corresponding clocksource
  * @cycles:	System counter value
@@ -325,6 +312,21 @@ struct system_counterval_t {
 	bool			use_nsecs;
 };
 
+/**
+ * struct system_device_crosststamp - system/device cross-timestamp
+ *				      (synchronized capture)
+ * @device:		Device time
+ * @sys_counter:	Clocksource counter value simultaneous with device time
+ * @sys_realtime:	Realtime simultaneous with device time
+ * @sys_monoraw:	Monotonic raw simultaneous with device time
+ */
+struct system_device_crosststamp {
+	ktime_t				device;
+	struct system_counterval_t	sys_counter;
+	ktime_t				sys_realtime;
+	ktime_t				sys_monoraw;
+};
+
 extern bool ktime_real_to_base_clock(ktime_t treal,
 				     enum clocksource_ids base_id, u64 *cycles);
 extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1419,6 +1419,8 @@ static bool convert_base_to_cs(struct sy
 		return false;
 
 	scv->cycles += base->offset;
+	/* Set the clocksource ID as scv::cycles is now clocksource based */
+	scv->cs_id = cs->id;
 	return true;
 }
 
@@ -1486,11 +1488,11 @@ EXPORT_SYMBOL_GPL(ktime_real_to_base_clo
 
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
- * @get_time_fn:	Callback to get simultaneous device time and
- *	system counter from the device driver
+ * @get_time_fn:	Callback to get simultaneous device time and system counter
+ *			from the device driver
  * @ctx:		Context passed to get_time_fn()
- * @history_begin:	Historical reference point used to interpolate system
- *	time when counter provided by the driver is before the current interval
+ * @history_begin:	Historical reference point used to interpolate system time when
+ *			the counter value provided by the driver is before the current interval
  * @xtstamp:		Receives simultaneously captured system and device time
  *
  * Reads a timestamp from a device and correlates it to system time
@@ -1503,14 +1505,12 @@ int get_device_system_crosststamp(int (*
 				  struct system_time_snapshot *history_begin,
 				  struct system_device_crosststamp *xtstamp)
 {
-	struct system_counterval_t system_counterval = {};
+	u64 syscnt_cycles, cycles, now, interval_start;
 	struct timekeeper *tk = &tk_core.timekeeper;
-	u64 cycles, now, interval_start;
-	unsigned int clock_was_set_seq = 0;
+	unsigned int seq, clock_was_set_seq = 0;
 	ktime_t base_real, base_raw;
 	u64 nsec_real, nsec_raw;
 	u8 cs_was_changed_seq;
-	unsigned int seq;
 	bool do_interp;
 	int ret;
 
@@ -1520,19 +1520,20 @@ int get_device_system_crosststamp(int (*
 		 * Try to synchronously capture device time and a system
 		 * counter value calling back into the device driver
 		 */
-		ret = get_time_fn(&xtstamp->device, &system_counterval, ctx);
+		ret = get_time_fn(&xtstamp->device, &xtstamp->sys_counter, ctx);
 		if (ret)
 			return ret;
 
 		/*
 		 * Verify that the clocksource ID associated with the captured
 		 * system counter value is the same as for the currently
-		 * installed timekeeper clocksource
+		 * installed timekeeper clocksource and convert to it.
 		 */
-		if (system_counterval.cs_id == CSID_GENERIC ||
-		    !convert_base_to_cs(&system_counterval))
+		if (xtstamp->sys_counter.cs_id == CSID_GENERIC ||
+		    !convert_base_to_cs(&xtstamp->sys_counter))
 			return -ENODEV;
-		cycles = system_counterval.cycles;
+
+		cycles = syscnt_cycles = xtstamp->sys_counter.cycles;
 
 		/*
 		 * Check whether the system counter value provided by the
@@ -1574,24 +1575,19 @@ int get_device_system_crosststamp(int (*
 		 * clocksource change
 		 */
 		if (!history_begin ||
-		    !timestamp_in_interval(history_begin->cycles,
-					   cycles, system_counterval.cycles) ||
+		    !timestamp_in_interval(history_begin->cycles, cycles, syscnt_cycles) ||
 		    history_begin->cs_was_changed_seq != cs_was_changed_seq)
 			return -EINVAL;
-		partial_history_cycles = cycles - system_counterval.cycles;
+
+		partial_history_cycles = cycles - syscnt_cycles;
 		total_history_cycles = cycles - history_begin->cycles;
-		discontinuity =
-			history_begin->clock_was_set_seq != clock_was_set_seq;
+		discontinuity = history_begin->clock_was_set_seq != clock_was_set_seq;
 
-		ret = adjust_historical_crosststamp(history_begin,
-						    partial_history_cycles,
-						    total_history_cycles,
-						    discontinuity, xtstamp);
-		if (ret)
-			return ret;
+		ret = adjust_historical_crosststamp(history_begin, partial_history_cycles,
+						    total_history_cycles, discontinuity, xtstamp);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 


