Return-Path: <linux-wireless+bounces-36908-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA99Cm3VFWrRcgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36908-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:16:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B805B5DA7B3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8118D300DD6D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C414218B5;
	Tue, 26 May 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/7TyMGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FD413D8F;
	Tue, 26 May 2026 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815636; cv=none; b=OvDkU0LOQC01acvHY8uJ/22nYGZXWJQ0mUGzfOGpFTwrHIZ02VFJJqa3pex6aStMQCMJVuT3n91YGBGWHoFFqMDMfD+Prh/iBfD3/7leb1nw1o9ujrS43def3XgNlyM4YSdUETqb+mHpqHtR2Q9hL4vwoInBnMEvY2BLR12gplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815636; c=relaxed/simple;
	bh=NDw6UHaPI2dJBJJYWyMVcYdnDmDcJDE7NsRFacHuejg=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CQ55KekC5e+/fafnOemrpkzPSxqJKxuzyHLHZMtzgB/Ee2+c2om7fhmHQJ+6AoqOpd3cbaoJs8x+TzrDyV+Kr0AQvMCyhc54jEzER+kf3xBsfEcw/seaAYbMeSSlkizdrHmspoYoCrtGbvRDVge91FihqOmLkUYPXU9pafRzX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/7TyMGC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CD14D1F00A3F;
	Tue, 26 May 2026 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815631;
	bh=2J+ciIb2LyPs5xxGSmmcudFc+5BTlYYzzEvJzgHR0zk=;
	h=Date:From:To:Cc:Subject:References;
	b=l/7TyMGC5Mv6l3ZKe7c6fhs4o1pwKNEh3volJKRnmz8sUSqATPBUvLA+ZGnqe9hst
	 vVP8HKu/Cl0PUZTGZjn2j+muR+e0Oeki3r4BWeIJ1CxqJJjBb93+8ttVfm8i80R79Y
	 sjaRQEJ7kj0nYumOC1QMkKrb2PqakO0Hlg8ejbrehNOWoutJSq8ECnvZf+5j7jVCW4
	 CqTuAv37DM6DpCC8NVwrBxQyRfUGwVL5kzg/0CScRKGCfpGLh/r7DHu4nKIHM4gGSN
	 oclVhhVS9gRq3E5suGSWD71huxZhD43uoo5rL9UCiYti5BILHylSUSXdT76eKhwf8K
	 9rc5+PBk5OsHA==
Date: Tue, 26 May 2026 19:13:48 +0200
Message-ID: <20260526171222.995833811@kernel.org>
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
Subject: [patch 04/24] pps: Convert to ktime_get_snapshot_id()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36908-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B805B5DA7B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ktime_get_snapshot() resolves to ktime_get_snapshot_id(CLOCK_REALTIME).

Make it obvious in the code and convert the readout to use the
snapshot::sys field instead of snapshot::real, which is going away.

Similar to the PPS generators, avoid the more expensive snapshot when
CONFIG_NTP_PPS is disabled.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>
---
 include/linux/pps_kernel.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -99,12 +99,14 @@ static inline void timespec_to_pps_ktime
 
 static inline void pps_get_ts(struct pps_event_time *ts)
 {
+#ifdef CONFIG_NTP_PPS
 	struct system_time_snapshot snap;
 
-	ktime_get_snapshot(&snap);
-	ts->ts_real = ktime_to_timespec64(snap.real);
-#ifdef CONFIG_NTP_PPS
+	ktime_get_snapshot_id(&snap, CLOCK_REALTIME);
+	ts->ts_real = ktime_to_timespec64(snap.sys);
 	ts->ts_raw = ktime_to_timespec64(snap.raw);
+#else
+	ktime_get_real_ts64(&ts->ts_real);
 #endif
 }
 


