Return-Path: <linux-wireless+bounces-37066-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEJ2CKFLGGqjiggAu9opvQ
	(envelope-from <linux-wireless+bounces-37066-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 16:05:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B15F3570
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 16:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D43130205C6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23216275B1A;
	Thu, 28 May 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqyPs9Tn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30023F417;
	Thu, 28 May 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976520; cv=none; b=oxBSZYbUwUFwXxH+xbjOoaxcS9iWXicfGwyIiGtfyw9umi1TnXhNGlCGN1p/5PMKfci6eOi/Vv103GogI3mxICWVp1HEhMXg/Htnatc7NiSdBU1g5mi5eQXDp/8mX3tEnBN2DOw54jqVdciUNNyKhOi5pRMqyiY3knRATtfAAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976520; c=relaxed/simple;
	bh=JHlB1VRiFdijv0FLI9b4i0396zAo+2ZyHpGGII6D6+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pMVFVNXWD+ohy/40scxQSBXkZ78Sa7f+jiDwE95F/hnCN+GN66eVFO3Iznl13qWZdSnxf5odnkV4j1+uvgEaqBj9LU6+S/moe5arE7OAthN3DzRx1sSkTAejpOqyhO/RlE628rhn4g8PP0WWxNUvWFEGT8Z72py1oIVr7rGIC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqyPs9Tn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157001F000E9;
	Thu, 28 May 2026 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779976518;
	bh=TWrEufAZ8DUslPgMoW8nH/Kc1/FwICNwsgwROWhzNko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kqyPs9TnwtA5QQRhEEFdwnM48mCMueLnPbgjtvSlZXef6hvNOujW10shIsgthUfUt
	 +t5LEfYEt0p+4Kvz+Js1I8qPG2Z6aVyCupMD1HKaIjtsoNejXZWqQU2p1Od0p7V9uR
	 52aqjzu77SDU4rMz6y2QOWkk5hlfPLckwWHCkYy4CNDAUZNe8zCSfAJIxkA2QB+wEp
	 RHOoUPJhGv8Y8bncebkPsAnvx436eale+F5k+GHDU+uCx4X06ja8udX6Zg9HXr6LZx
	 LiD4YRUIlOUMXsVi8P+/R65PhV073jbL0jEgTeWrADmcErO4l7bpZ2JPDt3MB2C9Uy
	 dAv/dkt0/TfiQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Miroslav Lichvar <mlichvar@redhat.com>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 thomas.weissschuh@linutronix.de, Arthur Kiyanovski <akiyano@amazon.com>,
 Rodolfo Giometti <giometti@enneenne.com>, Vincent Donnefort
 <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Oliver Upton
 <oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Johannes Berg
 <johannes.berg@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [patch 24/24] ptp: Switch to ktime_get_snapshot_id() for
 pre/post timestamps
In-Reply-To: <20260527165621.0ddad586@kernel.org>
References: <20260526165826.392227559@kernel.org>
 <20260526171224.499777655@kernel.org> <20260527165621.0ddad586@kernel.org>
Date: Thu, 28 May 2026 15:55:15 +0200
Message-ID: <87eciviqpo.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37066-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C11B15F3570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27 2026 at 16:56, Jakub Kicinski wrote:
> On Tue, 26 May 2026 19:15:27 +0200 Thomas Gleixner wrote:
>> -	if (sts && bp->ts_window_adjust) {
>> -		s64 ns = timespec64_to_ns(&sts->post_ts);
>> -
>> -		sts->post_ts = ns_to_timespec64(ns - bp->ts_window_adjust);
>> -	}
>> +	if (sts && bp->ts_window_adjust)
>> +		sts->post_ts.sys -= bp->ts_window_adjust;
>
> FWIW build says:
>
> drivers/ptp/ptp_ocp.c:1495:8: error: no member named 'post_ts' in 'struct ptp_system_timestamp'
>  1495 |                 sts->post_ts.sys -= bp->ts_window_adjust;
>       |                 ~~~  ^

Noticed too and fixed locally already.

