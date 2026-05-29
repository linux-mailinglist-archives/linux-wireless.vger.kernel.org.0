Return-Path: <linux-wireless+bounces-37143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPPzOkLyGWpl0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B96083FC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB89030929A7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138B43D508;
	Fri, 29 May 2026 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTZlNGjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1A43DA59;
	Fri, 29 May 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084854; cv=none; b=kPoJ3T90TqQN3iSZjug9nO1qqUtTi1Z0GHCq/ePtvoRVIBj76g0fjcPtL4Tn5bTICtI/fZIER00f5ErGbtPJg5I+QiRppLCYBys6/Petqtov9Mc2ajeLpl/AqGSWsJg33qnFCDNfmH26kCOHTfiPcqLtkw/DwqOxjVF7/YFzvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084854; c=relaxed/simple;
	bh=If9J1GmjwMtQvSz+pg01slinGqWkmlTrsmHY4xb16eY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Hv0tzuSHGlKjsIm9/LHkz4gte1izi4psEfEYSo1FNg6ZIBtJAuu3WjbehX6PSvzCIrsPkKaWEUI5wEPt4LVuyQEv3e1azL1o/bB9atB/xU5h2fkAcTnWPurquKxmrRsQ/hSi319XAXuj/7KhuN+b85bxZ4L5HOWJC+8L/EeEF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTZlNGjn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9355A1F00893;
	Fri, 29 May 2026 20:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084851;
	bh=AGLK7Fz7hIMtNoUOd7+F7HYWK+G9Ck5b7ho1TTE1Pao=;
	h=Date:From:To:Cc:Subject:References;
	b=VTZlNGjnLQP82nAQIT5UXLMUjmtNDd2A7v2a9GSV7+LB8qhmhymXij7snJ2ijv6kN
	 KTdy1XkjypwTq9kPo4ilNBj0b5zfGwAjKVJbYIsB1qHmHdk4uuN2Dty88VnsmXoedW
	 e8Pka5j0qjC6HZFEJyVtTG19XWy3aPFJOr3Jpn5ug5Bx9Uhx+2VC8ragZfOl9vqs/l
	 kkhLWomfTnMG+xZ5Bh7kaIP63O48yvmn34yWvZy2EKV35ltrsbn25yhZGHoTp2a22N
	 FxjdhvMc0q00uhHjTWm33owx9xRQWm83SJDDpcJOrEju0F3MBA2N2IYmGsCXQJO99q
	 /SrY1IBYrgS9w==
Date: Fri, 29 May 2026 22:00:48 +0200
Message-ID: <20260529195557.689836531@kernel.org>
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
Subject: [patch V2 15/25] net/mlx5: Use provided clock ID for history snapshot
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37143-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 6D9B96083FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

The PTP core indicates in system_device_crosststamp::clock_id the clock ID
for which the system time stamp should be taken. That allows to utilize
hardware timestamps with e.g. AUX clocks.

Use ktime_get_snapshot_id() and hand the provided clock ID in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -340,7 +340,7 @@ static int mlx5_ptp_getcrosststamp(struc
 		goto unlock;
 	}
 
-	ktime_get_snapshot(&history_begin);
+	ktime_get_snapshot_id(cts->clock_id, &history_begin);
 
 	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicetime, mdev,
 					    &history_begin, cts);
@@ -366,7 +366,7 @@ static int mlx5_ptp_getcrosscycles(struc
 		goto unlock;
 	}
 
-	ktime_get_snapshot(&history_begin);
+	ktime_get_snapshot_id(cts->clock_id, &history_begin);
 
 	err = get_device_system_crosststamp(mlx5_mtctr_syncdevicecyclestime,
 					    mdev, &history_begin, cts);


