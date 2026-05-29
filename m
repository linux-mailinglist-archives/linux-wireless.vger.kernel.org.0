Return-Path: <linux-wireless+bounces-37136-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yd+SC1PyGWp10AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37136-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86095608419
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B701B3167674
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7623ACF04;
	Fri, 29 May 2026 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGB2HDD5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FD332629;
	Fri, 29 May 2026 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084824; cv=none; b=MZ1QILL3IqTE7KueoTY534ySVflL4+R6Gn+eY18ARRJx4V3Ttv2BpLTmWZAACOwQcl4jkhQsMLJMAHX/lWNymL58fGR0/S8r/FYVuwzAJW0teSFJPFrQPyh2FyNGxVgVPavv/cb9OENGrrSB1AULFbUEmwATFW5i0GXV9gS3sS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084824; c=relaxed/simple;
	bh=JVrGTZx95Dbv2azQIZUdv5pFW8iH3/YKR93bJNOtW2Q=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=A6IM38hmA7FT53/2iFGS0k0WmOUzHLqmNHP20yTiB9J2y/R2rD0fl4de8uy8ZzoFZjiTznK3qd0fA1Kp3NIYDC8fntP6V8rX0J5nU3zykloeKZFa3Ug/1AtHh0TdMSj7KXJoh5IT4KCUQiR5RI+X6wBQqQnWt1s/ohwEEdpXUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGB2HDD5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4162B1F00893;
	Fri, 29 May 2026 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084822;
	bh=b67VnBzKoqE7efAw6mu6viaJtmVWPsvV2nRLA3Q5Jpg=;
	h=Date:From:To:Cc:Subject:References;
	b=bGB2HDD5DnsUTjfYy9+81ybn7I1A0QYaiPLVZTWt2p5LD4e0g7N3kKq+gkO3wwprN
	 4cWZA4EEbzSeZRi/2WxrVxbecWHugpGo8LL6xMXoa1AUew2bY5k2oEEW0zkv81s/fq
	 oBw1HI02Am8tGJEW26wA29qi8/1aMk/FGvGX1ZwNlebRBJh8JVOvM2ZPQWqfRmTFde
	 UFenSEMfXboybOYiq9cULYxNYvN7XBilXk15v3cVpbSSH2A1cIBaH5IOc9gQtDay5E
	 w4D0JFrSyV2hSmcoeldTOuHRXaAfVhUzBFehS5UzCPA6EjF2Xbjt8A7wHHr1g/prx5
	 D7A5VxG9HBRZg==
Date: Fri, 29 May 2026 22:00:20 +0200
Message-ID: <20260529195557.330029635@kernel.org>
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
Subject: [patch V2 08/25] timekeeping: Remove
 system_time_snapshot::real/boot/raw
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
	TAGGED_FROM(0.00)[bounces-37136-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 86095608419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

All users are converted over to ktime_get_snapshot_id() and
system_time_snapshot::systime and ::monoraw.

Remove the leftovers.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/linux/timekeeping.h |   10 +---------
 kernel/time/timekeeping.c   |    8 --------
 2 files changed, 1 insertion(+), 17 deletions(-)
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -280,9 +280,6 @@ static inline bool ktime_get_aux_ts64(cl
  *				 a selected CLOCK_* and the clocksource counter value
  * @cycles:		Clocksource counter value to produce the system times
  * @systime:		The system time of the selected CLOCK ID
- * @real:		Realtime system time
- * @boot:		Boot time
- * @raw:		Monotonic raw system time
  * @monoraw:		Monotonic raw system time
  * @cs_id:		Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
@@ -292,12 +289,7 @@ static inline bool ktime_get_aux_ts64(cl
 struct system_time_snapshot {
 	u64			cycles;
 	ktime_t			systime;
-	ktime_t			real;
-	ktime_t			boot;
-	union {
-		ktime_t		raw;
-		ktime_t		monoraw;
-	};
+	ktime_t			monoraw;
 	enum clocksource_ids	cs_id;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1196,8 +1196,6 @@ void ktime_get_snapshot_id(clockid_t clo
 	struct timekeeper *tk;
 	struct tk_data *tkd;
 	unsigned int seq;
-	ktime_t base_real;
-	ktime_t base_boot;
 
 	/* Invalidate the snapshot for all failure cases */
 	systime_snapshot->valid = false;
@@ -1239,18 +1237,12 @@ void ktime_get_snapshot_id(clockid_t clo
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
 	systime_snapshot->systime = ktime_add_ns(base_sys, offs_sys + nsec_sys);
-	systime_snapshot->real = ktime_add_ns(base_real, nsec_sys);
-	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_sys);
 	systime_snapshot->monoraw = ktime_add_ns(base_raw, nsec_raw);
 
 	/*


