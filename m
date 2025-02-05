Return-Path: <linux-wireless+bounces-18543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A5A299C2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 20:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5932216A264
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 19:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196CD20011A;
	Wed,  5 Feb 2025 19:07:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C821170D;
	Wed,  5 Feb 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782473; cv=none; b=T8y2X8Y7V7U1AVp4SiUWAACITQRAOzKVMkBw/FX+nLtOHiIS91+0CEaunOnujgOk9sWeumYxCPGyBAtTTY8BXA59Xo/oLuIDMZhus/lQ06J/Lf8qSe/pVyh9l7jArnDL24Y86sI4iGx3GFxAKzeHYh3OwUtUFiH57rY+7jJS6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782473; c=relaxed/simple;
	bh=LMG5gaWBYIK0JshQ6NVs4SIGayzcLVCUhGxss8oB55Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiS9Kt2YO6LEyLO/ZFhRzzFPSXEsD/ArAfpfuHUw4pHPN2ZqIDvzaelzPzc9M31cekZlQqfdwQ5Yae4x7afbwNW550ho+MmlzwT6YmBnve19sYMMiiin4byShosQcE84ccZ1X0PFt70PBGQBEmZlGCsA5+u4ZDCyHANQQYVC6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so19970866b.3;
        Wed, 05 Feb 2025 11:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782469; x=1739387269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY6dYGVe6ovMP6LmJErKZtQSspIX6gQ/V/P/706krPo=;
        b=k1Yh97gqK+28H97pNUOW6Uush9rIfj87Ss1CTElOV554J8ZX807bDcFmy1gemrPNos
         A4df4Ou6tx0Sh+t6LG6SG16nQ2ZUQKv8sNvTN8+c564f0MyoygJ81Ei5tdModzc5mjvU
         AmGNszhII0EWqgSuzQ615fmqexAC6PnkPi4o/1mR61f2iU1Ph7mqG2uBO+uRFntN/cVl
         FdxdfiCJtDIMDLbWBlpXdvP8YIU9antStxgIdlHtcXfKMNZAiUBvgUyqWXak5LbD7xic
         Hw4Hpcoz5pw6qyijd/lXqNdutWgVz4cp2s48pnLA8XYArW8z/TDbmae1jnJA0wM5mHRQ
         fyYA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGZ3Cjs1iLCR3MgAphD3Yx4o8eEAU626hmlvhNylQofkKH8F2ADUTmx/q5xrmDZRFfog5K4KG@vger.kernel.org, AJvYcCUMOnbr1vOj7XPJ9hSPw1pmLMY2TF4BBvGo/VfaoQADRR661Cpf5nF2VRPA1io66MIKuNEJ7exV0BXGHs52ESE=@vger.kernel.org, AJvYcCWCdOFZVfK+KYm6KzT9t0rZCRvi7az1mgVTG6Olpm3klnP1egUYc8U0uckR1h5k6i2r1+BIugqQ1oc=@vger.kernel.org, AJvYcCXiTYAUVuqhzEV55CLV+AYpNuIGWmTQjqlvu0GAI4/1zP66t/GIsWF3z82D5GSn3SqI0ZriukJeJBSh6oND@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4C3BV3XhvQXpVRX1oeAhLESuvH+5K1OVehJo1Smoh480h/BZ
	FLJxKxh+ueXefqG1txFzAju5uCWVkqczKEjcPfAjK1qT9EXx1d1e
X-Gm-Gg: ASbGncuncSHD9nJJuADIuhfqLj5TVOVqmxkN5RQCRdEHbCZ7MiCXgauEuW7URaYjpAI
	L13cCLBXLqjttw1Db9IgDE4MLAIArVv0lUCQNc9P4/RNI6kNggwIDL0L/B176wajPopezgp/jD2
	XRcxZiGgrgbEWzXAEeF9CL//aGOEeuEmDCn3/9EPBwVK+M8ICkYmAhZwMK/Xr+E6rOqnTWObZ3G
	TZv9DEHy0gIfO66CASaINz9zMCQiJB0GZZP4Oy9iHw4PpzQUJ6xrV5Lw2XEasMLUAcez2FRncii
	mkAfo9c=
X-Google-Smtp-Source: AGHT+IHPrkNV+54hDGaQFdYYeo3xJb2BJPMEFvC8tH4N4HRnkWu5xzHXdcDFw2aQOq4OJd0wfKsYEg==
X-Received: by 2002:a17:907:7f8d:b0:ab6:f59f:5427 with SMTP id a640c23a62f3a-ab75e21dd2emr420699366b.11.1738782468433;
        Wed, 05 Feb 2025 11:07:48 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a2fa50sm1139487266b.128.2025.02.05.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:07:47 -0800 (PST)
Date: Wed, 5 Feb 2025 11:07:45 -0800
From: Breno Leitao <leitao@debian.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] netconsole: allow selection of egress interface
 via MAC address
Message-ID: <20250205-flying-coucal-of-influence-0dcbc3@leitao>
References: <20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com>
 <20250204-netconsole-v2-2-5ef5eb5f6056@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-netconsole-v2-2-5ef5eb5f6056@purestorage.com>

On Tue, Feb 04, 2025 at 02:41:45PM -0700, Uday Shankar wrote:
> Currently, netconsole has two methods of configuration - module
> parameter and configfs. The former interface allows for netconsole
> activation earlier during boot (by specifying the module parameter on
> the kernel command line), so it is preferred for debugging issues which
> arise before userspace is up/the configfs interface can be used. The
> module parameter syntax requires specifying the egress interface name.
> This requirement makes it hard to use for a couple reasons:
> - The egress interface name can be hard or impossible to predict. For
>   example, installing a new network card in a system can change the
>   interface names assigned by the kernel.
> - When constructing the module parameter, one may have trouble
>   determining the original (kernel-assigned) name of the interface
>   (which is the name that should be given to netconsole) if some stable
>   interface naming scheme is in effect. A human can usually look at
>   kernel logs to determine the original name, but this is very painful
>   if automation is constructing the parameter.
> 
> For these reasons, allow selection of the egress interface via MAC
> address when configuring netconsole using the module parameter. Update
> the netconsole documentation with an example of the new syntax.
> Selection of egress interface by MAC address via configfs is far less
> interesting (since when this interface can be used, one should be able
> to easily convert between MAC address and interface name), so it is left
> unimplemented.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
Tested-by: Breno Leitao <leitao@debian.org>

>  int netpoll_setup(struct netpoll *np)
>  {
> +	struct net *net = current->nsproxy->net_ns;
>  	struct net_device *ndev = NULL;
>  	bool ip_overwritten = false;
> +	char buf[MAC_ADDR_LEN + 1];
>  	struct in_device *in_dev;
>  	int err;
>  
>  	rtnl_lock();
> -	if (np->dev_name[0]) {
> -		struct net *net = current->nsproxy->net_ns;
> +	if (np->dev_name[0])
>  		ndev = __dev_get_by_name(net, np->dev_name);
> -	}
> +	else if (is_valid_ether_addr(np->dev_mac))
> +		ndev = dev_getbyhwaddr_rcu(net, ARPHRD_ETHER, np->dev_mac);

You do not have the RCU read lock here. You have the rtnl(), which is
sufficient, but, CONFIG_PROVE_RCU_LIST will show something as:

	WARNING: suspicious RCU usage
	6.13.0-09701-g6610c7be45bb-dirty #18 Not tainted
	-----------------------------
	net/core/dev.c:1143 RCU-list traversed in non-reader section!!
	other info that might help us debug this:
	rcu_scheduler_active = 2, debug_locks = 1
	1 lock held by swapper/0/1:
	 #0: ffffffff832795b8 (rtnl_mutex){+.+.}-{4:4}, at: netpoll_setup+0x48/0x540
	stack backtrace:
	CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-virtme-09701-g6610c7be45bb-dirty #18
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
	Call Trace:
	 <TASK>
	 dump_stack_lvl+0x9f/0xf0
	 lockdep_rcu_suspicious+0x11a/0x150
	 dev_getbyhwaddr_rcu+0xb6/0xc0
	 netpoll_setup+0x8a/0x540
	 ? netpoll_parse_options+0x2bd/0x310

This is not a problem per-se, since you have RTNL. We probably need to
tell for_each_netdev_rcu() to not comply about "RCU-list traversed in
non-reader section" if RTNL is held. Not sure why we didn't hit in the
test infrastructure, tho:

	https://patchwork.kernel.org/project/netdevbpf/patch/20250204-netconsole-v2-2-5ef5eb5f6056@purestorage.com/

Anyway, no action item for you here. I am talking to Jakub on a way to
solve it, and I should send a fix soon.

Thanks for the patch,
--breno

