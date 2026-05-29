Return-Path: <linux-wireless+bounces-37153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GfPAqfzGWp/0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:14:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9E608571
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8132320BCFE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38110478874;
	Fri, 29 May 2026 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoIJ6+D+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C646AF1A;
	Fri, 29 May 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084893; cv=none; b=CXvu05cAEWw5IbnwcKRlKjPi8NyaKfN0NsVkic877GmCWHviPyZ5P0IMSe6uJKfXuPBbcb9L58n5ZaSx/rMMlTQ4EzyiikOlogHZGppUx9UcQ49Ef2kYfn5prGX9gBV5toMkRCudgJfXERF1ey0blIw9/I/8Eglpc9vH67fE8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084893; c=relaxed/simple;
	bh=kwziQxddCjRLWd+LZyTMpuLKnxl6q8axFDhA+IJke1s=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qMrPnWo0p4xUnpiOVnrwuo6RNIVPNhlfxeDDNSaXT9TgMY1eoWhxIc808tKt94wFkSytjfkPeGbMbWadslOEiE///oK9abvzXFEAlOU4TnB4GaJpT9dgkHL+4IvIGxhaLZH0FV0D2ln0+WMJKa9e7KtEjRF2+Ov51sfeAQ8g5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoIJ6+D+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1813E1F00893;
	Fri, 29 May 2026 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084891;
	bh=vtDlx0A2apUAGk72aYX84Fpf+lBjUArU9MGq0g9VqA8=;
	h=Date:From:To:Cc:Subject:References;
	b=LoIJ6+D+N2zwIzc7Zr3CBMruHQIrUvGg8I0i7e14rrlnxo5OrmFB9l1VCB5bVOJ5v
	 joB86liAx3bIpBVh03DJ8nIPQIZXXJQ1InXGQIx9C28gAYmXHOG3h9aNOjLtTlCnMh
	 vusvS9+32IFpvPmNBUCl7rNPlFlB7YIk2Fu93TGLTsUyz1EmUxQ47gSCnQVvjG1d4g
	 XsPxF0BHH8H2LuUOjB6TZ+lxAggQUxhYAH8iETXc6O/k5TS5i3hgPZ6ZySTJ27gTyU
	 Pp5R8uXe7A2ZUlrjMsykFXmvenJBzev3w0MmZ7G13BTlxNBsHGalnKd40f+Ua+kJH9
	 rZa7/5pCNROUw==
Date: Fri, 29 May 2026 22:01:29 +0200
Message-ID: <20260529195558.202568489@kernel.org>
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
Subject: [patch V2 25/25] timekeeping: Add clocksource read_snapshot() method
 and hw_cycles to snapshot
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37153-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: A1E9E608571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Add a read_snapshot() callback to struct clocksource which returns the
derived clocksource value while also providing the underlying hardware
counter reading and the related clocksource ID.

This allows ktime_get_snapshot_id() to populate new hw_cycles and hw_csid
fields in struct system_time_snapshot.

For clocksources that are derived from an underlying counter (e.g., Hyper-V
TSC page scales TSC to 10MHz, kvmclock scales TSC to 1GHz), this provides
atomic access to both the derived value needed for timekeeping
calculations, and the raw hardware counter needed by consumers like KVM's
master clock and the vmclock PTP driver.

[ tglx: Reworked it slightly ]

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Assisted-by: Kiro:claude-opus-4.6-1m
Link: https://patch.msgid.link/20260526230635.136914-1-dwmw2@infradead.org
---
 include/linux/clocksource.h |   24 ++++++++++++++++++++++++
 include/linux/timekeeping.h |    6 ++++++
 kernel/time/timekeeping.c   |   21 ++++++++++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -32,6 +32,21 @@ struct module;
 #include <vdso/clocksource.h>
 
 /**
+ * struct clocksource_hw_snapshot - Snapshot for the underlying hardware counter of derived
+ *				    clocksources like kvmclock or Hyper-V scaled TSC
+ * @hw_cycles:		The hardware counter value
+ * @hw_csid:		Clocksource ID of the hardware counter
+ *
+ * Such clocksources must implement the read_snapshot() callback and fill in the
+ * hardware counter value, the clocksource ID of the hardware counter and derive
+ * the actual clocksource cycles from @hw_cycles to provide an atomic snapshot
+ */
+struct clocksource_hw_snapshot {
+	u64			hw_cycles;
+	enum clocksource_ids	hw_csid;
+};
+
+/**
  * struct clocksource - hardware abstraction for a free running counter
  *	Provides mostly state-free accessors to the underlying hardware.
  *	This is the structure used for system time.
@@ -72,6 +87,14 @@ struct module;
  * @flags:		Flags describing special properties
  * @base:		Hardware abstraction for clock on which a clocksource
  *			is based
+ * @read_snapshot:	Extended @read() function for clocksources such as
+ *			kvmclock or the Hyper-V scaled TSC where the actual
+ *			clocksource value for timekeeping is calculated from an
+ *			underlying hardware counter. Returns the timekeeping
+ *			relevant cycle value and stores the raw value of the
+ *			underlying counter from which it was calculated
+ *			including the clocksource ID of that counter in the
+ *			clocksource hardware snapshot.
  * @enable:		Optional function to enable the clocksource
  * @disable:		Optional function to disable the clocksource
  * @suspend:		Optional suspend function for the clocksource
@@ -113,6 +136,7 @@ struct clocksource {
 	unsigned long		flags;
 	struct clocksource_base *base;
 
+	u64			(*read_snapshot)(struct clocksource *cs, struct clocksource_hw_snapshot *chs);
 	int			(*enable)(struct clocksource *cs);
 	void			(*disable)(struct clocksource *cs);
 	void			(*suspend)(struct clocksource *cs);
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -279,18 +279,24 @@ static inline bool ktime_get_aux_ts64(cl
  * struct system_time_snapshot - Simultaneous time capture of CLOCK_MONOTONIC_RAW,
  *				 a selected CLOCK_* and the clocksource counter value
  * @cycles:		Clocksource counter value to produce the system times
+ * @hw_cycles:		For derived clocksources, the hardware counter value from
+ *			which @cycles was derived
  * @systime:		The system time of the selected CLOCK ID
  * @monoraw:		Monotonic raw system time
  * @cs_id:		Clocksource ID
+ * @hw_csid:		Clocksource ID of the underlying hardware counter for derived
+ *			clocksources which implement the read_snapshot() callback.
  * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  * @valid:		True if the snapshot is valid
  */
 struct system_time_snapshot {
 	u64			cycles;
+	u64			hw_cycles;
 	ktime_t			systime;
 	ktime_t			monoraw;
 	enum clocksource_ids	cs_id;
+	enum clocksource_ids	hw_csid;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
 	u8			valid;
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -320,6 +320,7 @@ static __always_inline u64 tk_clock_read
 
 	return clock->read(clock);
 }
+
 static inline void clocksource_disable_inline_read(void) { }
 static inline void clocksource_enable_inline_read(void) { }
 #endif
@@ -1187,6 +1188,18 @@ noinstr time64_t __ktime_get_real_second
 	return tk->xtime_sec;
 }
 
+static inline u64 tk_clock_read_snapshot(const struct tk_read_base *tkr,
+					 struct clocksource_hw_snapshot *chs)
+{
+	struct clocksource *clock = READ_ONCE(tkr->clock);
+
+	if (unlikely(clock->read_snapshot))
+		return clock->read_snapshot(clock, chs);
+
+	return clock->read(clock);
+}
+
+
 /**
  * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
  *			    CLOCK_MONOTONIC_RAW and the underlying
@@ -1237,14 +1250,20 @@ void ktime_get_snapshot_id(clockid_t clo
 	tk = &tkd->timekeeper;
 
 	do {
+		struct clocksource_hw_snapshot chs = { };
+
 		seq = read_seqcount_begin(&tkd->seq);
 
 		/* Aux clocks can be invalid */
 		if (!tk->clock_valid)
 			return;
 
-		now = tk_clock_read(&tk->tkr_mono);
+		now = tk_clock_read_snapshot(&tk->tkr_mono, &chs);
 		systime_snapshot->cs_id = tk->tkr_mono.clock->id;
+
+		systime_snapshot->hw_cycles = chs.hw_cycles;
+		systime_snapshot->hw_csid = chs.hw_csid;
+
 		systime_snapshot->cs_was_changed_seq = tk->cs_was_changed_seq;
 		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
 


