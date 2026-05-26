Return-Path: <linux-wireless+bounces-36923-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBr2OTrYFWpYdAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36923-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:28:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5625DAABB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A40F305DF97
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA0449EB1;
	Tue, 26 May 2026 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ1ZSVWx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8724418F2;
	Tue, 26 May 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815707; cv=none; b=Vmde5F9rKyv1ZAqVfhf3+dN/oybU/uqExgbuF+vOTzTojrDofrxsQ0eobushOT2lOGG/qJV2hf8kEeewCT2hagVaErSUB6UkJKFLoEnjlUwBlbUJ0tETTwwyjytW6ssQIScqwaCtrZ8rJiq+HAITTXYm0QZPmv4eZuOYr3SvOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815707; c=relaxed/simple;
	bh=YURwA6+s+6fPB1LThEMXPoxgu0rZtCRJgZo7bvbyX5Q=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=luko1SWdhCvfMdxmnXeuQ8XL0rHv7UxQJ+tq/EOn5QeZREv0Yu8RRdh2CaqidkZXlIesbgLtUKFrDbjIAeHqndsgyiqT5lhWZKtpq0VpKifozZH049oeppKcXYBwRuTQ+X1sgz1O+FvpurFGy3vjzWlACmzSqmuIDdqlv+UrLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ1ZSVWx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BD3191F000E9;
	Tue, 26 May 2026 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815705;
	bh=yhwQYYAvyeyOA5BotIUCq0FAeRMIiVuWdgIXT7OQn38=;
	h=Date:From:To:Cc:Subject:References;
	b=TZ1ZSVWxd5rpQdtcvNYSLXO8N8FXmdBxLJjwZ7feXk4eNnRuqggL5tt5OvRNlonDK
	 BmmcHnBRD2zfpr3eV0FtXgDhb6hExzYQqskQM+Pqc2efvKMSCyE5RZ8/q1ivpmGD5e
	 54pr+wUkSJmulgQfOuBhjOniIRISgbTL4NskICtdla3IWp/ZGz7qm3zeIJ1MHBuM9C
	 YEzeXtVyI6bkwXIeXrTh7eGAkw+j5dFzVDYgqID/J9TbVzzgXxDhMEEhgdEaRfruA2
	 eX1IBv8duQYkk2LgpPZtrZnZpwkI2jO33k6Cz0jROkok3ip3S8Tvty+Lbi24Q2EdAL
	 R5lPOicf5vIJw==
Date: Tue, 26 May 2026 19:15:02 +0200
Message-ID: <20260526171224.124442963@kernel.org>
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
 Richard Cochran <richardcochran@gmail.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>,
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
Subject: [patch 19/24] ptp: Use system_device_crosststamp::sys_systime
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36923-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,gmail.com,enneenne.com,linux.dev,lists.linux.dev,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD5625DAABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

.. to prepare for cross timestamps with variable clock IDs.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
---
 drivers/ptp/ptp_chardev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -333,7 +333,7 @@ static long ptp_sys_offset_precise(struc
 	ts = ktime_to_timespec64(xtstamp.device);
 	precise_offset.device.sec = ts.tv_sec;
 	precise_offset.device.nsec = ts.tv_nsec;
-	ts = ktime_to_timespec64(xtstamp.sys_realtime);
+	ts = ktime_to_timespec64(xtstamp.sys_systime);
 	precise_offset.sys_realtime.sec = ts.tv_sec;
 	precise_offset.sys_realtime.nsec = ts.tv_nsec;
 	ts = ktime_to_timespec64(xtstamp.sys_monoraw);


