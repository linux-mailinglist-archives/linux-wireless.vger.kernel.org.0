Return-Path: <linux-wireless+bounces-18650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC57A2D21D
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 01:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF51160FE7
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7E38FB0;
	Sat,  8 Feb 2025 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOpWvW0+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0035729D0E;
	Sat,  8 Feb 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974526; cv=none; b=JRPd4xyU5k3K0jyTo8nk3bNj28o9wd7pf9kFcdAVSMwisE7atrbParwQmDScVhkVzWXKzUKCEsduI+TwL/aY4/DvF1BaZvc/J/JQ3ysAg/ibpTO/zGU7O4dOF8Pf/hArJcSSpzYMhP3isPO64K5XCT1vJK8Q4Ex4yL/7ZGZ/Dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974526; c=relaxed/simple;
	bh=u6eQSkM7Cfs+opcao0mVLmHYFdxwwlZIySepbPrVVzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0nkCXGgBxWF2uE1pBxfxrp6n+bK+P1gxtWP7UDZepoe++ir05epx8MmXUZUR0UO5zze+GIB2DJ78mGmY95ZiCckGWjK9IjtQb+HLZp4pk9HBhkOs3om9TLO3p2PCnukraOw/KEXkMygunbhI4yEUdII13fjMITvFFL2sfFOz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOpWvW0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5F2C4CEE4;
	Sat,  8 Feb 2025 00:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738974525;
	bh=u6eQSkM7Cfs+opcao0mVLmHYFdxwwlZIySepbPrVVzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IOpWvW0+YdUJ3ap6jQntf+5RAp4ed5ewCfgDB6op9LLzT6FVKaWHlWOc4ZMgg/HRC
	 hbhP4gOwkSaiJslF3QGrcpqNyGCHtI6Tss8B8d4nwyD5t+3/7MLd16KxxlQS4uRY3f
	 pBckzRjCmZIjLYlVFYKBOanTd5bhEoqcPV/CaSGsRT3ICWBwlTcPtpVJa1HHoCawmF
	 VpTlThGRN4aJOSvIDlnckWMEtt23ZETAgvBt4UUZyGtvP8CHPyknolOXN6pjPYJyMi
	 SAP0dltglldLXNba1Lyvj4n5MsHEwzm8H+W62oZ5HV3CgsxFKea8Xb9roqOwdwnaLc
	 iXaFxcyoyyF7A==
Date: Fri, 7 Feb 2025 16:28:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] netconsole: allow selection of egress interface
 via MAC address
Message-ID: <20250207162844.43b20256@kernel.org>
In-Reply-To: <20250205-netconsole-v3-2-132a31f17199@purestorage.com>
References: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
	<20250205-netconsole-v3-2-132a31f17199@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Feb 2025 22:21:31 -0700 Uday Shankar wrote:
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

Sounds like dev_getbyhwaddr_rcu() will warn here. Either wrap it 
in  RCU temporarily or combine the series with Breno's patch to 
add a new helper?
-- 
pw-bot: cr

