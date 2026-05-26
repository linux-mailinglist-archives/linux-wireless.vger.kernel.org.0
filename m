Return-Path: <linux-wireless+bounces-36919-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD22H9/XFWpYdAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36919-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:26:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 200E95DAA2F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 045C13053BE2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0043CEDB;
	Tue, 26 May 2026 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cILTQson"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D8403E99;
	Tue, 26 May 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815687; cv=none; b=qeQTjGPTCrIEzE0siYs7GFFyFaY5WMGrMj7KY3rQw1G2FHOFPulY0KBC5rnRrLOADGeac6Im9W8Bk5oZ2JWEDP6IkxOHas/YL28WYJ5E8VC8s46HCeNpaqNkgrpS0E8b6dEwZ1VkLzl9kC1Q0+KVFW7+w/A3G8tRA9WNuZ20PQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815687; c=relaxed/simple;
	bh=eqDmv2UxJrRVlr6eig+h4vADLMNuDousFQxN6Zd4qtI=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=n1kCtIy/BoL7wGh2iLMdSjf31jWnl4UIw6geHDIde7HhkW8ynC7FuGC4eCcJNblKg6VPJc1oQPSzxzvWlQTB0V7b4upVslYn1p2BV1OP/ELfAPuk6G84U/A+ljQpeqaIyNs8mHEH4z5ITMHmE8B/B6O1AUxLZjZaG4VNhO02lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cILTQson; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1B2411F000E9;
	Tue, 26 May 2026 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815686;
	bh=cBO+dX735CksKtXJ1HJ6TXwHjNQmqyoR/p2tV7cxXb0=;
	h=Date:From:To:Cc:Subject:References;
	b=cILTQsonW++0qS7x+cFj3PEdFUuahq/pXsnEuKC8tyzniFVBXJd5h8Ig+wX52U8nw
	 gvjeABRhU4sekjYYnLQT9DOEehvX5hcUhBx5B0E41+Zd2Z/FwXGbjiB5GPOCcBEFrm
	 EGyNzpdo6ZS3w3lEShtw8oaNynpYrJLZnNlBGexShIj5GrhT7qzy84w5ReeffvpeMt
	 6qwlJJVOwtf8GkuyB0WyjKN7lHEfi5wyIE0Z8XsKLlqqq+rlP8pt/NdLpmHeWOGVqN
	 TXuSzUw1zK+ZvcOTSlzyDDXes/VBxBcl3zCCVCRQbEy+JQ8Df3/e4xGFlXzdDqyUJL
	 vg0GpsVpO/enw==
Date: Tue, 26 May 2026 19:14:42 +0200
Message-ID: <20260526171223.826096151@kernel.org>
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
 Saeed Mahameed <saeedm@nvidia.com>,
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
 Peter Hilber <peter.hilber@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: [patch 15/24] net/mlx5: Use provided clock ID for history snapshot
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
	TAGGED_FROM(0.00)[bounces-36919-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,nvidia.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,oss.qualcomm.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 200E95DAA2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PTP core indicates in system_device_crosststamp::clock_id the clock ID
for which the system time stamp should be taken. That allows to utilize
hardware timestamps with e.g. AUX clocks.

Use ktime_get_snapshot_id() and hand the provided clock ID in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -340,7 +340,7 @@ static int mlx5_ptp_getcrosststamp(struc
 		goto unlock;
 	}
 
-	ktime_get_snapshot(&history_begin);
+	ktime_get_snapshot_id(&history_begin, cts->clock_id);
 
 	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicetime, mdev,
 					    &history_begin, cts);
@@ -366,7 +366,7 @@ static int mlx5_ptp_getcrosscycles(struc
 		goto unlock;
 	}
 
-	ktime_get_snapshot(&history_begin);
+	ktime_get_snapshot_id(&history_begin, cts->clock_id);
 
 	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicecyclestime,
 					    mdev, &history_begin, cts);


