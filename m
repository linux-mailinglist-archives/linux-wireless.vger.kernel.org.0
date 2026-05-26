Return-Path: <linux-wireless+bounces-36906-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFavMyfVFWrRcgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36906-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:15:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 667345DA73D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8E043018747
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F740DFCF;
	Tue, 26 May 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzCPuMax"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACC405C40;
	Tue, 26 May 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815625; cv=none; b=KaVlg54ZSLeoidr6npWAOeBUapBkHZe3Szz2JaAvUfPn1/HAuk3zqxDX6ifuSng2x3lorrB0XJF4CLWKepxOpOE1pQTt2acTmDvOysvKHUhhkcLNqNKzL0MXvcun5POdCB46m+ZlxOKcwkchDaWy4w6wNrI1CCm8VuBAu6nHlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815625; c=relaxed/simple;
	bh=/uIxxcW/VKW7V6tqmh6Hwrv4myf2hGcVB+nmBbsM4O0=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m35RBSP7Kfx1XMbzGHJXa5d8qvv0dUHW7IhT43nDj5iSq+t6bjIRkZ4pyQzXeb4Pf2GcUIuSa7jYeHEKjBqF3Qb7mrEVqyHZ2QTHLpiYuGZMeTG6/Uhfg0nRkuSaVycVRAmB1tmAX8uBPw+snr/eSPWvBa/BjuxGxf34S9Cxiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzCPuMax; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 308DD1F00A3E;
	Tue, 26 May 2026 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815617;
	bh=C2RjMS9VQOGkJN1go0lhI1NDtbLN/H1nTVa2BdBDyCY=;
	h=Date:From:To:Cc:Subject:References;
	b=XzCPuMaxP2oFxIaAt7DXedzD5bIxlbBx7ED2ib8msOaomyI8z4WFTt+xTSXFYvexl
	 DpA3ow5UqhjSkEwvKDhBUuj1H4vMFzDvFLyWfSk6msiow2Nu7rNop71fPeVr+oXahH
	 qnEJ/D57j/KxJhWDOAx7SQVdqFCATBIBamxIeu7vh8rhNpA9wkL5JxR1YUBLD+qjjZ
	 zU5yWGiCv1A9fHt+Q0RJzNKj8RSg9aJ9hqJ8cLkj6Z/aAe65jO3MYiVk++A/wGPch7
	 w5109BrM7Sd/pzDcES4IE6i7IKyo7GYPZs9g5ZD2UxXVDoRPjV7D0SaSFevQcLxjXj
	 uOHOY9vOofjmQ==
Date: Tue, 26 May 2026 19:13:33 +0200
Message-ID: <20260526171222.769770418@kernel.org>
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
Subject: [patch 01/24] timekeeping: Provide ktime_get_snapshot_id()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36906-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 667345DA73D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ktime_get_snapshot() provides a snapshot of the underlying clocksource
counter value and the corresponding CLOCK_MONOTONIC_RAW, CLOCK_REALTIME and
CLOCK_BOOTTIME timestamps.

There is no usage of CLOCK_REALTIME and CLOCK_BOOTTIME at the same time and
CLOCK_BOOTTIME support was just added for the ARM64 KVM tracing mechanism,
which needs CLOCK_BOOTTIME and the underlying clocksource counter value.

ktime_get_snapshot() is also not suitable for usage with CLOCK_AUX, but
that's a prerequisite to support PTP hardware timestamping for CLOCK_AUX
steering.

As a first step, rename ktime_get_snapshot() to ktime_get_snapshot_id(),
which now takes a clockid argument to select the clock which needs to be
captured. The result is stored in system_time_snapshot::sys, which will
replace the system_time_snapshot::real/boot members once all usage sites
have been converted.

ktime_get_snapshot() is a simple wrapper which hands in CLOCK_REALTIME as
clockid argument for the conversion period. That means CLOCK_REALTIME is
now captured twice, but that redunancy is only temporary.

No functional change vs. current users of ktime_get_snapshot()

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/timekeeping.h |   29 ++++++++++-----
 kernel/time/timekeeping.c   |   84 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 84 insertions(+), 29 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -276,24 +276,28 @@ static inline bool ktime_get_aux_ts64(cl
 #endif
 
 /**
- * struct system_time_snapshot - simultaneous raw/real time capture with
- *				 counter value
- * @cycles:	Clocksource counter value to produce the system times
- * @real:	Realtime system time
- * @boot:	Boot time
- * @raw:	Monotonic raw system time
- * @cs_id:	Clocksource ID
+ * struct system_time_snapshot - Simultaneous time capture of CLOCK_MONOTONIC_RAW,
+ *				 a selected CLOCK_* and the clocksource counter value
+ * @cycles:		Clocksource counter value to produce the system times
+ * @sys:		The system time of the selected CLOCK ID
+ * @real:		Realtime system time
+ * @boot:		Boot time
+ * @raw:		Monotonic raw system time
+ * @cs_id:		Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
+ * @valid:		True if the snapshot is valid
  */
 struct system_time_snapshot {
 	u64			cycles;
+	ktime_t			sys;
 	ktime_t			real;
 	ktime_t			boot;
 	ktime_t			raw;
 	enum clocksource_ids	cs_id;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
+	u8			valid;
 };
 
 /**
@@ -341,9 +345,16 @@ extern int get_device_system_crosststamp
 			struct system_device_crosststamp *xtstamp);
 
 /*
- * Simultaneously snapshot realtime and monotonic raw clocks
+ * Simultaneously snapshot a given clock with MONOTONIC_RAW and the underlying
+ * clocksource counter value.
  */
-extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
+extern bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot,
+				  clockid_t clock_id);
+
+static inline void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
+{
+	WARN_ON_ONCE(!ktime_get_snapshot_id(systime_snapshot, CLOCK_REALTIME));
+}
 
 /*
  * Persistent clock related interfaces
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1183,43 +1183,87 @@ noinstr time64_t __ktime_get_real_second
 }
 
 /**
- * ktime_get_snapshot - snapshots the realtime/monotonic raw clocks with counter
- * @systime_snapshot:	pointer to struct receiving the system time snapshot
+ * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
+ *			    CLOCK_MONOTONIC_RAW and the underlying
+ *			    clocksource counter value.
+ * @systime_snapshot:	Pointer to struct receiving the system time snapshot
+ * @clock_id:		The clock ID to snapshot
  */
-void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
+bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clockid_t clock_id)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t base_raw, base_sys, offs_sys, *offs, offs_zero = 0;
+	u64 nsec_raw, nsec_sys, now;
+	struct timekeeper *tk;
+	struct tk_data *tkd;
 	unsigned int seq;
-	ktime_t base_raw;
 	ktime_t base_real;
 	ktime_t base_boot;
-	u64 nsec_raw;
-	u64 nsec_real;
-	u64 now;
 
-	WARN_ON_ONCE(timekeeping_suspended);
+	/* Invalidate the snapshot for all failure cases */
+	systime_snapshot->valid = false;
+
+	if (WARN_ON_ONCE(timekeeping_suspended))
+		return false;
+
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+		tkd = &tk_core;
+		offs = &tk_core.timekeeper.offs_real;
+		break;
+	/* Map RAW to MONOTONIC so the loop below is trivial */
+	case CLOCK_MONOTONIC_RAW:
+	case CLOCK_MONOTONIC:
+		tkd = &tk_core;
+		offs = &offs_zero;
+		break;
+	case CLOCK_BOOTTIME:
+		tkd = &tk_core;
+		offs = &tk_core.timekeeper.offs_boot;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	tk = &tkd->timekeeper;
 
 	do {
-		seq = read_seqcount_begin(&tk_core.seq);
+		seq = read_seqcount_begin(&tkd->seq);
+
 		now = tk_clock_read(&tk->tkr_mono);
 		systime_snapshot->cs_id = tk->tkr_mono.clock->id;
 		systime_snapshot->cs_was_changed_seq = tk->cs_was_changed_seq;
 		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
-		base_real = ktime_add(tk->tkr_mono.base,
-				      tk_core.timekeeper.offs_real);
-		base_boot = ktime_add(tk->tkr_mono.base,
-				      tk_core.timekeeper.offs_boot);
+
+		base_sys = tk->tkr_mono.base;
+		offs_sys = *offs;
 		base_raw = tk->tkr_raw.base;
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
-		nsec_raw  = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
-	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+		/* Kept around until the callers are fixed up */
+		base_real = ktime_add(base_sys, tk_core.timekeeper.offs_real);
+		base_boot = ktime_add(base_sys, tk_core.timekeeper.offs_boot);
+
+		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
+		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
+	} while (read_seqcount_retry(&tkd->seq, seq));
 
 	systime_snapshot->cycles = now;
-	systime_snapshot->real = ktime_add_ns(base_real, nsec_real);
-	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_real);
+	systime_snapshot->sys = ktime_add_ns(base_sys, offs_sys + nsec_sys);
+	systime_snapshot->real = ktime_add_ns(base_real, nsec_sys);
+	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_sys);
 	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
+
+	/*
+	 * Special case for PTP. Just transfer the raw time into sys,
+	 * so the call sites can consistently use snap::sys.
+	 */
+	if (clock_id == CLOCK_MONOTONIC_RAW)
+		systime_snapshot->sys = systime_snapshot->raw;
+	/* Tell the consumer that this snapshot is valid */
+	systime_snapshot->valid = true;
+	return true;
 }
-EXPORT_SYMBOL_GPL(ktime_get_snapshot);
+EXPORT_SYMBOL_GPL(ktime_get_snapshot_id);
 
 /* Scale base by mult/div checking for overflow */
 static int scale64_check_overflow(u64 mult, u64 div, u64 *base)


