Return-Path: <linux-wireless+bounces-37016-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMksCWUdF2rw5AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37016-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 18:35:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7845E7D75
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 18:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2241D302C0F1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C91438FF2;
	Wed, 27 May 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g89DOoBA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26773D79E3
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899354; cv=none; b=eu1LuCbFV2FNVEQo0KBzLyNDbymZSZHC/yYAP/glW6iPYJJviaZdRIZNB4MVuYu7oVwbTT8lp1RqZlKp5zMi0UQslab2QFNbOWPeLv/EoDd3SvcqFMIo/R3rshEgfa968l5Jm61766iWZfjzUSEa4+iMUgg4FXiSSzYN3ZnbO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899354; c=relaxed/simple;
	bh=MARgWSB2JRyHiWTRwBhBMqTryJPPS2jchIS4w1LrmWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoZndDlgTCj0/ydjq6vX7P1rDkpjkN/DvTgd7JNGbqwE+uItgb9lVj42q50SOWXcaWxUxpp80H19zhzWwFQukk0QhuIsYaAq1cHGVIyGFuqV2uzMR28ZQn3ZDZnp8RalYR5C9KxdhH9h+036Dkvqh4RiChiJaBhtIFFwmixVtm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g89DOoBA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso56726145e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779899344; x=1780504144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp8EUEG6k+uQx75sbagyQs35jMaojHEjO5L3ntgLVNA=;
        b=g89DOoBAuI83xqPWszuqhCTddZx0ONETKVoZcKFdcASpTkVpc7A18DmvjXbkukKjp3
         jCzHh6oa0O2O60ft1uy4iEi3QrFypdTqA3bXE63RDDuojo2QkvpTLC4QvG0P5OSzsocv
         fEU4i5WODBfJsI4QSgvSCYAGpHQwvBou62wMJHBx4Ogc0QB+VeM8xYq14VPYB6aroWft
         GIJ3NGD/4re4dH4cAL6MU74xJCB/GqsPxFIqXwUz3hgODjcwYrWdL+rCF/7XwdcTaNc6
         qcAMLG3NeHvmXmJQ2AkRTxH83svDmpqoDBjLEPvCKlLfJwHNtyKbeO75s5nLFLuBMXVh
         MUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899344; x=1780504144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp8EUEG6k+uQx75sbagyQs35jMaojHEjO5L3ntgLVNA=;
        b=iFwOArOkiFTtxkz17X3HzNCZdqEHPWBooez/f9FJLs2xs9HfwgQIP8HsD5J2I9lzDD
         LenqVGOQ/row4WmSrnBPjevYgriAsDEap5YEhkXQR8Tdtg1wEQ4J06EYXNKrU36q6NVP
         QYsQT8ZDe9TySzJQ8PScM2X28eSCJKpmScG/1glTv2wtuSXkFUSd9AxJME3G9xOWjXow
         eJyM8bdO80FCyVTAqfZbq54WySynTzmMBOnIVFw6Tw5WZa0iMQVmt3q0NgGxGWPJGMNu
         810pQBCpGhv+1v6f/UZzLc+5PyyupYTuCk3TBFY9olhhvKRQelpmQY2qymiZVnIA6dPd
         a6cA==
X-Forwarded-Encrypted: i=1; AFNElJ/J6bXKT04PezeM3QllpqozAHzX6OOrXO7sethcP7vLu+VJbwo+J4L+bGZaNirAH6zaO7sxs+J0UfeYugGAEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvubxo6QJur+VC6NR4/gIG2KxksZfD0B4njiGkIeIoC9pKmbb3
	/W/NoreS17dzic3szDIE8xy9Gow+jDvaR1TsgzmGURRxhOuDkg6Vnd5QDri5JsC2Wg==
X-Gm-Gg: Acq92OF99/l17qN20pIf63PtFHev36R45URwfZ/pz8MEwk9aoz53oEmDOpiJ5IniPHV
	eBh8rlTP9qee/Dg3ays28iq8AaOXN8+0s2+O7q5DNW77k0oiDXON9iv1Ik9yFBBQZcBg5e+USCO
	aoH/Q3c2KjohcLx4CxtsC+yZma3EYcy+vnQoLsGQDa6FXwYwZlVzDDZALDJWjPwQcBVWJxQwR8l
	rgdjAXmR6E6KIX7QVU6NDnEewOdQqI0tLJRCGD3auYgpDdsgOhK5oE+dT3XyjjLDAFx+x/K4o1b
	3zh5rDwpHsIQ4jRAByoxboaF0nCIbVsxFYmM0TH70/t9gYKp2YqozmPQ66zOIVef7i3nsWgT4iC
	CgyzsNjo8ZYtYTJ5SkBrVaomj94adCrXh90PtBq2iq99rgZVo7TJH0cHIyF41rUJ6M/x2mEkl4l
	A7C+GJH+Bz3SiI2jR9jtrTBA/TJa3+q4ZND4ly54cvn6x3zeCPVOwcv4HMa6S/AIlMyUnXDUEbf
	qkXOQ==
X-Received: by 2002:a05:600c:45ce:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-4905cd8d33emr244688485e9.15.1779899343733;
        Wed, 27 May 2026 09:29:03 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a160sm466125765e9.9.2026.05.27.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:29:03 -0700 (PDT)
Date: Wed, 27 May 2026 17:28:59 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	thomas.weissschuh@linutronix.de,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Oliver Upton <oupton@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [patch 05/24] KVM: arm64: Use ktime_get_snapshot_id() to
 retrieve CLOCK_BOOTTIME
Message-ID: <ahcby8senHsmpOBm@google.com>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.070087856@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526171223.070087856@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,linux.dev,lists.linux.dev,enneenne.com,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-37016-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F7845E7D75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:13:53PM +0200, Thomas Gleixner wrote:
> ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
> request a particular CLOCK ID to be captured along with the clocksource
> counter.
> 
> Convert the tracing mechanism over and use the new
> system_time_snapshot::sys field, which holds the system timestamp selected
> by the CLOCK ID argument.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Vincent Donnefort <vdonnefort@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: kvmarm@lists.linux.dev

Acked-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp_trace.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/arm64/kvm/hyp_trace.c
> +++ b/arch/arm64/kvm/hyp_trace.c
> @@ -51,8 +51,8 @@ static void __hyp_clock_work(struct work
>  
>  	hyp_clock = container_of(dwork, struct hyp_trace_clock, work);
>  
> -	ktime_get_snapshot(&snap);
> -	boot = ktime_to_ns(snap.boot);
> +	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
> +	boot = ktime_to_ns(snap.sys);
>  
>  	delta_boot = boot - hyp_clock->boot;
>  	delta_cycles = snap.cycles - hyp_clock->cycles;
> @@ -118,9 +118,9 @@ static void hyp_trace_clock_enable(struc
>  		hyp_clock->running = false;
>  	}
>  
> -	ktime_get_snapshot(&snap);
> +	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
>  
> -	hyp_clock->boot = ktime_to_ns(snap.boot);
> +	hyp_clock->boot = ktime_to_ns(snap.sys);
>  	hyp_clock->cycles = snap.cycles;
>  	hyp_clock->mult = 0;
>  
> 

