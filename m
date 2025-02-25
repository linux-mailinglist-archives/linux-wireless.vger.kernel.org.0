Return-Path: <linux-wireless+bounces-19424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BAEA44353
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 15:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ABD3A9F56
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D321ABD6;
	Tue, 25 Feb 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR8aUf6G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58921ABCE;
	Tue, 25 Feb 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494426; cv=none; b=j+aNW5Dqet4UpzK0EtWtAFty91jtAl+8Z0h1OPUdpiTwL7wXwPs/xZUlbXLK7K1TodFGfaI/3afhPLhkbTWkPfTsyPzov43Jr+1flaQZ+LdzNOmLUG6DBLlFEwVMfZRyeY6chPIiierk7lYCBNu/U2Elee0okejLSlJPCXt9cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494426; c=relaxed/simple;
	bh=aE+KEHxtUqq/9yiwsA+fXGytdd/VP16zWK4EG1Unhck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMpXYMOhIJS/9Sq2lyAYrV7GXrbcGURSfEe402odeHMbgtMLH7YyqdFFDZZ7655fiUFi+S+Gfw61n5aG7eg9kJ9+NbGbM6zBlF8a/1doA6izkgHqKKv9NUN/3tVxNnyeOoDIxwUDRgMphqLN2lA508kV0NhwzAs46vglqnqBPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR8aUf6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE2C4CEDD;
	Tue, 25 Feb 2025 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494425;
	bh=aE+KEHxtUqq/9yiwsA+fXGytdd/VP16zWK4EG1Unhck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DR8aUf6GdPiWkRGYdYDOardMduO9u+VdLiUQvAHAsnLA/Df4p3ZVNCjxjYQ675YS1
	 rSujYDVsq51sL8urqsSIoYzjydbM2Uy092tV7hNjGG5HYHUXhZ6vBDytG0XmFEgRMk
	 kqWvDLBbqRC6CLu3TVyeEGgzAZ7Vx8P+syI4HxPJCKx2DuH/9OtJ32krR2hV8sOWSS
	 kKALmiwl5ETV5RLulAV8xnURKwS3e5g6I0OllCdsh8o9XnqbqmaA91YIhlRMicVMpI
	 78kQ/Q99B6+nxfWLBO1LEjEQq21vVzg21PTx/SAUzRa4g7CfPUvaujpjbqjMfYE6Co
	 3nhfoLbcZvs9w==
Date: Tue, 25 Feb 2025 14:40:20 +0000
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
	linux-doc@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net-next v5 1/2] net, treewide: define and use
 MAC_ADDR_STR_LEN
Message-ID: <20250225144020.GX1615191@kernel.org>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-1-4aeafa71debf@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-netconsole-v5-1-4aeafa71debf@purestorage.com>

On Thu, Feb 20, 2025 at 06:29:20PM -0700, Uday Shankar wrote:
> There are a few places in the tree which compute the length of the
> string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
> constant for this and use it where relevant. No functionality changes
> are expected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Reviewed-by: Simon Horman <horms@verge.net.au>


