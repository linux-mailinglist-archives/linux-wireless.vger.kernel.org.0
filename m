Return-Path: <linux-wireless+bounces-18757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB679A309B2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87FD168926
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C131B86F7;
	Tue, 11 Feb 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsPgTBen"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0B1BBBF7
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272535; cv=none; b=ikCa2TlUF+nsn2ELVhOHEwibGyG6mbhn3eoH57DLrcZw8acvgcnEkrQubFaBqotFuuYzEnqiEdicR1AADkIImUf5rG/mRkDddAceum8WqK2ayeiOCl50WB14g35SfbsKeBzeH/F3i7bylyACZ4Dz3qvmNNmszwbXLY+FEETxLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272535; c=relaxed/simple;
	bh=8l8FP7dj+1NJWawu0WDpUgtCnN886pFUV0K1G2Xj/d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Flwk1jenFKX6tKnm7Rr4yvncqWO+yIbtXteOwjo1xoJUy2n+H3S8V2eY+Zhn7IxooGKd9KB6bB/PsimpNoVK0BlSETsfr8H8D33OtWKKvUmz+Of0/oqbmz4VuEOEs1A7cfFLhWPtYvDFORIccrPsfCr5n3gtBxMtclqCpC+ib6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsPgTBen; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTT52xz0DA74wg1Fq9YWmZolWlBYBYiMJjpLvmR40n8=;
	b=gsPgTBenH8m+B1vincKtB8dlwgad16ipFscRWtDUsTz2crO9wo+scLKv2BSZK68Pt8lG0g
	GaLz+dayd9Mq+jdOMKjNiV7Qn0Tzl+mU3CjFT+dsGR/qJtaTsv/CjaGvqx+ClVh+LyeDG6
	Piup1lslJwBFrdfau/fVaLqyA7ZIvfo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-iPeFwvknMH2L1dqm_7d7Hw-1; Tue, 11 Feb 2025 06:15:31 -0500
X-MC-Unique: iPeFwvknMH2L1dqm_7d7Hw-1
X-Mimecast-MFC-AGG-ID: iPeFwvknMH2L1dqm_7d7Hw_1739272530
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6f2b082731eso61025037b3.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 03:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272530; x=1739877330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTT52xz0DA74wg1Fq9YWmZolWlBYBYiMJjpLvmR40n8=;
        b=HgAFH4bvyQqKWIwj+EMNYxT/ofVTi8LR89/a1QU5NTKZPkETysFkoSoB5q2yQLJlDn
         3q+i/hCw8d1BZdUdysCqJMn2jiYv+hJI602SnU9UIHzk0ANZ8YJsvQO129TJXy1hC+U9
         X9vJ8Jfjq/EdSIFKaedRxJ00c617d1ImUs0tHrqkeR7dOmKmAygAje2qrg6a1MRAeR9u
         /Wk0on48DeawdErokZ3npTdOMW2hxo5JKnih9Zzh2eVnz6oZs94bpVwXjwK1+WAzQeGW
         k1aF9+HuChWr6rtwcATJsTiUrb7JeIjz5Jpke39a5RO2C3rHzOxVPwq2d0lW3SukImow
         W1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr4/+6vevWzxuRA6hiiIBt6q8DXDbbZWX5xHB8LkGJ66L6POpebzyZT5o49r+gC9hPZ4lmTVGPTpbPdR7fqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bG610lypmDQGNiBHjVp8p4RHJT64VjC2Idt3nQf2bxkbhTaN
	FMKw4XSSde9y/G+ZczEZEfkk/WOgq8gYkC4lz2pxQFNVppSaDSa7unqynTQPoXjEZILwC+H0iWB
	YmNbuX9wAuWhK9H0thTPUXJSA/PKxw6y6COPLjIOEsV6Hayaq2MDAfTzeC71UPXkQ4RmOgt+jlo
	ZBlxyUYQ0rJ77NHpXxwPbYrgcUEbVjhnab+eA2W2c=
X-Gm-Gg: ASbGnctFoY4n8/WA9LJP1NieY42J28Rq9T/JNUztti8ygZ0oyDv4d5xzdVG28aRs1H+
	oScfnCBbYrqGuFHChATBXNgEOFlCfCBbplydZglgLdmTMqFRVAaLBTRVX3dAoQYOUgLirTuAwPe
	P/x8jDVbSWeHZMQZEP
X-Received: by 2002:a05:690c:62c1:b0:6ef:5013:bfd9 with SMTP id 00721157ae682-6f9b2848b45mr165172327b3.10.1739272530407;
        Tue, 11 Feb 2025 03:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNF6T2I8g7g0eCN2cY1s9w09QLGZQ32g2apXNz7Z6C1M9fCo1UadwH6c2YV8TO6JEjik4xnO/AMPiw7BaFxTE=
X-Received: by 2002:a05:690c:62c1:b0:6ef:5013:bfd9 with SMTP id
 00721157ae682-6f9b2848b45mr165172257b3.10.1739272530161; Tue, 11 Feb 2025
 03:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207121507.94221-1-donald.hunter@gmail.com>
 <20250207121507.94221-11-donald.hunter@gmail.com> <599a281f-d468-4b92-8b15-6f1292888dd9@redhat.com>
In-Reply-To: <599a281f-d468-4b92-8b15-6f1292888dd9@redhat.com>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Tue, 11 Feb 2025 11:15:17 +0000
X-Gm-Features: AWEUYZlorL5Ekx5ZkbVkyzU115bFfmicFvXWD4bbSdvoDWFeQqMhOAs-Co6t8ok
Message-ID: <CAAf2ycnV42g0YHMU9Jdv47J-5p44m2bgj6rjkpxBnXUUrWROzw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/10] netlink: specs: wireless: add a spec
 for nl80211
To: Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 10:59, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 2/7/25 1:15 PM, Donald Hunter wrote:
> > +        type: binary
> > +  -
> > +    name: nl80211-iftype-attrs
>
> I'm unsure if a respin is worth, but the above yields a strange looking
> c-struct name in generated/nl80211-user.h:
>
> struct nl80211_nl80211_iftype_attrs { //...
>
> All the cross-references looks correct, but replacing the above with:
>
> name: iftype-attrs
>
> AFAICS will also generate correct cross-reference and a more usual:
>
> struct nl80211_iftype_attrs { // ...

Yes, well spotted. I'll spin a v5. I've been making the same comment
on other reviews so I definitely need to heed the same advice.

> Also waiting for some explicit ack from wireless.
>
> Cheers,
>
> Paolo
>


