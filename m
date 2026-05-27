Return-Path: <linux-wireless+bounces-36993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIkELXezFmokogcAu9opvQ
	(envelope-from <linux-wireless+bounces-36993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:03:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5465E17D5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADA1E3010F0E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C173E51C8;
	Wed, 27 May 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSmOoBi5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B343CA490;
	Wed, 27 May 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872598; cv=none; b=HWONJl9VUp2ngLNvFAxtK/+kuFoNlGxrdA7LTZ2bcvEItr9uk7z0B75WYa6DcUo2DY6p723BZNRHG79K9vQYEJPLWcE58UNdfeln+AJIr94o6yXwc01y7aJWathmSDa8BSpysGbwbemw8wYKgcAFTZNBPUO5rmbTeZt4Bh457aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872598; c=relaxed/simple;
	bh=1QPGxVe2YVjIdUHB6ZQpNIFZJ/tNHjuloIjcC5WL6yk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+h1sOIhVAW0vdBIQcaaaEJBGvUfTfXo7qDMxx7mkDfyfG59r2EBKeHKEszaAcAUB4udYq7cgs1w1WD9b+jt20+eKladFeSvHBVOf3LX4hYzFNTY3o/mmChwh6bD3soCBWhZ/XB7cEOoMgyX6WLv3WQlUc+NAt69qlN8ftd+5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSmOoBi5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BE91F000E9;
	Wed, 27 May 2026 09:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779872597;
	bh=BLbsXnBlvM3iwIqe2tGZckughDYZqFaWG4pE/G8Jl5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZSmOoBi534c+Apdrr5BrPxD+73gSRd0jaT/awagOLp3NQC1vdv1yed9m7118mI8zW
	 N40WhYoaFqbI/0ARxsfyAuno7PslZyegv5sBVoHcD7o5jBMUusY/wE0zWeN1U8oKBL
	 T9wf0q2/4OrR1aBDayH8jsf8CwAeR9ozQx8Qoyjs2KEiTpAsUsNuf2w/Hcsv2F91zX
	 T2Eb9ifBaCNZuTncW4sp44fcTY9YzI69o3BAR1tmddC3Z9zSyt26eVFsvo8J61yG/O
	 s9EOf4W8b6kCQ3NL3qqqdCtXUuw4jf8IKfZRiCzelFdXkEf/W2/B8oy3HIPgbSjZST
	 FGh6JaxjC8WQQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wSAAV-00000006bac-1rBt;
	Wed, 27 May 2026 09:03:15 +0000
Date: Wed, 27 May 2026 10:03:14 +0100
Message-ID: <86pl2husvh.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	thomas.weissschuh@linutronix.de,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
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
Subject: Re: [patch 06/24] KVM: arm64: Use ktime_get_snapshot_id() to snapshot CLOCK_REALTIME
In-Reply-To: <20260526171223.144327185@kernel.org>
References: <20260526165826.392227559@kernel.org>
	<20260526171223.144327185@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, mlichvar@redhat.com, jstultz@google.com, sboyd@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, thomas.weissschuh@linutronix.de, akiyano@amazon.com, oupton@kernel.org, kvmarm@lists.linux.dev, giometti@enneenne.com, vdonnefort@google.com, oliver.upton@linux.dev, richardcochran@gmail.com, netdev@vger.kernel.org, tiwai@suse.com, miriam.rachel.korenblit@intel.com, johannes.berg@intel.com, jacob.e.keller@intel.com, anthony.l.nguyen@intel.com, saeedm@nvidia.com, peter.hilber@oss.qualcomm.com, mst@redhat.com, virtualization@lists.linux.dev, linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,lists.linux.dev,enneenne.com,linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-36993-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Rspamd-Queue-Id: BB5465E17D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 18:13:58 +0100,
Thomas Gleixner <tglx@kernel.org> wrote:
> 
> ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
> request a particular CLOCK ID to be captured along with the clocksource
> counter.
> 
> Convert the usage in kvm_get_ptp_time() over and use the new
> system_time_snapshot::sys field, which holds the system timestamp selected
> by the CLOCK ID argument.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oupton@kernel.org>
> Cc: kvmarm@lists.linux.dev
> ---
>  arch/arm64/kvm/hypercalls.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

