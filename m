Return-Path: <linux-wireless+bounces-36921-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDobFfLcFWrTdQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36921-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:48:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B65DAEBA
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317503204C65
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED043D513;
	Tue, 26 May 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQY+aGWC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704113BB117;
	Tue, 26 May 2026 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815697; cv=none; b=rxM8t4MXMzWbE/UxzlW/BdHA1INVWep7Shwe8oT0No9I/ROdr9Tt32iryXFloGYZlHy19sNpq6HOH9HgfoQMR/seKCZGzTyvcTPUwYkZPmhXLLT3JpImbOfKzB1i4uXyLZ5e748lRxgVZr9Zk4TsKiBsbc9/H7CR2DwbYkb3VIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815697; c=relaxed/simple;
	bh=SK/3JKLXcdAd0YA9Id3+ZKQgFkUKWMlumDPX4kWtLcU=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JCrO35mhWKknXwpY1yvrh5xDskX3PkXTYprj3GahMhvtkhagJ2okfGEJJUvp0lDvdSU26wwlOd4gdqaNCKNyp7qEUj1znyiM+n7VahzLJgY+2z8Uz/oPhg21NFihhx+zqjArkXlqwlc/VT68VcsjhMc29S3hMn6rubi36axQrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQY+aGWC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 234611F000E9;
	Tue, 26 May 2026 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815696;
	bh=VlSkpOxaAvhGprMh41yHQUf26c+3JClC3KsUbd0ubDw=;
	h=Date:From:To:Cc:Subject:References;
	b=BQY+aGWCDcmMJKzgY+cWui4K1C2HgXKdKaImj5UTEZpsSPFJSzfMmHDq29Xpv2CPo
	 z2lYBNm+P6naa+5EslAF6iwutkvHVBb4yTZC62mAdofF/i1BZyO0g+hr4ZBgJbUit7
	 pQYbuFbo0mUjuEsg9mh8oFqcVTEYa/4R0mDcE6SiPiXkSRLp2rNmrb7wik9HmwOeyY
	 /lfYfPrUQyMw4nDbIm18XS8UQ/D6rizQK/Tn/LUt7E/1G7YgB8CsWb5xPJi1fL3HuX
	 Cvc6eCFK83cJzh6dAGZfmZEHAO+YtY581OhrWQW5SnHrOjVcJom8QdeVWlKylolDCg
	 DEplBp341GV6g==
Date: Tue, 26 May 2026 19:14:52 +0200
Message-ID: <20260526171223.974925389@kernel.org>
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
Subject: [patch 17/24] timekeeping: Remove ktime_get_snapshot()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36921-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 909B65DAEBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All users have been converted to ktime_get_snapshot_id().

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/timekeeping.h |    5 -----
 1 file changed, 5 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -351,11 +351,6 @@ extern int get_device_system_crosststamp
 extern bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot,
 				  clockid_t clock_id);
 
-static inline void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
-{
-	WARN_ON_ONCE(!ktime_get_snapshot_id(systime_snapshot, CLOCK_REALTIME));
-}
-
 /*
  * Persistent clock related interfaces
  */


