Return-Path: <linux-wireless+bounces-34268-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKbWFj7izGl9XQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34268-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 11:15:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D9377630
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EFFA306FE7F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22B39DBE2;
	Wed,  1 Apr 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twFnRIT8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359493C3440
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034707; cv=pass; b=Ch3+sqOGpoRh+e1fK1MhC8+V1Pr86/uuCQRASRQOf1R5+7KX++242DkLs6ZwaYkGU6d5aNy3Z5M2r0nW6WQof5pruXWV7n+jm18cB11rj0pRq/PSNTKvilrnAin0vR5WVHbqKZj2CgmrZUJGdTCWyryki8Ruallh3wX+XRF4g2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034707; c=relaxed/simple;
	bh=dmaTcuAy6jfJ+bmzS1Jm/uyBrkTWgyDnScrFaQ2/nas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjq+JQmd7npsoyOsfajEAtMc0SqjcZNTpWyczVSG2ge+qzNEUPNJoRbH0BjBmO55pPTbsqp1BmCKLReRcxPmzWsQoWiCuqRvwMa8tBn6KSNoartKn8yRWz0TJT8fUFGfInV+jU3NzZoasoIqoLYO69SZv1wU3QfB3ShWqEU7Rrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twFnRIT8; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509061dab77so56640561cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 02:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034703; cv=none;
        d=google.com; s=arc-20240605;
        b=WWYMwIhk6Er3LDHlJsD39h9Z03DT5O1cK34+e/FPOkw6Ytl89YlUqcG6wD3FQVSRFI
         G0JTui9WqjcrrPUrz2KfX7kpmHjEHlWYtXor70tBE5FDTMaYERGnbf3C5rXt3S4+V96L
         iPUUadKjC3Xa2jbIQvBZaENkfos6BxKhGf4wIl0Ppn66TiT+/Ox0szUqO0i2ojHO6dNf
         j5fHk8R/LFvhAYXQIHYNp2m0GiQWzxqKOVqRexXeXyjgWpnmYEpGfdMhR6uIJNOLQPic
         ShfIf/KqVb/k8wFv9Rqgd31nvHU1M9vMFcjk6m4DmeYTtgVthAN5pfEhWw5ajc6Oyogg
         T7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        fh=79g70WR4NWr6gRgwpWaZq+V2S3iCTE/ougc1+aDtfYs=;
        b=jLMmCdtzBVnkrFpOTpFbp3/JFbwb4HdK8sWhfO9SXp+cIyLDe7azwSo/kaZwDQi4gY
         3B4L83Nzdo0iXsFsLEz9Kc5GHbp24Jp9Jv56G6SBAoCT2fDEbpB18n68j91BM/P0UprR
         s3cdYKmoLWVUWg3hPLUwGiQJNyxVlCSWRAdqGDYMkyzRGZ+AD979UHwvT9CEME+H0SHT
         13a9M6zCibOQtRH1PAeL9Zs2NGLOllCqtn3nQXVdIKF7xIpj+uZoQVCQUOaXKAoppKKT
         2nccmJ9hHuh/xxs31sbj5q2tl2pmQMMqs9AlnBKbwdZiwSkXY9e/F5syx7WGlKVz/57l
         qw8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034703; x=1775639503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=twFnRIT8SirtW12uUCHs6hTeF/J2DOg5PKAmKI/mwRCncAk4AIvZwUq8xR7yTK0iJ+
         4ImgI8xWhYvzAYMKo33ksmbew7TAwPlXPwRplqecw+NYSPwHcYD8NcIFmA0v/FzgmIrA
         GlgznlRQinWJpsA4qp4IlnNYa4zu4LMzYJu3khv64uuDL3+ybWpc3gfaIp1N30uXymnh
         o/KWJm7bZFr+X8f9bK2b9IBUwDPo2JrcV4mBBOIg3fqCL5h118wWZzw/mlpOg5YazSse
         2pJzkr32Nm/rqUXZUcHdfdBBA5R+Rztx/u8eIHbmmnYHi26nHKuFO8CqGzwdfgZfHKXJ
         VrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034703; x=1775639503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=Kg1Pcqhib0oSUxetcvegZMZmB89z6jFILYKHt4jKwzmGh0cRDufj/W3JOgNsf4fHVz
         WaMFhy3Kh5FdTN6IhBF2o4ZgjCE6Ziw2afYaZL+y38qID5DClpSYfNOR9n5YHkIIx/TR
         R4YDXM3Mj2jbVYiXqbtp+Xv+SrYaZiqkDqQQrtbdxrVq5GAj9M0Rb8/dKyi5QCatkVl3
         JxG24XBoSMWCzFDVwS63wlBbkNYwG+S8hWpzn1kH0VjORO9qDZ11MNwOMDG8sq0fhwVW
         nl2vhGEENFqvrvK9VEzYvWvGwKYhBkwhZBxP5ZWbpDqsgjxtjqW/bll0BDeGBDEwzZrX
         t3sg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Xf87+IIlcXruxi8LrNuZjPwR5JmHTUQH7uBWfc/5Tz9XVnFRoxr4b0fRpvZec6qCEIVp2SBMcMwPEGaMtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4jnp60hhWv1708p7BXUc5PdbbDCiljMEJm+ABWQOD3A7R09T
	HtOgSg+zKR16QdJwJs2F5OucQMZq0Npkmj4gfwDSo6sl88x1OXBKiIZIQkJWQPQjl+YGk2bCDEW
	4Fnru77RcKGmAwacdRo4VuAfhRa12lhsgrM4CbeVK
X-Gm-Gg: ATEYQzzE5Lg5j6cafKWtpqjW+3lKpn0f2OwyUcQkTNEI2nf/69JKu7w3mCof5S+CV3B
	3arJwQvbvI1nBHX0kZpoaqmDuSs5t7VQA+nQBV5/W6yORtRxUECxWokeNTpe6iUSWkpT8ccH/Cy
	ZHcNH+eEi5KEuLKkz3gimdH7mEnQl51jvROn8w8M+18PX1LOGvHrSqLNFuyxzwpvJn4Y5gPdpA2
	1iS8PRhg5zxAxA/NOVOVALCzbYQcuvkjsb19Pm9BcBX1CzjArXX1nOislQXNHlqaU1tC7Kzj0g6
	MUoySmakqYrQ5ZFi
X-Received: by 2002:a05:622a:5909:b0:4ed:b2da:966f with SMTP id
 d75a77b69052e-50d3bd84b29mr44808651cf.31.1775034702251; Wed, 01 Apr 2026
 02:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:11:31 -0700
X-Gm-Features: AQROBzDMpjzScINQf3v40GgXHFr7zNRIwe6Qb5aBvyyAycV5Up8H_bwJXHOzd_8
Message-ID: <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34268-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amazon.co.uk:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 298D9377630
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>         struct sock *sk =3D sock->sk;
>         int err =3D -EINVAL;
>
> +       pr_warn_once("process '%s' (pid %d) is listening on an AF_INET so=
cket. Consider using AF_INET6 with IPV6_V6ONLY=3D0 instead.\n",
> +                    current->comm, task_pid_nr(current));
> +

Some kernels are built without CONFIG_IPV6, so this warning would be
quite misleading.

