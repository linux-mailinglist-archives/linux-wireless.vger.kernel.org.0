Return-Path: <linux-wireless+bounces-36918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH0mI5HWFWrRcwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:21:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB05DA8AF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B28F300E3E5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039B40DFDC;
	Tue, 26 May 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVagiMvh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A338C42F;
	Tue, 26 May 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815682; cv=none; b=YSjXG2YMWnUU6PfXa7SNrq6YHTSwoKoWzi8b5HB6xCV5BwSZM2Ah9+ROTK/oLbz1RffB6S4WkT3VXiKUzVnUTcSBVGhr3ZG7jJc5nlyrPMipmdBM452bvOWaTU8Osr+NOluv4kgyILNXQjvtu3wvqUEqcdDwayMoc4RuLgOTypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815682; c=relaxed/simple;
	bh=FMGiUIWW29SL0cXr9CKSy7VJv5vDZCiZTj4ZKb2FdvQ=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RS6gP1RmF96rtPP/ykk0YuM/2WphnOjebY5pswFJP8LcPblzdiao18dq4j6GOtUFybDWeL/+p5rdmxgRAN5+IoBDhWNkq7vzI5kN7hleK4ByelGGcDKLHZJLTO45jDuIblTtlX9sEgTr5y90zlJDrwa00LK8UyIvif4YMuSjjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVagiMvh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A0861F000E9;
	Tue, 26 May 2026 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815681;
	bh=R0VKXSe8JW8k5VwE7MkMVpULu2pZ+xlu5Y3DpfUjVmo=;
	h=Date:From:To:Cc:Subject:References;
	b=JVagiMvhbmqyJMx9X+aTaV+UDZZvwgWYIrS+aNgU2okDyiRIvRvbFwz/A29WTxXS8
	 51r1Q1MIsLtqJQrlTjMBT49ltU+58Q0N4q877Fv2BGYN9x445JKtjA7c2do/7EeG2+
	 TaruBcMC5dzJrtT+otenMpWyTM3hE6yxlGWZkq2pIW1+1iUkU0Qvt+v2sYFuUbUfUV
	 NIV905YFJB86dXqFnuJxK39b8EQ2knTmu0hqMojX10drt1XUyieb8jsVsU6lkRTBBm
	 LtMs0ZDHSYln9h16lwj6xJA+iKtE9+hfHS1MiqAdOnrSnVDgT/imOMh0wC8Kg59MIZ
	 qQNWppVCV66cA==
Date: Tue, 26 May 2026 19:14:37 +0200
Message-ID: <20260526171223.745281238@kernel.org>
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
 Tony Nguyen <anthony.l.nguyen@intel.com>,
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
 Saeed Mahameed <saeedm@nvidia.com>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: [patch 14/24] igc: Use provided clock ID for history snapshot
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
	TAGGED_FROM(0.00)[bounces-36918-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,intel.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,nvidia.com,oss.qualcomm.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 05EB05DA8AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PTP core indicates in system_device_crosststamp::clock_id the clock ID
for which the system time stamp should be taken. That allows to utilize
hardware timestamps with e.g. AUX clocks.

Save the provided clock ID and use it in igc_phc_get_syncdevicetime() for
taking the history snapshot.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h     |    1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -326,6 +326,7 @@ struct igc_adapter {
 	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
 	struct system_time_snapshot snapshot;
+	clockid_t snapshot_clock_id;
 	struct mutex ptm_lock; /* Only allow one PTM transaction at a time */
 
 	char fw_version[32];
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1049,7 +1049,7 @@ static int igc_phc_get_syncdevicetime(kt
 	 */
 	do {
 		/* Get a snapshot of system clocks to use as historic value. */
-		ktime_get_snapshot(&adapter->snapshot);
+		ktime_get_snapshot_id(&adapter->snapshot, adapter->snapshot_clock_id);
 
 		igc_ptm_trigger(hw);
 
@@ -1103,6 +1103,8 @@ static int igc_ptp_getcrosststamp(struct
 	/* This blocks until any in progress PTM transactions complete */
 	mutex_lock(&adapter->ptm_lock);
 
+	adapter->snapshot_clock_id = cts->clock_id;
+
 	ret = get_device_system_crosststamp(igc_phc_get_syncdevicetime,
 					    adapter, &adapter->snapshot, cts);
 	mutex_unlock(&adapter->ptm_lock);


