Return-Path: <linux-wireless+bounces-37135-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKlFKOPxGWpl0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37135-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:06:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580B6083A4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B59D315C6BB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54D400E01;
	Fri, 29 May 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbO/RLYC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE24D3B388A;
	Fri, 29 May 2026 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084819; cv=none; b=RVqV6jUVbVcYsG52yUCngfa8yQT5k4tKw8sGcFMIVt3SXXDZl2DEYYJ7pj1uirA+KusP+5Nn4VQaGdya2Sa03sINkYwoah0byPMvNBiBvblkClRfk/PxEl3AQAXME2PQw6DozvQwlv+3MkQKVwfWYoTw823nz45+MLQxoqZxXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084819; c=relaxed/simple;
	bh=qju1MqRB0ivASytp9haWcSjwxxt5xCOgmY9ETRSGKCI=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QCmlSqP9v5B+M//sA92uFjh7WLLz0LB0Z89XjIjXJYv1bYqWah2trhHzsGXDVJG/N33f+6f/CdEnUcPKulBnXWfh6LLuUec5njVt1k2z98/fvopRzddxZZvc/caFdzRq6Mgzd6juQlqNn9bqeqwPmG2MQHknpQ79ai5/UnGfHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbO/RLYC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6241F00893;
	Fri, 29 May 2026 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084818;
	bh=uLwxmZd4CdUywaJPOeWBi7xkKgUAoOfHWX9DAZqAFzI=;
	h=Date:From:To:Cc:Subject:References;
	b=mbO/RLYCZ/LTWk70ZXsAb2UjhUOYWJTcsvg53pUIbPk7CcFtxzNWW0A/Ic1b0AtBO
	 eyZAf0UCy95qDfilKXjG7gOziyFySCyivDxtWS7WPDqM1Cqtrfc4tjImOa2Rg6YcRO
	 LXgzGTUDNQYzaoF5y4f/UaScTTLmuxA0OHlvfGJIRsJAOoocNZwS75mDJcKBhnZJIx
	 O8oYEGw7Tvj1pCkBNiUld+MTCGdGjjnZxPBHjTZIxAZ+Idc2Zwn4NaAA4MrnoCb8JI
	 bXv8zRcYAPkuNaEEJm52yoV9G9Rm1VxQZ9qjCyN36O5FyGUm1XDlBMHx3jS5pM3Jh5
	 4DD+7YsMYl21Q==
Date: Fri, 29 May 2026 22:00:16 +0200
Message-ID: <20260529195557.281425262@kernel.org>
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
Subject: [patch V2 07/25] ptp: ptp_vmclock: Convert to ktime_get_snapshot_id()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37135-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.co.uk:email]
X-Rspamd-Queue-Id: 2580B6083A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
request a particular CLOCK ID to be captured along with the clocksource
counter.

Convert vmclock over and use the new system_time_snapshot::systime field,
which holds the system timestamp selected by the CLOCK ID argument.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/ptp/ptp_vmclock.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -132,7 +132,7 @@ static int vmclock_get_crosststamp(struc
 		 * will be derived from the *same* counter value.
 		 *
 		 * If the system isn't using the same counter, then the value
-		 * from ktime_get_snapshot() will still be used as pre_ts, and
+		 * from ktime_get_snapshot_id() will still be used as pre_ts, and
 		 * ptp_read_system_postts() is called to populate postts after
 		 * calling get_cycles().
 		 *
@@ -140,7 +140,7 @@ static int vmclock_get_crosststamp(struc
 		 * the seq_count loop.
 		 */
 		if (sts) {
-			ktime_get_snapshot(&systime_snapshot);
+			ktime_get_snapshot_id(CLOCK_REALTIME, &systime_snapshot);
 			if (systime_snapshot.cs_id == st->cs_id) {
 				cycle = systime_snapshot.cycles;
 			} else {
@@ -181,7 +181,7 @@ static int vmclock_get_crosststamp(struc
 	}
 
 	if (sts) {
-		sts->pre_ts = ktime_to_timespec64(systime_snapshot.real);
+		sts->pre_ts = ktime_to_timespec64(systime_snapshot.systime);
 		if (systime_snapshot.cs_id == st->cs_id)
 			sts->post_ts = sts->pre_ts;
 	}
@@ -272,7 +272,7 @@ static int ptp_vmclock_getcrosststamp(st
 	if (ret == -ENODEV) {
 		struct system_time_snapshot systime_snapshot;
 
-		ktime_get_snapshot(&systime_snapshot);
+		ktime_get_snapshot_id(CLOCK_REALTIME, &systime_snapshot);
 
 		if (systime_snapshot.cs_id == CSID_X86_TSC ||
 		    systime_snapshot.cs_id == CSID_X86_KVM_CLK) {


