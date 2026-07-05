Return-Path: <linux-wireless+bounces-38633-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3nhJH5QSmogBQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38633-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 14:39:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B55709FA4
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 14:39:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b3ypc1ba;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38633-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38633-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EBCA300D14A
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D8437EFF3;
	Sun,  5 Jul 2026 12:38:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB5328B5E;
	Sun,  5 Jul 2026 12:38:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783255088; cv=none; b=H8tAZXrdrePe77ZxYlKtVuVfwQXv7uFPWVk6f+8Y662+RlRRut6woi0kZcxaqiqkGTYFBZlcuiwZYcV5lnfULa2YNpwIbfIUgzMU6YxtBLlmF9dvf/YaKcMc0mPpMvo0FSdrJeg6r8SypseUBad2OwPXJtkZuE/prThS07PRQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783255088; c=relaxed/simple;
	bh=Gl8MfTt8suXBO7Pu5/maEDsc0GlZdohSGzjmR3J0T+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KQQL6WvnXw+CCDhDvn6005N5+JBdq7hlwBPl3JlGyKZ6gr/wusKJH7W7eLdaMHyUvqEWCsNi/M6F+erk8U5sAKnPpv6vrqlknm96IDc93NplJaLW2ckX6m8rT4xrW88lLlmaFKvg6PqstKXMqyAFYoVSzjTJ9uz70RT0lsl0p1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3ypc1ba; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2471F000E9;
	Sun,  5 Jul 2026 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783255087;
	bh=rVncT2+p9KqQfIvl5pGhLMSnQrP7IONrb76DatfXrmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=b3ypc1baMCcYHKP78bk38XYOF7stZ4HSVpDDcrLmr72LmG+/JXlrWkfL+/2DskJle
	 NSV1L6u47otAthV4uhriDp9PDhmZ7H/mX3/A0xmfQb99kVxYTtCEJyqdsxVHVBW1Dv
	 nLtJReYfY0sJLhQbCiwkaHDACS4HjAYHF6tN3XQdt/uMARPTPejO58C1hqEZRCKZ+P
	 Ja3tgg6+AdxwVbLgHeYnTTfXQ5P8NZkVasSr0jN03qaB1loYDUqYIozwhTl8I+VTti
	 XVB6D0KorrlmcfO/oUGrK9vwheVY1+uN8d0vtZX2TSU+SvdesPhy2fx08xCpB+nWSv
	 ZLgNQHDn4S5BQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Miroslav Lichvar <mlichvar@redhat.com>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Arthur Kiyanovski <akiyano@amazon.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Vincent Donnefort <vdonnefort@google.com>, Marc
 Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org, Takashi Iwai
 <tiwai@suse.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Peter Hilber
 <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, linux-wireless@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: [PATCH] timekeeping: Document monotonic raw timestamps in snapshots
 correctly
In-Reply-To: <87bjctsptt.ffs@fw13>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.374814973@kernel.org>
 <20260626103359-66ab2b54-d36f-416b-94a4-3f3708dccced@linutronix.de>
 <87echtk24a.ffs@fw13>
 <20260626125819-d8b197fc-7671-4d12-a578-9025affc52d9@linutronix.de>
 <87fr29ib4v.ffs@fw13>
 <20260629055344-b74c43de-2a2b-4608-ae4e-ed0ac8e12fd1@linutronix.de>
 <87bjctsptt.ffs@fw13>
Date: Sun, 05 Jul 2026 14:38:04 +0200
Message-ID: <87wlv9k3wz.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:mlichvar@redhat.com,m:jstultz@google.com,m:sboyd@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:akiyano@amazon.com,m:giometti@enneenne.com,m:vdonnefort@google.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:tiwai@suse.com,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:saeedm@nvidia.com,m:peter.hilber@oss.qualcomm.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-sound@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38633-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fw13:mid,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1B55709FA4

The comments related to raw monotonic timestamps for the various
snapshot mechanisms in code and struct documentation are ambiguous. They
reference them as CLOCK_MONOTONIC_RAW timestamps, but with the arrival
of AUX clocks that's not longer correct.

The raw monotonic timestamps only represent CLOCK_MONOTONIC_RAW for the
system time clock IDs, i.e. REALTIME, MONOTONIC, BOOTTIME, TAI.

For AUX clocks they refer to the monotonic raw clock which is related to
the individual AUX clocks. These monotonic raw timestamps have the same
conversion factor as CLOCK_MONOTONIC_RAW, but differ from that by an
offset:

	MONORAW(AUX$N) =3D MONORAW(SYSTEM) + OFFSET(AUX$N)

The offset is established when a AUX clock is enabled and stays constant
for the lifetime of the AUX clock.

Update the comments so they reflect reality.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reported-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/timekeeping.h |   10 +++++++++-
 kernel/time/timekeeping.c   |   16 +++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -276,7 +276,7 @@ static inline bool ktime_get_aux_ts64(cl
 #endif
=20
 /**
- * struct system_time_snapshot - Simultaneous time capture of CLOCK_MONOTO=
NIC_RAW,
+ * struct system_time_snapshot - Simultaneous time capture of monotonic ra=
w time,
  *				 a selected CLOCK_* and the clocksource counter value
  * @cycles:		Clocksource counter value to produce the system times
  * @hw_cycles:		For derived clocksources, the hardware counter value from
@@ -289,6 +289,10 @@ static inline bool ktime_get_aux_ts64(cl
  * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  * @valid:		True if the snapshot is valid
+ *
+ * @monoraw is CLOCK_MONOTONIC_RAW for system time CLOCK ids. For CLOCK_AU=
X$N
+ * clock ids it's the monotonic raw time related to the AUX clock, which is
+ * CLOCK_MONOTONIC_RAW plus a AUX clock specific offset.
  */
 struct system_time_snapshot {
 	u64			cycles;
@@ -326,6 +330,10 @@ struct system_counterval_t {
  * @sys_counter:	Clocksource counter value simultaneous with device time
  * @sys_systime:	System time for @clock_id
  * @sys_monoraw:	Monotonic raw simultaneous with device time
+ *
+ * @sys_monoraw is CLOCK_MONOTONIC_RAW for system time CLOCK ids. For
+ * CLOCK_AUX$N clock ids it's the monotonic raw time related to the AUX cl=
ock,
+ * which is CLOCK_MONOTONIC_RAW plus a AUX clock specific offset.
  */
 struct system_device_crosststamp {
 	clockid_t			clock_id;
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1202,10 +1202,21 @@ static inline u64 tk_clock_read_snapshot
=20
 /**
  * ktime_get_snapshot_id -  Simultaneously snapshot a given clock ID with
- *			    CLOCK_MONOTONIC_RAW and the underlying
+ *			    the corresponding monotonic raw and the underlying
  *			    clocksource counter value.
  * @clock_id:		The clock ID to snapshot
  * @systime_snapshot:	Pointer to struct receiving the system time snapshot
+ *
+ * For the system time keeping clocks (REALTIME, MONOTONIC and BOOTTIME) t=
he
+ * monotonic raw clock is CLOCK_MONOTONIC_RAW. For AUX clocks this is the
+ * monotonic raw clock related to the AUX clock. These AUX clock related
+ * monotonic raw clocks have a strict linear offset to the system time
+ * CLOCK_MONOTONIC_RAW:
+ *
+ *	MONOTONIC_RAW(AUX$N) =3D CLOCK_MONOTONIC_RAW(system) + offset(AUX$N)
+ *
+ * The offset is established when a AUX clock is initialized, but it is
+ * currently not accessible.
  */
 void ktime_get_snapshot_id(clockid_t clock_id, struct system_time_snapshot=
 *systime_snapshot)
 {
@@ -1512,6 +1523,9 @@ EXPORT_SYMBOL_GPL(ktime_real_to_base_clo
  * @xtstamp:		Receives simultaneously captured system and device time
  *
  * Reads a timestamp from a device and correlates it to system time
+ *
+ * See documentation for ktime_get_snapshot_id() for information about the=
 raw
+ * monotonic time stamp which is used here.
  */
 int get_device_system_crosststamp(int (*get_time_fn)
 				  (ktime_t *device_time,

