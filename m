Return-Path: <linux-wireless+bounces-19425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00EA44348
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 15:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A8A175823
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BAC26B958;
	Tue, 25 Feb 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe/2Mwjk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A721ABDA;
	Tue, 25 Feb 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494440; cv=none; b=MwEtYThDVWwZSSdbSqK8EmqhLVWn/1zBrmxse3GF8SfPVLAJbImGgdjnlqFWpCbgyVayFYJJHmL+50Cy/jU2H0LgKSWalpStNt1z+m9rpvRTdkZdTJrg0rqpPUqNmbIawvYcUreeKMXO0Jbvs1lOeDx7x2e4ZOhfOHv+qN5MRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494440; c=relaxed/simple;
	bh=AYjrae84t0alupk1jpkw8gvE8OxPjRpVWE2iYxMspZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi6Y0P36D7IaCDPyrXNvayGHokjf+Cb0yoSS9V3hMfexeQV8kG0RDzy4UftbWtocJV2MF8vVel3LQbVWqGfXZ2+TY+9jfFFEO8ATfwcg+ot4N8jTvyUNzuxdXw+OncXK4d1vLo4rxkp3hFqi05eXrA0+wZfY/sI9qxAqFQHUHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe/2Mwjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BDBC4CEE8;
	Tue, 25 Feb 2025 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494440;
	bh=AYjrae84t0alupk1jpkw8gvE8OxPjRpVWE2iYxMspZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fe/2MwjkyiKWE+JXgg7zimg0A0OrZhiJmAVudNyrhW49GgfSE9smaTVNTUO0qmNiN
	 mkyfQ3XI7b8PLfd9P6u5w6Isu0TLH/u8OW1FpvZecdWtyBc/rQFQt4phDrwRe7r8Qw
	 h0G73DgEA2Tx//WnUASWE1AnDvdpk+m8mMIYmNbP+AfoOWhaUewOlnl/XlQiWpX+po
	 IN/WaPCOrHZIWdGFlq+wLT2dvP9dL7hGjHXfxLIs6W47nFoDf3GZVcJjrPViAmzWtc
	 LZmvz7H6CLKkLz9H8+I+H9aSgDhZKoqUAoRQxrd1/8fcUlPFV3p++A+583VT5v9fb0
	 FrlQsVNexWLJA==
Date: Tue, 25 Feb 2025 14:40:35 +0000
From: Simon Horman <horms@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <20250225144035.GY1615191@kernel.org>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>

On Thu, Feb 20, 2025 at 06:29:21PM -0700, Uday Shankar wrote:
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
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Tested-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


