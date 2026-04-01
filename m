Return-Path: <linux-wireless+bounces-34278-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNm/DrRJzWn4bQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34278-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 18:37:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED35D37DFEF
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 18:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F766300335F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4C35F171;
	Wed,  1 Apr 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SLWkWwU0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D439A046
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061106; cv=none; b=QQZBYTGNPZDAVjuc97CiFdapRm5Bg0OOHP6qG/S26ZNNUAWon8qURD2dqpE8NDVYrpTMa7jGATXHXfzP4ZnXrvVouCRSyLrnal0KoGczKyIW6Gimb8Y/Y25Gp2m4nP4GPKX8eAOClgWHSpr3Uqr3cSSP6fSe59QF9yuj5xwVEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061106; c=relaxed/simple;
	bh=ybEdMnj+IV21R50M/Nq06VgnFb302XMUbdzsNI1SGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yr4pKi5Bbs8InlmdDaeMu0fVWx4WAGyXjbXetec4G8zd87l8qyoNDhIrjYnBuYcr0NCJ2MBsQGzeDqJv1c+FMc3tHHjB4cwtSODileFx2JmNM8VeBFS4zM/dqjq96M6ZBFO0iG/+ClEcLVRrv2Z/NAqBHhO5fDLdbwhK6wgY4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SLWkWwU0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f97c626aaso1280634566b.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775061101; x=1775665901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=SLWkWwU0vwtfdG+u87e1LgXY0WPu4q220dtiXjEvrmDuZQE6xPT5N+B5oywR4VACzb
         bIfhCu5dAofTCO6U0N2aIdFxIDsHPAUiTS+utyDke0+19NBwRAmAVcibUIfBVUaZGBSZ
         8OQunHQIte+xt/GNIhm2B9MpC2Of/wKt/cz28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061101; x=1775665901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=MGZnbOxgfA88yj2PDnpgjVMaTjdJJ2jX8s3IGmFtzZDUMyA5V65HI3R7yrAKKN7fz6
         5M8bwyscsL/835NB2apM0ujPiBUF87mt3YX0J47/GXhTDQrPgmbVwcIs3slMtlzceanA
         ihRVPWPJYdp+wvEnc4dPO1yuIAxNrdWj4bi+cj0ujDjX7/qb4UdmLhp4IdMigYjDnuEe
         ZsEcWFDLGrwHtKm0e+DibzfdFEKr7kA/GUDWHNx2+Y8UXXaA41hARSLRZEcsJKPWt2zZ
         ENsfqXbtCrcJAslx+U7F4MOMin66MQ3mSbxFDhgxmqs124XkyK8v30ua9HFRWYJqf2BK
         vC8g==
X-Forwarded-Encrypted: i=1; AJvYcCUHooeSC4x7S5V67ADSV3D9CJ6RC2Xj31mPYBGCz3b8/o9dAkqP0jzLEO7doi9lHxqfxjDa2lrjlZwLEpmDlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzELDxT7xuvWJoQueLNPG+gULik8QrLliy18mMb1Oq0lgbypOjs
	ezk26mhyckbMB8VbQGxijM9DImBahKHR3aBVin3x1dJDYpiNkyLZ68L3n8Yh7egfhqHxpbSNJbU
	816uWnUNHsQ==
X-Gm-Gg: ATEYQzy7UwBQ0bYvTm8utzq7tK9RcUC+Sxi+Kd1ws4ut2t/QyJ+Fb0ofcoNdInoEPlg
	9kzuL7BM2MlyOYxe4bOH5014WU1u6Kfby24v4bbNGs2kX7QPMIUyHYRuGOBp658HOtOrzn0Rwpg
	90CShMSYpdVzqhDNHbaS4q6iAZ3r3xX4Zs36CUKfO37fXPyVROasJ9dD7Rxt+pGpLNTD6jaaUk5
	oikcM/VTu9pyLOkHxlpyuAPPyodDo2pMclVB1erGxMPISUrX00KEYY9YRCJvoWPWCncMgc0XwJR
	qVmV6wfpeC943xDrHPN48CIwFJfhYMkZ2n+0eI2coIwzt2+5/QrWzM0CYseVzxhFtFl/1hC5l/B
	reVVXxEY9Cp3E5GgO1Ka9lT8yR5Gs6WKSQ6OeG0S1R2r2g0yXcTNGrrJ71fgBtniB3/nmmCsFmq
	WVN/CwXqpRdek00rkVYjVIQqUzVTzeKho7ingV027DTLDXRme7Y7srPX5xZ7uDOub6qewYC02i
X-Received: by 2002:a17:907:d096:b0:b98:2c44:6631 with SMTP id a640c23a62f3a-b9c138e425cmr303479066b.14.1775061100821;
        Wed, 01 Apr 2026 09:31:40 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c97209csm6119366b.12.2026.04.01.09.31.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:31:40 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66dd27d4465so1804702a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 09:31:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXT8tv+H0pCv4TNnDCKvWjtZpXdhksErrFLkoGiU6CpviQoeg3JcWEbHDaJ/wWQ5EjfdmxKZvE6smE0Rarr9A==@vger.kernel.org
X-Received: by 2002:a05:6402:35d0:b0:663:4315:7271 with SMTP id
 4fb4d7f45d1cf-66db0cfbdaamr2927572a12.23.1775060766098; Wed, 01 Apr 2026
 09:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
 <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
 <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org> <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <20260401080657.70cd9bd1@phoenix.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Apr 2026 09:25:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
X-Gm-Features: AQROBzBuhMzLrgonz6WGspEvkWFhuj-ddiDGEYTFKbMu2F_LUT3de-t_k_EwsPU
Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, Kees Cook <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34278-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[infradead.org,google.com,nvidia.com,kernel.org,lunn.ch,davemloft.net,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ED35D37DFEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 at 08:07, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 01 Apr 2026 10:28:23 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > Maybe on this date next year, we could make it not possible to build
> > the kernel *without* IPv6... ?
>
> There are some government agencies that used to require that IPV6 was disabled
> for security reasons. Yes they had broken old firewalls

I think you missed the big clue here. "This date".

Sigh. It's going to be a long long day.

              Linus

