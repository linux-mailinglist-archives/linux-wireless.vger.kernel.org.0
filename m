Return-Path: <linux-wireless+bounces-38019-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vjsMGAKnOmrkCggAu9opvQ
	(envelope-from <linux-wireless+bounces-38019-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 17:32:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C946B84CC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 17:32:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=gmail.com header.s=20251104 header.b=Q3yeJ9Rb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38019-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38019-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3AB3019836
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154C2BD587;
	Tue, 23 Jun 2026 15:32:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568618DB37
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 15:32:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228735; cv=none; b=Npx3qFYobZaLMP42JmRp91HJ5BHLBELgwqfdPIfMZyWsbmncSJrWfnLQdAtdOTDcjrTFksT7nbTefBvdCb5q4NTotrmDiLvSNXAI1h/IJ/iXOc9hlkUpWdYX48uoYbWw/WNjJYJxDd2QbYLxjLsoI+8ibTWZ7UwtWlMvabBUInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228735; c=relaxed/simple;
	bh=5XQn0m/3gLi9moDpRLDBV/PwAY+GgnG88rPcDckEboU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pruyNGyad5v1CQd+ZYYwYnrQI0jhnqNI2vAOWiPrkv0/UfD7FCwuyxuOC4QjF/J6ht3kzNTshUYGP6Vzw/zGhVdbhADg7mJE0Y4CtbSllFQPQ0Try4NTP2SfZVL74aafs2/4GuMtggtlpu/QN1YZxeReHz/yDYxcszg4/PO1PF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3yeJ9Rb; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49222fb062bso202465e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228732; x=1782833532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+53L7UNPV2jK/LZnIdPZ946XAJTC8u0G7Peoj+okLE=;
        b=Q3yeJ9RbJm2PZ6xtChd7MXOgwwPUYjUwrkAzOAc+j9clXtDbwwdmBYrbvrMTBoxmjE
         1BgYFbxd79WIceuQa8trw1Kaa/RJVTr5YNAnNMHt8ajHGEwX5HcZV9IQiMAi1B/e1ahL
         rnOJ6WqmpU6hghDUOHaSZu1I1FcptM/1OVFB+QJ65Mgy6yU/e4Ivyb+h2Ct5MuggEjuU
         /9UvBh5srLMMLlH/cTXkMlCHX+lPadT+bF33Kyv7FdFihRLjYGHqBufdrPsCeEcj6LmO
         bvzloG0Pc1eY/besf4kME3lp2xlrweq/qyomiibD7j06E38H4HMMr8A8SMaUZGXFTI7S
         9yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228732; x=1782833532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+53L7UNPV2jK/LZnIdPZ946XAJTC8u0G7Peoj+okLE=;
        b=mcBr2Syu4JFPqye7iC4EFPHVtuzOSKLaCHxx57GvjbXFpe8Fwabv8NUx2zBhppCVlq
         FrSmlWTG7AvFApxWuTT0E0d2E/4qzPc5Qoej1HrCKdv+ia21Lb1hSX4OSzh0URxUPe3D
         JthjLxA7gCQNIlGNgN/pdf3vNiGUsrFwaI+xOqam7pNmb7owGCHHugpm4JaY1bsnisdT
         1swDM04Jv7Aay8f01sztEC41pasno73yU6PxNumWshWhGBe8we9XuVpMVeTFitlSLDSc
         kRgU0rWeIOTjWYL6VcMa3NMPQ13lWFqMpOlPb2FRD90nE8n1876n1IDmZn3SHTB5DB99
         aJdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K4TRAQU6Awoq5WyrlpfJ4i+vIabWILFqRH1xXdWUMn0ssScLOI2FsJlHOJkmhOmwScgo9hrZb/89cPkeXIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy2IlS6z7sQCBSS+ml85QdGgvQGNYlloUNVrPCZ3Nry7X9Ucx6
	doj7ILAz/XLNqsWp6Zw5uNcwEB10cPAcCwDDQxfnyWsSJkoC5xZQayEs
X-Gm-Gg: AfdE7clWsJXjqakn+6VErHZPzzNv6jG0Y6M0fJxPZNYYwS+m0Bup8Oho2hRIP6WF1XQ
	/epiGi8bmHAPnls5qC9vdz97fL7Wk/LsB/8J6l+KphN3yApRr07hotauPhIboasiV3wnOPMRkq6
	iTpQf2aDuQ/T7v26+/cdLHnizDCi6u4r7w65be3sl/oiSNmHpzVyaWUDTo4u2c/ktzZkLNSLI8o
	vKd6I5vVXob7Kb8X1m+5M5H8p9NSQImIweekf2ScvYyyh4yn4mTyA5l7xpUtpax2VknXIbv4h8h
	7XD4+mMfNAqSS5pzT0EObDWjQRtv5un2AXi0HYeHrDufv8kicmGfkPKMwa4oJIKvO0U2PfsXIJf
	aUnKI/yt0l04iCysjUByEsyHpgzLCpEO5MbR14e9/M7Af9I5PlKzYAS6anW/dnRkQhWSrTvp1aN
	SWKA2iol5AlsGrMAOwuWsmPcrVgReowsxF5geLnBg8g+qUPGWYag==
X-Received: by 2002:a05:600c:3baa:b0:492:42e1:1b6a with SMTP id 5b1f17b1804b1-49242e11d31mr310507785e9.25.1782228731641;
        Tue, 23 Jun 2026 08:32:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm537984865e9.0.2026.06.23.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:32:11 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:32:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <20260623163203.195416b4@pumpkin>
In-Reply-To: <ajqTpJAMFFV3H5Im@ashevche-desk.local>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
	<20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
	<202606182046.AE5F6A241@keescook>
	<ajTlfuOFHXlA7xdu@ashevche-desk.local>
	<202606192025.CF68F2E@keescook>
	<ajY5hg0f34C-iV3R@ashevche-desk.local>
	<54974e4298efd26a52c9c0e9ada88d57e8695a09.camel@sipsolutions.net>
	<ajqTpJAMFFV3H5Im@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[gmail.com:s=20251104];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38019-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:johannes@sipsolutions.net,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:-];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84C946B84CC

On Tue, 23 Jun 2026 17:09:40 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 22, 2026 at 01:16:29PM +0200, Johannes Berg wrote:
> > On Sat, 2026-06-20 at 09:56 +0300, Andy Shevchenko wrote:  
> > > Johannes, are you okay to take a new version (I assume the wish is to have
> > > the balanced additions)? If so, I will prepare one.  
> > 
> > Sure, I can take the patches, sounds good to me.  
> 
> Will send soon, for the record the *.i file is 61 character less with the patch.
> 
> Was
> 
> size = __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), sizeof(*(request)) + __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})))), __size_add(sizeof(*(request)), __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})), si
 ze_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");}))))));
> - size = __size_add(size, size_mul(sizeof(*request->ssids), n_ssids));
> - size = __size_add(size, size_mul(sizeof(*request->match_sets), n_match_sets));
> - size = __size_add(size, size_mul(sizeof(*request->scan_plans), n_plans));
> - size = __size_add(size, ie_len);
> 
> Now
> 
> size = __size_add(__size_add(__size_add(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), sizeof(*(request)) + __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})))), __size_add(sizeof(*(request)), __builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)(n_channels) * 0l)) : (int *)8))), (n_channels) * sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)
 [0])))), "must be array");})), size_mul(n_channels, sizeof(*(request)->channels) + ((int)sizeof(struct {_Static_assert(!(!(!__builtin_types_compatible_p(typeof(((request)->channels)), typeof(&((request)->channels)[0])))), "must be array");})))))), ie_len), size_mul(sizeof(*request->ssids), n_ssids)), __size_add(size_mul(sizeof(*request->match_sets), n_match_sets), size_mul(sizeof(*request->scan_plans), n_plans)));
> 

Both those seem to contain multiple expansions of is_constexpr().
I'd be surprised if __builtin_constant_p() wasn't good enough.

I also wonder what kind of mess the object code looks like.

I'd also worry whether the saturating maths in any way performs the correct check.
I suspect the (non-saturated) value gets used for a kmalloc(),
but that has much smaller valid (and sane) limits than can come out of the above.

	David


