Return-Path: <linux-wireless+bounces-36978-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH+PMpuWFmq1ngcAu9opvQ
	(envelope-from <linux-wireless+bounces-36978-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:00:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C15E01E8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABFC7300608F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500563ACF0C;
	Wed, 27 May 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtTRhgk5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRsaYlSw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848F2F7EFE;
	Wed, 27 May 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865238; cv=none; b=bPjoT2ZAH8B+8by0gIzeuwSfLfbTz67daBZa3DKfPCuo14zPRvqvutEVJdn0jISGpwpL+U2jJC8bnI9cTbciQvComVRWhWOTBY0n0aw4OkUfPKXpUMia1XjWnMcg/u2h8veOjfl1jRoREVUkQSnoaK7NOSRDeD0ZyR3eZmykC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865238; c=relaxed/simple;
	bh=LkKQ1R1pSHEuSNkJ1K5dmZeu/EWAZCgEjUT27ipKv3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzZPIBsQ9Muaf3/QeAU7v4NQGrREjVgrewzCr+Mfq3p1vSKUoEoopCWEarPn87V+k4Qfbgl7c+b7p88KKJg7HtkcuNbeYAQAPoFuq1MvdJTRNtnrkZHu1+F2w66oYOn6RQIMzMG//PXcQPyjlf2cgCucfLq3ee35jzLlVe6Ufis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtTRhgk5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRsaYlSw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 May 2026 09:00:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779865235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tLoZcgtTuIZz+YdIxADNM8s0hp7Ht/3EdGpfsAxrDw=;
	b=MtTRhgk57c8WaMvDDhA1y0Uhi4cQXKiz29TPbKTK5sJUUJI6AGD7TM4C4T45LDWOaM9p34
	/5EiodNqg+6XX6prMzdxebPmNXYAr7loDGmKOiFYo0uOcmgC7HFBF5kRzALV+8YmHPt9uq
	S1K981qGMPaXStkjE7YjX874urF+UqiwJeX9sVHE5qoiGIUf9GKWFDLuRHUlX4e/+4TpcX
	GKTjMjgw/YnSrGRrR5BOKJ2FjlzKD0pMMa2kThZvqFl9VXI/iCFXYvo75Mv/R8yD0b6EvK
	akreXt52/3jKAbGMH1hkds6E/7PsAtnyG4Rax0aHKaoZpFHQ+AtUdyQsIzQVkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779865235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tLoZcgtTuIZz+YdIxADNM8s0hp7Ht/3EdGpfsAxrDw=;
	b=JRsaYlSw6fnVEA4dHF/70NGvFUq9AsvQn3mULmlVv2c2mglLvmcgO2xcuX3IfA+UdPs7sk
	ukT4KbG3c17s+PDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Arthur Kiyanovski <akiyano@amazon.com>, Rodolfo Giometti <giometti@enneenne.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Peter Hilber <peter.hilber@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, linux-wireless@vger.kernel.org, 
	linux-sound@vger.kernel.org
Subject: Re: [patch 03/24] pps: generators: Use ktime_get_real_ts64() instead
 of ktime_get_snapshot()
Message-ID: <20260527085912-f2437598-6f16-4e09-a0b9-fbc759aad889@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171222.920736414@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526171222.920736414@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36978-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: C28C15E01E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:13:43PM +0200, Thomas Gleixner wrote:
> There is no reason to use the more complex ktime_get_snapshot() for
> retrieving CLOCK_REALTIME.
> 
> Just use ktime_get_real_ts64(), which avoids the extra timespec64
> conversion as a bonus.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Rodolfo Giometti <giometti@enneenne.com>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

These preparation commits could also go to the front of the series.

