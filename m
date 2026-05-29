Return-Path: <linux-wireless+bounces-37151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGPRMXD1GWp/0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:22:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A304608754
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D6F830D2D0A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76343636E;
	Fri, 29 May 2026 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt/68hw5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBEE3AEF23;
	Fri, 29 May 2026 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084885; cv=none; b=YouBvVMbI8mHYSkF3fIOawgdxL6nUXFtlnqxsszGpSfKdoxXTTQgJpi8CQZU7WRev/iy5hNHPRk8LOUaQn2LoGx94oyGrsSzoC2nfm0M1DoSrEcnRAQkEeomUFZG3/zfscjIEWaDXlr/DsAlV5vmiYeqvblcRnDlXmxNgP7xlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084885; c=relaxed/simple;
	bh=2T5s2PrZIU2o4Dm+5AlC+bvg7KAyKf6ZQhZYdGRS71g=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oMoZB+h8ZIHcKZg4zU0/nikyO0fu2BfP5lNhpLb+l7LERBotB+DWzdZXXCfgfYMIAkh4MXKpuaRxs+2mDD7xlPLdZMY0j8gQO3YE1HQAYpEPhsrSXt5OuEz/du95hdRvW+FccCtmoLcBvFThW4rVOudqIRnuNrGsjoO91dEGmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt/68hw5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14791F00893;
	Fri, 29 May 2026 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084883;
	bh=d8ecuHgn3EbMBTOWdGcfN7Rpmd+nK58rNN4GVOEm3A4=;
	h=Date:From:To:Cc:Subject:References;
	b=Bt/68hw5SylVR4cQs+fhfp1c9Axf+EESnpGCcBzgg+/1sIu4X+mDmaAFcXjpqkUqt
	 Q42CfZ/POXdHvk+o8Jtv/I/N4jiii84+6J+r18Quc/J1BNeLwJQSWV6PFCRrgHdeJC
	 oPN1ZXwNpomrEYLZgT7g/KLCDZhJmrd7IIDE3gipNMFXn4RDeFCeJbmt1r9en3j2FC
	 B8aaU0aHvp4LEjYPq1PD5xgeVZWBvxPYnambbtVLK00TNK8twaCfQNGNhbzGRJc114
	 oUsEJf8GVOWtDnU9UP1iM8oOP2JOxloF3ACfu7jG5tmWVfeUcYBlBblqSUxdU5r1tQ
	 sPgA6cDimISoQ==
Date: Fri, 29 May 2026 22:01:21 +0200
Message-ID: <20260529195558.097464513@kernel.org>
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
Subject: [patch V2 23/25] timekeeping: Add support for AUX clock cross
 timestamping
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37151-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.co.uk:email]
X-Rspamd-Queue-Id: 2A304608754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

Now that all prerequisites are in place add the final support for AUX
clocks in get_device_system_crosststamp(), which enables the PTP layer to
support hardware cross timestamps with a new IOTCL.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 kernel/time/timekeeping.c |    6 ++++++
 1 file changed, 6 insertions(+)
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1517,6 +1517,12 @@ int get_device_system_crosststamp(int (*
 		tkd = &tk_core;
 		offs = &tk_core.timekeeper.offs_real;
 		break;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		tkd = aux_get_tk_data(xtstamp->clock_id);
+		if (!tkd)
+			return -ENODEV;
+		offs = &tkd->timekeeper.offs_aux;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -ENODEV;


