Return-Path: <linux-wireless+bounces-34276-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKl9H2o3zWlwawYAu9opvQ
	(envelope-from <linux-wireless+bounces-34276-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 17:19:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F937CE38
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 17:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD7223037670
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46A370D7C;
	Wed,  1 Apr 2026 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pvvONBMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDC35FF75
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056045; cv=none; b=vE0GHF2yFDKKeHWebasFZb2NgEow8uiATopE/6PgfuIfaG2oxBDTmQBfzAZZVPXWIUgZ4M97fsWWe5XLDfWo3yi6+OFcpO+pmxzjElDkLqWzvvB3AV/MBEhNGF3ylmd39ZwwvhQDdf8NXm7e3mK+KGdbPV7tUC3UaeYwhOwOVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056045; c=relaxed/simple;
	bh=bjcwsYJwkpqzg1+Jd+PAkNPiIUaqng2IgQHyEKuA3jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku1R44tnczdC1ChV19bo40RoDgD1poVjw7WuLP3e3JgHdfDo0MTYRhXD9ij4zDRihBwVlHZx2mU6n7bXCZz9LAkNY1N44JJ9ctK8qmIXUeWuxG/zKmo5F93YfzDjTQcatVo1jx3SczQHO83M0fW9Mcv5j2DBwEI97gAr8Y/HRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pvvONBMP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3591cc98871so3098117a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775056044; x=1775660844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJuOxpA+gsO22gNPhXzJ2+Gj7ezb5L7fZMCH+oDlAG8=;
        b=pvvONBMP+FusaaII65++8DgYTon6o6wvICY7wRMlqojsy0Pz2YGtw88a5ZndpiPNbJ
         qApVXIfMuAlgCD44nPizCmr4iR7FiifOEdooE9ZdElP6qgbJM47ryxVSvZhkakeX4uUm
         D1QciWzNs6UF/wBlFOs2hpmQ6TyFFVEfnYAZc1eTT2BMauvPiNqrRKECaKK/e0zQaUJx
         8SG+BVXpG7aqQlKQLetcu2ylQX5TP1dNbyu1FbFsI5RpadI9uHwBzLOBwza76U9AXPAa
         UrL6hK7TB90Vg7hL16+6LmbBqOYsCfyq/QmR7a/EUCLAwasUUpGWxYhb1ZHhrKqpHvoT
         pqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056044; x=1775660844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJuOxpA+gsO22gNPhXzJ2+Gj7ezb5L7fZMCH+oDlAG8=;
        b=VSN/blaw5XtCxi0knzhFu/JjvqIZAE56U47o/zS8ItTo9cDk/nG+LhzCEhvaQgw6Lu
         OrkcJ+eExigvREi4HmOmE6q4b83w1Nh1DG7BFFoySMojEcQrTiqg8CpE1a67ckYMusiv
         jgm0AEz6/KROu6OnZZd5KJZ1ckQtJJYG4ED8ysmxYNvl7wilPdh+swV3XMbJjj+wSpB5
         9hwSVqTyaFwmQv35mWdOe6ZhpORuxagWVRgsVuEVmzpcoJ4vTYzb71djJyHMvxv7k8DS
         RufI1cfDtMCBvpSmXN6ARp5x2yYG9OCgAZLjf8y/bDc380BM1NMg/G8xKbgZcZ7VMw0t
         U3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJZ+2//ILoH5Uq7fs3GgREA53cvWOBQxjo/wU5dIKPi9N9y4qizjXqIneQ/GX4lVcOMHuhybjs2fKxc75tFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysYista2ysV+cS42rHVu95kyj4sTbu35k54/m7P+TkaxFe2TJS
	+2kwIAfTgU4clKxgw0ovBMiaSQUyhMiowc3ZQ0nBTAoAYT8esQjVATFAwQ9JdDhABO0=
X-Gm-Gg: ATEYQzznn+mgXBWDuwP5PFUhaoghS+7biH7NBpTWHIIUafAV6xu3iwrDM0feC1YThDl
	8WtfWnSzCGaYUlVBSbx2EJNeO2n1XrR5nGsfcweRbiHOFTl+/ygNQ1vvFOYrqxHRJ00XiUtmYP+
	XO6k3qVyxBj5lvP3ytmeetB7UrmHnTR5ZxzJ9KfHoqD3bAAu2vR7mFhJMHY4cDRj6edEhnFFPsL
	byEKYSJfC89EBQv/Iz81kXvrH19NGrjGXGfhHF9u+Zmhy6p1JIMDErH2syFjenRcw+LjNa8giMb
	xYf9zIvMMSJBo97Ka8bOpOrLXiS5pwK4Y0X3vQJZPLQgxz9YEh4ZhocDHaDlBsTOQeGZilrBUym
	3L5/MuXYB713N2pYzrzH8AHqH/Z0F4AOVbGXUE1HjBTG3IoBFqzlIzeqqj0b3GpGRC6iZAC2I7Q
	w3C6a0eA1sT7pGpE/Ak8hkbgulNdm0K6+azS5k/ScCLNPUUQ==
X-Received: by 2002:a17:90b:3e4f:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35dc6e9b097mr4036315a91.11.1775056043722;
        Wed, 01 Apr 2026 08:07:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe623754sm5043344a91.6.2026.04.01.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:07:23 -0700 (PDT)
Date: Wed, 1 Apr 2026 08:06:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, Pablo
 Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil
 Sutter <phil@nwl.cc>, Guillaume Nault <gnault@redhat.com>, Kees Cook
 <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org,
 linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
	<20260401074509.1897527-7-dwmw2@infradead.org>
	<CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
	<252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34276-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,nvidia.com,kernel.org,lunn.ch,davemloft.net,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B3F937CE38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 01 Apr 2026 10:28:23 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> > Some kernels are built without CONFIG_IPV6, so this warning would be
> > quite misleading.  
> 
> Maybe on this date next year, we could make it not possible to build
> the kernel *without* IPv6... ?


There are some government agencies that used to require that IPV6 was disabled
for security reasons. Yes they had broken old firewalls

