Return-Path: <linux-wireless+bounces-37043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBWuJv+EF2rJHggAu9opvQ
	(envelope-from <linux-wireless+bounces-37043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 01:57:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 303435EB17A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 01:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D638301232A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 23:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35193B47D3;
	Wed, 27 May 2026 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn+baHMK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A441EEA3C;
	Wed, 27 May 2026 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926184; cv=none; b=kTMQT9aSDr9ebEk8em4okD/x/XaABRloNqpiW3HQRK5Jb7A5s0gL4WBondwPnsmdM2RlvBiIBtLIzTNzNMpCkP6XWna4x4XS1em2E0gn+j7fFz2+w+24xUOpYEeGgzn+xY98q16tI4qt0NdSq5Zx4MUBRJ0PJB/ms/OjFhCJis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926184; c=relaxed/simple;
	bh=sPSGRnZwEDtCNxNuR/Ew8u6W8IXBxXVISGkllm9YKSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkO8A5f5V8BX26FbGYF4fA9p4RJvKXIICFR55Yh36VWfTodN4lkDfGk72fnQ13ZY8Ufd+llNkyUyCySAD2vKEXLY2+J5O7nhzuVyBTsiWwil6BZOmFLsj5yCBGGFBOh0vSKs0UeHf98F5JI10ZqEaVYAQY01CV8UFAV5xUfsqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn+baHMK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA271F000E9;
	Wed, 27 May 2026 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779926183;
	bh=6uiNi3282/xysyZQ5mrfKqAcPmlYIkJ9X4mVBnTuqS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nn+baHMKiXuFlXO5oBAM1kfeHAcuTp1w6q9Ft/MeDbyWe41yYDtxE9TFRb44McdP2
	 8Fj4O9wfPdeF1CY0QNb5gZZWM/cdIfyYZVsarST9wmGLGz+//lps5eOpw7NeOA5oSd
	 onYpqDDH41keyDe/cpzsycjLKmRHvJedgUjx0MkYAazjZeZxUG6k7L76M/45ur5ySM
	 jheN8Do+8GC8oZBLMKjHCaUDhB+ljc/AW5Q38dKPzj3sEI6Uu1S0oAI/7kbBtwEITs
	 5qIkhxyuvFuqcRLfSHDSaoXGRxvFu6Xy8cYSpjn/q5Hpc3JPYgXa084u8JaVEju5jD
	 BS9S/X6o5n59Q==
Date: Wed, 27 May 2026 16:56:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
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
Message-ID: <20260527165621.0ddad586@kernel.org>
In-Reply-To: <20260526171224.499777655@kernel.org>
References: <20260526165826.392227559@kernel.org>
	<20260526171224.499777655@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-37043-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 303435EB17A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 19:15:27 +0200 Thomas Gleixner wrote:
> -	if (sts && bp->ts_window_adjust) {
> -		s64 ns = timespec64_to_ns(&sts->post_ts);
> -
> -		sts->post_ts = ns_to_timespec64(ns - bp->ts_window_adjust);
> -	}
> +	if (sts && bp->ts_window_adjust)
> +		sts->post_ts.sys -= bp->ts_window_adjust;

FWIW build says:

drivers/ptp/ptp_ocp.c:1495:8: error: no member named 'post_ts' in 'struct ptp_system_timestamp'
 1495 |                 sts->post_ts.sys -= bp->ts_window_adjust;
      |                 ~~~  ^

