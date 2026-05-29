Return-Path: <linux-wireless+bounces-37134-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O2mIenwGWoX0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37134-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:02:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F4F6082DA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28EB230A5D59
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222793382E5;
	Fri, 29 May 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjmMmw6q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EE3AFD1D;
	Fri, 29 May 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084816; cv=none; b=hR58/vH4viKLHQ9PiiOSSJK4wfvr1dqWARgPx88/aIydNQB4Zo4OSMNK3JbX5Yd1lOKE/Zh0W4StnIEJWXuvPzyAkW4PGtjs8jr6CiZrYLBcmFcnbKc9P8s3dAahafwQIcpL1FfrOHw3buAazWzJpKIqVDCQ5NOQ79X1uI+ViSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084816; c=relaxed/simple;
	bh=0d9RszKQ5ulW58jHf7D5TV+rJ/8l3Yc/0M72KLCVNI4=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=t2MDQ3Y+Bq5CvU97qOMJnRB81PghlfVDrHvTddxtbYjxEvys0Ei1LR89hiePGVkTJ1X1goQoN3VeIQVGmbObNoeoX4OhYCRYpNOcif6qZYkyjfwWubKRoA1C8yUmypPz97YCQ1011Kgxm8R+JEsjvgAuWFw0FxOG/3CQONNXpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjmMmw6q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4541F00893;
	Fri, 29 May 2026 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084814;
	bh=Qf8paJy4cCr3FX3U9NzV2imouySCZRszPEy7aqG40WU=;
	h=Date:From:To:Cc:Subject:References;
	b=gjmMmw6qGV7+Acyr7NUqTziVKS5F3FLQvtEfICyo2FepMlINoOQUL+6bMjgapGII0
	 X2KbiKPL/+pXaTEoJ2nIVdhUjxHs2wfWMsFZepXvK3JHtT5uyK2BW+/n7uAazqwWTJ
	 LLHpa1z8+g9/A9AA70wuAfqHw4UOhwFHmIQoC7zb4ZOOquvZNggbANYJUrp3ZrMYgT
	 sTmqCaoKr+2OTf+pAG9ER8wMwQ4eqXDbhx5glRvni2ZyilJA9CW7rDO6C23WRu1KZB
	 xbrzki1aMg6343o3MRBHAGmBlE3TAFY8nRqe4/ckhd46aOn/Z47QywnZz2zYZzNofR
	 a5+jMIYDAeUjw==
Date: Fri, 29 May 2026 22:00:12 +0200
Message-ID: <20260529195557.225399927@kernel.org>
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
Subject: [patch V2 06/25] KVM: arm64: Use ktime_get_snapshot_id() to snapshot
 CLOCK_REALTIME
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37134-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:email,amazon.co.uk:email,intel.com:email]
X-Rspamd-Queue-Id: 25F4F6082DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
request a particular CLOCK ID to be captured along with the clocksource
counter.

Convert the usage in kvm_get_ptp_time() over and use the new
system_time_snapshot::systime field, which holds the system timestamp
selected by the CLOCK ID argument.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hypercalls.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -28,7 +28,7 @@ static void kvm_ptp_get_time(struct kvm_
 	 * system time and counter value must captured at the same
 	 * time to keep consistency and precision.
 	 */
-	ktime_get_snapshot(&systime_snapshot);
+	ktime_get_snapshot_id(CLOCK_REALTIME, &systime_snapshot);
 
 	/*
 	 * This is only valid if the current clocksource is the
@@ -61,8 +61,8 @@ static void kvm_ptp_get_time(struct kvm_
 	 * in the future (about 292 years from 1970, and at that stage
 	 * nobody will give a damn about it).
 	 */
-	val[0] = upper_32_bits(systime_snapshot.real);
-	val[1] = lower_32_bits(systime_snapshot.real);
+	val[0] = upper_32_bits(systime_snapshot.systime);
+	val[1] = lower_32_bits(systime_snapshot.systime);
 	val[2] = upper_32_bits(cycles);
 	val[3] = lower_32_bits(cycles);
 }


