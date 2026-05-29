Return-Path: <linux-wireless+bounces-37144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGIXMcbyGWp/0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:10:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C838608493
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B8231A455F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1843E4B0;
	Fri, 29 May 2026 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYsyJQ0X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F343DA2E;
	Fri, 29 May 2026 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084856; cv=none; b=irEQDNr2OPetqN05xFqQUgt0Ug0JDg2LJOL0SauyWAGAQYca6/wDtmdnY1zYWklN+AOs1sc8B3567a6KFkHDnzx62aKT7lcRBQFoGaiYVOHDdO1iC7ftgNRuWt3Qfdd3ploSYbn/U58Fyd01T1ETn8Df6wIAf3uchK6ZOWqnbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084856; c=relaxed/simple;
	bh=jfnjk0DrjAfvGqJQtbk2xk50gds9efqlBLmxRtifTf0=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IjH/EYAcxDWOyVJKuthdhYCj1c+R+KhmrIwBrNWqXAN/rthUx2kmn1Yzju5xHoAW/RLiWjdILgD9LRJaxJliV3CVtGEaMyYvy4/TC0O/jq43TcHfsX5JUGF/ib9utFJr5qcem38XLvX78arL60HuGHs5VTwUKVkS7pkg6wFgcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYsyJQ0X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBEB1F00893;
	Fri, 29 May 2026 20:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084855;
	bh=4Dl2AVIauMqhvyfPh4Lxz1+YVPAwec+mGhNTlZwpJas=;
	h=Date:From:To:Cc:Subject:References;
	b=jYsyJQ0X3zcmMMvTpDZ4XN353dTHqIvBzb8N5oTCJVeIITP/stpRtWKlT9l8UPEtO
	 WHeKC7dFhCm8eNg/rosugMW6Guze3ONqe6/6MKMiSJvEhclZs9GY1rughm1xaBqoAd
	 BWfiC0V5g9be8EUpur/sHK5uSy1BXm+OFH6kkaUqxBRyW+BUExitWyDOmqaWIqBaUy
	 gFYGtZ70XhtJh1cMZbdmARtKplhM32EjGnWq2Z4sesBWCp5DgxXlwDMZakn08a05aY
	 QSO+ebcNBCpv2/wlHA/+uy5WmI4og4N4ckVe7jKktfIq2JpiyXRGdbScQtyfn3/FE7
	 mRm2oZdz0PZeg==
Date: Fri, 29 May 2026 22:00:52 +0200
Message-ID: <20260529195557.744271454@kernel.org>
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
Subject: [patch V2 16/25] virtio_rtc: Use provided clock ID for history
 snapshot
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37144-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C838608493
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
 drivers/virtio/virtio_rtc_ptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
--- a/drivers/virtio/virtio_rtc_ptp.c
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -139,7 +139,7 @@ static int viortc_ptp_getcrosststamp(str
 	if (ret)
 		return ret;
 
-	ktime_get_snapshot(&history_begin);
+	ktime_get_snapshot_id(xtstamp->clock_id, &history_begin);
 	if (history_begin.cs_id != cs_id)
 		return -EOPNOTSUPP;
 


