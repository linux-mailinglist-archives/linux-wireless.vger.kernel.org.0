Return-Path: <linux-wireless+bounces-36907-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YANwE97VFWrRcgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36907-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:18:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BEE5DA7F8
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CA2B3028443
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C8641B366;
	Tue, 26 May 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBaPgM/x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CC409118;
	Tue, 26 May 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815633; cv=none; b=X9U888iuUXrde4aHwuqEBacTzcJXsUEugSTOcFsYY69+iFGMtmGibaeKDpxyRKIWRvL945rWyOcKcbpUwtfKCCernyCWWux6EkG+D/9Z9312gzrGrTGykqtIiSi5gufun3+fVXc8vjxsXekfnNZ2SXazTm9gjUirtZd2OHQZ+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815633; c=relaxed/simple;
	bh=Jo/Au8bQYAno4GeE3KqHD8eiAALVUwsf3qSc631Dg88=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZjBEMoopTvEmDPdo8fmix8jDVfNJKp9wOL1FmOJy4QIwbXcRFuATW61AmfJOpWL3cbvC19acXkJCb3z6oMWVlFfxB2dsyPWxAJ0wBgK0J0rqee8AxMf5NTlCb/nQxqWo/WiG/Imu65+9GYuX9MELsUN1ikEmmL3FzGG1jmgtgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBaPgM/x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CAD001F00A3A;
	Tue, 26 May 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815626;
	bh=X0scQND1xJm72l+yu4qfzG29LQeAoWdi/2lmLZs8YK4=;
	h=Date:From:To:Cc:Subject:References;
	b=gBaPgM/xsCiUVCAw9BPRWT13zmyadEtGDb6uVyJdpOXvhWBk2ulU534ck+xRoQ//k
	 9sUHIZvMsrUTuJPwaQzLyKyf1L1zY3Lo8ZxJ8SAsmKCTgb/GF9F7HZxiNCsS0Zpg/k
	 nuU0oRAvZF6Qvj/Q+n5ulI4ai+250J3JNiqk9gnayFDcEntnuAxW2eV1zJi8SFy+nZ
	 G0Ha02ne6Ck8Pi26tBsHGkCFMA4ybw53o2riJmtasNU+NfZ+pSqIknkIgG4R8byMwb
	 NDmOd+QhbvSXAOBtuxGyy5RsFc93k/j4gZIgiBn2RM3VKW/510aFVqzMjHXHWgpHXN
	 Fa0BUCoW+3qcQ==
Date: Tue, 26 May 2026 19:13:43 +0200
Message-ID: <20260526171222.920736414@kernel.org>
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
Subject: [patch 03/24] pps: generators: Use ktime_get_real_ts64() instead of
 ktime_get_snapshot()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36907-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,enneenne.com:email]
X-Rspamd-Queue-Id: E2BEE5DA7F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no reason to use the more complex ktime_get_snapshot() for
retrieving CLOCK_REALTIME.

Just use ktime_get_real_ts64(), which avoids the extra timespec64
conversion as a bonus.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/pps/generators/pps_gen-dummy.c |    6 +-----
 drivers/pps/generators/pps_gen_tio.c   |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/pps/generators/pps_gen-dummy.c
+++ b/drivers/pps/generators/pps_gen-dummy.c
@@ -39,11 +39,7 @@ static void pps_gen_ktimer_event(struct
 static int pps_gen_dummy_get_time(struct pps_gen_device *pps_gen,
 					struct timespec64 *time)
 {
-	struct system_time_snapshot snap;
-
-	ktime_get_snapshot(&snap);
-	*time = ktime_to_timespec64(snap.real);
-
+	ktime_get_real_ts64(time);
 	return 0;
 }
 
--- a/drivers/pps/generators/pps_gen_tio.c
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -189,11 +189,7 @@ static int pps_tio_gen_enable(struct pps
 static int pps_tio_get_time(struct pps_gen_device *pps_gen,
 			    struct timespec64 *time)
 {
-	struct system_time_snapshot snap;
-
-	ktime_get_snapshot(&snap);
-	*time = ktime_to_timespec64(snap.real);
-
+	ktime_get_real_ts64(time);
 	return 0;
 }
 


