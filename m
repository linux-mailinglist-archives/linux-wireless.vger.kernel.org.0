Return-Path: <linux-wireless+bounces-37142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMXdBVHyGWpl0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE660840A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C74312A69F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CB6425CC9;
	Fri, 29 May 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpMxLFcA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387E42189F;
	Fri, 29 May 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084848; cv=none; b=pAcw6JnO/XXF7Q08VsNbEnPBX/2Bq4nMDKbtZoT6ACOEJiyU5kbVFATp+N9d6+LKJv/WZxdMKeRQVTnlj6FDvZabKCf98LwiWTLM06xIgxqxv2xYjsOz4mVroAhg40NT0SgtALhkmyAuUJ/qSHedYYGrdQr58vXgLN9XLHOGH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084848; c=relaxed/simple;
	bh=9h44xDzk/nsmksBrMxzxTymh97zrP5YJwq4ovabSkLc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SdC0pkD5/s5C/vu/YlfCiUYYtE6LxB2WMf04FOIFemmCNdRCAizZVV04eCAZ62WaUm62o7sauRSW8425dcGNy7fT1ribqADeh5WgAZEA6968sG57e6FpD/EWf3i4ANlAQbzmK+ySvzGtXF0SmvVhOPPnquai9vrK1nDNZnrVmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpMxLFcA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ECA1F00893;
	Fri, 29 May 2026 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084847;
	bh=XYNT0eEpSeu3BKtrv2cuCAZMt8IThI/nHA1fOsyw8Do=;
	h=Date:From:To:Cc:Subject:References;
	b=ZpMxLFcAbmjMSbsGKjqTdwpU1V3XXcrdTnPC9U1kk+bcHnzYThtbYqI4ZaJf3jWqE
	 ia4Zs0zSRAJY2iAaljZx2A5fECiFxU2H+sxREcYQofD3dlXdmYI9FjePEukp7EtZGb
	 XFVKYDaHEEAz7W16M2d37bzwzcGho66wpCBmYezOC0/g4cebDRRvaYCThwAWVsy419
	 SFuVOsOjka4nshaJV/CuJiHfFYnjW8LrTY44VXdTSHaW8VaRKzHh739e+nJy4gRg0l
	 9A08TKX/0KcNFCu60AMucb1pQqh3b17oYPjLhLusuj9l3wQ+sU3lJg2GQKeTLthgoe
	 GcU6Z9MSKfA2w==
Date: Fri, 29 May 2026 22:00:44 +0200
Message-ID: <20260529195557.637381831@kernel.org>
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
Subject: [patch V2 14/25] igc: Use provided clock ID for history snapshot
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37142-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amazon.co.uk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 91CE660840A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

The PTP core indicates in system_device_crosststamp::clock_id the clock ID
for which the system time stamp should be taken. That allows to utilize
hardware timestamps with e.g. AUX clocks.

Save the provided clock ID and use it in igc_phc_get_syncdevicetime() for
taking the history snapshot.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
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
+		ktime_get_snapshot_id(adapter->snapshot_clock_id, &adapter->snapshot);
 
 		igc_ptm_trigger(hw);
 
@@ -1103,6 +1103,8 @@ static int igc_ptp_getcrosststamp(struct
 	/* This blocks until any in progress PTM transactions complete */
 	mutex_lock(&adapter->ptm_lock);
 
+	adapter->snapshot_clock_id = cts->clock_id;
+
 	ret = get_device_system_crosststamp(igc_phc_get_syncdevicetime,
 					    adapter, &adapter->snapshot, cts);
 	mutex_unlock(&adapter->ptm_lock);


