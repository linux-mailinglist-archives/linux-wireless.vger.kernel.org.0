Return-Path: <linux-wireless+bounces-36909-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF0VMrTYFWpYdAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36909-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:30:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD815DAB1B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 324CE316F319
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC4403E96;
	Tue, 26 May 2026 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iukdoetf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0C41B360;
	Tue, 26 May 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815639; cv=none; b=jk4lr9HZy1DwBaY/yXz9s7U5BlSRyy+Ct5b79cmCdqdIinY+CI+sQw5sT60kgz2fdds9Lcmr/bnDCCj4AipypMX3d/h8HQQb20OFlzuIuYyL34XrVs/HEImAjHPXDVd/KV+d9UFVJyG4UTAxHQczPTyvRL2gK0TEt/Z5bDueROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815639; c=relaxed/simple;
	bh=+xAbAhBIS4NGDmtAAjjXvloqPhdiK33Jmo3iTUVq4nc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=c4Lh77iIyZznHHh/GJf562Ykw6pncsXu4BjdnqDlwByaufnPgK9MdUTZuQIalTHG52tbNVHzH65XuaL+WqxZf2b3Fv00KdzCtMeY4BaZapWvCw/60dEdq3qVt6nuK0b+wjVQzGs0Y06Gnn9l1cV9k8Tv+bc3NF289p9SlonuBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iukdoetf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E9CD71F000E9;
	Tue, 26 May 2026 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815636;
	bh=Gcy0P/M1Djdc6nKd+KuNGUSSaq76qqVC96BEfx+Xwt0=;
	h=Date:From:To:Cc:Subject:References;
	b=iukdoetfKrX1GZsDkEFJmdiHvi94z/tMq5+r075qR0HQyvl5j6b64YcqTV4YErqCq
	 IH6Y6XxUHAhhQM+MIGbJmv+8durUSeKgJaGYnH83leu02cUIIiT/+5iIgko//DbDTB
	 O82eKlM9dxrMS5Sfl9NdffCXgROTcdY4ffrQ8HxjurJxeN+gWIlV7/eu1gHaib9Gv2
	 yfCci1ENOXJmk5fnx4tfEQTajgQUEZmYnszEQn56+UlpJij7f5WDZyi82eJrMXteQi
	 KMlYSk/URU4OFeBo0fSqQNKCwHLlaW6kZN+dzo8Iy+ndknLq4YkBv2oPx9CONXaKqH
	 f+z0l038h08ow==
Date: Tue, 26 May 2026 19:13:53 +0200
Message-ID: <20260526171223.070087856@kernel.org>
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
 Vincent Donnefort <vdonnefort@google.com>,
 Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev,
 Rodolfo Giometti <giometti@enneenne.com>,
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
Subject: [patch 05/24] KVM: arm64: Use ktime_get_snapshot_id() to retrieve
 CLOCK_BOOTTIME
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36909-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,linux.dev,lists.linux.dev,enneenne.com,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2BD815DAB1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
request a particular CLOCK ID to be captured along with the clocksource
counter.

Convert the tracing mechanism over and use the new
system_time_snapshot::sys field, which holds the system timestamp selected
by the CLOCK ID argument.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: kvmarm@lists.linux.dev
---
 arch/arm64/kvm/hyp_trace.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -51,8 +51,8 @@ static void __hyp_clock_work(struct work
 
 	hyp_clock = container_of(dwork, struct hyp_trace_clock, work);
 
-	ktime_get_snapshot(&snap);
-	boot = ktime_to_ns(snap.boot);
+	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
+	boot = ktime_to_ns(snap.sys);
 
 	delta_boot = boot - hyp_clock->boot;
 	delta_cycles = snap.cycles - hyp_clock->cycles;
@@ -118,9 +118,9 @@ static void hyp_trace_clock_enable(struc
 		hyp_clock->running = false;
 	}
 
-	ktime_get_snapshot(&snap);
+	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
 
-	hyp_clock->boot = ktime_to_ns(snap.boot);
+	hyp_clock->boot = ktime_to_ns(snap.sys);
 	hyp_clock->cycles = snap.cycles;
 	hyp_clock->mult = 0;
 


