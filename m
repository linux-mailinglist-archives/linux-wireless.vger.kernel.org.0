Return-Path: <linux-wireless+bounces-34277-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAjpJVpJzWn4bQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34277-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 18:35:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4143737DF71
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 18:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E818300E738
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1007363C62;
	Wed,  1 Apr 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNE45O+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C539A046
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060462; cv=none; b=OoOZXerBxphf1VXZf9CQzudzugq/DuccJF4mL6l0AX3POOyGroZEPJg1uafrKYSJR9AnSmPUoC7zCFHVCNAAwGX8u6iAUZ7+C1uehseeiHH3tOY9/TU2Zg73GDWe3zm6waxJ9iqI5l+0Pre1rFjbxAAJOwvRPs9FrKHa62BdVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060462; c=relaxed/simple;
	bh=vqf1PiQgIrSLvLOIqCuthN86/GGCYXPRBreHnHltp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REbcPzipV86HYS1Okxeup1fQKXMZlcXKhXwYE0PZiY0JcVFG0XEpCzyQswGX/IOZrfqC2aQWx+zOfYK3B8XGS1Nz+D5+nvDXJQpWC88Rn6HEFBdJ+kluiR0JSsBqCXu/HXswYBIfS7eUtcFM/F1RZhU3wGrHjxKJhCqSh/BnzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNE45O+3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12a74039dc6so5818116c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060460; x=1775665260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=BNE45O+3NVsAQGgQj1RNyaCUlBChtmDeBTLHeVtYINkc/ccArh4lb3w+uEBU5yahai
         UNh+Ndpqd9XuNVjqnqwdaq0xc3owzEU237n17YEGADTta8CUXIn4orZYlC/VrSxGpAOc
         Eh7dFf533GJO+rWiGiSInXk+Rvhn0y+ff4K/agx0KF4vqXSGo69d3Ygbv4O1AWDlZsMw
         GmTCjdKykQ7jVnwmcHACAXfMCThmI0Uc2wk1chAaWtIxoOnK2+oqHf1EwEl/7LxUjKyF
         W69NDNTHjl8nO5VW2zh4JPFrs3uOmeVM3ecRgox7fv3HLKiqQ/f5YGhEG+9a53YqUjuJ
         uBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060460; x=1775665260;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=FhrxX/KwFUoW9FtarlSiziJZfL+AiEMEQkCbn9vJzrh0bv5v/yy65oGGMvw/mm8gEI
         WcSjSOhvE2Nw5zjg0XNKfZqGkea840ThE26u7DEAWopyqAXB7CbF2xtfUyE0GMUBk/Te
         TEd7wwi5OYtiV5VQbK8W3vkSZlPYqMobG3yqCs8r0K+/0METevFT2XSzPsp8n2jZA+9F
         ke330puSbmgNvhuQgL3f9MOK8aLrZsv1+e/a73VirRUIq/IORFhwOrpaq6qD+UVUQ9cG
         WADBhG8GRKgmjELV6rxJXn8Cr29OwAV+PvDSJsXr8YCDnYHHPYyhqJ49hsp4jk7ASYCe
         BAaw==
X-Forwarded-Encrypted: i=1; AJvYcCURUU1VuGcMKr0AIbf4I4SCWYJrvnxA4I3jYrXi6HPGy5qzvyba5Kt/sIfdGT151YV4OgE6dEhLwOaVkmy1Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytrDmepG6ub01pEZw/YAOlmeISLRWjJ7HBlsJfvxaxN6e+zK87
	9TQXgtexGuJp+VisM6bDxzi1ARW3bJdMRQXJgCHDwyDQXocnr5wwa5Q=
X-Gm-Gg: ATEYQzxXWwDP95VHqKXM68I+q6ILsDYpuxW4ieoONgSYnBkjEUS1WQjKCi2USildlde
	a17SKfGr8tHDX21roGXOjHNoSI251uBAAaEslJme83UFXiws7Zt70QrRaMeJ3R3QZG4+AwlzmK5
	LTW3K5/j4dchVhXdjXo3MTeRZyWdbC58EK06l2WNasbN6pr5xw+nLbkj63rm4dteMcz42PaWsWs
	T2agK1vQm5ZbWbIXNrnnow6XAq2fri729uOjzNZyGROVOEhK5XqC60vATYjEEXWc7ovl8dsdQnz
	pYKhHIQFDVPc+1GRtuTpMj83AdrOJskrWZBECakQdz6K/WPfcogcw+IqL8trrv9tgUuiW8S/9mU
	Ozb8d7Y9lGdiPAj+6cM0yifRgMqccRpZeYSWxCTKQLOIwUxdY02AoTy5nU85VAj8VcMIf51cjuu
	RVBJZEZlbUHQTCoOTZxpyY4JDwVFHG/O+KFYF1HUEoniLPvqsltupfS6pQR8LP9w1Ue3QBr5tfu
	KDj7vEBXhXHW7F1NA==
X-Received: by 2002:a05:7301:4090:b0:2c1:b26:8424 with SMTP id 5a478bee46e88-2c933d8e814mr2313816eec.33.1775060459420;
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm144003eec.7.2026.04.01.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:20:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <ac1F6hIHcoZo-soO@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
References: <20260401074509.1897527-1-dwmw2@infradead.org>
 <20260401074509.1897527-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-34277-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4143737DF71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/01, David Woodhouse wrote:
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
>  	struct sock *sk = sock->sk;
>  	int err = -EINVAL;
>  
> +	pr_warn_once("process '%s' (pid %d) is listening on an AF_INET socket. Consider using AF_INET6 with IPV6_V6ONLY=0 instead.\n",
> +		     current->comm, task_pid_nr(current));
> +
>  	lock_sock(sk);
>  
>  	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
> -- 
> 2.51.0
> 

Does this also need to look at the proto? inet6_stream_ops seem to be
using inet_listen as well.

const struct proto_ops inet6_stream_ops = {
        .family            = PF_INET6,
        .owner             = THIS_MODULE,
        .release           = inet6_release,
        .bind              = inet6_bind,
        .connect           = inet_stream_connect,       /* ok           */
        .socketpair        = sock_no_socketpair,        /* a do nothing */
        .accept            = inet_accept,               /* ok           */
        .getname           = inet6_getname,
        .poll              = tcp_poll,                  /* ok           */
        .ioctl             = inet6_ioctl,               /* must change  */
        .gettstamp         = sock_gettstamp,
        .listen            = inet_listen,               /* ok           */

