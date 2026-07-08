Return-Path: <linux-wireless+bounces-38782-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3u5AJm0RTmoDCgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38782-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 10:59:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5326F72366A
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 10:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fffacYUf;
	dkim=pass header.d=redhat.com header.s=google header.b=iGDKGnqC;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38782-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38782-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB9D93025C79
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EDA402B96;
	Wed,  8 Jul 2026 08:56:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B93AB29D
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 08:55:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500960; cv=none; b=suGxO/+ltY18YsvpjuM9lYAOD4rGcV7bm7y9KanzWehOJY+vjuJUqW2peQIUtYI8dQllRYdrCYrbvzF+l8SkoVVRDi6i9OMTLz/S0xIT+Hj1bC5ipmnVVZw6KMub2N0JMSEvN3X6tOXxRTE/Sdcfo+SOfxiZ4hq8mwv6rAXolqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500960; c=relaxed/simple;
	bh=hvxo0k1MrjhNygA/KP1UD+xDX6qJaRVTlMh+2Jzokh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfRju9wHlT6LT4CAuJh+0gg8+htMeWk63dX0+y1Ht9UXQ+bNg+CXnGExCKYdG4AocwjLvsOecETgOGPN5DBzOt5sgTLDMrFiLQYDuMfdRoeH+2sycxYyCn2gR68tNfGaKmtPTTBPZl/u4kBy1T1K1GLjVpfrN07TBdMyPNDCYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fffacYUf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGDKGnqC; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783500957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbP35j/x3DTm7o/Yn1OIdMEqiWJ44P60wi1DTKxILpo=;
	b=fffacYUfhgTW5h6bxzOp1Y+4cSAPeLDB+cAH9DME/CyALa1kBnBSOzCY1YX4+lkk5082/T
	EAZ+3Vp1PttNnunkPcEJDQEYb0rCQALR5SX5ff7N9PM5tdAzq7tZ7Ktg+HVVRtxBQeEuCM
	/qPpH6j0cI48/Y7AB3R7aLWa/9vSsJc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-_5eG4byOOPC2r9NOA4Z1qw-1; Wed, 08 Jul 2026 04:55:56 -0400
X-MC-Unique: _5eG4byOOPC2r9NOA4Z1qw-1
X-Mimecast-MFC-AGG-ID: _5eG4byOOPC2r9NOA4Z1qw_1783500955
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493c588b6f2so5844055e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783500955; x=1784105755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbP35j/x3DTm7o/Yn1OIdMEqiWJ44P60wi1DTKxILpo=;
        b=iGDKGnqC8no4D4pk81ZehNPW1n6HuwtsNx6SAQToBt48vqGHGHjUw1FIq3Z/ZOgN2L
         42EB3wAV7MuiI/jJvLqCOfGKnpf/L29J9v0zy4txREZdhLocd2tHFHqg9lJrOrEQbJcc
         kZVc8+UZKb8d1vCt2nZmOEwoCtBW9e/kxfQCzOYe6vdg/aF2BbQNS+WG/7ozkiIR2F5n
         uCZ4k4suvbrZNb5WuFnQ0YOnkUPm9KlUGNtyzcuRojjX3roINk435DI8CRQpv04Vjpje
         KdUQx1Ad6SSMRUBrCfmqqTKd/oiABRUcbhE29Hd0UHL0umlWlnXg7AeBYqlc2bn8UMh3
         EMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500955; x=1784105755;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbP35j/x3DTm7o/Yn1OIdMEqiWJ44P60wi1DTKxILpo=;
        b=mFXhvQfdr/n1UHMKnj8wfZ451KknPzaTkJfuWjJTSlydcQOaUOCVfn3RcST8uIAnoe
         twb1LN5uDVi0l9NOyDsYju3a9RuwLmoRDFTKBuwWDSoO9lXP/jZBfacy6YrH222k1Zx3
         bT1YWk4WgA4ukwce4ztSurh5vzCbPRZM8qoeM+ZWb0cBDZVTK20MwHdJBB2FEu+L5u+a
         lWk8EffMFP9tqXzMUeReg1Plva773D2sBIq4JBkFaas89/S84KaddOVr1dtPf3b6sdtY
         P9PWo17gFWZU3JP5opjMDOev07iziBDaGpZ+Wr8gcKPsu+O54b0A7T5dqdn2ZqiXRfdY
         2zgg==
X-Forwarded-Encrypted: i=1; AHgh+RofKoZy+1clJY7cFKk1S7H6O3VwwChTmbPhP4DZvW9DEgDwHai4uqoMsG7TAXu6m22LJUzt54Sh2n/o7F/cBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjBWuE3cWiKzVtuvHi75S0ENqDLI73mWi6orX4J87fnMJgaw9
	8Sa5lgfFXMCj15gyp2GQaIGeVGS1S2ITQx7g4n9RP9C9lPREMS1QdSJzHCM3macC3djyjlp9Lbo
	sg2aRjHIfumSxqMDM8mSDA3fsuXRBvAoXFZaxGyrxQE3d954pLFQuuDBIWBYhjuqnrk8z
X-Gm-Gg: AfdE7clO7w+gFu8/i9K7AqRvNZFkaIOSnTi+z4GGBqYSsrN2CVAJipSj/fggAXt8lzj
	zaXegvK0HaHJ4S4y0Fg7CsQL+STxhc+4GLEC7SScegjKvj3R9XcrfMkQa3rONyG0nptpDcaFx7m
	afkTVGyYom37qpbvSVD1qOKJZIbkI70LJnHtxceouZFO5OgPfTjOxUtrktav1vjKU1XSzqtNIen
	f9OeKn1ZnVVU+G0fSDIPx1tEVyA7ex/FhfuO3XZf7YHRWC0OPJHXWtkL/ykMWNL04QhRYTIZbwv
	wnxtdAnm1XpuRS6b15r8jInAY8F19rnm7yY18kMQZ6sYjHY/fWOzDubsjPxd56RGB/0K8Pk+nZe
	+b7aHULYn/Ob9d97dbYRTLG2RBvm9MbVSSxzxsgNurM/aaHy4wvviVB40LVG+WbgrNTPW0kIGV0
	6UyTilJxl+C/J9
X-Received: by 2002:a05:600c:548d:b0:493:b8d9:f28b with SMTP id 5b1f17b1804b1-493e68c7f63mr16435275e9.23.1783500954931;
        Wed, 08 Jul 2026 01:55:54 -0700 (PDT)
X-Received: by 2002:a05:600c:548d:b0:493:b8d9:f28b with SMTP id 5b1f17b1804b1-493e68c7f63mr16435005e9.23.1783500954522;
        Wed, 08 Jul 2026 01:55:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a6240fsm34114935e9.2.2026.07.08.01.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 01:55:54 -0700 (PDT)
Message-ID: <3832c190-b5b7-49a2-902d-7f75598b0789@redhat.com>
Date: Wed, 8 Jul 2026 10:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drivers/net: replace __get_free_pages() with
 kmalloc()
To: Johannes Berg <johannes.berg@intel.com>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, Jakub Kicinski <kuba@kernel.org>,
 b43-dev@lists.infradead.org, libertas-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
References: <20260701-b4-drivers-wireless-v1-0-60264cdf2efe@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701-b4-drivers-wireless-v1-0-60264cdf2efe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38782-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:kuba@kernel.org,m:b43-dev@lists.infradead.org,m:libertas-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:rppt@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5326F72366A

On 7/1/26 3:59 PM, Mike Rapoport (Microsoft) wrote:
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> My initial intention a few month ago was to remove ugly casts [1], but then
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
> 
> Largely, anything that doesn't need struct page (or a memdesc in the
> future) should just use kmalloc() or kvmalloc() to allocate memory.
> kmalloc() guarantees alignment, physical contiguity and working
> virt_to_phys() and beside nicer API that returns void * on alloc and
> doesn't require to know the allocation size on free, kmalloc() provides
> better debugging capabilities than page allocator.
> 
> Another thing is that touching these allocation sites gives the reviewers
> opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> another size is appropriate.
> 
> For larger allocations that don't need physically contiguous memory
> kvmalloc() can be a better option that __get_free_pages() because under
> memory pressure it's is easier to allocate several order-0 pages than a
> physically contiguous chunk with the same number of pages.
> 
> And last, but not least, removing needless calls to page allocator should
> help with memdesc (aka project folio) conversion. There will be way less
> places to audit to see if the user was actually using struct page.
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/drivers-net-wireless
> 
> [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/
> 
> ---

@Johannes: just an head-up, I assume this series will go via your tree
(despite the slightly misleading subj)

/P


