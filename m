Return-Path: <linux-wireless+bounces-34269-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEX3BPbjzGmjXQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34269-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 11:23:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E4377815
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 11:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97E1330055D1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF423CC9EE;
	Wed,  1 Apr 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcbMzFc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16D3CAE65
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034901; cv=pass; b=jEzjUSn6lGqby33FfEY67OxOwmQkV1bM+B5wiRmjPF95y9bwogVBemaXgVys8e+r+YXcDDXO+8wjULR6VFhsB3RKkA/evG5LJfu+NT3FKOe5BPXfICnz3gxrYvIMjK193IQNrZC5CDRLx1QNt834zNfHGGpgtNO9EJe1uNlt20s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034901; c=relaxed/simple;
	bh=Px8VZ/mZa/wVBiSvlhUqswxvgLPunBza8vM2mBYbtJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND3vOCHk6MNKIxh0xZ/lG2DHhWD82OIq7uxy4RpSjIpUNmdgD4mMcm7PdOcLmuO2mP4OCN6mC5oOMEDlduCJHe2VrMcJ+1uAN56qgJbRzCVxdhQV/82GqzxD/wMYvENuSYrfqKSZ2t7HDoASoYux/2LRziXjuBtOvDDEMjQ1ANg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcbMzFc1; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506bcb23a78so56595211cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 02:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034898; cv=none;
        d=google.com; s=arc-20240605;
        b=UCtYVw21lcMv3SBoAVksQVrN5Oo2efuUXdzsGcruLRRCVst2zUa2hvUcCRrRqMVsIN
         K/08BjqDvFyKdJtjs85dYus/ykfFcBWpVbx/ehfLLg+zZq1rEee9EJ4VfTa0uqXFcpnK
         KAXS03iNS3ZsYT4MJYuHPVpgYPxzE3zi+i4BHh4zzsdqzrTu8/NzHyaVo4UrBIHZVZbh
         wbUyt3xmHRK0NT04kiQjdKPay7CvlqtTqzYWiHcHGVQOxNaiMZvDz0DEG8TZuCdt0J5g
         FEhu8AsaDzakPkaodQPE2siFoxHv6TNWGI9ezMBed3AAN5/rggzj3fmJBPKtkMigVqNI
         nqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        fh=Q3WqQHB2lbLImMCTAXceHaR+Dt3vHo2Q3fuW10OMvrE=;
        b=DDfmzih2IVZGbjb24QoYC3eLeWcowGLeYn3evLb8dR2bzcCPIOJquUuhfjD4kKp3e+
         2QsQQR5Nb4fi8AQLsU9g00acXw40ZJLJK2pHtRL0g+3KvW4pJfMLDwDd3InV9bVUgKd2
         qfyDiTRX+w6TpJfxTTuewQ79+HWOVtFDZtRVM49cbQkmW+eKUKU1W4mFHx5967VYrVi1
         V7a3rFu/gCvYOu9M6wr35762OyFHvAQiY/P/Bz3ycNeruEs2XxFnPKwoBIdPhZoxXFya
         yOpKCDGPufYHK7H6OfRH6qmAC+cPsEJ6JUU/bmRaxvsaJtl9ijecFg7S4dBk0lAeiwKL
         hH7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034898; x=1775639698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=PcbMzFc143UJPNLa1IszL9pPW8NVryFgbF485R7GCAGuU6p+ZrBk02ECuyE3QGpPPR
         s8PmzFSS1wArBXxvuc+UtXXMnAOwCJ+jq+1vNSV+UniMmd1Z5E8/yTmPY7jdYzGGTVr6
         NzWp9TOvjIix3ogAaxIjggzONpWn1bnYrGEVP35Jv2A4mKUlB7v6q/VKR1ubhl2Awk3s
         Kxcz59bI9slSkfdhXbqubS/KzGRsdYjcTJgVAK0tjaZi0oohw05fsUO/dcsMUFE+pl0E
         aVByIpngrWTZAFOiI7hgEJOSTa3dRZmFq7KhzfK0ZJxLzy54WLBvphLnzo2fZIpudTwx
         M7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034898; x=1775639698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=nlS11KFtaZcDydQWx9qgOVriAh/0HVQ/jJtHZxYG+aPIxyEcmbVD3o+//NYmmdTMvj
         3cO8lxwVy1kPYaqWTsMwkGJeWJJVJWovpBQe+QyHxrN1KGn6ZMlyIMIwUGmXTzjGnKMU
         epveC8Ctv9zZfjFXPUhTDfYrZLRBVDdS1snYOEZYeHtqemN9o+v30cJMRqvech9A2ViH
         C+nZoGII33ZIvCia2Y03UtMNczu9vDDWfhZOtekQc2rY5gTU8hMHtZXLfdF6txQ5iLhU
         ZJO6HrIfZlsSlckmjWoebx8xsdTZXZcIPf+DITNbbM6csiBHHvYIcrQkJ8B1om8VVSLN
         kEdw==
X-Forwarded-Encrypted: i=1; AJvYcCVTitUcZZaRU/cW0aTZnAySWMTBBbUDrUjVQ9Sv7IWUywHJ9aqc7l/VndFlIZYQ2Q6Q072Si9j0774Z3RAtnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5T9Ucd6F+aepCVg+v98Is18rTmRYsL3NTIdHFdWwBSyZ7hWwq
	HaPSOg3+cWy8coZUyvvuhLn5ZDlYmSoeqpaLks0fzBx1FdWq8lbbZdvnIPy0HLfd5xhzfkoEMQb
	lVA3Ucsh3K1qqZGYr8sVfPJKi7kj0fxd3YXD6zJqQ
X-Gm-Gg: ATEYQzyUZ8CGy4/KuSvvijtn8kFf2cM6N4GGPkQF+rzAdPjFI9s7s1yokNNE+9aFOgj
	0tMjVs2/ANBRedbTcWSsfH57DbcXFcdRIy8KyIG7yUDlMmpZY4fJ56TSJN+fOxb/vCu3QdfiHpj
	sai5ZvVbDWuPiGLx0655fNTjCCmFk+LOkV25W1Nu1MBC1pm4AVT4Qd4JV9BFyvtcfdTFhNyzmKD
	foG3vABFo5tWTIStvDZhYE2CI+aCWzochL31tNFF5/EbFftX1VtO7Df8RqSPuRzn3CaOP3vX8A0
	asSD9Q==
X-Received: by 2002:a05:622a:1c05:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50d3bcf5f5dmr36705111cf.50.1775034897967; Wed, 01 Apr 2026
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-4-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-4-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:14:45 -0700
X-Gm-Features: AQROBzAoGbAvZgGI1SP1QOjEPB9AfHu4JQqffzH3Pc3uWqwtvvbxFW3VGI6Tc4w
Message-ID: <CANn89i+iRUgqtd+eirfSUM3k+keNZKzLwsHxZtwE+vHdv7H5PQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
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
	Guillaume Nault <gnault@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>, 
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com, 
	bridge@lists.linux.dev, bpf@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34269-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email,amazon.co.uk:email]
X-Rspamd-Queue-Id: 070E4377815
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Wrap the IPv4-specific registrations in inet_init() with
> CONFIG_LEGACY_IP guards. When LEGACY_IP is disabled, the kernel
> will not:
>  - Register the AF_INET socket family
>  - Register the ETH_P_IP packet handler (ip_rcv)
>  - Initialize ARP, ICMP, IGMP, or IPv4 routing
>  - Register IPv4 protocol handlers (TCP/UDP/ICMP over IPv4)
>  - Initialize IPv4 multicast routing, proc entries, or fragmentation
>
> The shared INET infrastructure (tcp_prot, udp_prot, tcp_init, etc.)
> remains initialized for use by IPv6.
>

...

>
>         /* Add UDP-Lite (RFC 3828) */
> -       udplite4_register();
> +       if (IS_ENABLED(CONFIG_LEGACY_IP))
> +               udplite4_register();

udplite has been removed in net-next.

I would think your patch series is net-next material ?

