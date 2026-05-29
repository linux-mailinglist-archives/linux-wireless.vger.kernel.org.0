Return-Path: <linux-wireless+bounces-37139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPViA9rwGWoX0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:02:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C85196082CC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62DBD3065F2F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBB3A8741;
	Fri, 29 May 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM5E4/85"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF142980A;
	Fri, 29 May 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084836; cv=none; b=nXlHUl8+XcaTId5cTR0NACrogP6aygEYdb8kyTFM69XfIeb4Vl/RFoNkqtb8CjkDUR36SPVJHravgh8xwIMI77AStfPyrbPFVWcrPBdsGBqELO9V20kzp6AeuukBmUXnQnric8uhF1aM5uA0nKb/swHCm9bmxmj20HQ9lttFPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084836; c=relaxed/simple;
	bh=dey8iRymM7vLMYV5UGJf+eaqqnGtoU5Ev2K55WxpyzM=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oE6dLFbjiAexZ1l3FYQb7EGcTvmc1Kns9MBn5KydCGri+JZVqMs3sAj8DnG59aLy+sJ/+nG6oVydEkSW3SX+6niadwFk7LsbLaCOh9La9AUOVcm8l9sy2XdRjDyAZ8JVxAux06KnGZGTLjoDW3uFvbsnUGWF3L57V8aLlQExM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM5E4/85; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC91F00893;
	Fri, 29 May 2026 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084835;
	bh=SKtcApTyTHzie8ozCXbhX547ZgXhyRfMe740j/N9Ov4=;
	h=Date:From:To:Cc:Subject:References;
	b=SM5E4/85RCzamZQ3ymZEtEOZ0kip2WKBP1GTaCKe+v3f6xwjQn8jGG95mZas7jQdR
	 3AsUqDehajMjCk8urEa6MlRjCa6U0yhDQpDQN5PiypCHiEUvpVhv9JDlDtr3vBtKPX
	 PTq/BJRIGWJNO0b8qS/jOjOb022grqBYr/Q+4hW2Sr27B/OmEqavzPL3DfwtOtvJQD
	 /htCZdjwdt1YDlcJ+De9dqr+EEjc78W8VHGL7jpZFWetrJV2GWwZQ7pzIjhUTCNL9Y
	 gpSPbOuLL8YFfE/RTyUKVnzCMDadpmdkyYAP5K3P2P1oDPRW/bRDwxQ/HwBmLh30cf
	 ZPj/+NV726gJQ==
Date: Fri, 29 May 2026 22:00:32 +0200
Message-ID: <20260529195557.482153523@kernel.org>
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
Subject: [patch V2 11/25] timekeeping: Add CLOCK ID to
 system_device_crosststamp
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37139-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C85196082CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

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
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
 




