Return-Path: <linux-wireless+bounces-37129-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJtJCj/wGWoX0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37129-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 21:59:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5F160825C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE0463030D87
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51C3FC5DE;
	Fri, 29 May 2026 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa9cCoI9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6D3F075C;
	Fri, 29 May 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084795; cv=none; b=JfyXrGreLDFBtQ3DFKDiLHVZHpb3Z01GHYu9CsoaiGqNJbiV0y7zJHYGE3lySM2jBNBh2v01eir3YVXx8yDjJE0OLrpmJrX7Kbh7Ddhj2EBtavSMx27FekoSYcNp3hrLa7MipjBmgJUIFW23s+MLgQfG/p7JPyHOElian3clj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084795; c=relaxed/simple;
	bh=xhmA39SYGQm2mGUCjYMu1WZjaTDl2iuPuRxkKdoLsgQ=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DA1SNyARleg+MNwq3aZjV8/VNEL0AuTaRpnQO1EEIV7IPaA8VTbMbTEzzlPxhYukbo8PZx1KwyCO5479Lo3DZCwzBuMjenCJKWzTt/k/2WouwDoDpSi2uuXLlCKihKbYEgnwJTWskdHs8CZtfTRT1fCydy01aeRJIKhl6seWfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa9cCoI9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ED81F00893;
	Fri, 29 May 2026 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084794;
	bh=dhdZlxPWnYCizWKMSosoga+5CVjWLu4Sz2vXKbAjHu4=;
	h=Date:From:To:Cc:Subject:References;
	b=Aa9cCoI9Vxn0m6gmZ/dY1ZKWRrOLoRpog6P3GNPQeb2rg1lclvXOnk05+s5BH4I1v
	 /gq4UbrKCS1hi8Ftr78JQOOXV7ZYVSWKTTpfKpQXkVJ1m5XoeQpBKpfDKqzdMcZ+a1
	 VVVPEmAcNbAL3NjxneuDKquVU+iQXpOvmSvAQDXoviPP8vww5e5spuTGolRG/7QzzY
	 mLK9IbySyOg3b+aCFenruiL1qdj7TmXkWMsrC1+419p19KsI+Ts1motS5YuurH0vbc
	 aDqAxNWTBHFA2XnyFBDROtuubFrd1wBw8SBu5EbjWhGlRFLGgfdE+pnof9uiO6wWdh
	 cEqATJQX0w0NQ==
Date: Fri, 29 May 2026 21:59:51 +0200
Message-ID: <20260529195556.971591633@kernel.org>
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
Subject: [patch V2 01/25] timekeeping: Provide ktime_get_snapshot_id()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37129-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amazon.co.uk:email]
X-Rspamd-Queue-Id: BB5F160825C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

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
captured. The result is stored in system_time_snapshot::systime, which will
replace the system_time_snapshot::real/boot members once all usage sites
have been converted.

ktime_get_snapshot() is a simple wrapper which hands in CLOCK_REALTIME as
clockid argument for the conversion period. That means CLOCK_REALTIME is
now captured twice, but that redunancy is only temporary.

As all usage sites of struct system_time_snapshot has to be updated anyway,
rename the 'raw' member to 'monoraw' for clarity.

No functional change vs. current users of ktime_get_snapshot()

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/linux/timekeeping.h |   34 ++++++++++++-----
 kernel/time/timekeeping.c   |   85 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 88 insertions(+), 31 deletions(-)
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -276,24 +276,32 @@ static inline bool ktime_get_aux_ts64(cl
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
+ * @systime:		The system time of the selected CLOCK ID
+ * @real:		Realtime system time
+ * @boot:		Boot time
+ * @raw:		Monotonic raw system time
+ * @monoraw:		Monotonic raw system time
+ * @cs_id:		Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
+ * @valid:		True if the snapshot is valid
  */
 struct system_time_snapshot {
 	u64			cycles;
+	ktime_t			systime;
 	ktime_t			real;
 	ktime_t			boot;
-	ktime_t			raw;
+	union {
+		ktime_t		raw;
+		ktime_t		monoraw;
+	};
 	enum clocksource_ids	cs_id;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
+	u8			valid;
 };
 
 /**
@@ -341,9 +349,15 @@ extern int get_device_system_crosststamp
 			struct system_device_crosststamp *xtstamp);
 
 /*
- * Simultaneously snapshot realtime and monotonic raw clocks
+ * Simultaneously snapshot a given clock with MONOTONIC_RAW and the underlying
+ * clocksource counter value.
  */
-extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
+extern void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *systime_snapshot);
+
+static inline void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
+{
+	ktime_get_snapshot_id(CLOCK_REALTIME, systime_snapshot);
+}
 
 /*
  * Persistent clock related interfaces
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1183,43 +1183,86 @@ noinstr time64_t __ktime_get_real_second
 }
 
 /**
- * ktime_get_snapshot - snapshots the realtime/monotonic raw clocks with counter
- * @systime_snapshot:	pointer to struct receiving the system time snapshot
+ * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
+ *			    CLOCK_MONOTONIC_RAW and the underlying
+ *			    clocksource counter value.
+ * @clock_id:		The clock ID to snapshot
+ * @systime_snapshot:	Pointer to struct receiving the system time snapshot
  */
-void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
+void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *systime_snapshot)
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
+		return;
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
+		return;
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
-	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
+	systime_snapshot->systime = ktime_add_ns(base_sys, offs_sys + nsec_sys);
+	systime_snapshot->real = ktime_add_ns(base_real, nsec_sys);
+	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_sys);
+	systime_snapshot->monoraw = ktime_add_ns(base_raw, nsec_raw);
+
+	/*
+	 * Special case for PTP. Just transfer the raw time into sys,
+	 * so the call sites can consistently use snap::systime.
+	 */
+	if (clock_id == CLOCK_MONOTONIC_RAW)
+		systime_snapshot->systime = systime_snapshot->monoraw;
+	/* Tell the consumer that this snapshot is valid */
+	systime_snapshot->valid = true;
 }
-EXPORT_SYMBOL_GPL(ktime_get_snapshot);
+EXPORT_SYMBOL_GPL(ktime_get_snapshot_id);
 
 /* Scale base by mult/div checking for overflow */
 static int scale64_check_overflow(u64 mult, u64 div, u64 *base)


