Return-Path: <linux-wireless+bounces-36926-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ04LcjXFWoSdAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36926-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:26:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 345845DAA10
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12332306C133
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44A450918;
	Tue, 26 May 2026 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ9txE58"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA420405C51;
	Tue, 26 May 2026 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815722; cv=none; b=fUp1DAV4SFcfckrCpYCS7C5Oh1S1o6QFjq9bqis+pNOrvNIxlhrwrg5IYJmB/CyHY1eZG0nEJiRiUDzdu2hKyCc7qoU3AijDmoT0EV1lmnvyDAPzgdxZ/6GLUjfKfpf75eAClL0bwWkjbmayGbSFV+IWu+BzoEWqqjgafBDxanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815722; c=relaxed/simple;
	bh=taA3JhJ8LfR540IvF/KyclmLykmRPPkG2o8PM3ZOnT0=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IBleQwZ2eL06uIg89lsmC7arA2EIHCdKzgYPEFHGj7GT7HT8C7vpVfmAsyXLDYManmnkZPR7WxqEGMqlt9QNxq2DMCkMOYs13XXdPIWFlUQuI/9Dy4nzFpW04pJG/wY7pjGX0X5oWIbSARnvO0oddUA6lS6o1tUqgRG8i5IIl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ9txE58; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B18251F000E9;
	Tue, 26 May 2026 17:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815720;
	bh=iP9+Ejq+468GjDeS30IX6KFuH3pNpoH1TK3AxvpH6jM=;
	h=Date:From:To:Cc:Subject:References;
	b=mJ9txE58645sQz4WH7pcRhejpZWtR9+rOPLzP0JoT85ne5BnRR3eoGxgqeuO3sXvm
	 EDc64YGg1uTPw64JEPsVEU/b0dm7bVYiFTnD5hKg8/FVmMxA1ScVOaLF0PhpzwUb5k
	 uhplXMkSmgbQHiK5PBnr1dcuFNlqkToeEut6YWN/aSkUqlVNM00Sbl3WNlBTldhqY2
	 MGZPhvQKA/s6B0w3VRRX87UD4VEiMcJe2sWsfB1gXznCB+F+EUlGDhtihWuk9QUL85
	 9ENqoFtbpNE1NpBSkPuMTHrYCHzxJdmm4U0cyui2DB26SCFwqza711Wm1FkFMnJ1f1
	 Qk8tMpgtfmbeQ==
Date: Tue, 26 May 2026 19:15:17 +0200
Message-ID: <20260526171224.347997043@kernel.org>
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
Subject: [patch 22/24] timekeeping: Remove
 system_device_crosststamp::sys_realtime
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36926-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 345845DAA10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All users are converted to sys_systime.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/timekeeping.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -318,7 +318,6 @@ struct system_counterval_t {
  * @clock_id:		System time Clock ID to capture
  * @device:		Device time
  * @sys_counter:	Clocksource counter value simultaneous with device time
- * @sys_realtime:	Realtime simultaneous with device time
  * @sys_systime:	System time for @clock_id
  * @sys_monoraw:	Monotonic raw simultaneous with device time
  */
@@ -326,11 +325,7 @@ struct system_device_crosststamp {
 	clockid_t			clock_id;
 	ktime_t				device;
 	struct system_counterval_t	sys_counter;
-	union {
-		/* realtime goes away once all users are converted */
-		ktime_t			sys_realtime;
-		ktime_t			sys_systime;
-	};
+	ktime_t				sys_systime;
 	ktime_t				sys_monoraw;
 };
 


