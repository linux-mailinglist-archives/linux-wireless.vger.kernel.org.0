Return-Path: <linux-wireless+bounces-36912-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPxSB0/cFWpzdQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36912-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:45:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 621CC5DAE2B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0805830960CE
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B98429831;
	Tue, 26 May 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCFKYpyZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D98408011;
	Tue, 26 May 2026 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815653; cv=none; b=H7Em9Ai3O5zRVSEqJiTpv5O2HT4gPOvbaJ5CB7zjJOzz3JYIfzVDy4Neb3j1I4KTruHL+mDq01qOG+BFgSStOYU5wkL9J/02P4E7+KxRnRXXLdKGjYhT28+jphqncdRglr6z1s+OSs9jb+PcMetlGDqv6rjAKHeXWYB6GokufGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815653; c=relaxed/simple;
	bh=STmBwqCS69f3H1B/WdQPyC9A5JSbEcuGaZP9yLFIjdk=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uB0dw+Nsam4pheVEsQRvG4NCF7/wOtS81eAsV+EnDT707i3FPmqGHfBJfsDAaee4lgTA2YnMAFpSqRHfpZmRQpHsY1wpdJYxlVGCtQ1NMIplXmP9eIV01sdGXDwIbXGHVntGuqGaG1B8r0iml3v1WNty5fwIdZgfmfizl0GLJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCFKYpyZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5FE351F000E9;
	Tue, 26 May 2026 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815651;
	bh=rk/n5DCog2RqWoJ0i1Irxgkuc/EgZJSjx162WFCBbzc=;
	h=Date:From:To:Cc:Subject:References;
	b=eCFKYpyZucjpAEYv4wwh7vyYhZ3u+nHy0uIc5m+7G5LfPuCIqEKgu2exTK1BifpVz
	 3SJKUnDDcaWvZkztVHKcbAg4zFpeuMAhimkMMQB43Tjw/ZzM83zBsvJJYrITTQKyP2
	 pbbe359SHMnJPVu5Np6y9mqJi5McS1/wPtT4v4vmAvmfy4u9D47qjdAoUEF449Y5No
	 qRgdd7PzqIDK0VdNurHYovJBEqUvPegjnTbs54kNgMje6DoDMQBbxhGPfRK9GK6Dvl
	 ubYLQaai2lis6h36Q8G1CKgGnbwlOnQHg6V3uo4P54CzyoN2SePMUwoVoeiu/UWFTF
	 +LlkgJ0lHhL6w==
Date: Tue, 26 May 2026 19:14:08 +0200
Message-ID: <20260526171223.300914258@kernel.org>
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
Subject: [patch 08/24] timekeeping: Remove system_time_snapshot::real/boot
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
	TAGGED_FROM(0.00)[bounces-36912-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 621CC5DAE2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All users are converted over to ktime_get_snapshot_id() and
system_time_snapshot::sys.

Remove the leftovers.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/timekeeping.h |    4 ----
 kernel/time/timekeeping.c   |    8 --------
 2 files changed, 12 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -280,8 +280,6 @@ static inline bool ktime_get_aux_ts64(cl
  *				 a selected CLOCK_* and the clocksource counter value
  * @cycles:		Clocksource counter value to produce the system times
  * @sys:		The system time of the selected CLOCK ID
- * @real:		Realtime system time
- * @boot:		Boot time
  * @raw:		Monotonic raw system time
  * @cs_id:		Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
@@ -291,8 +289,6 @@ static inline bool ktime_get_aux_ts64(cl
 struct system_time_snapshot {
 	u64			cycles;
 	ktime_t			sys;
-	ktime_t			real;
-	ktime_t			boot;
 	ktime_t			raw;
 	enum clocksource_ids	cs_id;
 	unsigned int		clock_was_set_seq;
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1196,8 +1196,6 @@ bool ktime_get_snapshot_id(struct system
 	struct timekeeper *tk;
 	struct tk_data *tkd;
 	unsigned int seq;
-	ktime_t base_real;
-	ktime_t base_boot;
 
 	/* Invalidate the snapshot for all failure cases */
 	systime_snapshot->valid = false;
@@ -1239,18 +1237,12 @@ bool ktime_get_snapshot_id(struct system
 		offs_sys = *offs;
 		base_raw = tk->tkr_raw.base;
 
-		/* Kept around until the callers are fixed up */
-		base_real = ktime_add(base_sys, tk_core.timekeeper.offs_real);
-		base_boot = ktime_add(base_sys, tk_core.timekeeper.offs_boot);
-
 		nsec_sys = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
 	} while (read_seqcount_retry(&tkd->seq, seq));
 
 	systime_snapshot->cycles = now;
 	systime_snapshot->sys = ktime_add_ns(base_sys, offs_sys + nsec_sys);
-	systime_snapshot->real = ktime_add_ns(base_real, nsec_sys);
-	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_sys);
 	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*


