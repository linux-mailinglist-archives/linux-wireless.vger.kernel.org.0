Return-Path: <linux-wireless+bounces-29342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77EC85DA0
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C063B323C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA813AA2F;
	Tue, 25 Nov 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+tKTaSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E0347DD
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086437; cv=none; b=K6PpPbX1WhvN4UOK37xTmD87l+S9jGl5zfjd2+whyd4oqRFTd/3w0xAWNUwt/b20H5FtlHKsKRKKxQIzN1CIAMjVNamI90zHGijkkUYYgTdQ2b/oT8tKXMbqtEfOs1zUTJj+lR6CpbElVYRDyKstle/fvxgnAZDFmv13sAE4qGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086437; c=relaxed/simple;
	bh=9BFD4Msg+qpbpjeNXXts2YAMbYGLrMYUBpH3xOUujUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZLszfHigOIxITJo5lAx6gjHs8wRSzLTtz7jI/C9aS8gJ8O2LT7OlR/La+sV594VG9/yCIqVFtDKWgdTaoXwS2q4dvjZbQxLUv8pkOz94JmDv4svsmm4DZpcPfS5k5c4Av9++2eN5oQh5wHbBd7ETCO8JRGu9oZjfaDNgjxkKpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+tKTaSC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29555415c5fso62986955ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 08:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764086435; x=1764691235; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9BFD4Msg+qpbpjeNXXts2YAMbYGLrMYUBpH3xOUujUc=;
        b=Y+tKTaSCYmgZ0uh3+8+N/ngjl87A9j9z3kdiETUTcm5XVCV+GTIpPO5xo6enaZJT33
         llzUnBAZB+TbXcAyCrTMJF3gmk7/XyOgnS02nQVnEx1D7AGGbTNlxR2xZFwcZSv+yYCx
         T448b35WOrypKbRj3W3Ui2rf+HyoBSKOu4qLig8JE3NJ6i3Tkc9r/2nCFBOCNUisaMzn
         /t7i4VB53t5/5TQfoHo+u4rbcl+jBbMbPvmk8WmOeJozyYRppt2/xmEwRlahjw/LKqBB
         9jIvUkIdjr0N+HailS5wDdhgMqIvK77BkO+fbtn03Sn6wsq7SIxA7ArdY//QYcKcQ1pn
         Nvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764086435; x=1764691235;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BFD4Msg+qpbpjeNXXts2YAMbYGLrMYUBpH3xOUujUc=;
        b=YImCKPmxIf/y9FsNtf/GM3+OwKW0re47iMo3IbukqXulWd5xDDj1/jUNKI3Xa8jvBK
         mi5JqmVakeXVv0caNK6yDzxGX11PXwxHlqKqMWNlrq00QegwPdBevx9GosIq/2u3V3Kl
         SvbrknGbM5GgJNVy30H2aZntSXPlK+jHuYKZRnKnYc+QS85QpTjWWW/Fb491r1dY953l
         ATsHfKH2BBNzcWFSoX2QjQb0eHcFVOuhNSMfLpVmlu0GME5sFuaYVmY8+pkSqbcUM2rk
         bm3hLVMlUsJHuWQW26pV5O6Iv0Ra1JAllqVLePXFpLkznrm1KBFAHQ6rBGKm3y8NWpLA
         6GMA==
X-Forwarded-Encrypted: i=1; AJvYcCUbA0IV2bYkA7Nb++/ez21nsxdUdtO1i71Rc3EfLdzdo7m1pmX/pMKDJv9BFEjsT4RBx4MH9IyiACQ9nf7rfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CBpkfm912mbSl1c5CrfQlrp1QMKvnm0kJexU5rf2ANrjIjT9
	nzEx+jb7M2XUW5LXlVDxqZJYi+izNVTZhCtmXpKdKZAbgNTqk3DpENKE
X-Gm-Gg: ASbGncvXFzqRWVQnKRwBROlZL18t2SNItpgwZ0MapojI8xCZgHGn27x0FpFveZ+wIsQ
	VynUAe0GirvLAcdA1kuA4qVDv0MdALC9lITXdzxk7wobXfAtrFZ9DzYD/h0bjCPFA7LHp65mhYv
	n1r6M7DBlrTBy2o03F+prAETkAB8VxodpaSL4wyA4xk4UiwUUWyPRpmHK2rG6IdtY+XygWCCic9
	J12QWj5JM7NFAxByoSSiCqYWvcjyKQ11/poB6H4mzvSAxi+1A6fp9G5JfUNxtMTGeQvVPuPsZ6M
	4FqF6O+IsLcpAiUhlzptfXmoVc7FNwb6LNIJ73hcketmFxG4yZIL4OfpVOVqF22bqa5wppZbLtY
	yoxEKLwo8/Ym3stj8e8I125HlAQ/xeJnmB1HIo8GUyGJEM3r0UJJiaoIGKRe+wbEufTj6u7g3jO
	nkRXwCtwZP0at/aiFoTR66ANbjndHJjAi8N0nltkDqso/xaoEAYjg=
X-Google-Smtp-Source: AGHT+IFo0y8QRo77glOyXr1LFVMu5VvwMJ7IW5GrSQooqFcwZfF80Gc7FfZ6LwWpz8xenu+GXlE6cg==
X-Received: by 2002:a17:90b:4f8a:b0:341:194:5e7a with SMTP id 98e67ed59e1d1-34733f3d3a5mr14125781a91.29.1764086433186;
        Tue, 25 Nov 2025 08:00:33 -0800 (PST)
Received: from ?IPv6:2401:4900:8fce:eb65:99e9:53c:32e6:4996? ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be33dbsm16995860a91.8.2025.11.25.08.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:00:32 -0800 (PST)
Message-ID: <e5419ba84c64e9146652864072b1941ef310de4f.camel@gmail.com>
Subject: Re: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
From: ally heev <allyheev@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 25 Nov 2025 21:30:24 +0530
In-Reply-To: <20251125-hot-seagull-of-trust-cc4bbe@lemur>
References: 
	<20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
	 <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>
	 <20251124-terrestrial-mule-of-kindness-d8c4f5@lemur>
	 <5d6e492ee9194b1125340a66fbd878279286e433.camel@gmail.com>
	 <20251124-encouraging-snobbish-nuthatch-230bcb@lemur>
	 <89c6d616ed10eadcf41f085c2484560752db82be.camel@gmail.com>
	 <20251125-hot-seagull-of-trust-cc4bbe@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 08:54 -0500, Konstantin Ryabitsev wrote:
> On Tue, Nov 25, 2025 at 12:50:44PM +0530, ally heev wrote:
> > > > Yes, I use b4 for my patches. I work on other open source projects
> > > > which use Github. So, my global git config commit autosign is set t=
o
> >=20
> > typo: `tag autosign`
> >=20
> > > > `true`, hence you have seen PGP signatures.=20
> > >=20
> > > Interesting! I've not seen this cause PGP signatures to be added to "=
git show"
> > > output before. I've tried to replicate it locally, but even if I have=
 a signed
> > > git commit, I can't make the "gpgsig" header to show up in the output=
 of "git
> > > show --format=3Demail" (which is what b4 uses). Do you have some loca=
l git
> > > configuration changes that make "gpgsig" fields show up in the output=
 of "git
> > > show"?
> > >=20
> > > -K
> >=20
> > I think b4 uses tags for patch series. I have checked old
> > patches(before disabling autosign) and found that signature is only
> > added on first(cover-letter) of the patch series
>=20
> Oh! Interesting, so this happened on resend? I'll test it out, thanks!

I didn't get it. Signature was added to every cover-letter of patch
series before I disabled `tag autosign`

>=20
> -K

