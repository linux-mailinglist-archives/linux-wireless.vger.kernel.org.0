Return-Path: <linux-wireless+bounces-37935-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4+fmFkA4NmqN8gYAu9opvQ
	(envelope-from <linux-wireless+bounces-37935-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 08:50:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C966A870E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 08:50:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=CYXWYLoM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37935-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37935-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DB893031AD8
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79A373C1D;
	Sat, 20 Jun 2026 06:50:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78582361DA6
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jun 2026 06:50:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938208; cv=none; b=aaYW2CwENux6NkbJc9vWnZgdtXn/mzWhiiVniZVk4xUvpPnoHLi8YJFKUJpsJtGmLNVK/i1MxPrEBykJ2TeBhhp2zhz83Z2ZQ1rNHkysyrsMJFkiOjDkuYMFEYEsF2INlzxwGZorWoY8NjMiFUmMbQdYKXgHhc8poEoNYUBBAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938208; c=relaxed/simple;
	bh=dK82PrzfK0MmQgb2q/Ybhbo6Paemf3yKDTwrIdzHd2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGRhzoTp6/cE/0nyJm75wGRb27Dm15NAMPbguN3+8oB2IgQO1pR3fMzKC08GroBFDVXi62aPl0tscc/1gVXpOURjzhd8XWeBhApQKq/vfc+41OZdaYhdl0WDNVQmNveB7HIfJ1EO7oWqy4PPAv91HrdKAvxsqs1HJFewi3LNaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=CYXWYLoM; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842307473b5so1916453b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781938207; x=1782543007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWJ6ykcaVVJ8FSV3Vgps/e2+SKPjlPS1FEpT1cmZ/tA=;
        b=CYXWYLoMsIT56/AXoEdufhmzUorm5fQ/VzIXXJvw/9/WQ4OlmFFVC2hCc1IH+uj31F
         Zj+2ElYzgTSVbKKwV1zZFiAR7AHej29JvqpYjRu/885MowQRNrPUqRBoarMWmFmIuotY
         vdybLQt4Vk5UA5ltHycfoeITd/VH4qGFFp+CPWM0CQFeIvkq5R26KXZSxLZBqD1e59vw
         kpFIygOHqGVE1PBVliFS22VPrFaU//gwSmBPtjJwahVU56JM13smUL7p58yNvYYlVKjo
         p1fgwqpqZswLG7VizwjjIabzUoMpnbSelPnx3JomSfFDgNDmD684GXZIljQ/bL+UYCQ/
         k+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781938207; x=1782543007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWJ6ykcaVVJ8FSV3Vgps/e2+SKPjlPS1FEpT1cmZ/tA=;
        b=Ni5yTmlSk/R/DhY7mfMW6HWPW2iRd4zeZ1aXd7WKdv//mGtgq1NujB7Ju3S6dNZMKS
         aRU1CeKBWuFlDyvsbKDzsuxwQiR/0WSSAmTKwfEI60VCxaqEa+RoLvFqrjLhIQxl84wI
         kugE4uhMGD6wiET0pVpa0fLBpG/CXVewyG21Kwk2IsAFa6AH+ke9aoeC61uKDrJvQKwV
         cV/Wpniw3wbgqhkIuZrA0Iwgjc7TigWL0yf72Cpu7q7k0FskfWgCaewYD7rEoEHN+TsS
         wPPzXAqWUCvY80en9khlRYS9F9mDTtl2MB82vofxFZ7csP9auQ0m8xuc5RXabhKSfGB6
         Vv/g==
X-Gm-Message-State: AOJu0YyNlT9laVJluLhP1CuopITIyJGHz7aRocZ6JlWpjzKVBUJ097Ij
	nj+eKNyA8WamFeUsP+ITaSJRY0Uxgrn/J66L9Axi4F1fjoarETmZ4xDJCOwpy+tILc8=
X-Gm-Gg: AfdE7cmjzuSCE1WiP+sMseF8RC4OJUIFWsJQwfQI2xrJjmG07fdQua2V53NTJ3dT9RK
	pOULg4VQnAkkDSdCnRIwL4pmlGdlbBpZJ57YMU1hhPjycEtcwJ4djYBg7/LFSmMpGDE0xEShDyu
	gYYKvEah3sGfRcz6YIT7XpaUT5VVMR+IA5s9R1kQrNxc7J7eQofEIV+8p0BVDHeENfZAID/6LLn
	crkCszOVqxnBWchKm5leFv2wEm7khjL7OxtIY5zrdeOU0phrCcUxCpv7UHWCWXW750wcglx0XnM
	eVxCBA4bcZhj+oKnVt57yQqU9/4Kg/buAW0mee7fFA1qDeDJxng1Lq9tWnIxEOUEmO+QTkKJPRo
	faGVmLyuPQQ1QHSuUL5on8TcGNc4JNUKCqWAb/uDWclRgWuETiXcuqMqMTc2nDnZLVPsM3R28iH
	xyO8jWHql+aStyP1O+nt7kF+rwMAy7547p2Rb5OGXF+lWhF3f/s3lgB/nagDDnFVPehZo5K5IoT
	E4E01WeH896X24r4ESxYW2C
X-Received: by 2002:a05:6a00:2da7:b0:845:4d3d:c8a with SMTP id d2e1a72fcca58-8455616a4cbmr5905331b3a.32.1781938206616;
        Fri, 19 Jun 2026 23:50:06 -0700 (PDT)
Received: from essd ([103.158.43.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea7e22sm1394203b3a.42.2026.06.19.23.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:50:06 -0700 (PDT)
Date: Sat, 20 Jun 2026 12:20:00 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: stas.yakovlev@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ipw2100: fix potential memory leak in
 ipw2100_pci_init_one()
Message-ID: <722flntlwzdr5olnxilkad5rg3mmu3isgobzzhvmfwqiseibjb@si2vam2v2y6k>
References: <20260620055558.75740-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620055558.75740-1-nihaal@cse.iitm.ac.in>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37935-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stas.yakovlev@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:stasyakovlev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,cse.iitm.ac.in:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5C966A870E

On Sat, Jun 20, 2026 at 11:25:54AM +0530, Abdun Nihaal wrote:
> The memory allocated in the ipw2100_alloc_device() function is not freed
> in some of the error paths in ipw2100_pci_init_one(). Fix that by
> converting the direct return into a goto to the error path return.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2c86c275015c ("Add ipw2100 wireless driver.")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Sashiko reports a null pointer dereference introduced by the above
patch, and I realized I made a mistake in the first goto error path.

https://sashiko.dev/#/patchset/20260620055558.75740-1-nihaal%40cse.iitm.ac.in

Please ignore this patch. I'll send a v2 with the correct fix.

Regards,
Nihaal

