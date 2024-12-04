Return-Path: <linux-wireless+bounces-15872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ADF9E310D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 03:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B260B27B9C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F427715;
	Wed,  4 Dec 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFfXOAoY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89FEADA;
	Wed,  4 Dec 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277610; cv=none; b=uuzEKDaaR469j2eJxqdhdm4Qqw7qIUMC37IHYMOcgdUjdvHu3f6iC/v0b+z0qAKcBvWcMKdDI62HjTu1wTA4NVK7idBIkhj5TtYBgifHiExmbwSsmRdZq/xAJXzMPNGKcuoPhTlGh15H+2SEqUX12v4JDaAi+DPTzomV+VMtzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277610; c=relaxed/simple;
	bh=B4mGpkGP2zk+59NfcmDiRdWFa9fvTYj7eba+xhtof4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLMbQ1NHvLiSjy7eRoxuDA72WpyXHsPZY74mpSG9p5mWJ6TBi6DMOfxDGa+Z/hCCQTdSVv1cNGpcxjEZFnMB0JnbPIOcE0PAy1oCrOG5So0ibsg7rI5pXtr+RkpJ3Le9ViR/HCWaO7oi737FcGGP2T9JJm3jYT0ZkBc/AV5VYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFfXOAoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB2FC4CEDC;
	Wed,  4 Dec 2024 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733277610;
	bh=B4mGpkGP2zk+59NfcmDiRdWFa9fvTYj7eba+xhtof4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFfXOAoYFkIysqoiJSwFZN2Vlmt3EOsfgvNwEGDWKMTL8u1RcSMoj2h+XXOUk1M4Q
	 KvbCSu6CMc5eH1DQ8u6XW/+ehUTM/u5xQ/j+JdyUmqYi0+tT2glaMtrM7bV1xJqXOS
	 YCjpP8SGmqXDPtb+n5cpsrIcAXhxK87w/nyUsmVeFrNYzqvIQGozpmX0ZIqAnKYCNN
	 cR9btXFXDjV6arADDnw4MEIuLJm9GsMLyDfSbuRGF6eCJW8iWFKBCPxd6WzZ4CYoB9
	 IQS2Td1zO9O7INRpDvTLFnWH1IPwIUnXiHRczMVMxO5vpbGmjTutAFoB5QkE4gXEYn
	 rVfnU451qGZqg==
Date: Tue, 3 Dec 2024 18:00:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/7] tools/net/ynl: support decoding indexed
 arrays as enums
Message-ID: <20241203180008.64720493@kernel.org>
In-Reply-To: <20241203130655.45293-3-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	<20241203130655.45293-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:06:50 +0000 Donald Hunter wrote:
> When decoding an indexed-array with a scalar subtype, it is currently
> only possible to add a display-hint. Add support for decoding each value
> as an enum.

Makes me wonder if we should factor this code out into a helper.
But there aren't too many sites with this code so fine either way:

Acked-by: Jakub Kicinski <kuba@kernel.org>

