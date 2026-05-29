Return-Path: <linux-wireless+bounces-37128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCePOezwGWoX0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:02:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0266082E2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6E6309C574
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C03F075C;
	Fri, 29 May 2026 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Mq1BhP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50507390C94;
	Fri, 29 May 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084791; cv=none; b=FobeQTjyQA5e2OaVHQ+xMsfDmGch4nhV6/nzOhdURd2kpQ9XJQmRNvIe2Az5kwuDD96kdYqlQRdcLwE9Wt+rMJQgNs4VcKGC+eHFi6/x/gt7Oq0ZPLqQcM51vPwPh42RayqvfNn4Lotk7RQ0bgg6eEMuQIgtDLMxo1t5tQEO3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084791; c=relaxed/simple;
	bh=GB/rOR5wBsGV1uX6Ap8zvwiOu/iWiH+RAjpFSt4pgew=;
	h=Date:Message-ID:From:To:Cc:Subject; b=dEXQvHAypXuaMLpN1Hn3QIQcHDRAHlEi9YQF4qG+a3BYr1Sin+NSq14ZkAfjcZLsVPGa39A6SFWIcTgQoiJDtzbirV9YWx1oeGb+MpxELizAmmgBfyK34B58TT5cZX3isn+NRfDKRIshU6rxEl1ku7SJbfj6YYRphtGpoLsl/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Mq1BhP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5901F00893;
	Fri, 29 May 2026 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084790;
	bh=lIqH1wpDSgJlCdNVAPXlVVzavYopsc7PgK17OZ5Jy/k=;
	h=Date:From:To:Cc:Subject;
	b=Y8Mq1BhPieERyg30mE3CAGKsfqj2zqFnyZXZuLbDdQS8aKkR8miRW62he2LzLffzu
	 Cp/LVM7HSJB1ugM1imBrKOhrbvWrw8OMksMdTsZwDC5KtGYF9vYK3/3Q511PY8snDx
	 XLXi25sUM1f7hax8TIMMnbA7zV1KfN/zSXoLbhLORSg2LWtFNLXDS3iKJ+PSu9g6JY
	 p7CMOwy7ErbcTHOhqd4QK4IMUw3rsFVaP972UifTVoY5/SGx5kSQELvMdph3q6c9AQ
	 FqLw8JJkyz1rYa7vL/35WYcNiheBpG3VXM2iyovDtsCJaYZXFTSJKqIZTlIbi2Vqrp
	 AwiwaOqQkY96Q==
Date: Fri, 29 May 2026 21:59:47 +0200
Message-ID: <20260529193435.921555544@kernel.org>
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
Subject: [patch V2 00/25] timekeeping/ptp: Expand snapshot functionality
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37128-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E0266082E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an update to V1 which can be found here:

   https://lore.kernel.org/lkml/20260526165826.392227559@kernel.org

PTP wants to grow new snapshot functionality, which provides not only the
captured CLOCK* values, but also the underlying clocksource counter value.

   https://lore.kernel.org/20260515164033.6403-1-akiyano@amazon.com

There was quite some discussion in seemingly related threads how to capture
these values and how to provide core infrastructure so that driver writers
have something to work with

   https://lore.kernel.org/20260514225842.110706-1-hramamurthy@google.com
   https://lore.kernel.org/20260520135207.37826-1-dwmw2@infradead.org

This series implements the timekeeping related mechanisms to:

     1) Capture CLOCK values along with the clocksource counter value for
     	non-hardware based sampling

     2) Expanding the hardware cross time stamp mechanism to hand back the
     	clocksource counter value, which was captured by the device, along
     	with the related CLOCK values

     3) Adding AUX clock support to the hardware cross timestamping core

     4) Add support for derived clocksources to the snapshot mechanism (New
     	in V2)

Changes vs. V1:

  - Fixed the ptp_ocp typo - 0-day, Jakub

  - Renamed the system_time_snapshot members sys and raw so systime and
    monoraw to make them less ambigous.

  - Fixed the error case return values of get_device_system_crosststamp()

  - Made ktime_snapshot_id() void as there is no point for the return
    value, which is nowhere checked and cannot be propagated.
    system_time_snapshot::valid has to be evaluated at the call sites
    anyway. - Jacob

  - Picked up the first patch from Davids follow up series, which extends
    the snapshot mechanism so that derived clocksources (like kvmclock and
    Hyper-V scaled TSC) can return the actual underlying hardware counter
    value (TSC for the two examples).

  - Collected Reviewed/Acked/Tested-by tags

Delta patch against v1 below.

The series is based on v7.1-rc2 and also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timekeeping-ptp-extend-v2

Thanks,

	tglx
---
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 616062587510..b056c652ff01 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -51,8 +51,8 @@ static void __hyp_clock_work(struct work_struct *work)
 
 	hyp_clock = container_of(dwork, struct hyp_trace_clock, work);
 
-	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
-	boot = ktime_to_ns(snap.sys);
+	ktime_get_snapshot_id(CLOCK_BOOTTIME, &snap);
+	boot = ktime_to_ns(snap.systime);
 
 	delta_boot = boot - hyp_clock->boot;
 	delta_cycles = snap.cycles - hyp_clock->cycles;
@@ -120,7 +120,7 @@ static void hyp_trace_clock_enable(struct hyp_trace_clock *hyp_clock, bool enabl
 
 	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
 
-	hyp_clock->boot = ktime_to_ns(snap.sys);
+	hyp_clock->boot = ktime_to_ns(snap.systime);
 	hyp_clock->cycles = snap.cycles;
 	hyp_clock->mult = 0;
 
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index e60cc7ed3e70..b11b8821c9fb 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -28,7 +28,7 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
 	 * system time and counter value must captured at the same
 	 * time to keep consistency and precision.
 	 */
-	ktime_get_snapshot_id(&systime_snapshot, CLOCK_REALTIME);
+	ktime_get_snapshot_id(CLOCK_REALTIME, &systime_snapshot);
 
 	/*
 	 * This is only valid if the current clocksource is the
@@ -61,8 +61,8 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
 	 * in the future (about 292 years from 1970, and at that stage
 	 * nobody will give a damn about it).
 	 */
-	val[0] = upper_32_bits(systime_snapshot.sys);
-	val[1] = lower_32_bits(systime_snapshot.sys);
+	val[0] = upper_32_bits(systime_snapshot.systime);
+	val[1] = lower_32_bits(systime_snapshot.systime);
 	val[2] = upper_32_bits(cycles);
 	val[3] = lower_32_bits(cycles);
 }
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 1d5fef4df560..2697073dbf90 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2310,10 +2310,10 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		goto out;
 	}
 
-	t1 = ktime_to_ns(ptp_sts_before.pre_sts.sys);
-	t2 = ktime_to_ns(ptp_sts_before.post_sts.sys);
-	t3 = ktime_to_ns(ptp_sts_after.pre_sts.sys);
-	t4 = ktime_to_ns(ptp_sts_after.post_sts.sys);
+	t1 = ktime_to_ns(ptp_sts_before.pre_sts.systime);
+	t2 = ktime_to_ns(ptp_sts_before.post_sts.systime);
+	t3 = ktime_to_ns(ptp_sts_after.pre_sts.systime);
+	t4 = ktime_to_ns(ptp_sts_after.post_sts.systime);
 	/* Mid point, corresponds to pre-reset PTPCLKVAL */
 	t12 = t1 + (t2 - t1) / 2;
 	/* Mid point, corresponds to post-reset PTPCLKVAL, aka 0 */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5023fc1587f9..f9e4ec6f7ebb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2117,7 +2117,7 @@ static int ice_capture_crosststamp(ktime_t *device,
 	}
 
 	/* Snapshot system time for historic interpolation */
-	ktime_get_snapshot_id(&ctx->snapshot, ctx->snapshot_clock_id);
+	ktime_get_snapshot_id(ctx->snapshot_clock_id, &ctx->snapshot);
 
 	/* Program cmd to master timer */
 	ice_ptp_src_cmd(hw, ICE_PTP_READ_TIME);
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 9b8b4a04e32d..b40aba9ab685 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1049,7 +1049,7 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 	 */
 	do {
 		/* Get a snapshot of system clocks to use as historic value. */
-		ktime_get_snapshot_id(&adapter->snapshot, adapter->snapshot_clock_id);
+		ktime_get_snapshot_id(adapter->snapshot_clock_id, &adapter->snapshot);
 
 		igc_ptm_trigger(hw);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index beb80912b9d5..5df786133e4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -340,7 +340,7 @@ static int mlx5_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 		goto unlock;
 	}
 
-	ktime_get_snapshot_id(&history_begin, cts->clock_id);
+	ktime_get_snapshot_id(cts->clock_id, &history_begin);
 
 	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicetime, mdev,
 					    &history_begin, cts);
@@ -366,7 +366,7 @@ static int mlx5_ptp_getcrosscycles(struct ptp_clock_info *ptp,
 		goto unlock;
 	}
 
-	ktime_get_snapshot_id(&history_begin, cts->clock_id);
+	ktime_get_snapshot_id(cts->clock_id, &history_begin);
 
 	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicecyclestime,
 					    mdev, &history_begin, cts);
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index aed5c13cd1be..dc23cd708cfe 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -392,11 +392,11 @@ static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg,
 		extoff->ts[i][1].sec = ts.tv_sec;
 		extoff->ts[i][1].nsec = ts.tv_nsec;
 
-		ts = ktime_to_timespec64(sts.pre_sts.sys);
+		ts = ktime_to_timespec64(sts.pre_sts.systime);
 		extoff->ts[i][0].sec = ts.tv_sec;
 		extoff->ts[i][0].nsec = ts.tv_nsec;
 
-		ts = ktime_to_timespec64(sts.post_sts.sys);
+		ts = ktime_to_timespec64(sts.post_sts.systime);
 		extoff->ts[i][2].sec = ts.tv_sec;
 		extoff->ts[i][2].nsec = ts.tv_nsec;
 	}
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index b7a23936a44d..28b0302c6250 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1492,7 +1492,7 @@ __ptp_ocp_gettime_locked(struct ptp_ocp *bp, struct timespec64 *ts,
 	ptp_read_system_postts(sts);
 
 	if (sts && bp->ts_window_adjust)
-		sts->post_ts.sys -= bp->ts_window_adjust;
+		sts->post_sts.systime -= bp->ts_window_adjust;
 
 	time_ns = ioread32(&bp->reg->time_ns);
 	time_sec = ioread32(&bp->reg->time_sec);
@@ -4592,8 +4592,8 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 		struct timespec64 sys_ts;
 		s64 pre_ns, post_ns, ns;
 
-		pre_ns = ktime_to_ns(sts.pre_sts.sys);
-		post_ns = ktime_to_ns(sts.post_sts.sys);
+		pre_ns = ktime_to_ns(sts.pre_sts.systime);
+		post_ns = ktime_to_ns(sts.post_sts.systime);
 		ns = (pre_ns + post_ns) / 2;
 		ns += (s64)bp->utc_tai_offset * NSEC_PER_SEC;
 		sys_ts = ns_to_timespec64(ns);
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index cb18c15a4697..d6a5a533164a 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -263,7 +263,7 @@ static int ptp_vmclock_getcrosststamp(struct ptp_clock_info *ptp,
 	if (ret == -ENODEV) {
 		struct system_time_snapshot systime_snapshot;
 
-		ktime_get_snapshot_id(&systime_snapshot, CLOCK_REALTIME);
+		ktime_get_snapshot_id(CLOCK_REALTIME, &systime_snapshot);
 
 		if (systime_snapshot.cs_id == CSID_X86_TSC ||
 		    systime_snapshot.cs_id == CSID_X86_KVM_CLK) {
diff --git a/drivers/virtio/virtio_rtc_ptp.c b/drivers/virtio/virtio_rtc_ptp.c
index e15d00aeb01d..ff8d834493dc 100644
--- a/drivers/virtio/virtio_rtc_ptp.c
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -139,7 +139,7 @@ static int viortc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 	if (ret)
 		return ret;
 
-	ktime_get_snapshot_id(&history_begin, xtstamp->clock_id);
+	ktime_get_snapshot_id(xtstamp->clock_id, &history_begin);
 	if (history_begin.cs_id != cs_id)
 		return -EOPNOTSUPP;
 
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7c38190b10bf..6d9ddf1587a2 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -31,6 +31,21 @@ struct module;
 
 #include <vdso/clocksource.h>
 
+/**
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
 /**
  * struct clocksource - hardware abstraction for a free running counter
  *	Provides mostly state-free accessors to the underlying hardware.
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
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index cd80f1cb96a9..9f088c9023b1 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -102,9 +102,9 @@ static inline void pps_get_ts(struct pps_event_time *ts)
 #ifdef CONFIG_NTP_PPS
 	struct system_time_snapshot snap;
 
-	ktime_get_snapshot_id(&snap, CLOCK_REALTIME);
-	ts->ts_real = ktime_to_timespec64(snap.sys);
-	ts->ts_raw = ktime_to_timespec64(snap.raw);
+	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
+	ts->ts_real = ktime_to_timespec64(snap.systime);
+	ts->ts_raw = ktime_to_timespec64(snap.monoraw);
 #else
 	ktime_get_real_ts64(&ts->ts_real);
 #endif
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index df6c9aac458b..36a27a910595 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -511,13 +511,13 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_snapshot_id(&sts->pre_sts, sts->clockid);
+		ktime_get_snapshot_id(sts->clockid, &sts->pre_sts);
 }
 
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_snapshot_id(&sts->post_sts, sts->clockid);
+		ktime_get_snapshot_id(sts->clockid, &sts->post_sts);
 }
 
 #endif
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index f7945f1048fc..984a866d293b 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -279,18 +279,24 @@ static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { ret
  * struct system_time_snapshot - Simultaneous time capture of CLOCK_MONOTONIC_RAW,
  *				 a selected CLOCK_* and the clocksource counter value
  * @cycles:		Clocksource counter value to produce the system times
- * @sys:		The system time of the selected CLOCK ID
- * @raw:		Monotonic raw system time
+ * @hw_cycles:		For derived clocksources, the hardware counter value from
+ *			which @cycles was derived
+ * @systime:		The system time of the selected CLOCK ID
+ * @monoraw:		Monotonic raw system time
  * @cs_id:		Clocksource ID
+ * @hw_csid:		Clocksource ID of the underlying hardware counter for derived
+ *			clocksources which implement the read_snapshot() callback.
  * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  * @valid:		True if the snapshot is valid
  */
 struct system_time_snapshot {
 	u64			cycles;
-	ktime_t			sys;
-	ktime_t			raw;
+	u64			hw_cycles;
+	ktime_t			systime;
+	ktime_t			monoraw;
 	enum clocksource_ids	cs_id;
+	enum clocksource_ids	hw_csid;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
 	u8			valid;
@@ -348,8 +354,7 @@ extern int get_device_system_crosststamp(
  * Simultaneously snapshot a given clock with MONOTONIC_RAW and the underlying
  * clocksource counter value.
  */
-extern bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot,
-				  clockid_t clock_id);
+extern void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *systime_snapshot);
 
 /*
  * Persistent clock related interfaces
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c4fd7229b7da..0d5b67f609bb 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -320,6 +320,7 @@ static __always_inline u64 tk_clock_read(const struct tk_read_base *tkr)
 
 	return clock->read(clock);
 }
+
 static inline void clocksource_disable_inline_read(void) { }
 static inline void clocksource_enable_inline_read(void) { }
 #endif
@@ -1187,14 +1188,26 @@ noinstr time64_t __ktime_get_real_seconds(void)
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
  *			    clocksource counter value.
- * @systime_snapshot:	Pointer to struct receiving the system time snapshot
  * @clock_id:		The clock ID to snapshot
+ * @systime_snapshot:	Pointer to struct receiving the system time snapshot
  */
-bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clockid_t clock_id)
+void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot *systime_snapshot)
 {
 	ktime_t base_raw, base_sys, offs_sys, *offs, offs_zero = 0;
 	u64 nsec_raw, nsec_sys, now;
@@ -1206,7 +1219,7 @@ bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clocki
 	systime_snapshot->valid = false;
 
 	if (WARN_ON_ONCE(timekeeping_suspended))
-		return false;
+		return;
 
 	switch (clock_id) {
 	case CLOCK_REALTIME:
@@ -1226,25 +1239,31 @@ bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clocki
 	case CLOCK_AUX ... CLOCK_AUX_LAST:
 		tkd = aux_get_tk_data(clock_id);
 		if (!tkd)
-			return false;
+			return;
 		offs = &tkd->timekeeper.offs_aux;
 		break;
 	default:
 		WARN_ON_ONCE(1);
-		return false;
+		return;
 	}
 
 	tk = &tkd->timekeeper;
 
 	do {
+		struct clocksource_hw_snapshot chs = { };
+
 		seq = read_seqcount_begin(&tkd->seq);
 
 		/* Aux clocks can be invalid */
 		if (!tk->clock_valid)
-			return false;
+			return;
 
-		now = tk_clock_read(&tk->tkr_mono);
+		now = tk_clock_read_snapshot(&tk->tkr_mono, &chs);
 		systime_snapshot->cs_id = tk->tkr_mono.clock->id;
+
+		systime_snapshot->hw_cycles = chs.hw_cycles;
+		systime_snapshot->hw_csid = chs.hw_csid;
+
 		systime_snapshot->cs_was_changed_seq = tk->cs_was_changed_seq;
 		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
 
@@ -1257,18 +1276,17 @@ bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clocki
 	} while (read_seqcount_retry(&tkd->seq, seq));
 
 	systime_snapshot->cycles = now;
-	systime_snapshot->sys = ktime_add_ns(base_sys, offs_sys + nsec_sys);
-	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
+	systime_snapshot->systime = ktime_add_ns(base_sys, offs_sys + nsec_sys);
+	systime_snapshot->monoraw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*
 	 * Special case for PTP. Just transfer the raw time into sys,
-	 * so the call sites can consistently use snap::sys.
+	 * so the call sites can consistently use snap::systime.
 	 */
 	if (clock_id == CLOCK_MONOTONIC_RAW)
-		systime_snapshot->sys = systime_snapshot->raw;
+		systime_snapshot->systime = systime_snapshot->monoraw;
 	/* Tell the consumer that this snapshot is valid */
 	systime_snapshot->valid = true;
-	return true;
 }
 EXPORT_SYMBOL_GPL(ktime_get_snapshot_id);
 
@@ -1330,7 +1348,7 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 	 * Scale the monotonic raw time delta by:
 	 *	partial_history_cycles / total_history_cycles
 	 */
-	corr_raw = (u64)ktime_to_ns(ktime_sub(ts->sys_monoraw, history->raw));
+	corr_raw = (u64)ktime_to_ns(ktime_sub(ts->sys_monoraw, history->monoraw));
 	ret = scale64_check_overflow(partial_history_cycles,
 				     total_history_cycles, &corr_raw);
 	if (ret)
@@ -1347,7 +1365,7 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 	if (discontinuity) {
 		corr_sys = mul_u64_u32_div(corr_raw, tk->tkr_mono.mult, tk->tkr_raw.mult);
 	} else {
-		corr_sys = (u64)ktime_to_ns(ktime_sub(ts->sys_systime, history->sys));
+		corr_sys = (u64)ktime_to_ns(ktime_sub(ts->sys_systime, history->systime));
 		ret = scale64_check_overflow(partial_history_cycles, total_history_cycles,
 					     &corr_sys);
 		if (ret)
@@ -1356,8 +1374,8 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 
 	/* Fixup monotonic raw and system time time values */
 	if (interp_forward) {
-		ts->sys_monoraw = ktime_add_ns(history->raw, corr_raw);
-		ts->sys_systime = ktime_add_ns(history->sys, corr_sys);
+		ts->sys_monoraw = ktime_add_ns(history->monoraw, corr_raw);
+		ts->sys_systime = ktime_add_ns(history->systime, corr_sys);
 	} else {
 		ts->sys_monoraw = ktime_sub_ns(ts->sys_monoraw, corr_raw);
 		ts->sys_systime = ktime_sub_ns(ts->sys_systime, corr_sys);
@@ -1521,12 +1539,12 @@ int get_device_system_crosststamp(int (*get_time_fn)
 	case CLOCK_AUX ... CLOCK_AUX_LAST:
 		tkd = aux_get_tk_data(xtstamp->clock_id);
 		if (!tkd)
-			return false;
+			return -ENODEV;
 		offs = &tkd->timekeeper.offs_aux;
 		break;
 	default:
 		WARN_ON_ONCE(1);
-		return false;
+		return -ENODEV;
 	}
 
 	tk = &tkd->timekeeper;


