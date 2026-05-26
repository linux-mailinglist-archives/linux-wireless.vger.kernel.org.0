Return-Path: <linux-wireless+bounces-36928-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DO0D63YFWpYdAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36928-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:30:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21B5DAB04
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC1D63024E00
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05F41C302;
	Tue, 26 May 2026 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixngS4Sn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99D41C2FB;
	Tue, 26 May 2026 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815732; cv=none; b=rW1i0n9iGhwgNiqOrhn6CPtjyuwjgXKzZGRnQ0gl+ftxt4VfisWMvV9SmPbQ6FEffN1a9WltDgfkPV+qwCFMPym6/IU/w9+PXzfxOu/+q8zxnmj6t2NNzl2ogSkoXif5FU1pDD8GqCqBM1FaFft+eTa9BPPUoWtLf/ZxjqGY0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815732; c=relaxed/simple;
	bh=x+DEaPvKv7TQz/Zz8vDRySswulFxfroGrLWhxyBmfJM=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZAk6jwz9Q9OLmX3838kFRJhgC1TDpHpJOG8rOJp+fk64zsMgI86LBfKSYYlsEDcKvyEkBilfpizf19BysWfM2G+fFyluOTkQMfHIwSXBf8npwf7aEbLF3Oz29NpEdEP8RSjfWnMNCDz/WZ+l3zJf/vqG7FDSu0M4K78odAKL2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixngS4Sn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A379E1F000E9;
	Tue, 26 May 2026 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815730;
	bh=a4FYRpF1UYnCO8X4b7Ms8Ubqb9G1rX4iNVRYaeabgIQ=;
	h=Date:From:To:Cc:Subject:References;
	b=ixngS4SnkGLyqGeipEEwuirzm/HHZxpkH7kvwDyAyEK24rrwJT/ZQ101v2Cx4uWVn
	 JgGTIBZ5UNi2TzcfUlL9RV/Fmon0QpUgY5LCPlPxe0EFOITmBrBDrfZOUwMBlKqcPh
	 Qtx9WenveUCT9y9lpoQMVFRE5WRX02W6gtVRBQBOCQdxY50L15drAfLSX5puBpeeCf
	 A+SuRtbTKPyWL3ur4a/SISfMATT1S9BwY2xZM9y/LU2qrzGExLZ05B08iEO58KdJHG
	 gb3dwQX8Az1X5YalJgJXToi9tu7Gq4cWGAd3OmdRzY4rEuVGAWjQqSF3eUsWnJrf6i
	 Jcs6AoAq3kAZg==
Date: Tue, 26 May 2026 19:15:27 +0200
Message-ID: <20260526171224.499777655@kernel.org>
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
Subject: [patch 24/24] ptp: Switch to ktime_get_snapshot_id() for pre/post
 timestamps
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36928-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D21B5DAB04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To prepare for a new PTP IOCTL, which exposes the raw counter value along
with the requested system time snapshot, switch the pre/post time stamp
sampling over to use ktime_get_snapshot_id() and fix up all usage sites.

No functional change intended.

The ptp_vmclock conversion was simplified by David Woodhouse.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c |    8 ++++----
 drivers/ptp/ptp_chardev.c              |   14 +++++++++-----
 drivers/ptp/ptp_ocp.c                  |   11 ++++-------
 drivers/ptp/ptp_vmclock.c              |   23 +++++++----------------
 include/linux/ptp_clock_kernel.h       |   15 ++++++++-------
 5 files changed, 32 insertions(+), 39 deletions(-)

--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2310,10 +2310,10 @@ int sja1105_static_config_reload(struct
 		goto out;
 	}
 
-	t1 = timespec64_to_ns(&ptp_sts_before.pre_ts);
-	t2 = timespec64_to_ns(&ptp_sts_before.post_ts);
-	t3 = timespec64_to_ns(&ptp_sts_after.pre_ts);
-	t4 = timespec64_to_ns(&ptp_sts_after.post_ts);
+	t1 = ktime_to_ns(ptp_sts_before.pre_sts.sys);
+	t2 = ktime_to_ns(ptp_sts_before.post_sts.sys);
+	t3 = ktime_to_ns(ptp_sts_after.pre_sts.sys);
+	t4 = ktime_to_ns(ptp_sts_after.post_sts.sys);
 	/* Mid point, corresponds to pre-reset PTPCLKVAL */
 	t12 = t1 + (t2 - t1) / 2;
 	/* Mid point, corresponds to post-reset PTPCLKVAL, aka 0 */
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -386,15 +386,19 @@ static long ptp_sys_offset_extended(stru
 			return err;
 
 		/* Filter out disabled or unavailable clocks */
-		if (sts.pre_ts.tv_sec < 0 || sts.post_ts.tv_sec < 0)
+		if (!sts.pre_sts.valid || !sts.post_sts.valid)
 			return -EINVAL;
 
-		extoff->ts[i][0].sec = sts.pre_ts.tv_sec;
-		extoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
 		extoff->ts[i][1].sec = ts.tv_sec;
 		extoff->ts[i][1].nsec = ts.tv_nsec;
-		extoff->ts[i][2].sec = sts.post_ts.tv_sec;
-		extoff->ts[i][2].nsec = sts.post_ts.tv_nsec;
+
+		ts = ktime_to_timespec64(sts.pre_sts.sys);
+		extoff->ts[i][0].sec = ts.tv_sec;
+		extoff->ts[i][0].nsec = ts.tv_nsec;
+
+		ts = ktime_to_timespec64(sts.post_sts.sys);
+		extoff->ts[i][2].sec = ts.tv_sec;
+		extoff->ts[i][2].nsec = ts.tv_nsec;
 	}
 
 	return copy_to_user(arg, extoff, sizeof(*extoff)) ? -EFAULT : 0;
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1491,11 +1491,8 @@ static int
 	}
 	ptp_read_system_postts(sts);
 
-	if (sts && bp->ts_window_adjust) {
-		s64 ns = timespec64_to_ns(&sts->post_ts);
-
-		sts->post_ts = ns_to_timespec64(ns - bp->ts_window_adjust);
-	}
+	if (sts && bp->ts_window_adjust)
+		sts->post_ts.sys -= bp->ts_window_adjust;
 
 	time_ns = ioread32(&bp->reg->time_ns);
 	time_sec = ioread32(&bp->reg->time_sec);
@@ -4595,8 +4592,8 @@ ptp_ocp_summary_show(struct seq_file *s,
 		struct timespec64 sys_ts;
 		s64 pre_ns, post_ns, ns;
 
-		pre_ns = timespec64_to_ns(&sts.pre_ts);
-		post_ns = timespec64_to_ns(&sts.post_ts);
+		pre_ns = ktime_to_ns(sts.pre_sts.sys);
+		post_ns = ktime_to_ns(sts.post_sts.sys);
 		ns = (pre_ns + post_ns) / 2;
 		ns += (s64)bp->utc_tai_offset * NSEC_PER_SEC;
 		sys_ts = ns_to_timespec64(ns);
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -101,7 +101,6 @@ static int vmclock_get_crosststamp(struc
 				   struct timespec64 *tspec)
 {
 	ktime_t deadline = ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
-	struct system_time_snapshot systime_snapshot;
 	uint64_t cycle, delta, seq, frac_sec;
 
 #ifdef CONFIG_X86
@@ -132,17 +131,15 @@ static int vmclock_get_crosststamp(struc
 		 * will be derived from the *same* counter value.
 		 *
 		 * If the system isn't using the same counter, then the value
-		 * from ktime_get_snapshot_id() will still be used as pre_ts, and
-		 * ptp_read_system_postts() is called to populate postts after
-		 * calling get_cycles().
-		 *
-		 * The conversion to timespec64 happens further down, outside
-		 * the seq_count loop.
+		 * from ptp_read_system_prets() will still be used as pre_ts,
+		 * and ptp_read_system_postts() is called to populate postts
+		 * after calling get_cycles().
 		 */
 		if (sts) {
-			ktime_get_snapshot_id(&systime_snapshot, CLOCK_REALTIME);
-			if (systime_snapshot.cs_id == st->cs_id) {
-				cycle = systime_snapshot.cycles;
+			ptp_read_system_prets(sts);
+			if (sts->pre_sts.cs_id == st->cs_id) {
+				cycle = sts->pre_sts.cycles;
+				sts->post_sts = sts->pre_sts;
 			} else {
 				cycle = get_cycles();
 				ptp_read_system_postts(sts);
@@ -180,12 +177,6 @@ static int vmclock_get_crosststamp(struc
 		system_counter->cs_id = st->cs_id;
 	}
 
-	if (sts) {
-		sts->pre_ts = ktime_to_timespec64(systime_snapshot.sys);
-		if (systime_snapshot.cs_id == st->cs_id)
-			sts->post_ts = sts->pre_ts;
-	}
-
 	return 0;
 }
 
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -12,6 +12,7 @@
 #include <linux/pps_kernel.h>
 #include <linux/ptp_clock.h>
 #include <linux/timecounter.h>
+#include <linux/timekeeping.h>
 #include <linux/skbuff.h>
 
 #define PTP_CLOCK_NAME_LEN	32
@@ -45,13 +46,13 @@ struct system_device_crosststamp;
 
 /**
  * struct ptp_system_timestamp - system time corresponding to a PHC timestamp
- * @pre_ts: system timestamp before capturing PHC
- * @post_ts: system timestamp after capturing PHC
- * @clockid: clock-base used for capturing the system timestamps
+ * @pre_sts:	system time snapshot before capturing PHC
+ * @post_sts:	system time snapshot after capturing PHC
+ * @clockid:	clock-base used for capturing the system timestamps
  */
 struct ptp_system_timestamp {
-	struct timespec64 pre_ts;
-	struct timespec64 post_ts;
+	struct system_time_snapshot pre_sts;
+	struct system_time_snapshot post_sts;
 	clockid_t clockid;
 };
 
@@ -510,13 +511,13 @@ static inline ktime_t ptp_convert_timest
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_clock_ts64(sts->clockid, &sts->pre_ts);
+		ktime_get_snapshot_id(&sts->pre_sts, sts->clockid);
 }
 
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_clock_ts64(sts->clockid, &sts->post_ts);
+		ktime_get_snapshot_id(&sts->post_sts, sts->clockid);
 }
 
 #endif


