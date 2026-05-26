Return-Path: <linux-wireless+bounces-36915-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCuPDzzWFWrRcwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36915-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:19:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E945DA874
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12B1530120C3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B242EEDF;
	Tue, 26 May 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH3Q+0BX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912E406267;
	Tue, 26 May 2026 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815667; cv=none; b=Won36r136W01883+pfyyMAfEO900cwG8THLT/OHnORJG4Rj3lo6lH0uy5whTX1H/NK6g3A6BXfHwWnr9WkIaAg+Xt3xFyfAl7u6P5i0v77iSIqQ10BqSDaO5Jhymn1jg8waLZFLXxbNwdCcvUJegtWfnhViuBQkpbFXYGl5ql/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815667; c=relaxed/simple;
	bh=UnUe9MHT86IThOANvTClBCvas7NQoNn77t2q9Prf/ik=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ox4u1ee+3M0d54r8oGC15jOGLtb0P1K1rOB+jWqtpJuSsM2U1lZRp2uIcyfOo1E0zvXmgJJBUB9dVdLmud0tPGJV9s+/qSadaxHZks0BbQDQEyMfpcMKHljpBHc1Xh0V30Pr1Y56I8hezRS9z0rMDmyXy9cO8MoL3wyWgDxHV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH3Q+0BX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 87A6A1F000E9;
	Tue, 26 May 2026 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815666;
	bh=o35TybNtvElFbKMNcpkUkArI5s3Bfjkcl70NZOwwDvM=;
	h=Date:From:To:Cc:Subject:References;
	b=SH3Q+0BXJ/kvGPA1mD6EzHR1nyZZl/R6Lcn8Jizr3YR4dnpZtwuTWq4uzVL47/rLL
	 5brlYKUILwdaMFvaIBkIGOAhu5mlxr1v7lX/Yom1ehEaqJNk+x9W/xn/R/VAyFhhGn
	 L9s/v0D8C1TJhu5qfx3V6NntM2jGXTQFL1qh/RkfS8dgYiPBniuO9OaEfRT31Wy9l6
	 mEd7ipCj9oZnHgxGyzqorQveNcjeYoYrk4HW6BVVDBtjpN5Qe74mc0y6YKFpf5zsEI
	 UKq/FnrIwIYK6ve9lAW05B5w7K1fWPlMyRnXUw7dsGS6kDddj0rPs2aXDS8pj71XhF
	 aA19BE44qWk+w==
Date: Tue, 26 May 2026 19:14:23 +0200
Message-ID: <20260526171223.522578743@kernel.org>
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
 Richard Cochran <richardcochran@gmail.com>,
 Takashi Iwai <tiwai@suse.com>,
 netdev@vger.kernel.org,
 Rodolfo Giometti <giometti@enneenne.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>,
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
Subject: [patch 11/24] timekeeping: Add CLOCK ID to system_device_crosststamp
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
	TAGGED_FROM(0.00)[bounces-36915-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,gmail.com,suse.com,vger.kernel.org,enneenne.com,linux.dev,lists.linux.dev,intel.com,nvidia.com,oss.qualcomm.com];
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
X-Rspamd-Queue-Id: B2E945DA874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The normal capture for system/device cross timestamps is CLOCK_REALTIME,
but that's meaningless for AUX clocks.

Add a clock_id field to struct system_device_crosststamp and initialize it
with CLOCK_REALTIME at the two places which prepare for cross
timestamps.

After the related code has been cleaned up, the core code will honor the
clock_id field when calculating the system time from the system counter
snapshot.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: netdev@vger.kernel.org
---
 drivers/ptp/ptp_chardev.c     |    2 +-
 include/linux/timekeeping.h   |    2 ++
 sound/hda/common/controller.c |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -317,8 +317,8 @@ typedef int (*ptp_crosststamp_fn)(struct
 static long ptp_sys_offset_precise(struct ptp_clock *ptp, void __user *arg,
 				   ptp_crosststamp_fn crosststamp_fn)
 {
+	struct system_device_crosststamp xtstamp = { .clock_id = CLOCK_REALTIME };
 	struct ptp_sys_offset_precise precise_offset;
-	struct system_device_crosststamp xtstamp;
 	struct timespec64 ts;
 	int err;
 
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -315,12 +315,14 @@ struct system_counterval_t {
 /**
  * struct system_device_crosststamp - system/device cross-timestamp
  *				      (synchronized capture)
+ * @clock_id:		System time Clock ID to capture
  * @device:		Device time
  * @sys_counter:	Clocksource counter value simultaneous with device time
  * @sys_realtime:	Realtime simultaneous with device time
  * @sys_monoraw:	Monotonic raw simultaneous with device time
  */
 struct system_device_crosststamp {
+	clockid_t			clock_id;
 	ktime_t				device;
 	struct system_counterval_t	sys_counter;
 	ktime_t				sys_realtime;
--- a/sound/hda/common/controller.c
+++ b/sound/hda/common/controller.c
@@ -489,9 +489,9 @@ static int azx_get_time_info(struct snd_
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report)
 {
+	struct system_device_crosststamp xtstamp = { .clock_id = CLOCK_REALTIME };
 	struct azx_dev *azx_dev = get_azx_dev(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct system_device_crosststamp xtstamp;
 	int ret;
 	u64 nsec;
 


