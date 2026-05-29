Return-Path: <linux-wireless+bounces-37138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGhdAszxGWpl0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:06:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94829608385
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE09231014DF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A73403FF;
	Fri, 29 May 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7w1dVnS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D33382C3;
	Fri, 29 May 2026 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084832; cv=none; b=C+ypWxRatv+vyxt5rXAeHtZwbfDLWX2bh4OLHN1mUOXxmPy/n9ZiqIkn2UOg+Fl9rX8uKtqbw85U89nItudGp3D3B1NypEmpHOeVyyBfWCEY9KTBjftZHd8QBWs4akb5As4h49zhgHezA1D82CBA7h317ng6BJDcfPG3ghEyk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084832; c=relaxed/simple;
	bh=3+zAdRIstwLiKcqqYWsWz0zrcfL5clt9y/+hnYFosms=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EAq227YUzqhdKS8VmBt9/e8xnjlA5N7x3UzSLz9BlBU/BgOwm4PpB7lGV2hYlB3yNua11ugERAHQcGA7hDCL7rzCkewuCSW6HlD/5qlkpb+fwPnzDwZLCqrN6VOizHOgvT+mZdK81tMS6QdztiRZlskFhPGcBl/EshQtBYtW7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7w1dVnS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588F01F00893;
	Fri, 29 May 2026 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084831;
	bh=TzOBzjOs2Y3thGFeNAC6uYTpbahSBfsnJF7q+sb4muo=;
	h=Date:From:To:Cc:Subject:References;
	b=T7w1dVnS6RGSh5lLSprQBqHkcvkciS4XaObr1QWBp4a16D/pl9thRyN84dy3Baxm3
	 IOhk16z+uzswmYrKybIm6t3T+ph9GnIq1IflbRFwkqdy6eNx8KO88S8gBAsbWHlucH
	 O21PbTztzvfLjkKCRTnck+mU75QfD69rqATkIj1IYtx5Zi8bkSgcgy60AWwteeml+s
	 hX9cW/bmYo1vQo/q4xOnpi039bjn4DZKlU5UlzsFtUirOQCPKqOfI5u/O2brA8zVgm
	 yhAczfNyGl/jHn4gBpvdmjf+DjeGUOWjjtkI276ynfyXYWbPpecuyMDuM04swRf1Rf
	 yO/MmMLwDYRVg==
Date: Fri, 29 May 2026 22:00:28 +0200
Message-ID: <20260529195557.429406675@kernel.org>
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
Subject: [patch V2 10/25] timekeeping: Add system_counterval_t to struct
 system_device_crosststamp
References: <20260529193435.921555544@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37138-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amazon.co.uk:email]
X-Rspamd-Queue-Id: 94829608385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

An upcoming extension to the PTP IOCTL requires to return the system counter
value and the clocksource ID to user space. get_device_system_crosststamp() has
this information already.

Extend struct system_device_crosststamp with a system_counterval_t member
and fill in the data.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
@@ -1418,6 +1418,8 @@ static bool convert_base_to_cs(struct sy
 		return false;
 
 	scv->cycles += base->offset;
+	/* Set the clocksource ID as scv::cycles is now clocksource based */
+	scv->cs_id = cs->id;
 	return true;
 }
 
@@ -1485,11 +1487,11 @@ EXPORT_SYMBOL_GPL(ktime_real_to_base_clo
 
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
@@ -1502,14 +1504,12 @@ int get_device_system_crosststamp(int (*
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
 
@@ -1519,19 +1519,20 @@ int get_device_system_crosststamp(int (*
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
@@ -1573,24 +1574,19 @@ int get_device_system_crosststamp(int (*
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
 


