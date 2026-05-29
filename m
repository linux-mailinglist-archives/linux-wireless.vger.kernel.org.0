Return-Path: <linux-wireless+bounces-37130-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGo0CW/xGWoX0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37130-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:05:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4078608335
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9902530DFD03
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86693F44CB;
	Fri, 29 May 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaelR0yi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF92400E18;
	Fri, 29 May 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084801; cv=none; b=kcN8X9N0DRoojRgsJ2OcTHdBo7vU/K7w9zamjV/U+HOlzoDJQ9LBqADYhumDUU7YJtkB+PpXHsbB7ZRVSrnJZYr5ZyFX6zsOf+ZyA7Mfds4wmcW81fEixzUKrM6bFlXRNhea8iMNNG8vCWdRihcMHq8qTK6oHUs820EM7sDoRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084801; c=relaxed/simple;
	bh=kDMLq81zxEY3Qw4+XcEyqMbRH/WjQHnFMlcYVQsYZVY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XJVjhyxpJIi+7LZHXNgx/NHOWrM3vNZ804IlR+t379/j7CIO5CwiSx1D/qT9tYN/C93Wb/1pq/GODD7nJUTDOVDQsbnn9eI4Ye9KmnoyYJPFp1z0jDaOY8i8kh1qXsHM60Fd/QVJTpm10EL1H8JTAjI90HsH2bnoleQ1fjYJjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaelR0yi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34271F00893;
	Fri, 29 May 2026 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084798;
	bh=SYZ624D4hDEc52N2OKneCwOVvZYQ+Bp0/K98maxT9oY=;
	h=Date:From:To:Cc:Subject:References;
	b=YaelR0yiAtSst4y0mzGC1GpZAkPopCwiuQ3mH9DLVzXkA2YTvC17xV5egGZntbYg1
	 wWMFe84g2pt30yMBbCO5A1YhJSYGwH7sPlZSwZEYc9CEHkRL+TE9tx3UgDRTozSbV1
	 fMuYqX0SdS1O0tb4ofkrZMBETUznjm0cFkTjELwHVslX0CZ8LKpQvb+IDJma4S8kE/
	 PbDILniROT7XIp+FD6hGlXtgR3Gfa5b6g0pcR322EX8sbnXKYpGE5RBYRxfTrs6quT
	 U755hCDPjyfsgNt6vzBptpz9eljN0qom2KQQjn8lH6whD+Mm+yLo88j51GNN1shp7b
	 7X7dmjpeje8XQ==
Date: Fri, 29 May 2026 21:59:55 +0200
Message-ID: <20260529195557.024415766@kernel.org>
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
Subject: [patch V2 02/25] timekeeping: Use
 system_time_snapshot::systime/monoraw instead of ::real/raw
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
	TAGGED_FROM(0.00)[bounces-37130-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:email,amazon.co.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B4078608335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

system_time_snapshot::systime provides the same information as
system_time_snapshot::real when the snapshot was taken with
ktime_get_snapshot_id(CLOCK_REALTIME).

Convert the history interpolation over to use 'systime' and 'monoraw' as
'real/raw' are going away once all users are converted.

As a side effect this is the first step to support CLOCK_AUX with
get_device_crosstime_stamp() and the history interpolation.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 kernel/time/timekeeping.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1323,7 +1323,7 @@ static int adjust_historical_crosststamp
 	 *	partial_history_cycles / total_history_cycles
 	 */
 	corr_raw = (u64)ktime_to_ns(
-		ktime_sub(ts->sys_monoraw, history->raw));
+		ktime_sub(ts->sys_monoraw, history->monoraw));
 	ret = scale64_check_overflow(partial_history_cycles,
 				     total_history_cycles, &corr_raw);
 	if (ret)
@@ -1341,7 +1341,7 @@ static int adjust_historical_crosststamp
 			(corr_raw, tk->tkr_mono.mult, tk->tkr_raw.mult);
 	} else {
 		corr_real = (u64)ktime_to_ns(
-			ktime_sub(ts->sys_realtime, history->real));
+			ktime_sub(ts->sys_realtime, history->systime));
 		ret = scale64_check_overflow(partial_history_cycles,
 					     total_history_cycles, &corr_real);
 		if (ret)
@@ -1350,8 +1350,8 @@ static int adjust_historical_crosststamp
 
 	/* Fixup monotonic raw and real time time values */
 	if (interp_forward) {
-		ts->sys_monoraw = ktime_add_ns(history->raw, corr_raw);
-		ts->sys_realtime = ktime_add_ns(history->real, corr_real);
+		ts->sys_monoraw = ktime_add_ns(history->monoraw, corr_raw);
+		ts->sys_realtime = ktime_add_ns(history->systime, corr_real);
 	} else {
 		ts->sys_monoraw = ktime_sub_ns(ts->sys_monoraw, corr_raw);
 		ts->sys_realtime = ktime_sub_ns(ts->sys_realtime, corr_real);


